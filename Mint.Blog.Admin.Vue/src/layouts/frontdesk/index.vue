<template>
  <template v-if="blank">
    <RouterView />
  </template>

  <div v-else class="relative h-full" :class="commonClass" :style="cssVars">
    <div
      :id="isWrapperScroll ? scrollElId : undefined"
      class="h-full flex flex-col overscroll-contain"
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
        ref="mainRef"
        class="flex flex-col flex-grow overflow-x-hidden overscroll-contain"
        :class="[commonClass, contentClass, leftGapClass, { 'overflow-y-auto': isContentScroll }]"
      >
        <Menu :key="menuRenderKey" />
        <div class="flex-1">
          <RouterView />
        </div>
        <footer v-if="showFooter" v-show="!fullContent" class="flex-shrink-0" :class="commonClass">
          <Footer />
        </footer>
      </main>

      <FloatingTools v-show="!fullContent" />

      <div
        v-if="showFooter && !fullContent && footerAnimalsVisible"
        class="fixed-footer-animals pointer-events-none fixed inset-x-0 bottom-0 z-[30] flex justify-center"
      >
        <div class="fixed-footer-animals-wrap mx-auto flex w-full max-w-[1200px] justify-center">
          <img src="@/assets/blog/surfer/footer/animals.png" alt="" class="fixed-footer-animals-img" />
        </div>
      </div>
    </div>

    <ThemeDrawer />
  </div>
</template>

<script setup lang="ts">
import { computed, defineAsyncComponent, nextTick, onBeforeUnmount, onMounted, ref, useCssModule, watch } from 'vue';
import { useRouter } from 'vue-router';
import { useAppStore } from '@/store/system/app';
import { useRouteStore } from '@/store/system/route';
import { useThemeStore } from '@/store/system/theme';
import { useBannerImage } from '@/hooks/blog/use-banner-image';
import bannerDefaultImg from '@/assets/blog/surfer/article-banner/banner-default.jpg';
import Footer from '@/layouts/frontdesk/footer.vue';
import Header from '@/layouts/frontdesk/header.vue';
import Sider from '@/layouts/frontdesk/sider.vue';
import Tab from '@/layouts/frontdesk/tab-bar.vue';
import ThemeDrawer from '@/layouts/frontdesk/theme-drawer.vue';
import FloatingTools from '@/components/blog/surfer/floating-tools.vue';

defineOptions({
  name: 'ModernIndex'
});

type LayoutMode = 'horizontal' | 'vertical';

interface Props {
  blank?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  blank: false
});

const LAYOUT_SCROLL_EL_ID = '__SCROLL_EL_ID__';
const LAYOUT_MAX_Z_INDEX = 100;
const BANNER_PRELOAD_ROUTE_NAMES = new Set(['blog-surfer_home', 'blog-surfer_article_detail', 'blog-surfer_friend']);
const bannerImages = Object.values(
  import.meta.glob('@/assets/blog/surfer/article-banner/*.{png,jpg,jpeg,webp,avif,gif}', {
    eager: true,
    import: 'default'
  })
) as string[];

const style = useCssModule();
const appStore = useAppStore();
const themeStore = useThemeStore();
const routeStore = useRouteStore();
const router = useRouter();
const mainRef = ref<HTMLElement>();
const footerAnimalsVisible = ref(true);
const { schedulePreloadAfterRender: scheduleBannerPreloadAfterRender, stopPreload: stopBannerPreload } = useBannerImage(
  {
    images: bannerImages,
    fallbackImage: bannerDefaultImg,
    storageNamespace: 'blog-surfer:layout-banner-preload'
  }
);
let footerAnimalsObserver: IntersectionObserver | null = null;
let scrollRoot: HTMLElement | null = null;

function updateFooterAnimalsVisibleByScroll() {
  const root = scrollRoot || mainRef.value;
  const footerAnimalsEl = document.querySelector('[data-footer-animals]');
  if (!root || !footerAnimalsEl) return;

  const rootRect = root.getBoundingClientRect();
  const animalRect = footerAnimalsEl.getBoundingClientRect();
  const isPageAnimalInViewport = animalRect.top < rootRect.bottom && animalRect.bottom > rootRect.top;

  footerAnimalsVisible.value = !isPageAnimalInViewport;
}

function setupFooterAnimalsObserver() {
  footerAnimalsObserver?.disconnect();

  nextTick(() => {
    const footerAnimalsEl = document.querySelector('[data-footer-animals]');
    const root = mainRef.value;
    scrollRoot?.removeEventListener('scroll', updateFooterAnimalsVisibleByScroll);
    scrollRoot = root || null;

    if (!footerAnimalsEl || !root) {
      footerAnimalsVisible.value = true;
      return;
    }

    root.addEventListener('scroll', updateFooterAnimalsVisibleByScroll, { passive: true });

    footerAnimalsObserver = new IntersectionObserver(
      () => {
        updateFooterAnimalsVisibleByScroll();
      },
      {
        root,
        rootMargin: '0px',
        threshold: [0, 0.1, 0.5, 1]
      }
    );

    footerAnimalsObserver.observe(footerAnimalsEl);
    updateFooterAnimalsVisibleByScroll();
  });
}

function preloadBannerImages() {
  const routeName = String(router.currentRoute.value.name || '');
  if (!BANNER_PRELOAD_ROUTE_NAMES.has(routeName)) scheduleBannerPreloadAfterRender();
}

watch(router.currentRoute, async () => {
  if (appStore.isMobile) {
    appStore.siderCollapse = true;
  }

  await nextTick();
  document.getElementById(LAYOUT_SCROLL_EL_ID)?.scrollTo({ top: 0, left: 0 });
  window.scrollTo({ top: 0, left: 0 });
  setupFooterAnimalsObserver();
  preloadBannerImages();
});

onMounted(() => {
  setupFooterAnimalsObserver();
  preloadBannerImages();
});

onBeforeUnmount(() => {
  footerAnimalsObserver?.disconnect();
  scrollRoot?.removeEventListener('scroll', updateFooterAnimalsVisibleByScroll);
  stopBannerPreload();
});

const Menu = defineAsyncComponent(() => import('@/layouts/frontdesk/menu.vue'));
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
const scrollElId = LAYOUT_SCROLL_EL_ID;
const commonClass = 'transition-all-300';
const fullContent = computed(() => appStore.fullContent);
const fixedFooter = computed(() => themeStore.footer.fixed);
const showHeader = computed(() => true);
const showTab = computed(() => themeStore.tab.visible);
const showSider = computed(() => !appStore.isMobile && themeStore.layout.mode !== 'horizontal');
const showMobileSider = computed(() => appStore.isMobile);
const showFooter = computed(() => themeStore.footer.visible);
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
  '--soy-mobile-sider-z-index': appStore.isMobile ? LAYOUT_MAX_Z_INDEX - 2 : 0,
  '--soy-footer-height': '0px',
  '--soy-footer-z-index': LAYOUT_MAX_Z_INDEX - 5
}));

const leftGapClass = computed(() => {
  if (!fullContent.value && showSider.value) {
    return appStore.siderCollapse ? style['left-gap_collapsed'] : style['left-gap'];
  }

  return '';
});

const headerLeftGapClass = computed(() => (isVertical.value ? leftGapClass.value : ''));

const footerLeftGapClass = computed(() => {
  const needLeftGap =
    isVertical.value ||
    (isHorizontal.value && isWrapperScroll.value && !fixedFooter.value) ||
    (isHorizontal.value && themeStore.footer.right);

  return needLeftGap ? leftGapClass.value : '';
});

const siderPaddingClass = computed(() => {
  let cls = '';

  if (showHeader.value && !headerLeftGapClass.value) {
    cls += style['sider-padding-top'];
  }

  if (showFooter.value && !footerLeftGapClass.value) {
    cls += ` ${style['sider-padding-bottom']}`;
  }

  return cls.trim();
});
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

.layout-footer,
.layout-footer-placement {
  height: var(--soy-footer-height);
}

.layout-footer {
  z-index: var(--soy-footer-z-index);
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

.sider-padding-bottom {
  padding-bottom: var(--soy-footer-height);
}
</style>

<style>
.fixed-footer-animals {
  transform: translateY(0);
}

.fixed-footer-animals::after {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 60%;
  background: linear-gradient(to top, rgb(var(--layout-bg-color)), transparent);
  content: '';
}

.fixed-footer-animals-wrap {
  position: relative;
  z-index: 40;
}

.fixed-footer-animals-img {
  position: relative;
  z-index: 40;
  width: min(660px, 72vw);
  height: auto;
}

@media (max-width: 767px) {
  .fixed-footer-animals {
    transform: translateY(0);
  }

  .fixed-footer-animals::after {
    bottom: 0;
  }

  .fixed-footer-animals-img {
    width: min(330px, 82vw);
  }
}

.horizontal-menu .ant-menu {
  font-size: 15.5px;
}

.horizontal-menu .ant-menu-submenu-title {
  display: inline-flex !important;
  align-items: center !important;
  margin-right: 17px !important;
}

.horizontal-menu .ant-menu-submenu-arrow {
  display: inline-flex !important;
  position: absolute !important;
  right: -20px !important;
  top: 50% !important;
  font-size: 11.5px;
  transform: translateY(-50%) rotate(0deg);
  opacity: 0.5;
  transition:
    transform 0.25s ease,
    opacity 0.2s;
}

.horizontal-menu .ant-menu-submenu-open > .ant-menu-submenu-title > .ant-menu-submenu-arrow {
  opacity: 0.8;
  transform: translateY(-50%) rotate(90deg);
}
</style>
