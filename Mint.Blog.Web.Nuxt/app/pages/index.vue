<template>
  <div class="home-page">
    <SiteBanner>
      <h1 class="sr-only">{{ settings?.name || 'Mint Blog' }}</h1>
      <p aria-hidden="true" class="typed-line">{{ typed }}<span class="typing-caret">|</span></p>
      <p class="sr-only">新鲜阅读，温柔写作 · 技术·生活·思考</p>
    </SiteBanner>
    <div class="home-content">
    <section :aria-busy="status === 'pending'" aria-labelledby="articles-heading">
      <h2 id="articles-heading" class="sr-only">{{ text('最新文章', 'Latest articles') }}</h2>
      <p v-if="status === 'pending'" role="status">{{ text('正在加载文章…', 'Loading articles…') }}</p>
      <div v-else-if="error" class="preview-panel" role="alert">
        <p>{{ text('文章加载失败，请重试。', 'Could not load articles. Please retry.') }}</p>
        <button @click="refresh()">{{ text('重试', 'Retry') }}</button>
      </div>
      <div v-else-if="!data?.data.length" class="preview-panel">
        <h2>{{ current > 1 ? text('这一页暂无文章', 'No articles on this page') : text('还没有发布文章', 'No published articles yet') }}</h2>
        <NuxtLink v-if="current > 1" :to="pageUrl(1)">{{ text('返回第一页', 'Back to first page') }}</NuxtLink>
      </div>
      <div v-else class="article-list">
        <article v-for="article in data.data" :key="article.id" class="article-card" :data-article-id="article.id">
          <NuxtLink :to="`/articles/${encodeURIComponent(article.id)}`" class="article-cover" :aria-label="article.title">
            <img :src="assetUrl(article.cover) || defaultCover(article.id)" alt="" loading="lazy" width="460" height="260" @error="coverError($event, article.id)">
          </NuxtLink>
          <div class="article-body">
            <span v-if="article.isTop" class="top-badge">{{ text('置顶', 'Pinned') }}</span>
            <h2><NuxtLink :to="`/articles/${encodeURIComponent(article.id)}`">{{ article.title }}</NuxtLink></h2>
            <p class="article-summary">{{ article.summary?.trim() || text('点击查看详细内容…', 'Read the full article…') }}</p>
            <div class="article-meta">
              <span><SiteIcon name="eye" />{{ article.readNum }}</span>
              <time :datetime="article.createDate"><SiteIcon name="date" />{{ article.createDate?.slice(0, 10) }}</time>
            </div>
            <div class="article-tags">
              <NuxtLink class="article-chip" :to="{ path: '/categories', query: { id: article.categoryId, name: article.categoryName } }"><span class="article-chip-label">{{ text('分类', 'Category') }}</span>{{ article.categoryName }}</NuxtLink>
              <NuxtLink class="article-chip" :to="{ path: '/tags', query: { id: article.tagId, name: article.tagName } }"><span class="article-chip-label">{{ text('技术标签', 'Tag') }}</span>{{ article.tagName }}</NuxtLink>
              <span v-if="article.tagVersionName" class="article-chip"><span class="article-chip-label">{{ text('版本', 'Version') }}</span>{{ article.tagVersionName }}</span>
            </div>
          </div>
        </article>
      </div>
      <nav v-if="!error && data && data.pages > 0" class="article-pagination" :aria-label="text('文章分页', 'Article pagination')">
        <NuxtLink v-if="current > 1" :to="pageUrl(current - 1)" rel="prev">{{ text('上一页', 'Previous') }}</NuxtLink>
        <NuxtLink v-for="page in pageLinks" :key="page" :to="pageUrl(page)" :aria-current="page === current ? 'page' : undefined">{{ page }}</NuxtLink>
        <NuxtLink v-if="current < data.pages" :to="pageUrl(current + 1)" rel="next">{{ text('下一页', 'Next') }}</NuxtLink>
        <span>{{ text('共', 'Total') }} {{ data.total }} {{ text('篇', 'articles') }}</span>
      </nav>
    </section>
    <SiteOverviewCards :settings="settings" />
    </div>
  </div>
</template>

<script setup lang="ts">
import type { PublicArticlePage } from '~/composables/usePublicContent'
import defaultArticleCover1 from '~/assets/images/article-default-1.jpeg'
import defaultArticleCover2 from '~/assets/images/article-default-2.jpg'

const route = useRoute()
const api = usePublicApi()
const { text } = useSitePreferences()
const { data: settings } = await useSiteSettings()
const assetUrl = useAssetUrl()
const current = computed(() => {
  const raw = route.query.page
  if (typeof raw !== 'string' || !/^[1-9]\d*$/.test(raw)) return 1
  const page = Number(raw)
  return Number.isSafeInteger(page) && page <= 2147483647 ? page : 1
})
const { data, status, error, refresh } = await useAsyncData(
  () => `public-articles-${current.value}`,
  async () => {
    const result = await api<PublicArticlePage>('article/list', { method: 'POST', body: { current: current.value, size: 10 } })
    if (!result.success || !Array.isArray(result.data)) throw new Error('Public articles unavailable')
    return result
  }
)
const pageLinks = computed(() => {
  const count = data.value?.pages ?? 0
  const start = Math.max(1, Math.min(current.value - 2, count - 4))
  return Array.from({ length: Math.min(5, count) }, (_, i) => start + i)
})
const mounted = ref(false)
const pageUrl = (page: number) => ({ path: '/', query: { ...route.query, page: page > 1 ? String(page) : undefined }, hash: mounted.value ? route.hash : '' })
const defaultCover = (id: string) => /[13579]$/.test(id) ? defaultArticleCover2 : defaultArticleCover1
const coverError = (event: Event, id: string) => { const image = event.target as HTMLImageElement; if (image.src !== new URL(defaultCover(id), document.baseURI).href) image.src = defaultCover(id) }
const phrases = ['Mint Blog', '新鲜阅读，温柔写作', '技术·生活·思考']
const typed = ref(phrases[0])
let timer: ReturnType<typeof setInterval> | undefined
onMounted(() => {
  mounted.value = true
  document.querySelectorAll<HTMLImageElement>('.article-cover img').forEach(image => {
    const fallback = defaultCover(image.closest<HTMLElement>('[data-article-id]')!.dataset.articleId!)
    if (image.complete && !image.naturalWidth && image.src !== new URL(fallback, document.baseURI).href) image.src = fallback
  })
  if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return
  let phrase = 0
  let length = phrases[0]!.length
  let deleting = true
  let pause = 15
  timer = setInterval(() => {
    if (pause-- > 0) return
    const value = phrases[phrase]!
    length += deleting ? -1 : 1
    typed.value = value.slice(0, length)
    if (length === 0) { phrase = (phrase + 1) % phrases.length; deleting = false }
    else if (length === value.length) { deleting = true; pause = 15 }
  }, 110)
})
onBeforeUnmount(() => { if (timer) clearInterval(timer) })
useSeoMeta({
  title: () => `${text('首页', 'Home')}${current.value > 1 ? ` · ${current.value}` : ''}`,
  description: () => settings.value?.introduction || text('新鲜阅读，温柔写作。技术、生活与思考。', 'Fresh reading, gentle writing. Technology, life and thoughts.')
})
</script>

<style scoped>
.home-content { position: relative; z-index: 12; max-width: 1280px; margin: 0 auto; padding: 16px 24px 80px; display: grid; grid-template-columns: minmax(0,17fr) minmax(0,7fr); gap: 28px; align-items: start; }
.home-content > section { min-width: 0; }
.home-content .article-list { gap: 16px; }
.home-content .article-card { height: 220px; position: relative; transition: transform .3s; }
.home-content .article-card:hover { transform: scale(1.015); }
.home-content .article-cover { flex-basis: 42%; clip-path: polygon(0 0,90% 0,100% 100%,0 100%); }
.home-content .article-card:nth-child(even) .article-cover { clip-path: polygon(10% 0,100% 0,100% 100%,0 100%); }
.home-content .article-cover img { min-height: 0; height: 100%; }
.home-content .article-body { padding: 20px; display: flex; flex-direction: column; justify-content: center; }
.home-content .article-body h2 { font-size: 24px; font-weight: 800; line-height: 1.4; overflow-wrap: anywhere; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.home-content .article-body h2 a { color: var(--text); }
.home-content .article-body h2 a:hover { color: var(--primary); }
.home-content .article-summary { font-size: 14px; font-weight: 600; color: var(--text); text-indent: 32px; margin: 6px 0 12px; }
.home-content .article-meta { gap: 8px; font-size: 12px; }
.home-content .article-meta > * { display: flex; align-items: center; gap: 4px; }
.home-content .article-meta :deep(svg) { width: 23px; height: 23px; padding: 4px; border-radius: 50%; background: #4fa7591a; color: #4fa759; }
.home-content .article-meta span :deep(svg) { background: #f59e0b1a; color: #f59e0b; }
.home-content .article-meta time :deep(svg) { background: #ea3b241a; color: #ea3b24; }
.home-content .article-tags { gap: 6px; margin-top: 10px; font-size: 12px; }
.home-content .article-tags .article-chip { display: inline-flex; align-items: center; gap: 8px; max-width: 100%; padding: 4px 12px; border-radius: 99px; font-size: inherit; font-weight: 600; font-variant-numeric: tabular-nums; line-height: 1.5; color: var(--article-accent); background: color-mix(in srgb, var(--article-accent) 12%, transparent); box-shadow: inset 0 0 0 1px color-mix(in srgb, var(--article-accent) 25%, transparent); }
.home-content .article-chip-label { flex-shrink: 0; padding-right: 8px; border-right: 1px solid color-mix(in srgb, var(--article-accent) 30%, transparent); font-size: .9em; font-weight: 400; opacity: .8; }
.home-content .article-tags a.article-chip:hover { background: color-mix(in srgb, var(--article-accent) 20%, transparent); }
.home-content .top-badge { position: absolute; top: 12px; right: 12px; z-index: 1; background: linear-gradient(135deg,#fb7185,#ef4444); }
.home-page { --article-accent: #2faa7d; }
:global([data-theme="dark"] .home-page) { --article-accent: #8fc3ff; }
:global([data-theme="dark"] .home-content .article-card) { border-color: #475569; background: var(--surface); box-shadow: 0 4px 24px #539dfd14; }
.home-content .article-meta a { color: var(--article-accent); }
.home-content .article-tags a { color: var(--article-accent); background: color-mix(in srgb, var(--article-accent) 12%, transparent); }
@media (max-width: 1279px) { .home-content .article-card { height: 180px; } .home-content .article-body h2 { font-size: 20px; } }
@media (max-width: 1023px) { .home-content { grid-template-columns: 1fr; } .home-content .article-card { height: 200px; } }
@media (max-width: 639px) {
  .home-content { padding: 16px 16px 40px; }
  .home-content .article-card,.home-content .article-card:nth-child(even) { flex-direction: row; height: auto; min-height: 154px; border-radius: 28px; overflow: visible; background: radial-gradient(at top left,#3ecf9a14,transparent 70%),var(--surface); box-shadow: 0 6px 24px #3ecf9a14; }
  .home-content .article-cover,.home-content .article-card:nth-child(even) .article-cover { flex: 0 0 112px; height: 118px; margin: 16px 0 16px 16px; border-radius: 18px; clip-path: none; }
  .home-content .article-body { padding: 14px 12px; }
  .home-content .article-body h2 { font-size: 18px; }
  .home-content .article-summary { -webkit-line-clamp: 1; text-indent: 0; font-size: 13px; margin: 4px 0; }
  .home-content .article-meta { font-size: 10px; gap: 4px; }
  .home-content .article-meta > a { display: none; }
  .home-content .article-meta :deep(svg) { width: 18px; height: 18px; padding: 3px; }
  .home-content .article-tags { margin-top: 6px; }
  .home-content .article-tags .article-chip { padding: 2px 8px; font-size: 11px; }
  .home-content .top-badge { top: -10px; }
  .home-content .article-card:hover { transform: none; }
}
@media (max-width: 374px) { .home-content .article-cover,.home-content .article-card:nth-child(even) .article-cover { flex-basis: 98px; height: 108px; margin-left: 10px; } }

.typed-line { min-height: 30px; font-size: 20px; }
.typing-caret { margin-left: 4px; }
.article-list { display: grid; gap: 22px; }
.article-card { display: flex; overflow: hidden; min-width: 0; border: 1px solid #3ecf9a66; border-radius: 24px; background: var(--surface); box-shadow: 0 4px 24px #0000000f; }
.article-card:nth-child(even) { flex-direction: row-reverse; }
.article-cover { flex: 0 0 38%; overflow: hidden; }
.article-cover img { display: block; width: 100%; height: 100%; min-height: 230px; object-fit: cover; transition: transform .4s; }
.article-cover:hover img { transform: scale(1.04); }
.article-body { flex: 1; min-width: 0; padding: 24px 30px; overflow-wrap: anywhere; }
.article-body h2 { margin: 0 0 0px; }
.article-body h2 a { color: var(--text); }
.article-summary { color: var(--muted); display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
.article-meta, .article-tags { display: flex; flex-wrap: wrap; gap: 8px 16px; font-size: 13px; color: var(--muted); }
.article-tags { margin-top: 14px; }
.article-tags a { border-radius: 16px; background: #3ecf9a14; padding: 2px 10px; }
.top-badge { float: right; border-radius: 12px; background: #ef4444; color: white; font-size: 12px; padding: 2px 10px; }
.article-pagination { display: flex; flex-wrap: wrap; align-items: center; justify-content: center; gap: 12px; margin: 28px 0; }
.article-pagination a { padding: 4px 10px; border: 1px solid var(--border); border-radius: 8px; }
.article-pagination [aria-current] { background: var(--primary); color: white; }
@media (prefers-reduced-motion: reduce) { .article-cover img { transition: none; } }
</style>
