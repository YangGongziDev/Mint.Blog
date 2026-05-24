<template>
  <div class="flex flex-wrap items-center justify-end gap-2 sm:gap-3 w-full min-w-0">
    <slot name="prefix"></slot>
    <slot name="default">
      <AButton size="small" ghost type="primary" class="table-action-btn" @click="add">
        <template #icon>
          <icon-ic-round-plus class="align-sub text-icon" />
        </template>
        <span class="ml-[6px] whitespace-nowrap">{{ $t('common.add') }}</span>
      </AButton>
      <APopconfirm :title="$t('common.confirmDelete')" :disabled="disabledDelete" @confirm="batchDelete">
        <AButton size="small" danger :disabled="disabledDelete" class="table-action-btn">
          <template #icon>
            <icon-ic-round-delete class="align-sub text-icon" />
          </template>
          <span class="ml-[6px] whitespace-nowrap">{{ $t('common.batchDelete') }}</span>
        </AButton>
      </APopconfirm>
    </slot>
    <AButton size="small" class="table-action-btn" @click="refresh">
      <template #icon>
        <icon-mdi-refresh class="align-sub text-icon" :class="{ 'animate-spin': loading }" />
      </template>
      <span class="ml-[6px] whitespace-nowrap">{{ $t('common.refresh') }}</span>
    </AButton>
    <TableColumnSetting v-model:columns="columns" />
    <slot name="suffix"></slot>
  </div>
</template>

<script setup lang="ts">
import { $t } from '@/locales';

defineOptions({
  name: 'TableHeaderOperation'
});

interface Props {
  disabledDelete?: boolean;
  loading?: boolean;
}

defineProps<Props>();

interface Emits {
  (e: 'add'): void;
  (e: 'delete'): void;
  (e: 'refresh'): void;
}

const emit = defineEmits<Emits>();

const columns = defineModel<AntDesign.TableColumnCheck[]>('columns', {
  default: () => []
});

function add() {
  emit('add');
}

function batchDelete() {
  emit('delete');
}

function refresh() {
  emit('refresh');
}
</script>

<style scoped lang="scss">
:deep(.table-action-btn) {
  display: inline-flex;
  align-items: center;
  flex-shrink: 0;
  white-space: nowrap;
}

:deep(.table-action-btn .ant-btn-icon),
:deep(.table-action-btn > span),
:deep(.table-action-btn .ant-btn-loading-icon) {
  white-space: nowrap;
}

:deep(.table-action-btn .ant-btn-icon + span) {
  display: inline-flex;
  align-items: center;
  white-space: nowrap;
}
</style>
