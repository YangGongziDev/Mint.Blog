<template>
  <div class="gallery-page">
    <section class="filter-panel" :class="{ collapsed: !expanded }"><button class="filter-toggle" type="button" aria-controls="gallery-filters" :aria-expanded="expanded" @click="expanded = !expanded">{{ expanded ? '收起筛选' : '展开筛选' }}</button><div id="gallery-filters" class="filter-row">
      <label><span class="sr-only">搜索图片名称</span><input v-model="keyword" type="search" placeholder="搜索图片名称"></label>
      <GalleryFilterSelect v-model="category" label="分类" :options="[{ value: 'all', label: `全部分类（${images.length}）` }, ...(data?.categories || []).map(item => ({ value: item.id, label: `${item.name}（${count(item.id)}）` }))]" />
      <GalleryFilterSelect v-model="resolution" label="分辨率" :options="[{ value: 'all', label: '全部分辨率' }, ...resolutions.map(item => ({ value: item, label: item }))]" />
      <GalleryFilterSelect v-model="ratio" label="比例" :options="[{ value: 'all', label: '全部比例' }, ...ratios.map(item => ({ value: item, label: item }))]" />
      <GalleryFilterSelect v-model="sort" label="排序" :options="[{ value: 'timeDesc', label: '时间最新' }, { value: 'timeAsc', label: '时间最早' }, { value: 'nameAsc', label: '名称 A-Z' }, { value: 'nameDesc', label: '名称 Z-A' }]" />
    </div><p class="copyright-notice">声明：如有侵权，请联系 YangGongziDev@163.com，我会尽快删除。</p></section>
    <section class="image-panel"><header><h1>{{ categoryName }}</h1><p aria-live="polite">共 {{ filtered.length }} 张图片</p><small>每次读取当前排序首 200 张，筛选仅作用于本次读取范围。</small></header>
      <p v-if="status === 'pending'" class="empty-state" role="status">正在加载图片...</p><div v-else-if="error" class="empty-state" role="alert">图片暂时无法加载 <button type="button" @click="refresh()">重试</button></div>
      <div v-else-if="!filtered.length" class="empty-state">{{ images.length ? '暂无匹配图片' : '暂无图片' }} <button v-if="images.length" type="button" @click="reset">清除筛选</button></div>
      <div v-else class="image-grid"><article v-for="image in filtered" :key="image.id" class="image-card" :data-image-id="image.id"><button type="button" class="image-cover" :aria-label="`预览：${image.name}`" :disabled="!assetUrl(image.url)" @click="openPreview(image)"><img v-if="assetUrl(image.url) && !failed[image.id]" :src="assetUrl(image.url)" :alt="image.name" loading="lazy" @error="failed[image.id] = true"><span v-else>图片暂不可用</span></button><div class="image-info"><h2>{{ image.name }}</h2><div class="meta-row"><span>{{ image.categoryName }}</span><span>{{ image.resolution }}</span><span>{{ formatRatio(image.ratio) }}</span><a v-if="assetUrl(image.url)" :href="assetUrl(image.url)" target="_blank" rel="noopener noreferrer" :download="image.name">下载({{ image.size }}M)</a></div><p>{{ image.time || '未设置时间' }}</p></div></article></div>
    </section>
    <dialog ref="preview" aria-labelledby="preview-title" @click="($event.target === preview) && preview?.close()"><div class="preview-heading"><h2 id="preview-title">{{ selected?.name }}</h2><button type="button" autofocus @click="preview?.close()">关闭预览</button></div><template v-if="selected"><p v-if="previewFailed" role="status">图片暂不可用 <button type="button" @click="previewFailed = false">重试图片</button></p><img v-else class="preview-img" :src="assetUrl(selected.url)" :alt="selected.name" @error="previewFailed = true"></template></dialog>
  </div>
</template>

<script setup lang="ts">
interface GalleryCategory { id: string; name: string }
interface GalleryImage { id: string; name: string; categoryId: string; categoryName: string; resolution: string; ratio: string; time?: string; createdAt?: string; url: string; size: number }
type Sort = 'timeDesc' | 'timeAsc' | 'nameAsc' | 'nameDesc'
const api = usePublicApi()
const assetUrl = useAssetUrl()
const sort = ref<Sort>('timeDesc')
const category = ref('all')
const keyword = ref('')
const resolution = ref('all')
const ratio = ref('all')
const expanded = ref(false)
const { data, error, status, refresh } = await useAsyncData(() => `public-gallery-${sort.value}`, async () => {
  const [categories, images] = await Promise.all([
    api<{ success: boolean; data: GalleryCategory[] }>('gallery/categories'),
    api<{ success: boolean; data: { items?: GalleryImage[]; records?: GalleryImage[] } }>('gallery/images', { query: { pageNumber: 1, pageSize: 200, sortOrder: sort.value } })
  ])
  if (!categories.success || !Array.isArray(categories.data) || !images.success || !images.data || !Array.isArray(images.data.items ?? images.data.records)) throw new Error('图库加载失败')
  return { categories: categories.data, images: images.data.items ?? images.data.records ?? [] }
})
const images = computed(() => data.value?.images || [])
const resolutions = computed(() => [...new Set(images.value.map(item => item.resolution).filter(Boolean))])
const ratios = computed(() => [...new Set(images.value.map(item => item.ratio).filter(Boolean))])
const count = (id: string) => images.value.filter(item => item.categoryId === id).length
const categoryName = computed(() => category.value === 'all' ? '全部图片' : data.value?.categories.find(item => item.id === category.value)?.name || '图片')
function timestamp(item: GalleryImage) { const value = Date.parse(item.time || item.createdAt || ''); return Number.isFinite(value) ? value : 0 }
const filtered = computed(() => images.value.filter(item => (category.value === 'all' || item.categoryId === category.value) && (resolution.value === 'all' || item.resolution === resolution.value) && (ratio.value === 'all' || item.ratio === ratio.value) && (!keyword.value.trim() || item.name.toLowerCase().includes(keyword.value.trim().toLowerCase()))).sort((a, b) => {
  if (sort.value === 'nameAsc') return a.name.localeCompare(b.name)
  if (sort.value === 'nameDesc') return b.name.localeCompare(a.name)
  return sort.value === 'timeAsc' ? timestamp(a) - timestamp(b) : timestamp(b) - timestamp(a)
}))
function formatRatio(value: string) {
  const [width, height] = value.split(':').map(Number)
  if (!width || !height) return value
  let bestWidth = 1, bestHeight = 1, difference = Infinity
  for (let w = 1; w <= 9; w++) for (let h = 1; h <= 9; h++) {
    const next = Math.abs(width / height - w / h)
    if (next < difference) { bestWidth = w; bestHeight = h; difference = next }
  }
  if (difference / (width / height) <= .03) return `${bestWidth}:${bestHeight}`
  difference = Infinity
  for (let w = 1; w <= 99; w++) for (let h = 1; h <= 99; h++) if (w <= 9 || h <= 9) {
    const next = Math.abs(width / height - w / h)
    if (next < difference) { bestWidth = w; bestHeight = h; difference = next }
  }
  return `${bestWidth}:${bestHeight}`
}
const preview = ref<HTMLDialogElement>()
const selected = ref<GalleryImage>()
const failed = ref<Record<string, boolean>>({})
const previewFailed = ref(false)
function openPreview(image: GalleryImage) { selected.value = image; previewFailed.value = false; preview.value?.showModal() }
function reset() { category.value = resolution.value = ratio.value = 'all'; keyword.value = '' }
watch(sort, () => { failed.value = {} })
onBeforeUnmount(() => preview.value?.close())
useSeoMeta({ title: '图库', description: '浏览图库图片，按名称、分类、分辨率与比例筛选。' })
</script>

<style scoped>
.gallery-page{max-width:1536px;margin:auto;color:var(--text)}.filter-panel,.image-panel{border:1px solid #3ecf9a6b;border-radius:28px;background:var(--surface);box-shadow:0 8px 28px #0f172a12}.filter-panel{position:sticky;top:57px;z-index:10;margin-top:22px;padding:18px;backdrop-filter:blur(14px)}.filter-toggle{display:none}.filter-row{display:flex;flex-wrap:wrap;gap:12px}.filter-row label{min-width:0}.filter-row input,.filter-row select{height:38px;max-width:100%;border:1px solid #3ecf9a4d;border-radius:99px;padding:6px 13px;background:var(--surface);color:var(--text);font:inherit}.filter-row input{width:240px}.filter-row select{min-width:140px}.copyright-notice{margin:12px 0 0;color:var(--muted);font-size:12px;line-height:1.6;overflow-wrap:anywhere}.image-panel{margin-top:22px;padding:22px}.image-panel h1{font-size:24px;font-weight:950;margin:0}.image-panel header p{margin:5px 0;color:var(--muted)}.image-panel header small{display:block;color:var(--muted);margin-bottom:20px}.image-grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:18px}.image-card{overflow:hidden;border:1px solid var(--border);border-radius:24px;background:var(--surface)}.image-cover{display:grid;place-items:center;width:100%;aspect-ratio:16/10;overflow:hidden;border:0;border-radius:0;padding:0;background:#3ecf9a14;color:var(--muted)}.image-cover img{display:block;width:100%;height:100%;object-fit:cover}.image-info{padding:7.5px 15px}.image-info h2{font-size:16px;margin:0;overflow-wrap:anywhere}.meta-row{display:flex;flex-wrap:wrap;align-items:center;gap:7px}.meta-row span{border-radius:99px;padding:5px 9px;background:#3ecf9a1a;color:#15956b;font-size:12px}.meta-row a{margin-left:auto;padding:5px 9px;border:1px solid #3ecf9a4d;border-radius:99px;color:var(--text);font-size:12px}.image-info p{margin:0;color:var(--muted);font-size:12px}.empty-state{padding:80px 0;text-align:center;color:var(--muted)}dialog{width:min(92vw,980px);max-height:90vh;padding:20px;border:1px solid var(--border);border-radius:20px;color:var(--text);background:var(--surface)}dialog::backdrop{background:#0009}.preview-heading{display:flex;gap:16px;align-items:center;justify-content:space-between;margin-bottom:16px}.preview-heading h2{font-size:18px;margin:0;overflow-wrap:anywhere}.preview-heading button{flex-shrink:0}.preview-img{display:block;width:100%;max-height:70vh;object-fit:contain;border-radius:16px}:global([data-theme="dark"]) .filter-panel,:global([data-theme="dark"]) .image-panel{border-color:#334155e6}:global([data-theme="dark"]) .image-card{background:#1e293bb8}:global([data-theme="dark"]) .meta-row span{background:#3ecf9a24;color:#6ee7b7}@media(max-width:900px){.image-grid{grid-template-columns:repeat(2,minmax(0,1fr))}}@media(max-width:640px){.filter-panel{top:53px;margin-top:8px;padding:8px 10px;border-radius:16px}.filter-toggle{display:block;width:100%;border:0;background:transparent;color:var(--primary);text-align:left;font-weight:900}.filter-panel.collapsed .filter-row{display:none}.filter-row{gap:8px;margin-top:8px}.filter-row label,.filter-row input,.filter-row select{width:100%;font-size:16px}.copyright-notice{font-size:11px;margin-top:6px}.image-panel{margin-top:12px;padding:12px;border-radius:18px}.image-grid{grid-template-columns:minmax(0,1fr)}.image-info{padding:6px 15px}.meta-row{gap:5px}.meta-row span{padding:5px 7px;font-size:11px}.meta-row a{padding:3px 6px;font-size:11px}.preview-heading{align-items:flex-start}}
</style>
