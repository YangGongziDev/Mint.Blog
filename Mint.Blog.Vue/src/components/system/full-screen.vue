<template>
  <ButtonIcon
    :key="String(full)"
    size-class="text-icon-large"
    :icon="full ? 'gridicons-fullscreen-exit' : 'gridicons-fullscreen'"
    :tooltip-content="full ? $t('icon.fullscreenExit') : $t('icon.fullscreen')"
  />
</template>

<script setup lang="ts">
import { $t } from '@/locales';

defineOptions({
  name: 'FullScreen'
});  

interface Props {
  full?: boolean;
}  

defineProps<Props>();
</script>

<style scoped lang="scss">

</style>
