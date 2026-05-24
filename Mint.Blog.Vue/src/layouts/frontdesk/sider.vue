<template>
  <DarkModeContainer class="size-full min-h-0 flex flex-col shadow-sider" :inverted="darkMenu">
    <RouterLink
      v-if="showLogo"
      to="/"
      class="w-full flex items-center justify-center overflow-hidden whitespace-nowrap"
      :style="{ height: themeStore.header.height + 'px' }"
    >
      <SystemLogo class="h-[48px] w-[48px]" :style="{ '--lw': '48px', '--lh': '48px' }" />
      <h2
        v-show="!appStore.siderCollapse"
        class="pl-[8px] text-[16px] text-primary font-bold transition duration-300 ease-in-out"
      >
        {{ $t('system.title') }}
      </h2>
    </RouterLink>
    <div :id="GLOBAL_SIDER_MENU_ID" :class="menuWrapperClass"></div>
  </DarkModeContainer>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { GLOBAL_SIDER_MENU_ID } from '@/constants/app';
import { useAppStore } from '@/store/system/app';
import { useThemeStore } from '@/store/system/theme';
import { $t } from '@/locales';

defineOptions({
  name: 'AdminSider'
});

const appStore = useAppStore();
const themeStore = useThemeStore();

const isVerticalMix = computed(() => themeStore.layout.mode === 'vertical-mix');
const isHorizontalMix = computed(() => themeStore.layout.mode === 'horizontal-mix');
const darkMenu = computed(() => !themeStore.darkMode && !isHorizontalMix.value && themeStore.sider.inverted);
const showLogo = computed(() => !isVerticalMix.value && !isHorizontalMix.value);
const menuWrapperClass = computed(() => (showLogo.value ? 'min-w-0 min-h-0 flex-1 overflow-hidden' : 'h-full'));
</script>

<style scoped lang="scss"></style>
