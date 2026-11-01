import type { RouteRecordRaw } from 'vue-router';

export const blogRoutes: RouteRecordRaw[] = [
  { path: '/blog/tag-version', name: 'blog_tag-version', component: () => import('@/views/blog/tag-version.vue'), meta: { title: 'blog_tag-version', i18nKey: 'route.blog_tag-version', public: true, roles: ['ROLE_ADMIN', 'ROLE_SUPER'] } },
  { path: '/blog/resource', name: 'blog_resource', component: () => import('@/views/blog/resource.vue'), meta: { title: 'blog_resource', i18nKey: 'route.blog_resource', public: true, roles: ['ROLE_ADMIN', 'ROLE_SUPER'] } },
  { path: '/blog/category', name: 'blog_category', component: () => import('@/views/blog/category.vue'), meta: { title: 'blog_category', i18nKey: 'route.blog_category', public: true } },
  { path: '/blog/tag', name: 'blog_tag', component: () => import('@/views/blog/tag.vue'), meta: { title: 'blog_tag', i18nKey: 'route.blog_tag', public: true } },
  { path: '/blog/settings', name: 'blog_settings', component: () => import('@/views/blog/settings.vue'), meta: { title: 'blog_settings', i18nKey: 'route.blog_settings', public: true } },
  { path: '/blog/friend', name: 'blog_friend', component: () => import('@/views/blog/friend.vue'), meta: { title: 'blog_friend', i18nKey: 'route.blog_friend', public: true } },
  { path: '/blog/comment', name: 'blog_comment', component: () => import('@/views/blog/comment.vue'), meta: { title: 'blog_comment', i18nKey: 'route.blog_comment', public: true } },
  { path: '/blog/column', name: 'blog_column', component: () => import('@/views/blog/column.vue'), meta: { title: 'blog_column', i18nKey: 'route.blog_column', public: true } },
  { path: '/blog/image', name: 'blog_image', component: () => import('@/views/blog/image.vue'), meta: { title: 'blog_image', i18nKey: 'route.blog_image', public: true } },
  { path: '/blog/gallery', name: 'blog_gallery', component: () => import('@/views/blog/gallery.vue'), meta: { title: 'blog_gallery', i18nKey: 'route.blog_gallery', public: true } },
  { path: '/blog/article', name: 'blog_article', component: () => import('@/views/blog/article.vue'), meta: { title: 'blog_article', i18nKey: 'route.blog_article', public: true } },
  { path: '/blog/article/create', name: 'blog_article-create', component: () => import('@/views/blog/article-create.vue'), meta: { title: 'blog_article-create', i18nKey: 'route.blog_article-create', public: true, hideInMenu: true, activeMenu: 'blog_article' } },
  { path: '/blog/article/edit/:id', name: 'blog_article-edit', component: () => import('@/views/blog/article-edit.vue'), meta: { title: 'blog_article-edit', i18nKey: 'route.blog_article-edit', public: true, hideInMenu: true, activeMenu: 'blog_article' } }
];
