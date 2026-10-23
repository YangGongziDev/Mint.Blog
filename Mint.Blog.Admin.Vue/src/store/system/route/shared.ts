import type { RouteLocationNormalizedLoaded, RouteRecordRaw } from 'vue-router';
import type { AppRouteRecord, RouteKey } from '@/router/types';
import type { AppMenuNode, AppMenuRecord } from '@/menu/types';
import { $t } from '@/locales';
import { transformMenuRecordsToNodes } from '@/menu/types';

function getRouteName(route?: RouteRecordRaw | null) {
  return route?.name ? String(route.name) : '';
}

function cloneMenuNode(node: AppMenuNode): App.Global.Menu {
  return {
    id: node.id,
    parentId: node.parentId,
    key: node.key,
    label: node.menuI18nKey ? $t(node.menuI18nKey) : node.key,
    menuI18nKey: node.menuI18nKey,
    menuType: node.menuType,
    routeKey: (node.routeKey || node.key) as RouteKey,
    routePath: node.path,
    path: node.path,
    tableName: node.tableName,
    enabled: node.enabled,
    permission: node.permission,
    title: node.menuI18nKey ? $t(node.menuI18nKey) : node.key,
    icon: undefined,
    children: node.children?.map(cloneMenuNode)
  };
}

export function buildMenuTreeByRecords(records: AppMenuRecord[]) {
  const nodes = transformMenuRecordsToNodes(records);
  const nodeMap = new Map(nodes.map(node => [node.id, { ...node, children: [] as AppMenuNode[] }]));
  const roots: AppMenuNode[] = [];

  records.forEach(record => {
    const current = nodeMap.get(record.id)!;

    if (record.parentId && nodeMap.has(record.parentId)) {
      nodeMap.get(record.parentId)!.children!.push(current);
    } else {
      roots.push(current);
    }
  });

  const sortNodes = (items: AppMenuNode[]) => {
    items.sort((a, b) => (a.order || 0) - (b.order || 0));
    items.forEach(item => {
      if (item.children?.length) {
        sortNodes(item.children);
      } else {
        delete item.children;
      }
    });
  };

  sortNodes(roots);
  return roots;
}

export function createRouteMap(routes: RouteRecordRaw[]) {
  const map = new Map<RouteKey, RouteRecordRaw>();

  const walk = (items: RouteRecordRaw[]) => {
    items.forEach(route => {
      const name = getRouteName(route);
      if (name) {
        map.set(name as RouteKey, route);
      }
      if (route.children?.length) {
        walk(route.children);
      }
    });
  };

  walk(routes);
  return map;
}

function getMenuIcon(route?: RouteRecordRaw) {
  const icon = route?.meta?.icon;

  if (!icon || typeof icon !== 'string') {
    return undefined;
  }

  return () => null as never;
}

export function buildMenusByMenuTree(menuTree: AppMenuNode[], routeMap: Map<RouteKey, RouteRecordRaw>): App.Global.Menu[] {
  const convert = (node: AppMenuNode): App.Global.Menu => {
    const menu = cloneMenuNode(node);
    const route = routeMap.get(menu.routeKey);

    menu.routePath = route?.path || node.path;
    menu.icon = getMenuIcon(route);
    menu.title = menu.menuI18nKey ? $t(menu.menuI18nKey) : menu.label;
    menu.children = node.children?.map(convert);

    if (!menu.children?.length) {
      delete menu.children;
    }

    return menu;
  };

  return menuTree.map(convert);
}

export function transformMenuToSearchMenus(menus: App.Global.Menu[]) {
  const result: App.Global.Menu[] = [];

  const walk = (items: App.Global.Menu[]) => {
    items.forEach(item => {
      result.push(item);
      if (item.children?.length) {
        walk(item.children);
      }
    });
  };

  walk(menus);
  return result;
}

export function updateLocaleOfGlobalMenus(menus: App.Global.Menu[]): App.Global.Menu[] {
  return menus.map(menu => ({
    ...menu,
    label: menu.menuI18nKey ? $t(menu.menuI18nKey) : menu.label,
    title: menu.menuI18nKey ? $t(menu.menuI18nKey) : menu.title,
    children: menu.children ? updateLocaleOfGlobalMenus(menu.children) : undefined
  }));
}

export function flattenRoutes(routes: RouteRecordRaw[]) {
  const result: RouteRecordRaw[] = [];

  const walk = (items: RouteRecordRaw[]) => {
    items.forEach(route => {
      result.push(route);
      if (route.children?.length) {
        walk(route.children);
      }
    });
  };

  walk(routes);
  return result;
}

export function filterAuthRoutesByRoles(routes: AppRouteRecord[], roles: string[]) {
  const hasRole = (route: AppRouteRecord) => {
    const routeRoles = (route.meta?.roles as string[] | undefined) || [];
    return routeRoles.length === 0 || routeRoles.some(role => roles.includes(role));
  };

  const filterRoutes = (items: AppRouteRecord[]): AppRouteRecord[] => {
    return items.filter(hasRole).map(route => {
      const filteredRoute: AppRouteRecord = { ...route };
      if (route.children) {
        filteredRoute.children = filterRoutes(route.children as AppRouteRecord[]);
      }
      return filteredRoute;
    });
  };

  return filterRoutes(routes);
}

export function getCacheRouteNames(routes: RouteRecordRaw[]) {
  return flattenRoutes(routes)
    .filter(route => route.name)
    .filter(route => Boolean(route.meta?.keepAlive))
    .map(route => String(route.name) as RouteKey);
}

export function getSelectedMenuKeyPathByKey(routeName: RouteKey, menus: App.Global.Menu[]) {
  const path: string[] = [];

  const dfs = (items: App.Global.Menu[], parents: string[]): boolean => {
    for (const item of items) {
      const currentPath = [...parents, item.key];
      if (item.key === routeName || item.routeKey === routeName) {
        path.push(...currentPath);
        return true;
      }
      if (item.children?.length && dfs(item.children, currentPath)) {
        return true;
      }
    }
    return false;
  };

  dfs(menus, []);
  return path;
}

export function getBreadcrumbsByRoute(
  route: RouteLocationNormalizedLoaded,
  menus: App.Global.Menu[],
  routeMap: Map<RouteKey, RouteRecordRaw>
) {
  const routeName = String((route.meta?.activeMenu as string) || route.name || '');
  const keyPath = getSelectedMenuKeyPathByKey(routeName as RouteKey, menus);
  const searchMenus = transformMenuToSearchMenus(menus);

  function getBreadcrumbOptions(index: number, menu: App.Global.Menu) {
    if (menu.children?.length) {
      return menu.children;
    }

    if (index === 0) {
      return menus.filter(item => item.key !== menu.key);
    }

    const parentKey = keyPath[index - 1];
    const parentMenu = searchMenus.find(item => item.key === parentKey || item.routeKey === parentKey);

    return (parentMenu?.children || []).filter(item => item.key !== menu.key);
  }

  const breadcrumbs: App.Global.Menu[] = [];

  keyPath.forEach((key, index) => {
    const menu = searchMenus.find(item => item.key === key || item.routeKey === key);
    if (!menu) return;

    const options = getBreadcrumbOptions(index, menu);

    breadcrumbs.push({
      ...menu,
      routePath: routeMap.get(menu.routeKey)?.path || menu.routePath,
      children: options.map(option => ({
        ...option,
        routePath: routeMap.get(option.routeKey)?.path || option.routePath
      }))
    });
  });

  return breadcrumbs;
}
