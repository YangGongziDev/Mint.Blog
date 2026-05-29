import type { AxiosError } from 'axios';
import { $t } from '@/locales';

interface ApiErrorBody {
  success?: boolean;
  errorCode?: string | null;
  message?: string | null;
  ErrorCode?: string | null;
  Message?: string | null;
}

const ERROR_CODE_I18N_MAP: Partial<Record<string, App.I18n.I18nKey>> = {
  login_invalid: 'page.login.common.invalidCredentials',
  user_not_found: 'page.login.common.invalidCredentials',
  user_password_invalid: 'page.login.common.invalidCredentials',
  unauthorized: 'page.login.common.sessionExpired',
  token_expired: 'page.login.common.sessionExpired',
  refresh_token_invalid: 'page.login.common.sessionExpired',
  forbidden: 'common.noPermission'
};

const ERROR_CODE_MESSAGE_MAP: Partial<Record<string, string>> = {
  tag_not_found: '所选标签不存在或已被删除，请重新选择标签',
  category_not_found: '所选分类不存在或已被删除，请重新选择分类',
  article_not_found: '文章不存在或已被删除',
  article_draft_not_found: '草稿不存在或已被删除',
  file_upload_invalid: '文件上传失败，请检查文件或对象存储配置',
  file_not_found: '文件不存在或已被删除'
};

function getApiErrorPayload(error: unknown): ApiErrorBody | null {
  if (typeof error === 'string') {
    return { message: error };
  }

  if (error && typeof error === 'object' && 'response' in error) {
    const axiosError = error as AxiosError<ApiErrorBody>;
    return axiosError.response?.data ?? null;
  }

  if (error && typeof error === 'object' && ('errorCode' in error || 'message' in error || 'ErrorCode' in error || 'success' in error)) {
    return error as ApiErrorBody;
  }

  return null;
}

function getErrorCode(payload: ApiErrorBody | null) {
  return (payload?.errorCode || payload?.ErrorCode || '').trim();
}

function getRawMessage(payload: ApiErrorBody | null) {
  return (payload?.message || payload?.Message || '').trim();
}

/** 将接口错误转为用户可读文案（优先 i18n 映射，其次后端 message） */
export function resolveServiceErrorMessage(error: unknown, fallbackKey: App.I18n.I18nKey = 'common.error') {
  const payload = getApiErrorPayload(error);
  const errorCode = getErrorCode(payload);
  const mappedKey = ERROR_CODE_I18N_MAP[errorCode];
  const mappedMessage = ERROR_CODE_MESSAGE_MAP[errorCode];

  if (mappedMessage) {
    return mappedMessage;
  }

  if (mappedKey) {
    return $t(mappedKey);
  }

  const rawMessage = getRawMessage(payload);
  if (errorCode === 'internal_server_error' || rawMessage.toLowerCase() === 'internal server error') {
    return $t('page.login.common.serverError');
  }

  if (rawMessage) {
    return rawMessage;
  }

  if (error && typeof error === 'object' && 'response' in error) {
    const axiosError = error as AxiosError;
    const status = axiosError.response?.status;

    if (status === 403) {
      return $t('common.noPermission');
    }
    if (status === 404) {
      return $t('page.login.common.apiNotFound');
    }
    if (status === 502 || status === 503) {
      return $t('page.login.common.serviceUnavailable');
    }
    if (status === 504) {
      return $t('page.login.common.gatewayTimeout');
    }
    if (status === 500) {
      return $t('page.login.common.serverError');
    }

    if (!axiosError.response) {
      if (axiosError.code === 'ECONNABORTED') {
        return $t('page.login.common.requestTimeout');
      }
      return $t('page.login.common.networkError');
    }
  }

  return $t(fallbackKey);
}

export function isLoginRequestUrl(url?: string) {
  return Boolean(url?.includes('/system/auth/login'));
}
