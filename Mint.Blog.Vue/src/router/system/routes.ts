import type { RouteRecordRaw } from 'vue-router';

export const systemRoutes: RouteRecordRaw[] = [
  {
    path: ':pathMatch(.*)*',
    name: 'NotFound',
    component: () => import('@/components/system/404.vue'),
    meta: {
      title: '404',
      hideInMenu: true
    }
  },
  {
    path: 'login/:module(pwd-login|code-login|register|reset-pwd|bind-wechat)?',
    name: 'login',
    component: () => import('@/views/system/login.vue'),
    props: true,
    meta: {
      title: 'login',
      i18nKey: 'route.login',
      public: true,
      hideInMenu: true,
      blank: true
    }
  },
  {
    path: 'exception/403',
    name: 'system_exception_403',
    component: () => import('@/components/system/403.vue'),
    meta: {
      title: 'system_exception_403',
      i18nKey: 'route.system_exception_403',
      public: false,
      hideInMenu: true
    }
  },
  {
    path: 'exception/404',
    name: 'system_exception_404',
    component: () => import('@/components/system/404.vue'),
    meta: {
      title: 'system_exception_404',
      i18nKey: 'route.system_exception_404',
      public: false,
      hideInMenu: true
    }
  },
  {
    path: 'exception/500',
    name: 'system_exception_500',
    component: () => import('@/components/system/500.vue'),
    meta: {
      title: 'system_exception_500',
      i18nKey: 'route.system_exception_500',
      public: false,
      hideInMenu: true
    }
  },
  {
    path: 'exception/look-forward',
    name: 'system_exception_look-forward',
    component: () => import('@/components/system/look-forward.vue'),
    meta: {
      title: 'system_exception_look-forward',
      i18nKey: 'route.system_exception_look-forward',
      public: false,
      hideInMenu: true
    }
  },
  {
    path: 'iframe-page/:url',
    name: 'iframe-page',
    component: () => import('@/components/system/iframe-page.vue'),
    props: true,
    meta: {
      title: 'iframe-page',
      i18nKey: 'route.iframe-page',
      public: true,
      hideInMenu: true,
      keepAlive: true
    }
  },
  {
    path: 'user',
    name: 'system_user',
    component: () => import('@/views/system/user.vue'),
    meta: {
      title: 'system_user',
      i18nKey: 'route.system_user',
      public: true
    }
  },
  {
    path: 'role',
    name: 'system_role',
    component: () => import('@/views/system/role.vue'),
    meta: {
      title: 'system_role',
      i18nKey: 'route.system_role',
      public: true
    }
  },
  {
    path: 'menu',
    name: 'system_menu',
    component: () => import('@/views/system/menu.vue'),
    meta: {
      title: 'system_menu',
      i18nKey: 'route.system_menu',
      public: true,
      keepAlive: true
    }
  },
  {
    path: 'user-detail/:id',
    name: 'system_user-detail',
    component: () => import('@/views/system/user.vue'),
    props: true,
    meta: {
      title: 'system_user-detail',
      i18nKey: 'route.system_user-detail',
      public: true,
      hideInMenu: true,
      activeMenu: 'system_user'
    }
  },
  {
    path: 'user-center',
    name: 'user-center',
    component: () => import('@/views/system/user-center.vue'),
    meta: {
      title: 'user-center',
      i18nKey: 'route.user-center',
      public: true,
      hideInMenu: true,
      activeMenu: 'system'
    }
  },
  {
    path: 'about',
    name: 'system_about',
    component: () => import('@/views/blog/admin/about.vue'),
    meta: {
      title: 'system_about',
      i18nKey: 'route.system_about',
      public: true
    }
  }
];
