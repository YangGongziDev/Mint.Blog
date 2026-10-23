<template>
  <div class="size-full min-h-[520px] flex flex-col items-center justify-center gap-[24px] overflow-hidden">
    <div class="flex text-[400px] text-primary">
      <SvgIcon local-icon="expectation" />
    </div>
    <slot>
      <h3 class="text-[28px] text-primary font-[500]">{{ $t('common.lookForward') }}</h3>
    </slot>
  </div>
</template>

<script setup lang="ts">
import { $t } from '@/locales';

defineOptions({
  name: 'LookForward'
});
</script>

<style scoped lang="scss">

</style>
