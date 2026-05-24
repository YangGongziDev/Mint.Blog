import type { App } from 'vue';
import { type RouteRecordRaw, createRouter, createWebHistory } from 'vue-router';
import { useRouteStore } from '@/store/system/route';
import { setupRouterGuards } from './guards';
import type { MenuModuleKey, RouteLayout } from './types';
import { systemRoutes } from '@/router/system/routes';
import { blogAdminRoutes } from '@/router/blog/admin/routes';
import { blogSurferRoutes } from '@/router/blog/surfer/routes';

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
      title: '程序员-杨工子',
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

export async function setupRouter(app: App) {
  const routeStore = useRouteStore();
  await routeStore.initAuthRoute();
  app.use(router);
  setupRouterGuards(router);
  await router.isReady();
}

export default router;

