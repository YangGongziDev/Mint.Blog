import { computed, ref } from 'vue';
import { useEventListener } from '@vueuse/core';
import { defineStore } from 'pinia';
import type { MenuModuleKey, RouteKey } from '@/router/types';
import { router } from '@/router';
import { useRouterPush } from '@/hooks/routing/use-router-push';
import { localStg } from '@/utils/storage';
import { SetupStoreId } from '@/enum';
import { useThemeStore } from '../theme';
import {
  extractTabsByAllRoutes,
  filterTabsById,
  filterTabsByIds,
  findTabByRouteName,
  getAllTabs,
  getDefaultHomeTab,
  getFixedTabIds,
  getTabByRoute,
  getTabIdByRoute,
  isTabInTabs,
  updateTabByI18nKey,
  updateTabsByI18nKey
} from './shared';

export const useTabStore = defineStore(SetupStoreId.Tab, () => {
  const themeStore = useThemeStore();
  const { routerPush } = useRouterPush(false);
  type TabModule = MenuModuleKey;
  const LEGACY_TAB_STORAGE_KEY = 'globalTabs';
  const tabStorageKey = (module: TabModule) => `${LEGACY_TAB_STORAGE_KEY}:${module}`;
  const readTabStorage = (module: TabModule): App.Global.Tab[] => {
    const json = window.localStorage.getItem(tabStorageKey(module));
    if (!json) return [];

    try {
      return JSON.parse(json) as App.Global.Tab[];
    } catch {
      window.localStorage.removeItem(tabStorageKey(module));
      return [];
    }
  };
  const writeTabStorage = (module: TabModule, nextTabs: App.Global.Tab[]) => {
    window.localStorage.setItem(tabStorageKey(module), JSON.stringify(nextTabs));
  };
  const getTabModuleByPath = (path = router.currentRoute.value.path): TabModule => router.resolve(path).meta.menuModule || 'frontdesk';
  const isTabInModule = (tab: App.Global.Tab, module: TabModule) => getTabModuleByPath(tab.routePath) === module;
  const homeRouteByModule: Record<TabModule, RouteKey> = {
    backstage: 'blog-admin_home',
    frontdesk: 'blog-surfer_home'
  };
  const currentTabModule = ref<TabModule>(getTabModuleByPath());

  /** Tabs */
  const tabs = ref<App.Global.Tab[]>([]);

  /** Get active tab */
  const homeTab = ref<App.Global.Tab>();

  /** Init home tab */
  function initHomeTab(path = router.currentRoute.value.path) {
    currentTabModule.value = getTabModuleByPath(path);
    const nextHomeRoute = homeRouteByModule[currentTabModule.value] || 'blog-surfer_home';

    homeTab.value = getDefaultHomeTab(router, nextHomeRoute);
    tabs.value = tabs.value.filter(tab => isTabInModule(tab, currentTabModule.value));
  }

  function getStoredTabs(module: TabModule) {
    const storageTabs = readTabStorage(module);

    if (!themeStore.tab.cache || !storageTabs) return [];

    return updateTabsByI18nKey(
      extractTabsByAllRoutes(router, storageTabs).filter(tab => isTabInModule(tab, module))
    );
  }

  /** Get all tabs */
  const allTabs = computed(() => getAllTabs(tabs.value, homeTab.value));

  /** Active tab id */
  const activeTabId = ref<string>('');

  /**
   * Set active tab id
   *
   * @param id Tab id
   */
  function setActiveTabId(id: string) {
    activeTabId.value = id;
  }

  /**
   * Init tab store
   *
   * @param currentRoute Current route
   */
  function initTabStore(currentRoute: App.Global.TabRoute) {
    const module = getTabModuleByPath(currentRoute.path);
    currentTabModule.value = module;
    tabs.value = getStoredTabs(module);

    addTab(currentRoute);
  }

  /**
   * Add tab
   *
   * @param route Tab route
   * @param active Whether to activate the added tab
   */
  function addTab(route: App.Global.TabRoute, active = true) {
    const module = getTabModuleByPath(route.path);

    if (module !== currentTabModule.value) {
      cacheTabs();
      currentTabModule.value = module;
      tabs.value = getStoredTabs(module);
      initHomeTab(route.path);
    }

    const tab = getTabByRoute(route);

    const isHomeTab = tab.id === homeTab.value?.id;

    if (!isHomeTab && !isTabInTabs(tab.id, tabs.value)) {
      tabs.value.push(tab);
    }

    if (active) {
      setActiveTabId(tab.id);
    }
  }

  /**
   * Remove tab
   *
   * @param tabId Tab id
   */
  async function removeTab(tabId: string) {
    const isRemoveActiveTab = activeTabId.value === tabId;
    const updatedTabs = filterTabsById(tabId, tabs.value);

    function update() {
      tabs.value = updatedTabs;
    }

    if (!isRemoveActiveTab) {
      update();
      return;
    }

    const activeTab = updatedTabs.at(-1) || homeTab.value;

    if (activeTab) {
      await switchRouteByTab(activeTab);
      update();
    }
  }

  /** remove active tab */
  async function removeActiveTab() {
    await removeTab(activeTabId.value);
  }

  /**
   * remove tab by route name
   *
   * @param routeName route name
   */
  async function removeTabByRouteName(routeName: RouteKey) {
    const tab = findTabByRouteName(routeName, tabs.value);
    if (!tab) return;

    await removeTab(tab.id);
  }

  /**
   * Clear tabs
   *
   * @param excludes Exclude tab ids
   */
  async function clearTabs(excludes: string[] = []) {
    const remainTabIds = [...getFixedTabIds(tabs.value), ...excludes];
    const removedTabsIds = tabs.value.map(tab => tab.id).filter(id => !remainTabIds.includes(id));

    const isRemoveActiveTab = removedTabsIds.includes(activeTabId.value);
    const updatedTabs = filterTabsByIds(removedTabsIds, tabs.value);

    function update() {
      tabs.value = updatedTabs;
    }

    if (!isRemoveActiveTab) {
      update();
      return;
    }

    const activeTab = updatedTabs[updatedTabs.length - 1] || homeTab.value;

    await switchRouteByTab(activeTab);
    update();
  }

  /**
   * Switch route by tab
   *
   * @param tab
   */
  async function switchRouteByTab(tab: App.Global.Tab) {
    const fail = await routerPush(tab.fullPath);
    if (!fail) {
      setActiveTabId(tab.id);
    }
  }

  /**
   * Clear left tabs
   *
   * @param tabId
   */
  async function clearLeftTabs(tabId: string) {
    const tabIds = tabs.value.map(tab => tab.id);
    const index = tabIds.indexOf(tabId);
    if (index === -1) return;

    const excludes = tabIds.slice(index);
    await clearTabs(excludes);
  }

  /**
   * Clear right tabs
   *
   * @param tabId
   */
  async function clearRightTabs(tabId: string) {
    const isHomeTab = tabId === homeTab.value?.id;
    if (isHomeTab) {
      clearTabs();
      return;
    }

    const tabIds = tabs.value.map(tab => tab.id);
    const index = tabIds.indexOf(tabId);
    if (index === -1) return;

    const excludes = tabIds.slice(0, index + 1);
    await clearTabs(excludes);
  }

  /**
   * Set new label of tab
   *
   * @default activeTabId
   * @param label New tab label
   * @param tabId Tab id
   */
  function setTabLabel(label: string, tabId?: string) {
    const id = tabId || activeTabId.value;

    const tab = tabs.value.find(item => item.id === id);
    if (!tab) return;

    tab.oldLabel = tab.label;
    tab.newLabel = label;
  }

  /**
   * Reset tab label
   *
   * @default activeTabId
   * @param tabId Tab id
   */
  function resetTabLabel(tabId?: string) {
    const id = tabId || activeTabId.value;

    const tab = tabs.value.find(item => item.id === id);
    if (!tab) return;

    tab.newLabel = undefined;
  }

  /**
   * Is tab retain
   *
   * @param tabId
   */
  function isTabRetain(tabId: string) {
    if (tabId === homeTab.value?.id) return true;

    const fixedTabIds = getFixedTabIds(tabs.value);

    return fixedTabIds.includes(tabId);
  }

  /** Update tabs by locale */
  function updateTabsByLocale() {
    tabs.value = updateTabsByI18nKey(tabs.value);

    if (homeTab.value) {
      homeTab.value = updateTabByI18nKey(homeTab.value);
    }
  }

  /** Cache tabs */
  function cacheTabs() {
    if (!themeStore.tab.cache) return;

    writeTabStorage(
      currentTabModule.value,
      tabs.value.filter(tab => isTabInModule(tab, currentTabModule.value))
    );
    localStg.remove(LEGACY_TAB_STORAGE_KEY);
  }

  // cache tabs when page is closed or refreshed
  useEventListener(window, 'beforeunload', () => {
    cacheTabs();
  });

  return {
    /** All tabs */
    tabs: allTabs,
    activeTabId,
    initHomeTab,
    initTabStore,
    addTab,
    removeTab,
    removeActiveTab,
    removeTabByRouteName,
    clearTabs,
    clearLeftTabs,
    clearRightTabs,
    switchRouteByTab,
    setTabLabel,
    resetTabLabel,
    isTabRetain,
    updateTabsByLocale,
    getTabIdByRoute,
    cacheTabs
  };
});
