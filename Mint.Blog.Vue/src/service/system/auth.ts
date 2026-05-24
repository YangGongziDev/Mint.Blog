import { safeRequest } from '../axios';

/**
 * Login
 *
 * @param userName User name
 * @param password Password
 */
export function fetchLogin(userName: string, password: string) {
  return safeRequest<Api.Auth.LoginToken>({
    url: '/system/auth/login',
    method: 'post',
    data: {
      userName,
      password
    }
  });
}

/** Refresh login token */
export function fetchRefreshToken(refreshToken: string) {
  return safeRequest<Api.Auth.LoginToken>({
    url: '/system/auth/refresh',
    method: 'post',
    data: {
      refreshToken
    }
  });
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
export function fetchGetUserInfo() {
  return safeRequest<Api.Auth.UserInfo>({ url: '/system/user/me' });
}
