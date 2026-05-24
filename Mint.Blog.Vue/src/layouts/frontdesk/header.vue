<script setup lang="ts">
import { useFullscreen } from '@vueuse/core';
import { GLOBAL_HEADER_MENU_ID } from '@/constants/app';
import { useAppStore } from '@/store/system/app';
import { useThemeStore } from '@/store/system/theme';
import { useRouterPush } from '@/hooks/routing/use-router-push';
import { $t } from '@/locales';
import Breadcrumb from '@/layouts/frontdesk/breadcrumb.vue';
import SurferSearchInput from '@/components/blog/surfer/search-input.vue';

defineOptions({
  name: 'SurferHeader'
});

interface Props {
  showLogo?: App.Global.HeaderProps['showLogo'];
  showMenuToggler?: App.Global.HeaderProps['showMenuToggler'];
  showMenu?: App.Global.HeaderProps['showMenu'];
}

defineProps<Props>();

const appStore = useAppStore();
const themeStore = useThemeStore();
const { isFullscreen, toggle } = useFullscreen();
const { routerPushByKey } = useRouterPush();

function openV1() {
  window.open('https://v1.yangmufa.cn/surfer/home', '_blank', 'noopener,noreferrer');
}
</script>

<template>
  <DarkModeContainer class="h-full flex items-center px-[8px] sm:px-[12px] shadow-header">
    <RouterLink
      v-if="showLogo"
      to="/blog/surfer/home"
      class="h-full flex items-center shrink-0 overflow-hidden"
      :class="[appStore.isMobile ? 'justify-start' : 'justify-center']"
      :style="{ width: appStore.isMobile ? 'auto' : themeStore.sider.width + 'px' }"
    >
      <SystemLogo class="h-[34px] w-[34px] sm:h-[38px] sm:w-[38px] shrink-0" />
      <h2 class="pl-[6px] sm:pl-[8px] text-[18px] sm:text-[21px] text-primary font-bold transition duration-300 ease-in-out truncate">
        {{ $t('system.title') }}
      </h2>
    </RouterLink>
    <MenuToggler v-if="showMenuToggler" :collapsed="appStore.siderCollapse" @click="appStore.toggleSiderCollapse" />

    <div class="h-full min-w-0 flex flex-1 items-center overflow-hidden">
      <div v-if="!appStore.isMobile && !showMenu" class="ml-[12px] mr-[12px] flex-shrink-0 overflow-hidden">
        <Breadcrumb />
      </div>
      <div
        v-if="showMenu"
        :id="GLOBAL_HEADER_MENU_ID"
        class="h-full min-w-0 flex flex-1 items-center overflow-hidden pb-[1px]"
      ></div>
    </div>

    <div class="h-full flex items-center justify-end gap-[4px] sm:gap-2 shrink-0">
      <SurferSearchInput :is-mobile="appStore.isMobile" />
      <!-- <ButtonIcon
        v-if="!appStore.isMobile"
        size-class="text-icon-large"
        icon="mdi:history"
        tooltip-content="V1版本"
        @click="openV1"
      /> -->
      <ButtonIcon
        size-class="text-icon-large"
        icon="mdi:view-dashboard-outline"
        tooltip-content="去后台"
        @click="routerPushByKey('blog-admin_home')"
      />
      <FullScreen v-if="!appStore.isMobile" :full="isFullscreen" @click="toggle" />
      <LangSwitch :lang="appStore.locale" :lang-options="appStore.localeOptions" @change-lang="appStore.changeLocale" />
      <ThemeSchemaSwitch
        :theme-schema="themeStore.themeScheme"
        :is-dark="themeStore.darkMode"
        @switch="themeStore.toggleThemeScheme"
      />
      <ButtonIcon
        size-class="text-icon-large"
        icon="majesticons:color-swatch-line"
        :tooltip-content="$t('icon.themeConfig')"
        class="mr-[-5px]"
        @click="appStore.openThemeDrawer"
      />
    </div>
  </DarkModeContainer>
</template>

<style scoped lang="scss">
:deep(.ant-btn) {
  border: 1px solid transparent !important;
}

@media (max-width: 639px) {
  :deep(.ant-btn) {
    padding: 0 5px !important;
  }
}
</style>
