import type { RouteRecordRaw } from 'vue-router';

export const exceptionRoutes: RouteRecordRaw[] = [
  { path: '/exception/403', name: 'exception_403', component: () => import('@/components/system/403.vue'), meta: { title: 'exception_403', i18nKey: 'route.exception_403', public: false, hideInMenu: true } },
  { path: '/exception/404', name: 'exception_404', component: () => import('@/components/system/404.vue'), meta: { title: 'exception_404', i18nKey: 'route.exception_404', public: false, hideInMenu: true } },
  { path: '/exception/500', name: 'exception_500', component: () => import('@/components/system/500.vue'), meta: { title: 'exception_500', i18nKey: 'route.exception_500', public: false, hideInMenu: true } },
  { path: '/exception/look-forward', name: 'exception_look-forward', component: () => import('@/components/system/look-forward.vue'), meta: { title: 'exception_look-forward', i18nKey: 'route.system_exception_look-forward', public: false, hideInMenu: true } },
  { path: '/:pathMatch(.*)*', name: 'not-found', component: () => import('@/components/system/404.vue'), meta: { title: 'exception_404', i18nKey: 'route.exception_404', public: false, hideInMenu: true } }
];
