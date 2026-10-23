<template>
  <div class="category-page flex h-full min-h-0 w-full flex-col overflow-hidden">
    <div class="flex-shrink-0 bg-layout pb-4">
      <ACard :bordered="false" class="card-wrapper">
        <AForm layout="inline" class="responsive-search-form">
          <AFormItem label="标签名称">
            <AInput
              v-model:value="query.name"
              allow-clear
              placeholder="请输入（模糊查询）"
              class="w-full sm:w-[220px]"
              @press-enter="loadData"
            />
          </AFormItem>
          <AFormItem label="创建日期">
            <ARangePicker
              v-model:value="dateRange"
              format="YYYY-MM-DD"
              class="w-full sm:w-[280px]"
              @change="handleDateChange"
            />
          </AFormItem>
          <AFormItem>
            <ASpace wrap>
              <AButton type="primary" @click="loadData">
                <template #icon><SearchOutlined /></template>
                查询
              </AButton>
              <AButton @click="handleReset">
                <template #icon><ReloadOutlined /></template>
                重置
              </AButton>
              <AButton type="primary" @click="openCreateModal">
                <template #icon><PlusOutlined /></template>
                新增
              </AButton>
            </ASpace>
          </AFormItem>
        </AForm>
      </ACard>
    </div>

    <ACard :bordered="false" class="card-wrapper table-card flex-1 min-h-0 overflow-hidden">
      <ATable
        :columns="columns"
        :data-source="tableData"
        :loading="loading"
        :pagination="pagination"
        :row-key="record => record.id"
        :row-class-name="record => (isTagDeleted(record as TagListItem) ? 'deleted-row' : '')"
        :scroll="{ x: tableScrollX, y: tableScrollY }"
        bordered
        size="middle"
        @change="handleTableChange"
      >
        <template #bodyCell="{ column, record, index }">
          <template v-if="column.key === 'index'">
            {{ index + 1 }}
          </template>
          <template v-else-if="column.key === 'name'">
            <ATag class="ms-2" color="success">{{ record.name }}</ATag>
          </template>
          <template v-else-if="column.key === 'createTime'">
            {{ getCreateTime(record as TagListItem) }}
          </template>
          <template v-else-if="column.key === 'isDeleted'">
            <ATag :color="isTagDeleted(record as TagListItem) ? 'error' : 'success'">
              {{ isTagDeleted(record as TagListItem) ? '已删除' : '未删除' }}
            </ATag>
          </template>
          <template v-else-if="column.key === 'action'">
            <ASpace>
              <ATooltip title="置顶">
                <AButton
                  size="small"
                  shape="circle"
                  :disabled="index === 0"
                  @click="moveTagToFirst(record as TagListItem, index)"
                >
                  <template #icon><VerticalAlignTopOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="置底">
                <AButton
                  size="small"
                  shape="circle"
                  :disabled="index === tableData.length - 1"
                  @click="moveTagToLast(record as TagListItem, index)"
                >
                  <template #icon><VerticalAlignBottomOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="上移">
                <AButton
                  size="small"
                  shape="circle"
                  :disabled="index === 0"
                  @click="moveTagUp(record as TagListItem, index)"
                >
                  <template #icon><UpOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="下移">
                <AButton
                  size="small"
                  shape="circle"
                  :disabled="index === tableData.length - 1"
                  @click="moveTagDown(record as TagListItem, index)"
                >
                  <template #icon><DownOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="编辑">
                <AButton size="small" shape="circle" @click="openEditModal(record as TagListItem)">
                  <template #icon><EditOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="删除">
                <AButton danger size="small" shape="circle" @click="openDeleteModal(record as TagListItem)">
                  <template #icon><DeleteOutlined /></template>
                </AButton>
              </ATooltip>
            </ASpace>
          </template>
        </template>
      </ATable>
    </ACard>

    <AModal v-model:open="createModalVisible" title="添加文章标签" :width="modalWidth" :footer="null">
      <AForm ref="formRef" :model="createForm" layout="vertical">
        <AFormItem label="标签列表">
          <div class="tag-input-container">
            <ATag v-for="tag in dynamicTags" :key="tag" class="mb-2 mr-2" closable @close="handleClose(tag)">
              {{ tag }}
            </ATag>
            <div class="mt-2">
              <AInput
                v-if="inputVisible"
                ref="inputRef"
                v-model:value="inputValue"
                class="w-32"
                size="small"
                placeholder="输入标签名称"
                @keyup.enter="handleInputConfirm"
                @blur="handleInputConfirm"
              />
              <AButton v-else class="button-new-tag" size="small" @click="showInput">+ 新增标签</AButton>
            </div>
          </div>
        </AFormItem>
      </AForm>
      <div class="modal-footer mt-6 flex justify-end gap-3 border-t border-gray-200 pt-4 dark:border-gray-600">
        <AButton size="middle" @click="cancelCreateTag">取消</AButton>
        <AButton type="primary" size="middle" :loading="submitLoading" @click="handleCreateSubmit">确定</AButton>
      </div>
    </AModal>

    <AModal
      v-model:open="deleteModalVisible"
      title="删除标签"
      :width="deleteModalWidth"
      :footer="null"
      wrap-class-name="delete-dialog"
    >
      <div class="delete-content py-4">
        <div class="mb-4 flex items-center">
          <div class="warning-icon mr-3 flex h-8 w-8 items-center justify-center rounded-full">
            <DeleteOutlined />
          </div>
          <div>
            <div class="font-medium text-gray-900 dark:text-white">确认删除标签</div>
            <div class="mt-1 text-sm text-gray-500 dark:text-gray-400">请选择删除方式，不同方式的影响不同</div>
          </div>
        </div>
        <div class="delete-info mb-4 rounded-lg p-4">
          <p class="text-sm">
            是否确定要删除标签
            <span class="font-medium">"{{ currentDeleteTag?.name }}"</span>
            ？
          </p>
          <p class="mt-2 text-xs">删除后该标签下的所有文章将移除此标签</p>
        </div>
        <div class="delete-type-selection">
          <div class="mb-3 text-sm font-medium text-gray-900 dark:text-white">删除方式：</div>
          <ARadioGroup v-model:value="deleteType" class="w-full">
            <div class="flex flex-col gap-3">
              <ARadio :value="1" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(1)">
                <div class="ml-2">
                  <div class="font-medium">逻辑删除</div>
                  <div class="mt-1 text-xs text-gray-500">标签将被标记为已删除，但数据仍保留在数据库中，可以恢复</div>
                </div>
              </ARadio>
              <ARadio :value="2" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(2)">
                <div class="ml-2">
                  <div class="font-medium">物理删除</div>
                  <div class="mt-1 text-xs text-gray-500">标签将从数据库中彻底删除，此操作不可撤销</div>
                  <div v-if="(currentDeleteTag?.articlesTotal ?? 0) > 0" class="mt-1 text-xs text-red-500">
                    当前标签下还有 {{ currentDeleteTag?.articlesTotal }} 篇文章，不能物理删除
                  </div>
                </div>
              </ARadio>
              <ARadio :value="3" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(3)">
                <div class="ml-2">
                  <div class="font-medium">取消删除</div>
                  <div class="mt-1 text-xs text-gray-500">恢复已删除的标签，使其重新可用</div>
                </div>
              </ARadio>
            </div>
          </ARadioGroup>
        </div>
      </div>
      <div class="modal-footer mt-6 flex justify-end gap-3 border-t border-gray-200 pt-4 dark:border-gray-600">
        <AButton size="middle" @click="handleDeleteCancel">取消</AButton>
        <AButton
          type="primary"
          :danger="deleteType !== 3"
          size="middle"
          :loading="deleteLoading"
          :disabled="!deleteType || isDeleteTypeDisabled(deleteType)"
          @click="handleDelete"
        >
          {{ getDeleteButtonText() }}
        </AButton>
      </div>
    </AModal>

    <AModal v-model:open="editModalVisible" title="编辑标签" :width="editModalWidth" :footer="null">
      <AForm ref="editFormRef" :model="editForm" layout="vertical">
        <AFormItem label="标签名称" name="name" :rules="[{ required: true, message: '请输入标签名称' }]">
          <AInput v-model:value="editForm.name" allow-clear show-count :maxlength="20" placeholder="请输入标签名称" />
        </AFormItem>
      </AForm>
      <div class="modal-footer mt-6 flex justify-end gap-3 border-t border-gray-200 pt-4 dark:border-gray-600">
        <AButton size="middle" @click="cancelEditTag">取消</AButton>
        <AButton type="primary" size="middle" :loading="editSubmitLoading" @click="handleEditSubmit">确定</AButton>
      </div>
    </AModal>
  </div>
</template>

<script setup lang="ts">
import { computed, nextTick, onMounted, reactive, ref } from 'vue';
import type { FormInstance, TableColumnsType } from 'ant-design-vue';
import { message } from 'ant-design-vue';
import type { Dayjs } from 'dayjs';
import {
  DeleteOutlined,
  DownOutlined,
  EditOutlined,
  PlusOutlined,
  ReloadOutlined,
  SearchOutlined,
  UpOutlined,
  VerticalAlignBottomOutlined,
  VerticalAlignTopOutlined
} from '@ant-design/icons-vue';
import {
  type TagListItem,
  createTag,
  deleteTag,
  getTagPageList,
  moveTagSortFirst,
  moveTagSortLast,
  updateTag,
  updateTagSort
} from '@/service/blog/admin/tag';
import { useAppStore } from '@/store/system/app';
import type { TimeSortOrder } from '@/utils/date-time';
import { compareDateTime, formatDateTime, getAntdTimeSortOrder, getTableSortOrder, resolveTimeSortOrder } from '@/utils/date-time';

defineOptions({ name: 'BlogAdminTagList' });

const appStore = useAppStore();
const loading = ref(false);
const dateRange = ref<[Dayjs, Dayjs] | undefined>();
const tableData = ref<TagListItem[]>([]);
const current = ref(1);
const pageSize = ref(20);
const total = ref(0);
const createModalVisible = ref(false);
const editModalVisible = ref(false);
const deleteModalVisible = ref(false);
const submitLoading = ref(false);
const editSubmitLoading = ref(false);
const deleteLoading = ref(false);
const deleteType = ref<number | null>(null);
const currentDeleteTag = ref<TagListItem | null>(null);
const currentEditTag = ref<TagListItem | null>(null);
const inputValue = ref('');
const dynamicTags = ref<string[]>([]);
const inputVisible = ref(false);
const inputRef = ref();
const formRef = ref<FormInstance>();
const editFormRef = ref<FormInstance>();
const createForm = reactive({ tags: [] as string[] });
const editForm = reactive({ id: undefined as string | undefined, name: '' });
const query = reactive({ name: '', startDate: '', endDate: '', sortOrder: undefined as TimeSortOrder | undefined });

const modalWidth = computed(() => (appStore.isMobile ? '92vw' : 500));
const editModalWidth = computed(() => (appStore.isMobile ? '92vw' : 480));
const deleteModalWidth = computed(() => (appStore.isMobile ? '92vw' : 600));

const columns = computed<TableColumnsType<TagListItem>>(() => [
  { title: '序号', key: 'index', width: 80, align: 'center' },
  { title: '标签名称', dataIndex: 'name', key: 'name', width: 200, align: 'center', ellipsis: true },
  { title: '文章数', dataIndex: 'articlesTotal', key: 'articlesTotal', width: 100, align: 'center' },
  {
    title: '创建时间',
    dataIndex: 'createTime',
    key: 'createTime',
    width: 180,
    align: 'center',
    sorter: (a, b) => compareDateTime(getRawCreateTime(a), getRawCreateTime(b)),
    sortOrder: query.sortOrder ? getAntdTimeSortOrder(query.sortOrder) : undefined,
    sortDirections: ['descend', 'ascend']
  },
  { title: '删除状态', dataIndex: 'isDeleted', key: 'isDeleted', width: 120, align: 'center' },
  { title: '操作', dataIndex: 'action', key: 'action', width: 220, align: 'center' }
]);
const tableScrollX = 1200;
const tableScrollY = computed(() => (appStore.isMobile ? 'calc(100vh - 400px)' : 'calc(100vh - 440px)'));

const pagination = computed(() => ({
  current: current.value,
  pageSize: pageSize.value,
  total: total.value,
  showSizeChanger: true,
  showQuickJumper: true,
  pageSizeOptions: [
    '10',
    '20',
    '50',
    '100',
    '150',
    '200',
    '300',
    '350',
    '400',
    '500',
    '600',
    '800',
    '1000',
    '1500',
    '2000'
  ],
  showTotal: (value: number, range: [number, number]) => `第 ${range[0]}-${range[1]} 条，共 ${value} 条`,
  size: appStore.isMobile ? ('small' as const) : ('default' as const)
}));

function isTagDeleted(record: TagListItem) {
  return record.isDeleted === true || Number(record.isDeleted ?? 0) === 1;
}
const currentDeleteTagDeleted = computed(() => (currentDeleteTag.value ? isTagDeleted(currentDeleteTag.value) : false));
function isDeleteTypeDisabled(type: number) {
  if (type === 1) return currentDeleteTagDeleted.value;
  if (type === 2) return (currentDeleteTag.value?.articlesTotal ?? 0) > 0;
  if (type === 3) return !currentDeleteTagDeleted.value;
  return false;
}

function getRawCreateTime(record: TagListItem) {
  return record.createTime || record.createdAt || '';
}

function getCreateTime(record: TagListItem) {
  return formatDateTime(getRawCreateTime(record));
}

async function loadData() {
  loading.value = true;
  try {
    const res = await getTagPageList({
      pageNumber: current.value,
      pageSize: pageSize.value,
      name: query.name || undefined,
      startDate: query.startDate || undefined,
      endDate: query.endDate || undefined,
      sortOrder: query.sortOrder
    });
    if (res.success) {
      const items = res.data.items ?? res.data.records ?? [];
      tableData.value = items;
      total.value = res.data.totalCount ?? res.data.total ?? 0;
      current.value = res.data.pageNumber;
      pageSize.value = res.data.pageSize;
    }
  } finally {
    loading.value = false;
  }
}

function handleDateChange(_: unknown, dateStrings: [string, string]) {
  query.startDate = dateStrings[0];
  query.endDate = dateStrings[1];
}

function handleReset() {
  query.name = '';
  query.startDate = '';
  query.endDate = '';
  query.sortOrder = undefined;
  dateRange.value = undefined;
  current.value = 1;
  loadData();
}

function handleTableChange(page: { current?: number; pageSize?: number }, ...changeArgs: [unknown?, unknown?, { action?: string }?]) {
  current.value = page.current ?? 1;
  pageSize.value = page.pageSize ?? 20;
  if (changeArgs[2]?.action === 'sort') query.sortOrder = resolveTimeSortOrder(getTableSortOrder(changeArgs[1]), query.sortOrder);
  loadData();
}

function openCreateModal() {
  createModalVisible.value = true;
}

function cancelCreateTag() {
  createModalVisible.value = false;
  dynamicTags.value = [];
  createForm.tags = [];
  inputVisible.value = false;
  inputValue.value = '';
}

function handleClose(tag: string) {
  dynamicTags.value.splice(dynamicTags.value.indexOf(tag), 1);
}

function showInput() {
  inputVisible.value = true;
  nextTick(() => inputRef.value?.focus?.());
}

function handleInputConfirm() {
  const tag = inputValue.value.trim();
  if (tag && !dynamicTags.value.includes(tag)) dynamicTags.value.push(tag);
  inputVisible.value = false;
  inputValue.value = '';
}

function normalizeTagName(name: string) {
  return name.trim().toLowerCase();
}

function findDuplicateTagName(tags: string[]) {
  const tagNameSet = new Set<string>();
  return tags.find(tag => {
    const tagName = normalizeTagName(tag);
    if (tagNameSet.has(tagName)) return true;
    tagNameSet.add(tagName);
    return false;
  });
}

async function findExistingTagName(tags: string[]) {
  const results = await Promise.all(tags.map(tag => getTagPageList({ pageNumber: 1, pageSize: 1000, name: tag })));

  for (const [index, res] of results.entries()) {
    const tag = tags[index];
    const items = res.success ? (res.data.items ?? res.data.records ?? []) : [];
    const existingTag = items.find(item => normalizeTagName(item.name) === normalizeTagName(tag));
    if (existingTag) return tag;
  }

  return '';
}

async function handleCreateSubmit() {
  if (dynamicTags.value.length === 0) {
    message.warning('请至少添加一个标签');
    return;
  }

  const duplicateTag = findDuplicateTagName(dynamicTags.value);
  if (duplicateTag) {
    message.warning(`标签“${duplicateTag}”重复，请勿重复添加`);
    return;
  }

  submitLoading.value = true;
  try {
    const existingTag = await findExistingTagName(dynamicTags.value);
    if (existingTag) {
      message.warning(`标签“${existingTag}”已存在，请勿重复添加`);
      return;
    }

    const results = await Promise.all(dynamicTags.value.map(tag => createTag({ name: tag })));
    if (results.some(res => !res.success)) return;

    message.success('添加成功');
    cancelCreateTag();
    await loadData();
  } finally {
    submitLoading.value = false;
  }
}

function openEditModal(record: TagListItem) {
  currentEditTag.value = record;
  editForm.id = record.id;
  editForm.name = record.name;
  editModalVisible.value = true;
}

function cancelEditTag() {
  editModalVisible.value = false;
  currentEditTag.value = null;
  editForm.id = undefined;
  editForm.name = '';
  editSubmitLoading.value = false;
  editFormRef.value?.clearValidate();
}

async function handleEditSubmit() {
  await editFormRef.value?.validate();
  if (!editForm.id) return;

  if (currentEditTag.value && isTagDeleted(currentEditTag.value)) {
    message.warning('已删除的标签不能编辑，请先取消删除后再修改');
    return;
  }

  editSubmitLoading.value = true;
  try {
    const res = await updateTag(editForm.id, { name: editForm.name });
    if (res.success) {
      message.success('编辑成功');
      cancelEditTag();
      await loadData();
    }
  } finally {
    editSubmitLoading.value = false;
  }
}

function openDeleteModal(record: TagListItem) {
  currentDeleteTag.value = record;
  deleteType.value = isTagDeleted(record) ? 3 : 1;
  deleteModalVisible.value = true;
}

function handleDeleteCancel() {
  deleteModalVisible.value = false;
  currentDeleteTag.value = null;
  deleteLoading.value = false;
  deleteType.value = null;
}

function getDeleteButtonText() {
  if (deleteType.value === 1) return '逻辑删除';
  if (deleteType.value === 2) return '物理删除';
  if (deleteType.value === 3) return '取消删除';
  return '确定删除';
}

async function handleDelete() {
  if (!currentDeleteTag.value || !deleteType.value || isDeleteTypeDisabled(deleteType.value)) return;

  deleteLoading.value = true;
  try {
    const res = await deleteTag(currentDeleteTag.value.id, deleteType.value);
    if (res.success) {
      message.success(`${getDeleteButtonText()}成功`);
      await loadData();
      handleDeleteCancel();
    }
  } finally {
    deleteLoading.value = false;
  }
}

async function updateTagSortValue(id: string, sort: number) {
  const res = await updateTagSort(id, sort);
  if (!res.success) throw new Error('更新排序失败');
}

async function moveTagUp(_record: TagListItem, index: number) {
  query.sortOrder = undefined;
  if (index === 0) return;

  try {
    const currentItem = tableData.value[index];
    const previousItem = tableData.value[index - 1];
    const currentSort = Number(currentItem.sort || 0);
    currentItem.sort = previousItem.sort || 0;
    previousItem.sort = currentSort;
    await updateTagSortValue(currentItem.id, Number(currentItem.sort || 0));
    await updateTagSortValue(previousItem.id, Number(previousItem.sort || 0));
    tableData.value[index] = previousItem;
    tableData.value[index - 1] = currentItem;
    message.success('上移成功');
  } catch {
    message.error('上移失败');
    await loadData();
  }
}

async function moveTagDown(_record: TagListItem, index: number) {
  query.sortOrder = undefined;
  if (index === tableData.value.length - 1) return;

  try {
    const currentItem = tableData.value[index];
    const nextItem = tableData.value[index + 1];
    const currentSort = Number(currentItem.sort || 0);
    currentItem.sort = nextItem.sort || 0;
    nextItem.sort = currentSort;
    await updateTagSortValue(currentItem.id, Number(currentItem.sort || 0));
    await updateTagSortValue(nextItem.id, Number(nextItem.sort || 0));
    tableData.value[index] = nextItem;
    tableData.value[index + 1] = currentItem;
    message.success('下移成功');
  } catch {
    message.error('下移失败');
    await loadData();
  }
}

async function moveTagToFirst(record: TagListItem, index: number) {
  query.sortOrder = undefined;
  if (index === 0) {
    message.warning('已经是第一个了');
    return;
  }

  const res = await moveTagSortFirst(record.id);
  if (res.success) {
    message.success('置顶成功');
    await loadData();
  }
}

async function moveTagToLast(record: TagListItem, index: number) {
  query.sortOrder = undefined;
  if (index === tableData.value.length - 1) {
    message.warning('已经是最后一个了');
    return;
  }

  const res = await moveTagSortLast(record.id);
  if (res.success) {
    message.success('置底成功');
    await loadData();
  }
}

onMounted(() => {
  loadData();
});
</script>

<style scoped lang="scss">
.category-page {
  height: 100%;
}

.responsive-search-form {
  gap: 12px;

  :deep(.ant-form-item) {
    margin-right: 0;
    margin-bottom: 0;
  }
}

.table-card {
  display: flex;
  flex-direction: column;
}

.table-card :deep(.ant-card-body) {
  display: flex;
  flex: 1;
  min-height: 0;
  overflow: hidden;
  flex-direction: column;
}

.table-card :deep(.ant-spin-nested-loading),
.table-card :deep(.ant-spin-container),
.table-card :deep(.ant-table),
.table-card :deep(.ant-table-container) {
  display: flex;
  flex: 1;
  min-height: 0;
  flex-direction: column;
}

.table-card :deep(.ant-table-body) {
  overflow-y: auto !important;
}

.table-card :deep(.ant-table-thead) {
  position: sticky;
  top: 0;
  z-index: 10;
}

.table-card :deep(.ant-table-thead > tr > th) {
  background: rgb(var(--container-bg-color));
}

.button-new-tag {
  margin-inline-start: 10px;
  block-size: 32px;
  line-height: 30px;
  padding-block: 0;
}

:global(html:not(.dark)) .tag-input-container {
  min-height: 60px;
  padding: 8px;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  background-color: #fafafa;
}

:global(html.dark) .tag-input-container {
  border: 1px solid rgb(var(--container-bg-color));
  background-color: rgb(var(--container-bg-color));
}

:global(html:not(.dark)) .delete-info {
  border: 1px solid #ffccc7;
  background-color: #fff2f0;
}

:global(html.dark) .delete-info {
  border: 1px solid rgb(127 55 55);
  background-color: rgb(69 35 35);
}

:global(html:not(.dark)) .warning-icon {
  background-color: #ff4d4f;
  color: white;
}

:global(html.dark) .warning-icon {
  background-color: rgb(248 113 113);
  color: white;
}

:deep(.delete-dialog) {
  .ant-modal-header {
    .ant-modal-title {
      color: #ff4d4f;
      font-weight: 600;
    }
  }
}

:global(html:not(.dark)) :deep(.deleted-row > td) {
  background-color: #f5f5f5 !important;
  color: #999 !important;
}

:global(html:not(.dark)) :deep(.deleted-row:hover > td) {
  background-color: #f5f5f5 !important;
}

:global(html.dark) .table-card :deep(.ant-table),
:global(html.dark) .table-card :deep(.ant-table-container),
:global(html.dark) .table-card :deep(.ant-table-content),
:global(html.dark) .table-card :deep(.ant-table-body),
:global(html.dark) .table-card :deep(.ant-table-tbody),
:global(html.dark) .table-card :deep(.ant-table-cell) {
  background: rgb(var(--container-bg-color)) !important;
}

:global(html.dark) .table-card :deep(.ant-table-tbody > tr > td) {
  background: rgb(var(--container-bg-color)) !important;
  color: rgb(var(--base-text-color)) !important;
}

:global(html.dark) .table-card :deep(.ant-table-tbody > tr:hover > td) {
  background: rgb(51 60 74) !important;
}

:global(html.dark) .table-card :deep(.ant-table-tbody > tr.ant-table-placeholder > td) {
  background: rgb(var(--container-bg-color)) !important;
}

:global(html.dark) .table-card :deep(.deleted-row > td) {
  background-color: rgb(45 52 63) !important;
  color: rgb(148 163 184) !important;
}

:global(html.dark) .table-card :deep(.deleted-row:hover > td) {
  background-color: rgb(51 60 74) !important;
}

@media (max-width: 640px) {
  .responsive-search-form {
    display: flex;
    flex-direction: column;
    align-items: stretch;
  }

  .responsive-search-form :deep(.ant-form-item-control),
  .responsive-search-form :deep(.ant-form-item-control-input-content) {
    width: 100%;
  }

  :deep(.blog-admin-action-column) {
    padding-right: 4px !important;
    padding-left: 4px !important;
  }

  :deep(.blog-admin-action-column .ant-btn) {
    padding-right: 0;
    padding-left: 0;
  }
}
</style>
