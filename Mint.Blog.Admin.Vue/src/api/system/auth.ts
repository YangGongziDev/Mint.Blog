import { safeRequest } from '../axios';

type LoginResponse = Omit<Api.Auth.LoginToken, 'accessToken'> & { token: string };

type AdminUserResponse = {
  id: string;
  username: string;
  realName: string;
  roles: { code: string }[];
  permissions: { code: string }[];
};

function toLoginToken(data: LoginResponse): Api.Auth.LoginToken {
  const { token, ...rest } = data;
  return { ...rest, accessToken: token };
}

/**
 * Login
 *
 * @param userName User name
 * @param password Password
 */
export async function fetchLogin(userName: string, password: string) {
  const { data, error } = await safeRequest<LoginResponse>({
    url: '/system/auth/login',
    method: 'post',
    data: {
      userName,
      password
    }
  });
  return { data: data ? toLoginToken(data) : null, error };
}

/** Refresh login token */
export async function fetchRefreshToken(refreshToken: string) {
  const { data, error } = await safeRequest<LoginResponse>({
    url: '/system/auth/refresh',
    method: 'post',
    data: {
      refreshToken
    }
  });
  return { data: data ? toLoginToken(data) : null, error };
}

/** Logout */
export function fetchLogout(refreshToken: string) {
  return safeRequest({
    url: '/system/auth/logout',
    method: 'post',
    data: {
      refreshToken
    }
  });
}

/** Get user info */
export async function fetchGetUserInfo() {
  const { data, error } = await safeRequest<AdminUserResponse>({ url: '/system/auth/info' });
  const info: Api.Auth.UserInfo | null = data
    ? {
        userId: data.id,
        userName: data.username,
        displayName: data.realName,
        roles: data.roles.map(role => role.code),
        buttons: data.permissions.map(permission => permission.code)
      }
    : null;
  return { data: info, error };
}
