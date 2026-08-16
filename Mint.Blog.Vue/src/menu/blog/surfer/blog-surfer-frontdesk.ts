import type { AppMenuRecord } from '@/menu/types';

export const blogSurferMenus: AppMenuRecord[] = [
  {
    id: 'blog-surfer_dashboard',
    parentId: null,
    menuType: 'route',
    routerName: 'blog-surfer_dashboard',
    path: '/blog/surfer/dashboard',
    tableName: 'blog-surfer_dashboard',
    enabled: true,
    menuI18nKey: 'route.blog-surfer_dashboard',
    icon: 'mdi:view-dashboard-outline',
    order: 1
  },
  {
    id: 'blog-surfer_home',
    parentId: null,
    menuType: 'route',
    routerName: 'blog-surfer_home',
    path: '/blog/surfer/home',
    tableName: 'blog-surfer_home',
    enabled: true,
    menuI18nKey: 'route.blog-surfer_home',
    icon: 'mdi:home-outline',
    order: 2
  },
  {
    id: 'blog-surfer_column',
    parentId: null,
    menuType: 'route',
    routerName: 'blog-surfer_column',
    path: '/blog/surfer/column',
    tableName: 'blog-surfer_column',
    enabled: true,
    menuI18nKey: 'route.blog-surfer_column',
    icon: 'mdi:bookshelf',
    order: 3
  },
  {
    id: 'blog-surfer_category',
    parentId: null,
    menuType: 'route',
    routerName: 'blog-surfer_category',
    path: '/blog/surfer/category',
    tableName: 'blog-surfer_category',
    enabled: true,
    menuI18nKey: 'route.blog-surfer_category',
    icon: 'mdi:shape-outline',
    order: 4
  },
  {
    id: 'blog-surfer_tag',
    parentId: null,
    menuType: 'route',
    routerName: 'blog-surfer_tag',
    path: '/blog/surfer/tag',
    tableName: 'blog-surfer_tag',
    enabled: true,
    menuI18nKey: 'route.blog-surfer_tag',
    icon: 'mdi:tag-multiple-outline',
    order: 5
  },
  {
    id: 'blog-surfer_archive',
    parentId: null,
    menuType: 'route',
    routerName: 'blog-surfer_archive',
    path: '/blog/surfer/archive',
    tableName: 'blog-surfer_archive',
    enabled: true,
    menuI18nKey: 'route.blog-surfer_archive',
    icon: 'mdi:archive-outline',
    order: 6
  },
  {
    id: 'blog-surfer_gallery',
    parentId: null,
    menuType: 'route',
    routerName: 'blog-surfer_gallery',
    path: '/blog/surfer/gallery',
    tableName: 'blog-surfer_gallery',
    enabled: true,
    menuI18nKey: 'route.blog-surfer_gallery',
    icon: 'mdi:wallpaper',
    order: 7
  },
  {
    id: 'blog-surfer_friend',
    parentId: null,
    menuType: 'route',
    routerName: 'blog-surfer_friend',
    path: '/blog/surfer/friend',
    tableName: 'blog-surfer_friend',
    enabled: true,
    menuI18nKey: 'route.blog-surfer_friend',
    icon: 'mdi:link-variant',
    order: 8
  },
  {
    id: 'blog-surfer_message',
    parentId: null,
    menuType: 'route',
    routerName: 'blog-surfer_message',
    path: '/blog/surfer/message',
    tableName: 'blog-surfer_message',
    enabled: true,
    menuI18nKey: 'route.blog-surfer_message',
    icon: 'mdi:message-outline',
    order: 9
  },
  {
    id: 'blog-surfer_about-group',
    parentId: null,
    menuType: 'folder',
    path: '/blog/surfer/about-group',
    tableName: '.',
    enabled: true,
    menuI18nKey: 'route.blog-surfer_about-group',
    icon: 'mdi:information-outline',
    order: 11
  },
  {
    id: 'blog-surfer_author',
    parentId: 'blog-surfer_about-group',
    menuType: 'route',
    routerName: 'blog-surfer_author',
    path: '/blog/surfer/author',
    tableName: 'blog-surfer_author',
    enabled: true,
    menuI18nKey: 'route.blog-surfer_author',
    icon: 'mdi:account-outline',
    order: 1
  },
  {
    id: 'blog-surfer_about',
    parentId: 'blog-surfer_about-group',
    menuType: 'route',
    routerName: 'blog-surfer_about',
    path: '/blog/surfer/about',
    tableName: 'blog-surfer_about',
    enabled: true,
    menuI18nKey: 'route.blog-surfer_about',
    icon: 'mdi:information-variant',
    order: 2
  },
  {
    id: 'blog-surfer_equipment',
    parentId: 'blog-surfer_about-group',
    menuType: 'route',
    routerName: 'blog-surfer_equipment',
    path: '/blog/surfer/equipment',
    tableName: 'blog-surfer_equipment',
    enabled: true,
    menuI18nKey: 'route.blog-surfer_equipment',
    icon: 'mdi:monitor-cellphone',
    order: 3
  }
];
