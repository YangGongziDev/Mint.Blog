import { computed, nextTick, ref, shallowRef } from 'vue';
import type { RouteRecordRaw } from 'vue-router';
import { defineStore } from 'pinia';
import type { AppRouteRecord, RouteKey } from '@/router/types';
import { createStaticRoutes, router } from '@/router';
import { menuOptions } from '@/menu';
import type { AppMenuRecord } from '@/menu/types';
import useBoolean from '@/hooks/state/use-boolean';
import { SetupStoreId } from '@/enum';
import { useAuthStore } from '@/store/system/auth';
import { useTabStore } from '@/store/system/tab';
import {
  buildMenuTreeByRecords,
  buildMenusByMenuTree,
  createRouteMap,
  filterAuthRoutesByRoles,
  flattenRoutes,
  getBreadcrumbsByRoute,
  getCacheRouteNames,
  getSelectedMenuKeyPathByKey,
  transformMenuToSearchMenus,
  updateLocaleOfGlobalMenus
} from './shared';

export const useRouteStore = defineStore(SetupStoreId.Route, () => {
  const authStore = useAuthStore();
  const tabStore = useTabStore();
  const { bool: isRouteReady, setBool: setIsRouteReady } = useBoolean();
  const routes = shallowRef<RouteRecordRaw[]>([]);
  const removeRouteFns: (() => void)[] = [];
  const menuRecords = shallowRef<AppMenuRecord[]>([]);
  const menus = ref<App.Global.Menu[]>([]);
  const selectedMenuKey = computed(() => {
    const routeName = String(router.currentRoute.value.meta.activeMenu || router.currentRoute.value.name || '');
    return getSelectedMenuKeyPathByKey(routeName, menus.value).at(-1) || routeName;
  });
  const searchMenus = computed(() => transformMenuToSearchMenus(menus.value));
  const routeMap = computed(() => createRouteMap(routes.value));
  const cacheRoutes = ref<RouteKey[]>([]);
  const excludeCacheRoutes = ref<RouteKey[]>([]);
  const breadcrumbs = computed(() => getBreadcrumbsByRoute(router.currentRoute.value, menus.value, routeMap.value));

  function setRoutes(nextRoutes: RouteRecordRaw[]) {
    routes.value = [...nextRoutes];
  }

  function getGlobalMenus() {
    menus.value = buildMenusByMenuTree(buildMenuTreeByRecords(menuRecords.value), routeMap.value);
  }

  function updateGlobalMenusByLocale() {
    menus.value = updateLocaleOfGlobalMenus(menus.value);
  }

  async function resetRouteCache(routeKey?: RouteKey) {
    excludeCacheRoutes.value.push(routeKey || String(router.currentRoute.value.name));
    await nextTick();
    excludeCacheRoutes.value = [];
  }

  function resetVueRoutes() {
    removeRouteFns.forEach(fn => fn());
    removeRouteFns.length = 0;
  }

  async function resetStore(path?: string) {
    setIsRouteReady(false);
    setRoutes([]);
    menuRecords.value = [];
    menus.value = [];
    cacheRoutes.value = [];
    excludeCacheRoutes.value = [];
    resetVueRoutes();
    await initAuthRoute(path);
  }

  async function initAuthRoute(_path?: string) {
    if (isRouteReady.value) return;
    if (!authStore.userInfo.userId) await authStore.initUserInfo();
    setRoutes(filterAuthRoutesByRoles(createStaticRoutes() as AppRouteRecord[], authStore.userInfo.roles));
    menuRecords.value = menuOptions;
    resetVueRoutes();
    routes.value.forEach(route => removeRouteFns.push(router.addRoute(route)));
    getGlobalMenus();
    cacheRoutes.value = getCacheRouteNames(routes.value);
    setIsRouteReady(true);
    tabStore.initHomeTab();
  }

  async function getIsAuthRouteExist(routePath: string) {
    return flattenRoutes(createStaticRoutes()).some(route => route.path === routePath || `/${route.path}` === routePath);
  }

  function onRouteSwitchWhenNotLoggedIn(_path?: string) {
    tabStore.initHomeTab();
  }

  function onRouteSwitchWhenLoggedIn(_path?: string) {
    if (isRouteReady.value) tabStore.initHomeTab();
  }

  return {
    isRouteReady, routes, menus, selectedMenuKey, searchMenus, cacheRoutes, excludeCacheRoutes, breadcrumbs,
    setRoutes, updateGlobalMenusByLocale, resetRouteCache, resetStore, initAuthRoute,
    onRouteSwitchWhenNotLoggedIn, onRouteSwitchWhenLoggedIn, getIsAuthRouteExist, getGlobalMenus,
    getSelectedMenuKeyPath: (routeName: RouteKey) => getSelectedMenuKeyPathByKey(routeName, menus.value),
    getRouteNamePath: (routeName: RouteKey) => getSelectedMenuKeyPathByKey(routeName, menus.value)
  };
});
