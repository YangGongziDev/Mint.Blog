import axios from 'axios';
import type { AxiosError, AxiosRequestConfig, InternalAxiosRequestConfig } from 'axios';
import { useAuthStore } from '@/store/system/auth';
import { useRouterPush } from '@/hooks/routing/use-router-push';
import { fetchRefreshToken } from '@/service/system/auth';
import { isLoginRequestUrl, resolveServiceErrorMessage } from '@/utils/service-error';
import { localStg } from '@/utils/storage';

const ACCESS_TOKEN_HEADER = 'x-access-token';
const UNAUTHORIZED_CODES = ['unauthorized', 'token_expired'];
const REFRESH_TOKEN_INVALID_CODE = 'refresh_token_invalid';
const REFRESH_REQUEST_URL = '/system/auth/refresh';

type RetryableAxiosRequestConfig = InternalAxiosRequestConfig & {
  _retry?: boolean;
};

function getAuthorization() {
  const token = localStg.get('token');
  return token ? `Bearer ${token}` : null;
}

function getRefreshTokenValue() {
  return localStg.get('refreshToken') || '';
}

function syncAuthTokens(loginToken: Api.Auth.LoginToken) {
  localStg.set('token', loginToken.accessToken);
  localStg.set('refreshToken', loginToken.refreshToken);
}

function syncAccessToken(auth?: string | null) {
  if (auth) localStg.set('token', auth);
}

function getRenewedAccessToken(headers?: Record<string, unknown> | null) {
  if (!headers) return '';
  const token = headers[ACCESS_TOKEN_HEADER];
  return typeof token === 'string' ? token : '';
}

const errMsgStack: string[] = [];
const VISITOR_READONLY_MESSAGE = '当前为访客账号，仅支持查看，不能新增、编辑、删除或排序。';
let refreshTokenPromise: Promise<Api.Auth.LoginToken | null> | null = null;

function isReadonlyVisitor() {
  const roles = useAuthStore().userInfo.roles;
  return roles.includes('ROLE_VISITOR') && !roles.some(role => role === 'ROLE_ADMIN' || role === 'ROLE_SUPER');
}

function isForbiddenError(errorCode?: string, status?: number) {
  return errorCode === 'forbidden' || status === 403;
}

function resolveForbiddenMessage(errorCode?: string, status?: number) {
  if (isForbiddenError(errorCode, status) && isReadonlyVisitor()) {
    return VISITOR_READONLY_MESSAGE;
  }

  return '';
}

function showRequestMsg(message: string, type: 'error' | 'warning' = 'error') {
  if (errMsgStack.includes(message)) return;
  errMsgStack.push(message);
  window.$message?.[type](message, 2, () => {
    const idx = errMsgStack.indexOf(message);
    if (idx > -1) errMsgStack.splice(idx, 1);
  });
}

/** 将网关/网络类错误转为可读文案，避免直接展示 Axios 英文提示 */
function getFriendlyAxiosErrorMessage(error: AxiosError<App.Service.Response>) {
  return resolveServiceErrorMessage(error, 'common.error');
}

async function handleLogout() {
  const authStore = useAuthStore();
  const { toLogin } = useRouterPush(false);
  await authStore.logout(false);
  await toLogin(undefined);
}

async function refreshAccessToken() {
  if (refreshTokenPromise) {
    return refreshTokenPromise;
  }

  const refreshToken = getRefreshTokenValue();
  if (!refreshToken) {
    return null;
  }

  refreshTokenPromise = (async () => {
    const { data, error } = await fetchRefreshToken(refreshToken);
    if (error || !data) {
      return null;
    }

    syncAuthTokens(data);
    return data;
  })();

  try {
    return await refreshTokenPromise;
  } finally {
    refreshTokenPromise = null;
  }
}

export function getServiceBaseURL(env: Env.ViteEnv) {
  if (import.meta.env.DEV) return '/api';
  return env.VITE_SERVICE_BASE_URL;
}

const axiosInstance = axios.create({
  baseURL: getServiceBaseURL(import.meta.env),
  headers: {
    apifoxToken: 'XL299LiMEDZ0H5h3A29PxwQXdMJqWyY2'
  },
  timeout: 30000
});

axiosInstance.interceptors.request.use(config => {
  const auth = getAuthorization();
  if (auth) Object.assign(config.headers, { Authorization: auth });
  if (config.data instanceof FormData) delete config.headers['Content-Type'];
  return config;
});

axiosInstance.interceptors.response.use(
  response => {
    const renewedToken = getRenewedAccessToken(response.headers as Record<string, unknown>);
    if (renewedToken) syncAccessToken(renewedToken);

    const body = response.data as App.Service.Response;

    if (body && typeof body === 'object' && body.success === false) {
      const errorCode = body.errorCode || '';

      if (UNAUTHORIZED_CODES.includes(errorCode) || errorCode === REFRESH_TOKEN_INVALID_CODE) {
        return Promise.reject({
          config: response.config,
          response: { data: body }
        });
      }

      const requestUrl = response.config?.url;
      if (!isLoginRequestUrl(requestUrl)) {
        const forbiddenMessage = resolveForbiddenMessage(errorCode);
        if (forbiddenMessage) {
          showRequestMsg(forbiddenMessage, 'warning');
        } else {
          showRequestMsg(resolveServiceErrorMessage(body, 'common.error'));
        }
      }
      return Promise.reject(body);
    }

    return response.data;
  },
  async (error: AxiosError<App.Service.Response>) => {
    const originalRequest = error.config as RetryableAxiosRequestConfig | undefined;
    const errorCode = error.response?.data?.errorCode || '';
    const isRefreshRequest = originalRequest?.url?.includes(REFRESH_REQUEST_URL);
    const canRetry = Boolean(originalRequest) && !originalRequest?._retry && !isRefreshRequest;

    if (UNAUTHORIZED_CODES.includes(errorCode) && canRetry) {
      originalRequest!._retry = true;

      const refreshedToken = await refreshAccessToken();
      if (refreshedToken) {
        originalRequest!.headers = originalRequest!.headers || {};
        originalRequest!.headers.Authorization = `Bearer ${refreshedToken.accessToken}`;
        return axiosInstance.request(originalRequest!);
      }

      await handleLogout();
      return Promise.reject(error);
    }

    if ((UNAUTHORIZED_CODES.includes(errorCode) && isRefreshRequest) || errorCode === REFRESH_TOKEN_INVALID_CODE) {
      await handleLogout();
      return Promise.reject(error);
    }

    const requestUrl = originalRequest?.url;
    if (!isLoginRequestUrl(requestUrl)) {
      const forbiddenMessage = resolveForbiddenMessage(errorCode, error.response?.status);
      if (forbiddenMessage) {
        showRequestMsg(forbiddenMessage, 'warning');
      } else {
        showRequestMsg(getFriendlyAxiosErrorMessage(error));
      }
    }
    return Promise.reject(error);
  }
);

export async function safeRequest<T = any>(config: AxiosRequestConfig) {
  try {
    const result: App.Service.Response = await axiosInstance.request(config);
    return { data: (result.data || null) as T, error: null };
  } catch (err) {
    return { data: null, error: err };
  }
}

export default axiosInstance;
