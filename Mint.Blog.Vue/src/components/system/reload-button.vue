<template>
  <ButtonIcon size-class="text-icon" :tooltip-content="$t('icon.reload')">
    <icon-ant-design-reload-outlined class="text-icon" :class="[{ 'animate-spin animate-duration-750': loading }]" />
  </ButtonIcon>
</template>

<script setup lang="ts">
import { $t } from '@/locales';

defineOptions({
  name: 'ReloadButton'
});  

interface Props {
  loading?: boolean;
}  

defineProps<Props>();
</script>

<style scoped lang="scss">

</style>
