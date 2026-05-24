import type { AppMenuRecord, MenuPermission } from '@/menu/types';

const queryPermission: MenuPermission[] = ['Search'];
const userPermission: MenuPermission[] = ['Search', 'Add', 'Delete', 'Update', 'Import', 'Export', 'Upload', 'Audit'];
const rolePermission: MenuPermission[] = ['Search', 'Add', 'Update', 'Audit'];
const menuPermission: MenuPermission[] = ['Search', 'Add', 'Delete', 'Update', 'Export'];

export const systemMenus: AppMenuRecord[] = [
  {
    id: 'system',
    parentId: null,
    menuType: 'folder',
    path: '/system',
    tableName: '.',
    enabled: true,
    menuI18nKey: 'route.system',
    icon: 'carbon:cloud-service-management',
    order: 3
  },
  {
    id: 'system_user',
    parentId: 'system',
    menuType: 'route',
    routerName: 'system_user',
    path: '/system/user',
    tableName: 'system_user',
    enabled: true,
    menuI18nKey: 'route.system_user',
    icon: 'ic:round-manage-accounts',
    order: 1,
    permission: userPermission
  },
  {
    id: 'system_role',
    parentId: 'system',
    menuType: 'route',
    routerName: 'system_role',
    path: '/system/role',
    tableName: 'system_role',
    enabled: true,
    menuI18nKey: 'route.system_role',
    icon: 'carbon:user-role',
    order: 2,
    permission: rolePermission
  },
  {
    id: 'system_menu',
    parentId: 'system',
    menuType: 'route',
    routerName: 'system_menu',
    path: '/system/menu',
    tableName: 'system_menu',
    enabled: true,
    menuI18nKey: 'route.system_menu',
    icon: 'material-symbols:route',
    order: 3,
    permission: menuPermission
  },
  {
    id: 'system_exception',
    parentId: 'system',
    menuType: 'folder',
    path: '/system/exception',
    tableName: '.',
    enabled: true,
    menuI18nKey: 'route.system_exception',
    icon: 'ant-design:exception-outlined',
    order: 4
  },
  {
    id: 'system_exception_403',
    parentId: 'system_exception',
    menuType: 'route',
    routerName: 'system_exception_403',
    path: '/system/exception/403',
    tableName: 'system_exception_403',
    enabled: true,
    menuI18nKey: 'route.system_exception_403',
    icon: 'ic:baseline-block',
    order: 1,
    permission: queryPermission
  },
  {
    id: 'system_exception_404',
    parentId: 'system_exception',
    menuType: 'route',
    routerName: 'system_exception_404',
    path: '/system/exception/404',
    tableName: 'system_exception_404',
    enabled: true,
    menuI18nKey: 'route.system_exception_404',
    icon: 'ic:baseline-web-asset-off',
    order: 2,
    permission: queryPermission
  },
  {
    id: 'system_exception_500',
    parentId: 'system_exception',
    menuType: 'route',
    routerName: 'system_exception_500',
    path: '/system/exception/500',
    tableName: 'system_exception_500',
    enabled: true,
    menuI18nKey: 'route.system_exception_500',
    icon: 'ic:baseline-wifi-off',
    order: 3,
    permission: queryPermission
  },

  {
    id: 'system_about',
    parentId: null,
    menuType: 'route',
    routerName: 'system_about',
    path: '/system/about',
    tableName: 'system_about',
    enabled: true,
    menuI18nKey: 'route.system_about',
    icon: 'fluent:book-information-24-regular',
    order: 5,
    permission: queryPermission
  },
];
