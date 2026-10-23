import type { RouteRecordRaw } from 'vue-router';

export const blogSurferRoutes: RouteRecordRaw[] = [
  {
    path: 'home',
    name: 'blog-surfer_home',
    component: () => import('@/views/blog/surfer/home.vue'),
    meta: {
      title: 'blog-surfer_home',
      i18nKey: 'route.blog-surfer_home',
      hideInMenu: true,
      public: false
    }
  },
  {
    path: 'dashboard',
    name: 'blog-surfer_dashboard',
    component: () => import('@/views/blog/surfer/dashboard.vue'),
    meta: {
      title: 'blog-surfer_dashboard',
      i18nKey: 'route.blog-surfer_dashboard',
      hideInMenu: true,
      public: false
    }
  },
  {
    path: 'article/:id',
    name: 'blog-surfer_article_detail',
    component: () => import('@/views/blog/surfer/article-detail.vue'),
    props: true,
    meta: {
      title: 'blog-surfer_article_detail',
      i18nKey: 'route.blog-surfer_articles',
      hideInMenu: true,
      public: false,
      activeMenu: 'blog-surfer_dashboard'
    }
  },
  {
    path: 'category',
    name: 'blog-surfer_category',
    component: () => import('@/views/blog/surfer/category.vue'),
    meta: {
      title: 'blog-surfer_category',
      i18nKey: 'route.blog-surfer_category',
      hideInMenu: true,
      public: false
    }
  },
  {
    path: 'tag',
    name: 'blog-surfer_tag',
    component: () => import('@/views/blog/surfer/tag.vue'),
    meta: {
      title: 'blog-surfer_tag',
      i18nKey: 'route.blog-surfer_tag',
      hideInMenu: true,
      public: false
    }
  },
  {
    path: 'archive',
    name: 'blog-surfer_archive',
    component: () => import('@/views/blog/surfer/archive.vue'),
    meta: {
      title: 'blog-surfer_archive',
      i18nKey: 'route.blog-surfer_archive',
      hideInMenu: true,
      public: false
    }
  },
  {
    path: 'column',
    name: 'blog-surfer_column',
    component: () => import('@/views/blog/surfer/column.vue'),
    meta: {
      title: 'blog-surfer_column',
      i18nKey: 'route.blog-surfer_column',
      hideInMenu: true,
      public: false
    }
  },
  {
    path: 'column/:columnId',
    name: 'blog-surfer_column_detail',
    component: () => import('@/views/blog/surfer/column-detail.vue'),
    meta: {
      title: 'blog-surfer_column_detail',
      i18nKey: 'route.blog-surfer_column',
      hideInMenu: true,
      public: false,
      activeMenu: 'blog-surfer_column'
    }
  },
  {
    path: 'about',
    name: 'blog-surfer_about',
    component: () => import('@/views/blog/surfer/about.vue'),
    meta: {
      title: 'blog-surfer_about',
      i18nKey: 'route.blog-surfer_about',
      hideInMenu: true,
      public: false
    }
  },
  {
    path: 'author',
    name: 'blog-surfer_author',
    component: () => import('@/views/blog/surfer/author.vue'),
    meta: {
      title: 'blog-surfer_author',
      i18nKey: 'route.blog-surfer_author',
      hideInMenu: true,
      public: false
    }
  },
  {
    path: 'friend',
    name: 'blog-surfer_friend',
    component: () => import('@/views/blog/surfer/friend.vue'),
    meta: {
      title: 'blog-surfer_friend',
      i18nKey: 'route.blog-surfer_friend',
      hideInMenu: true,
      public: false
    }
  },
  {
    path: 'message',
    name: 'blog-surfer_message',
    component: () => import('@/views/blog/surfer/message.vue'),
    meta: {
      title: 'blog-surfer_message',
      i18nKey: 'route.blog-surfer_message',
      hideInMenu: true,
      public: false
    }
  },

  {
    path: 'equipment',
    name: 'blog-surfer_equipment',
    component: () => import('@/views/blog/surfer/equipment.vue'),
    meta: {
      title: 'blog-surfer_equipment',
      i18nKey: 'route.blog-surfer_equipment',
      hideInMenu: true,
      public: false
    }
  },
  {
    path: 'gallery',
    name: 'blog-surfer_gallery',
    component: () => import('@/views/blog/surfer/gallery.vue'),
    meta: {
      title: 'blog-surfer_gallery',
      i18nKey: 'route.blog-surfer_gallery',
      hideInMenu: true,
      public: false
    }
  },
  {
    path: ':pathMatch(.*)*',
    name: 'blog-surfer_not-found',
    component: () => import('@/components/system/404.vue'),
    meta: {
      title: 'exception_404',
      i18nKey: 'route.exception_404',
      hideInMenu: true,
      public: false
    }
  }
];
