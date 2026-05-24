<template>
  <div class="size-full min-h-[520px] flex flex-col items-center justify-center gap-[24px] overflow-hidden">
    <div class="flex text-[400px] text-primary">
      <SvgIcon :local-icon="icon" />
    </div>
    <AButton type="primary" @click="routerPushByKey('root')">{{ $t('common.backToHome') }}</AButton>
  </div>
</template>

<script lang="ts" setup>
import { computed } from 'vue';
import { useRouterPush } from '@/hooks/routing/use-router-push';
import { $t } from '@/locales';

defineOptions({ name: 'ExceptionBase' });

type ExceptionType = '403' | '404' | '500';

interface Props {
  /**
   * Exception type
   *
   * - 403: no permission
   * - 404: not found
   * - 500: service error
   */ 
  type: ExceptionType;
}  

const props = defineProps<Props>();

const { routerPushByKey } = useRouterPush();  

const iconMap: Record<ExceptionType, string> = {
  '403': 'no-permission',
  '404': 'not-found',
  '500': 'service-error'
};  

const icon = computed(() => iconMap[props.type]);
</script>

<style scoped lang="scss">

</style>
