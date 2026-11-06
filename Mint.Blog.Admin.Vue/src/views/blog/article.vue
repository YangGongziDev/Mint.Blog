<template>
  <div class="h-full min-h-0 overflow-hidden flex flex-col gap-4 p-4">
    <ACard :bordered="false" class="card-wrapper search-card">
      <ASpace wrap>
        <AInput v-model:value="query.title" placeholder="文章标题" allow-clear style="width: 180px" @press-enter="search" />
        <ASelect v-model:value="query.categoryId" :options="categoryOptions" placeholder="分类" allow-clear style="width: 160px" />
        <ASelect v-model:value="query.tagId" :options="tagOptions" placeholder="标签" allow-clear show-search option-filter-prop="label" style="width: 160px" />
        <ASelect v-model:value="query.tagVersionId" :options="versionOptions" placeholder="全部版本" allow-clear style="width: 160px" :loading="versionsLoading" :disabled="!query.tagId || !versionsReady" />
        <ARangePicker v-model:value="dateRange" @change="changeDates" /><AButton @click="search">查询</AButton><AButton @click="reset">重置</AButton>
        <AButton type="primary" :disabled="!canWrite" @click="router.push({ name: 'blog_article-create' })">写文章</AButton><AButton @click="openDrafts">草稿箱</AButton>
      </ASpace>
    </ACard>
    <ACard :bordered="false" class="card-wrapper table-card">
      <AAlert v-if="error" type="error" :message="error" class="my-3"><template #action><AButton @click="refresh">重试</AButton></template></AAlert>
      <ATable :columns="columns" :data-source="items" row-key="id" :loading="loading" :pagination="pagination" :scroll="{ x: 1800, y: '100%' }" @change="changePage">
        <template #bodyCell="{ column, record }">
          <template v-if="column.key === 'cover'"><AImage :src="record.cover" :width="90" /></template>
          <template v-else-if="column.key === 'version'"><ATag v-if="record.isGeneral">通用</ATag><template v-else>{{ record.tagVersionName }}</template></template>
          <template v-else-if="column.key === 'top'"><ASwitch :checked="record.isTop" :disabled="!canWrite || busy" @change="value => changeTop(record.id, Boolean(value))" /></template>
          <template v-else-if="column.key === 'visibility'"><ASwitch :checked="record.visibility === 2" checked-children="专栏" un-checked-children="公开" :disabled="!canWrite || busy" @change="value => changeVisibility(record.id, Boolean(value))" /></template>
          <template v-else-if="column.key === 'deleted'">{{ deleted(record as AdminArticleListItem) ? '已删除' : '正常' }}</template>
          <template v-else-if="column.key === 'time'">{{ formatDateTime(record.createTime || record.createdAt || '') }}</template>
          <template v-else-if="column.key === 'action'"><div class="table-actions table-actions-grid">
            <AButton type="link" size="small" :disabled="!canWrite" @click="router.push({ name: 'blog_article-edit', params: { id: record.id } })"><EditOutlined />编辑</AButton><AButton type="link" size="small" @click="previewArticle(record.id)"><EyeOutlined />预览</AButton><AButton type="link" size="small" danger :disabled="!canWrite || busy" @click="openDelete(record as AdminArticleListItem)"><DeleteOutlined />删除 / 恢复</AButton>
          </div></template>
        </template>
      </ATable>
    </ACard>
    <AModal :open="!!deleteTarget" title="删除或恢复文章" :confirm-loading="busy" :mask-closable="false" :ok-button-props="{ disabled: !canWrite || busy }" @cancel="!busy && (deleteTarget = undefined)" @ok="confirmDelete">
      <p>{{ deleteTarget?.title }}</p><p class="my-3">{{ deleteTarget?.categoryName }} / {{ deleteTarget?.tagName }} / {{ deleteTarget?.tagVersionName }}{{ deleteTarget?.isGeneral ? '（通用）' : '' }}</p>
      <ARadioGroup v-model:value="deleteType"><ASpace direction="vertical"><ARadio :value="1" :disabled="!!deleteTarget && deleted(deleteTarget)">软删除</ARadio><ARadio :value="2">物理删除（不可撤销，清理相关图片）</ARadio><ARadio :value="3" :disabled="!deleteTarget || !deleted(deleteTarget)">恢复</ARadio></ASpace></ARadioGroup>
      <AAlert class="mt-4" message="恢复时必须满足有效标签、版本和分类约束；失效关联请先修复，不能自动替换为通用版本。" />
    </AModal>
    <AModal v-model:open="draftsVisible" title="草稿箱" :footer="null" width="1100px">
      <ATable :data-source="drafts" row-key="id" :loading="draftsLoading" :pagination="false" :scroll="{ x: 1000, y: 'max(120px, calc(100dvh - 320px))' }">
        <ATableColumn title="标题" data-index="title" /><ATableColumn title="类型"><template #default="{ record }">{{ record.isNewArticleDraft ? '新增草稿' : '修改草稿' }}</template></ATableColumn>
        <ATableColumn title="分类" data-index="categoryName" /><ATableColumn title="标签" data-index="tagName" /><ATableColumn title="版本"><template #default="{ record }"><ATag v-if="record.isGeneral">通用</ATag><template v-else>{{ record.tagVersionName || '尚未选择' }}</template></template></ATableColumn>
        <ATableColumn title="更新时间"><template #default="{ record }">{{ formatDateTime(record.updatedAt) }}</template></ATableColumn>
        <ATableColumn title="操作" fixed="right" align="center" :width="200"><template #default="{ record }"><div class="table-actions table-actions-grid"><AButton type="link" size="small" @click="preview?.openArticle(record.id, true)"><EyeOutlined />预览</AButton><AButton type="link" size="small" :disabled="!canWrite" @click="editDraft(record)"><EditOutlined />编辑</AButton><AButton type="link" size="small" :disabled="!canWrite || busy" @click="publishDraft(record)"><UploadOutlined />发布</AButton><APopconfirm title="删除草稿并清理未使用图片？" @confirm="removeDraft(record.id)"><AButton type="link" size="small" danger :disabled="!canWrite || busy"><DeleteOutlined />删除</AButton></APopconfirm></div></template></ATableColumn>
      </ATable>
    </AModal>
    <AuthorizedPreview ref="preview" />
  </div>
</template>

<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, reactive, ref, watch } from 'vue';
import { useRouter } from 'vue-router';
import { message, type TableColumnsType, type TablePaginationConfig } from 'ant-design-vue';
import type { Dayjs } from 'dayjs';
import { DeleteOutlined, EditOutlined, EyeOutlined, UploadOutlined } from '@ant-design/icons-vue';
import { deleteArticle, deleteArticleDraft, getArticleDraftPageList, getArticlePageList, publishArticleDraft, setArticleTop, setArticleVisibility, type AdminArticleListItem, type ArticleDraftListItem, type ArticlePageQuery } from '@/api/blog/article';
import { getCategoryList, type CategoryListItem } from '@/api/blog/category';
import { getTagList, type TagListItem } from '@/api/blog/tag';
import { getTagVersions, type TagVersion } from '@/api/blog/resource';
import { useAuth } from '@/hooks/auth/use-auth';
import { useAuthStore } from '@/store/system/auth';
import { formatDateTime, getTableSortOrder, resolveTimeSortOrder } from '@/utils/date-time';
import { getBlogWebUrl } from '@/utils/blog-web-url';
import { sortOptionsByLabel } from '@/utils/common';
import AuthorizedPreview from '@/components/blog/authorized-preview.vue';

defineOptions({ name: 'BlogArticleList' });
const router = useRouter();
const { isReadonly } = useAuth();
const auth = useAuthStore();
const canWrite = computed(() => !isReadonly.value && auth.userInfo.roles.some(role => ['ROLE_ADMIN', 'ROLE_SUPER'].includes(role)));
const preview = ref<InstanceType<typeof AuthorizedPreview>>();
const query = reactive<ArticlePageQuery>({ pageNumber: 1, pageSize: 20, title: '', categoryId: undefined, tagId: undefined, tagVersionId: undefined });
const dateRange = ref<[Dayjs, Dayjs]>();
const categories = ref<CategoryListItem[]>([]);
const tags = ref<TagListItem[]>([]);
const versions = ref<TagVersion[]>([]);
const categoryOptions = computed(() => sortOptionsByLabel(categories.value.map(item => ({ value: item.id, label: item.name })), option => option.label));
const tagOptions = computed(() => sortOptionsByLabel(tags.value.map(item => ({ value: item.id, label: item.name })), option => option.label));
const versionOptions = computed(() => sortOptionsByLabel(versions.value.map(item => ({ value: item.id, label: `${item.name}${item.isGeneral ? '（通用）' : ''}` })), option => option.label));
const versionsLoading = ref(false);
const versionsReady = ref(false);
const items = ref<AdminArticleListItem[]>([]);
const total = ref(0);
const loading = ref(false);
const busy = ref(false);
const error = ref('');
const draftsVisible = ref(false);
const draftsLoading = ref(false);
const drafts = ref<ArticleDraftListItem[]>([]);
const deleteTarget = ref<AdminArticleListItem>();
const deleteType = ref<1 | 2 | 3>(1);
const deleted = (record: AdminArticleListItem) => record.isDeleted === true || record.isDeleted === 1;
const pagination = computed(() => ({ current: query.pageNumber, pageSize: query.pageSize, total: total.value, showSizeChanger: true }));
const columns: TableColumnsType<AdminArticleListItem> = [
  { title: '标题', dataIndex: 'title', width: 220, ellipsis: true }, { title: '摘要', dataIndex: 'summary', width: 250, ellipsis: true }, { title: '封面', key: 'cover', width: 110 },
  { title: '分类', dataIndex: 'categoryName', width: 130 }, { title: '标签', dataIndex: 'tagName', width: 130 }, { title: '版本', key: 'version', width: 150 },
  { title: '置顶', key: 'top', width: 80 }, { title: '可见性', key: 'visibility', width: 100 }, { title: '状态', key: 'deleted', width: 100 },
  { title: '发布时间', key: 'time', width: 180, sorter: true }, { title: '操作', key: 'action', width: 240, align: 'center', fixed: 'right' }
];
let disposed = false;
let listRequest = 0;
let versionRequest = 0;
let optionsRequest = 0;
let draftsRequest = 0;
async function loadVersions() {
  const request = ++versionRequest;
  const tagId = query.tagId;
  versions.value = [];
  versionsReady.value = false;
  versionsLoading.value = !!tagId;
  if (!tagId) return;
  try {
    const response = await getTagVersions(tagId);
    if (disposed || request !== versionRequest || query.tagId !== tagId) return;
    if (!response.success) throw new Error();
    versions.value = response.data;
    versionsReady.value = true;
  } catch { if (!disposed && request === versionRequest) error.value = '标签版本加载失败，请重试'; }
  finally { if (!disposed && request === versionRequest) versionsLoading.value = false; }
}
async function loadOptions() {
  const request = ++optionsRequest;
  const [categoryResponse, tagResponse] = await Promise.all([getCategoryList(), getTagList()]);
  if (disposed || request !== optionsRequest) return;
  if (!categoryResponse.success || !tagResponse.success) throw new Error('分类或标签加载失败');
  categories.value = categoryResponse.data;
  tags.value = tagResponse.data;
}
async function loadData() {
  const request = ++listRequest;
  loading.value = true;
  error.value = '';
  try {
    const response = await getArticlePageList({ ...query });
    if (disposed || request !== listRequest) return;
    if (!response.success) throw new Error();
    items.value = response.data.items;
    total.value = response.data.totalCount;
  } catch { if (!disposed && request === listRequest) error.value = '文章列表加载失败'; }
  finally { if (!disposed && request === listRequest) loading.value = false; }
}
function search() { query.pageNumber = 1; void loadData(); }
function reset() { Object.assign(query, { pageNumber: 1, title: '', categoryId: undefined, tagId: undefined, tagVersionId: undefined, startDate: undefined, endDate: undefined, sortOrder: undefined }); dateRange.value = undefined; search(); }
function changeDates(_value: unknown, dates: [string, string]) { query.startDate = dates[0]; query.endDate = dates[1]; }
function changePage(page: TablePaginationConfig, _filters: unknown, sorter: unknown) { query.pageNumber = page.current ?? 1; query.pageSize = page.pageSize ?? 20; query.sortOrder = resolveTimeSortOrder(getTableSortOrder(sorter), query.sortOrder); void loadData(); }
async function changeTop(id: string, value: boolean) { if (!canWrite.value || busy.value) return; busy.value = true; try { await setArticleTop(id, value); await loadData(); } finally { busy.value = false; } }
async function changeVisibility(id: string, value: boolean) { if (!canWrite.value || busy.value) return; busy.value = true; try { await setArticleVisibility(id, value ? 2 : 1); await loadData(); } finally { busy.value = false; } }
function openDelete(record: AdminArticleListItem) { deleteTarget.value = record; deleteType.value = deleted(record) ? 3 : 1; }
async function confirmDelete() {
  if (!canWrite.value || busy.value || !deleteTarget.value) return;
  busy.value = true;
  try { const response = await deleteArticle(deleteTarget.value.id, deleteType.value); if (!response.success || disposed) return; deleteTarget.value = undefined; message.success('操作成功'); await loadData(); }
  finally { busy.value = false; }
}
async function openDrafts() {
  const request = ++draftsRequest;
  draftsVisible.value = true;
  draftsLoading.value = true;
  try { const response = await getArticleDraftPageList({ pageNumber: 1, pageSize: 100 }); if (!disposed && request === draftsRequest && response.success) drafts.value = response.data.items ?? response.data.records ?? []; }
  finally { if (!disposed && request === draftsRequest) draftsLoading.value = false; }
}
function editDraft(record: ArticleDraftListItem) { draftsVisible.value = false; void router.push(record.articleId ? { name: 'blog_article-edit', params: { id: record.articleId }, query: { draftId: record.id } } : { name: 'blog_article-create', query: { draftId: record.id } }); }
async function publishDraft(record: ArticleDraftListItem) {
  if (!canWrite.value || busy.value) return;
  if (!record.tagId || !record.tagVersionId) { message.warning('草稿缺少标签或版本，请先编辑补全'); return; }
  busy.value = true;
  try { const response = await publishArticleDraft(record.id); if (response.success && !disposed) { message.success('草稿已发布'); await Promise.all([openDrafts(), loadData()]); } }
  finally { busy.value = false; }
}
async function removeDraft(id: string) { if (!canWrite.value || busy.value) return; busy.value = true; try { const response = await deleteArticleDraft(id); if (response.success && !disposed) await openDrafts(); } finally { busy.value = false; } }
function previewArticle(id: string) { const url = getBlogWebUrl('article', id); if (!url) { message.warning('请配置有效前台地址'); return; } window.open(url, '_blank', 'noopener,noreferrer'); }
async function refresh() { try { await Promise.all([loadOptions(), loadVersions(), loadData()]); } catch { if (!disposed) error.value = '分类或标签加载失败'; } }
watch(() => query.tagId, () => { query.tagVersionId = undefined; void loadVersions(); }, { flush: 'sync' });
onMounted(refresh);
onBeforeUnmount(() => { disposed = true; ++listRequest; ++versionRequest; ++optionsRequest; ++draftsRequest; });
</script>

<style scoped lang="scss">
.search-card {
  flex-shrink: 0;
}
.table-card {
  display: flex;
  flex: 1;
  min-height: 0;
  overflow: hidden;
  flex-direction: column;
}
.table-card :deep(.ant-card-body),
.table-card :deep(.ant-table-wrapper),
.table-card :deep(.ant-spin-nested-loading),
.table-card :deep(.ant-spin-container),
.table-card :deep(.ant-table),
.table-card :deep(.ant-table-container) {
  display: flex;
  flex: 1;
  min-height: 0;
  flex-direction: column;
}
.table-card :deep(.ant-card-body) {
  overflow: hidden;
}
.table-card :deep(.ant-card-head),
.table-card :deep(.ant-alert),
.table-card :deep(.ant-table-header),
.table-card :deep(.ant-table-pagination) {
  flex-shrink: 0;
}
.table-card :deep(.ant-table-body) {
  flex: 1;
  min-height: 0;
  overflow-y: auto !important;
}
.table-actions-grid {
  display: grid;
  grid-template-columns: repeat(2, max-content);
  justify-content: center;
  gap: 4px 8px;
}
.table-actions :deep(.ant-btn) { white-space: nowrap; }
</style>
