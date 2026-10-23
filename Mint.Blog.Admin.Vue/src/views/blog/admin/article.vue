<template>
  <div class="category-page flex h-full min-h-0 w-full flex-col overflow-hidden">
    <div class="flex-shrink-0 bg-layout pb-4">
      <ACard :bordered="false" class="card-wrapper">
        <AForm layout="inline" class="responsive-search-form">
          <AFormItem label="文章标题">
            <AInput
              v-model:value="query.title"
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
              <AButton type="primary" class="w-full sm:w-auto" @click="goToCreateArticle">
                <template #icon><EditOutlined /></template>
                写文章
              </AButton>
              <AButton class="w-full sm:w-auto" @click="openDraftModal">草稿箱</AButton>
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
        :row-class-name="record => (isArticleDeleted(record as AdminArticleListItem) ? 'deleted-row' : '')"
        :scroll="{ x: tableScrollX, y: tableScrollY }"
        bordered
        size="middle"
        @change="handleTableChange"
      >
        <template #bodyCell="{ column, record, index }">
          <template v-if="column.key === 'index'">{{ index + 1 }}</template>
          <template v-else-if="column.key === 'title'">
            <ATypographyParagraph :content="record.title" :ellipsis="{ rows: 2 }" class="table-text-cell !mb-0" />
          </template>
          <template v-else-if="column.key === 'summary'">
            <ATypographyParagraph :content="record.summary" :ellipsis="{ rows: 2 }" class="table-text-cell !mb-0" />
          </template>
          <template v-else-if="column.key === 'cover'">
            <AImage :width="100" :src="record.cover" />
          </template>
          <template v-else-if="column.key === 'isTop'">
            <ASwitch
              v-model:checked="record.isTop"
              checked-children="置顶"
              un-checked-children="普通"
              class="top-switch"
              @change="() => handleTopChange(record.id, record.isTop)"
            />
          </template>
          <template v-else-if="column.key === 'visibility'">
            <ASwitch
              :checked="record.visibility === 2"
              checked-children="专栏"
              un-checked-children="公开"
              @change="checked => handleVisibilityChange(record as AdminArticleListItem, checked as boolean)"
            />
          </template>
          <template v-else-if="column.key === 'isDeleted'">
            <ATag :color="isArticleDeleted(record as AdminArticleListItem) ? 'error' : 'success'" class="status-tag">
              {{ isArticleDeleted(record as AdminArticleListItem) ? '已删除' : '未删除' }}
            </ATag>
          </template>
          <template v-else-if="column.key === 'createTime'">
            {{ getCreateTime(record as AdminArticleListItem) }}
          </template>
          <template v-else-if="column.key === 'action'">
            <ASpace>
              <ATooltip title="编辑">
                <AButton size="small" shape="circle" @click="goToEditArticle(record.id)">
                  <template #icon><EditOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="预览">
                <AButton size="small" shape="circle" @click="goArticleDetailPage(record.id)">
                  <template #icon><EyeOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="删除">
                <AButton danger size="small" shape="circle" @click="openDeleteModal(record as AdminArticleListItem)">
                  <template #icon><DeleteOutlined /></template>
                </AButton>
              </ATooltip>
            </ASpace>
          </template>
        </template>
      </ATable>
    </ACard>

    <AModal
      v-model:open="deleteModalVisible"
      title="删除文章"
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
            <div class="font-medium text-gray-900 dark:text-white">确认删除文章</div>
            <div class="mt-1 text-sm text-gray-500 dark:text-gray-400">请选择删除类型，谨慎操作</div>
          </div>
        </div>
        <div class="delete-info mb-4 rounded-lg p-4">
          <p class="text-sm">
            是否确定要删除文章
            <span class="font-medium">"{{ currentDeleteArticle?.title }}"</span>
            ？
          </p>
        </div>
        <div class="delete-type-selection mb-4">
          <div class="mb-3 text-sm font-medium">删除类型：</div>
          <ARadioGroup v-model:value="deleteType" class="w-full">
            <div class="flex flex-col gap-3">
              <ARadio :value="1" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(1)">
                <div class="ml-2">
                  <div class="font-medium">逻辑删除</div>
                  <div class="mt-1 text-xs text-gray-500">文章将被标记为已删除，但数据仍保留在数据库中，可以恢复</div>
                </div>
              </ARadio>
              <ARadio :value="2" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(2)">
                <div class="ml-2">
                  <div class="font-medium">物理删除</div>
                  <div class="mt-1 text-xs text-gray-500">文章将从数据库中彻底删除，包括相关图片，此操作不可撤销</div>
                </div>
              </ARadio>
              <ARadio :value="3" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(3)">
                <div class="ml-2">
                  <div class="font-medium">取消删除</div>
                  <div class="mt-1 text-xs text-gray-500">恢复已删除的文章，将删除状态重置为未删除</div>
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
          @click="confirmDelete"
        >
          {{ getDeleteButtonText() }}
        </AButton>
      </div>
    </AModal>

    <AModal v-model:open="draftModalVisible" title="草稿箱" :footer="null" width="900px">
      <ATable :data-source="draftData" :loading="draftLoading" :pagination="false" :row-key="record => record.id" size="middle">
        <ATableColumn title="标题" data-index="title" key="title">
          <template #default="{ record }">
            <ATypographyParagraph :content="record.title" :ellipsis="{ rows: 2 }" class="draft-title-cell !mb-0" />
          </template>
        </ATableColumn>
        <ATableColumn title="类型" key="type">
          <template #default="{ record }">
            <ATag :color="record.isNewArticleDraft ? 'processing' : 'warning'">
              {{ record.isNewArticleDraft ? '新增草稿' : '修改草稿' }}
            </ATag>
          </template>
        </ATableColumn>
        <ATableColumn title="分类" data-index="categoryName" key="categoryName" />
        <ATableColumn
          title="更新时间"
          data-index="updatedAt"
          key="updatedAt"
          :sorter="
            (a: unknown, b: unknown) =>
              compareDateTime((a as ArticleDraftListItem).updatedAt, (b as ArticleDraftListItem).updatedAt)
          "
          default-sort-order="descend"
          :sort-directions="['descend', 'ascend']"
        >
          <template #default="{ record }">
            {{ formatDateTime(record.updatedAt) }}
          </template>
        </ATableColumn>
        <ATableColumn title="操作" key="action" :width="220">
          <template #default="{ record }">
            <ASpace>
              <AButton size="small" type="link" @click="goToEditDraft(record)">编辑</AButton>
              <AButton size="small" type="link" @click="handlePublishDraft(record)">发布</AButton>
              <APopconfirm title="删除草稿后会清理仅被该草稿使用的图片，确定删除？" @confirm="handleDeleteDraft(record)">
                <AButton size="small" type="link" danger>删除</AButton>
              </APopconfirm>
            </ASpace>
          </template>
        </ATableColumn>
      </ATable>
    </AModal>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, reactive, ref } from 'vue';
import { useRouter } from 'vue-router';
import type { TableColumnsType, TablePaginationConfig } from 'ant-design-vue';
import { message } from 'ant-design-vue';
import type { Dayjs } from 'dayjs';
import { DeleteOutlined, EditOutlined, EyeOutlined, ReloadOutlined, SearchOutlined } from '@ant-design/icons-vue';
import {
  type AdminArticleListItem,
  type ArticleDraftListItem,
  deleteArticle,
  deleteArticleDraft,
  getArticleDraftPageList,
  getArticlePageList,
  publishArticleDraft,
  setArticleTop,
  setArticleVisibility
} from '@/service/blog/admin/article';
import { useAppStore } from '@/store/system/app';
import type { TimeSortOrder } from '@/utils/date-time';
import { compareDateTime, formatDateTime, getAntdTimeSortOrder, getTableSortOrder, resolveTimeSortOrder } from '@/utils/date-time';

defineOptions({ name: 'BlogAdminArticleList' });

const router = useRouter();
const appStore = useAppStore();
const loading = ref(false);
const tableData = ref<AdminArticleListItem[]>([]);
const draftModalVisible = ref(false);
const draftLoading = ref(false);
const draftData = ref<ArticleDraftListItem[]>([]);
const total = ref(0);
const deleteModalVisible = ref(false);
const deleteLoading = ref(false);
const currentDeleteArticle = ref<AdminArticleListItem | null>(null);
const deleteType = ref<number | null>(null);
const dateRange = ref<[Dayjs, Dayjs] | undefined>();
const query = reactive({
  pageNumber: 1,
  pageSize: 20,
  title: '',
  startDate: '',
  endDate: '',
  sortOrder: undefined as TimeSortOrder | undefined
});
const pagination = computed<TablePaginationConfig>(() => ({
  current: query.pageNumber,
  pageSize: query.pageSize,
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
  showTotal: (value, range) => `第 ${range[0]}-${range[1]} 条，共 ${value} 条`,
  size: appStore.isMobile ? 'small' : 'default'
}));
const deleteModalWidth = computed(() => (appStore.isMobile ? '92vw' : 550));
const columns = computed<TableColumnsType<AdminArticleListItem>>(() => [
  { title: '序号', key: 'index', width: 80, align: 'center' },
  { title: '标题', dataIndex: 'title', key: 'title', width: 220, align: 'center', ellipsis: true },
  { title: '摘要', dataIndex: 'summary', key: 'summary', width: 380, align: 'center', ellipsis: true },
  { title: '封面', dataIndex: 'cover', key: 'cover', width: 180, align: 'center' },
  { title: '是否置顶', dataIndex: 'isTop', key: 'isTop', width: 100, align: 'center' },
  { title: '仅专栏可见', dataIndex: 'visibility', key: 'visibility', width: 120, align: 'center' },
  { title: '删除状态', dataIndex: 'isDeleted', key: 'isDeleted', width: 100, align: 'center' },
  {
    title: '发布时间',
    dataIndex: 'createTime',
    key: 'createTime',
    width: 180,
    align: 'center',
    sorter: (a, b) => compareDateTime(getRawCreateTime(a), getRawCreateTime(b)),
    sortOrder: query.sortOrder ? getAntdTimeSortOrder(query.sortOrder) : undefined,
    sortDirections: ['descend', 'ascend']
  },
  { title: '操作', key: 'action', width: 150, align: 'center' }
]);
const tableScrollX = 1320;
const tableScrollY = computed(() => (appStore.isMobile ? 'calc(100vh - 400px)' : 'calc(100vh - 440px)'));
async function loadData() {
  loading.value = true;
  try {
    const res = await getArticlePageList({ ...query });
    if (res.success) {
      tableData.value = res.data.items || res.data.records || [];
      total.value = res.data.totalCount || res.data.total || 0;
    }
  } finally {
    loading.value = false;
  }
}
function handleTableChange(page: TablePaginationConfig, ...changeArgs: [unknown?, unknown?, { action?: string }?]) {
  query.pageNumber = page.current || 1;
  query.pageSize = page.pageSize || 10;
  if (changeArgs[2]?.action === 'sort') query.sortOrder = resolveTimeSortOrder(getTableSortOrder(changeArgs[1]), query.sortOrder);
  loadData();
}
function handleReset() {
  Object.assign(query, { pageNumber: 1, title: '', startDate: '', endDate: '', sortOrder: undefined });
  dateRange.value = undefined;
  loadData();
}
function handleDateChange(_: unknown, dateStrings: [string, string]) {
  query.startDate = dateStrings[0];
  query.endDate = dateStrings[1];
}
async function handleTopChange(id: string, isTop: boolean) {
  query.sortOrder = undefined;
  const res = await setArticleTop(id, isTop);
  if (res.success) message.success('置顶状态已更新');
  await loadData();
}
async function handleVisibilityChange(record: AdminArticleListItem, checked: boolean) {
  const previousVisibility = record.visibility;
  record.visibility = checked ? 2 : 1;
  try {
    const res = await setArticleVisibility(record.id, record.visibility);
    if (res.success) {
      message.success('仅专栏可见状态已更新');
      return;
    }
  } catch {}
  record.visibility = previousVisibility;
}
function openDeleteModal(record: AdminArticleListItem) {
  currentDeleteArticle.value = record;
  deleteType.value = isArticleDeleted(record) ? 3 : 1;
  deleteModalVisible.value = true;
}
function handleDeleteCancel() {
  deleteModalVisible.value = false;
  currentDeleteArticle.value = null;
  deleteLoading.value = false;
  deleteType.value = null;
}
function getDeleteButtonText() {
  if (deleteType.value === 1) return '逻辑删除';
  if (deleteType.value === 2) return '物理删除';
  if (deleteType.value === 3) return '取消删除';
  return '确定删除';
}
async function confirmDelete() {
  if (!currentDeleteArticle.value || !deleteType.value || isDeleteTypeDisabled(deleteType.value)) return;
  deleteLoading.value = true;
  try {
    const res = await deleteArticle(currentDeleteArticle.value.id, deleteType.value);
    if (res.success) {
      message.success(`${getDeleteButtonText()}成功`);
      await loadData();
      handleDeleteCancel();
    }
  } finally {
    deleteLoading.value = false;
  }
}
function isArticleDeleted(record: AdminArticleListItem) {
  return record.isDeleted === true || Number(record.isDeleted ?? 0) === 1;
}
const currentDeleteArticleDeleted = computed(() =>
  currentDeleteArticle.value ? isArticleDeleted(currentDeleteArticle.value) : false
);
function isDeleteTypeDisabled(type: number) {
  if (type === 1) return currentDeleteArticleDeleted.value;
  if (type === 3) return !currentDeleteArticleDeleted.value;
  return false;
}
function getRawCreateTime(record: AdminArticleListItem) {
  return record.createTime || record.createdAt || '';
}
function getCreateTime(record: AdminArticleListItem) {
  return formatDateTime(getRawCreateTime(record));
}
function goToCreateArticle() {
  router.push({ name: 'blog-admin_article-create' });
}
function goToEditArticle(articleId: string) {
  router.push({ name: 'blog-admin_article-edit', params: { id: articleId } });
}
async function openDraftModal() {
  draftModalVisible.value = true;
  draftLoading.value = true;
  try {
    const res = await getArticleDraftPageList({ pageNumber: 1, pageSize: 100 });
    if (res.success) draftData.value = res.data.items || res.data.records || [];
  } finally {
    draftLoading.value = false;
  }
}
function goToEditDraft(record: ArticleDraftListItem) {
  draftModalVisible.value = false;
  if (record.articleId) {
    router.push({ name: 'blog-admin_article-edit', params: { id: record.articleId }, query: { draftId: record.id } });
    return;
  }
  router.push({ name: 'blog-admin_article-create', query: { draftId: record.id } });
}
async function handlePublishDraft(record: ArticleDraftListItem) {
  const res = await publishArticleDraft(record.id);
  if (res.success) {
    message.success('草稿已发布');
    await openDraftModal();
    await loadData();
  }
}
async function handleDeleteDraft(record: ArticleDraftListItem) {
  const res = await deleteArticleDraft(record.id);
  if (res.success) {
    message.success('草稿已删除，未使用图片已清理');
    await openDraftModal();
  }
}
function goArticleDetailPage(articleId: string) {
  const url = router.resolve({ name: 'blog-surfer_article_detail', params: { id: articleId } }).href;
  window.open(url, '_blank');
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

.table-text-cell {
  max-width: 100%;
  overflow-wrap: anywhere;
  word-break: break-word;
}

.draft-title-cell {
  max-width: 360px;
  overflow-wrap: anywhere;
  word-break: break-word;
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

:global(html.dark) .card-wrapper {
  background: rgb(var(--container-bg-color)) !important;
}

:global(html.dark) .table-card :deep(.ant-card-body) {
  background: rgb(var(--container-bg-color)) !important;
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

:global(html.dark) .table-card :deep(.ant-table-thead > tr > th) {
  color: rgb(var(--base-text-color)) !important;
}

:global(html.dark) :deep(.ant-form-item-label > label) {
  color: rgb(var(--base-text-color)) !important;
}

:global(html.dark) :deep(.ant-empty-description) {
  color: rgb(148 163 184) !important;
}

:global(html.dark) .table-card :deep(.ant-pagination .ant-pagination-total-text) {
  color: rgb(var(--base-text-color));
}
</style>
