<template>
  <template v-if="blank">
    <RouterView v-slot="{ Component, route }">
      <Transition
        :name="transitionName"
        mode="out-in"
        @before-leave="appStore.setContentXScrollable(true)"
        @after-leave="resetScroll"
        @after-enter="appStore.setContentXScrollable(false)"
      >
        <KeepAlive :include="routeStore.cacheRoutes" :exclude="routeStore.excludeCacheRoutes">
          <component
            :is="Component"
            v-if="appStore.reloadFlag"
            :key="tabStore.getTabIdByRoute(route)"
            class="flex-grow bg-layout transition duration-300"
            :class="{ 'p-[16px]': showPadding }"
          />
        </KeepAlive>
      </Transition>
    </RouterView>
  </template>

  <div v-else class="relative h-full" :class="commonClass" :style="cssVars">
    <div
      :id="isWrapperScroll ? scrollElId : undefined"
      class="h-full flex flex-col"
      :class="[commonClass, { 'overflow-y-auto': isWrapperScroll }]"
    >
      <template v-if="showHeader">
        <header
          v-show="!fullContent"
          class="flex-shrink-0"
          :class="[
            $style['layout-header'],
            commonClass,
            headerLeftGapClass,
            { 'absolute top-0 left-0 w-full': fixedHeaderAndTab }
          ]"
        >
          <Header v-bind="headerProps" />
        </header>
        <div
          v-show="!fullContent && fixedHeaderAndTab"
          class="flex-shrink-0 overflow-hidden"
          :class="$style['layout-header-placement']"
        ></div>
      </template>

      <template v-if="showTab">
        <div
          class="flex-shrink-0"
          :class="[
            $style['layout-tab'],
            commonClass,
            { '!top-0': fullContent || !showHeader },
            leftGapClass,
            { 'absolute left-0 w-full': fixedHeaderAndTab }
          ]"
        >
          <Tab />
        </div>
        <div
          v-show="fullContent || fixedHeaderAndTab"
          class="flex-shrink-0 overflow-hidden"
          :class="$style['layout-tab-placement']"
        ></div>
      </template>

      <template v-if="showSider">
        <aside
          v-show="!fullContent"
          class="absolute left-0 top-0 h-full"
          :class="[
            commonClass,
            siderPaddingClass,
            appStore.siderCollapse ? $style['layout-sider_collapsed'] : $style['layout-sider']
          ]"
        >
          <Sider />
        </aside>
      </template>

      <template v-if="showMobileSider">
        <aside
          class="absolute left-0 top-0 h-full w-0 bg-white"
          :class="[
            commonClass,
            $style['layout-mobile-sider'],
            appStore.siderCollapse ? 'overflow-hidden' : $style['layout-sider']
          ]"
        >
          <Sider />
        </aside>
        <div
          v-show="!appStore.siderCollapse"
          class="absolute left-0 top-0 h-full w-full bg-[rgba(0,0,0,0.2)]"
          :class="$style['layout-mobile-sider-mask']"
          @click="appStore.siderCollapse = true"
        ></div>
      </template>

      <main
        :id="isContentScroll ? scrollElId : undefined"
        class="flex flex-col flex-grow"
        :class="[commonClass, contentClass, leftGapClass, { 'overflow-y-auto': isContentScroll }]"
      >
        <Menu :key="menuRenderKey" />
        <RouterView v-slot="{ Component, route }">
          <Transition
            :name="transitionName"
            mode="out-in"
            @before-leave="appStore.setContentXScrollable(true)"
            @after-leave="resetScroll"
            @after-enter="appStore.setContentXScrollable(false)"
          >
            <KeepAlive :include="routeStore.cacheRoutes" :exclude="routeStore.excludeCacheRoutes">
              <component
                :is="Component"
                v-if="appStore.reloadFlag"
                :key="tabStore.getTabIdByRoute(route)"
                class="flex-grow bg-layout transition duration-300"
                :class="{ 'p-[16px]': showPadding }"
              />
            </KeepAlive>
          </Transition>
        </RouterView>
      </main>
    </div>

    <ThemeDrawer />
  </div>
</template>

<script setup lang="ts">
import { computed, defineAsyncComponent, nextTick, ref, useCssModule, watch } from 'vue';
import { useRouter } from 'vue-router';
import { useAppStore } from '@/store/system/app';
import { useThemeStore } from '@/store/system/theme';
import { useRouteStore } from '@/store/system/route';
import { useTabStore } from '@/store/system/tab';
import Header from '@/layouts/backstage/header.vue';
import Sider from '@/layouts/backstage/sider.vue';
import Tab from '@/layouts/backstage/tab-bar.vue';
import ThemeDrawer from '@/layouts/backstage/theme-drawer.vue';

defineOptions({
  name: 'AdminIndex'
});

type LayoutMode = 'horizontal' | 'vertical';

interface Props {
  showPadding?: boolean;
  blank?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  showPadding: true,
  blank: false
});

const LAYOUT_SCROLL_EL_ID = '__SCROLL_EL_ID__';
const LAYOUT_MAX_Z_INDEX = 100;

const style = useCssModule();
const appStore = useAppStore();
const themeStore = useThemeStore();
const routeStore = useRouteStore();
const tabStore = useTabStore();
const router = useRouter();

watch(router.currentRoute, () => {
  if (appStore.isMobile) {
    appStore.setSiderCollapse(true);
  }
});

watch(
  () => appStore.isMobile,
  isMobile => {
    appStore.setSiderCollapse(isMobile);
  },
  { flush: 'post' }
);

const Menu = defineAsyncComponent(() => import('@/layouts/backstage/menu.vue'));
const menuRenderKey = ref(0);

watch(
  () => [appStore.isMobile, themeStore.layout.mode, themeStore.layout.reverseHorizontalMix, routeStore.menus.length],
  async () => {
    await nextTick();
    menuRenderKey.value += 1;
  },
  { flush: 'post' }
);

const blank = computed(() => props.blank || Boolean(router.currentRoute.value.meta.blank));
const showPadding = computed(() => props.showPadding);
const selectedKey = computed(() => routeStore.selectedMenuKey || '');
const activeFirstLevelMenuKey = computed(() => {
  if (!selectedKey.value) return '';

  return routeStore.getSelectedMenuKeyPath(selectedKey.value).at(0) || selectedKey.value;
});
const childLevelMenus = computed<App.Global.Menu[]>(() => {
  return routeStore.menus.find(menu => menu.key === activeFirstLevelMenuKey.value)?.children || [];
});
const isActiveFirstLevelMenuHasChildren = computed(() => {
  return Boolean(
    activeFirstLevelMenuKey.value &&
    routeStore.menus.find(item => item.key === activeFirstLevelMenuKey.value)?.children?.length
  );
});
const layoutMode = computed<LayoutMode>(() =>
  themeStore.layout.mode.includes('vertical') ? 'vertical' : 'horizontal'
);
const transitionName = computed(() => (themeStore.page.animate ? themeStore.page.animateMode : ''));
const scrollElId = LAYOUT_SCROLL_EL_ID;
const commonClass = 'transition-all-300';
const fullContent = computed(() => appStore.fullContent);
const showHeader = computed(() => true);
const showTab = computed(() => themeStore.tab.visible);
const showSider = computed(() => !appStore.isMobile && themeStore.layout.mode !== 'horizontal');
const showMobileSider = computed(() => appStore.isMobile);
const isWrapperScroll = computed(() => themeStore.layout.scrollMode === 'wrapper');
const isContentScroll = computed(() => themeStore.layout.scrollMode === 'content');
const isVertical = computed(() => layoutMode.value === 'vertical');
const isHorizontal = computed(() => layoutMode.value === 'horizontal');
const fixedHeaderAndTab = computed(() => themeStore.fixedHeaderAndTab || (isHorizontal.value && isWrapperScroll.value));
const isVerticalMix = computed(() => themeStore.layout.mode === 'vertical-mix');
const isHorizontalMix = computed(() => themeStore.layout.mode === 'horizontal-mix');
const contentClass = computed(() => (appStore.contentXScrollable ? 'overflow-x-hidden' : ''));

const headerProps = computed(() => {
  const { mode, reverseHorizontalMix } = themeStore.layout;

  const config: Record<UnionKey.ThemeLayoutMode, App.Global.HeaderProps> = {
    vertical: { showLogo: false, showMenu: false, showMenuToggler: true },
    'vertical-mix': { showLogo: false, showMenu: false, showMenuToggler: false },
    horizontal: {
      showLogo: true,
      showMenu: !appStore.isMobile,
      showMenuToggler: appStore.isMobile
    },
    'horizontal-mix': {
      showLogo: true,
      showMenu: true,
      showMenuToggler: reverseHorizontalMix && isActiveFirstLevelMenuHasChildren.value
    }
  };

  return config[mode];
});

const siderWidth = computed(() => {
  const { reverseHorizontalMix } = themeStore.layout;
  const { width, mixWidth, mixChildMenuWidth } = themeStore.sider;

  if (isHorizontalMix.value && reverseHorizontalMix) {
    return isActiveFirstLevelMenuHasChildren.value ? width : 0;
  }

  let widthValue = isVerticalMix.value || isHorizontalMix.value ? mixWidth : width;

  if (isVerticalMix.value && appStore.mixSiderFixed && childLevelMenus.value.length) {
    widthValue += mixChildMenuWidth;
  }

  return widthValue;
});

const siderCollapsedWidth = computed(() => {
  const { reverseHorizontalMix } = themeStore.layout;
  const { collapsedWidth, mixCollapsedWidth, mixChildMenuWidth } = themeStore.sider;

  if (isHorizontalMix.value && reverseHorizontalMix) {
    return isActiveFirstLevelMenuHasChildren.value ? collapsedWidth : 0;
  }

  let widthValue = isVerticalMix.value || isHorizontalMix.value ? mixCollapsedWidth : collapsedWidth;

  if (isVerticalMix.value && appStore.mixSiderFixed && childLevelMenus.value.length) {
    widthValue += mixChildMenuWidth;
  }

  return widthValue;
});

const cssVars = computed(() => ({
  '--soy-header-height': `${themeStore.header.height}px`,
  '--soy-header-z-index': LAYOUT_MAX_Z_INDEX - 3,
  '--soy-tab-height': `${themeStore.tab.height}px`,
  '--soy-tab-z-index': LAYOUT_MAX_Z_INDEX - 5,
  '--soy-sider-width': `${siderWidth.value}px`,
  '--soy-sider-collapsed-width': `${siderCollapsedWidth.value}px`,
  '--soy-sider-z-index':
    layoutMode.value === 'vertical' || appStore.isMobile ? LAYOUT_MAX_Z_INDEX - 1 : LAYOUT_MAX_Z_INDEX - 4,
  '--soy-mobile-sider-z-index': appStore.isMobile ? LAYOUT_MAX_Z_INDEX - 2 : 0
}));

const leftGapClass = computed(() => {
  if (!fullContent.value && showSider.value) {
    return appStore.siderCollapse ? style['left-gap_collapsed'] : style['left-gap'];
  }

  return '';
});

const headerLeftGapClass = computed(() => (isVertical.value ? leftGapClass.value : ''));

const siderPaddingClass = computed(() => {
  let cls = '';

  if (showHeader.value && !headerLeftGapClass.value) {
    cls += style['sider-padding-top'];
  }

  return cls.trim();
});

function resetScroll() {
  const el = document.querySelector(`#${LAYOUT_SCROLL_EL_ID}`);
  el?.scrollTo({ left: 0, top: 0 });
}
</script>

<style module>
.layout-header,
.layout-header-placement {
  height: var(--soy-header-height);
}

.layout-header {
  z-index: var(--soy-header-z-index);
}

.layout-tab {
  top: var(--soy-header-height);
  height: var(--soy-tab-height);
  z-index: var(--soy-tab-z-index);
}

.layout-tab-placement {
  height: var(--soy-tab-height);
}

.layout-sider {
  width: var(--soy-sider-width);
  z-index: var(--soy-sider-z-index);
}

.layout-mobile-sider {
  z-index: var(--soy-sider-z-index);
}

.layout-mobile-sider-mask {
  z-index: var(--soy-mobile-sider-z-index);
}

.layout-sider_collapsed {
  width: var(--soy-sider-collapsed-width);
  z-index: var(--soy-sider-z-index);
}

.left-gap {
  padding-left: var(--soy-sider-width);
}

.left-gap_collapsed {
  padding-left: var(--soy-sider-collapsed-width);
}

.sider-padding-top {
  padding-top: var(--soy-header-height);
}
</style>
