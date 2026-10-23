<template>
  <main class="gallery-page mx-auto max-w-screen-2xl px-4 py-0 md:px-6" :class="pageClass">
    <section class="filter-panel" :class="{ collapsed: !filterExpanded }">
      <button class="filter-toggle" type="button" @click="filterExpanded = !filterExpanded">{{ filterExpanded ? '收起筛选' : '展开筛选' }}</button>
      <div class="filter-row">
        <AInput v-model:value="searchKeyword" allow-clear placeholder="搜索图片名称"><template #prefix><SearchOutlined /></template></AInput>
        <ASelect v-model:value="activeCategory" class="filter-select"><ASelectOption value="all">全部分类（{{ galleryImages.length }}）</ASelectOption><ASelectOption v-for="item in categories" :key="item.id" :value="item.id">{{ item.name }}（{{ getCategoryCount(item.id) }}）</ASelectOption></ASelect>
        <ASelect v-model:value="activeResolution" class="filter-select"><ASelectOption value="all">全部分辨率</ASelectOption><ASelectOption v-for="item in resolutions" :key="item" :value="item">{{ item }}</ASelectOption></ASelect>
        <ASelect v-model:value="activeRatio" class="filter-select"><ASelectOption value="all">全部比例</ASelectOption><ASelectOption v-for="item in ratios" :key="item" :value="item">{{ item }}</ASelectOption></ASelect>
        <div class="sort-box"><SortAscendingOutlined /><select v-model="sortType" @change="loadGallery"><option value="timeDesc">时间最新</option><option value="timeAsc">时间最早</option><option value="nameAsc">名称 A-Z</option><option value="nameDesc">名称 Z-A</option></select></div>
      </div>
      <p class="copyright-notice">声明：如有侵权，请联系 yanggongzi@163.com，我会尽快删除。</p>
    </section>
    <section class="image-panel"><div class="toolbar"><div><h2>{{ activeCategoryName }}</h2><p>共 {{ filteredImages.length }} 张图片</p></div></div>
      <div v-if="loading" class="empty-state">正在加载图片...</div>
      <div v-else-if="!filteredImages.length" class="empty-state">暂无匹配图片</div>
      <div v-else class="image-grid">
        <article v-for="image in filteredImages" :key="image.id" class="image-card">
          <div class="image-cover" role="button" tabindex="0" @click="openPreview(image)" @keydown.enter="openPreview(image)">
            <img :src="image.url" :alt="image.name" loading="lazy" />
          </div>
          <div class="image-info">
            <h3>{{ image.name }}</h3>
          <div class="meta-row">
            <span>{{ image.categoryName }}</span>
            <span>{{ image.resolution }}</span>
            <span>{{ formatRatio(image.ratio) }}</span>
            <a class="download-action" :href="image.url" target="_blank" rel="noopener noreferrer" :download="image.name" @click.stop>
              <DownloadOutlined />下载({{ image.size }}M)
            </a>
          </div>
          <p><CalendarOutlined /> {{ image.time || '未设置时间' }}</p>
        </div>
      </article>
    </div>
    </section>
    <AModal v-model:open="previewOpen" centered :footer="null" width="min(92vw, 980px)" :title="previewImage?.name"><img v-if="previewImage" class="preview-img" :src="previewImage.url" :alt="previewImage.name" /></AModal>
  </main>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue';
import { CalendarOutlined, DownloadOutlined, SearchOutlined, SortAscendingOutlined } from '@ant-design/icons-vue';
import { type GalleryCategoryItem, type GalleryImageItem, getSurferGalleryCategories, getSurferGalleryImages } from '@/service/blog/admin/gallery';
import { useThemeStore } from '@/store/system/theme';

type SortType = 'nameAsc' | 'nameDesc' | 'timeDesc' | 'timeAsc';

defineOptions({ name: 'SurferGalleryPage' });
const themeStore = useThemeStore();
const pageClass = computed(() => ({ dark: themeStore.darkMode }));
const activeCategory = ref('all');
const searchKeyword = ref('');
const activeResolution = ref('all');
const activeRatio = ref('all');
const filterExpanded = ref(false);
const sortType = ref<SortType>('timeDesc');
const loading = ref(false);
const categories = ref<GalleryCategoryItem[]>([]);
const galleryImages = ref<GalleryImageItem[]>([]);
const previewOpen = ref(false);
const previewImage = ref<GalleryImageItem | null>(null);

const resolutions = computed(() => [...new Set(galleryImages.value.map(item => item.resolution).filter(Boolean))]);
const ratios = computed(() => [...new Set(galleryImages.value.map(item => item.ratio).filter(Boolean))]);
const filteredImages = computed(() => {
  const keyword = searchKeyword.value.trim().toLowerCase();
  return galleryImages.value
    .filter(item => activeCategory.value === 'all' || item.categoryId === activeCategory.value)
    .filter(item => activeResolution.value === 'all' || item.resolution === activeResolution.value)
    .filter(item => activeRatio.value === 'all' || item.ratio === activeRatio.value)
    .filter(item => !keyword || item.name.toLowerCase().includes(keyword))
    .sort((a, b) => {
      if (sortType.value === 'nameAsc') return a.name.localeCompare(b.name);
      if (sortType.value === 'nameDesc') return b.name.localeCompare(a.name);
      const aTime = new Date(a.time || a.createdAt || '').getTime();
      const bTime = new Date(b.time || b.createdAt || '').getTime();
      return sortType.value === 'timeAsc' ? aTime - bTime : bTime - aTime;
    });
});
const activeCategoryName = computed(() => activeCategory.value === 'all' ? '全部图片' : categories.value.find(item => item.id === activeCategory.value)?.name || '图片');

async function loadGallery() {
  loading.value = true;
  try {
    const [categoryRes, imageRes] = await Promise.all([
      getSurferGalleryCategories(),
      getSurferGalleryImages({ pageNumber: 1, pageSize: 200, sortOrder: sortType.value })
    ]);
    if (categoryRes.success) categories.value = categoryRes.data;
    if (imageRes.success) galleryImages.value = imageRes.data.items ?? imageRes.data.records ?? [];
  } finally { loading.value = false; }
}
function getCategoryCount(id: string) { return id === 'all' ? galleryImages.value.length : galleryImages.value.filter(item => item.categoryId === id).length; }
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
function openPreview(image: GalleryImageItem) { previewImage.value = image; previewOpen.value = true; }
onMounted(loadGallery);
</script>

<style scoped lang="scss">
.gallery-page { color: #0d3d2d; background-color: rgb(var(--layout-bg-color)); }.filter-panel,.image-panel { border: 1px solid rgb(62 207 154 / 42%); border-radius: 28px; background: rgb(255 255 255 / 88%); box-shadow: 0 8px 28px rgb(15 23 42 / 7%); }.filter-panel { position: sticky; top: 22px; z-index: 10; margin-top: 22px; padding: 18px; backdrop-filter: blur(14px); }.filter-toggle { display:none; }.panel-title { display:flex; gap:8px; margin-bottom:14px; font-weight:950; }.filter-row { display:flex; flex-wrap:wrap; gap:12px; }.filter-row :deep(.ant-input-affix-wrapper) { width:240px; }.filter-select { min-width:160px; }.filter-select :deep(.ant-select-selector) { height: 38px !important; align-items: center; border-radius: 999px !important; }.sort-box { display:inline-flex; height:38px; box-sizing:border-box; align-items:center; gap:8px; padding:8px 13px; border:1px solid rgb(62 207 154 / 30%); border-radius:999px; color:#15956b; }.sort-box select { border:0; outline:0; background:transparent; color:#15956b; font-weight:900; }.copyright-notice { position:absolute; top:18px; right:18px; max-width:420px; margin:0; color:#7a8f87; font-size:12px; line-height:1.6; white-space:normal; overflow-wrap:anywhere; text-align:right; }.image-panel { margin-top:22px; padding:22px; }.toolbar h2 { margin:0; font-size:24px; font-weight:950; }.toolbar p { margin:5px 0 20px; color:#6b8078; }.image-grid { display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:18px; }.image-card { overflow:hidden; border:1px solid rgb(15 61 45 / 8%); border-radius:24px; background:#fff; }.image-cover { position:relative; aspect-ratio:16/10; overflow:hidden; background:#eefbf6; cursor:pointer; }.image-cover img { width:100%; height:100%; object-fit:cover; }.image-info { padding:7.5px 15px; }.image-info h3 { margin:0; font-size:16px; }.meta-row { display:flex; flex-wrap:wrap; align-items:center; gap:7px; margin-top:0; }.meta-row span { border-radius:999px; padding:5px 9px; background:#e9faf3; color:#15956b; font-size:12px; }.download-action { display:inline-flex; align-items:center; gap:5px; margin-left:auto; padding:5px 9px; border:1px solid rgb(62 207 154 / 30%); border-radius:999px; background:#fff; color:#0d3d2d; font-size:12px; text-decoration:none; }.image-info p { display:flex; gap:6px; margin:0; color:#6b8078; font-size:12px; }.empty-state { padding:80px 0; text-align:center; color:#6b8078; }.preview-img { display:block; width:100%; max-height:76vh; object-fit:contain; border-radius:16px; }
.gallery-page.dark { color:#f8fafc; }
.gallery-page.dark .filter-panel, .gallery-page.dark .image-panel { border-color:rgb(51 65 85 / 90%); background:#2c333e; box-shadow:0 8px 28px rgb(0 0 0 / 18%); }
.gallery-page.dark .image-card { border-color:rgb(51 65 85 / 78%); background:rgb(30 41 59 / 72%); }
.gallery-page.dark .image-cover { background:#0f172a; }
.gallery-page.dark .toolbar h2, .gallery-page.dark .image-info h3 { color:#f8fafc; }
.gallery-page.dark .toolbar p, .gallery-page.dark .image-info p, .gallery-page.dark .empty-state, .gallery-page.dark .copyright-notice { color:#cbd5e1; }
.gallery-page.dark .meta-row span { background:rgb(62 207 154 / 14%); color:#6ee7b7; }
.gallery-page.dark .download-action { border-color:rgb(62 207 154 / 35%); background:rgb(15 23 42 / 55%); color:#d1fae5; }
.gallery-page.dark .sort-box { border-color:rgb(62 207 154 / 35%); color:#6ee7b7; }
.gallery-page.dark .sort-box select { color:#6ee7b7; color-scheme:dark; }
.gallery-page.dark .filter-row :deep(.ant-input-affix-wrapper), .gallery-page.dark .filter-select :deep(.ant-select-selector) { border-color:#475569 !important; background:#1e293b !important; color:#f8fafc !important; }
.gallery-page.dark .filter-row :deep(.ant-input), .gallery-page.dark .filter-row :deep(.ant-input-prefix), .gallery-page.dark .filter-select :deep(.ant-select-selection-item) { background:transparent !important; color:#f8fafc !important; }
.gallery-page.dark .filter-row :deep(.ant-input::placeholder), .gallery-page.dark .filter-select :deep(.ant-select-selection-placeholder), .gallery-page.dark .filter-select :deep(.ant-select-arrow), .gallery-page.dark .filter-row :deep(.ant-input-clear-icon) { color:#94a3b8 !important; }
@media(max-width:900px){.image-grid{grid-template-columns:repeat(2,minmax(0,1fr));}}@media(max-width:640px){.filter-panel{top:8px;margin-top:8px;padding:8px 10px;border-radius:16px;}.filter-toggle{display:block;width:100%;border:0;background:transparent;color:#15956b;font-size:14.5px;font-weight:900;text-align:left;cursor:pointer;}.filter-panel.collapsed .filter-row{display:none;}.filter-row{gap:8px;margin-top:8px;}.filter-row>*{width:100%!important;}.filter-row :deep(input),.filter-row :deep(.ant-select-selection-item),.filter-row :deep(.ant-select-selection-placeholder),.sort-box select{font-size:16px!important;}.filter-select{min-width:0;}.copyright-notice{position:static;max-width:100%;margin:6px 0 0;text-align:left;overflow:hidden;font-size:11px;text-overflow:ellipsis;}.image-panel{margin-top:12px;padding:12px;border-radius:18px;}.image-grid{grid-template-columns:1fr;}.image-cover img{display:block;}.image-info{padding:6px 15px;}.image-info h3{line-height:1.25;}.meta-row{flex-wrap:nowrap;gap:5px;margin-top:0;}.meta-row span{padding:5px 7px;font-size:11px;}.download-action{flex-shrink:0;padding:3px 6px;font-size:10px;}.image-info p{margin-top:0;}}
</style>
