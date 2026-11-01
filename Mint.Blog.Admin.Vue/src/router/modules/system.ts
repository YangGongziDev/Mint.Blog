import type { RouteRecordRaw } from 'vue-router';

export const loginRoute: RouteRecordRaw = {
  path: '/system/login/:module(pwd-login|code-login|register|reset-pwd|bind-wechat)?',
  name: 'login',
  component: () => import('@/views/system/login.vue'),
  props: true,
  meta: { title: 'login', i18nKey: 'route.login', public: true, hideInMenu: true, blank: true }
};

export const systemRoutes: RouteRecordRaw[] = [
  { path: '/system/iframe-page/:url', name: 'iframe-page', component: () => import('@/components/system/iframe-page.vue'), props: true, meta: { title: 'iframe-page', i18nKey: 'route.iframe-page', public: true, hideInMenu: true, keepAlive: true } },
  { path: '/system/user', name: 'system_user', component: () => import('@/views/system/user.vue'), meta: { title: 'system_user', i18nKey: 'route.system_user', public: true } },
  { path: '/system/role', name: 'system_role', component: () => import('@/views/system/role.vue'), meta: { title: 'system_role', i18nKey: 'route.system_role', public: true } },
  { path: '/system/user-detail/:id', name: 'system_user-detail', component: () => import('@/views/system/user.vue'), props: true, meta: { title: 'system_user-detail', i18nKey: 'route.system_user-detail', public: true, hideInMenu: true, activeMenu: 'system_user' } },
  { path: '/system/user-center', name: 'user-center', component: () => import('@/views/system/user-center.vue'), meta: { title: 'user-center', i18nKey: 'route.user-center', public: true, hideInMenu: true } },
  { path: '/system/about', name: 'system_about', component: () => import('@/views/system/about.vue'), meta: { title: 'system_about', i18nKey: 'route.system_about', public: true } }
];
