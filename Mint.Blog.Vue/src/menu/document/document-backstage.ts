import type { AppMenuRecord, MenuPermission } from '@/menu/types';

const queryPermission: MenuPermission[] = ['Search'];

export const documentMenus: AppMenuRecord[] = [

  {
    id: 'blog_admin_document',
    parentId: null,
    menuType: 'folder',
    path: '/blog/admin/document',
    tableName: '.',
    enabled: true,
    menuI18nKey: 'route.document',
    icon: 'mdi:file-document-multiple-outline',
    order: 4
  },
  {
    id: 'blog_admin_document_project',
    parentId: 'blog_admin_document',
    menuType: 'iframe',
    routerName: 'document_project',
    path: '/blog/admin/document/project',
    tableName: 'admin_document_project',
    enabled: true,
    menuI18nKey: 'route.document_project',
    icon: 'mdi:file-link-outline',
    order: 1,
    permission: queryPermission
  },
  {
    id: 'blog_admin_document_project_link',
    parentId: 'blog_admin_document',
    menuType: 'external',
    routerName: 'document_project-link',
    path: 'https://www.yangmufa.cn',
    tableName: 'admin_document_project_link',
    enabled: true,
    menuI18nKey: 'route.document_project-link',
    icon: 'mdi:open-in-new',
    order: 2,
    permission: queryPermission
  },
  {
    id: 'blog_admin_document_vue',
    parentId: 'blog_admin_document',
    menuType: 'iframe',
    routerName: 'document_vue',
    path: '/blog/admin/document/vue',
    tableName: 'admin_document_vue',
    enabled: true,
    menuI18nKey: 'route.document_vue',
    icon: 'logos:vue',
    order: 3,
    permission: queryPermission
  },
  {
    id: 'blog_admin_document_vite',
    parentId: 'blog_admin_document',
    menuType: 'iframe',
    routerName: 'document_vite',
    path: '/blog/admin/document/vite',
    tableName: 'admin_document_vite',
    enabled: true,
    menuI18nKey: 'route.document_vite',
    icon: 'logos:vitejs',
    order: 4,
    permission: queryPermission
  },
  {
    id: 'blog_admin_document_unocss',
    parentId: 'blog_admin_document',
    menuType: 'iframe',
    routerName: 'document_unocss',
    path: '/blog/admin/document/unocss',
    tableName: 'admin_document_unocss',
    enabled: true,
    menuI18nKey: 'route.document_unocss',
    icon: 'logos:unocss',
    order: 5,
    permission: queryPermission
  },
  {
    id: 'blog_admin_document_naive',
    parentId: 'blog_admin_document',
    menuType: 'iframe',
    routerName: 'document_naive',
    path: '/blog/admin/document/naive',
    tableName: 'admin_document_naive',
    enabled: true,
    menuI18nKey: 'route.document_naive',
    icon: 'logos:naiveui',
    order: 6,
    permission: queryPermission
  },
  {
    id: 'blog_admin_document_antd',
    parentId: 'blog_admin_document',
    menuType: 'iframe',
    routerName: 'document_antd',
    path: '/blog/admin/document/antd',
    tableName: 'admin_document_antd',
    enabled: true,
    menuI18nKey: 'route.document_antd',
    icon: 'logos:ant-design',
    order: 7,
    permission: queryPermission
  },
];
