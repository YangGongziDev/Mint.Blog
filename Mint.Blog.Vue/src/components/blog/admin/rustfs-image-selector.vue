<script setup lang="ts">
import { computed, reactive, ref, watch } from 'vue';
import type { TablePaginationConfig } from 'ant-design-vue';
import { message } from 'ant-design-vue';
import {
  type ManagedImageListItem,
  type ManagedImagePageQuery,
  type RustfsBucketItem,
  getManagedImagePageList,
  getRustfsBuckets
} from '@/service/blog/admin/image';
import { useAppStore } from '@/store/system/app';
import { resolveServiceErrorMessage } from '@/utils/service-error';

type GallerySortOrder = NonNullable<ManagedImagePageQuery['sortOrder']>;

const props = withDefaults(
  defineProps<{
    open: boolean;
    selectedUrl?: string;
    title?: string;
    width?: string | number;
  }>(),
  {
    selectedUrl: '',
    title: '从 RustFS 图库选择封面',
    width: undefined
  }
);

const emit = defineEmits<{
  'update:open': [value: boolean];
  select: [url: string];
}>();

const appStore = useAppStore();
const loading = ref(false);
const buckets = ref<RustfsBucketItem[]>([]);
const images = ref<ManagedImageListItem[]>([]);
const total = ref(0);
const selectedImageUrl = ref('');
const query = reactive({
  pageNumber: 1,
  pageSize: 12,
  bucketName: '',
  fileName: '',
  sortOrder: 'lastModifiedDesc' as GallerySortOrder
});

const modalWidth = computed(() => props.width ?? (appStore.isMobile ? '96vw' : 920));
const pagination = computed<TablePaginationConfig>(() => ({
  current: query.pageNumber,
  pageSize: query.pageSize,
  total: total.value,
  showSizeChanger: true,
  pageSizeOptions: ['12', '24', '48'],
  showTotal: value => `共 ${value} 张图片`,
  size: appStore.isMobile ? 'small' : 'default'
}));

watch(
  () => props.open,
  async value => {
    if (!value) return;
    selectedImageUrl.value = props.selectedUrl || '';
    await openSelector();
  }
);

watch(
  () => props.selectedUrl,
  value => {
    if (props.open) selectedImageUrl.value = value || '';
  }
);

function updateOpen(value: boolean) {
  emit('update:open', value);
}

async function loadBuckets() {
  const res = await getRustfsBuckets();
  if (!res.success) return false;
  buckets.value = res.data;
  if (!query.bucketName && res.data.length) query.bucketName = res.data[0].name;
  return true;
}

async function loadImages() {
  if (!query.bucketName) {
    images.value = [];
    total.value = 0;
    return;
  }

  loading.value = true;
  try {
    const res = await getManagedImagePageList({
      pageNumber: query.pageNumber,
      pageSize: query.pageSize,
      bucketName: query.bucketName,
      fileName: query.fileName || undefined,
      sortOrder: query.sortOrder
    });
    if (res.success) {
      images.value = res.data.items || res.data.records || [];
      total.value = res.data.totalCount || res.data.total || 0;
    }
  } finally {
    loading.value = false;
  }
}

async function openSelector() {
  try {
    if (!buckets.value.length) {
      const loaded = await loadBuckets();
      if (!loaded) return;
    }
    query.pageNumber = 1;
    await loadImages();
  } catch (error) {
    message.error(resolveServiceErrorMessage(error));
  }
}

async function handleBucketChange() {
  query.pageNumber = 1;
  selectedImageUrl.value = '';
  await loadImages();
}

async function handleSearch() {
  query.pageNumber = 1;
  await loadImages();
}

async function handleReset() {
  query.fileName = '';
  query.sortOrder = 'lastModifiedDesc';
  query.pageNumber = 1;
  await loadImages();
}

async function handlePageChange(page: TablePaginationConfig) {
  query.pageNumber = page.current || 1;
  query.pageSize = page.pageSize || 12;
  await loadImages();
}

function handleConfirm() {
  if (!selectedImageUrl.value) {
    message.warning('请选择一张图库图片');
    return;
  }
  emit('select', selectedImageUrl.value);
  updateOpen(false);
}

function formatImageSize(size: number) {
  if (size < 1024) return `${size} B`;
  if (size < 1024 * 1024) return `${(size / 1024).toFixed(1)} KiB`;
  return `${(size / 1024 / 1024).toFixed(2)} MiB`;
}
</script>

<template>
  <AModal
    :open="open"
    :title="title"
    :width="modalWidth"
    :confirm-loading="loading"
    @ok="handleConfirm"
    @update:open="updateOpen"
  >
    <ASpace direction="vertical" :size="16" class="w-full">
      <AForm layout="inline" class="gallery-filter-form">
        <AFormItem label="桶">
          <ASelect
            v-model:value="query.bucketName"
            class="gallery-bucket-select"
            placeholder="请选择桶"
            :options="buckets.map(item => ({ label: item.name, value: item.name }))"
            @change="handleBucketChange"
          />
        </AFormItem>
        <AFormItem label="名称">
          <AInput v-model:value="query.fileName" allow-clear placeholder="搜索图片名称" @press-enter="handleSearch" />
        </AFormItem>
        <AFormItem label="排序">
          <ASelect v-model:value="query.sortOrder" class="gallery-sort-select" @change="handleSearch">
            <ASelectOption value="lastModifiedDesc">时间倒序</ASelectOption>
            <ASelectOption value="lastModifiedAsc">时间正序</ASelectOption>
            <ASelectOption value="nameAsc">名称 A-Z</ASelectOption>
            <ASelectOption value="nameDesc">名称 Z-A</ASelectOption>
          </ASelect>
        </AFormItem>
        <AFormItem>
          <ASpace>
            <AButton type="primary" :loading="loading" @click="handleSearch">搜索</AButton>
            <AButton @click="handleReset">重置</AButton>
          </ASpace>
        </AFormItem>
      </AForm>

      <ASpin :spinning="loading">
        <AEmpty v-if="!images.length" description="暂无图片" />
        <div v-else class="gallery-grid">
          <button
            v-for="image in images"
            :key="image.url"
            type="button"
            class="gallery-image-card"
            :class="{ active: selectedImageUrl === image.url }"
            @click="selectedImageUrl = image.url"
          >
            <img :src="image.url" :alt="image.fileName" />
            <span class="gallery-image-mask">
              <span class="gallery-image-name" :title="image.fileName">{{ image.fileName }}</span>
              <span class="gallery-image-meta">{{ formatImageSize(image.size) }}</span>
              <span class="gallery-image-meta">{{ image.lastModified || '-' }}</span>
            </span>
          </button>
        </div>
      </ASpin>

      <div class="flex justify-end">
        <APagination
          v-bind="pagination"
          @change="(page, pageSize) => handlePageChange({ current: page, pageSize })"
          @show-size-change="(page, pageSize) => handlePageChange({ current: page, pageSize })"
        />
      </div>
    </ASpace>
  </AModal>
</template>

<style scoped lang="scss">
.gallery-filter-form {
  row-gap: 12px;
}

.gallery-bucket-select {
  min-width: 180px;
}

.gallery-sort-select {
  min-width: 140px;
}

.gallery-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  gap: 12px;
  max-height: min(56vh, 520px);
  overflow-y: auto;
  padding: 2px 4px 4px 2px;
}

.gallery-image-card {
  position: relative;
  overflow: hidden;
  border: 2px solid transparent;
  border-radius: 12px;
  aspect-ratio: 16 / 10;
  background: rgb(var(--base-text-color) / 5%);
  text-align: left;
  transition:
    border-color 0.2s ease,
    transform 0.2s ease,
    box-shadow 0.2s ease;
}

.gallery-image-card.active {
  border-color: rgb(var(--primary-color));
  box-shadow: 0 8px 22px rgb(var(--primary-color) / 20%);
}

.gallery-image-card:hover {
  transform: translateY(-1px);
}

.gallery-image-card img {
  width: 100%;
  height: 100%;
  display: block;
  object-fit: cover;
}

.gallery-image-mask {
  position: absolute;
  right: 0;
  bottom: 0;
  left: 0;
  display: flex;
  flex-direction: column;
  gap: 2px;
  padding: 18px 10px 8px;
  color: #fff;
  background: linear-gradient(180deg, transparent, rgb(15 23 42 / 82%));
}

.gallery-image-name {
  overflow: hidden;
  font-size: 12px;
  font-weight: 600;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.gallery-image-meta {
  overflow: hidden;
  font-size: 11px;
  opacity: 0.82;
  text-overflow: ellipsis;
  white-space: nowrap;
}
</style>
