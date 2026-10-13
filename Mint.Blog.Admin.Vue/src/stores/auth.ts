import type { User, Role, Permission } from '@/types/auth';

import { defineStore } from 'pinia';
import { ref, computed } from 'vue';

import avatarImg from '@/assets/images/avatar.jpg';
import { ALL_PERMISSION } from '@/constants/permissions';

const TOKEN_KEY = 'access_token';
const REFRESH_TOKEN_KEY = 'refresh_token';
const USER_KEY = 'user_info';
const TOKEN_EXPIRES_KEY = 'token_expires_at';
const USER_DATA_VERSION_KEY = 'user_data_version';

/**
 * Increment this version when the user data schema changes
 * (e.g. avatar format migration). Stale cached data from older
 * versions will be discarded so the next login / getUserInfo
 * call repopulates it with the current format.
 */
const CURRENT_USER_DATA_VERSION = 1;

const LEGACY_ASSET_AVATAR_PATTERN = /^\/assets\/avatar-[\w-]+\.png$/;

/**
 * Additional legacy patterns that should be migrated to DiceBear.
 * Covers common faker.image.avatar() output formats and old
 * asset paths that may be cached in localStorage.
 */
const LEGACY_AVATAR_PATTERNS = [
  // Old static asset paths
  /^\/assets\/images\/avatar\.png$/,
  /^\/assets\/avatar\.(png|jpg|jpeg|webp)$/,
  // faker.image.avatar() legacy formats (picsum, loremflickr, etc.)
  /^https?:\/\/picsum\.photos\/.*/,
  /^https?:\/\/loremflickr\.com\/.*/,
  // GitHub avatars (faker avatarGitHub)
  /^https?:\/\/avatars\.githubusercontent\.com\/u\/\d+.*/,
  // cloudflare-ipfs (old faker image provider)
  /^https?:\/\/cloudflare-ipfs\.com\/.*/,
];

const DEFAULT_TOKEN_EXPIRY_MS = 24 * 60 * 60 * 1000;

function decodeJwtPayload(token: string): Record<string, unknown> | null {
  try {
    const base64Url = token.split('.')[1];
    if (!base64Url) return null;
    const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    const jsonPayload = decodeURIComponent(
      atob(base64)
        .split('')
        .map((c) => '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2))
        .join(''),
    );
    return JSON.parse(jsonPayload);
  } catch {
    return null;
  }
}

function isLegacyAvatar(avatar: string): boolean {
  if (LEGACY_ASSET_AVATAR_PATTERN.test(avatar)) {
    return true;
  }
  return LEGACY_AVATAR_PATTERNS.some((pattern) => pattern.test(avatar));
}

function normalizeUserInfo(userInfo: User): User {
  if (!isLegacyAvatar(userInfo.avatar)) {
    return userInfo;
  }

  return {
    ...userInfo,
    avatar: avatarImg,
  };
}

export const useAuthStore = defineStore('auth', () => {

  const token = ref<string | null>(localStorage.getItem(TOKEN_KEY));
  const refreshTokenValue = ref<string | null>(localStorage.getItem(REFRESH_TOKEN_KEY));
  const tokenExpiresAt = ref<number | null>(null);
  const user = ref<User | null>(null);
  const roles = ref<Role[]>([]);
  const permissions = ref<Permission[]>([]);

  const savedExpires = localStorage.getItem(TOKEN_EXPIRES_KEY);
  if (savedExpires) {
    tokenExpiresAt.value = parseInt(savedExpires, 10);
  }

  const isTokenExpired = computed(() => {
    if (!token.value) return true;
    if (!tokenExpiresAt.value) return false;
    return Date.now() >= tokenExpiresAt.value;
  });

  const isLoggedIn = computed(() => !!token.value && !!user.value && !isTokenExpired.value);
  const userRoles = computed(() => roles.value.map((role) => role.code));
  const userPermissions = computed(() => permissions.value.map((perm) => perm.code));

  const setToken = (
    newToken: string | null,
    newRefreshToken?: string | null,
    expiresIn?: number,
  ) => {
    token.value = newToken;
    if (newToken) {
      localStorage.setItem(TOKEN_KEY, newToken);

      let expiresAt: number;
      if (expiresIn !== undefined && expiresIn > 0) {
        expiresAt = Date.now() + expiresIn * 1000;
      } else {
        const payload = decodeJwtPayload(newToken);
        if (payload?.exp && typeof payload.exp === 'number') {
          expiresAt = payload.exp * 1000;
        } else {
          expiresAt = Date.now() + DEFAULT_TOKEN_EXPIRY_MS;
        }
      }
      tokenExpiresAt.value = expiresAt;
      localStorage.setItem(TOKEN_EXPIRES_KEY, expiresAt.toString());
    } else {
      localStorage.removeItem(TOKEN_KEY);
      tokenExpiresAt.value = null;
      localStorage.removeItem(TOKEN_EXPIRES_KEY);
    }

    if (newRefreshToken !== undefined) {
      refreshTokenValue.value = newRefreshToken;
      if (newRefreshToken) {
        localStorage.setItem(REFRESH_TOKEN_KEY, newRefreshToken);
      } else {
        localStorage.removeItem(REFRESH_TOKEN_KEY);
      }
    }
  };

  const setUserInfo = (userInfo: User | null) => {
    const normalizedUserInfo = userInfo ? normalizeUserInfo(userInfo) : null;
    user.value = normalizedUserInfo;
    if (normalizedUserInfo) {
      roles.value = normalizedUserInfo.roles || [];
      permissions.value = normalizedUserInfo.permissions || [];
      localStorage.setItem(USER_KEY, JSON.stringify(normalizedUserInfo));
      localStorage.setItem(USER_DATA_VERSION_KEY, String(CURRENT_USER_DATA_VERSION));
    } else {
      roles.value = [];
      permissions.value = [];
      localStorage.removeItem(USER_KEY);
      localStorage.removeItem(USER_DATA_VERSION_KEY);
    }
  };

  const login = async (username: string, password: string): Promise<void> => {
    const { login: loginApi } = await import('@/api/auth');

    if (token.value || user.value) {
      // 清除旧的token和用户信息
      logout();
    }

    const loginResult = await loginApi({ username, password });
    setToken(loginResult.data.token, loginResult.data.refreshToken, loginResult.data.expiresIn);

    await syncIdentity(false);
  };

  const logout = () => {
    const refreshToken = refreshTokenValue.value;
    setToken(null, null);
    setUserInfo(null);
    if (refreshToken) {
      void import('@/api/auth').then(({ logout: logoutApi }) => logoutApi(refreshToken)).catch(() => {
        console.warn('服务端会话吊销失败，本地登录信息已清除。');
      });
    }
  };

  const refreshToken = async (): Promise<string> => {
    const { refreshToken: refreshTokenApi } = await import('@/api/auth');

    if (!refreshTokenValue.value) {
      throw new Error('No refresh token available');
    }

    const result = await refreshTokenApi(refreshTokenValue.value);
    setToken(result.data.token, result.data.refreshToken, result.data.expiresIn);
    await syncIdentity(true, true);
    return result.data.token;
  };

  const hasRole = (role: string): boolean => {
    return userRoles.value.includes(role);
  };

  const hasAnyRole = (roleList: string[]): boolean => {
    return roleList.some((role) => hasRole(role));
  };

  const hasAllRoles = (roleList: string[]): boolean => {
    return roleList.every((role) => hasRole(role));
  };

  const hasPermission = (permission: string): boolean => {
    return (
      userPermissions.value.includes(ALL_PERMISSION) || userPermissions.value.includes(permission)
    );
  };

  const hasAnyPermission = (permissionList: string[]): boolean => {
    return permissionList.some((perm) => hasPermission(perm));
  };

  const hasAllPermissions = (permissionList: string[]): boolean => {
    return permissionList.every((perm) => hasPermission(perm));
  };

  const syncIdentity = async (rebuildRoutes = true, skipAuthRefresh = false) => {
    try {
      const { getUserInfo } = await import('@/api/auth');
      const response = await getUserInfo(skipAuthRefresh);
      setUserInfo(response.data);
      if (rebuildRoutes) {
        const { default: router, rebuildDynamicRoutes } = await import('@/router');
        await rebuildDynamicRoutes(router);
        const current = router.currentRoute.value;
        if (current.meta.requiresAuth !== false && current.name) {
          const required = current.meta.requiredPermissions as string[] | undefined;
          const requiredRoles = current.meta.requiredRoles as string[] | undefined;
          const denied = !router.hasRoute(current.name)
            || (required?.length && !hasAnyPermission(required))
            || (requiredRoles?.length && !hasAnyRole(requiredRoles));
          void router.replace(denied ? '/403' : current.fullPath);
        }
      }
    } catch (error) {
      const { clearSessionState } = await import('@/utils/session');
      const { default: router } = await import('@/router');
      clearSessionState(router);
      void router.replace('/login');
      throw error;
    }
  };

  let initPromise: Promise<void> | null = null;
  const initAuth = (): Promise<void> => {
    if (!token.value || user.value) return Promise.resolve();
    if (!initPromise) {
      initPromise = syncIdentity(false).finally(() => { initPromise = null; });
    }
    return initPromise;
  };

  return {
    token,
    refreshTokenValue,
    tokenExpiresAt,
    user,
    roles,
    permissions,
    isTokenExpired,
    isLoggedIn,
    userRoles,
    userPermissions,
    setToken,
    setUserInfo,
    login,
    logout,
    refreshToken,
    hasRole,
    hasAnyRole,
    hasAllRoles,
    hasPermission,
    hasAnyPermission,
    hasAllPermissions,
    initAuth,
    syncIdentity,
  };
});
