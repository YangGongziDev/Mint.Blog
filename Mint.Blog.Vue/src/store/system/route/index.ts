import { computed, nextTick, ref, shallowRef } from 'vue';
import type { RouteRecordRaw } from 'vue-router';
import { defineStore } from 'pinia';
import type { AppRouteRecord, MenuModuleKey, RouteKey } from '@/router/types';
import { createStaticRoutes, router } from '@/router';
import { menuOptionsByModule } from '@/menu';
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

  function setRoutes(nextRoutes: RouteRecordRaw[]) {
    routes.value = [...nextRoutes];
  }

  const removeRouteFns: (() => void)[] = [];

  const menuRecords = shallowRef<AppMenuRecord[]>([]);
  const currentMenuModule = ref<MenuModuleKey>('frontdesk');
  const menus = ref<App.Global.Menu[]>([]);
  const selectedMenuKey = computed(() => {
    const routeName = String(router.currentRoute.value.meta.activeMenu || router.currentRoute.value.name || '');
    return getSelectedMenuKeyPathByKey(routeName as RouteKey, menus.value).at(-1) || routeName;
  });
  const searchMenus = computed(() => transformMenuToSearchMenus(menus.value));
  const routeMap = computed(() => createRouteMap(routes.value));

  function getGlobalMenus() {
    const menuTree = buildMenuTreeByRecords(menuRecords.value);
    menus.value = buildMenusByMenuTree(menuTree, routeMap.value);
  }

  function updateGlobalMenusByLocale() {
    menus.value = updateLocaleOfGlobalMenus(menus.value);
  }

  const cacheRoutes = ref<RouteKey[]>([]);
  const excludeCacheRoutes = ref<RouteKey[]>([]);

  function getCacheRoutes(nextRoutes: RouteRecordRaw[]) {
    cacheRoutes.value = getCacheRouteNames(nextRoutes);
  }

  async function resetRouteCache(routeKey?: RouteKey) {
    const routeName = routeKey || (router.currentRoute.value.name as RouteKey);

    excludeCacheRoutes.value.push(routeName);

    await nextTick();

    excludeCacheRoutes.value = [];
  }

  const breadcrumbs = computed(() => getBreadcrumbsByRoute(router.currentRoute.value, menus.value, routeMap.value));

  async function resetStore(path?: string) {
    setIsRouteReady(false);
    setRoutes([]);
    menuRecords.value = [];
    currentMenuModule.value = 'frontdesk';
    menus.value = [];
    cacheRoutes.value = [];
    excludeCacheRoutes.value = [];
    resetVueRoutes();

    await initAuthRoute(path);
  }

  function resetVueRoutes() {
    removeRouteFns.forEach(fn => fn());
    removeRouteFns.length = 0;
  }

  function getMenuModuleByPath(path = router.currentRoute.value.path): MenuModuleKey {
    return router.resolve(path).meta.menuModule || 'frontdesk';
  }

  function initStaticMenuRecords(path = router.currentRoute.value.path) {
    const module = getMenuModuleByPath(path);

    if (currentMenuModule.value === module && menuRecords.value.length) return false;

    currentMenuModule.value = module;
    menuRecords.value = menuOptionsByModule[module] || [];

    return true;
  }

  async function initAuthRoute(path?: string) {
    if (isRouteReady.value) return;

    if (!authStore.userInfo.userId) {
      await authStore.initUserInfo();
    }

    const staticRoutes = createStaticRoutes();
    const filteredRoutes = filterAuthRoutesByRoles(staticRoutes as AppRouteRecord[], authStore.userInfo.roles);

    setRoutes(filteredRoutes);
    initStaticMenuRecords(path);
    handleRoutes();
    setIsRouteReady(true);
    tabStore.initHomeTab(path);
  }

  function handleRoutes() {
    resetVueRoutes();
    addRoutesToVueRouter(routes.value);
    getGlobalMenus();
    getCacheRoutes(routes.value);
  }

  function addRoutesToVueRouter(nextRoutes: RouteRecordRaw[]) {
    nextRoutes.forEach(route => {
      const removeFn = router.addRoute(route);
      addRemoveRouteFn(removeFn);
    });
  }

  function addRemoveRouteFn(fn: () => void) {
    removeRouteFns.push(fn);
  }

  async function getIsAuthRouteExist(routePath: string) {
    const allRoutes = flattenRoutes(createStaticRoutes());

    return allRoutes.some(route => route.path === routePath || `/${route.path}` === routePath);
  }

  function onRouteSwitchWhenNotLoggedIn(path?: string) {
    if (initStaticMenuRecords(path)) {
      getGlobalMenus();
    }

    tabStore.initHomeTab(path);
  }

  function onRouteSwitchWhenLoggedIn(path?: string) {
    if (!isRouteReady.value) {
      return;
    }

    if (initStaticMenuRecords(path)) {
      getGlobalMenus();
    }

    tabStore.initHomeTab(path);
  }

  return {
    isRouteReady,
    routes,
    menus,
    selectedMenuKey,
    searchMenus,
    cacheRoutes,
    excludeCacheRoutes,
    breadcrumbs,
    setRoutes,
    updateGlobalMenusByLocale,
    resetRouteCache,
    resetStore,
    initAuthRoute,
    onRouteSwitchWhenNotLoggedIn,
    onRouteSwitchWhenLoggedIn,
    getIsAuthRouteExist,
    getGlobalMenus,
    getSelectedMenuKeyPath: (routeName: RouteKey) => getSelectedMenuKeyPathByKey(routeName, menus.value),
    getRouteNamePath: (routeName: RouteKey) => getSelectedMenuKeyPathByKey(routeName, menus.value)
  };
});
