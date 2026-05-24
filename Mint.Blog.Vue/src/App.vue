<template>
  <ConfigProvider :theme="themeStore.antdTheme" :locale="antdLocale">
    <AppProvider>
      <RouterView class="bg-layout" />
      <AWatermark
        v-if="themeStore.watermark.visible"
        v-bind="watermarkProps"
        class="pointer-events-none size-full !absolute !left-0 !top-0"
      />
    </AppProvider>
  </ConfigProvider>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { ConfigProvider } from 'ant-design-vue';
import type { WatermarkProps } from 'ant-design-vue';
import { useAppStore } from '@/store/system/app';
import { useThemeStore } from '@/store/system/theme';
import { antdLocales } from './locales/antd';

defineOptions({
  name: 'App'
});  

const appStore = useAppStore();
const themeStore = useThemeStore();

const antdLocale = computed(() => {
  return antdLocales[appStore.locale];
});  

const watermarkProps = computed(() => {
  const props: WatermarkProps = {
    content: themeStore.watermark.text,
    width: 120,
    height: 120,
    font: {
      fontSize: 16
    },  
    offset: [12, 60],
    rotate: -15,
    zIndex: 9999
  };  

  return props;
});  
</script>

<style scoped lang="scss">

</style>
