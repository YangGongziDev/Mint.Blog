import { useRouter } from 'vue-router';
import type { RouteLocationRaw } from 'vue-router';
import type { RouteKey } from '@/router/types';
import { router as globalRouter } from '@/router';
import { useRouteStore } from '@/store/system/route';

/**
 * Router push
 *
 * Jump to the specified route, it can replace function router.push
 *
 * @param inSetup Whether is in vue script setup
 */
export function useRouterPush(inSetup = true) {
  const router = inSetup ? useRouter() : globalRouter;
  const route = globalRouter.currentRoute;
  const routeStore = useRouteStore();

  const routerPush = router.push;

  const routerBack = router.back;

  interface RouterPushOptions {
    query?: Record<string, string>;
    params?: Record<string, string>;
  }

  async function routerPushByKey(key: RouteKey, options?: RouterPushOptions) {
    const { query, params } = options || {};

    const routeLocation: RouteLocationRaw = {
      name: key
    };

    if (Object.keys(query || {}).length) {
      routeLocation.query = query;
    }

    if (Object.keys(params || {}).length) {
      routeLocation.params = params;
    }

    return routerPush(routeLocation);
  }

  function routerPushByKeyWithMetaQuery(key: RouteKey) {
    const allRoutes = router.getRoutes();
    const meta = allRoutes.find((item: { name?: unknown; meta?: Record<string, unknown> | null }) => item.name === key)?.meta || null;

    const query: Record<string, string> = {};

    meta?.query?.forEach((item: { key: string; value: string }) => {
      query[item.key] = item.value;
    });

    return routerPushByKey(key, { query });
  }

  function openExternal(url: string) {
    window.open(url, '_blank', 'noopener,noreferrer');
  }

  function routerPushByMenu(menu: App.Global.Menu) {
    if (menu.menuType === 'external') {
      openExternal(menu.path);
      return Promise.resolve();
    }

    return routerPushByKeyWithMetaQuery(menu.routeKey);
  }

  function routerPushByMenuKey(key: string) {
    const menu = routeStore.searchMenus.find((item: App.Global.Menu) => item.key === key);

    if (!menu) {
      return routerPushByKeyWithMetaQuery(key as RouteKey);
    }

    return routerPushByMenu(menu);
  }

  async function toHome() {
    return routerPushByKey('blog-admin_home');
  }

  /**
   * Navigate to login page
   *
   * @param loginModule The login module
   * @param redirectUrl The redirect url, if not specified, it will be the current route fullPath
   */
  async function toLogin(loginModule?: UnionKey.LoginModule, redirectUrl?: string) {
    const module = loginModule || 'pwd-login';

    const options: RouterPushOptions = {
      params: {
        module
      }
    };

    const redirect = redirectUrl || route.value.fullPath;

    options.query = {
      redirect
    };

    return routerPushByKey('login', options);
  }

  /**
   * Toggle login module
   *
   * @param module
   */
  async function toggleLoginModule(module: UnionKey.LoginModule) {
    const query = route.value.query as Record<string, string>;

    return routerPushByKey('login', { query, params: { module } });
  }

  /**
   * Redirect from login
   *
   * @param [needRedirect=true] Whether to redirect after login. Default is `true`
   */
  async function redirectFromLogin(needRedirect = true) {
    const redirect = route.value.query?.redirect as string;

    if (needRedirect && redirect) {
      await routerPush(redirect);
    } else {
      await toHome();
    }
  }

  return {
    routerPush,
    routerBack,
    routerPushByKey,
    routerPushByKeyWithMetaQuery,
    routerPushByMenu,
    routerPushByMenuKey,
    toLogin,
    toggleLoginModule,
    redirectFromLogin
  };
}
