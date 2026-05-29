import type { RouteRecordRaw } from 'vue-router';

export const blogAdminRoutes: RouteRecordRaw[] = [
  {
    path: 'home',
    name: 'blog-admin_home',
    component: () => import('@/views/blog/admin/home.vue'),
    meta: {
      title: 'blog-admin_home',
      i18nKey: 'route.blog-admin_home',
      public: true
    }
  },
  {
    path: 'category',
    name: 'blog-admin_category',
    component: () => import('@/views/blog/admin/category.vue'),
    meta: {
      title: 'blog-admin_category',
      i18nKey: 'route.blog-admin_category',
      public: true
    }
  },
  {
    path: 'tag',
    name: 'blog-admin_tag',
    component: () => import('@/views/blog/admin/tag.vue'),
    meta: {
      title: 'blog-admin_tag',
      i18nKey: 'route.blog-admin_tag',
      public: true
    }
  },
  {
    path: 'blog/settings',
    name: 'blog-admin_blog-settings',
    component: () => import('@/views/blog/admin/blog-settings.vue'),
    meta: {
      title: 'blog-admin_blog-settings',
      i18nKey: 'route.blog-admin_blog-settings',
      public: true
    }
  },
  {
    path: 'blog-settings',
    redirect: { name: 'blog-admin_blog-settings' }
  },
  {
    path: 'friend',
    name: 'blog-admin_friend',
    component: () => import('@/views/blog/admin/friend.vue'),
    meta: {
      title: 'blog-admin_friend',
      i18nKey: 'route.blog-admin_friend',
      public: true
    }
  },
  {
    path: 'comment',
    name: 'blog-admin_comment',
    component: () => import('@/views/blog/admin/comment.vue'),
    meta: {
      title: 'blog-admin_comment',
      i18nKey: 'route.blog-admin_comment',
      public: true
    }
  },
  {
    path: 'column',
    name: 'blog-admin_column',
    component: () => import('@/views/blog/admin/column.vue'),
    meta: {
      title: 'blog-admin_column',
      i18nKey: 'route.blog-admin_column',
      public: true
    }
  },
  {
    path: 'image',
    name: 'blog-admin_image',
    component: () => import('@/views/blog/admin/image.vue'),
    meta: {
      title: 'blog-admin_image',
      i18nKey: 'route.blog-admin_image',
      public: true
    }
  },
  {
    path: 'article',
    name: 'blog-admin_article',
    component: () => import('@/views/blog/admin/article.vue'),
    meta: {
      title: 'blog-admin_article',
      i18nKey: 'route.blog-admin_article',
      public: true
    }
  },
  {
    path: 'article/create',
    name: 'blog-admin_article-create',
    component: () => import('@/views/blog/admin/article-create.vue'),
    meta: {
      title: 'blog-admin_article-create',
      i18nKey: 'route.blog-admin_article-create',
      public: true,
      hideInMenu: true,
      activeMenu: 'blog-admin_article'
    }
  },
  {
    path: 'article/edit/:id',
    name: 'blog-admin_article-edit',
    component: () => import('@/views/blog/admin/article-edit.vue'),
    meta: {
      title: 'blog-admin_article-edit',
      i18nKey: 'route.blog-admin_article-edit',
      public: true,
      hideInMenu: true,
      activeMenu: 'blog-admin_article'
    }
  },
  {
    path: 'document/project',
    name: 'document_project',
    component: () => import('@/components/system/iframe-page.vue'),
    props: {
      url: 'https://www.yangmufa.cn'
    },
    meta: {
      title: 'document_project',
      i18nKey: 'route.document_project',
      public: true,
      hideInMenu: true
    }
  },
  {
    path: 'document/project-link',
    name: 'document_project-link',
    component: () => import('@/components/system/iframe-page.vue'),
    meta: {
      title: 'document_project-link',
      i18nKey: 'route.document_project-link',
      public: true,
      hideInMenu: true
    }
  },
  {
    path: 'document/vue',
    name: 'document_vue',
    component: () => import('@/components/system/iframe-page.vue'),
    props: {
      url: 'https://cn.vuejs.org/'
    },
    meta: {
      title: 'document_vue',
      i18nKey: 'route.document_vue',
      public: true,
      hideInMenu: true
    }
  },
  {
    path: 'document/vite',
    name: 'document_vite',
    component: () => import('@/components/system/iframe-page.vue'),
    props: {
      url: 'https://cn.vitejs.dev/'
    },
    meta: {
      title: 'document_vite',
      i18nKey: 'route.document_vite',
      public: true,
      hideInMenu: true
    }
  },
  {
    path: 'document/unocss',
    name: 'document_unocss',
    component: () => import('@/components/system/iframe-page.vue'),
    props: {
      url: 'https://unocss.dev/'
    },
    meta: {
      title: 'document_unocss',
      i18nKey: 'route.document_unocss',
      public: true,
      hideInMenu: true
    }
  },
  {
    path: 'document/naive',
    name: 'document_naive',
    component: () => import('@/components/system/iframe-page.vue'),
    props: {
      url: 'https://www.naiveui.com/zh-CN/os-theme/docs/introduction'
    },
    meta: {
      title: 'document_naive',
      i18nKey: 'route.document_naive',
      public: true,
      hideInMenu: true
    }
  },
  {
    path: 'document/antd',
    name: 'document_antd',
    component: () => import('@/components/system/iframe-page.vue'),
    props: {
      url: 'https://antdv.com/components/overview-cn'
    },
    meta: {
      title: 'document_antd',
      i18nKey: 'route.document_antd',
      public: true,
      hideInMenu: true
    }
  },
  {
    path: 'exception/403',
    name: 'exception_403',
    component: () => import('@/components/system/403.vue'),
    meta: {
      title: 'exception_403',
      i18nKey: 'route.exception_403',
      public: true,
      hideInMenu: true
    }
  },
  {
    path: 'exception/404',
    name: 'exception_404',
    component: () => import('@/components/system/404.vue'),
    meta: {
      title: 'exception_404',
      i18nKey: 'route.exception_404',
      public: true,
      hideInMenu: true
    }
  },
  {
    path: 'exception/500',
    name: 'exception_500',
    component: () => import('@/components/system/500.vue'),
    meta: {
      title: 'exception_500',
      i18nKey: 'route.exception_500',
      public: true,
      hideInMenu: true
    }
  },
  {
    path: ':pathMatch(.*)*',
    name: 'blog-admin_not-found',
    component: () => import('@/components/system/404.vue'),
    meta: {
      title: 'exception_404',
      i18nKey: 'route.exception_404',
      public: true,
      hideInMenu: true
    }
  }
];
