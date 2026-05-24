<template>
  <template v-if="renderLocalIcon">
    <svg aria-hidden="true" width="1em" height="1em" v-bind="bindAttrs">
      <use :xlink:href="symbolId" fill="currentColor" />
    </svg>
  </template>
  <template v-else>
    <Icon v-if="icon" :icon="icon" v-bind="bindAttrs" />
  </template>
</template>

<script setup lang="ts">
import { computed, useAttrs } from 'vue';
import { Icon } from '@iconify/vue';

defineOptions({ name: 'SvgIcon', inheritAttrs: false });

/**
 * Props
 *
 * - Support iconify and local svg icon
 * - If icon and localIcon are passed at the same time, localIcon will be rendered first
 */ 
interface Props {
  /** Iconify icon name */
  icon?: string;
  /** Local svg icon name */
  localIcon?: string;
}  

const props = defineProps<Props>();

const attrs = useAttrs();  

const bindAttrs = computed<{ class: string; style: string }>(() => ({
  class: (attrs.class as string) || '',
  style: (attrs.style as string) || ''
}));  

const ICON_LOCAL_PREFIX = 'icon-local';

const symbolId = computed(() => {
  const defaultLocalIcon = 'no-icon';

  const icon = props.localIcon || defaultLocalIcon;

  return `#${ICON_LOCAL_PREFIX}-${icon}`;
});  

/** If localIcon is passed, render localIcon first */
const renderLocalIcon = computed(() => props.localIcon || !props.icon);
</script>

<style scoped lang="scss">

</style>
