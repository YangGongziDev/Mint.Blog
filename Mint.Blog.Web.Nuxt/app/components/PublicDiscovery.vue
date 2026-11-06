<template>
  <section class="discovery-page" :aria-busy="result.status.value === 'pending' || metadata.status.value === 'pending'">
    <header class="discovery-filter">
      <div class="discovery-filter-heading">
        <h1><SiteIcon :name="kind" />{{ title }} <small>({{ archive ? years.length : entries.length }})</small></h1>
        <NuxtLink v-if="!archive" class="discovery-back-resources" to="/resources"><span aria-hidden="true">←</span>{{ text('返回资源导航', 'Back to resources') }}</NuxtLink>
      </div>
      <button class="filter-toggle" :aria-expanded="expanded" @click="expanded = !expanded">{{ expanded ? text('收起筛选', 'Collapse filters') : text('展开筛选', 'Expand filters') }} <span aria-hidden="true">{{ expanded ? '⌃' : '⌄' }}</span></button>
      <nav class="discovery-pills" :class="{ expanded }" :aria-label="title">
        <template v-if="archive">
          <NuxtLink :to="selectUrl('')" :aria-current="!year && !invalid ? 'true' : undefined" @click="expanded = false">{{ text('全部', 'All') }}</NuxtLink>
          <NuxtLink v-for="item in years" :key="item.year" :to="selectUrl(String(item.year))" :aria-current="year === String(item.year) ? 'true' : undefined" @click="expanded = false">{{ item.year }} {{ text('年', '') }} <span>{{ item.articlesTotal }}</span></NuxtLink>
        </template>
        <NuxtLink v-for="item in entries" v-else :key="item.id" :to="selectUrl(item.id, item.name)" :aria-current="selectedId === item.id ? 'true' : undefined" @click="expanded = false">{{ kind === 'tag' ? '# ' : '' }}{{ item.name }} <span>{{ item.articlesTotal }}</span></NuxtLink>
      </nav>
    </header>
    <div class="discovery-results">
      <p v-if="invalid" role="alert">{{ text('筛选参数无效，请重新选择。', 'Invalid filter. Please select again.') }}</p>
      <div v-else-if="metadata.error.value || result.error.value" role="alert"><p>{{ text('加载失败，请重试。', 'Loading failed. Please retry.') }}</p><button @click="retry">{{ text('重试', 'Retry') }}</button></div>
      <p v-else-if="metadata.status.value === 'pending' || result.status.value === 'pending'" role="status">{{ text('正在加载文章…', 'Loading articles…') }}</p>
      <div v-else-if="!hasArticles" class="discovery-empty"><SiteIcon :name="kind" /><p>{{ text('此筛选下暂无文章', 'No articles for this filter') }}</p><NuxtLink v-if="current > 1" :to="pageUrl(1)">{{ text('返回第一页', 'Back to first page') }}</NuxtLink></div>
      <div v-else :class="{ 'discovery-timeline': archive }">
        <section v-for="group in groups" :key="group.month" class="discovery-group">
          <h2 v-if="archive">{{ group.month }}</h2>
          <ol>
            <li v-for="article in group.articles" :key="article.id" :data-article-id="article.id">
              <NuxtLink class="discovery-article" :to="`/articles/${encodeURIComponent(article.id)}`">
                <img v-if="article.cover" :src="assetUrl(article.cover)" alt="" loading="lazy" width="96" height="48">
                <span v-else class="discovery-placeholder" aria-hidden="true">M</span>
                <div><h3>{{ article.title }}</h3><p class="discovery-selection">{{ article.categoryName }} · # {{ article.tagName }} · {{ article.tagVersionName }}</p><time :datetime="article.createDate"><SiteIcon name="date" />{{ article.createDate?.slice(0, 10) }}</time></div>
              </NuxtLink>
            </li>
          </ol>
        </section>
      </div>
    </div>
    <nav v-if="!invalid && !metadata.error.value && !result.error.value && pageCount > 1" class="discovery-pagination" :aria-label="text('文章分页', 'Article pagination')">
      <NuxtLink v-if="current > 1" :to="pageUrl(current - 1)" rel="prev">{{ text('上一页', 'Previous') }}</NuxtLink>
      <NuxtLink v-for="page in pages" :key="page" :to="pageUrl(page)" :aria-current="page === current ? 'page' : undefined">{{ page }}</NuxtLink>
      <NuxtLink v-if="current < pageCount" :to="pageUrl(current + 1)" rel="next">{{ text('下一页', 'Next') }}</NuxtLink>
    </nav>
    <p v-if="result.data.value && !invalid && !result.error.value && !metadata.error.value" class="discovery-total">{{ text('共', 'Total') }} {{ result.data.value.total }} {{ text('篇文章', 'articles') }}<span v-if="archive && year"> · {{ text('所选年份全部文章', 'All articles in selected year') }}</span></p>
  </section>
</template>

<script setup lang="ts">
import type { PublicArticlePage } from '~/composables/usePublicContent'
const props = defineProps<{ kind: 'category' | 'tag' | 'archive' }>()
type Entry = { id: string; name: string; articlesTotal: number; sort?: string | number | null }
type Year = { year: number; articlesTotal: number }
type Month = { month: string; articles: PublicArticlePage['data'] }
type ArchivePage = Omit<PublicArticlePage, 'data'> & { data: Month[] }
const route = useRoute()
const api = usePublicApi()
const assetUrl = useAssetUrl()
const { text } = useSitePreferences()
const archive = props.kind === 'archive'
const path = archive ? '/archives' : props.kind === 'category' ? '/categories' : '/tags'
const title = computed(() => archive ? text('归档', 'Archives') : props.kind === 'category' ? text('分类', 'Categories') : text('标签', 'Tags'))
const expanded = ref(false)
const mounted = ref(false)
onMounted(() => { mounted.value = true })
const rawId = computed(() => route.query.id)
const validId = (value: unknown): value is string => typeof value === 'string' && /^[1-9]\d{0,18}$/.test(value) && BigInt(value) <= 9223372036854775807n
const year = computed(() => typeof route.query.year === 'string' && /^[1-9]\d{0,3}$/.test(route.query.year) && Number(route.query.year) < 9999 ? route.query.year : '')
const invalid = computed(() => archive ? route.query.year !== undefined && !year.value : rawId.value !== undefined && !validId(rawId.value))
const current = computed(() => {
  if (archive && year.value) return 1
  const raw = route.query.page
  // 仓储以 int 计算 skip，限制到安全范围，异常参数回第一页。
  const page = typeof raw === 'string' && /^[1-9]\d*$/.test(raw) ? Number(raw) : 1
  return Number.isSafeInteger(page) && page <= Math.floor(2147483647 / (archive ? 20 : 10)) ? page : 1
})
const metadata = await useAsyncData(`discovery-${props.kind}-metadata`, async () => {
  const result = await api<{ success: boolean; data: Entry[] | Year[] }>(archive ? 'archive/year' : props.kind)
  if (!result.success || !Array.isArray(result.data)) throw new Error('Discovery metadata unavailable')
  return result.data
})
const entries = computed(() => archive ? [] : [...(metadata.data.value || []) as Entry[]].filter(item => item.articlesTotal > 0).sort((a, b) => (BigInt(a.sort ?? 0) < BigInt(b.sort ?? 0) ? -1 : BigInt(a.sort ?? 0) > BigInt(b.sort ?? 0) ? 1 : 0) || (BigInt(a.id) < BigInt(b.id) ? -1 : BigInt(a.id) > BigInt(b.id) ? 1 : 0)))
const years = computed(() => archive ? [...(metadata.data.value || []) as Year[]].sort((a, b) => b.year - a.year) : [])
const selectedId = computed(() => validId(rawId.value) ? rawId.value : rawId.value === undefined ? entries.value[0]?.id || '' : '')
const selectedName = computed(() => entries.value.find(item => item.id === selectedId.value)?.name || (typeof route.query.name === 'string' ? route.query.name : ''))
const result = await useAsyncData(() => `discovery-${props.kind}-${invalid.value}-${archive ? year.value : selectedId.value}-${current.value}`, async () => {
  if (invalid.value || (!archive && (!selectedId.value || metadata.error.value))) return null
  const response = await api<PublicArticlePage | ArchivePage>(archive ? 'archive/list' : `${props.kind}/article/list`, {
    method: 'POST', body: archive ? { current: current.value, size: 20, year: year.value || null } : { current: current.value, size: 10, [props.kind === 'category' ? 'categoryId' : 'tagId']: selectedId.value }
  })
  if (!response.success || !Array.isArray(response.data)) throw new Error('Discovery articles unavailable')
  return response
})
const groups = computed<Month[]>(() => archive ? (result.data.value as ArchivePage | null)?.data || [] : [{ month: '', articles: (result.data.value as PublicArticlePage | null)?.data || [] }])
const hasArticles = computed(() => groups.value.some(group => group.articles.length))
const pageCount = computed(() => archive && year.value ? 1 : result.data.value?.pages || 0)
const pages = computed(() => {
  const start = Math.max(1, Math.min(current.value - 2, pageCount.value - 4))
  return Array.from({ length: Math.min(5, pageCount.value) }, (_, index) => start + index)
})
const url = (query: Record<string, string | undefined>) => ({ path, query: { ...route.query, ...query }, hash: mounted.value ? route.hash : '' })
const selectUrl = (id: string, name?: string) => url(archive ? { year: id || undefined, page: undefined } : { id, name, page: undefined })
const pageUrl = (page: number) => url({ page: page > 1 ? String(page) : undefined })
async function retry() { await metadata.refresh(); await result.refresh() }
useSeoMeta({ title: () => `${title.value}${archive ? year.value ? ` · ${year.value}` : '' : selectedName.value ? ` · ${selectedName.value}` : ''}`, description: () => text('按分类、标签或时间探索公开文章。', 'Explore public articles by category, tag or date.') })
</script>

<style scoped>
.discovery-filter-heading{display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:8px;margin-bottom:8px}
.discovery-filter .discovery-filter-heading h1{margin:0}
.discovery-back-resources{display:inline-flex;align-items:center;gap:6px;padding:5px 10px;border:1px solid var(--border);border-radius:99px;background:var(--discovery-soft);color:var(--discovery-accent);font-size:12px;white-space:nowrap}
.discovery-back-resources:hover{border-color:var(--discovery-accent)}
.discovery-back-resources:focus-visible{outline:2px solid var(--discovery-accent);outline-offset:3px}
.discovery-selection{margin:4px 0;color:var(--muted);font-size:12px;overflow-wrap:anywhere}
.discovery-page{max-width:1280px;margin:8px auto 40px;--discovery-accent:#15956b;--discovery-soft:rgba(62,207,154,0.10);--discovery-brand-border:rgba(62,207,154,0.18);min-width:0}.discovery-filter,.discovery-results{border:1px solid var(--discovery-brand-border);border-radius:8px;background:var(--surface);padding:12px;margin-bottom:12px}.discovery-filter{position:sticky;top:57px;z-index:5;box-shadow:0 2px 6px #00000008}.discovery-filter h1{display:flex;align-items:center;gap:6px;font-size:16px;margin:0 0 8px;color:var(--text)}.discovery-filter h1 svg{color:#3ecf9a;width:20px;height:20px}.discovery-filter small{font-weight:400;color:var(--muted)}.filter-toggle{display:flex;justify-content:space-between;width:100%;margin-bottom:8px;padding:6px 12px;background:var(--discovery-soft);color:var(--discovery-accent);border:1px solid var(--discovery-brand-border);border-radius:8px}.discovery-pills{display:flex;flex-wrap:wrap;gap:6px;max-height:100px;overflow:auto;transition:max-height .3s}.discovery-pills.expanded{max-height:180px}.discovery-pills a{display:inline-flex;align-items:center;gap:5px;max-width:100%;overflow-wrap:anywhere;border:1px solid var(--border);border-radius:12px;padding:3px 7px;color:var(--muted);transition:background .3s,transform .3s}.discovery-pills a:hover{background:var(--discovery-soft);transform:translateY(-1px)}.discovery-pills span{flex-shrink:0;background:var(--discovery-soft);color:var(--discovery-accent);padding:0 5px;border-radius:50%;font-size:12px;min-width:20px;text-align:center}.discovery-pills [aria-current]{background:#3ecf9a;color:white;border-color:transparent}.discovery-pills [aria-current] span{background:#15956b;color:white}.discovery-results{padding:20px}.discovery-results ol{list-style:none;margin:0;padding:0}.discovery-results li+li{border-top:1px solid var(--border)}.discovery-article{display:flex;align-items:center;padding:12px;border-radius:8px;gap:12px;min-width:0;color:var(--text);transition:background .2s}.discovery-article:hover{background:var(--discovery-soft)}.discovery-article>div{min-width:0}.discovery-article img,.discovery-placeholder{width:96px;height:48px;flex-shrink:0;object-fit:cover;border-radius:8px}.discovery-placeholder{display:grid;place-items:center;background:var(--discovery-soft);color:#3ecf9a;font-size:20px;font-weight:700}.discovery-article h3{font-size:16px;font-weight:500;margin:0;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}.discovery-article time{display:flex;gap:8px;align-items:center;font-size:12px;color:var(--muted);margin-top:4px}.discovery-article time svg{width:12px;height:12px}.discovery-empty{text-align:center;padding:64px 0;color:var(--muted)}.discovery-empty>svg{width:48px;height:48px;color:#3ecf9a66}.discovery-timeline{border-left:1px solid var(--discovery-brand-border);margin-left:7px;padding-left:20px}.discovery-group{position:relative}.discovery-timeline .discovery-group{margin-bottom:28px}.discovery-timeline h2{font-size:18px;margin:0 0 12px}.discovery-timeline h2:before{content:'';position:absolute;left:-27px;top:7px;width:10px;height:10px;border-radius:50%;background:#3ecf9a;box-shadow:0 0 0 4px var(--discovery-soft);border:2px solid var(--surface)}.discovery-pagination{display:flex;justify-content:center;flex-wrap:wrap;gap:8px;margin:24px 0}.discovery-pagination a{border:1px solid var(--border);border-radius:8px;padding:4px 10px}.discovery-pagination [aria-current]{background:var(--primary);color:white}.discovery-total{text-align:center;color:var(--muted)}
[data-theme="dark"] .discovery-page{--discovery-accent:#8cc8ff;--discovery-soft:rgba(83,157,253,0.10);--discovery-brand-border:rgba(83,157,253,0.18);}
[data-theme="dark"] .discovery-filter-heading:has(.discovery-back-resources) h1 svg{color:#539dfd}
[data-theme="dark"] .discovery-pills [aria-current]{background:#539dfd1a;color:#539dfd;border-color:#539dfd4d}
[data-theme="dark"] .discovery-pills [aria-current] span{background:#539dfd;color:white}
@media(min-width:641px){.filter-toggle{display:none}.discovery-filter:has(.discovery-pills a:nth-child(9)) .filter-toggle{display:flex}}
@media(max-width:640px){.discovery-pills:not(.expanded){display:none}.discovery-results{padding:12px}.discovery-article{padding:10px 4px;gap:10px}.discovery-article img,.discovery-placeholder{width:80px}.discovery-timeline{padding-left:16px}.discovery-timeline h2:before{left:-23px}}
@media(prefers-reduced-motion:reduce){.discovery-page *{transition:none!important}}
</style>
