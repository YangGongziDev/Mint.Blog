import type { App } from 'vue';
import { type RouteRecordRaw, createRouter, createWebHistory } from 'vue-router';
import { useRouteStore } from '@/store/system/route';
import { homeRoutes } from './modules/home';
import { blogRoutes } from './modules/blog';
import { systemRoutes, loginRoute } from './modules/system';
import { documentRoutes } from './modules/document';
import { exceptionRoutes } from './modules/exception';
import { setupRouterGuards } from './guards';

const { VITE_BASE_URL } = import.meta.env;

export const builtinRoutes: RouteRecordRaw[] = [
  loginRoute,
  {
    path: '/',
    name: 'root',
    component: () => import('@/layouts/index.vue'),
    redirect: '/home',
    meta: { title: '管理端', hideInMenu: true },
    children: [
      ...homeRoutes,
      ...blogRoutes,
      ...systemRoutes,
      ...documentRoutes,
      ...exceptionRoutes,
      { path: '/blog', redirect: '/home' },
      { path: '/system', redirect: '/home' }
    ]
  }
];

export function createStaticRoutes() {
  return builtinRoutes;
}

export const router = createRouter({
  history: createWebHistory(VITE_BASE_URL),
  routes: builtinRoutes
});

const DYNAMIC_IMPORT_RELOAD_KEY = 'mint-blog:dynamic-import-reload-at';

function isDynamicImportLoadError(error: unknown) {
  const message = error instanceof Error ? error.message : String(error);
  return /Failed to fetch dynamically imported module|Importing a module script failed|error loading dynamically imported module/i.test(
    message
  );
}

function setupDynamicImportErrorReload() {
  router.onError(error => {
    if (!isDynamicImportLoadError(error)) return;

    const lastReloadAt = Number(window.sessionStorage.getItem(DYNAMIC_IMPORT_RELOAD_KEY) || 0);
    const now = Date.now();
    if (now - lastReloadAt < 30_000) return;

    window.sessionStorage.setItem(DYNAMIC_IMPORT_RELOAD_KEY, String(now));
    window.location.reload();
  });
}

setupDynamicImportErrorReload();

export async function setupRouter(app: App) {
  const routeStore = useRouteStore();
  await routeStore.initAuthRoute();
  app.use(router);
  setupRouterGuards(router);
  await router.isReady();
}

export default router;
