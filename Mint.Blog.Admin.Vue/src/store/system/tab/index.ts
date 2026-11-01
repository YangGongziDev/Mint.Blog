import { computed, ref } from 'vue';
import { useEventListener } from '@vueuse/core';
import { defineStore } from 'pinia';
import { router } from '@/router';
import { useRouterPush } from '@/hooks/routing/use-router-push';
import { localStg } from '@/utils/storage';
import type { RouteKey } from '@/router/types';
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
  const TAB_STORAGE_KEY = 'globalTabs:main';
  window.localStorage.removeItem('globalTabs:backstage');
  window.localStorage.removeItem('globalTabs:frontdesk');
  localStg.remove('globalTabs');
  const readTabStorage = (): App.Global.Tab[] => {
    const json = window.localStorage.getItem(TAB_STORAGE_KEY);
    if (!json) return [];

    try {
      const stored: unknown = JSON.parse(json);
      return Array.isArray(stored) ? stored : [];
    } catch {
      window.localStorage.removeItem(TAB_STORAGE_KEY);
      return [];
    }
  };

  /** Tabs */
  const tabs = ref<App.Global.Tab[]>([]);

  /** Tab visit order - most recent first, used to determine which tab to activate when closing */
  const tabVisitOrder = ref<string[]>([]);

  /** Get active tab */
  const homeTab = ref<App.Global.Tab>();

  /** Init home tab */
  function initHomeTab() {
    homeTab.value = getDefaultHomeTab(router, 'home');
  }

  function getStoredTabs() {
    if (!themeStore.tab.cache) return [];
    return updateTabsByI18nKey(extractTabsByAllRoutes(router, readTabStorage()));
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
    const order = tabVisitOrder.value.filter(tid => tid !== id);
    tabVisitOrder.value = [id, ...order];
  }

  /**
   * Init tab store
   *
   * @param currentRoute Current route
   */
  function initTabStore(currentRoute: App.Global.TabRoute) {
    initHomeTab();
    tabs.value = getStoredTabs();

    addTab(currentRoute);
  }

  /**
   * Add tab
   *
   * @param route Tab route
   * @param active Whether to activate the added tab
   */
  function addTab(route: App.Global.TabRoute, active = true) {
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

    tabVisitOrder.value = tabVisitOrder.value.filter(id => id !== tabId);

    function update() {
      tabs.value = updatedTabs;
    }

    if (!isRemoveActiveTab) {
      update();
      return;
    }

    const activeTab =
      tabVisitOrder.value.map(id => updatedTabs.find(t => t.id === id)).find(t => t !== undefined) ||
      updatedTabs.at(-1) ||
      homeTab.value;

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

    tabVisitOrder.value = tabVisitOrder.value.filter(id => remainTabIds.includes(id));

    const isRemoveActiveTab = removedTabsIds.includes(activeTabId.value);
    const updatedTabs = filterTabsByIds(removedTabsIds, tabs.value);

    function update() {
      tabs.value = updatedTabs;
    }

    if (!isRemoveActiveTab) {
      update();
      return;
    }

    const activeTab =
      tabVisitOrder.value.map(id => updatedTabs.find(t => t.id === id)).find(t => t !== undefined) ||
      updatedTabs[updatedTabs.length - 1] ||
      homeTab.value;

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

    window.localStorage.setItem(TAB_STORAGE_KEY, JSON.stringify(tabs.value));
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
