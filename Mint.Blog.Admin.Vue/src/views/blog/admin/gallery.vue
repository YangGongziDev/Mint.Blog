<template>
  <div class="gallery-admin-page">
    <ACard :bordered="false" class="page-card">
      <div v-if="activeTab === 'images'" class="gallery-toolbar-row">
        <AInput
          v-model:value="imageKeyword"
          allow-clear
          placeholder="搜索图片名称、分类、分辨率"
          class="search-input"
          @input="scheduleImageSearch"
          @press-enter="loadImages"
        >
          <template #prefix><SearchOutlined /></template>
        </AInput>
        <div class="default-bucket-bar">
          <span>上传默认桶</span>
          <ASelect
            :value="defaultBucketName"
            allow-clear
            :loading="bucketLoading"
            placeholder="请选择默认上传桶"
            class="default-bucket-select"
            @change="saveDefaultBucket"
          >
            <ASelectOption v-for="item in bucketOptions" :key="item.name" :value="item.name">
              {{ item.name }}{{ item.isPublic ? '（公开）' : '（私有）' }}
            </ASelectOption>
          </ASelect>
        </div>
        <AButton type="primary" ghost :disabled="isDemoAdmin" @click="openImageModal">
          <UploadOutlined />
          上传图片
        </AButton>
      </div>
      <div class="gallery-tabs-wrapper">
        <ATabs v-model:active-key="activeTab">
        <ATabPane key="images" tab="图片管理">
          <ATable
            row-key="id"
            :loading="loading"
            :columns="imageColumns"
            :data-source="imageData"
            :pagination="false"
            :size="tableSize"
            :scroll="{ x: tableScrollX }"
            :row-selection="{ selectedRowKeys: selectedImageRowKeys, onChange: (keys: (string | number)[]) => (selectedImageRowKeys = keys.map(String)) }"
          >
            <template #title>
              <ASpace v-if="selectedImageRowKeys.length">
                <span>已选择 {{ selectedImageRowKeys.length }} 张</span>
                <AButton danger size="small" :disabled="isDemoAdmin" @click="confirmDeleteImages(imageData.filter(item => selectedImageRowKeys.includes(item.id)))">
                  批量删除
                </AButton>
              </ASpace>
            </template>
            <template #bodyCell="{ column, record, index }">
              <template v-if="column.key === 'index'">{{ index + 1 }}</template>
              <template v-else-if="column.key === 'url'">
                <AImage :src="record.url" :width="72" :height="46" />
              </template>
              <template v-else-if="column.key === 'link'">
                <ATooltip :title="record.url">
                  <AButton type="link" size="small" class="copy-link-button" @click="copyImageUrl(record.url)">
                    <CopyOutlined />
                    复制链接
                  </AButton>
                </ATooltip>
              </template>
              <template v-else-if="column.key === 'enabled'">
                <ATag :color="record.enabled ? 'green' : 'default'">{{ record.enabled ? '启用' : '停用' }}</ATag>
              </template>
              <template v-else-if="column.key === 'action'">
                <ASpace>
                  <AButton
                    type="link"
                    size="small"
                    :disabled="isDemoAdmin"
                    @click="openEditImage(record as GalleryImageItem)"
                  >
                    <EditOutlined />
                    编辑
                  </AButton>
                  <AButton
                    type="link"
                    size="small"
                    danger
                    :disabled="isDemoAdmin"
                    @click="confirmDeleteImage(record as GalleryImageItem)"
                  >
                    <DeleteOutlined />
                    删除
                  </AButton>
                </ASpace>
              </template>
            </template>
          </ATable>
        </ATabPane>

        <ATabPane key="categories" tab="分类管理">
          <div class="table-toolbar category-toolbar">
            <AButton type="primary" ghost :disabled="isDemoAdmin" @click="openCategoryModal">
              <PlusOutlined />
              新增分类
            </AButton>
          </div>
          <ATable
            row-key="id"
            :loading="loading"
            :columns="categoryColumns"
            :data-source="categoryData"
            :pagination="false"
            :size="tableSize"
            :scroll="{ x: tableScrollX }"
          >
            <template #bodyCell="{ column, record, index }">
              <template v-if="column.key === 'index'">{{ index + 1 }}</template>
              <template v-else-if="column.key === 'enabled'">
                <ATag :color="record.enabled ? 'green' : 'default'">{{ record.enabled ? '启用' : '停用' }}</ATag>
              </template>
              <template v-else-if="column.key === 'action'">
                <ASpace>
                  <AButton
                    type="link"
                    size="small"
                    :disabled="isDemoAdmin"
                    @click="openEditCategory(record as GalleryCategoryItem)"
                  >
                    <EditOutlined />
                    编辑
                  </AButton>
                  <AButton
                    type="link"
                    size="small"
                    danger
                    :disabled="isDemoAdmin"
                    @click="confirmDeleteCategory(record as GalleryCategoryItem)"
                  >
                    <DeleteOutlined />
                    删除
                  </AButton>
                </ASpace>
              </template>
            </template>
          </ATable>
        </ATabPane>

        <ATabPane key="duplicates" tab="查重管理">
          <div class="duplicate-toolbar">
            <ASpace wrap>
              <span>查重条件：</span>
              <ACheckboxGroup v-model:value="duplicateConditions" @change="handleDuplicateConditionChange">
                <ACheckbox value="resolution">分辨率</ACheckbox>
                <ACheckbox value="ratio">比例</ACheckbox>
                <ACheckbox value="size">大小</ACheckbox>
              </ACheckboxGroup>
            </ASpace>
            <ASpace wrap>
              <span>重复组 {{ duplicateGroups.length }} 组，重复图片 {{ duplicateImageCount }} 张</span>
              <AButton size="small" :disabled="!duplicateRows.length" @click="selectDuplicateExtras">每组保留一张</AButton>
            </ASpace>
          </div>
          <AAlert
            v-if="!duplicateConditions.length"
            message="请至少选择一个查重条件"
            type="warning"
            show-icon
            class="duplicate-alert"
          />
          <ATable
            row-key="id"
            :loading="loading"
            :columns="duplicateColumns"
            :data-source="duplicateRows"
            :pagination="false"
            :size="tableSize"
            :scroll="{ x: tableScrollX }"
            :row-selection="{
              selectedRowKeys: duplicateSelectedRowKeys,
              onChange: (keys: (string | number)[]) => (duplicateSelectedRowKeys = keys.map(String))
            }"
          >
            <template #title>
              <ASpace>
                <span>已选择 {{ duplicateSelectedRowKeys.length }} 张</span>
                <AButton
                  danger
                  size="small"
                  :disabled="isDemoAdmin || !duplicateSelectedRowKeys.length"
                  @click="confirmDeleteSelectedDuplicates"
                >
                  批量删除
                </AButton>
              </ASpace>
            </template>
            <template #bodyCell="{ column, record }">
              <template v-if="column.key === 'url'">
                <AImage :src="record.url" :width="72" :height="46" />
              </template>
            </template>
          </ATable>
        </ATabPane>
        </ATabs>
      </div>
    </ACard>

    <AModal v-model:open="categoryModalOpen" title="画廊分类" :width="modalWidth" destroy-on-close>
      <AForm :model="categoryForm" layout="vertical">
        <AFormItem label="分类名称" required>
          <AInput v-model:value="categoryForm.name" placeholder="请输入分类名称" />
        </AFormItem>
        <AFormItem label="描述">
          <ATextarea v-model:value="categoryForm.description" placeholder="请输入分类描述" />
        </AFormItem>
        <AFormItem label="排序"><AInputNumber v-model:value="categoryForm.sort" class="w-full" /></AFormItem>
        <AFormItem label="启用状态"><ASwitch v-model:checked="categoryForm.enabled" /></AFormItem>
      </AForm>
      <template #footer>
        <AButton @click="categoryModalOpen = false">取消</AButton>
        <AButton type="primary" :disabled="isDemoAdmin" @click="handleCategorySubmit">保存</AButton>
      </template>
    </AModal>

    <AModal v-model:open="imageModalOpen" title="画廊图片" :width="modalWidth" destroy-on-close>
      <AForm :model="imageForm" layout="vertical">
        <AFormItem v-if="!isBatchLocalUpload" label="图片名称" required>
          <AInput v-model:value="imageForm.name" placeholder="请输入图片名称" />
        </AFormItem>
        <AFormItem label="图片来源" required>
          <ARadioGroup v-model:value="imageForm.sourceType" button-style="solid" @change="handleSourceTypeChange">
            <ARadioButton value="local">本地上传</ARadioButton>
            <ARadioButton value="external">外部引用</ARadioButton>
          </ARadioGroup>
        </AFormItem>
        <AFormItem v-if="imageForm.sourceType === 'local'" label="存储桶" required>
          <ASelect v-model:value="imageForm.bucketName" :loading="bucketLoading" placeholder="请选择存储桶">
            <ASelectOption v-for="item in bucketOptions" :key="item.name" :value="item.name">
              {{ item.name }}{{ item.isPublic ? '（公开）' : '（私有）' }}
            </ASelectOption>
          </ASelect>
        </AFormItem>
        <AFormItem v-if="imageForm.sourceType === 'local'" label="上传图片" required>
          <AUpload
            v-model:file-list="uploadFileList"
            accept="image/*"
            :multiple="!editingImage"
            :max-count="editingImage ? 1 : undefined"
            :show-upload-list="true"
            :before-upload="handleBeforeLocalUpload"
            @change="handleLocalUpload"
          >
            <AButton :loading="uploadLoading">
              <UploadOutlined />
              选择本地图片
            </AButton>
          </AUpload>
          <div v-if="isBatchLocalUpload" class="generated-url">
            将按文件名创建 {{ selectedLocalFiles.length }} 条画廊记录
          </div>
          <div v-else-if="imageForm.url" class="generated-url">链接已生成：{{ imageForm.url }}</div>
        </AFormItem>
        <AFormItem v-else label="图片链接" required>
          <AInput v-model:value="imageForm.url" placeholder="请输入外部图片链接" @input="scheduleExternalImageMetadata" @blur="fillExternalImageMetadata" @press-enter="fillExternalImageMetadata" />
        </AFormItem>
        <AFormItem label="分类" required>
          <ASelect v-model:value="imageForm.categoryId" placeholder="请选择分类">
            <ASelectOption v-for="item in categoryOptions" :key="item.id" :value="item.id">
              {{ item.name }}
            </ASelectOption>
          </ASelect>
        </AFormItem>
        <ARow v-if="!isBatchLocalUpload" :gutter="16">
          <ACol :span="6">
            <AFormItem label="分辨率"><AInput v-model:value="imageForm.resolution" placeholder="例如 4K" /></AFormItem>
          </ACol>
          <ACol :span="6">
            <AFormItem label="比例"><AInput v-model:value="imageForm.ratio" placeholder="例如 16:9" /></AFormItem>
          </ACol>
          <ACol :span="6">
            <AFormItem label="时间">
              <ADatePicker
                v-model:value="imageForm.time"
                value-format="YYYY-MM-DD"
                class="w-full"
                placeholder="请选择时间"
              />
            </AFormItem>
          </ACol>
          <ACol :span="6">
            <AFormItem label="大小（MB）">
              <AInputNumber v-model:value="imageForm.size" :min="0" class="w-full" />
            </AFormItem>
          </ACol>
        </ARow>
        <AFormItem label="启用状态"><ASwitch v-model:checked="imageForm.enabled" /></AFormItem>
      </AForm>
      <template #footer>
        <AButton @click="imageModalOpen = false">取消</AButton>
        <AButton type="primary" :disabled="isDemoAdmin" @click="handleImageSubmit">保存</AButton>
      </template>
    </AModal>
  </div>
</template>

<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, reactive, ref } from 'vue';
import type { TableColumnsType, UploadChangeParam, UploadProps } from 'ant-design-vue';
import { Modal, message } from 'ant-design-vue';
import {
  CopyOutlined,
  DeleteOutlined,
  EditOutlined,
  PlusOutlined,
  SearchOutlined,
  UploadOutlined
} from '@ant-design/icons-vue';
import { type RustfsBucketItem, deleteBlogImage, getRustfsBuckets, uploadBlogImage } from '@/service/blog/admin/image';
import {
  type GalleryCategoryItem,
  type GalleryImageItem,
  createGalleryCategory,
  createGalleryImage,
  deleteGalleryCategory,
  deleteGalleryImage,
  getGalleryCategoryOptions,
  getGalleryCategoryPageList,
  getGalleryImagePageList,
  updateGalleryCategory,
  updateGalleryImage
} from '@/service/blog/admin/gallery';
import { useAppStore } from '@/store/system/app';
import { useAuthStore } from '@/store/system/auth';

defineOptions({ name: 'BlogAdminGalleryManage' });

const appStore = useAppStore();
const activeTab = ref('images');
const loading = ref(false);
const categoryKeyword = ref('');
const imageKeyword = ref('');
const categoryModalOpen = ref(false);
const imageModalOpen = ref(false);
const bucketLoading = ref(false);
const uploadLoading = ref(false);
const bucketOptions = ref<RustfsBucketItem[]>([]);
const defaultBucketName = ref(localStorage.getItem('blog-gallery-default-bucket') || '');
const uploadFileList = ref<UploadProps['fileList']>([]);
const selectedLocalFiles = ref<File[]>([]);
let externalMetadataTimer: ReturnType<typeof setTimeout> | null = null;
let imageSearchTimer: ReturnType<typeof setTimeout> | null = null;
const categoryForm = reactive({ name: '', description: '', sort: 0, enabled: true });
const imageForm = reactive({
  sourceType: 'local' as 'local' | 'external',
  bucketName: '',
  name: '',
  categoryId: '',
  resolution: '',
  ratio: '',
  time: '',
  url: '',
  objectName: '',
  fileName: '',
  size: 0,
  sort: 0,
  enabled: true
});

const authStore = useAuthStore();
const categoryData = ref<GalleryCategoryItem[]>([]);
const categoryOptions = ref<GalleryCategoryItem[]>([]);
const imageData = ref<GalleryImageItem[]>([]);
const selectedImageRowKeys = ref<string[]>([]);
const duplicateSelectedRowKeys = ref<string[]>([]);
const duplicateConditions = ref<string[]>(['resolution', 'ratio', 'size']);
const editingCategory = ref<GalleryCategoryItem | null>(null);
const editingImage = ref<GalleryImageItem | null>(null);
const isDemoAdmin = computed(() => {
  const roleText = authStore.userInfo.roles.join(',').toLowerCase();
  const userText = `${authStore.userInfo.userName},${authStore.userInfo.displayName}`.toLowerCase();
  return /demo|visitor|演示|游客/.test(roleText) || /demo|visitor|演示|游客/.test(userText);
});
const readonlyActionMessage = '游客演示账号仅允许查看画廊数据，不能上传、新增、修改或删除';

const tableSize = computed(() => (appStore.isMobile ? 'small' : 'middle'));
const tableScrollX = computed(() => (appStore.isMobile ? 1180 : 1400));
const modalWidth = computed(() => (appStore.isMobile ? '92vw' : 560));
const isBatchLocalUpload = computed(
  () => !editingImage.value && imageForm.sourceType === 'local' && selectedLocalFiles.value.length > 1
);

const categoryColumns: TableColumnsType<GalleryCategoryItem> = [
  { title: '序号', key: 'index', width: 80, align: 'center' },
  { title: '分类名称', dataIndex: 'name', key: 'name', width: 180, align: 'center' },
  { title: '描述', dataIndex: 'description', key: 'description', width: 260, align: 'center', ellipsis: true },
  { title: '排序', dataIndex: 'sort', key: 'sort', width: 100, align: 'center' },
  { title: '状态', dataIndex: 'enabled', key: 'enabled', width: 100, align: 'center' },
  { title: '操作', key: 'action', width: 180, align: 'center', fixed: appStore.isMobile ? undefined : 'right' }
];

const imageColumns: TableColumnsType<GalleryImageItem> = [
  { title: '序号', key: 'index', width: 80, align: 'center' },
  { title: '图片', dataIndex: 'url', key: 'url', width: 120, align: 'center' },
  { title: '图片链接', dataIndex: 'url', key: 'link', width: 260, align: 'center', ellipsis: true },
  { title: '名称', dataIndex: 'name', key: 'name', width: 180, align: 'center', ellipsis: true },
  { title: '分类', dataIndex: 'categoryName', key: 'categoryName', width: 140, align: 'center' },
  { title: '分辨率', dataIndex: 'resolution', key: 'resolution', width: 100, align: 'center' },
  { title: '比例', dataIndex: 'ratio', key: 'ratio', width: 100, align: 'center', customRender: ({ text }) => formatRatio(text) },
  {
    title: '大小',
    dataIndex: 'size',
    key: 'size',
    width: 100,
    align: 'center',
    customRender: ({ text }) => `${text} MB`
  },
  { title: '时间', dataIndex: 'time', key: 'time', width: 140, align: 'center' },
  { title: '状态', dataIndex: 'enabled', key: 'enabled', width: 100, align: 'center' },
  { title: '操作', key: 'action', width: 180, align: 'center', fixed: appStore.isMobile ? undefined : 'right' }
];

type DuplicateImageRow = GalleryImageItem & { duplicateGroupKey: string; duplicateGroupLabel: string; duplicateGroupCount: number };

const duplicateColumns: TableColumnsType<DuplicateImageRow> = [
  { title: '重复组标识', dataIndex: 'duplicateGroupLabel', key: 'duplicateGroupLabel', width: 260, align: 'center' },
  { title: '组内数量', dataIndex: 'duplicateGroupCount', key: 'duplicateGroupCount', width: 100, align: 'center' },
  { title: '图片', dataIndex: 'url', key: 'url', width: 120, align: 'center' },
  { title: '名称', dataIndex: 'name', key: 'name', width: 180, align: 'center', ellipsis: true },
  { title: '分类', dataIndex: 'categoryName', key: 'categoryName', width: 140, align: 'center' },
  { title: '分辨率', dataIndex: 'resolution', key: 'resolution', width: 110, align: 'center' },
  { title: '比例', dataIndex: 'ratio', key: 'ratio', width: 100, align: 'center', customRender: ({ text }) => formatRatio(text) },
  { title: '大小', dataIndex: 'size', key: 'size', width: 100, align: 'center', customRender: ({ text }) => `${text} MB` },
  { title: '时间', dataIndex: 'time', key: 'time', width: 140, align: 'center' }
];

const duplicateGroups = computed(() => {
  if (!duplicateConditions.value.length) return [];
  const groups = new Map<string, GalleryImageItem[]>();
  imageData.value.forEach(item => {
    const values = duplicateConditions.value.map(condition => {
      if (condition === 'resolution') return item.resolution || '';
      if (condition === 'ratio') return item.ratio || '';
      return item.size;
    });
    const key = JSON.stringify(values);
    groups.set(key, [...(groups.get(key) || []), item]);
  });
  return [...groups.entries()].filter(([, items]) => items.length >= 2);
});

const duplicateRows = computed<DuplicateImageRow[]>(() =>
  duplicateGroups.value.flatMap(([key, items]) => {
    const labels = duplicateConditions.value.map(condition => {
      if (condition === 'resolution') return items[0].resolution || '空分辨率';
      if (condition === 'ratio') return items[0].ratio ? formatRatio(items[0].ratio) : '空比例';
      return `${items[0].size} MB`;
    });
    return items.map(item => ({
      ...item,
      duplicateGroupKey: key,
      duplicateGroupLabel: labels.join(' / '),
      duplicateGroupCount: items.length
    }));
  })
);

const duplicateImageCount = computed(() => duplicateRows.value.length);

async function loadCategories() {
  loading.value = true;
  try {
    const res = await getGalleryCategoryPageList({
      pageNumber: 1,
      pageSize: 200,
      keyword: categoryKeyword.value || undefined
    });
    if (res.success) categoryData.value = res.data.items ?? res.data.records ?? [];
  } finally {
    loading.value = false;
  }
}

async function loadCategoryOptions() {
  const res = await getGalleryCategoryOptions();
  if (res.success) categoryOptions.value = res.data;
}

async function loadImages() {
  loading.value = true;
  try {
    const pageSize = 200;
    const firstRes = await getGalleryImagePageList({ pageNumber: 1, pageSize, keyword: imageKeyword.value || undefined });
    if (!firstRes.success) return;
    const firstItems = firstRes.data.items ?? firstRes.data.records ?? [];
    const totalCount = firstRes.data.totalCount ?? firstRes.data.total ?? firstItems.length;
    const pageCount = Math.ceil(totalCount / pageSize);
    const pages = await Promise.all(
      Array.from({ length: pageCount - 1 }, (_, index) =>
        getGalleryImagePageList({ pageNumber: index + 2, pageSize, keyword: imageKeyword.value || undefined })
      )
    );
    imageData.value = firstItems.concat(...pages.filter(res => res.success).map(res => res.data.items ?? res.data.records ?? []));
  } finally {
    loading.value = false;
  }
}

function formatRatio(ratio: string) {
  const [width, height] = ratio.split(':').map(Number);
  if (!width || !height) return ratio;
  let bestWidth = 1;
  let bestHeight = 1;
  let bestDifference = Number.POSITIVE_INFINITY;
  for (let candidateWidth = 1; candidateWidth <= 9; candidateWidth += 1) {
    for (let candidateHeight = 1; candidateHeight <= 9; candidateHeight += 1) {
      const difference = Math.abs(width / height - candidateWidth / candidateHeight);
      if (difference < bestDifference) {
        bestWidth = candidateWidth;
        bestHeight = candidateHeight;
        bestDifference = difference;
      }
    }
  }
  if (bestDifference / (width / height) <= 0.03) return `${bestWidth}:${bestHeight}`;
  bestWidth = 1;
  bestHeight = 1;
  bestDifference = Number.POSITIVE_INFINITY;
  for (let candidateWidth = 1; candidateWidth <= 99; candidateWidth += 1) {
    for (let candidateHeight = 1; candidateHeight <= 99; candidateHeight += 1) {
      if (candidateWidth <= 9 || candidateHeight <= 9) {
        const difference = Math.abs(width / height - candidateWidth / candidateHeight);
        if (difference < bestDifference) {
          bestWidth = candidateWidth;
          bestHeight = candidateHeight;
          bestDifference = difference;
        }
      }
    }
  }
  return `${bestWidth}:${bestHeight}`;
}

async function loadData() {
  await Promise.all([loadCategories(), loadCategoryOptions(), loadImages()]);
}

function scheduleImageSearch() {
  if (imageSearchTimer) clearTimeout(imageSearchTimer);
  imageSearchTimer = setTimeout(loadImages, 300);
}

function warnReadonlyAction() {
  message.warning(readonlyActionMessage);
}

function ensureWritable() {
  if (!isDemoAdmin.value) return true;
  warnReadonlyAction();
  return false;
}

async function copyImageUrl(url: string) {
  if (!url) return;

  try {
    await navigator.clipboard.writeText(url);
    message.success('图片链接已复制');
  } catch {
    const input = document.createElement('textarea');
    input.value = url;
    input.style.position = 'fixed';
    input.style.opacity = '0';
    document.body.append(input);
    input.select();
    document.execCommand('copy');
    input.remove();
    message.success('图片链接已复制');
  }
}

async function loadBuckets() {
  bucketLoading.value = true;
  try {
    const res = await getRustfsBuckets();
    if (res.success) {
      bucketOptions.value = res.data;
      const defaultExists = res.data.some(item => item.name === defaultBucketName.value);
      if (!defaultExists) defaultBucketName.value = '';
      if (!imageForm.bucketName && res.data.length) imageForm.bucketName = defaultBucketName.value || res.data[0].name;
    }
  } finally {
    bucketLoading.value = false;
  }
}

function saveDefaultBucket(value: unknown) {
  const bucketName = typeof value === 'string' ? value : '';
  defaultBucketName.value = bucketName;
  if (bucketName) localStorage.setItem('blog-gallery-default-bucket', bucketName);
  else localStorage.removeItem('blog-gallery-default-bucket');
  message.success(bucketName ? '默认上传桶已设置' : '已取消默认上传桶');
}

function resetCategoryForm() {
  Object.assign(categoryForm, { name: '', description: '', sort: 0, enabled: true });
}

function resetImageForm() {
  Object.assign(imageForm, {
    sourceType: 'local',
    bucketName: defaultBucketName.value || bucketOptions.value[0]?.name || '',
    name: '',
    categoryId: '',
    resolution: '',
    ratio: '',
    time: '',
    url: '',
    objectName: '',
    fileName: '',
    size: 0,
    sort: 0,
    enabled: true
  });
  uploadFileList.value = [];
  selectedLocalFiles.value = [];
}

async function uploadLocalFile(file: File) {
  const res = await uploadBlogImage({
    newImageFile: file,
    newImageOriginalName: file.name,
    bucketName: imageForm.bucketName
  });
  return res.success ? res.data?.url : undefined;
}

async function uploadSelectedLocalImage() {
  if (!ensureWritable()) {
    uploadFileList.value = [];
    selectedLocalFiles.value = [];
    return false;
  }

  const file = selectedLocalFiles.value[0];
  if (!file) {
    message.warning('请先选择本地图片');
    return false;
  }
  if (!imageForm.bucketName) {
    message.warning('请先选择存储桶');
    return false;
  }
  if (uploadLoading.value) return false;

  uploadLoading.value = true;
  try {
    const url = await uploadLocalFile(file);
    if (url) {
      imageForm.url = url;
      imageForm.objectName = getObjectName(url, imageForm.bucketName);
      imageForm.fileName = file.name;
      if (!imageForm.name) imageForm.name = file.name.replace(/\.[^.]+$/, '');
      message.success('图片上传成功，链接已自动生成');
      return true;
    }

    message.error('图片上传失败，未获取到图片链接');
    return false;
  } finally {
    uploadLoading.value = false;
  }
}

async function getImageMetadata(file: File) {
  const image = await createImageBitmap(file);
  const gcd = (a: number, b: number): number => (b ? gcd(b, a % b) : a);
  const divisor = gcd(image.width, image.height);
  const metadata = {
    resolution: `${image.width}x${image.height}`,
    ratio: formatRatio(`${image.width / divisor}:${image.height / divisor}`),
    time: new Date(file.lastModified).toISOString().slice(0, 10)
  };
  image.close();
  return metadata;
}

async function fillImageMetadata(file: File) {
  Object.assign(imageForm, await getImageMetadata(file));
}

function handleBeforeLocalUpload() {
  return false;
}

async function handleLocalUpload(change: UploadChangeParam) {
  if (!ensureWritable()) {
    uploadFileList.value = [];
    selectedLocalFiles.value = [];
    return;
  }

  selectedLocalFiles.value = change.fileList.flatMap(item => {
    const file = item.originFileObj;
    return file instanceof File ? [file] : [];
  });
  const changedFile = change.file.originFileObj;
  if (changedFile instanceof File && selectedLocalFiles.value.length === 0) {
    selectedLocalFiles.value = [changedFile];
  }
  imageForm.url = '';
  imageForm.size = selectedLocalFiles.value.length === 1
    ? Math.max(1, Math.ceil(selectedLocalFiles.value[0].size / 1024 / 1024))
    : 0;

  if (selectedLocalFiles.value.length === 1) {
    const [file] = selectedLocalFiles.value;
    imageForm.name = file.name.replace(/\.[^.]+$/, '');
    await fillImageMetadata(file);
  } else if (selectedLocalFiles.value.length > 1) {
    imageForm.name = '';
    imageForm.resolution = '';
    imageForm.ratio = '';
    imageForm.time = '';
  }
}

function handleSourceTypeChange() {
  imageForm.url = '';
  uploadFileList.value = [];
  selectedLocalFiles.value = [];
  if (imageForm.sourceType === 'external') {
    imageForm.size = 0;
    if (!imageForm.time) imageForm.time = new Date().toLocaleDateString('en-CA');
  }
}

function scheduleExternalImageMetadata() {
  if (externalMetadataTimer) clearTimeout(externalMetadataTimer);
  externalMetadataTimer = setTimeout(fillExternalImageMetadata, 500);
}

async function fillExternalImageMetadata() {
  if (externalMetadataTimer) clearTimeout(externalMetadataTimer);
  externalMetadataTimer = null;
  const url = imageForm.url.trim();
  if (!/^https?:\/\/.+/i.test(url)) return;

  try {
    const parsedUrl = new URL(url);
    const fileName = decodeURIComponent(parsedUrl.pathname.split('/').pop() || '');
    imageForm.name = fileName.replace(/\.[^.]+$/, '') || parsedUrl.hostname;
  } catch {
    return;
  }

  const image = new Image();
  image.onload = () => {
    imageForm.resolution = `${image.naturalWidth}x${image.naturalHeight}`;
    imageForm.ratio = formatRatio(`${image.naturalWidth}:${image.naturalHeight}`);
  };
  image.onerror = () => message.warning('无法读取外部图片信息，请检查图片链接');
  image.src = url;
}

function validateExternalImageUrl(url: string) {
  try {
    const parsedUrl = new URL(url);
    if (!['http:', 'https:'].includes(parsedUrl.protocol)) return Promise.resolve(false);
  } catch {
    return Promise.resolve(false);
  }

  return new Promise<boolean>(resolve => {
    const image = new Image();
    image.onload = () => resolve(image.naturalWidth > 0 && image.naturalHeight > 0);
    image.onerror = () => resolve(false);
    image.src = url;
  });
}

async function canSaveExternalImage() {
  if (imageForm.sourceType !== 'external') return true;
  if (await validateExternalImageUrl(imageForm.url.trim())) return true;
  message.warning('请输入可以正常访问的有效图片链接');
  return false;
}

async function ensureLocalImageUploaded() {
  if (imageForm.sourceType !== 'local' || imageForm.url.trim()) return true;
  return uploadSelectedLocalImage();
}

function getObjectName(url: string, bucketName: string) {
  try {
    const segments = new URL(url).pathname.split('/').filter(Boolean).map(decodeURIComponent);
    const bucketIndex = segments.indexOf(bucketName);
    return segments.slice(bucketIndex >= 0 ? bucketIndex + 1 : 1).join('/');
  } catch {
    return '';
  }
}

function shouldCleanupOldLocalImage(oldImage: GalleryImageItem | null, newUrl: string) {
  if (!oldImage || oldImage.sourceType !== 'local' || !oldImage.url) return false;
  return oldImage.url !== newUrl;
}

async function cleanupOldLocalImage(oldImage: GalleryImageItem | null, newUrl: string) {
  if (!shouldCleanupOldLocalImage(oldImage, newUrl)) return;

  try {
    await deleteBlogImage(oldImage!.url);
  } catch {
    message.warning('记录已保存，但旧图片从 RustFS 删除失败，请稍后在图片管理中手动清理');
  }
}

function openCategoryModal() {
  if (!ensureWritable()) return;
  editingCategory.value = null;
  resetCategoryForm();
  categoryModalOpen.value = true;
}

async function openImageModal() {
  if (!ensureWritable()) return;
  editingImage.value = null;
  if (!bucketOptions.value.length) await loadBuckets();
  resetImageForm();
  imageModalOpen.value = true;
}

function openEditCategory(record: GalleryCategoryItem) {
  if (!ensureWritable()) return;
  editingCategory.value = record;
  Object.assign(categoryForm, {
    name: record.name,
    description: record.description,
    sort: record.sort,
    enabled: record.enabled
  });
  categoryModalOpen.value = true;
}

async function handleCategorySubmit() {
  if (!ensureWritable()) return;
  const payload = { ...categoryForm, name: categoryForm.name.trim(), description: categoryForm.description.trim() };
  if (editingCategory.value) await updateGalleryCategory(editingCategory.value.id, payload);
  else await createGalleryCategory(payload);
  message.success('保存成功');
  categoryModalOpen.value = false;
  await Promise.all([loadCategories(), loadCategoryOptions()]);
}

function openEditImage(record: GalleryImageItem) {
  if (!ensureWritable()) return;
  editingImage.value = record;
  Object.assign(imageForm, {
    sourceType: record.sourceType || 'external',
    bucketName: record.bucketName || bucketOptions.value[0]?.name || '',
    name: record.name,
    categoryId: record.categoryId,
    resolution: record.resolution,
    ratio: record.ratio,
    time: record.time || '',
    url: record.url,
    objectName: record.objectName,
    fileName: record.fileName,
    size: record.size,
    sort: record.sort,
    enabled: record.enabled
  });
  uploadFileList.value = [];
  selectedLocalFiles.value = [];
  imageModalOpen.value = true;
}

async function createSelectedLocalImages() {
  if (!selectedLocalFiles.value.length) {
    message.warning('请先选择本地图片');
    return false;
  }
  if (uploadLoading.value) return false;

  uploadLoading.value = true;
  try {
    await Promise.all(
      selectedLocalFiles.value.map(async file => {
        const [url, metadata] = await Promise.all([uploadLocalFile(file), getImageMetadata(file)]);
        if (!url) throw new Error(`${file.name} 上传失败`);
        await createGalleryImage({
          name: file.name.replace(/\.[^.]+$/, ''),
          categoryId: imageForm.categoryId,
          ...metadata,
          url,
          sourceType: 'local',
          bucketName: imageForm.bucketName,
          objectName: '',
          fileName: file.name,
          size: Math.max(1, Math.ceil(file.size / 1024 / 1024)),
          sort: 0,
          enabled: imageForm.enabled
        });
      })
    );
    return true;
  } finally {
    uploadLoading.value = false;
  }
}

async function handleImageSubmit() {
  if (!ensureWritable()) return;
  if (!imageForm.categoryId) {
    message.warning('请选择图片分类');
    return;
  }
  if (imageForm.sourceType === 'local' && !imageForm.bucketName) {
    message.warning('请选择存储桶');
    return;
  }
  if (isBatchLocalUpload.value) {
    const created = await createSelectedLocalImages();
    if (!created) return;
    message.success(`成功上传 ${selectedLocalFiles.value.length} 张图片`);
    imageModalOpen.value = false;
    await loadImages();
    return;
  }
  if (!imageForm.name.trim()) {
    message.warning('请输入图片名称');
    return;
  }
  if (!(await canSaveExternalImage())) return;
  if (!(await ensureLocalImageUploaded())) return;

  if (!imageForm.url.trim()) {
    message.warning(imageForm.sourceType === 'local' ? '请先选择并上传本地图片' : '请输入外部图片链接');
    return;
  }

  const payload = {
    name: imageForm.name.trim(),
    categoryId: imageForm.categoryId,
    resolution: imageForm.resolution.trim(),
    ratio: imageForm.ratio.trim(),
    time: imageForm.time || undefined,
    url: imageForm.url.trim(),
    sourceType: imageForm.sourceType,
    bucketName: imageForm.sourceType === 'local' ? imageForm.bucketName : '',
    objectName: imageForm.sourceType === 'local' ? imageForm.objectName : '',
    fileName: imageForm.sourceType === 'local' ? imageForm.fileName : '',
    size: imageForm.sourceType === 'local' && selectedLocalFiles.value[0]
      ? Math.max(1, Math.ceil(selectedLocalFiles.value[0].size / 1024 / 1024))
      : imageForm.size,
    sort: imageForm.sort,
    enabled: imageForm.enabled
  };
  const oldImage = editingImage.value;
  if (oldImage) await updateGalleryImage(oldImage.id, payload);
  else await createGalleryImage(payload);
  await cleanupOldLocalImage(oldImage, payload.url);
  message.success('保存成功');
  imageModalOpen.value = false;
  await loadImages();
}

function confirmDeleteCategory(record: GalleryCategoryItem) {
  if (!ensureWritable()) return;
  Modal.confirm({
    title: '删除分类',
    content: `确认删除分类“${record.name}”？`,
    okText: '删除',
    okType: 'danger',
    cancelText: '取消',
    async onOk() {
      await deleteGalleryCategory(record.id);
      message.success('删除成功');
      await Promise.all([loadCategories(), loadCategoryOptions()]);
    }
  });
}

function confirmDeleteImages(records: GalleryImageItem[]) {
  if (!ensureWritable() || !records.length) return;
  Modal.confirm({
    title: '批量删除图片',
    content: `确认删除选中的 ${records.length} 张图片？删除后本地图片会同步从 RustFS 删除。`,
    okText: '删除',
    okType: 'danger',
    cancelText: '取消',
    async onOk() {
      await Promise.all(records.map(record => deleteGalleryImage(record.id)));
      await Promise.all(records.map(record => cleanupOldLocalImage(record, '')));
      selectedImageRowKeys.value = [];
      duplicateSelectedRowKeys.value = [];
      message.success(`已删除 ${records.length} 张图片`);
      await loadImages();
    }
  });
}

function handleDuplicateConditionChange() {
  duplicateSelectedRowKeys.value = [];
  if (!duplicateConditions.value.length) message.warning('请至少选择一个查重条件');
}

function selectDuplicateExtras() {
  duplicateSelectedRowKeys.value = duplicateGroups.value.flatMap(([, items]) => items.slice(1).map(item => item.id));
}

function confirmDeleteSelectedDuplicates() {
  const records = duplicateRows.value.filter(item => duplicateSelectedRowKeys.value.includes(item.id));
  confirmDeleteImages(records);
}

function confirmDeleteImage(record: GalleryImageItem) {
  if (!ensureWritable()) return;
  Modal.confirm({
    title: '删除图片',
    content:
      record.sourceType === 'local'
        ? `确认删除图片“${record.name}”？删除后会同步删除 RustFS 中的图片。`
        : `确认删除图片“${record.name}”？`,
    okText: '删除',
    okType: 'danger',
    cancelText: '取消',
    async onOk() {
      await deleteGalleryImage(record.id);
      await cleanupOldLocalImage(record, '');
      message.success('删除成功');
      await loadImages();
    }
  });
}

onMounted(() => {
  loadBuckets();
  loadData();
});

onBeforeUnmount(() => {
  if (externalMetadataTimer) clearTimeout(externalMetadataTimer);
  if (imageSearchTimer) clearTimeout(imageSearchTimer);
});
</script>

<style scoped lang="scss">
.gallery-admin-page {
  padding: 16px;
}

.page-card {
  min-height: calc(100vh - 140px);
}

.gallery-toolbar-row {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 12px;
}

.gallery-tabs-wrapper {
  position: relative;
}

.gallery-tabs-wrapper > :deep(.ant-tabs) {
  width: 100%;
}

.default-bucket-bar {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  font-weight: 600;
}

:deep(.ant-tabs-extra-content) {
  display: flex;
  align-items: center;
}

:deep(.ant-tabs-nav) {
  align-items: center;
  margin-bottom: 0;
}

.default-bucket-select {
  width: 260px;
}

.table-toolbar {
  display: flex;
  justify-content: space-between;
  gap: 12px;
  margin-bottom: 16px;
}

.category-toolbar {
  justify-content: flex-end;
  padding-top: 16px;
}

.duplicate-toolbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  padding: 16px 0;
}

.duplicate-alert {
  margin-bottom: 12px;
}

.search-input {
  max-width: 340px;
}

:deep(.ant-image-img) {
  object-fit: cover;
  border-radius: 8px;
}

.generated-url {
  margin-top: 8px;
  word-break: break-all;
  color: #16a34a;
  font-size: 12px;
  line-height: 1.6;
}

.copy-link-button {
  max-width: 220px;
  padding-inline: 0;
}

@media (max-width: 768px) {
  .default-bucket-bar {
    align-items: flex-start;
    flex-direction: column;
  }

  .default-bucket-select {
    width: 100%;
  }

  .gallery-admin-page {
    padding: 12px;
  }

  .gallery-toolbar-row {
    align-items: stretch;
    flex-direction: column;
  }

  .table-toolbar,
  .duplicate-toolbar {
    align-items: flex-start;
    flex-direction: column;
  }

  .search-input {
    max-width: none;
    width: 100%;
  }
}
</style>
