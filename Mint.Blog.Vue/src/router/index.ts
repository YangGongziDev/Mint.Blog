import type { App } from 'vue';
import { type RouteRecordRaw, createRouter, createWebHistory } from 'vue-router';
import { useRouteStore } from '@/store/system/route';
import { blogAdminRoutes } from '@/router/blog/admin/routes';
import { blogSurferRoutes } from '@/router/blog/surfer/routes';
import { systemRoutes } from '@/router/system/routes';
import { setupRouterGuards } from './guards';
import type { MenuModuleKey, RouteLayout } from './types';

const { VITE_BASE_URL } = import.meta.env;

interface ModuleRouteOptions {
  path: string;
  title: string;
  redirect: string;
  layout: RouteLayout;
  menuModule: MenuModuleKey;
  children: RouteRecordRaw[];
}

function createModuleRoute(options: ModuleRouteOptions): RouteRecordRaw {
  const layoutComponent =
    options.layout === 'backstage'
      ? () => import('@/layouts/backstage/index.vue')
      : () => import('@/layouts/frontdesk/index.vue');

  return {
    path: options.path,
    component: layoutComponent,
    redirect: options.redirect,
    meta: {
      title: options.title,
      layout: options.layout,
      menuModule: options.menuModule
    },
    children: options.children
  };
}

export const builtinRoutes: RouteRecordRaw[] = [
  {
    path: '/',
    name: 'root',
    component: () => import('@/views/index.vue'),
    redirect: '/blog',
    meta: {
      title: '杨工子',
      hideInMenu: true
    },
    children: [
      createModuleRoute({
        path: '/system',
        title: '系统管理',
        redirect: '/system/home',
        layout: 'backstage',
        menuModule: 'backstage',
        children: systemRoutes
      }),
      {
        path: '/blog',
        name: 'blog',
        component: () => import('@/views/index.vue'),
        redirect: '/blog/surfer/home',
        meta: {
          title: '博客',
          hideInMenu: true
        },
        children: [
          createModuleRoute({
            path: '/blog/admin',
            title: '后台',
            redirect: '/blog/admin/home',
            layout: 'backstage',
            menuModule: 'backstage',
            children: blogAdminRoutes
          }),
          createModuleRoute({
            path: '/blog/surfer',
            title: '前台',
            redirect: '/blog/surfer/home',
            layout: 'frontdesk',
            menuModule: 'frontdesk',
            children: blogSurferRoutes
          })
        ]
      }
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

