<template>
  <APopover placement="bottomRight" trigger="click">
    <AButton size="small" class="table-action-btn">
      <template #icon>
        <icon-ant-design-setting-outlined class="align-sub text-icon" />
      </template>
      <span class="ml-[6px] whitespace-nowrap">{{ $t('common.columnSetting') }}</span>
    </AButton>
    <template #content>
      <VueDraggable v-model="columns" :animation="150" filter=".none_draggable">
        <div
          v-for="item in columns"
          :key="item.key"
          class="h-[36px] flex items-center rounded-[4px] hover:bg-primary hover:bg-opacity-20"
        >
          <icon-mdi-drag class="mr-[8px] h-full cursor-move text-icon" />
          <ACheckbox v-model:checked="item.checked" class="none_draggable flex-1">
            {{ item.title }}
          </ACheckbox>
        </div>
      </VueDraggable>
    </template>
  </APopover>
</template>

<script setup lang="ts" generic="T extends Record<string, unknown>, K = never">
import { VueDraggable } from 'vue-draggable-plus';  
import { $t } from '@/locales';

defineOptions({
  name: 'TableColumnSetting'
});  

const columns = defineModel<AntDesign.TableColumnCheck[]>('columns', {
  required: true
});  
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
