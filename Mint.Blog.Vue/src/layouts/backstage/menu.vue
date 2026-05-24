<template>
  <template v-if="isHorizontal && !appStore.isMobile">
    <Teleport defer :to="`#${GLOBAL_HEADER_MENU_ID}`">
      <AMenu
        mode="horizontal"
        :selected-keys="[selectedKey]"
        :items="routeStore.menus"
        class="horizontal-menu size-full select-none !border-0"
        :class="{ '!bg-container': themeStore.darkMode }"
        :style="{ lineHeight: themeStore.header.height + 'px' }"
        @click="handleClickMenu"
      />
    </Teleport>
  </template>

  <template v-else-if="isHorizontalMix && !themeStore.layout.reverseHorizontalMix">
    <Teleport defer :to="`#${GLOBAL_HEADER_MENU_ID}`">
      <AMenu
        mode="horizontal"
        :selected-keys="[selectedKey]"
        :items="childLevelMenus"
        class="horizontal-menu size-full select-none !border-0"
        :class="{ '!bg-container': themeStore.darkMode }"
        :style="{ lineHeight: themeStore.header.height + 'px' }"
        @click="handleClickMenu"
      />
    </Teleport>
    <Teleport defer :to="`#${GLOBAL_SIDER_MENU_ID}`">
      <div class="h-full min-h-0 min-w-0 flex flex-col flex-1 overflow-hidden">
        <SimpleScrollbar>
          <div
            v-for="menu in allMenus"
            :key="menu.key"
            class="mx-[4px] mb-[6px] flex select-none flex-col cursor-pointer items-center justify-center rounded-[8px] bg-transparent px-[4px] py-[8px] hover:bg-[rgb(0,0,0,0.08)]"
            :class="{
              'text-primary selected-mix-menu': menu.key === activeFirstLevelMenuKey,
              'text-white/65 hover:text-white': inverted,
              '!text-white !bg-primary': menu.key === activeFirstLevelMenuKey && inverted
            }"
            @click="handleSelectHorizontalMixMenu(menu)"
          >
            <component :is="menu.icon" :class="[appStore.siderCollapse ? 'text-icon-small' : 'text-icon-large']" />
            <p
              class="w-full truncate text-center text-[12px] transition-[height] duration-300"
              :class="[appStore.siderCollapse ? 'h-0 pt-0' : 'h-[20px] pt-[4px]']"
            >
              {{ menu.label }}
            </p>
          </div>
        </SimpleScrollbar>
        <MenuToggler
          arrow-icon
          :collapsed="appStore.siderCollapse"
          :z-index="99"
          :class="{ 'text-white/88 hover:!text-white': inverted }"
          @click="appStore.toggleSiderCollapse"
        />
      </div>
    </Teleport>
  </template>

  <template v-else-if="isHorizontalMix">
    <Teleport defer :to="`#${GLOBAL_HEADER_MENU_ID}`">
      <AMenu
        mode="horizontal"
        :selected-keys="[activeFirstLevelMenuKey]"
        :items="firstLevelMenus"
        class="horizontal-menu size-full select-none !border-0"
        :class="{ '!bg-container': themeStore.darkMode }"
        :style="{ lineHeight: themeStore.header.height + 'px' }"
        @click="handleSelectReversedMixMenu"
      />
    </Teleport>
    <Teleport defer :to="`#${GLOBAL_SIDER_MENU_ID}`">
      <SimpleScrollbar>
        <AMenu
          mode="inline"
          :items="childLevelMenus"
          :selected-keys="[selectedKey]"
          :open-keys="openKeys"
          :inline-collapsed="appStore.siderCollapse"
          :inline-indent="18"
          class="size-full select-none !border-0"
          :class="{ '!bg-container': themeStore.darkMode }"
          @click="handleClickMenu"
        />
      </SimpleScrollbar>
    </Teleport>
  </template>

  <template v-else-if="isVerticalMix">
    <Teleport defer :to="`#${GLOBAL_SIDER_MENU_ID}`">
      <div class="h-full flex" @mouseleave="drawerVisible = false">
        <div class="h-full min-h-0 min-w-0 flex flex-col flex-1 overflow-hidden">
          <RouterLink
            to="/blog/admin/home"
            class="w-full flex items-center justify-center overflow-hidden whitespace-nowrap"
            :style="{ height: themeStore.header.height + 'px' }"
          >
            <SystemLogo class="h-[48px] w-[48px]" :style="{ '--lw': '48px', '--lh': '48px' }" />
          </RouterLink>
          <SimpleScrollbar>
            <div
              v-for="menu in allMenus"
              :key="menu.key"
              class="mx-[4px] mb-[6px] flex select-none flex-col cursor-pointer items-center justify-center rounded-[8px] bg-transparent px-[4px] py-[8px] hover:bg-[rgb(0,0,0,0.08)]"
              :class="{
                'text-primary selected-mix-menu': menu.key === activeFirstLevelMenuKey,
                'text-white/65 hover:text-white': inverted,
                '!text-white !bg-primary': menu.key === activeFirstLevelMenuKey && inverted
              }"
              @click="handleSelectVerticalMixMenu(menu)"
            >
              <component :is="menu.icon" :class="[appStore.siderCollapse ? 'text-icon-small' : 'text-icon-large']" />
              <p
                class="w-full truncate text-center text-[12px] transition-[height] duration-300"
                :class="[appStore.siderCollapse ? 'h-0 pt-0' : 'h-[20px] pt-[4px]']"
              >
                {{ menu.label }}
              </p>
            </div>
          </SimpleScrollbar>
          <MenuToggler
            arrow-icon
            :collapsed="appStore.siderCollapse"
            :z-index="99"
            :class="{ 'text-white/88 hover:!text-white': inverted }"
            @click="appStore.toggleSiderCollapse"
          />
        </div>
        <div
          class="relative h-full transition-[width] duration-300"
          :style="{ width: appStore.mixSiderFixed && hasChildMenus ? themeStore.sider.mixChildMenuWidth + 'px' : '0px' }"
        >
          <DarkModeContainer
            class="absolute left-0 top-0 h-full min-h-0 flex flex-col overflow-hidden whitespace-nowrap shadow-sm transition-[width] duration-300"
            :inverted="inverted"
            :style="{ width: showDrawer ? themeStore.sider.mixChildMenuWidth + 'px' : '0px' }"
          >
            <header class="flex items-center justify-between px-[12px]" :style="{ height: themeStore.header.height + 'px' }">
              <h2 class="text-[28px] text-primary font-bold">{{ $t('system.title') }}</h2>
              <PinToggler
                :pin="appStore.mixSiderFixed"
                :class="{ 'text-white/88 hover:!text-white': inverted }"
                @click="appStore.toggleMixSiderFixed"
              />
            </header>
            <SimpleScrollbar class="menu-wrapper" :class="{ 'select-menu': !inverted }">
              <AMenu
                mode="inline"
                :theme="menuTheme"
                :items="childLevelMenus"
                :selected-keys="[selectedKey]"
                :open-keys="openKeys"
                class="size-full select-none !border-0"
                :class="{ '!bg-container': !inverted }"
                @click="handleClickMenu"
              />
            </SimpleScrollbar>
          </DarkModeContainer>
        </div>
      </div>
    </Teleport>
  </template>

  <template v-else>
    <Teleport defer :to="`#${GLOBAL_SIDER_MENU_ID}`">
      <SimpleScrollbar class="menu-wrapper" :class="{ 'select-menu': !darkTheme }">
        <AMenu
          mode="inline"
          :theme="menuTheme"
          :items="routeStore.menus"
          :selected-keys="[selectedKey]"
          :open-keys="openKeys"
          :inline-collapsed="appStore.siderCollapse"
          :inline-indent="18"
          :style="menuStyle"
          class="size-full select-none !border-0"
          :class="{ '!bg-container': !darkTheme }"
          @click="handleClickMenu"
        />
      </SimpleScrollbar>
    </Teleport>
  </template>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue';
import type { MenuInfo } from 'ant-design-vue/es/menu/src/interface';
import { GLOBAL_HEADER_MENU_ID, GLOBAL_SIDER_MENU_ID } from '@/constants/app';
import { useAppStore } from '@/store/system/app';
import { useThemeStore } from '@/store/system/theme';
import { useRouteStore } from '@/store/system/route';
import { useRouterPush } from '@/hooks/routing/use-router-push';
import { transformColorWithOpacity } from '@/utils/color';
import { $t } from '@/locales';
import SimpleScrollbar from '@/components/system/simple-scrollbar.vue';

defineOptions({
  name: 'BackstageMenu'
});

const appStore = useAppStore();
const themeStore = useThemeStore();
const routeStore = useRouteStore();
const { routerPushByMenu, routerPushByMenuKey } = useRouterPush();
const drawerVisible = ref(false);

const selectedKey = computed(() => routeStore.selectedMenuKey || '');
const allMenus = computed<App.Global.Menu[]>(() => routeStore.menus);
const activeFirstLevelMenuKey = computed(() => {
  if (!selectedKey.value) return '';

  return routeStore.getSelectedMenuKeyPath(selectedKey.value).at(0) || selectedKey.value;
});
const childLevelMenus = computed<App.Global.Menu[]>(() => {
  return routeStore.menus.find(menu => menu.key === activeFirstLevelMenuKey.value)?.children || [];
});
const firstLevelMenus = computed<App.Global.Menu[]>(() =>
  routeStore.menus.map(menu => Object.fromEntries(Object.entries(menu).filter(([key]) => key !== 'children')) as App.Global.Menu)
);
const isActiveFirstLevelMenuHasChildren = computed(() => {
  if (!activeFirstLevelMenuKey.value) return false;

  const findItem = routeStore.menus.find(item => item.key === activeFirstLevelMenuKey.value);
  return Boolean(findItem?.children?.length);
});

const isHorizontal = computed(() => themeStore.layout.mode === 'horizontal');
const isHorizontalMix = computed(() => themeStore.layout.mode === 'horizontal-mix');
const isVerticalMix = computed(() => themeStore.layout.mode === 'vertical-mix');
const inverted = computed(() => !themeStore.darkMode && themeStore.sider.inverted);
const darkTheme = computed(() => !themeStore.darkMode && themeStore.sider.inverted);
const menuTheme = computed(() => (darkTheme.value ? 'dark' : 'light'));
const hasChildMenus = computed(() => childLevelMenus.value.length > 0);
const showDrawer = computed(() => hasChildMenus.value && (drawerVisible.value || appStore.mixSiderFixed));
const openKeys = computed(() => {
  if (appStore.siderCollapse || !selectedKey.value) return [];
  return routeStore.getSelectedMenuKeyPath(selectedKey.value);
});
const menuStyle = computed(() => {
  if (appStore.siderCollapse) {
    return { width: `${themeStore.sider.collapsedWidth}px` };
  }

  return { width: '100%' };
});
const selectedBgColor = computed(() => {
  const { darkMode, themeColor } = themeStore;
  const light = transformColorWithOpacity(themeColor, 0.1, '#ffffff');
  const dark = transformColorWithOpacity(themeColor, 0.3, '#000000');

  return darkMode ? dark : light;
});

function handleClickMenu(menuInfo: MenuInfo) {
  routerPushByMenuKey(String(menuInfo.key));
}

function handleSelectHorizontalMixMenu(menu: App.Global.Menu) {
  if (!menu.children?.length) {
    routerPushByMenu(menu);
  }
}

function handleSelectVerticalMixMenu(menu: App.Global.Menu) {
  if (menu.children?.length) {
    drawerVisible.value = true;
  } else {
    routerPushByMenu(menu);
  }
}

function handleSelectReversedMixMenu(menuInfo: MenuInfo) {
  const key = String(menuInfo.key);

  if (!isActiveFirstLevelMenuHasChildren.value) {
    routerPushByMenuKey(key);
  }
}
</script>

<style scoped lang="scss">
.menu-wrapper {
  :deep(.ant-menu-inline) {
    .ant-menu-item {
      width: calc(100% - 16px);
      margin-inline: 8px;
    }
  }

  :deep(.ant-menu-submenu-title) {
    width: calc(100% - 16px);
    margin-inline: 8px;
  }

  :deep(.ant-menu-inline-collapsed) {
    width: 100% !important;

    > .ant-menu-item {
      padding-inline: calc(50% - 14px);
    }

    .ant-menu-item-icon {
      vertical-align: -0.25em;
    }

    .ant-menu-submenu-title {
      padding-inline: calc(50% - 18px);
    }
  }
}

.select-menu,
.selected-mix-menu {
  --selected-bg-color: v-bind(selectedBgColor);
}

.select-menu {
  :deep(.ant-menu-inline) {
    .ant-menu-item-selected {
      background-color: var(--selected-bg-color);
    }
  }
}

.selected-mix-menu {
  background-color: var(--selected-bg-color);
}

.horizontal-menu {
  :deep(.ant-menu-horizontal) {
    .ant-menu-item,
    .ant-menu-submenu-title {
      display: flex;
      align-items: center;
    }
  }
}
:global(.ant-menu),
:global(.ant-menu-submenu-popup) {
  user-select: none;
}
</style>
