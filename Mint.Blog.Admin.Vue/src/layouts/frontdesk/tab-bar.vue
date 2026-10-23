<template>
  <DarkModeContainer class="size-full flex items-center px-[16px] shadow-tab">
    <div ref="bsWrapper" class="h-full min-w-0 flex-1 overflow-hidden">
      <BetterScroll ref="bsScroll" :options="{ scrollX: true, scrollY: false, click: !isPCFlag }" @click="removeFocus">
        <div
          ref="tabRef"
          class="h-full flex pr-[18px]"
          :class="[themeStore.tab.mode === 'chrome' ? 'items-end' : 'items-center gap-[12px]']"
        >
          <ADropdown
            v-for="tab in tabStore.tabs"
            :key="tab.id"
            :trigger="['contextmenu']"
            placement="bottom"
            destroy-popup-on-hide
          >
            <div :[TAB_DATA_ID]="tab.id" @click="handleClickTab(tab)">
              <component
                :is="activeTabComponent(themeStore.tab.mode)"
                :active="tab.id === tabStore.activeTabId"
                :dark-mode="themeStore.darkMode"
                :style="cssVars"
              >
                <SvgIcon
                  :icon="tab.icon"
                  :local-icon="tab.localIcon"
                  class="inline-block align-text-bottom text-[16px]"
                />
                <ATooltip :title="tab.label" placement="bottom">
                  <div class="max-w-[240px] truncate">{{ tab.label }}</div>
                </ATooltip>
                <SvgClose v-if="!tabStore.isTabRetain(tab.id)" @click="handleCloseTab(tab)" />
              </component>
            </div>
            <template #overlay>
              <AMenu>
                <AMenuItem
                  v-for="option in getContextMenuOptions(tab.id)"
                  :key="option.key"
                  :disabled="option.disabled"
                  @click="dropdownAction[option.key](tab.id)"
                >
                  <div class="flex items-center gap-[12px]">
                    <SvgIcon :icon="option.icon" class="text-icon" />
                    <span>{{ option.label }}</span>
                  </div>
                </AMenuItem>
              </AMenu>
            </template>
          </ADropdown>
        </div>
      </BetterScroll>
    </div>
    <ATooltip :title="$t('icon.reload')" placement="bottom">
      <AButton type="text" class="h-[36px] text-icon" @click="refresh">
        <div class="flex items-center justify-center gap-[8px]">
          <icon-ant-design-reload-outlined
            class="text-icon"
            :class="[{ 'animate-spin animate-duration-750': !appStore.reloadFlag }]"
          />
        </div>
      </AButton>
    </ATooltip>
    <FullScreen :full="appStore.fullContent" @click="appStore.toggleFullContent" />
  </DarkModeContainer>
</template>

<script setup lang="ts">
import { computed, defineComponent, h, nextTick, ref, useCssModule, watch } from 'vue';
import type { Component } from 'vue';
import { useRoute } from 'vue-router';
import { useElementBounding } from '@vueuse/core';
import { useAppStore } from '@/store/system/app';
import { useThemeStore } from '@/store/system/theme';
import { useRouteStore } from '@/store/system/route';
import { useTabStore } from '@/store/system/tab';
import { $t } from '@/locales';
import { isPC } from '@/utils/agent';
import { addColorAlpha, transformColorWithOpacity } from '@/utils/color';
import BetterScroll from '@/components/system/better-scroll.vue';

defineOptions({
  name: 'TabBar'
});

type PageTabMode = 'button' | 'chrome';

interface DropdownOption {
  key: App.Global.DropdownKey;
  label: string;
  icon: string;
  disabled?: boolean;
}

const style = useCssModule();
const route = useRoute();
const appStore = useAppStore();
const themeStore = useThemeStore();
const routeStore = useRouteStore();
const tabStore = useTabStore();

const bsWrapper = ref<HTMLElement>();
const { width: bsWrapperWidth, left: bsWrapperLeft } = useElementBounding(bsWrapper);
const bsScroll = ref<InstanceType<typeof BetterScroll>>();
const tabRef = ref<HTMLElement>();
const isPCFlag = isPC();

const TAB_DATA_ID = 'data-tab-id';
const ACTIVE_COLOR = '#1890ff';

const baseContextMenuOptions = computed<DropdownOption[]>(() => [
  { key: 'closeCurrent', label: $t('dropdown.closeCurrent'), icon: 'ant-design:close-outlined' },
  { key: 'closeOther', label: $t('dropdown.closeOther'), icon: 'ant-design:column-width-outlined' },
  { key: 'closeLeft', label: $t('dropdown.closeLeft'), icon: 'mdi:format-horizontal-align-left' },
  { key: 'closeRight', label: $t('dropdown.closeRight'), icon: 'mdi:format-horizontal-align-right' },
  { key: 'closeAll', label: $t('dropdown.closeAll'), icon: 'ant-design:line-outlined' }
]);

const cssVars = computed(() => {
  const primaryColor = themeStore.themeColor || ACTIVE_COLOR;

  return {
    '--soy-primary-color': primaryColor,
    '--soy-primary-color1': transformColorWithOpacity(primaryColor, 0.1, '#ffffff'),
    '--soy-primary-color2': transformColorWithOpacity(primaryColor, 0.3, '#000000'),
    '--soy-primary-color-opacity1': addColorAlpha(primaryColor, 0.1),
    '--soy-primary-color-opacity2': addColorAlpha(primaryColor, 0.15),
    '--soy-primary-color-opacity3': addColorAlpha(primaryColor, 0.3),
    '--soy-primary-color-opacity4': addColorAlpha(primaryColor, 0.22),
    '--soy-primary-color-opacity5': addColorAlpha(primaryColor, 0.18)


    // --soy-primary-color: #646cff;
    // --soy-primary-color1: #f0f0ff;
    // --soy-primary-color2: #1e204d;
    // --soy-primary-color-opacity1: #646cff1a;
    // --soy-primary-color-opacity2: #646cff26;
    // --soy-primary-color-opacity3: #646cff4d;
    // --soy-primary-color-opacity4: #646cff38;
    // --soy-primary-color-opacity5: #646cff2e;
  };
});

type TabNamedNodeMap = NamedNodeMap & {
  [TAB_DATA_ID]: Attr;
};

const ChromeTabBg = defineComponent({
  name: 'ChromeTabBg',
  setup() {
    return () =>
      h('svg', { class: 'size-full' }, [
        h('defs', undefined, [
          h('symbol', { id: 'geometry-left', viewBox: '0 0 214 36' }, [
            h('path', { d: 'M17 0h197v36H0v-2c4.5 0 9-3.5 9-8V8c0-4.5 3.5-8 8-8z' })
          ]),
          h('symbol', { id: 'geometry-right', viewBox: '0 0 214 36' }, [h('use', { 'xlink:href': '#geometry-left' })]),
          h('clipPath', undefined, [h('rect', { width: '100%', height: '100%', x: '0' })])
        ]),
        h('svg', { width: '51%', height: '100%' }, [
          h('use', { 'xlink:href': '#geometry-left', width: '214', height: '36', fill: 'currentColor' })
        ]),
        h('g', { transform: 'scale(-1, 1)' }, [
          h('svg', { width: '51%', height: '100%', x: '-100%', y: '0' }, [
            h('use', { 'xlink:href': '#geometry-right', width: '214', height: '36', fill: 'currentColor' })
          ])
        ])
      ]);
  }
});

const SvgClose = defineComponent({
  name: 'SvgClose',
  emits: ['click'],
  setup(_, { emit }) {
    return () =>
      h(
        'div',
        {
          class: ['relative inline-flex h-[16px] w-[16px] items-center justify-center rounded-[50%] text-[14px]', style['svg-close']],
          onClick: (event: MouseEvent) => {
            event.stopPropagation();
            emit('click');
          }
        },
        [
          h('svg', { width: '1em', height: '1em', viewBox: '0 0 1024 1024' }, [
            h('path', {
              fill: 'currentColor',
              d: 'm563.8 512l262.5-312.9c4.4-5.2.7-13.1-6.1-13.1h-79.8c-4.7 0-9.2 2.1-12.3 5.7L511.6 449.8L295.1 191.7c-3-3.6-7.5-5.7-12.3-5.7H203c-6.8 0-10.5 7.9-6.1 13.1L459.4 512L196.9 824.9A7.95 7.95 0 0 0 203 838h79.8c4.7 0 9.2-2.1 12.3-5.7l216.5-258.1l216.5 258.1c3 3.6 7.5 5.7 12.3 5.7h79.8c6.8 0 10.5-7.9 6.1-13.1L563.8 512z'
            })
          ])
        ]
      );
  }
});

const ButtonTab = defineComponent({
  name: 'ButtonTab',
  props: { active: Boolean, darkMode: Boolean },
  setup(componentProps, { slots }) {
    return () =>
      h(
        'div',
        {
          class: [
            'relative inline-flex cursor-pointer items-center justify-center gap-[12px] whitespace-nowrap border border-solid rounded-[4px] px-[12px] py-[4px]',
            style['button-tab'],
            { [style['button-tab_dark']]: componentProps.darkMode },
            { [style['button-tab_active']]: componentProps.active },
            { [style['button-tab_active_dark']]: componentProps.active && componentProps.darkMode }
          ]
        },
        [slots.default?.()]
      );
  }
});

const ChromeTab = defineComponent({
  name: 'ChromeTab',
  props: { active: Boolean, darkMode: Boolean },
  setup(componentProps, { slots }) {
    return () =>
      h(
        'div',
        {
          class: [
            'relative inline-flex cursor-pointer items-center justify-center gap-[6px] whitespace-nowrap px-[16px] py-[6px] -mr-[18px]',
            style['chrome-tab'],
            { [style['chrome-tab_dark']]: componentProps.darkMode },
            { [style['chrome-tab_active']]: componentProps.active },
            { [style['chrome-tab_active_dark']]: componentProps.active && componentProps.darkMode }
          ]
        },
        [
          h('div', { class: ['pointer-events-none absolute left-0 top-0 h-full w-full -z-[1]', style['chrome-tab__bg']] }, [h(ChromeTabBg)]),
          slots.default?.(),
          h('div', { class: ['absolute right-[7px] h-[16px] w-[1px] bg-[#1f2225]', style['chrome-tab-divider']] })
        ]
      );
  }
});

function activeTabComponent(mode: PageTabMode): Component {
  return mode === 'chrome' ? ChromeTab : ButtonTab;
}

function getContextMenuDisabledKeys(tabId: string) {
  const disabledKeys: App.Global.DropdownKey[] = [];

  if (tabStore.isTabRetain(tabId)) {
    disabledKeys.push('closeCurrent', 'closeLeft');
  }

  return disabledKeys;
}

function getContextMenuOptions(tabId: string) {
  const disabledKeys = getContextMenuDisabledKeys(tabId);

  return baseContextMenuOptions.value.map(option => ({
    ...option,
    disabled: disabledKeys.includes(option.key)
  }));
}

async function scrollToActiveTab() {
  await nextTick();
  if (!tabRef.value) return;

  const { children } = tabRef.value;

  for (let i = 0; i < children.length; i += 1) {
    const child = children[i];
    const { value: tabId } = (child.attributes as TabNamedNodeMap)[TAB_DATA_ID];

    if (tabId === tabStore.activeTabId) {
      const { left, width } = child.getBoundingClientRect();
      const clientX = left + width / 2;

      setTimeout(() => scrollByClientX(clientX), 50);
      break;
    }
  }
}

function scrollByClientX(clientX: number) {
  const currentX = clientX - bsWrapperLeft.value;
  const deltaX = currentX - bsWrapperWidth.value / 2;

  if (bsScroll.value?.instance) {
    const { maxScrollX, x: leftX, scrollBy } = bsScroll.value.instance;
    const rightX = maxScrollX - leftX;
    const update = deltaX > 0 ? Math.max(-deltaX, rightX) : Math.min(-deltaX, -leftX);

    scrollBy(update, 0, 300);
  }
}

async function handleClickTab(tab: App.Global.Tab) {
  await tabStore.switchRouteByTab(tab);
}

async function handleCloseTab(tab: App.Global.Tab) {
  await tabStore.removeTab(tab.id);

  if (themeStore.resetCacheStrategy === 'close') {
    routeStore.resetRouteCache(tab.routeKey);
  }
}

function refresh() {
  window.location.reload();
}

function removeFocus() {
  (document.activeElement as HTMLElement)?.blur();
}

tabStore.initTabStore(route);

const dropdownAction: Record<App.Global.DropdownKey, (tabId: string) => void> = {
  closeCurrent(tabId) {
    tabStore.removeTab(tabId);
  },
  closeOther(tabId) {
    tabStore.clearTabs([tabId]);
  },
  closeLeft(tabId) {
    tabStore.clearLeftTabs(tabId);
  },
  closeRight(tabId) {
    tabStore.clearRightTabs(tabId);
  },
  closeAll() {
    tabStore.clearTabs();
  }
};

watch(
  () => route.fullPath,
  () => {
    tabStore.addTab(route);
  }
);
watch(
  () => [tabStore.tabs.length, tabStore.tabs.map(tab => tab.id).join('|'), themeStore.tab.mode],
  async () => {
    await nextTick();
    bsScroll.value?.instance?.refresh();
  },
  { flush: 'post' }
);
watch(
  () => tabStore.activeTabId,
  () => {
    scrollToActiveTab();
  }
);
</script>

<style module>
.button-tab {
  border-color: #e5e7eb;
}
.button-tab_dark {
  border-color: #ffffff3d;
}
.button-tab:hover {
  color: var(--soy-primary-color);
  border-color: var(--soy-primary-color-opacity3);
}
.button-tab_active {
  color: var(--soy-primary-color);
  border-color: var(--soy-primary-color-opacity3);
  background-color: var(--soy-primary-color-opacity1);
}
.button-tab_active_dark {
  background-color: var(--soy-primary-color-opacity2);
}
.button-tab .svg-close:hover {
  font-size: 12px;
  color: #ffffff;
  background-color: var(--soy-primary-color);
}
.button-tab_dark .svg-close:hover {
  color: #000000;
}
.chrome-tab:hover {
  z-index: 9;
}
.chrome-tab_active {
  z-index: 10;
  color: var(--soy-primary-color);
}
.chrome-tab__bg {
  color: transparent;
}
.chrome-tab_active .chrome-tab__bg {
  color: var(--soy-primary-color1);
}
.chrome-tab_active_dark .chrome-tab__bg {
  color: var(--soy-primary-color2);
}
.chrome-tab:hover .chrome-tab__bg {
  color: #dee1e6;
}
.chrome-tab_active:hover .chrome-tab__bg {
  color: var(--soy-primary-color1);
}
.chrome-tab_dark:hover .chrome-tab__bg {
  color: #333333;
}
.chrome-tab_active_dark:hover .chrome-tab__bg {
  color: var(--soy-primary-color2);
}
.chrome-tab .svg-close:hover {
  font-size: 12px;
  color: #ffffff;
  background-color: #9ca3af;
}
.chrome-tab_active .svg-close:hover {
  background-color: var(--soy-primary-color);
}
.chrome-tab_dark .svg-close:hover {
  color: #000000;
}
.chrome-tab_active .chrome-tab-divider {
  opacity: 0;
}
.chrome-tab:hover .chrome-tab-divider {
  opacity: 0;
}
.chrome-tab_dark .chrome-tab-divider {
  background-color: rgba(255, 255, 255, 0.9);
}
</style>
