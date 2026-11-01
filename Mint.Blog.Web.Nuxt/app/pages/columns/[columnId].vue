<template>
  <div class="column-detail-page">
    <p v-if="status === 'pending'" class="panel" role="status">正在加载专栏介绍与目录…</p>
    <section v-else-if="error" class="panel" role="alert"><h1>{{ error.statusCode === 404 ? '404 · 专栏不存在' : '专栏暂时无法加载' }}</h1><p>请稍后重试。</p><button type="button" @click="refresh()">重新加载专栏</button><NuxtLink to="/columns">返回专栏列表</NuxtLink></section>
    <template v-else-if="data">
      <button type="button" class="catalog-toggle" :aria-expanded="catalogOpen" aria-controls="column-catalog" aria-label="展开专栏目录" @click="catalogOpen = true"><span aria-hidden="true">▶</span></button>
      <div class="column-reading-layout" :class="{ 'catalog-collapsed': catalogCollapsed }">
      <component :is="catalogMobile ? 'dialog' : 'aside'" id="column-catalog" ref="catalogElement" class="column-catalog panel" aria-label="专栏文章目录" @close="syncCatalog" @cancel.prevent="closeCatalog" @click="catalogBackdropClick">
        <div class="catalog-mobile-header"><h2>专栏目录</h2><button autofocus type="button" class="catalog-mobile-close" aria-label="收起专栏目录" @click="closeCatalog"><span aria-hidden="true">◀</span></button></div>
        <button type="button" class="catalog-desktop-toggle" :aria-expanded="!catalogCollapsed" aria-controls="column-catalog-tree" :aria-label="catalogCollapsed ? '展开专栏目录' : '收起专栏目录'" @click="catalogCollapsed = !catalogCollapsed"><span v-if="!catalogCollapsed">专栏目录</span><span aria-hidden="true">{{ catalogCollapsed ? '»' : '«' }}</span></button>
        <div id="column-catalog-tree" class="column-catalog-tree">
        <header class="column-introduction">
          <img v-if="assetUrl(data.column.cover) && !coverFailed" ref="cover" :src="assetUrl(data.column.cover)" :alt="`${data.column.title}封面`" class="column-cover" @error="coverFailed = true">
          <div><h1>{{ data.column.title }}</h1><p class="column-summary">{{ data.column.summary || '暂无专栏介绍。' }}</p><p class="muted">{{ data.column.articlesTotal }} 篇文章 · {{ data.catalogs.length }} 个分组</p></div>
        </header>
        <p v-if="!data.catalogs.length" class="muted">专栏暂无分组与文章，敬请期待。</p>
        <section v-for="group in data.catalogs" :key="group.id" class="column-catalog-group">
          <h3>{{ group.title }}</h3>
          <ol v-if="group.children?.length">
            <li v-for="item in group.children" :key="item.id">
              <NuxtLink v-if="columnReadingId(item.articleId)" :to="selectedArticleLocation(columnReadingId(item.articleId)!)" @click.capture="selectArticle($event, columnReadingId(item.articleId)!)" :aria-current="selectedId === columnReadingId(item.articleId) ? 'page' : undefined" style="padding-left: 8px;">{{ item.title }}</NuxtLink>
              <span v-else class="muted">{{ item.title }}（暂不可阅读）</span>
            </li>
          </ol>
          <p v-else class="muted">本分组暂无文章。</p>
        </section>
        </div>
      </component>
      <section v-if="invalidSelection" class="panel" role="alert"><h2>404 · 文章不在此专栏中</h2><p>请选择专栏目录中的文章。</p></section>
      <Suspense v-else-if="selectedId" :key="`${id}-${selectedId}`">
        <ColumnArticleReader :key="`${id}-${selectedId}`" :column-id="id" :article-id="selectedId" :article-ids="articleIds" :column-title="data.column.title" @ready="readerReady" @select="selectArticle" />
        <template #fallback><p class="panel" role="status">正在加载文章…</p></template>
      </Suspense>
      <p v-else class="panel muted">专栏暂无可阅读文章，敬请期待。</p>
      </div>
      <div class="column-comments"><PublicComments :key="id" :path="`/blog/surfer/column/${id}`" source="column" /></div>
    </template>
  </div>
</template>

<script setup lang="ts">
import { columnReadingId } from '~/utils/columnReading'
definePageMeta({ key: route => route.params.columnId as string })
interface ColumnIntroduction { id: string; cover: string; title: string; articlesTotal: number; summary: string }
interface CatalogItem { id: string; articleId: string; title: string; level: number; children: CatalogItem[] }
const route = useRoute()
const router = useRouter()
const id = columnReadingId(route.params.columnId)
if (!id) throw createError({ statusCode: 404, statusMessage: '专栏不存在' })
const api = usePublicApi()
const assetUrl = useAssetUrl()
const { data, error, status, refresh } = await useAsyncData(`column-reading-${id}`, async () => {
  const result = await api<{ success: boolean; data?: ColumnIntroduction[] }>('column')
  if (!result.success || !result.data) throw createError({ statusCode: 502, statusMessage: '专栏介绍暂时无法加载' })
  const column = result.data.find(item => columnReadingId(item.id) === id)
  if (!column) throw createError({ statusCode: 404, statusMessage: '专栏不存在或未发布' })
  const catalog = await api<{ success: boolean; data?: CatalogItem[] }>(`column/${id}/catalog`)
  if (!catalog.success || !catalog.data) throw createError({ statusCode: 502, statusMessage: '专栏目录暂时无法加载' })
  return { column, catalogs: catalog.data }
})
if (error.value?.statusCode === 404) throw createError({ statusCode: 404, statusMessage: '专栏不存在或未发布', fatal: true })
const articleIds = computed(() => data.value?.catalogs.flatMap(group => (group.children || []).map(item => columnReadingId(item.articleId)).filter((value): value is string => !!value)) || [])
const memberIds = computed(() => new Set(articleIds.value))
const selectedId = computed(() => {
  if (route.query.articleId === undefined) return articleIds.value[0]
  const requested = columnReadingId(route.query.articleId)
  return requested && memberIds.value.has(requested) ? requested : undefined
})
const invalidSelection = computed(() => route.query.articleId !== undefined && !selectedId.value)
if (import.meta.server && invalidSelection.value && data.value) {
  const event = useRequestEvent()
  if (event) setResponseStatus(event, 404)
}
const hash = ref('')
watch(() => route.hash, value => { hash.value = value })
const articleLocation = (articleId: string) => ({ path: route.path, query: { ...route.query, articleId }, hash: hash.value })
const selectedArticleLocation = (articleId: string) => ({ ...articleLocation(articleId), hash: '' })
let pendingReadingStart: string | undefined
let readyArticle: { id: string; title: HTMLElement } | undefined
function scrollToReadingStart() {
  if (!pendingReadingStart || pendingReadingStart !== selectedId.value || readyArticle?.id !== pendingReadingStart || !readyArticle.title.isConnected) return
  pendingReadingStart = undefined
  const title = readyArticle.title
  const toc = title.closest('.column-reader')?.querySelector('.column-article-toc')
  if (toc) toc.scrollTop = 0
  requestAnimationFrame(() => {
    if (readyArticle?.title === title && selectedId.value === readyArticle.id && title.isConnected) window.scrollTo({ top: window.scrollY + title.getBoundingClientRect().top - 85, behavior: 'instant' })
  })
}
function readerReady(articleId: string, title: HTMLElement) {
  readyArticle = { id: articleId, title }
  scrollToReadingStart()
}
async function selectArticle(event: MouseEvent, articleId: string) {
  if (event.button !== 0 || event.metaKey || event.ctrlKey || event.shiftKey || event.altKey || (event.currentTarget instanceof HTMLAnchorElement && event.currentTarget.target === '_blank')) return
  event.preventDefault()
  closeCatalog()
  pendingReadingStart = articleId
  try {
    const failure = await router.push(selectedArticleLocation(articleId))
    if (failure && selectedId.value !== articleId) pendingReadingStart = undefined
    await nextTick()
    scrollToReadingStart()
  } catch {
    pendingReadingStart = undefined
  }
}
watch(() => route.fullPath, () => {
  if (pendingReadingStart !== selectedId.value) pendingReadingStart = undefined
})
let mounted = false
function completeDefaultQuery() {
  if (mounted && route.query.articleId === undefined && selectedId.value) void router.replace(articleLocation(selectedId.value))
}
onMounted(() => { hash.value = route.hash; mounted = true; completeDefaultQuery() })
watch([() => route.query.articleId, selectedId], completeDefaultQuery)
const catalogOpen = ref(false)
const catalogCollapsed = ref(false)
const catalogMobile = ref(false)
const catalogElement = ref<HTMLElement>()
function closeCatalog() {
  if (catalogElement.value instanceof HTMLDialogElement) catalogElement.value.close()
  catalogOpen.value = false
}
function syncCatalog() {
  if (catalogElement.value instanceof HTMLDialogElement && !catalogElement.value.open) catalogOpen.value = false
}
function catalogBackdropClick(event: MouseEvent) {
  const dialog = catalogElement.value
  if (!(dialog instanceof HTMLDialogElement) || event.target !== dialog) return
  const bounds = dialog.getBoundingClientRect()
  if (event.clientX < bounds.left || event.clientX > bounds.right || event.clientY < bounds.top || event.clientY > bounds.bottom) closeCatalog()
}
function resizeCatalog() {
  const mobile = window.innerWidth < 1100
  if (mobile !== catalogMobile.value) closeCatalog()
  catalogMobile.value = mobile
}
watch([catalogOpen, catalogElement], () => {
  const dialog = catalogElement.value
  if (!(dialog instanceof HTMLDialogElement)) return
  if (catalogOpen.value && !dialog.open) dialog.showModal()
  else if (!catalogOpen.value && dialog.open) dialog.close()
}, { flush: 'post' })
watch(selectedId, closeCatalog)
onMounted(() => {
  resizeCatalog()
  window.addEventListener('resize', resizeCatalog)
})
onBeforeUnmount(() => {
  closeCatalog()
  window.removeEventListener('resize', resizeCatalog)
})
const coverFailed = ref(false)
const cover = ref<HTMLImageElement>()
function checkCover() { if (cover.value?.complete && !cover.value.naturalWidth) coverFailed.value = true }
onMounted(checkCover)
watch(() => data.value?.column.cover, () => { coverFailed.value = false; void nextTick(checkCover) })
const url = useRequestURL()
const columnUrl = new URL(`/columns/${id}`, useRuntimeConfig().public.siteUrl || url.origin).href
useSeoMeta({
  title: () => data.value?.column.title || '专栏',
  description: () => data.value?.column.summary || '专栏介绍与文章目录',
  ogTitle: () => data.value?.column.title, ogDescription: () => data.value?.column.summary,
  ogImage: () => assetUrl(data.value?.column.cover),
  robots: () => error.value || invalidSelection.value ? 'noindex, nofollow' : 'index, follow'
})
useHead({ link: [{ rel: 'canonical', href: columnUrl }] })
</script>

<style scoped>
.column-detail-page{max-width:1536px;margin:0 auto;min-width:0}.column-detail-page>.panel,.column-catalog{margin-bottom:24px}.column-introduction{display:grid;grid-template-columns:minmax(0,1fr);gap:12px;min-width:0;padding-bottom:12px}.column-cover{display:block;width:100%;height:auto;max-height:140px;object-fit:cover;border-radius:8px}.column-introduction h1{font-size:20px;line-height:1.4;margin:0 0 10px;overflow-wrap:anywhere}.column-introduction p{margin:10px 0;font-size:13px}.column-summary{white-space:pre-wrap;overflow-wrap:anywhere;line-height:1.7}.column-catalog-group{border-top:1px solid var(--border);padding:12px 0}.column-catalog-group h3{margin:8px 0}.column-catalog ol{padding-left:24px}.column-catalog li{padding:6px 0;overflow-wrap:anywhere}.column-catalog a[aria-current]{color:var(--primary);font-weight:700;text-decoration:underline}.column-detail-page button{margin-right:16px}
.column-reading-layout{display:grid;grid-template-columns:240px minmax(0,1fr);gap:24px;align-items:start}.column-catalog{position:sticky;top:65px;max-height:calc(100dvh - 90px);overflow-y:auto;overscroll-behavior:contain;min-width:0;padding:20px;scrollbar-width:thin}.column-catalog h2{font-size:16px;margin:0 0 12px}.column-catalog h3{font-size:14px}.column-catalog ol{padding-left:20px}.column-catalog a{display:block;border-radius:6px;padding:4px}.column-catalog a[aria-current]{background:color-mix(in srgb,var(--primary) 10%,transparent);text-decoration:none}.catalog-toggle,.catalog-mobile-header{display:none}.column-comments{max-width:1000px;margin:32px auto 0}
.catalog-desktop-toggle{display:flex;align-items:center;justify-content:space-between;gap:12px;width:100%;margin:0 0 12px!important;padding:6px 0;border:0;background:transparent;color:var(--text);font:inherit;font-weight:600;cursor:pointer}.catalog-desktop-toggle span[aria-hidden]{font-size:28px;line-height:1;flex-shrink:0}.catalog-desktop-toggle:focus-visible{outline:2px solid var(--primary);outline-offset:4px}@media(min-width:1100px){.column-reading-layout.catalog-collapsed{grid-template-columns:48px minmax(0,1fr)}.catalog-collapsed .column-catalog{padding:12px}.catalog-collapsed .column-catalog-tree{display:none}.catalog-collapsed .catalog-desktop-toggle{justify-content:center;margin:0!important}}
@media(max-width:1099px){.column-reading-layout{grid-template-columns:minmax(0,1fr);gap:16px}.column-catalog{display:none}.column-catalog[open]{display:flex;flex-direction:column;position:fixed;inset:0 auto 0 0;box-sizing:border-box;width:min(86vw,320px);height:100dvh;max-width:none;max-height:none;margin:0;padding:calc(16px + env(safe-area-inset-top)) 16px calc(16px + env(safe-area-inset-bottom)) calc(16px + env(safe-area-inset-left));border:0;border-right:1px solid var(--border);border-radius:0;background:var(--surface);color:var(--text);overflow:hidden;overscroll-behavior:contain;box-shadow:8px 0 24px #0002}.column-catalog::backdrop{background:#0005}.catalog-toggle,.catalog-mobile-close{display:flex;align-items:center;justify-content:center;width:32px;height:32px;margin:0!important;padding:0;border:1px solid var(--border);border-radius:50%;background:var(--surface);color:var(--text);box-shadow:0 2px 8px #0002;cursor:pointer}.catalog-toggle{position:fixed;top:69px;left:16px;z-index:100}.catalog-mobile-header{display:flex;flex-shrink:0;align-items:center;justify-content:space-between;gap:12px;margin-bottom:12px}.catalog-mobile-header h2{margin:0}.catalog-mobile-close{position:sticky;top:0;margin-left:auto!important}.catalog-desktop-toggle{display:none}.column-catalog-tree{display:block;min-height:0;flex:1;overflow-y:auto;overscroll-behavior:contain}}
@media(min-width:1100px){.column-detail-page{max-width:none}}
</style>
