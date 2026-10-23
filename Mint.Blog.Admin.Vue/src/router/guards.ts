import type { LocationQueryRaw, RouteLocationNormalized, RouteLocationRaw, Router } from 'vue-router';
import { useTitle } from '@vueuse/core';
import { useAuthStore } from '@/store/system/auth';
import { useRouteStore } from '@/store/system/route';
import { useThemeStore } from '@/store/system/theme';
import { localStg } from '@/utils/storage';
import { $t } from '@/locales';
import type { RouteKey } from '@/router/types';

export function setupRouterGuards(router: Router) {
  createProgressGuard(router);
  createRouteGuard(router);
  createDocumentTitleGuard(router);
}

export const createRouterGuard = setupRouterGuards;

function createProgressGuard(router: Router) {
  router.beforeEach(() => {
    window.NProgress?.start?.();
  });

  router.afterEach(() => {
    window.NProgress?.done?.();
  });
}

function createDocumentTitleGuard(router: Router) {
  router.afterEach(to => {
    const { i18nKey, title } = to.meta;
    const routeTitle = i18nKey ? $t(i18nKey) : title;
    const appTitle = import.meta.env.VITE_APP_TITLE;
    const documentTitle = routeTitle ? `${appTitle}-${routeTitle}` : appTitle;

    useTitle(documentTitle);
  });
}

function createRouteGuard(router: Router) {
  router.beforeEach(async (to, from) => {
    const themeStore = useThemeStore();
    themeStore.applyThemeLayoutByRoute(to);

    const location = await initRoute(to);

    if (location) {
      return location;
    }

    const authStore = useAuthStore();
    const rootRoute: RouteKey = 'root';
    const loginRoute: RouteKey = 'login';
    const noAuthorizationRoute: RouteKey = '403';
    const isLogin = Boolean(localStg.get('token'));
    const needLogin = Boolean(to.meta.public) && to.name !== loginRoute;
    const routeRoles = to.meta.roles || [];
    const hasRole = authStore.userInfo.roles.some(role => routeRoles.includes(role));
    const hasAuth = !routeRoles.length || hasRole;

    if (to.name === loginRoute && isLogin) {
      return { name: rootRoute };
    }

    if (needLogin && !isLogin) {
      return { name: loginRoute, query: { redirect: to.fullPath } };
    }

    if (!needLogin) {
      return handleRouteSwitch(to, from);
    }

    if (!hasAuth) {
      return { name: noAuthorizationRoute };
    }

    return handleRouteSwitch(to, from);
  });
}

async function initRoute(to: RouteLocationNormalized): Promise<RouteLocationRaw | null> {
  const routeStore = useRouteStore();
  const notFoundRoute: RouteKey = 'not-found';
  const isNotFoundRoute = to.name === notFoundRoute;

  if (!routeStore.isRouteReady) {
    await routeStore.initAuthRoute(to.path);

    return {
      path: to.fullPath,
      replace: true,
      query: to.query,
      hash: to.hash
    };
  }

  const isLogin = Boolean(localStg.get('token'));

  if (!isLogin) {
    if ((!to.meta.public || to.name === 'login') && !isNotFoundRoute) {
      routeStore.onRouteSwitchWhenNotLoggedIn(to.path);
      return null;
    }

    return {
      name: 'login',
      query: getRouteQueryOfLoginRoute(to)
    };
  }

  routeStore.onRouteSwitchWhenLoggedIn(to.path);

  if (!isNotFoundRoute) {
    return null;
  }

  const exist = await routeStore.getIsAuthRouteExist(to.path as string);

  if (exist) {
    return { name: '403' };
  }

  return null;
}

function handleRouteSwitch(to: RouteLocationNormalized, from: RouteLocationNormalized) {
  if (to.meta.href) {
    window.open(to.meta.href, '_blank');

    return { path: from.fullPath, replace: true, query: from.query, hash: to.hash };
  }

  return true;
}

function getRouteQueryOfLoginRoute(to: RouteLocationNormalized) {
  const loginRoute: RouteKey = 'login';
  const redirect = to.fullPath;
  const [redirectPath, redirectQuery] = redirect.split('?');
  const isRedirectHome =
    redirectPath === '/' ||
    redirectPath === '/blog' ||
    redirectPath === '/blog/admin' ||
    redirectPath === '/blog/surfer';
  const query: LocationQueryRaw = to.name !== loginRoute && !isRedirectHome ? { redirect } : {};

  if (isRedirectHome && redirectQuery) {
    query.redirect = `/?${redirectQuery}`;
  }

  return query;
}
