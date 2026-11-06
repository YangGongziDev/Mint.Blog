<template>
  <div class="image-page flex h-full min-h-0 w-full flex-col gap-4 overflow-hidden">
    <ACard :bordered="false" class="card-wrapper flex-shrink-0">
      <AForm layout="inline" class="responsive-search-form">
        <AFormItem label="桶名称">
          <ASelect v-model:value="query.bucketName" allow-clear show-search placeholder="请选择桶" :style="{ width: appStore.isMobile ? '100%' : '220px' }" @change="handleBucketChange">
            <ASelectOption v-for="item in sortedBucketOptions" :key="item.name" :value="item.name">{{ item.name }}{{ item.isPublic ? '（公开）' : '（私有）' }}</ASelectOption>
          </ASelect>
        </AFormItem>
        <AFormItem label="图片名称"><AInput v-model:value="query.fileName" allow-clear placeholder="请输入图片名称" class="w-full sm:w-[220px]" @update:value="handleImageNameInput" @press-enter="handleSearch" /></AFormItem>
        <AFormItem label="使用状态"><ASelect v-model:value="query.used" allow-clear placeholder="全部" class="w-full sm:w-[180px]" @change="handleSearch"><ASelectOption v-for="option in usedOptions" :key="option.value" :value="option.value">{{ option.label }}</ASelectOption></ASelect></AFormItem>
        <AFormItem><ASpace wrap>
          <AButton @click="handleReset"><template #icon><ReloadOutlined /></template>重置</AButton>
          <AButton @click="openCreateBucketModal">创建桶</AButton>
          <AButton :disabled="!query.bucketName" @click="openUploadModal">上传图片</AButton>
          <ASwitch v-if="currentBucket" :checked="currentBucket.isPublic" checked-children="公开" un-checked-children="私有" @change="toggleCurrentBucketPublic" />
          <APopconfirm title="确定删除当前桶吗？桶必须为空，默认桶不能删除。" @confirm="confirmDeleteCurrentBucket"><AButton danger :disabled="!query.bucketName">删除桶</AButton></APopconfirm>
          <AButton :disabled="!selectedCount" @click="openBatchMoveModal">批量移动{{ selectedCount ? `（${selectedCount}）` : '' }}</AButton>
          <APopconfirm title="确定批量删除选中的图片吗？正在被文章引用的图片会自动跳过。" @confirm="confirmBatchDelete"><AButton danger :disabled="!selectedCount">批量删除{{ selectedCount ? `（${selectedCount}）` : '' }}</AButton></APopconfirm>
        </ASpace></AFormItem>
      </AForm>
    </ACard>
    <ACard :bordered="false" class="card-wrapper table-card flex-1 min-h-0 overflow-hidden">
      <div v-if="bucketLoadFailed" class="flex flex-1 items-center justify-center px-6 py-10 text-center">
        <div><div class="mb-2 text-base font-semibold text-orange-500">{{ permissionDenied ? '权限不足' : '图片存储服务暂时不可用' }}</div><div class="text-sm text-gray-500">{{ permissionDenied ? '您当前没有权限访问图片管理功能，请确认账号已登录或联系管理员分配访问权限。' : '请检查 RustFS 是否正常启动、桶权限和后端配置是否正确。页面已停止加载图片列表，避免显示旧数据。' }}</div><AButton class="mt-4" @click="onRetryLoadBuckets">重新加载</AButton></div>
      </div>
      <ATable v-else :columns="columns" :data-source="tableData" :loading="loading" :pagination="pagination" :row-key="record => `${record.bucketName}/${record.objectName}`" :row-selection="{ selectedRowKeys, preserveSelectedRowKeys: true, onChange: handleSelectionChange }" :scroll="{ x: 1760, y: tableScrollY }" bordered size="middle" @change="handleTableChange">
        <template #bodyCell="{ column, record, index }">
          <template v-if="column.key === 'index'">{{ index + 1 }}</template>
          <template v-else-if="column.key === 'image'"><AImage :width="88" :height="64" :src="record.url" class="image-preview" /></template>
          <template v-else-if="column.key === 'url'"><div class="url-cell"><ATooltip :title="record.url"><ATypographyLink class="url-text" @click="openImageUrl(record.url)">{{ record.url }}</ATypographyLink></ATooltip><AButton size="small" type="link" @click="copyUrl(record.url)"><template #icon><LinkOutlined /></template>复制</AButton></div></template>
          <template v-else-if="column.key === 'referencedArticles'"><ASpace v-if="record.referencedArticles.length" wrap :size="4"><ATag v-for="article in record.referencedArticles" :key="article.articleId" color="processing" class="reference-tag"><span class="reference-tag-text" :title="article.articleTitle">{{ article.articleTitle }}</span></ATag></ASpace><ATag v-else>未使用</ATag></template>
          <template v-else-if="column.key === 'articleLinks'">
            <ASpace v-if="record.referencedArticles.length" direction="vertical" :size="2" class="w-full">
              <span v-for="article in record.referencedArticles" :key="article.articleId" class="article-link-item">
                <APopconfirm v-if="resolveArticleHref(article.articleUrl)" title="请选择来源链接操作（不作为授权预览）" ok-text="查看来源" cancel-text="复制链接" @confirm="openArticleLink(article.articleUrl)" @cancel="copyArticleLink(article.articleUrl)"><AButton type="link" size="small" class="article-link-button"><span :title="article.articleTitle">{{ article.articleTitle }}</span></AButton></APopconfirm>
                <ATooltip v-else title="公共站点未配置或来源不可用"><span class="text-gray-400">{{ article.articleTitle }}（来源不可用）</span></ATooltip>
              </span>
            </ASpace><span v-else class="text-gray-400">-</span>
          </template>
          <template v-else-if="column.key === 'size'">{{ formatSize(record.size) }}</template>
          <template v-else-if="column.key === 'lastModified'">{{ formatDateTime(record.lastModified) }}</template>
          <template v-else-if="column.key === 'action'"><ASpace class="table-actions">
            <ATooltip title="改名"><AButton type="link" size="small" @click="openRenameModal(record as ManagedImageListItem)"><template #icon><EditOutlined /></template></AButton></ATooltip>
            <AButton type="link" size="small" @click="openMoveModal(record as ManagedImageListItem)"><SwapOutlined />移动</AButton>
            <APopconfirm title="确定删除这张图片吗？如果文章仍在引用，图片会无法显示。" @confirm="confirmDelete(record as ManagedImageListItem)"><AButton type="link" danger size="small" aria-label="删除"><template #icon><DeleteOutlined /></template></AButton></APopconfirm>
          </ASpace></template>
        </template>
      </ATable>
    </ACard>
    <AModal v-model:open="bucketModalVisible" title="创建 RustFS 桶" :width="modalWidth" :confirm-loading="bucketLoading" @ok="confirmCreateBucket"><AForm layout="vertical"><AFormItem label="桶名称"><AInput v-model:value="bucketForm.bucketName" allow-clear placeholder="例如 blog、article-images" /></AFormItem><AFormItem label="访问权限"><ASwitch v-model:checked="bucketForm.isPublic" checked-children="公开读取" un-checked-children="私有" /></AFormItem></AForm></AModal>
    <AModal v-model:open="uploadModalVisible" title="上传图片到当前桶" :width="modalWidth" :footer="null" @cancel="handleUploadCancel">
      <div class="upload-modal-body"><AForm layout="vertical"><AFormItem label="目标桶"><AInput :value="query.bucketName" disabled /></AFormItem><AFormItem label="图片文件"><input ref="uploadInputRef" type="file" accept="image/*" multiple class="hidden" @change="handleManualUploadFileChange" /><ASpace><AButton @click="uploadInputRef?.click()">选择图片</AButton><span>{{ uploadFiles.length ? `已选择 ${uploadFiles.length} 张图片` : '未选择图片' }}</span></ASpace><div class="upload-file-list"><div v-for="(file, index) in uploadFiles" :key="`${file.name}-${file.size}-${index}`" class="flex items-center justify-between py-2"><div class="min-w-0"><div class="truncate">{{ file.name }}</div><div>{{ formatSize(file.size) }}</div></div><AButton danger type="text" @click="uploadFiles.splice(index, 1)">移除</AButton></div></div></AFormItem></AForm><div class="upload-modal-actions"><AButton @click="handleUploadCancel">取消</AButton><AButton type="primary" :loading="uploadLoading" @click="confirmUploadToBucket">确定</AButton></div></div>
    </AModal>
    <AModal v-model:open="moveModalVisible" :title="isBatchMove ? '批量移动图片到其他桶' : '移动图片到其他桶'" :width="modalWidth" :footer="null" @cancel="handleMoveCancel"><AForm layout="vertical"><AFormItem v-if="!isBatchMove" label="当前图片"><AInput :value="currentImage?.objectName" disabled /></AFormItem><AFormItem v-if="!isBatchMove" label="当前桶"><AInput :value="currentImage?.bucketName" disabled /></AFormItem><AFormItem v-else label="已选图片数量"><AInput :value="`${selectedCount} 张`" disabled /></AFormItem><AFormItem label="目标桶"><ASelect v-model:value="moveTargetBucketName" placeholder="请选择目标桶"><ASelectOption v-for="item in movableBucketOptions" :key="item.name" :value="item.name">{{ item.name }}{{ item.isPublic ? '（公开）' : '（私有）' }}</ASelectOption></ASelect></AFormItem></AForm><div class="upload-modal-actions"><AButton @click="handleMoveCancel">取消</AButton><AButton type="primary" :loading="moveLoading" @click="confirmMove">确定</AButton></div></AModal>
    <AModal v-model:open="moveConflictsModalVisible" title="发现同名文件" :width="modalWidth" :footer="null"><AAlert type="warning" show-icon :message="`目标桶中有 ${moveConflicts.length} 个同名文件，请选择处理方式`" /><div class="upload-file-list"><div v-for="item in moveConflicts" :key="`${item.sourceUrl}-${item.targetUrl}`" class="py-2"><div>{{ item.targetObjectName }}</div><div>源桶：{{ item.sourceBucketName }}</div><div class="truncate">{{ item.targetUrl }}</div></div></div><div class="upload-modal-actions"><AButton @click="moveConflictsModalVisible = false">取消</AButton><AButton @click="handleMoveConflictSkip">跳过同名继续</AButton><AButton type="primary" :loading="movePrecheckLoading" @click="handleMoveConflictOverwrite">替换同名继续</AButton></div></AModal>
    <AModal v-model:open="renameModalVisible" title="图片改名" :width="modalWidth" :confirm-loading="renameLoading" @ok="confirmRename" @cancel="handleRenameCancel"><AForm layout="vertical"><AFormItem label="原图片名称"><AInput :value="currentImage?.objectName" disabled /></AFormItem><AFormItem label="新图片名称"><AInput v-model:value="newImageName" allow-clear placeholder="请输入新图片名称，未填扩展名时会沿用原扩展名" /></AFormItem></AForm></AModal>
  </div>
</template>

<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, reactive, ref } from 'vue';
import type { TableColumnsType, TablePaginationConfig } from 'ant-design-vue';
import { message } from 'ant-design-vue';
import axios from 'axios';
import { DeleteOutlined, EditOutlined, LinkOutlined, ReloadOutlined, SwapOutlined } from '@ant-design/icons-vue';
import {
  type ManagedImageListItem,
  type ObjectMoveConflict,
  type RustfsBucketItem,
  createRustfsBucket,
  deleteBlogImage,
  deleteBlogImages,
  deleteRustfsBucket,
  getManagedImagePageList,
  getRustfsBuckets,
  moveBlogImage,
  moveBlogImages,
  moveBlogImagesPrecheck,
  renameBlogImage,
  setRustfsBucketPublic,
  uploadBlogImage
} from '@/api/blog/image';
import { useAppStore } from '@/store/system/app';
import { READONLY_ACTION_MESSAGE, useAuthStore } from '@/store/system/auth';
import { resolveBlogSourceHref } from '@/utils/blog-web-url';
import { sortOptionsByLabel } from '@/utils/common';
import { compareDateTime, formatDateTime, getTableSortOrder, resolveTimeSortOrder } from '@/utils/date-time';

defineOptions({ name: 'BlogImageManage' });

const appStore = useAppStore();
const authStore = useAuthStore();
const loading = ref(false);
const searchDebounceTimer = ref<number>();
const tableData = ref<ManagedImageListItem[]>([]);
const selectedRowKeys = ref<string[]>([]);
const selectedRows = ref<ManagedImageListItem[]>([]);
const bucketOptions = ref<RustfsBucketItem[]>([]);
const sortedBucketOptions = computed(() => sortOptionsByLabel(bucketOptions.value, item => item.name));
const usedOptions = computed(() => sortOptionsByLabel([
  { value: 'true', label: '已使用' },
  { value: 'false', label: '未使用' }
], option => option.label));
const bucketLoadFailed = ref(false);
const permissionDenied = ref(false);
const total = ref(0);
const bucketModalVisible = ref(false);
const bucketLoading = ref(false);
const uploadModalVisible = ref(false);
const uploadLoading = ref(false);
const uploadInputRef = ref<HTMLInputElement | null>(null);
const uploadFiles = ref<File[]>([]);
const bucketForm = reactive({ bucketName: '', isPublic: true });
const moveModalVisible = ref(false);
const moveLoading = ref(false);
const movePrecheckLoading = ref(false);
const isBatchMove = ref(false);
const moveTargetBucketName = ref('');
const moveConflictsModalVisible = ref(false);
const moveConflicts = ref<ObjectMoveConflict[]>([]);
const renameModalVisible = ref(false);
const renameLoading = ref(false);
const currentImage = ref<ManagedImageListItem | null>(null);
const newImageName = ref('');
const query = reactive({ pageNumber: 1, pageSize: 20, bucketName: '', fileName: '', used: undefined as 'true' | 'false' | undefined, sortOrder: 'lastModifiedDesc' as 'lastModifiedDesc' | 'lastModifiedAsc' });
const pagination = computed<TablePaginationConfig>(() => ({ current: query.pageNumber, pageSize: query.pageSize, total: total.value, showSizeChanger: true, showQuickJumper: true, pageSizeOptions: ['10', '20', '50', '100', '200'], showTotal: (value, range) => `第 ${range[0]}-${range[1]} 条，共 ${value} 条`, size: appStore.isMobile ? 'small' : 'default' }));
const isDemoAdmin = computed(() => authStore.isReadonly);
const canManageImages = computed(() => !isDemoAdmin.value);
function warnReadonlyAction() { message.warning(READONLY_ACTION_MESSAGE); }
const columns = computed<TableColumnsType<ManagedImageListItem>>(() => [
  { title: '序号', key: 'index', width: 80, align: 'center' },
  { title: '桶名称', dataIndex: 'bucketName', key: 'bucketName', width: 140, align: 'center' },
  { title: '图片', dataIndex: 'url', key: 'image', width: 140, align: 'center' },
  { title: '照片链接', dataIndex: 'url', key: 'url', width: 360, align: 'center' },
  { title: '引用位置', key: 'referencedArticles', width: 240, align: 'center' },
  { title: '文章链接', key: 'articleLinks', width: 260, align: 'center' },
  { title: '文件大小', dataIndex: 'size', key: 'size', width: 120, align: 'center' },
  { title: '更新时间', dataIndex: 'lastModified', key: 'lastModified', width: 180, align: 'center', sorter: (a, b) => compareDateTime(a.lastModified, b.lastModified), sortOrder: query.sortOrder === 'lastModifiedAsc' ? 'ascend' : 'descend', sortDirections: ['descend', 'ascend'] },
  { title: '操作', key: 'action', width: 170, align: 'center', fixed: 'right' }
]);
const tableScrollY = '100%';
const modalWidth = computed(() => (appStore.isMobile ? '92vw' : 620));
const currentBucket = computed(() => bucketOptions.value.find(item => item.name === query.bucketName));
const selectedCount = computed(() => selectedRowKeys.value.length);
const batchMovableBucketOptions = computed(() => {
  const names = new Set(selectedRows.value.map(item => item.bucketName));
  if (names.size !== 1) return bucketOptions.value;
  return bucketOptions.value.filter(item => item.name !== Array.from(names)[0]);
});
const movableBucketOptions = computed(() => sortOptionsByLabel(
  isBatchMove.value ? batchMovableBucketOptions.value : bucketOptions.value.filter(item => item.name !== currentImage.value?.bucketName),
  item => item.name
));
function resetSelection() { selectedRowKeys.value = []; selectedRows.value = []; }
function resetImageTable() { tableData.value = []; total.value = 0; resetSelection(); }
async function loadBuckets() {
  try {
    const res = await getRustfsBuckets();
    if (res.success) {
      bucketLoadFailed.value = false;
      permissionDenied.value = false;
      bucketOptions.value = res.data;
      if (!query.bucketName && res.data.length) query.bucketName = res.data[0].name;
      if (!res.data.length) resetImageTable();
      return true;
    }
  } catch (err: unknown) {
    bucketLoadFailed.value = true;
    permissionDenied.value = axios.isAxiosError(err) && err.response?.status === 403;
    bucketOptions.value = [];
    query.bucketName = '';
    resetImageTable();
    message.warning(permissionDenied.value ? '您没有权限访问图片管理功能，请确认账号已登录或联系管理员分配访问权限' : '图片存储服务暂时不可用，请稍后重试或联系管理员检查 RustFS 配置');
  }
  return false;
}
async function loadData() {
  if (bucketLoadFailed.value || !query.bucketName) { resetImageTable(); return; }
  loading.value = true;
  try {
    const res = await getManagedImagePageList({ pageNumber: query.pageNumber, pageSize: query.pageSize, bucketName: query.bucketName || undefined, fileName: query.fileName || undefined, used: query.used === undefined ? undefined : query.used === 'true', sortOrder: query.sortOrder });
    if (res.success) { tableData.value = res.data.items || res.data.records || []; total.value = res.data.totalCount || res.data.total || 0; resetSelection(); }
  } finally { loading.value = false; }
}
function handleTableChange(page: TablePaginationConfig, ...changeArgs: [unknown?, unknown?]) {
  if (bucketLoadFailed.value) return;
  query.pageNumber = page.current || 1;
  query.pageSize = page.pageSize || 20;
  query.sortOrder = resolveTimeSortOrder(getTableSortOrder(changeArgs[1]), query.sortOrder === 'lastModifiedAsc' ? 'timeAsc' : 'timeDesc') === 'timeAsc' ? 'lastModifiedAsc' : 'lastModifiedDesc';
  loadData();
}
function clearSearchDebounce() { if (searchDebounceTimer.value !== undefined) window.clearTimeout(searchDebounceTimer.value); searchDebounceTimer.value = undefined; }
function handleImageNameInput() { clearSearchDebounce(); searchDebounceTimer.value = window.setTimeout(() => { handleSearch(); }, 400); }
async function handleSearch() { clearSearchDebounce(); if (bucketLoadFailed.value) return; query.pageNumber = 1; await loadData(); }
async function handleReset() { Object.assign(query, { pageNumber: 1, fileName: '', used: undefined }); await loadData(); }
async function handleBucketChange() { if (bucketLoadFailed.value) return; query.pageNumber = 1; await loadData(); }
async function onRetryLoadBuckets() { if (await loadBuckets()) await loadData(); }
function openCreateBucketModal() { Object.assign(bucketForm, { bucketName: '', isPublic: true }); bucketModalVisible.value = true; }
async function confirmCreateBucket() {
  if (!canManageImages.value) { warnReadonlyAction(); return; }
  if (!bucketForm.bucketName.trim()) { message.warning('请输入桶名称'); return; }
  bucketLoading.value = true;
  try {
    const res = await createRustfsBucket(bucketForm.bucketName.trim(), bucketForm.isPublic);
    if (res.success) { message.success('桶已创建'); bucketModalVisible.value = false; await loadBuckets(); query.bucketName = bucketForm.bucketName.trim().toLowerCase(); await loadData(); }
  } finally { bucketLoading.value = false; }
}
async function toggleCurrentBucketPublic(checked: boolean | string | number) {
  if (!canManageImages.value) { warnReadonlyAction(); return; }
  if (!query.bucketName) { message.warning('请先选择桶'); return; }
  const res = await setRustfsBucketPublic(query.bucketName, Boolean(checked));
  if (res.success) { message.success(checked ? '桶已设置为公开读取' : '桶已设置为私有'); await loadBuckets(); }
}
async function confirmDeleteCurrentBucket() {
  if (!canManageImages.value) { warnReadonlyAction(); return; }
  if (!query.bucketName) { message.warning('请先选择桶'); return; }
  const res = await deleteRustfsBucket(query.bucketName);
  if (res.success) { message.success('桶已删除'); query.bucketName = ''; await loadBuckets(); await loadData(); }
}
function handleUploadCancel() { if (uploadLoading.value) return; uploadModalVisible.value = false; uploadFiles.value = []; }
function openUploadModal() { uploadFiles.value = []; uploadModalVisible.value = true; }
function handleManualUploadFileChange(event: Event) { uploadFiles.value = Array.from((event.target as HTMLInputElement).files || []); (event.target as HTMLInputElement).value = ''; }
function getImageFileExtension(file: File) {
  const extension = file.name.match(/\.[^./\\]+$/)?.[0];
  if (extension) return extension.toLowerCase();
  const types: Record<string, string> = { 'image/jpeg': '.jpg', 'image/png': '.png', 'image/gif': '.gif', 'image/webp': '.webp', 'image/svg+xml': '.svg' };
  return types[file.type] || '.png';
}
function createUniqueImageFileName(file: File) {
  const extension = getImageFileExtension(file);
  const rawBaseName = file.name.replace(/\.[^./\\]+$/, '').trim() || 'image';
  const safeBaseName = rawBaseName.replace(/[^\p{L}\p{N}_-]+/gu, '-').replace(/^-+|-+$/g, '') || 'image';
  const uniqueId = crypto.randomUUID?.() || `${Date.now()}-${Math.random().toString(36).slice(2, 10)}`;
  return `${safeBaseName}-${uniqueId}${extension}`;
}
async function confirmUploadToBucket() {
  if (!canManageImages.value) { warnReadonlyAction(); return; }
  if (!query.bucketName) { message.warning('请先选择桶'); return; }
  if (!uploadFiles.value.length) { message.warning('请选择图片文件'); return; }
  uploadLoading.value = true;
  try {
    const results = await Promise.all(uploadFiles.value.map(file => uploadBlogImage({ newImageFile: file, newImageOriginalName: createUniqueImageFileName(file), bucketName: query.bucketName })));
    message.success(`已上传 ${results.filter(item => item.success).length} 张图片`);
    uploadModalVisible.value = false; uploadFiles.value = []; await loadData();
  } finally { uploadLoading.value = false; }
}
function copyUrl(url: string) { navigator.clipboard.writeText(url); message.success('图片链接已复制'); }
function openImageUrl(url: string) { window.open(url, '_blank', 'noopener,noreferrer'); }
function resolveArticleHref(articleUrl: string) { return resolveBlogSourceHref(articleUrl); }
function openArticleLink(articleUrl: string) { const href = resolveArticleHref(articleUrl); if (href) window.open(href, '_blank', 'noopener,noreferrer'); }
function copyArticleLink(articleUrl: string) { const href = resolveArticleHref(articleUrl); if (!href) return; navigator.clipboard.writeText(href); message.success('完整文章链接已复制'); }
function openRenameModal(record: ManagedImageListItem) { currentImage.value = record; newImageName.value = record.fileName; renameModalVisible.value = true; }
function handleSelectionChange(keys: (string | number)[], rows: ManagedImageListItem[]) { selectedRowKeys.value = keys.map(String); selectedRows.value = rows; }
function getSelectedImageNames() { return selectedRows.value.map(item => item.url || item.objectName).filter(Boolean); }
function openBatchMoveModal() {
  if (!selectedCount.value) { message.warning('请选择要移动的图片'); return; }
  isBatchMove.value = true; currentImage.value = null; moveTargetBucketName.value = ''; moveModalVisible.value = true;
}
async function confirmBatchDelete() {
  if (!canManageImages.value) { warnReadonlyAction(); return; }
  const names = getSelectedImageNames();
  if (!names.length) { message.warning('请选择要删除的图片'); return; }
  try {
    const res = await deleteBlogImages(names);
    if (res.success) {
      const { deletedCount, skippedUsedCount } = res.data;
      message.success(skippedUsedCount > 0 ? `批量删除完成，已删除 ${deletedCount} 张，跳过 ${skippedUsedCount} 张正在被文章引用的图片` : `批量删除完成，共删除 ${deletedCount} 张`);
      resetSelection(); await loadData();
    }
  } catch { message.error('批量删除失败，请稍后重试'); }
}
function openMoveModal(record: ManagedImageListItem) { isBatchMove.value = false; currentImage.value = record; moveTargetBucketName.value = ''; moveModalVisible.value = true; }
function handleMoveCancel() { moveModalVisible.value = false; moveLoading.value = false; movePrecheckLoading.value = false; isBatchMove.value = false; currentImage.value = null; moveTargetBucketName.value = ''; moveConflictsModalVisible.value = false; moveConflicts.value = []; }
async function executeBatchMove(overwriteExisting = false) {
  if (!canManageImages.value) { warnReadonlyAction(); return; }
  let names = getSelectedImageNames();
  if (!names.length) { message.warning('请选择要移动的图片'); return; }
  if (!overwriteExisting && moveConflicts.value.length) { const urls = new Set(moveConflicts.value.map(item => item.sourceUrl)); names = names.filter(item => !urls.has(item)); }
  if (!names.length) { message.warning('所选图片均存在同名冲突，已全部跳过'); handleMoveCancel(); return; }
  const res = await moveBlogImages(names, moveTargetBucketName.value, overwriteExisting);
  if (res.success) {
    const skippedCount = overwriteExisting ? 0 : moveConflicts.value.length;
    let text = `批量移动完成，已移动 ${res.data.urls.length} 张`;
    if (skippedCount > 0) text += `，跳过 ${skippedCount} 张同名图片`;
    else if (overwriteExisting) text += '并替换同名文件';
    message.success(text); resetSelection(); handleMoveCancel(); await loadData();
  }
}
async function handleMoveConflictSkip() {
  if (!canManageImages.value) { warnReadonlyAction(); return; }
  movePrecheckLoading.value = true;
  try { moveConflictsModalVisible.value = false; await executeBatchMove(false); } catch { message.error('批量移动失败，请稍后重试'); } finally { movePrecheckLoading.value = false; }
}
async function handleMoveConflictOverwrite() {
  if (!canManageImages.value) { warnReadonlyAction(); return; }
  movePrecheckLoading.value = true;
  try { moveConflictsModalVisible.value = false; await executeBatchMove(true); } catch { message.error('批量移动失败，请稍后重试'); } finally { movePrecheckLoading.value = false; }
}
async function confirmMove() {
  if (!canManageImages.value) { warnReadonlyAction(); return; }
  if (!moveTargetBucketName.value) { message.warning('请选择目标桶'); return; }
  moveLoading.value = true;
  try {
    if (isBatchMove.value) {
      const names = getSelectedImageNames();
      if (!names.length) { message.warning('请选择要移动的图片'); return; }
      const res = await moveBlogImagesPrecheck(names, moveTargetBucketName.value);
      if (res.success && res.data.conflicts.length) { moveConflicts.value = res.data.conflicts; moveConflictsModalVisible.value = true; return; }
      await executeBatchMove(false); return;
    }
    if (!currentImage.value) { message.warning('请选择要移动的图片'); return; }
    const res = await moveBlogImage(currentImage.value.url || currentImage.value.objectName, moveTargetBucketName.value);
    if (res.success) { message.success('图片已移动'); handleMoveCancel(); await loadData(); }
  } catch { message.error('移动失败，请稍后重试'); } finally { moveLoading.value = false; }
}
function handleRenameCancel() { renameModalVisible.value = false; renameLoading.value = false; currentImage.value = null; newImageName.value = ''; }
async function confirmRename() {
  if (!canManageImages.value) { warnReadonlyAction(); return; }
  if (!currentImage.value || !newImageName.value.trim()) { message.warning('请输入新图片名称'); return; }
  renameLoading.value = true;
  try { const res = await renameBlogImage(currentImage.value.url, newImageName.value.trim()); if (res.success) { message.success('图片已改名'); handleRenameCancel(); await loadData(); } } finally { renameLoading.value = false; }
}
async function confirmDelete(record: ManagedImageListItem) {
  if (!canManageImages.value) { warnReadonlyAction(); return; }
  try { const res = await deleteBlogImage(record.url || record.objectName); if (res.success) { message.success('图片已删除'); await loadData(); } } catch { message.error('删除失败，请检查该图片是否正在被 文章、专栏、友链、封面、LOGO、系统 引用'); }
}
function formatSize(size: number) { if (!size) return '0 B'; const units = ['B', 'KB', 'MB', 'GB']; let value = size; let i = 0; while (value >= 1024 && i < units.length - 1) { value /= 1024; i += 1; } return `${value.toFixed(value >= 10 || i === 0 ? 0 : 1)} ${units[i]}`; }
onMounted(async () => { await loadBuckets(); await loadData(); });
onBeforeUnmount(clearSearchDebounce);
</script>

<style scoped lang="scss">
.table-actions { flex-wrap: nowrap; }
.table-actions :deep(.ant-btn) { padding-inline: 4px; white-space: nowrap; }

.responsive-search-form { gap: 12px; :deep(.ant-form-item) { margin-right: 0; margin-bottom: 0; } }
.table-card, .table-card :deep(.ant-card-body), .table-card :deep(.ant-table-wrapper), .table-card :deep(.ant-spin-nested-loading), .table-card :deep(.ant-spin-container), .table-card :deep(.ant-table), .table-card :deep(.ant-table-container) { display: flex; flex: 1; min-height: 0; flex-direction: column; }
.table-card :deep(.ant-card-body) { overflow: hidden; }
.table-card :deep(.ant-table-body) { flex: 1; min-height: 0; overflow-y: auto !important; }
.table-card :deep(.ant-card-head), .table-card :deep(.ant-alert), .table-card :deep(.ant-table-title), .table-card :deep(.ant-table-header), .table-card :deep(.ant-table-pagination) { flex-shrink: 0; }
.table-card :deep(.ant-table-thead) { position: sticky; top: 0; z-index: 10; }
.table-card :deep(.ant-table-thead > tr > th) { background: rgb(var(--container-bg-color)); }
.image-preview { object-fit: cover; border-radius: 6px; }
.url-cell { display: flex; align-items: center; justify-content: center; gap: 8px; max-width: 100%; min-width: 0; overflow: hidden; }
.url-text { display: -webkit-box; max-width: 260px; overflow: hidden; -webkit-box-orient: vertical; -webkit-line-clamp: 2; line-height: 1.35; overflow-wrap: anywhere; word-break: break-word; text-align: left; }
.reference-tag { max-width: 100%; margin-inline-end: 0; }
.reference-tag-text { display: inline-block; max-width: 210px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; vertical-align: bottom; }
.article-link-button { max-width: 100%; height: auto; min-height: 24px; padding-inline: 0; white-space: normal; text-align: left; line-height: 1.35; overflow-wrap: anywhere; word-break: break-word; }
.article-link-item { display: block; max-width: 100%; }
.upload-modal-body { display: flex; max-height: min(68vh, 620px); flex-direction: column; }
.upload-file-list { max-height: min(42vh, 360px); overflow-y: auto; padding-right: 4px; }
.upload-modal-actions { display: flex; flex-shrink: 0; justify-content: center; gap: 12px; margin-top: 20px; padding-top: 16px; border-top: 1px solid rgb(var(--border-color)); }
@media (max-width: 640px) { .responsive-search-form { display: flex; flex-direction: column; align-items: stretch; } .responsive-search-form :deep(.ant-form-item-control), .responsive-search-form :deep(.ant-form-item-control-input-content) { width: 100%; } }
:global(html.dark) .card-wrapper { background: rgb(var(--container-bg-color)) !important; }
:global(html.dark) .table-card :deep(.ant-table),
:global(html.dark) .table-card :deep(.ant-table-container),
:global(html.dark) .table-card :deep(.ant-table-body),
:global(html.dark) .table-card :deep(.ant-table-cell) { background: rgb(var(--container-bg-color)) !important; }
:global(html.dark) .table-card :deep(.ant-table-tbody > tr > td),
:global(html.dark) .table-card :deep(.ant-table-thead > tr > th),
:global(html.dark) .table-card :deep(.ant-pagination-total-text) { color: rgb(var(--base-text-color)) !important; }
:global(html.dark) .table-card :deep(.ant-table-tbody > tr:hover > td) { background: rgb(51 60 74) !important; }
</style>
