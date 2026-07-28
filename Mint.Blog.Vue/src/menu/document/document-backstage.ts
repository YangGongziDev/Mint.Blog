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
    path: 'https://www.yanggongzi.dev/blog/surfer/column/1',
    tableName: 'admin_document_project_link',
    enabled: true,
    menuI18nKey: 'route.document_project-link',
    icon: 'mdi:open-in-new',
    order: 2,
    permission: queryPermission
  },
  {
    id: 'blog_admin_document_dotnet',
    parentId: 'blog_admin_document',
    menuType: 'iframe',
    routerName: 'document_dotnet',
    path: '/blog/admin/document/dotnet',
    tableName: 'admin_document_dotnet',
    enabled: true,
    menuI18nKey: 'route.document_dotnet',
    icon: 'logos:dotnet',
    order: 3,
    permission: queryPermission
  },
  {
    id: 'blog_admin_document_postgresql',
    parentId: 'blog_admin_document',
    menuType: 'iframe',
    routerName: 'document_postgresql',
    path: '/blog/admin/document/postgresql',
    tableName: 'admin_document_postgresql',
    enabled: true,
    menuI18nKey: 'route.document_postgresql',
    icon: 'logos:postgresql',
    order: 4,
    permission: queryPermission
  },
  {
    id: 'blog_admin_document_rustfs',
    parentId: 'blog_admin_document',
    menuType: 'iframe',
    routerName: 'document_rustfs',
    path: '/blog/admin/document/rustfs',
    tableName: 'admin_document_rustfs',
    enabled: true,
    menuI18nKey: 'route.document_rustfs',
    icon: 'simple-icons:rust',
    order: 5,
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
    order: 6,
    permission: queryPermission
  },
  {
    id: 'blog_admin_document_pinia',
    parentId: 'blog_admin_document',
    menuType: 'iframe',
    routerName: 'document_pinia',
    path: '/blog/admin/document/pinia',
    tableName: 'admin_document_pinia',
    enabled: true,
    menuI18nKey: 'route.document_pinia',
    icon: 'logos:pinia',
    order: 7,
    permission: queryPermission
  },
  {
    id: 'blog_admin_document_tailwindcss',
    parentId: 'blog_admin_document',
    menuType: 'iframe',
    routerName: 'document_tailwindcss',
    path: '/blog/admin/document/tailwindcss',
    tableName: 'admin_document_tailwindcss',
    enabled: true,
    menuI18nKey: 'route.document_tailwindcss',
    icon: 'logos:tailwindcss-icon',
    order: 8,
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
    order: 9,
    permission: queryPermission
  },
];
