import { localStg } from '@/utils/storage';

/** Get token */
export function getToken() {
  return localStg.get('token') || '';
}

/** Get refresh token */
export function getRefreshToken() {
  return localStg.get('refreshToken') || '';
}

/** Set auth tokens */
export function setAuthTokens(loginToken: Api.Auth.LoginToken) {
  localStg.set('token', loginToken.accessToken);
  localStg.set('refreshToken', loginToken.refreshToken);
}

/** Clear auth storage */
export function clearAuthStorage() {
  localStg.remove('token');
  localStg.remove('refreshToken');
}
