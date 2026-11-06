<template>
  <div class="columns-page">
    <header class="columns-heading"><div><h1>专栏</h1><p class="muted">按主题整理，循序阅读。</p></div><p v-if="columns" class="muted">{{ columns.length }} 个专栏 · {{ totalArticles }} 篇文章</p></header>
    <p v-if="status === 'pending'" class="panel" role="status">正在加载专栏…</p>
    <p v-else-if="error" class="panel" role="alert">专栏暂时无法加载 <button type="button" @click="refresh()">重试</button></p>
    <template v-else>
      <div v-if="visible.length" ref="covers" class="column-grid">
        <NuxtLink v-for="column in visible" :key="column.id" :to="`/columns/${encodeURIComponent(column.id)}`" class="column-card">
          <div class="column-cover"><img v-if="assetUrl(column.cover) && !failed[column.id]" :src="assetUrl(column.cover)" :data-column="column.id" alt="" loading="lazy" @error="failed[column.id] = true"><div v-else class="cover-unavailable"><SiteIcon name="column" /></div><span v-if="column.isTop" class="top-badge">置顶</span><span class="card-action">查看专栏</span></div>
          <div class="column-info"><h2>{{ column.title }}</h2><p>{{ column.summary || '暂无简介' }}</p><small>{{ column.articlesTotal }} 篇文章</small></div>
        </NuxtLink>
      </div>
      <div v-else class="panel columns-empty"><h2>{{ columns?.length ? '本页暂无专栏' : '暂无专栏' }}</h2><NuxtLink v-if="page > 1" :to="pageLink(1)">返回第一页</NuxtLink></div>
      <nav v-if="pages > 1 || page > 1" class="columns-pagination" aria-label="专栏分页"><NuxtLink v-if="page > 1" :to="pageLink(page - 1)">上一页</NuxtLink><span aria-live="polite">第 {{ page }} / {{ pages }} 页</span><NuxtLink v-if="page < pages" :to="pageLink(page + 1)">下一页</NuxtLink></nav>
    </template>
  </div>
</template>

<script setup lang="ts">
interface Column { id: string; title: string; summary: string; cover: string; articlesTotal: number; isTop: boolean; weight: number; sort: number }
const api = usePublicApi()
const assetUrl = useAssetUrl()
const route = useRoute()
const { data: columns, error, status, refresh } = await useAsyncData('public-columns', async () => {
  const result = await api<{ success: boolean; data: Column[] }>('column')
  if (!result.success || !Array.isArray(result.data)) throw new Error('专栏加载失败')
  return [...result.data].sort((a, b) => Number((b.weight || 0) > 0) - Number((a.weight || 0) > 0) || (a.sort || 0) - (b.sort || 0) || (BigInt(a.id) < BigInt(b.id) ? -1 : BigInt(a.id) > BigInt(b.id) ? 1 : 0))
})
const size = 9
const page = computed(() => typeof route.query.page === 'string' && /^[1-9]\d*$/.test(route.query.page) && Number.isSafeInteger(Number(route.query.page)) ? Number(route.query.page) : 1)
const pages = computed(() => Math.max(1, Math.ceil((columns.value?.length || 0) / size)))
const visible = computed(() => columns.value?.slice((page.value - 1) * size, page.value * size) || [])
const totalArticles = computed(() => columns.value?.reduce((sum, column) => sum + column.articlesTotal, 0) || 0)
const hash = ref('')
onMounted(() => { hash.value = route.hash })
watch(() => route.hash, value => { hash.value = value })
const pageLink = (value: number) => ({ path: '/columns', query: { ...route.query, page: String(value) }, hash: hash.value })
const failed = ref<Record<string, boolean>>({})
const covers = ref<HTMLElement>()
function checkCovers() { covers.value?.querySelectorAll<HTMLImageElement>('img[data-column]').forEach(image => { if (image.complete && !image.naturalWidth) failed.value[image.dataset.column!] = true }) }
onMounted(checkCovers)
watch(visible, () => nextTick(checkCovers))
useSeoMeta({ title: '专栏', description: '浏览专栏介绍与系列文章，按目录连续阅读。' })
</script>

<style scoped>
.columns-page{max-width:1200px;margin:auto}.columns-heading{display:flex;justify-content:space-between;align-items:center;gap:16px;flex-wrap:wrap;margin-bottom:24px}.columns-heading h1{margin-bottom:8px}.columns-heading p{margin:0}.column-grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:18px}.column-card{display:block;overflow:hidden;border:1px solid #0f3d2d14;border-radius:24px;background:var(--surface);color:var(--text);transition:transform .2s,box-shadow .2s}.column-card:hover{transform:translateY(-4px);box-shadow:0 18px 36px #0f172a1a;text-decoration:none}.column-cover{position:relative;aspect-ratio:16/10;overflow:hidden;background:#3ecf9a14}.column-cover img{display:block;width:100%;height:100%;object-fit:cover;transition:transform .25s}.column-card:hover img{transform:scale(1.06)}.cover-unavailable{display:grid;place-items:center;width:100%;height:100%;color:#3ecf9a6b}.cover-unavailable .site-icon{width:46px;height:46px}.top-badge{position:absolute;top:12px;right:12px;border-radius:99px;background:linear-gradient(135deg,#ff6b6b,#ef4444);padding:5px 11px;color:white;font-size:12px;font-weight:900}.card-action{position:absolute;inset:0;display:grid;place-content:center;background:#0f172a7a;color:white;font-weight:800;opacity:0;transition:opacity .2s}.column-card:hover .card-action,.column-card:focus-visible .card-action{opacity:1}.column-info{padding:8px 15px 14px}.column-info h2{font-size:16px;font-weight:950;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;margin:0;color:#0d3d2d}.column-info p{display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden;min-height:44px;margin:0;color:#60786e;font-size:13px;font-weight:700;line-height:1.7}.column-info small{color:var(--muted)}.columns-pagination{display:flex;justify-content:center;align-items:center;gap:20px;margin:28px 0}.columns-pagination a{border:1px solid var(--border);border-radius:8px;padding:8px 14px}.columns-empty{min-height:300px;text-align:center;padding-top:90px}
[data-theme="dark"] .column-card {
  background: var(--surface);
  border-color: var(--border);
}
[data-theme="dark"] .column-card:hover,
[data-theme="dark"] .column-card:focus-visible {
  border-color: #7fb8ff;
  box-shadow: 0 12px 28px #0004;
}
[data-theme="dark"] .column-card:focus-visible,
[data-theme="dark"] .columns-pagination a:focus-visible {
  outline: 2px solid #7fb8ff;
  outline-offset: 3px;
}
[data-theme="dark"] .column-cover {
  background: color-mix(in srgb, #539dfd 10%, var(--bg));
}
[data-theme="dark"] .cover-unavailable {
  color: #7fb8ff;
}
[data-theme="dark"] .column-info h2 {
  color: #f1f5f9;
}
[data-theme="dark"] .column-info p {
  color: var(--text);
}
[data-theme="dark"] .top-badge {
  background: #9f304d;
  color: #fff1f2;
}
[data-theme="dark"] .card-action {
  background: #101827b3;
  color: #f1f5f9;
}
[data-theme="dark"] .columns-pagination a {
  background: var(--surface);
  color: #7fb8ff;
}
[data-theme="dark"] .columns-pagination a:hover,
[data-theme="dark"] .columns-pagination a:focus-visible {
  background: color-mix(in srgb, #539dfd 12%, var(--surface));
  border-color: #7fb8ff;
}
[data-theme="dark"] .columns-empty a {
  color: #7fb8ff;
}
@media(max-width:1200px){.column-grid{grid-template-columns:repeat(2,minmax(0,1fr))}}@media(max-width:640px){.column-grid{grid-template-columns:minmax(0,1fr)}}@media(prefers-reduced-motion:reduce){.column-card,.column-cover img,.card-action{transition:none}.column-card:hover,.column-card:hover img{transform:none}}
</style>
