<template>
  <ATooltip :title="$t('icon.reload')" placement="bottom">
    <AButton type="text" class="h-[36px] text-icon" @click="emit('click')">
      <div class="flex items-center justify-center gap-[8px]">
        <icon-ant-design-reload-outlined class="text-icon" :class="[{ 'animate-spin animate-duration-750': loading }]" />
      </div>
    </AButton>
  </ATooltip>
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

const emit = defineEmits<{
  click: [];
}>();
</script>

<style scoped lang="scss">

</style>
