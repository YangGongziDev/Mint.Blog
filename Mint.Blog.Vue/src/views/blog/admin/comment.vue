<template>
  <div class="category-page flex h-full min-h-0 w-full flex-col overflow-hidden">
    <div class="flex-shrink-0 bg-layout pb-4">
      <ACard :bordered="false" class="card-wrapper">
        <AForm layout="inline" class="responsive-search-form">
          <AFormItem label="路由地址">
            <AInput v-model:value="query.routerUrl" allow-clear placeholder="请输入路由地址" class="w-full sm:w-[220px]" />
          </AFormItem>
          <AFormItem label="创建日期">
            <ARangePicker v-model:value="dateRange" class="w-full sm:w-[280px]" @change="handleDateChange" />
          </AFormItem>
          <AFormItem label="状态">
            <ASelect v-model:value="query.status" allow-clear placeholder="请选择状态" class="w-full sm:w-[160px]">
              <ASelectOption :value="1">待审核</ASelectOption>
              <ASelectOption :value="2">正常</ASelectOption>
              <ASelectOption :value="3">审核不通过</ASelectOption>
            </ASelect>
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
        :row-class-name="record => (isCommentDeleted(record as AdminCommentPageItem) ? 'deleted-row' : '')"
        :scroll="{ x: tableScrollX, y: tableScrollY }"
        size="middle"
        @change="handleTableChange"
      >
        <template #bodyCell="{ column, record, index }">
          <template v-if="column.key === 'index'">
            {{ index + 1 }}
          </template>
          <template v-else-if="column.key === 'avatar'">
            <AAvatar :size="40" :src="record.avatar" />
          </template>
          <template v-else-if="column.key === 'routerUrl'">
            <ATooltip :title="record.routerUrl">
              <a :href="`#${record.routerUrl}`" target="_blank" class="comment-route-link text-blue-500 hover:text-blue-700">
                {{ record.routerUrl }}
              </a>
            </ATooltip>
          </template>
          <template v-else-if="column.key === 'nickname'">
            <ATypographyParagraph :content="record.nickname" :ellipsis="{ rows: 1 }" class="comment-text-cell !mb-0" />
          </template>
          <template v-else-if="column.key === 'content'">
            <ATypographyParagraph :content="record.content" :ellipsis="{ rows: 2 }" class="comment-text-cell !mb-0" />
          </template>
          <template v-else-if="column.key === 'createdAt'">
            {{ formatDateTime(record.createdAt) }}
          </template>
          <template v-else-if="column.key === 'status'">
            <ATag :color="getStatusMeta(record.status).color">{{ getStatusMeta(record.status).label }}</ATag>
          </template>
          <template v-else-if="column.key === 'isDeleted'">
            <ATag :color="isCommentDeleted(record as AdminCommentPageItem) ? 'red' : 'green'">
              {{ isCommentDeleted(record as AdminCommentPageItem) ? '已删除' : '未删除' }}
            </ATag>
          </template>
          <template v-else-if="column.key === 'action'">
            <ASpace>
              <ATooltip title="详情">
                <AButton size="small" shape="circle" @click="openDetailModal(record as AdminCommentPageItem)">
                  <template #icon><FileTextOutlined /></template>
                </AButton>
              </ATooltip>

              <ATooltip title="审核">
                <AButton size="small" shape="circle" @click="openExamineModal(record as AdminCommentPageItem)">
                  <template #icon><EditOutlined /></template>
                </AButton>
              </ATooltip>

              <ATooltip title="删除">
                <AButton danger size="small" shape="circle" @click="openDeleteModal(record as AdminCommentPageItem)">
                  <template #icon><DeleteOutlined /></template>
                </AButton>
              </ATooltip>
            </ASpace>
          </template>
        </template>
      </ATable>
    </ACard>

    <AModal v-model:open="detailModalVisible" title="评论详情" :width="wideModalWidth">
      <AForm v-if="currentComment" :model="currentComment" :label-col="{ span: 3 }" :wrapper-col="{ span: 20 }">
        <AFormItem label="路由">
          <AInput :value="currentComment.routerUrl" disabled />
        </AFormItem>
        <AFormItem label="头像">
          <AAvatar :size="40" :src="currentComment.avatar" />
        </AFormItem>
        <AFormItem label="昵称">
          <AInput :value="currentComment.nickname" disabled />
        </AFormItem>
        <AFormItem label="评论内容">
          <ATextarea :value="currentComment.content" disabled :rows="4" />
        </AFormItem>
        <AFormItem label="网站">
          <AInput :value="currentComment.website" disabled />
        </AFormItem>
        <AFormItem label="邮箱">
          <AInput :value="currentComment.mail" disabled />
        </AFormItem>
        <AFormItem label="发布时间">
          <AInput :value="formatDateTime(currentComment.createdAt)" disabled />
        </AFormItem>
        <AFormItem label="状态">
          <ATag :color="getStatusMeta(currentComment.status).color">{{ getStatusMeta(currentComment.status).label }}</ATag>
        </AFormItem>
        <AFormItem label="原因">
          <ATextarea :value="currentComment.reason" disabled :rows="4" />
        </AFormItem>
      </AForm>
      <template #footer>
        <div class="flex justify-end">
          <AButton @click="detailModalVisible = false">退出</AButton>
        </div>
      </template>
    </AModal>

    <AModal v-model:open="examineModalVisible" title="审核评论" :width="modalWidth" :footer="null">
      <AForm ref="formRef" :rules="rules" :model="examineForm" :layout="appStore.isMobile ? 'vertical' : 'horizontal'" :label-col="labelCol">
        <AFormItem label="状态" name="status">
          <ARadioGroup v-model:value="examineForm.status">
            <ARadio :value="2">通过</ARadio>
            <ARadio :value="3">不通过</ARadio>
          </ARadioGroup>
        </AFormItem>
        <AFormItem v-if="examineForm.status === 3" label="原因" name="reason">
          <ATextarea v-model:value="examineForm.reason" :rows="6" placeholder="请填写审核不通过的原因" />
        </AFormItem>
      </AForm>

      <div class="modal-footer mt-6 flex justify-end gap-3 border-t border-gray-200 pt-4 dark:border-gray-600">
        <AButton size="middle" @click="examineModalVisible = false">取消</AButton>
        <AButton type="primary" size="middle" :loading="submitLoading" @click="handleExamine">确定</AButton>
      </div>
    </AModal>

    <AModal v-model:open="deleteModalVisible" title="删除评论" :width="deleteModalWidth" :footer="null" wrap-class-name="delete-dialog">
      <div class="delete-content py-4">
        <div class="mb-4 flex items-center">
          <div class="warning-icon mr-3 flex h-8 w-8 items-center justify-center rounded-full">
            <DeleteOutlined />
          </div>
          <div>
            <div class="font-medium text-gray-900 dark:text-white">确认删除评论</div>
            <div class="mt-1 text-sm text-gray-500 dark:text-gray-400">请选择删除类型，谨慎操作</div>
          </div>
        </div>

        <div class="delete-info mb-4 rounded-lg p-4">
          <p class="text-sm">是否确定要删除该评论，以及其子评论？</p>
        </div>

        <div class="delete-type-selection mb-4">
          <div class="mb-3 text-sm font-medium">删除类型：</div>
          <ARadioGroup v-model:value="deleteType" class="w-full">
            <div class="flex flex-col gap-3">
              <ARadio :value="1" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(1)">
                <div class="ml-2">
                  <div class="font-medium">逻辑删除</div>
                  <div class="mt-1 text-xs text-gray-500">评论将被标记为已删除，但数据仍保留在数据库中，可以恢复</div>
                </div>
              </ARadio>
              <ARadio :value="2" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(2)">
                <div class="ml-2">
                  <div class="font-medium">物理删除</div>
                  <div class="mt-1 text-xs text-gray-500">评论将从数据库中彻底删除，包括所有回复，此操作不可撤销</div>
                </div>
              </ARadio>
              <ARadio :value="3" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(3)">
                <div class="ml-2">
                  <div class="font-medium">取消删除</div>
                  <div class="mt-1 text-xs text-gray-500">恢复已删除的评论，使其重新可见</div>
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
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, reactive, ref } from 'vue';
import type { Dayjs } from 'dayjs';
import type { FormInstance, FormProps, TableColumnsType, TablePaginationConfig } from 'ant-design-vue';
import { message } from 'ant-design-vue';
import { DeleteOutlined, EditOutlined, FileTextOutlined, ReloadOutlined, SearchOutlined } from '@ant-design/icons-vue';
import {
  deleteComment,
  examineComment,
  getCommentPageList,
  type AdminCommentPageItem
} from '@/service/blog/admin/comment';
import { useAppStore } from '@/store/system/app';
import type { TimeSortOrder } from '@/utils/date-time';
import { compareDateTime, formatDateTime, getAntdTimeSortOrder, getTableSortOrder, resolveTimeSortOrder } from '@/utils/date-time';

const appStore = useAppStore();
const loading = ref(false);
const tableData = ref<AdminCommentPageItem[]>([]);
const total = ref(0);
const dateRange = ref<[Dayjs, Dayjs] | undefined>();
const detailModalVisible = ref(false);
const examineModalVisible = ref(false);
const deleteModalVisible = ref(false);
const currentComment = ref<AdminCommentPageItem | null>(null);
const deleteType = ref<number | null>(null);
const submitLoading = ref(false);
const deleteLoading = ref(false);
const formRef = ref<FormInstance>();

const query = reactive({
  pageNumber: 1,
  pageSize: 10,
  routerUrl: '',
  startDate: '',
  endDate: '',
  status: undefined as number | undefined,
  sortOrder: 'timeDesc' as TimeSortOrder
});
const examineForm = reactive({ status: 2, reason: '' });
const rules: FormProps['rules'] = {
  status: [{ required: true, message: '状态不能为空', trigger: 'blur' }],
  reason: [{ required: true, message: '原因不能为空', trigger: 'blur' }]
};

const modalWidth = computed(() => (appStore.isMobile ? '92vw' : 500));
const deleteModalWidth = computed(() => (appStore.isMobile ? '92vw' : 550));
const wideModalWidth = computed(() => (appStore.isMobile ? '92vw' : 700));
const labelCol = computed(() => (appStore.isMobile ? undefined : { span: 5 }));
const pagination = computed<TablePaginationConfig>(() => ({
  current: query.pageNumber,
  pageSize: query.pageSize,
  total: total.value,
  showSizeChanger: true,
  showTotal: value => `共 ${value} 条`,
  size: appStore.isMobile ? 'small' : 'default'
}));

const columns = computed<TableColumnsType<AdminCommentPageItem>>(() => [
  { title: '序号', key: 'index', width: 80, align: 'center' },
  { title: '路由', dataIndex: 'routerUrl', key: 'routerUrl', width: 260, ellipsis: true },
  { title: '头像', key: 'avatar', width: 70 },
  { title: '昵称', dataIndex: 'nickname', key: 'nickname', width: 160, ellipsis: true },
  { title: '评论内容', dataIndex: 'content', key: 'content', width: 280, ellipsis: true },
  {
    title: '发布时间',
    dataIndex: 'createdAt',
    key: 'createdAt',
    width: 180,
    align: 'center',
    sorter: (a, b) => compareDateTime(a.createdAt, b.createdAt),
    sortOrder: getAntdTimeSortOrder(query.sortOrder),
    sortDirections: ['descend', 'ascend']
  },
  { title: '状态', key: 'status', width: 100, align: 'center' },
  { title: '删除状态', key: 'isDeleted', width: 100, align: 'center' },
  { title: '操作', key: 'action', width: 150, align: 'center', fixed: 'right', className: 'blog-admin-action-column' }
]);
const tableScrollX = 1200;
const tableScrollY = computed(() => (appStore.isMobile ? 'calc(100vh - 380px)' : 'calc(100vh - 420px)'));

function isCommentDeleted(record: AdminCommentPageItem) {
  return record.isDeleted === true || Number(record.isDeleted) === 1;
}
const currentDeleteCommentDeleted = computed(() =>
  currentComment.value ? isCommentDeleted(currentComment.value) : false
);
function isDeleteTypeDisabled(type: number) {
  if (type === 1) return currentDeleteCommentDeleted.value;
  if (type === 3) return !currentDeleteCommentDeleted.value;
  return false;
}

function getStatusMeta(status: number) {
  if (status === 2) return { color: 'green', label: '正常' };
  if (status === 3) return { color: 'red', label: '审核不通过' };
  return { color: 'orange', label: '待审核' };
}

async function loadData() {
  loading.value = true;
  try {
    const res = await getCommentPageList({ ...query });
    if (res.success) {
      tableData.value = res.data.items || res.data.records || [];
      total.value = res.data.totalCount || res.data.total || 0;
    }
  } finally {
    loading.value = false;
  }
}

function handleDateChange(_: unknown, dateStrings: [string, string]) {
  query.startDate = dateStrings[0];
  query.endDate = dateStrings[1];
}

function handleTableChange(page: TablePaginationConfig, ...changeArgs: [unknown?, unknown?]) {
  query.pageNumber = page.current || 1;
  query.pageSize = page.pageSize || 10;
  query.sortOrder = resolveTimeSortOrder(getTableSortOrder(changeArgs[1]), query.sortOrder);
  loadData();
}

function handleReset() {
  Object.assign(query, { pageNumber: 1, routerUrl: '', startDate: '', endDate: '', status: undefined });
  dateRange.value = undefined;
  loadData();
}

function openDetailModal(record: AdminCommentPageItem) {
  currentComment.value = record;
  detailModalVisible.value = true;
}

function openExamineModal(record: AdminCommentPageItem) {
  currentComment.value = record;
  examineForm.status = 2;
  examineForm.reason = '';
  examineModalVisible.value = true;
}

async function handleExamine() {
  if (!currentComment.value) return;

  await formRef.value?.validate();
  submitLoading.value = true;
  try {
    const res = await examineComment(currentComment.value.id, { status: examineForm.status, reason: examineForm.reason || null });
    if (res.success) {
      message.success('审核完成');
      currentComment.value = null;
      examineForm.status = 2;
      examineForm.reason = '';
      examineModalVisible.value = false;
      await loadData();
    }
  } finally {
    submitLoading.value = false;
  }
}

function openDeleteModal(record: AdminCommentPageItem) {
  currentComment.value = record;
  deleteType.value = isCommentDeleted(record) ? 3 : 1;
  deleteModalVisible.value = true;
}

function handleDeleteCancel() {
  deleteModalVisible.value = false;
  currentComment.value = null;
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
  if (!currentComment.value || !deleteType.value || isDeleteTypeDisabled(deleteType.value)) return;

  deleteLoading.value = true;
  try {
    const res = await deleteComment(currentComment.value.id, deleteType.value);
    if (res.success) {
      message.success(`${getDeleteButtonText()}成功`);
      await loadData();
      handleDeleteCancel();
    }
  } finally {
    deleteLoading.value = false;
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

.comment-detail {
  overflow-x: auto;
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

.comment-route-link,
.comment-text-cell {
  max-width: 100%;
  overflow-wrap: anywhere;
  word-break: break-word;
}

.comment-route-link {
  display: -webkit-box;
  overflow: hidden;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
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

:global(html:not(.dark)) :deep(.deleted-row) {
  background-color: #f5f5f5 !important;
  color: #999 !important;

  &:hover {
    background-color: #f5f5f5 !important;
  }
}

:global(html.dark) .table-card :deep(.deleted-row) {
  background-color: rgb(45 52 63) !important;
  color: rgb(148 163 184) !important;

  &:hover {
    background-color: rgb(51 60 74) !important;
  }
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

  .comment-detail :deep(.ant-descriptions) {
    min-width: 560px;
  }
}
</style>
