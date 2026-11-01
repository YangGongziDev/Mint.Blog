import type { AppMenuRecord } from '@/menu/types';

export const systemMenus: AppMenuRecord[] = [
  { id: 'system', parentId: null, menuType: 'folder', path: '/system', tableName: '.', enabled: true, menuI18nKey: 'route.system', icon: 'carbon:cloud-service-management', order: 3 },
  { id: 'system_user', parentId: 'system', menuType: 'route', routerName: 'system_user', path: '/system/user', tableName: 'system_user', enabled: true, menuI18nKey: 'route.system_user', icon: 'ic:round-manage-accounts', order: 1, permission: ['Search', 'Add', 'Delete', 'Update', 'Import', 'Export', 'Upload', 'Audit'] },
  { id: 'system_role', parentId: 'system', menuType: 'route', routerName: 'system_role', path: '/system/role', tableName: 'system_role', enabled: true, menuI18nKey: 'route.system_role', icon: 'carbon:user-role', order: 2, permission: ['Search', 'Add', 'Update', 'Audit'] },
  { id: 'exception', parentId: 'system', menuType: 'folder', path: '/exception', tableName: '.', enabled: true, menuI18nKey: 'route.system_exception', icon: 'ant-design:exception-outlined', order: 4 },
  ...['look-forward', '403', '404', '500'].map((key, index): AppMenuRecord => ({
    id: `exception_${key}`, parentId: 'exception', menuType: 'route', routerName: `exception_${key}`, path: `/exception/${key}`, tableName: `exception_${key}`, enabled: true, menuI18nKey: `route.system_exception_${key}`, icon: 'ant-design:exception-outlined', order: index + 1, permission: ['Search']
  })),
  { id: 'system_about', parentId: null, menuType: 'route', routerName: 'system_about', path: '/system/about', tableName: 'system_about', enabled: true, menuI18nKey: 'route.system_about', icon: 'fluent:book-information-24-regular', order: 5, permission: ['Search'] }
];
