<script setup lang="ts">
import { computed, onMounted, reactive, ref } from 'vue';
import { useRouter } from 'vue-router';
import type { TableColumnsType, TablePaginationConfig } from 'ant-design-vue';
import { message } from 'ant-design-vue';
import axios from 'axios';
import { DeleteOutlined, EditOutlined, LinkOutlined, ReloadOutlined, SearchOutlined } from '@ant-design/icons-vue';
import {
  type ManagedImageListItem,
  type MinioBucketItem,
  type ObjectMoveConflict,
  createMinioBucket,
  deleteBlogImage,
  deleteBlogImages,
  deleteMinioBucket,
  getManagedImagePageList,
  getMinioBuckets,
  moveBlogImage,
  moveBlogImages,
  moveBlogImagesPrecheck,
  renameBlogImage,
  setMinioBucketPublic,
  uploadBlogImage
} from '@/service/blog/admin/image';
import { useAppStore } from '@/store/system/app';

defineOptions({ name: 'BlogAdminImageManage' });

const router = useRouter();
const appStore = useAppStore();
const loading = ref(false);
const tableData = ref<ManagedImageListItem[]>([]);
const selectedRowKeys = ref<string[]>([]);
const selectedRows = ref<ManagedImageListItem[]>([]);
const bucketOptions = ref<MinioBucketItem[]>([]);
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
const moveOverwriteExisting = ref(false);
const renameModalVisible = ref(false);
const renameLoading = ref(false);
const currentImage = ref<ManagedImageListItem | null>(null);
const newImageName = ref('');
const query = reactive({
  pageNumber: 1,
  pageSize: 20,
  bucketName: '',
  fileName: '',
  used: undefined as 'true' | 'false' | undefined
});

const pagination = computed<TablePaginationConfig>(() => ({
  current: query.pageNumber,
  pageSize: query.pageSize,
  total: total.value,
  showSizeChanger: true,
  showQuickJumper: true,
  pageSizeOptions: ['10', '20', '50', '100', '200'],
  showTotal: (value, range) => `第 ${range[0]}-${range[1]} 条，共 ${value} 条`,
  size: appStore.isMobile ? 'small' : 'default'
}));
const columns = computed<TableColumnsType<ManagedImageListItem>>(() => [
  { title: '序号', key: 'index', width: 80, align: 'center' },
  { title: '桶名称', dataIndex: 'bucketName', key: 'bucketName', width: 140, align: 'center' },
  { title: '图片', dataIndex: 'url', key: 'image', width: 140, align: 'center' },
  { title: '照片链接', dataIndex: 'url', key: 'url', width: 360, align: 'center' },
  { title: '引用位置', key: 'referencedArticles', width: 240, align: 'center' },
  { title: '文章链接', key: 'articleLinks', width: 260, align: 'center' },
  { title: '文件大小', dataIndex: 'size', key: 'size', width: 120, align: 'center' },
  { title: '更新时间', dataIndex: 'lastModified', key: 'lastModified', width: 180, align: 'center' },
  { title: '操作', key: 'action', width: 150, align: 'center', fixed: appStore.isMobile ? undefined : 'right' }
]);
const tableScrollX = 1670;
const tableScrollY = computed(() => (appStore.isMobile ? 'calc(100vh - 430px)' : 'calc(100vh - 440px)'));
const renameModalWidth = computed(() => (appStore.isMobile ? '92vw' : 520));
const bucketModalWidth = computed(() => (appStore.isMobile ? '92vw' : 520));
const uploadModalWidth = computed(() => (appStore.isMobile ? '92vw' : 620));
const moveModalWidth = computed(() => (appStore.isMobile ? '92vw' : 520));
const currentBucket = computed(() => bucketOptions.value.find(item => item.name === query.bucketName));
const selectedCount = computed(() => selectedRowKeys.value.length);
const batchMovableBucketOptions = computed(() => {
  const selectedBucketNames = new Set(selectedRows.value.map(item => item.bucketName));
  if (selectedBucketNames.size !== 1) return bucketOptions.value;
  const [selectedBucketName] = Array.from(selectedBucketNames);
  return bucketOptions.value.filter(item => item.name !== selectedBucketName);
});
const movableBucketOptions = computed(() =>
  isBatchMove.value
    ? batchMovableBucketOptions.value
    : bucketOptions.value.filter(item => item.name !== currentImage.value?.bucketName)
);

function getSelectPopupContainer() {
  return globalThis.document?.body || document.body;
}

function resetSelection() {
  selectedRowKeys.value = [];
  selectedRows.value = [];
}

function resetImageTable() {
  tableData.value = [];
  total.value = 0;
  resetSelection();
}

async function loadBuckets() {
  try {
    const res = await getMinioBuckets();
    if (res.success) {
      bucketLoadFailed.value = false;
      permissionDenied.value = false;
      bucketOptions.value = res.data;
      if (!query.bucketName && res.data.length) query.bucketName = res.data[0].name;
      if (!res.data.length) resetImageTable();
      return true;
    }
  } catch (err: any) {
    bucketLoadFailed.value = true;
    permissionDenied.value = axios.isAxiosError(err) && err.response?.status === 403;
    bucketOptions.value = [];
    query.bucketName = '';
    resetImageTable();
    if (permissionDenied.value) {
      message.warning('您没有权限访问图片管理功能，请联系管理员分配 ROLE_ADMIN 或 ROLE_SUPER 角色');
    } else {
      message.error('图片存储服务暂时不可用，请稍后重试或联系管理员检查 MinIO 配置');
    }
  }

  return false;
}

async function loadData() {
  if (bucketLoadFailed.value) {
    resetImageTable();
    if (permissionDenied.value) {
      message.warning('权限不足，无法查询图片列表');
    } else {
      message.warning('图片存储服务暂时不可用，无法查询图片列表');
    }
    return;
  }

  if (!query.bucketName) {
    resetImageTable();
    return;
  }

  loading.value = true;
  try {
    const params = {
      pageNumber: query.pageNumber,
      pageSize: query.pageSize,
      bucketName: query.bucketName || undefined,
      fileName: query.fileName || undefined,
      used: query.used === undefined ? undefined : query.used === 'true'
    };
    const res = await getManagedImagePageList(params);
    if (res.success) {
      tableData.value = res.data.items || res.data.records || [];
      total.value = res.data.totalCount || res.data.total || 0;
      resetSelection();
    }
  } finally {
    loading.value = false;
  }
}

function handleTableChange(page: TablePaginationConfig) {
  if (bucketLoadFailed.value) return;
  query.pageNumber = page.current || 1;
  query.pageSize = page.pageSize || 20;
  loadData();
}

async function handleSearch() {
  if (bucketLoadFailed.value) return;
  query.pageNumber = 1;
  await loadData();
}

async function handleReset() {
  Object.assign(query, { pageNumber: 1, fileName: '', used: undefined });
  if (bucketLoadFailed.value) {
    resetImageTable();
    return;
  }
  await loadData();
}

async function handleBucketChange() {
  if (bucketLoadFailed.value) return;
  query.pageNumber = 1;
  await loadData();
}

async function onRetryLoadBuckets() {
  const loaded = await loadBuckets();
  if (loaded) {
    await loadData();
  }
}

function openCreateBucketModal() {
  Object.assign(bucketForm, { bucketName: '', isPublic: true });
  bucketModalVisible.value = true;
}

async function confirmCreateBucket() {
  if (!bucketForm.bucketName.trim()) {
    message.warning('请输入桶名称');
    return;
  }

  bucketLoading.value = true;
  try {
    const res = await createMinioBucket(bucketForm.bucketName.trim(), bucketForm.isPublic);
    if (res.success) {
      message.success('桶已创建');
      bucketModalVisible.value = false;
      await loadBuckets();
      query.bucketName = bucketForm.bucketName.trim().toLowerCase();
      await loadData();
    }
  } finally {
    bucketLoading.value = false;
  }
}

async function toggleCurrentBucketPublic(checked: boolean) {
  if (!query.bucketName) {
    message.warning('请先选择桶');
    return;
  }

  const res = await setMinioBucketPublic(query.bucketName, checked);
  if (res.success) {
    message.success(checked ? '桶已设置为公开读取' : '桶已设置为私有');
    await loadBuckets();
  }
}

async function confirmDeleteCurrentBucket() {
  if (!query.bucketName) {
    message.warning('请先选择桶');
    return;
  }

  const res = await deleteMinioBucket(query.bucketName);
  if (res.success) {
    message.success('桶已删除');
    query.bucketName = '';
    await loadBuckets();
    await loadData();
  }
}

function handleUploadCancel() {
  if (uploadLoading.value) return;
  uploadModalVisible.value = false;
  uploadFiles.value = [];
}

function openUploadModal() {
  uploadFiles.value = [];
  uploadModalVisible.value = true;
}

function openUploadFilePicker() {
  uploadInputRef.value?.click();
}

function removeUploadFile(index: number) {
  uploadFiles.value.splice(index, 1);
}

function handleManualUploadFileChange(event: Event) {
  const files = Array.from((event.target as HTMLInputElement).files || []);
  uploadFiles.value = files;
  (event.target as HTMLInputElement).value = '';
}

async function confirmUploadToBucket() {
  if (!query.bucketName) {
    message.warning('请先选择桶');
    return;
  }
  if (!uploadFiles.value.length) {
    message.warning('请选择图片文件');
    return;
  }

  uploadLoading.value = true;
  try {
    const results = await Promise.all(
      uploadFiles.value.map(file =>
        uploadBlogImage({
          newImageFile: file,
          newImageOriginalName: file.name,
          bucketName: query.bucketName
        })
      )
    );
    const successCount = results.filter(item => item.success).length;

    message.success(`已上传 ${successCount} 张图片`);
    uploadModalVisible.value = false;
    uploadFiles.value = [];
    await loadData();
  } finally {
    uploadLoading.value = false;
  }
}

function copyUrl(url: string) {
  navigator.clipboard.writeText(url);
  message.success('图片链接已复制');
}

function openImageUrl(url: string) {
  window.open(url, '_blank');
}

function resolveArticleHref(articleUrl: string) {
  return router.resolve(articleUrl).href;
}

function resolveArticleFullUrl(articleUrl: string) {
  return new URL(resolveArticleHref(articleUrl), window.location.origin).href;
}

function openArticleLink(articleUrl: string) {
  window.open(resolveArticleHref(articleUrl), '_blank');
}

function copyArticleLink(articleUrl: string) {
  navigator.clipboard.writeText(resolveArticleFullUrl(articleUrl));
  message.success('完整文章链接已复制');
}

function openRenameModal(record: ManagedImageListItem) {
  currentImage.value = record;
  newImageName.value = record.fileName;
  renameModalVisible.value = true;
}

function handleSelectionChange(keys: (string | number)[], rows: ManagedImageListItem[]) {
  selectedRowKeys.value = keys.map(String);
  selectedRows.value = rows;
}

function getSelectedImageNames() {
  return selectedRows.value.map(item => item.url || item.objectName).filter(Boolean);
}

function openBatchMoveModal() {
  if (!selectedCount.value) {
    message.warning('请选择要移动的图片');
    return;
  }

  isBatchMove.value = true;
  moveOverwriteExisting.value = false;
  currentImage.value = null;
  moveTargetBucketName.value = '';
  moveModalVisible.value = true;
}

async function confirmBatchDelete() {
  const imageNames = getSelectedImageNames();
  if (!imageNames.length) {
    message.warning('请选择要删除的图片');
    return;
  }

  try {
    const res = await deleteBlogImages(imageNames);
    if (res.success) {
      const { deletedCount, skippedUsedCount } = res.data;
      message.success(
        skippedUsedCount > 0
          ? `批量删除完成，已删除 ${deletedCount} 张，跳过 ${skippedUsedCount} 张正在被文章引用的图片`
          : `批量删除完成，共删除 ${deletedCount} 张`
      );
      resetSelection();
      await loadData();
    }
  } catch {
    message.error('批量删除失败，请稍后重试');
  }
}

function openMoveModal(record: ManagedImageListItem) {
  isBatchMove.value = false;
  moveOverwriteExisting.value = false;
  currentImage.value = record;
  moveTargetBucketName.value = '';
  moveModalVisible.value = true;
}

function resetBatchMoveState() {
  moveConflictsModalVisible.value = false;
  moveConflicts.value = [];
  moveOverwriteExisting.value = false;
}

function handleMoveCancel() {
  moveModalVisible.value = false;
  moveLoading.value = false;
  movePrecheckLoading.value = false;
  isBatchMove.value = false;
  currentImage.value = null;
  moveTargetBucketName.value = '';
  resetBatchMoveState();
}

async function executeBatchMove(overwriteExisting = false) {
  let imageNames = getSelectedImageNames();
  if (!imageNames.length) {
    message.warning('请选择要移动的图片');
    return;
  }

  if (!overwriteExisting && moveConflicts.value.length) {
    const conflictSourceUrls = new Set(moveConflicts.value.map(item => item.sourceUrl));
    imageNames = imageNames.filter(item => !conflictSourceUrls.has(item));
  }

  if (!imageNames.length) {
    message.warning('所选图片均存在同名冲突，已全部跳过');
    handleMoveCancel();
    return;
  }

  const res = await moveBlogImages(imageNames, moveTargetBucketName.value, overwriteExisting);
  if (res.success) {
    const skippedCount = overwriteExisting ? 0 : moveConflicts.value.length;
    let successMessage = `批量移动完成，已移动 ${res.data.urls.length} 张`;
    if (skippedCount > 0) {
      successMessage = `批量移动完成，已移动 ${res.data.urls.length} 张，跳过 ${skippedCount} 张同名图片`;
    } else if (overwriteExisting) {
      successMessage = `批量移动完成，已移动 ${res.data.urls.length} 张并替换同名文件`;
    }

    message.success(successMessage);
    resetSelection();
    handleMoveCancel();
    await loadData();
  }
}

async function handleMoveConflictSkip() {
  movePrecheckLoading.value = true;
  try {
    moveOverwriteExisting.value = false;
    moveConflictsModalVisible.value = false;
    await executeBatchMove(false);
  } catch {
    message.error('批量移动失败，请稍后重试');
  } finally {
    movePrecheckLoading.value = false;
  }
}

async function handleMoveConflictOverwrite() {
  movePrecheckLoading.value = true;
  try {
    moveOverwriteExisting.value = true;
    moveConflictsModalVisible.value = false;
    await executeBatchMove(true);
  } catch {
    message.error('批量移动失败，请稍后重试');
  } finally {
    movePrecheckLoading.value = false;
  }
}

async function confirmMove() {
  if (!moveTargetBucketName.value) {
    message.warning('请选择目标桶');
    return;
  }

  moveLoading.value = true;
  try {
    if (isBatchMove.value) {
      const imageNames = getSelectedImageNames();
      if (!imageNames.length) {
        message.warning('请选择要移动的图片');
        return;
      }

      const precheckRes = await moveBlogImagesPrecheck(imageNames, moveTargetBucketName.value);
      if (precheckRes.success && precheckRes.data.conflicts.length) {
        moveConflicts.value = precheckRes.data.conflicts;
        moveConflictsModalVisible.value = true;
        return;
      }

      await executeBatchMove(false);
      return;
    }

    if (!currentImage.value) {
      message.warning('请选择要移动的图片');
      return;
    }

    const res = await moveBlogImage(
      currentImage.value.url || currentImage.value.objectName,
      moveTargetBucketName.value
    );
    if (res.success) {
      message.success('图片已移动');
      handleMoveCancel();
      await loadData();
    }
  } catch {
    message.error('移动失败，请稍后重试');
  } finally {
    moveLoading.value = false;
  }
}

function handleRenameCancel() {
  renameModalVisible.value = false;
  renameLoading.value = false;
  currentImage.value = null;
  newImageName.value = '';
}

async function confirmRename() {
  if (!currentImage.value || !newImageName.value.trim()) {
    message.warning('请输入新图片名称');
    return;
  }

  renameLoading.value = true;
  try {
    const res = await renameBlogImage(currentImage.value.url, newImageName.value.trim());
    if (res.success) {
      message.success('图片已改名');
      handleRenameCancel();
      await loadData();
    }
  } finally {
    renameLoading.value = false;
  }
}

async function confirmDelete(record: ManagedImageListItem) {
  try {
    const res = await deleteBlogImage(record.url || record.objectName);
    if (res.success) {
      message.success('图片已删除');
      await loadData();
    }
  } catch {
    message.error('删除失败，请检查该图片是否正在被 文章、专栏、友链、封面、LOGO、系统 引用');
  }
}

function formatSize(size: number) {
  if (!size) return '0 B';
  const units = ['B', 'KB', 'MB', 'GB'];
  let value = size;
  let unitIndex = 0;
  while (value >= 1024 && unitIndex < units.length - 1) {
    value /= 1024;
    unitIndex += 1;
  }
  return `${value.toFixed(value >= 10 || unitIndex === 0 ? 0 : 1)} ${units[unitIndex]}`;
}

onMounted(async () => {
  await loadBuckets();
  await loadData();
});
</script>

<template>
  <div class="image-page flex h-full min-h-0 w-full flex-col overflow-hidden">
    <div class="flex-shrink-0 bg-layout pb-4">
      <ACard :bordered="false" class="card-wrapper">
        <AForm layout="inline" class="responsive-search-form">
          <AFormItem label="桶名称">
            <ASelect
              v-model:value="query.bucketName"
              allow-clear
              show-search
              placeholder="请选择桶"
              class="w-full sm:w-[180px]"
              :get-popup-container="getSelectPopupContainer"
              @change="handleBucketChange"
            >
              <ASelectOption v-for="item in bucketOptions" :key="item.name" :value="item.name">
                {{ item.name }}{{ item.isPublic ? '（公开）' : '（私有）' }}
              </ASelectOption>
            </ASelect>
          </AFormItem>
          <AFormItem label="图片名称">
            <AInput
              v-model:value="query.fileName"
              allow-clear
              placeholder="请输入图片名称"
              class="w-full sm:w-[220px]"
              @press-enter="handleSearch"
            />
          </AFormItem>
          <AFormItem label="使用状态">
            <ASelect
              v-model:value="query.used"
              allow-clear
              placeholder="全部"
              class="w-full sm:w-[180px]"
              popup-class-name="image-page-select-dropdown"
              :get-popup-container="getSelectPopupContainer"
            >
              <ASelectOption value="true">
                <span class="select-option-text">已使用</span>
              </ASelectOption>
              <ASelectOption value="false">
                <span class="select-option-text">未使用</span>
              </ASelectOption>
            </ASelect>
          </AFormItem>
          <AFormItem>
            <ASpace wrap>
              <AButton type="primary" @click="handleSearch">
                <template #icon><SearchOutlined /></template>
                查询
              </AButton>
              <AButton @click="handleReset">
                <template #icon><ReloadOutlined /></template>
                重置
              </AButton>
              <AButton @click="openCreateBucketModal">创建桶</AButton>
              <AButton :disabled="!query.bucketName" @click="openUploadModal">上传图片</AButton>
              <ASwitch
                v-if="currentBucket"
                :checked="currentBucket.isPublic"
                checked-children="公开"
                un-checked-children="私有"
                @change="toggleCurrentBucketPublic"
              />
              <APopconfirm title="确定删除当前桶吗？桶必须为空，默认桶不能删除。" @confirm="confirmDeleteCurrentBucket">
                <AButton danger :disabled="!query.bucketName">删除桶</AButton>
              </APopconfirm>
              <AButton :disabled="!selectedCount" @click="openBatchMoveModal">
                批量移动{{ selectedCount ? `（${selectedCount}）` : '' }}
              </AButton>
              <APopconfirm
                title="确定批量删除选中的图片吗？正在被文章引用的图片会自动跳过。"
                :overlay-style="{ minWidth: '260px' }"
                @confirm="confirmBatchDelete"
              >
                <AButton danger :disabled="!selectedCount">
                  批量删除{{ selectedCount ? `（${selectedCount}）` : '' }}
                </AButton>
              </APopconfirm>
            </ASpace>
          </AFormItem>
        </AForm>
      </ACard>
    </div>

    <ACard :bordered="false" class="card-wrapper table-card flex-1 min-h-0 overflow-hidden">
      <div
        v-if="bucketLoadFailed"
        class="bucket-error-state flex flex-1 items-center justify-center px-6 py-10 text-center"
      >
        <div v-if="permissionDenied">
          <div class="mb-2 text-base font-semibold text-orange-500">权限不足</div>
          <div class="text-sm text-gray-500 dark:text-gray-400">
            您当前的角色没有权限访问图片管理功能，请联系管理员分配 ROLE_ADMIN 或 ROLE_SUPER 角色。
          </div>
          <AButton class="mt-4" @click="onRetryLoadBuckets">重新加载</AButton>
        </div>
        <div v-else>
          <div class="mb-2 text-base font-semibold text-red-500">图片存储服务暂时不可用</div>
          <div class="text-sm text-gray-500 dark:text-gray-400">
            请检查 RustFS 是否正常启动、桶权限和后端配置是否正确。页面已停止加载图片列表，避免显示旧数据。
          </div>
          <AButton class="mt-4" type="primary" @click="onRetryLoadBuckets">重新加载</AButton>
        </div>
      </div>
      <ATable
        v-else
        :columns="columns"
        :data-source="tableData"
        :loading="loading"
        :pagination="pagination"
        :row-key="record => `${record.bucketName}/${record.objectName}`"
        :row-selection="{
          selectedRowKeys,
          preserveSelectedRowKeys: true,
          onChange: handleSelectionChange
        }"
        :scroll="{ x: tableScrollX, y: tableScrollY }"
        bordered
        size="middle"
        @change="handleTableChange"
      >
        <template #bodyCell="{ column, record, index }">
          <template v-if="column.key === 'index'">{{ index + 1 }}</template>
          <template v-else-if="column.key === 'image'">
            <AImage :width="88" :height="64" :src="record.url" class="image-preview" />
          </template>
          <template v-else-if="column.key === 'url'">
            <div class="url-cell">
              <ATypographyLink class="line-clamp-2 break-all" @click="openImageUrl(record.url)">
                {{ record.url }}
              </ATypographyLink>
              <AButton size="small" type="link" @click="copyUrl(record.url)">
                <template #icon><LinkOutlined /></template>
                复制
              </AButton>
            </div>
          </template>
          <template v-else-if="column.key === 'referencedArticles'">
            <ASpace v-if="record.referencedArticles.length" wrap>
              <ATag v-for="article in record.referencedArticles" :key="article.articleId" color="processing">
                {{ article.articleTitle }}
              </ATag>
            </ASpace>
            <ATag v-else color="default">未使用</ATag>
          </template>
          <template v-else-if="column.key === 'articleLinks'">
            <ASpace v-if="record.referencedArticles.length" direction="vertical" :size="2">
              <APopconfirm
                v-for="article in record.referencedArticles"
                :key="article.articleId"
                title="请选择文章链接操作"
                ok-text="跳转预览"
                cancel-text="复制链接"
                @confirm="openArticleLink(article.articleUrl)"
                @cancel="copyArticleLink(article.articleUrl)"
              >
                <AButton type="link" size="small">
                  {{ article.articleTitle }}
                </AButton>
              </APopconfirm>
            </ASpace>
            <span v-else class="text-gray-400">-</span>
          </template>
          <template v-else-if="column.key === 'size'">{{ formatSize(record.size) }}</template>
          <template v-else-if="column.key === 'action'">
            <ASpace>
              <ATooltip title="改名">
                <AButton size="small" shape="circle" @click="openRenameModal(record as ManagedImageListItem)">
                  <template #icon><EditOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="移动到其他桶">
                <AButton size="small" @click="openMoveModal(record as ManagedImageListItem)">移动</AButton>
              </ATooltip>
              <APopconfirm
                title="确定删除这张图片吗？如果文章仍在引用，图片会无法显示。"
                overlay-class-name="image-delete-popconfirm"
                @confirm="confirmDelete(record as ManagedImageListItem)"
              >
                <ATooltip title="删除">
                  <AButton danger size="small" shape="circle">
                    <template #icon><DeleteOutlined /></template>
                  </AButton>
                </ATooltip>
              </APopconfirm>
            </ASpace>
          </template>
        </template>
      </ATable>
    </ACard>

    <AModal
      v-model:open="bucketModalVisible"
      title="创建 RustFS 桶"
      :width="bucketModalWidth"
      :confirm-loading="bucketLoading"
      @ok="confirmCreateBucket"
    >
      <AForm layout="vertical">
        <AFormItem label="桶名称">
          <AInput v-model:value="bucketForm.bucketName" allow-clear placeholder="例如 blog、article-images" />
        </AFormItem>
        <AFormItem label="访问权限">
          <ASwitch v-model:checked="bucketForm.isPublic" checked-children="公开读取" un-checked-children="私有" />
        </AFormItem>
      </AForm>
    </AModal>

    <AModal
      v-model:open="uploadModalVisible"
      title="上传图片到当前桶"
      :width="uploadModalWidth"
      :confirm-loading="uploadLoading"
      :footer="null"
      @cancel="handleUploadCancel"
    >
      <div class="upload-modal-body">
        <AForm layout="vertical" class="upload-modal-form">
          <AFormItem label="目标桶">
            <AInput :value="query.bucketName" disabled />
          </AFormItem>
          <AFormItem label="图片文件">
            <input
              ref="uploadInputRef"
              type="file"
              accept="image/*"
              multiple
              class="hidden"
              @change="handleManualUploadFileChange"
            />
            <ASpace wrap>
              <AButton @click="openUploadFilePicker">选择图片</AButton>
              <span class="text-sm text-base-text/70">
                {{ uploadFiles.length ? `已选择 ${uploadFiles.length} 张图片` : '未选择图片' }}
              </span>
            </ASpace>
            <div v-if="uploadFiles.length" class="upload-file-list mt-3 space-y-2">
              <div
                v-for="(file, index) in uploadFiles"
                :key="`${file.name}-${file.size}-${index}`"
                class="flex items-center justify-between rounded-lg border border-border-color px-3 py-2"
              >
                <div class="min-w-0 flex-1 pr-3">
                  <div class="truncate text-sm font-medium">{{ file.name }}</div>
                  <div class="text-xs text-base-text/60">{{ formatSize(file.size) }}</div>
                </div>
                <AButton size="small" danger type="text" @click="removeUploadFile(index)">移除</AButton>
              </div>
            </div>
          </AFormItem>
        </AForm>
        <div class="upload-modal-actions">
          <AButton class="min-w-[96px]" @click="handleUploadCancel">取消</AButton>
          <AButton class="min-w-[96px]" type="primary" :loading="uploadLoading" @click="confirmUploadToBucket">
            确定
          </AButton>
        </div>
      </div>
    </AModal>

    <AModal
      v-model:open="moveModalVisible"
      :title="isBatchMove ? '批量移动图片到其他桶' : '移动图片到其他桶'"
      :width="moveModalWidth"
      :confirm-loading="moveLoading"
      :footer="null"
      @cancel="handleMoveCancel"
    >
      <div class="upload-modal-body">
        <AForm layout="vertical" class="upload-modal-form">
          <AFormItem v-if="!isBatchMove" label="当前图片">
            <AInput :value="currentImage?.objectName" disabled />
          </AFormItem>
          <AFormItem v-if="!isBatchMove" label="当前桶">
            <AInput :value="currentImage?.bucketName" disabled />
          </AFormItem>
          <AFormItem v-else label="已选图片数量">
            <AInput :value="`${selectedCount} 张`" disabled />
          </AFormItem>
          <AFormItem label="目标桶">
            <ASelect v-model:value="moveTargetBucketName" placeholder="请选择目标桶">
              <ASelectOption v-for="item in movableBucketOptions" :key="item.name" :value="item.name">
                {{ item.name }}{{ item.isPublic ? '（公开）' : '（私有）' }}
              </ASelectOption>
            </ASelect>
          </AFormItem>
        </AForm>
        <div class="upload-modal-actions">
          <AButton class="min-w-[96px]" @click="handleMoveCancel">取消</AButton>
          <AButton class="min-w-[96px]" type="primary" :loading="moveLoading" @click="confirmMove">确定</AButton>
        </div>
      </div>
    </AModal>

    <AModal
      v-model:open="moveConflictsModalVisible"
      title="发现同名文件"
      :width="moveModalWidth"
      :footer="null"
      @cancel="moveConflictsModalVisible = false"
    >
      <div class="upload-modal-body">
        <AAlert
          type="warning"
          show-icon
          :message="`目标桶中有 ${moveConflicts.length} 个同名文件，请选择处理方式`"
          class="mb-4"
        />
        <div class="upload-file-list space-y-2">
          <div
            v-for="item in moveConflicts"
            :key="`${item.sourceUrl}-${item.targetUrl}`"
            class="rounded-lg border border-border-color px-3 py-2"
          >
            <div class="truncate text-sm font-medium">{{ item.targetObjectName }}</div>
            <div class="mt-1 text-xs text-base-text/60">源桶：{{ item.sourceBucketName }}</div>
            <div class="truncate text-xs text-base-text/60">{{ item.targetUrl }}</div>
          </div>
        </div>
        <div class="upload-modal-actions">
          <AButton class="min-w-[96px]" @click="moveConflictsModalVisible = false">取消</AButton>
          <AButton class="min-w-[96px]" @click="handleMoveConflictSkip">跳过同名继续</AButton>
          <AButton
            class="min-w-[96px]"
            type="primary"
            :loading="movePrecheckLoading"
            @click="handleMoveConflictOverwrite"
          >
            替换同名继续
          </AButton>
        </div>
      </div>
    </AModal>

    <AModal
      v-model:open="renameModalVisible"
      title="图片改名"
      :width="renameModalWidth"
      :confirm-loading="renameLoading"
      @ok="confirmRename"
      @cancel="handleRenameCancel"
    >
      <AForm layout="vertical">
        <AFormItem label="原图片名称">
          <AInput :value="currentImage?.objectName" disabled />
        </AFormItem>
        <AFormItem label="新图片名称">
          <AInput v-model:value="newImageName" allow-clear placeholder="请输入新图片名称，未填扩展名时会沿用原扩展名" />
        </AFormItem>
      </AForm>
    </AModal>
  </div>
</template>

<style scoped lang="scss">
.image-page {
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

.image-preview {
  object-fit: cover;
  border-radius: 6px;
}

.url-cell {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.select-option-text {
  display: inline-block;
  min-width: 48px;
}

.upload-modal-body {
  display: flex;
  max-height: min(68vh, 620px);
  flex-direction: column;
}

.upload-modal-form {
  min-height: 0;
  overflow: hidden;
}

.upload-file-list {
  max-height: min(42vh, 360px);
  overflow-y: auto;
  padding-right: 4px;
}

.upload-modal-actions {
  display: flex;
  flex-shrink: 0;
  justify-content: center;
  gap: 12px;
  margin-top: 20px;
  padding-top: 16px;
  border-top: 1px solid rgb(var(--border-color));
}

:global(.image-page-select-dropdown) {
  min-width: 120px !important;
}

:global(.image-delete-popconfirm) {
  min-width: 280px;
  width: max-content !important;
  transition-property: opacity, transform !important;
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

:global(html.dark) .card-wrapper {
  background: rgb(var(--container-bg-color)) !important;
}

:global(html.dark) .table-card :deep(.ant-card-body),
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

:global(html.dark) .table-card :deep(.ant-table-thead > tr > th),
:global(html.dark) :deep(.ant-form-item-label > label),
:global(html.dark) .table-card :deep(.ant-pagination .ant-pagination-total-text) {
  color: rgb(var(--base-text-color)) !important;
}
</style>
