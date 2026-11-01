<template>
  <ADrawer :open="appStore.themeDrawerVisible" :title="$t('theme.themeDrawerTitle')" :closable="false" :body-style="{ padding: '0px' }" @close="appStore.closeThemeDrawer">
    <template #extra><ButtonIcon icon="ant-design:close-outlined" class="h-[28px]" @click="appStore.closeThemeDrawer" /></template>
    <SimpleScrollbar>
      <div class="px-[24px] pb-[24px] pt-[8px]">
        <ADivider>{{ $t('theme.themeSchema.title') }}</ADivider>
        <div class="flex flex-col gap-[16px]">
          <ASegmented :value="themeStore.themeScheme" :options="schemaOptions" @change="value => themeStore.setThemeScheme(value as UnionKey.ThemeScheme)">
            <template #label="{ payload }"><div class="w-[70px] flex justify-center"><SvgIcon :icon="payload.icon" class="h-[28px] text-icon-small" /></div></template>
          </ASegmented>
          <Row v-if="!themeStore.darkMode && themeStore.layout.mode.includes('vertical')" :label="$t('theme.sider.inverted')"><ASwitch v-model:checked="themeStore.sider.inverted" /></Row>
          <Row :label="$t('theme.grayscale')"><ASwitch :checked="themeStore.grayscale" @update:checked="value => themeStore.setGrayscale(Boolean(value))" /></Row>
          <Row :label="$t('theme.colourWeakness')"><ASwitch :checked="themeStore.colourWeakness" @update:checked="value => themeStore.setColourWeakness(Boolean(value))" /></Row>
        </div>
        <ADivider>{{ $t('theme.layoutMode.title') }}</ADivider>
        <div class="flex flex-wrap items-center justify-center gap-x-[32px] gap-y-[16px]">
          <ATooltip v-for="mode in layoutModes" :key="mode" placement="bottom" :title="$t(themeLayoutModeRecord[mode])">
            <div class="flex cursor-pointer rounded-[6px]" @click="!appStore.isMobile && themeStore.setThemeLayout(mode)">
              <div class="h-[64px] w-[96px] gap-[6px] rounded-[4px] p-[6px] shadow transition-colors duration-300 dark:shadow-coolGray-5" :class="mode.includes('vertical') ? 'flex' : 'flex flex-col'" :style="{ borderWidth: '2px', borderStyle: 'solid', borderColor: themeStore.layout.mode === mode || hoverMode === mode ? themeStore.themeColor || '#1677ff' : 'transparent' }" @mouseenter="hoverMode = mode" @mouseleave="hoverMode = ''">
                <template v-if="mode.includes('vertical')">
                  <div class="h-full rounded-[4px] bg-[var(--color-primary-300)]" :class="mode === 'vertical' ? 'w-[18px]' : 'w-[8px]'"></div>
                  <div v-if="mode === 'vertical-mix'" class="h-full w-[16px] rounded-[4px] bg-[var(--color-primary-300)]"></div>
                  <div class="flex flex-1 flex-col gap-[6px]"><div class="h-[16px] rounded-[4px] bg-[var(--color-primary)]"></div><div class="flex-1 rounded-[4px] bg-[var(--color-primary-200)]"></div></div>
                </template>
                <template v-else>
                  <div class="h-[16px] rounded-[4px] bg-[var(--color-primary)]"></div>
                  <div class="flex flex-1 gap-[6px]"><div v-if="mode === 'horizontal-mix'" class="w-[18px] rounded-[4px] bg-[var(--color-primary-300)]"></div><div class="flex-1 rounded-[4px] bg-[var(--color-primary-200)]"></div></div>
                </template>
              </div>
            </div>
          </ATooltip>
        </div>
        <Row v-if="themeStore.layout.mode === 'horizontal-mix'" :label="$t('theme.layoutMode.reverseHorizontalMix')" class="mt-[16px]"><ASwitch :checked="themeStore.layout.reverseHorizontalMix" @update:checked="value => themeStore.setLayoutReverseHorizontalMix(Boolean(value))" /></Row>
        <ADivider>{{ $t('theme.themeColor.title') }}</ADivider>
        <div class="flex flex-col gap-[12px]">
          <ATooltip placement="topLeft">
            <template #title><p><span class="pr-[12px]">{{ $t('theme.recommendColorDesc') }}</span><br /><AButton type="link" href="https://uicolors.app/create" target="_blank" class="text-gray">https://uicolors.app/create</AButton></p></template>
            <Row :label="$t('theme.recommendColor')"><ASwitch v-model:checked="themeStore.recommendColor" /></Row>
          </ATooltip>
          <Row v-for="key in colorKeys" :key="key" :label="$t(`theme.themeColor.${key}`)">
            <template #suffix><ACheckbox v-if="key === 'info'" v-model:checked="themeStore.isInfoFollowPrimary">{{ $t('theme.themeColor.followPrimary') }}</ACheckbox></template>
            <ColorPicker :color="themeStore.themeColors[key]" :disabled="key === 'info' && themeStore.isInfoFollowPrimary" @update:color="color => themeStore.updateThemeColors(key, color)" />
          </Row>
        </div>
        <ADivider>{{ $t('theme.pageFunTitle') }}</ADivider>
        <TransitionGroup tag="div" name="setting-list">
          <Row key="0" :label="$t('theme.resetCacheStrategy.title')"><ASelect v-model:value="themeStore.resetCacheStrategy"><ASelectOption v-for="option in resetCacheStrategyOptions" :key="option.value" :value="option.value">{{ $t(option.label) }}</ASelectOption></ASelect></Row>
          <Row key="1" :label="$t('theme.scrollMode.title')"><ASelect v-model:value="themeStore.layout.scrollMode" class="w-[120px]"><ASelectOption v-for="option in themeScrollModeOptions" :key="option.value" :value="option.value">{{ $t(option.label) }}</ASelectOption></ASelect></Row>
          <Row key="1-1" :label="$t('theme.page.animate')"><ASwitch v-model:checked="themeStore.page.animate" /></Row>
          <Row v-if="themeStore.page.animate" key="1-2" :label="$t('theme.page.mode.title')"><ASelect v-model:value="themeStore.page.animateMode" class="w-[120px]"><ASelectOption v-for="option in themePageAnimationModeOptions" :key="option.value" :value="option.value">{{ $t(option.label) }}</ASelectOption></ASelect></Row>
          <Row v-if="isWrapperScrollMode" key="2" :label="$t('theme.fixedHeaderAndTab')"><ASwitch v-model:checked="themeStore.fixedHeaderAndTab" /></Row>
          <Row key="3" :label="$t('theme.header.height')"><AInputNumber v-model:value="themeStore.header.height" class="w-[120px]" /></Row>
          <Row key="4" :label="$t('theme.header.breadcrumb.visible')"><ASwitch v-model:checked="themeStore.header.breadcrumb.visible" /></Row>
          <Row v-if="themeStore.header.breadcrumb.visible" key="4-1" :label="$t('theme.header.breadcrumb.showIcon')"><ASwitch v-model:checked="themeStore.header.breadcrumb.showIcon" /></Row>
          <Row key="5" :label="$t('theme.tab.visible')"><ASwitch v-model:checked="themeStore.tab.visible" /></Row>
          <Row v-if="themeStore.tab.visible" key="5-1" :label="$t('theme.tab.cache')"><ASwitch v-model:checked="themeStore.tab.cache" /></Row>
          <Row v-if="themeStore.tab.visible" key="5-2" :label="$t('theme.tab.height')"><AInputNumber v-model:value="themeStore.tab.height" class="w-[120px]" /></Row>
          <Row v-if="themeStore.tab.visible" key="5-3" :label="$t('theme.tab.mode.title')"><ASelect v-model:value="themeStore.tab.mode" class="w-[120px]"><ASelectOption v-for="option in themeTabModeOptions" :key="option.value" :value="option.value">{{ $t(option.label) }}</ASelectOption></ASelect></Row>
          <Row v-if="layoutMode === 'vertical'" key="6-1" :label="$t('theme.sider.width')"><AInputNumber v-model:value="themeStore.sider.width" class="w-[120px]" /></Row>
          <Row v-if="layoutMode === 'vertical'" key="6-2" :label="$t('theme.sider.collapsedWidth')"><AInputNumber v-model:value="themeStore.sider.collapsedWidth" class="w-[120px]" /></Row>
          <Row v-if="layoutMode.includes('mix')" key="6-3" :label="$t('theme.sider.mixWidth')"><AInputNumber v-model:value="themeStore.sider.mixWidth" class="w-[120px]" /></Row>
          <Row v-if="layoutMode.includes('mix')" key="6-4" :label="$t('theme.sider.mixCollapsedWidth')"><AInputNumber v-model:value="themeStore.sider.mixCollapsedWidth" class="w-[120px]" /></Row>
          <Row v-if="layoutMode === 'vertical-mix'" key="6-5" :label="$t('theme.sider.mixChildMenuWidth')"><AInputNumber v-model:value="themeStore.sider.mixChildMenuWidth" class="w-[120px]" /></Row>
          <Row key="7" :label="$t('theme.footer.visible')"><ASwitch v-model:checked="themeStore.footer.visible" /></Row>
          <Row v-if="themeStore.footer.visible && isWrapperScrollMode" key="7-1" :label="$t('theme.footer.fixed')"><ASwitch v-model:checked="themeStore.footer.fixed" /></Row>
          <Row v-if="themeStore.footer.visible" key="7-2" :label="$t('theme.footer.height')"><AInputNumber v-model:value="themeStore.footer.height" class="w-[120px]" /></Row>
          <Row v-if="themeStore.footer.visible && layoutMode === 'horizontal-mix'" key="7-3" :label="$t('theme.footer.right')"><ASwitch v-model:checked="themeStore.footer.right" /></Row>
          <Row key="8" :label="$t('theme.watermark.visible')"><ASwitch v-model:checked="themeStore.watermark.visible" /></Row>
          <Row v-if="themeStore.watermark.visible" key="8-1" :label="$t('theme.watermark.text')"><AInput v-model:value="themeStore.watermark.text" placeholder="MintAdmin" class="w-[120px]" /></Row>
        </TransitionGroup>
      </div>
    </SimpleScrollbar>
    <template #footer><div class="flex justify-between"><AButton danger @click="resetConfig">{{ $t('theme.configOperation.resetConfig') }}</AButton><div ref="domRef"><AButton type="primary">{{ $t('theme.configOperation.copyConfig') }}</AButton></div></div></template>
  </ADrawer>
</template>

<script setup lang="ts">
import { computed, defineComponent, h, onBeforeUnmount, onMounted, ref } from 'vue';
import Clipboard from 'clipboard';
import { resetCacheStrategyOptions, themeLayoutModeRecord, themePageAnimationModeOptions, themeSchemaRecord, themeScrollModeOptions, themeTabModeOptions } from '@/constants/app';
import { useAppStore } from '@/store/system/app';
import { useThemeStore } from '@/store/system/theme';
import { $t } from '@/locales';
import SimpleScrollbar from '@/components/system/simple-scrollbar.vue';
import ColorPicker from '@/components/system/color-picker.vue';
defineOptions({ name: 'ThemeDrawer' });
const appStore = useAppStore();
const themeStore = useThemeStore();
const domRef = ref<HTMLElement | null>(null);
const layoutModes: UnionKey.ThemeLayoutMode[] = ['vertical', 'vertical-mix', 'horizontal', 'horizontal-mix'];
const schemaIcons: Record<UnionKey.ThemeScheme, string> = { light: 'material-symbols:sunny', dark: 'material-symbols:nightlight-rounded', auto: 'material-symbols:hdr-auto' };
const schemaOptions = computed(() => (Object.keys(themeSchemaRecord) as UnionKey.ThemeScheme[]).map(value => ({ value, payload: { icon: schemaIcons[value] } })));
const layoutMode = computed(() => themeStore.layout.mode);
const isWrapperScrollMode = computed(() => themeStore.layout.scrollMode === 'wrapper');
const hoverMode = ref<UnionKey.ThemeLayoutMode | ''>('');
const colorKeys = computed(() => Object.keys(themeStore.themeColors) as App.Theme.ThemeColorKey[]);
const Row = defineComponent({
  name: 'ThemeDrawerRow', props: { label: { type: String, required: true } },
  setup(props, { slots, attrs }) {
    return () => h('div', { class: ['w-full flex items-center justify-between', attrs.class] }, [
      h('div', [h('span', { class: 'pr-[8px] text-base-text' }, props.label), slots.suffix?.()]), slots.default?.()
    ]);
  }
});
let clipboard: Clipboard | undefined;
function resetConfig() {
  themeStore.resetStore();
  setTimeout(() => window.$message?.success($t('theme.configOperation.resetSuccessMsg')), 50);
}
onMounted(() => {
  if (!domRef.value) return;
  clipboard = new Clipboard(domRef.value, { text: () => themeStore.settingsJson.replace(/"\w+":/g, match => match.replace(/"/g, '')) });
  clipboard.on('success', () => window.$message?.success($t('theme.configOperation.copySuccessMsg')));
});
onBeforeUnmount(() => clipboard?.destroy());
</script>

<style scoped lang="scss">
.setting-list-move, .setting-list-enter-active, .setting-list-leave-active { transition: all .3s; }
.setting-list-enter-from, .setting-list-leave-to { opacity: 0; transform: translateX(-30px); }
.setting-list-leave-active { position: absolute; }
</style>
