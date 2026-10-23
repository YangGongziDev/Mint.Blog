<template>
  <div class="category-page flex h-full min-h-0 w-full flex-col overflow-hidden">
    <div class="flex-shrink-0 bg-layout pb-4">
      <ACard :bordered="false" class="card-wrapper">
        <AForm layout="inline" class="responsive-search-form">
          <AFormItem label="分类名称">
            <AInput
              v-model:value="query.name"
              allow-clear
              placeholder="请输入（模糊查询）"
              class="w-full sm:w-[220px]"
              @press-enter="loadData"
            />
          </AFormItem>
          <AFormItem label="创建日期">
            <ARangePicker v-model:value="dateRange" class="w-full sm:w-[280px]" @change="handleDateChange" />
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
        :row-class-name="record => (isCategoryDeleted(record as CategoryListItem) ? 'deleted-row' : '')"
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
            <ATag color="blue">{{ record.name }}</ATag>
          </template>
          <template v-else-if="column.key === 'createTime'">
            {{ getCreateTime(record as CategoryListItem) }}
          </template>
          <template v-else-if="column.key === 'isDeleted'">
            <ATag :color="isCategoryDeleted(record as CategoryListItem) ? 'red' : 'green'">
              {{ isCategoryDeleted(record as CategoryListItem) ? '已删除' : '未删除' }}
            </ATag>
          </template>
          <template v-else-if="column.key === 'action'">
            <ASpace>
              <ATooltip title="置顶">
                <AButton
                  size="small"
                  shape="circle"
                  :disabled="index === 0"
                  @click="moveCategoryToFirst(record as CategoryListItem, index)"
                >
                  <template #icon><VerticalAlignTopOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="置底">
                <AButton
                  size="small"
                  shape="circle"
                  :disabled="index === tableData.length - 1"
                  @click="moveCategoryToLast(record as CategoryListItem, index)"
                >
                  <template #icon><VerticalAlignBottomOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="上移">
                <AButton size="small" shape="circle" :disabled="index === 0" @click="moveCategoryUp(index)">
                  <template #icon><UpOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="下移">
                <AButton
                  size="small"
                  shape="circle"
                  :disabled="index === tableData.length - 1"
                  @click="moveCategoryDown(index)"
                >
                  <template #icon><DownOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="编辑">
                <AButton type="primary" size="small" shape="circle" @click="openEditModal(record as CategoryListItem)">
                  <template #icon><EditOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="删除">
                <AButton danger size="small" shape="circle" @click="openDeleteModal(record as CategoryListItem)">
                  <template #icon><DeleteOutlined /></template>
                </AButton>
              </ATooltip>
            </ASpace>
          </template>
        </template>
      </ATable>
    </ACard>

    <AModal v-model:open="createModalVisible" title="添加文章分类" :width="modalWidth" :footer="null">
      <AForm ref="formRef" :model="form" :rules="rules" layout="vertical">
        <AFormItem label="分类名称" name="name">
          <AInput v-model:value="form.name" allow-clear show-count :maxlength="20" placeholder="请输入分类名称" />
        </AFormItem>
      </AForm>
      <div class="modal-footer mt-6 flex justify-end gap-3 border-t border-gray-200 pt-4 dark:border-gray-600">
        <AButton size="middle" @click="handleCancel">取消</AButton>
        <AButton type="primary" size="middle" :loading="submitLoading" @click="handleSubmit">确定</AButton>
      </div>
    </AModal>

    <AModal
      v-model:open="deleteModalVisible"
      title="删除分类"
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
            <div class="font-medium text-gray-900 dark:text-white">确认删除分类</div>
            <div class="mt-1 text-sm text-gray-500 dark:text-gray-400">请选择删除类型，谨慎操作</div>
          </div>
        </div>
        <div class="delete-info mb-4 rounded-lg p-4">
          <p class="text-sm">
            是否确定要删除分类
            <span class="font-medium">"{{ currentDeleteCategory?.name }}"</span>
            ？
          </p>
          <p class="mt-2 text-xs">删除后该分类下的所有文章将变为未分类状态</p>
        </div>
        <div class="delete-type-selection mb-4">
          <div class="mb-3 text-sm font-medium">删除类型：</div>
          <ARadioGroup v-model:value="deleteType" class="w-full">
            <div class="flex flex-col gap-3">
              <ARadio :value="1" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(1)">
                <div class="ml-2">
                  <div class="font-medium">逻辑删除</div>
                  <div class="mt-1 text-xs text-gray-500">分类将被标记为已删除，但数据仍保留在数据库中，可以恢复</div>
                </div>
              </ARadio>
              <ARadio :value="2" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(2)">
                <div class="ml-2">
                  <div class="font-medium">物理删除</div>
                  <div class="mt-1 text-xs text-gray-500">分类将从数据库中永久删除，此操作不可恢复</div>
                  <div v-if="(currentDeleteCategory?.articlesTotal ?? 0) > 0" class="mt-1 text-xs text-red-500">
                    当前分类下还有 {{ currentDeleteCategory?.articlesTotal }} 篇文章，不能物理删除
                  </div>
                </div>
              </ARadio>
              <ARadio :value="3" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(3)">
                <div class="ml-2">
                  <div class="font-medium">取消删除</div>
                  <div class="mt-1 text-xs text-gray-500">恢复已删除的分类，使其重新可见</div>
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

    <AModal v-model:open="editModalVisible" title="编辑分类" :width="modalWidth" :footer="null">
      <AForm ref="editFormRef" :model="editForm" layout="vertical" :rules="editRules">
        <AFormItem label="分类名称" name="name">
          <AInput v-model:value="editForm.name" placeholder="请输入分类名称" :maxlength="20" show-count />
        </AFormItem>
      </AForm>
      <div class="mt-5 text-center">
        <ASpace>
          <AButton @click="handleEditCancel">取消</AButton>
          <AButton type="primary" :loading="editLoading" @click="handleEditSubmit">确定</AButton>
        </ASpace>
      </div>
    </AModal>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, reactive, ref } from 'vue';
import type { FormInstance, FormProps, TableColumnsType } from 'ant-design-vue';
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
  type CategoryListItem,
  createCategory,
  deleteCategory,
  getCategoryPageList,
  moveCategorySortFirst,
  moveCategorySortLast,
  updateCategory,
  updateCategorySort
} from '@/service/blog/admin/category';
import { useAppStore } from '@/store/system/app';
import type { TimeSortOrder } from '@/utils/date-time';
import { compareDateTime, formatDateTime, getAntdTimeSortOrder, getTableSortOrder, resolveTimeSortOrder } from '@/utils/date-time';

defineOptions({ name: 'BlogAdminCategoryList' });

const appStore = useAppStore();
const loading = ref(false);
const dateRange = ref<[Dayjs, Dayjs] | undefined>();
const tableData = ref<CategoryListItem[]>([]);
const current = ref(1);
const pageSize = ref(20);
const total = ref(0);
const createModalVisible = ref(false);
const editModalVisible = ref(false);
const deleteModalVisible = ref(false);
const submitLoading = ref(false);
const editLoading = ref(false);
const deleteLoading = ref(false);
const deleteType = ref<number | null>(null);
const currentDeleteCategory = ref<CategoryListItem | null>(null);
const currentEditCategory = ref<CategoryListItem | null>(null);
const formRef = ref<FormInstance>();
const editFormRef = ref<FormInstance>();
const form = reactive({ name: '' });
const editForm = reactive({ id: undefined as string | undefined, name: '' });
const query = reactive({ name: '', startDate: '', endDate: '', sortOrder: undefined as TimeSortOrder | undefined });

const modalWidth = computed(() => (appStore.isMobile ? '92vw' : 480));
const deleteModalWidth = computed(() => (appStore.isMobile ? '92vw' : 600));

const columns = computed<TableColumnsType<CategoryListItem>>(() => [
  { title: '序号', key: 'index', width: 80, align: 'center' },
  { title: '分类名称', dataIndex: 'name', key: 'name', width: 180, align: 'center', ellipsis: true },
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
  { title: '删除状态', key: 'isDeleted', width: 100, align: 'center' },
  { title: '操作', key: 'action', width: 220, align: 'center' }
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

const rules: FormProps['rules'] = {
  name: [
    { required: true, message: '分类名称不能为空', trigger: 'blur' },
    { min: 1, max: 20, message: '分类名称字数要求大于 1 个字符，小于 20 个字符', trigger: 'blur' }
  ]
};
const editRules: FormProps['rules'] = {
  name: [
    { required: true, message: '请输入分类名称', trigger: 'blur' },
    { max: 20, message: '分类名称不能超过20个字符', trigger: 'blur' }
  ]
};
function isCategoryDeleted(record: CategoryListItem) {
  return record.isDeleted === true || Number(record.isDeleted ?? 0) === 1;
}
const currentDeleteCategoryDeleted = computed(() =>
  currentDeleteCategory.value ? isCategoryDeleted(currentDeleteCategory.value) : false
);
function isDeleteTypeDisabled(type: number) {
  if (type === 1) return currentDeleteCategoryDeleted.value;
  if (type === 2) return (currentDeleteCategory.value?.articlesTotal ?? 0) > 0;
  if (type === 3) return !currentDeleteCategoryDeleted.value;
  return false;
}
function getRawCreateTime(record: CategoryListItem) {
  return record.createTime || record.createdAt || '';
}
function getCreateTime(record: CategoryListItem) {
  return formatDateTime(getRawCreateTime(record));
}
async function loadData() {
  loading.value = true;
  try {
    const res = await getCategoryPageList({
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
  Object.assign(query, { name: '', startDate: '', endDate: '', sortOrder: undefined });
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
  form.name = '';
  createModalVisible.value = true;
}
function handleCancel() {
  createModalVisible.value = false;
  formRef.value?.resetFields();
}
function normalizeCategoryName(name: string) {
  return name.trim().toLowerCase();
}
async function categoryExists(name: string) {
  const normalizedName = normalizeCategoryName(name);
  const res = await getCategoryPageList({ pageNumber: 1, pageSize: 1000, name });
  const items = res.success ? (res.data.items ?? res.data.records ?? []) : [];
  return items.some(item => normalizeCategoryName(item.name) === normalizedName);
}
async function handleSubmit() {
  await formRef.value?.validate();
  const name = form.name.trim();

  submitLoading.value = true;
  try {
    if (await categoryExists(name)) {
      message.warning(`分类“${name}”已存在，请勿重复添加`);
      return;
    }

    const res = await createCategory({ name });
    if (res.success) {
      message.success('添加成功');
      handleCancel();
      await loadData();
    }
  } finally {
    submitLoading.value = false;
  }
}
function openEditModal(record: CategoryListItem) {
  currentEditCategory.value = record;
  editForm.id = record.id;
  editForm.name = record.name;
  editModalVisible.value = true;
}
function handleEditCancel() {
  editModalVisible.value = false;
  currentEditCategory.value = null;
  editForm.id = undefined;
  editForm.name = '';
  editFormRef.value?.resetFields();
}
async function handleEditSubmit() {
  await editFormRef.value?.validate();
  if (!editForm.id) return;

  if (currentEditCategory.value && isCategoryDeleted(currentEditCategory.value)) {
    message.warning('已删除的分类不能编辑，请先取消删除后再修改');
    return;
  }

  editLoading.value = true;
  try {
    const res = await updateCategory(editForm.id, { name: editForm.name });
    if (res.success) {
      message.success('编辑成功');
      handleEditCancel();
      await loadData();
    }
  } finally {
    editLoading.value = false;
  }
}
function openDeleteModal(record: CategoryListItem) {
  currentDeleteCategory.value = record;
  deleteType.value = isCategoryDeleted(record) ? 3 : 1;
  deleteModalVisible.value = true;
}
function handleDeleteCancel() {
  deleteModalVisible.value = false;
  currentDeleteCategory.value = null;
  deleteLoading.value = false;
  deleteType.value = null;
}
function getDeleteButtonText() {
  if (deleteType.value === 1) return '确定逻辑删除';
  if (deleteType.value === 2) return '确定物理删除';
  if (deleteType.value === 3) return '取消删除';
  return '确定删除';
}
async function handleDelete() {
  if (!currentDeleteCategory.value || !deleteType.value || isDeleteTypeDisabled(deleteType.value)) return;
  deleteLoading.value = true;
  try {
    const res = await deleteCategory(currentDeleteCategory.value.id, deleteType.value);
    if (res.success) {
      message.success(`${getDeleteButtonText()}成功`);
      await loadData();
      handleDeleteCancel();
    }
  } finally {
    deleteLoading.value = false;
  }
}
async function updateCategorySortValue(id: string, sort: number) {
  const res = await updateCategorySort(id, sort);
  if (!res.success) throw new Error('排序更新失败');
}
async function moveCategoryUp(index: number) {
  query.sortOrder = undefined;
  if (index === 0) return;
  const currentItem = tableData.value[index];
  const prevItem = tableData.value[index - 1];
  const currentSort = Number(currentItem.sort || 0);
  currentItem.sort = prevItem.sort || 0;
  prevItem.sort = currentSort;
  await updateCategorySortValue(currentItem.id, Number(currentItem.sort || 0));
  await updateCategorySortValue(prevItem.id, Number(prevItem.sort || 0));
  [tableData.value[index], tableData.value[index - 1]] = [tableData.value[index - 1], tableData.value[index]];
}
async function moveCategoryDown(index: number) {
  query.sortOrder = undefined;
  if (index === tableData.value.length - 1) return;
  const currentItem = tableData.value[index];
  const nextItem = tableData.value[index + 1];
  const currentSort = Number(currentItem.sort || 0);
  currentItem.sort = nextItem.sort || 0;
  nextItem.sort = currentSort;
  await updateCategorySortValue(currentItem.id, Number(currentItem.sort || 0));
  await updateCategorySortValue(nextItem.id, Number(nextItem.sort || 0));
  [tableData.value[index], tableData.value[index + 1]] = [tableData.value[index + 1], tableData.value[index]];
}
async function moveCategoryToFirst(record: CategoryListItem, index: number) {
  query.sortOrder = undefined;
  if (index === 0) {
    message.warning('已经是第一个了');
    return;
  }
  const res = await moveCategorySortFirst(record.id);
  if (res.success) {
    message.success('置顶成功');
    await loadData();
  }
}
async function moveCategoryToLast(record: CategoryListItem, index: number) {
  query.sortOrder = undefined;
  if (index === tableData.value.length - 1) {
    message.warning('已经是最后一个了');
    return;
  }
  const res = await moveCategorySortLast(record.id);
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
}
</style>
