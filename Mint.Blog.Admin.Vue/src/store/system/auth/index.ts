import { computed, reactive, ref } from 'vue';
import { defineStore } from 'pinia';
import { router } from '@/router';
import { fetchGetUserInfo, fetchLogin, fetchLogout } from '@/service/system/auth';
import { useRouterPush } from '@/hooks/routing/use-router-push';
import useLoading from '@/hooks/state/use-loading';
import { SetupStoreId } from '@/enum';
import { $t } from '@/locales';
import { useRouteStore } from '@/store/system/route';
import { useTabStore } from '@/store/system/tab';
import { resolveServiceErrorMessage } from '@/utils/service-error';
import { clearAuthStorage, getRefreshToken, getToken, setAuthTokens } from './shared';

export interface LoginResult {
  success: boolean;
}

export const useAuthStore = defineStore(SetupStoreId.Auth, () => {
  const routeStore = useRouteStore();
  const tabStore = useTabStore();
  const { toLogin, redirectFromLogin } = useRouterPush(false);
  const { loading: loginLoading, startLoading, endLoading } = useLoading();

  const token = ref(getToken());

  const userInfo: Api.Auth.UserInfo = reactive({
    userId: '',
    userName: '',
    displayName: '',
    roles: [],
    buttons: []
  });

  const isLogin = computed(() => Boolean(token.value));

  async function resetStore() {
    const authStore = useAuthStore();

    clearAuthStorage();
    authStore.$reset();

    if (!routeStore.isRouteReady) {
      await toLogin();
      return;
    }

    const currentRoute = router.currentRoute.value;

    if (currentRoute.meta.public) {
      await toLogin();
    }

    tabStore.cacheTabs();
    await routeStore.resetStore();
  }

  async function logout(redirectToLogin = true) {
    const refreshToken = getRefreshToken();
    if (refreshToken) {
      await fetchLogout(refreshToken);
    }

    await resetStore();

    if (redirectToLogin) {
      await toLogin();
    }
  }

  function getLoginRedirectPath(redirect = true) {
    if (!redirect) {
      return '/blog/admin/home';
    }

    const redirectPath = router.currentRoute.value.query?.redirect;

    if (typeof redirectPath === 'string' && redirectPath && !redirectPath.startsWith('/blog/surfer')) {
      return redirectPath;
    }

    return '/blog/admin/home';
  }

  function showLoginErrorNotification(description: string) {
    window.$notification?.error({
      message: $t('page.login.common.loginFailed'),
      description
    });
  }

  async function login(userName: string, password: string, redirect = true): Promise<LoginResult> {
    startLoading();

    try {
      const { data: loginToken, error } = await fetchLogin(userName, password);

      if (!error && loginToken) {
        const pass = await loginByToken(loginToken, getLoginRedirectPath(redirect));

        if (pass) {
          await redirectFromLogin(redirect);

          window.$notification?.success({
            message: $t('page.login.common.loginSuccess'),
            description: $t('page.login.common.welcomeBack', { userName: userInfo.displayName })
          });
          return { success: true };
        }

        await resetStore();
        showLoginErrorNotification($t('page.login.common.serverError'));
        return { success: false };
      }

      showLoginErrorNotification(
        resolveServiceErrorMessage(error, 'page.login.common.invalidCredentials')
      );
      return { success: false };
    } finally {
      endLoading();
    }
  }

  async function loginByToken(loginToken: Api.Auth.LoginToken, routePath?: string) {
    setAuthTokens(loginToken);

    const pass = await getUserInfo();

    if (pass) {
      token.value = loginToken.accessToken;
      await routeStore.resetStore(routePath);
      return true;
    }

    return false;
  }

  async function getUserInfo() {
    const { data: info, error } = await fetchGetUserInfo();

    if (!error && info) {
      Object.assign(userInfo, info);
      return true;
    }

    return false;
  }

  async function initUserInfo() {
    if (userInfo.userId) {
      return;
    }

    const hasToken = getToken();

    if (hasToken) {
      token.value = hasToken;

      const pass = await getUserInfo();

      if (!pass) {
        resetStore();
      }
    }
  }

  return {
    token,
    userInfo,
    isLogin,
    loginLoading,
    resetStore,
    logout,
    login,
    loginByToken,
    initUserInfo
  };
});
