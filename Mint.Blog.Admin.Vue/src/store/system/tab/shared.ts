import type { Router } from 'vue-router';
import type { RouteKey } from '@/router/types';
import { $t } from '@/locales';
import { menuOptions } from '@/menu';

export function getAllTabs(tabs: App.Global.Tab[], homeTab?: App.Global.Tab) {
  if (!homeTab) {
    return [];
  }

  const filterHomeTabs = tabs.filter(tab => tab.id !== homeTab.id);
  const fixedTabs = filterHomeTabs.filter(isFixedTab).sort((a, b) => a.fixedIndex! - b.fixedIndex!);
  const remainTabs = filterHomeTabs.filter(tab => !isFixedTab(tab));

  return updateTabsLabel([homeTab, ...fixedTabs, ...remainTabs]);
}

function isFixedTab(tab: App.Global.Tab) {
  return tab.fixedIndex !== undefined && tab.fixedIndex !== null;
}

export function getTabIdByRoute(route: App.Global.TabRoute) {
  const { path, query = {}, meta } = route;

  let id = path;

  if (meta.multiTab) {
    const queryKeys = Object.keys(query).sort();
    const qs = queryKeys.map(key => `${key}=${query[key]}`).join('&');

    id = `${path}?${qs}`;
  }

  return id;
}

export function getTabByRoute(route: App.Global.TabRoute) {
  const { name, path, fullPath = path, meta } = route;
  const { title, i18nKey, fixedIndexInTab } = meta;
  const menuDisplay = getMenuDisplayByRoute(routeNameFromRoute(route), activeMenuFromRoute(route));
  const routeDisplay = getRouteDisplay(route);
  const label = (i18nKey ? $t(i18nKey) : title) || menuDisplay?.label || '无标题';

  const tab: App.Global.Tab = {
    id: getTabIdByRoute(route),
    label,
    routeKey: name as RouteKey,
    routePath: String(path),
    fullPath,
    fixedIndex: fixedIndexInTab,
    icon: menuDisplay?.icon || routeDisplay.icon,
    localIcon: routeDisplay.localIcon,
    i18nKey
  };

  return tab;
}

function routeNameFromRoute(route: App.Global.TabRoute) {
  return String(route.name);
}

function activeMenuFromRoute(route: App.Global.TabRoute) {
  return (route.meta?.activeMenu as string | null) || null;
}

function getMenuDisplayByRoute(routeName: string, activeMenu: string | null) {
  const targetKey = activeMenu || routeName;
  const menu = menuOptions.find(item => item.routerName === targetKey);

  if (!menu) {
    return null;
  }

  return {
    label: menu.menuI18nKey ? $t(menu.menuI18nKey) : '无标题',
    menuI18nKey: menu.menuI18nKey,
    icon: menu.icon || 'mdi:menu'
  };
}

function getRouteDisplay(route: App.Global.TabRoute) {
  let icon: string = route?.meta?.icon || 'mdi:menu';
  let localIcon: string | undefined = route?.meta?.localIcon;

  if (route.matched) {
    const currentRoute = route.matched.find(r => r.name === route.name);
    icon = currentRoute?.meta?.icon || icon;
    localIcon = currentRoute?.meta?.localIcon;
  }

  return { icon, localIcon };
}

export function getDefaultHomeTab(router: Router, homeRouteName: RouteKey) {
  const i18nLabel = $t(`route.${homeRouteName}`);
  const routes = router.getRoutes();
  const homeRoute = routes.find(route => route.name === homeRouteName);
  const homeRoutePath = homeRoute?.path || `/${homeRouteName}`;

  let homeTab: App.Global.Tab = {
    id: homeRoutePath,
    label: i18nLabel || homeRouteName,
    routeKey: homeRouteName,
    routePath: homeRoutePath,
    fullPath: homeRoutePath
  };

  if (homeRoute) {
    homeTab = getTabByRoute(homeRoute);
  }

  return homeTab;
}

export function isTabInTabs(tabId: string, tabs: App.Global.Tab[]) {
  return tabs.some(tab => tab.id === tabId);
}

export function filterTabsById(tabId: string, tabs: App.Global.Tab[]) {
  return tabs.filter(tab => tab.id !== tabId);
}

export function filterTabsByIds(tabIds: string[], tabs: App.Global.Tab[]) {
  return tabs.filter(tab => !tabIds.includes(tab.id));
}

export function findTabByRouteName(routeName: RouteKey, tabs: App.Global.Tab[]) {
  return tabs.find(tab => tab.routeKey === routeName);
}

export function extractTabsByAllRoutes(router: Router, tabs: App.Global.Tab[]) {
  const routes = router.getRoutes();
  const routeMap = new Map(routes.filter(route => route.name).map(route => [String(route.name), route]));

  return tabs
    .filter(tab => routeMap.has(tab.routeKey))
    .map(tab => {
      const route = routeMap.get(tab.routeKey)!;
      const menuDisplay = getMenuDisplayByRoute(
        String(tab.routeKey),
        (route.meta?.activeMenu as string | null) || null
      );

      const routeI18nKey = route.meta?.i18nKey;
      const routeLabel = routeI18nKey ? $t(routeI18nKey) : route.meta?.title;

      return {
        ...tab,
        label: tab.newLabel || tab.oldLabel || routeLabel || menuDisplay?.label || tab.label,
        icon: menuDisplay?.icon || tab.icon,
        i18nKey: routeI18nKey || tab.i18nKey
      };
    });
}

export function getFixedTabs(tabs: App.Global.Tab[]) {
  return tabs.filter(tab => tab.fixedIndex !== undefined);
}

export function getFixedTabIds(tabs: App.Global.Tab[]) {
  return getFixedTabs(tabs).map(tab => tab.id);
}

function updateTabsLabel(tabs: App.Global.Tab[]) {
  return tabs.map(tab => ({
    ...tab,
    label: tab.newLabel || tab.oldLabel || tab.label
  }));
}

export function updateTabByI18nKey(tab: App.Global.Tab) {
  const menuDisplay = getMenuDisplayByRoute(String(tab.routeKey), null);
  const { i18nKey } = tab;

  if (!i18nKey) {
    return {
      ...tab,
      icon: menuDisplay?.icon || tab.icon
    };
  }

  const nextLabel = $t(i18nKey);

  return {
    ...tab,
    oldLabel: tab.newLabel ? nextLabel : undefined,
    label: nextLabel,
    icon: menuDisplay?.icon || tab.icon,
    i18nKey
  };
}

export function updateTabsByI18nKey(tabs: App.Global.Tab[]) {
  return tabs.map(updateTabByI18nKey);
}
