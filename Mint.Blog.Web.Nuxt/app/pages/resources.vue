<template>
  <div class="resource-page">
    <header class="resource-intro">
      <div>
        <span class="intro-label"><span class="mint-dot" /> MY DEVELOPER BOOKMARKS</span>
        <h1>资源导航<span>让收藏，有迹可循。</span></h1>
        <p>选一个技术标签，找到对应版本。官网、文章和工具，都在这里。</p>
      </div>
    </header>
    <div class="resource-workspace">
      <aside class="technology-sidebar" aria-label="标签目录">
        <div class="sidebar-discovery">
          <nav class="discovery-links" aria-label="文章分类与标签">
            <NuxtLink to="/categories">
              <SiteIcon name="category" />技术分类
            </NuxtLink>
            <NuxtLink to="/tags">
              <SiteIcon name="tag" />技术标签
            </NuxtLink>
          </nav>
        </div>
        <label class="search-box"><SiteIcon name="search" /><input v-model="technologyQuery" type="search" placeholder="技术标签名称…" aria-label="技术标签名称"></label>
        <div class="category-picker">
          <span class="category-label">技术标签分类</span>
          <details ref="categoryMenu" class="category-menu" @focusout="closeCategoryMenu" @keydown.esc.prevent.stop="dismissCategoryMenu">
            <summary :aria-disabled="categories.status.value !== 'success'" @click="categories.status.value !== 'success' && $event.preventDefault()">
              <span class="category-name" :title="categories.data.value?.find(item => item.id === category)?.name || '全部标签'">{{ categories.data.value?.find(item => item.id === category)?.name || '全部标签' }}</span>
              <span class="category-chevron" aria-hidden="true">⌄</span>
            </summary>
            <div class="category-options" aria-label="标签分类">
              <button type="button" :aria-pressed="category === ''" @click="selectCategory('')">全部标签</button>
              <button v-for="item in categories.data.value" :key="item.id" type="button" :aria-pressed="category === item.id" @click="selectCategory(item.id)">{{ item.name }}</button>
            </div>
          </details>
        </div>
        <p v-if="categories.status.value === 'pending'" class="sidebar-empty" role="status">正在加载分类…</p>
        <div v-else-if="categories.error.value" class="sidebar-empty" role="alert">分类加载失败。<button @click="categories.refresh()">重试</button></div>
        <h3 class="category-label technology-list-title">技术标签列表</h3>
        <nav class="technology-list" aria-label="选择标签" :aria-busy="technologies.status.value === 'pending'">
          <p v-if="technologies.status.value === 'pending'" class="sidebar-empty" role="status">正在加载标签…</p>
          <div v-else-if="technologies.error.value" class="sidebar-empty" role="alert">标签加载失败。<button @click="technologies.refresh()">重试</button></div>
          <template v-else>
            <button v-for="item in technologyItems" :key="item.id" :aria-pressed="tagId === item.id" @click="selectTechnology(item)">
              <span class="tech-mark"><img v-if="item.logoUrl && hasLogo(item)" :key="item.logoUrl" :src="item.logoUrl" :alt="`${item.name} Logo`" width="36" height="36" @error="onLogoError"><template v-else>{{ mark(item.name) }}</template></span><span class="technology-name"><b>{{ item.name }}</b><small>{{ item.categoryName }} · {{ item.versionCount }} 个版本</small></span><span class="tech-count" :title="`${item.resourceCount} 条技术标签资源（所有版本）`">{{ item.resourceCount }}</span>
            </button>
            <p v-if="!technologyItems.length" class="sidebar-empty">没有匹配的标签，试试其他关键词。</p>
          </template>
        </nav>
      </aside>
      <section class="resource-content" aria-label="技术资源" :aria-busy="loading">
        <div v-if="current" class="resource-sticky-header">
          <header class="technology-detail">
            <div class="technology-summary">
              <header class="1resource-intro">
                <div>
                  <div class="technology-identity">
                    <span class="tech-mark large">
                      <img v-if="current.logoUrl && hasLogo(current)" :key="current.logoUrl" :src="current.logoUrl" :alt="`${current.name} Logo`" width="56" height="56" @error="onLogoError">
                      <template v-else>{{ mark(current.name) }}</template>
                    </span>
                    <div class="technology-identity-text">
                      <h1>{{ current.name }}</h1>
                      <span>此标签共 {{ current.resourceCount }} 条资源</span>
                    </div>
                  </div>
                </div>
              </header>
            </div>
            <div class="version-picker"><span class="version-label">技术标签版本</span><div v-if="versionsReady" class="version-buttons" aria-label="选择标签版本"><button v-for="version in sortedVersions" :key="version.id" :aria-pressed="selectedVersion === version.id" @click="selectVersion(version.id)">{{ version.name }}<span v-if="selectedVersion === version.id" aria-hidden="true"> ✓</span></button></div><span class="version-hint">仅显示所选版本的资源与文章</span></div>
          </header>
          <div class="resource-toolbar"><div class="kind-filters" aria-label="资源类型"><button :aria-pressed="selectedKind === 0" @click="selectedKind = 0">全部资源</button><button v-for="kind in kinds" :key="kind.value" :aria-pressed="selectedKind === kind.value" @click="selectedKind = kind.value">{{ kind.label }}</button></div><label class="search-box resource-search"><SiteIcon name="search" /><input v-model="resourceQuery" type="search" placeholder="搜索所选版本资源…" aria-label="搜索所选版本资源"></label></div>
        </div>
        <div v-if="loading" class="resource-empty" role="status">正在加载资源导航…</div>
        <div v-else-if="failed" class="resource-empty" role="alert"><h3>加载失败</h3><p>{{ versionError || '无法获取资源导航，请检查服务后重试。' }}</p><button @click="retry">重试</button></div>
        <div v-else-if="!current" class="resource-empty"><h3>暂无可选标签</h3><p>换个分类或关键词，查看其他标签。</p></div>
        <template v-else-if="resourceResult">
          <div v-if="!resourceResult.items.length" class="resource-empty"><SiteIcon name="search" /><h3>暂时没有匹配的资源</h3><p>换个关键词，或查看其他版本的收藏。</p><button @click="resetResourceFilters">清除资源筛选</button><button v-if="page > 1" @click="page = 1">返回第一页</button></div>
          <section v-for="group in groups" :key="group.value" class="resource-group">
            <h3><span class="group-marker" />{{ group.label }}<small>本页 {{ group.items.length }}</small><span class="group-line" /></h3>
            <div class="resource-grid"><a v-for="resource in group.items" :key="resource.id" class="resource-card" :href="resource.url" target="_blank" rel="noopener noreferrer">
              <div class="card-top"><span class="resource-symbol" aria-hidden="true">{{ resource.kind === 1 ? 'W' : resource.kind === 2 ? 'Aa' : resource.kind === 4 ? '⌘' : '</>' }}</span><span v-if="resource.isFeatured" class="featured-badge">常用入口</span><span class="external-arrow" aria-hidden="true">↗</span></div>
              <h4>{{ resource.title }}</h4><p>{{ resource.description }}</p><div class="card-footer"><span class="resource-domain">{{ domain(resource.url) }}</span><span class="version-badge">{{ resource.tagVersionName }}</span></div>
            </a></div>
          </section>
          <nav v-if="pageCount > 1" class="resource-pagination" aria-label="资源分页"><button :disabled="page <= 1" @click="page--">上一页</button><button v-for="number in pages" :key="number" :aria-current="number === page ? 'page' : undefined" @click="page = number">{{ number }}</button><button :disabled="page >= pageCount" @click="page++">下一页</button><span>第 {{ page }} / {{ pageCount }} 页 · 共 {{ totalCount }} 条</span></nav>
        </template>
        <footer class="resource-footnote"><span class="mint-dot" /> 少一点翻找，多一点专注。<span>外链均在新标签页打开 ↗</span></footer>
      </section>
    </div>
  </div>
</template>

<script setup lang="ts">
import { isPublicSelectionId, type NavigationTag, type ResourceKind } from '~/composables/usePublicResources'

const service = usePublicResources()
const route = useRoute()
const router = useRouter()
const category = ref('')
const categoryMenu = ref<HTMLDetailsElement>()
function closeCategoryMenu(event?: FocusEvent) {
  if (event?.relatedTarget instanceof Node && categoryMenu.value?.contains(event.relatedTarget)) return
  if (categoryMenu.value) categoryMenu.value.open = false
}
function selectCategory(id: string) {
  category.value = id
  closeCategoryMenu()
  categoryMenu.value?.querySelector('summary')?.focus()
}
function dismissCategoryMenu() {
  closeCategoryMenu()
  categoryMenu.value?.querySelector('summary')?.focus()
}
const technologyQuery = ref('')
const technologyKeyword = ref('')
const resourceQuery = ref('')
const resourceKeyword = ref('')
const articleQuery = ref('')
const articleKeyword = ref('')
const selectedKind = ref<ResourceKind | 0>(0)
const page = ref(1)
const pageSize = 12
const articlePage = ref(1)
const articlePageSize = 10
const kinds = [
  { value: 1, label: '官方文档' }, { value: 2, label: 'Mint文章' },
  { value: 3, label: 'Gite仓库' }, { value: 4, label: '软件获取' }
] as const
let technologyTimer: ReturnType<typeof setTimeout> | undefined
let resourceTimer: ReturnType<typeof setTimeout> | undefined
let articleTimer: ReturnType<typeof setTimeout> | undefined
watch(technologyQuery, value => {
  clearTimeout(technologyTimer)
  technologyTimer = setTimeout(() => { technologyKeyword.value = value.trim() }, 300)
})
watch(resourceQuery, value => {
  clearTimeout(resourceTimer)
  resourceTimer = setTimeout(() => { resourceKeyword.value = value.trim() }, 300)
})
watch(articleQuery, value => {
  clearTimeout(articleTimer)
  articleTimer = setTimeout(() => { articleKeyword.value = value.trim() }, 300)
})
onBeforeUnmount(() => { clearTimeout(technologyTimer); clearTimeout(resourceTimer); clearTimeout(articleTimer) })

const categories = await useAsyncData('resource-categories', () => service.getCategories())
const technologyKey = computed(() => JSON.stringify(['navigation-tags', category.value, technologyKeyword.value]))
const technologies = await useAsyncData(technologyKey, async () => {
  const key = technologyKey.value
  const items = await service.getNavigationTags({ categoryId: category.value, keyword: technologyKeyword.value })
  return { key, items }
})
const technologyItems = computed(() => technologies.status.value === 'success' && technologies.data.value?.key === technologyKey.value ? technologies.data.value.items : [])
const current = computed(() => route.query.tagId === undefined
  ? technologyItems.value[0]
  : technologyItems.value.find(item => item.id === route.query.tagId))
const tagId = computed(() => current.value?.id || '')
const routeError = computed(() => {
  if (route.query.tagId !== undefined && !isPublicSelectionId(route.query.tagId)) return '标签参数无效，请重新选择标签。'
  if (route.query.tagVersionId !== undefined && !isPublicSelectionId(route.query.tagVersionId)) return '版本参数无效，请重新选择版本。'
  if (route.query.tagVersionId !== undefined && route.query.tagId === undefined) return '版本链接缺少标签，请重新选择标签。'
  if (route.query.versionId !== undefined) return '此链接使用旧版本参数，请重新选择标签与版本。'
  if (technologies.status.value === 'success' && route.query.tagId !== undefined && !current.value) return '标签不存在、已停用或不在当前筛选范围，请重新选择标签。'
  return ''
})
watch(tagId, () => { resetResourceFilters(); resetArticleSearch() }, { flush: 'sync' })
const versions = await useAsyncData(() => `navigation-versions-${tagId.value}`, async () => {
  const id = tagId.value
  return { tagId: id, items: id ? await service.getVersions(id) : [] }
})
const versionsReady = computed(() => !!tagId.value && versions.status.value === 'success' && versions.data.value?.tagId === tagId.value)
const sortedVersions = computed(() => [...(versions.data.value?.items || [])].sort((a, b) => {
  if (a.isGeneral !== b.isGeneral) return a.isGeneral ? -1 : 1
  const sortDifference = BigInt(a.sort) - BigInt(b.sort)
  if (sortDifference !== 0n) return sortDifference < 0n ? -1 : 1
  const idDifference = BigInt(a.id) - BigInt(b.id)
  return idDifference < 0n ? -1 : idDifference > 0n ? 1 : 0
}))
const versionError = computed(() => {
  if (routeError.value) return routeError.value
  if (versions.error.value) return versions.error.value.message
  if (!versionsReady.value) return ''
  if (route.query.tagVersionId !== undefined && !versions.data.value?.items.some(item => item.id === route.query.tagVersionId && item.tagId === tagId.value)) return '所选版本不存在、已停用或不属于当前标签，请重新选择版本。'
  return ''
})
const selectedVersion = computed(() => {
  if (!versionsReady.value || versionError.value) return ''
  if (route.query.tagVersionId !== undefined) return sortedVersions.value.find(item => item.id === route.query.tagVersionId)?.id || ''
  return (sortedVersions.value.find(item => !item.isGeneral) || sortedVersions.value[0])?.id || ''
})
const versionName = computed(() => versions.data.value?.items.find(item => item.id === selectedVersion.value)?.name || '等待有效版本')
// 未指定版本时优先选择排序号最小的非通用版本，并将选择同步到路由。
watch([tagId, selectedVersion], ([id, version]) => {
  if (import.meta.client && id && version && route.query.tagVersionId === undefined && !routeError.value) {
    void router.replace({ path: route.path, query: { ...route.query, tagId: id, tagVersionId: version }, hash: route.hash })
  }
}, { immediate: true })
function selectTechnology(item: NavigationTag) {
  void router.push({ path: route.path, query: { ...route.query, tagId: item.id, tagVersionId: undefined, versionId: undefined }, hash: route.hash })
}
function selectVersion(id: string) {
  void router.push({ path: route.path, query: { ...route.query, tagId: tagId.value, tagVersionId: id, versionId: undefined }, hash: route.hash })
}
watch([category, technologyKeyword], () => {
  void router.replace({ path: route.path, query: { ...route.query, tagId: undefined, tagVersionId: undefined, versionId: undefined }, hash: route.hash })
}, { flush: 'sync' })
watch([tagId, selectedVersion, selectedKind, resourceKeyword], () => { page.value = 1 }, { flush: 'sync' })
watch([tagId, selectedVersion, articleKeyword], () => { articlePage.value = 1 }, { flush: 'sync' })
const resourcesReady = computed(() => !!tagId.value && !!selectedVersion.value && versionsReady.value && !versionError.value)
const resourceParameters = computed(() => ({
  tagId: tagId.value, tagVersionId: selectedVersion.value,
  kind: selectedKind.value || undefined, keyword: resourceKeyword.value,
  pageNumber: page.value, pageSize
}))
const resourceKey = computed(() => JSON.stringify(['navigation-resources', resourcesReady.value, resourceParameters.value]))
const resources = await useAsyncData(resourceKey, async () => {
  const key = resourceKey.value
  const parameters = { ...resourceParameters.value }
  if (!resourcesReady.value) return null
  return { key, result: await service.getResources(parameters) }
})
const articleParameters = computed(() => ({
  tagId: tagId.value, tagVersionId: selectedVersion.value, keyword: articleKeyword.value,
  pageNumber: articlePage.value, pageSize: articlePageSize
}))
const articleKey = computed(() => JSON.stringify(['navigation-articles', resourcesReady.value, articleParameters.value]))
const articles = await useAsyncData(articleKey, async () => {
  const key = articleKey.value
  const parameters = { ...articleParameters.value }
  if (!resourcesReady.value) return null
  return { key, result: await service.getArticles(parameters) }
})
const loading = computed(() => technologies.status.value === 'pending' || versions.status.value === 'pending' || resources.status.value === 'pending')
const failed = computed(() => !!technologies.error.value || !!versionError.value || !!resources.error.value)
const resourceResult = computed(() => resourcesReady.value && !loading.value && !failed.value && resources.status.value === 'success' && resources.data.value?.key === resourceKey.value ? resources.data.value.result : null)
const totalCount = computed(() => resourceResult.value?.totalCount || 0)
const pageCount = computed(() => Math.ceil(totalCount.value / pageSize))
const pages = computed(() => {
  const start = Math.max(1, Math.min(page.value - 2, pageCount.value - 4))
  return Array.from({ length: Math.min(5, pageCount.value) }, (_, index) => start + index)
})
const groups = computed(() => kinds.map(kind => ({ ...kind, items: resourceResult.value?.items.filter(item => item.kind === kind.value) || [] })).filter(group => group.items.length))
const articleLoading = computed(() => technologies.status.value === 'pending' || versions.status.value === 'pending' || articles.status.value === 'pending')
const articleFailed = computed(() => !!technologies.error.value || !!versionError.value || !!articles.error.value)
const articleResult = computed(() => resourcesReady.value && !articleLoading.value && !articleFailed.value && articles.status.value === 'success' && articles.data.value?.key === articleKey.value ? articles.data.value.result : null)
const articleTotal = computed(() => articleResult.value?.totalCount || 0)
const articlePageCount = computed(() => Math.ceil(articleTotal.value / articlePageSize))
const articlePages = computed(() => {
  const start = Math.max(1, Math.min(articlePage.value - 2, articlePageCount.value - 4))
  return Array.from({ length: Math.min(5, articlePageCount.value) }, (_, index) => start + index)
})
async function retryArticles() {
  if (technologies.error.value || routeError.value) await technologies.refresh()
  else if (versions.error.value || versionError.value) await versions.refresh()
  else await articles.refresh()
}
async function retry() {
  if (technologies.error.value || routeError.value) await technologies.refresh()
  else if (versions.error.value || versionError.value) await versions.refresh()
  else await resources.refresh()
}
function resetArticleSearch() {
  clearTimeout(articleTimer)
  articleQuery.value = ''
  articleKeyword.value = ''
  articlePage.value = 1
}
function resetResourceFilters() {
  clearTimeout(resourceTimer)
  selectedKind.value = 0
  resourceQuery.value = ''
  resourceKeyword.value = ''
  page.value = 1
}
const articleDate = (value: string) => new Intl.DateTimeFormat('zh-CN', { timeZone: 'Asia/Shanghai', year: 'numeric', month: '2-digit', day: '2-digit' }).format(new Date(value))
const failedLogoUrls = ref(new Set<string>())
function hasLogo(tag: NavigationTag) { return !!tag.logoUrl?.trim() && !failedLogoUrls.value.has(tag.logoUrl) }
function onLogoError(event: Event) {
  const url = (event.currentTarget as HTMLImageElement).getAttribute('src')
  if (url) failedLogoUrls.value.add(url)
}
function mark(name: string) { return Array.from(name).slice(0, 2).join('') }
function domain(url: string) { return new URL(url).hostname.replace(/^www\./, '') }
useSeoMeta({ title: '资源导航 · 技术标签', description: '按技术标签和版本整理官方文档、文章教程、Gite仓库与软件获取入口。' })
</script>

<style scoped>
.resource-sticky-header{position:sticky;top:65px;z-index:10;display:flow-root;background:var(--bg)}
@media(max-width:760px){.resource-sticky-header{position:static}}
.technology-identity{display:flex;align-items:center;gap:15px;margin:18px 0}
.technology-identity-text{min-width:0}
.technology-identity-text h1{margin:0 0 4px;font-size:26px;line-height:1.4;overflow-wrap:anywhere}
.technology-identity-text>span{font-size:12px;color:var(--muted)}
.category-picker{display:grid;gap:6px;margin:14px 0;padding-bottom:16px;border-bottom:1px dashed var(--border)}
.category-label{font-size:12px;color:var(--muted)}
.technology-list-title{margin:0 0 8px;font-weight:400}
.category-menu{position:relative;min-width:0}
.category-menu summary{display:flex;align-items:center;gap:10px;padding:9px 12px;list-style:none;cursor:pointer;border:1px solid var(--border);border-radius:7px;background:var(--bg);color:var(--text);font-size:13px}
.category-menu summary::-webkit-details-marker{display:none}
.category-menu summary:hover,.category-menu[open] summary{border-color:var(--mint)}
.category-menu summary:focus-visible{outline:2px solid var(--mint);outline-offset:3px}
.category-menu summary[aria-disabled="true"]{opacity:.5;cursor:default}
.category-name{flex:1;min-width:0;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.category-chevron{flex-shrink:0;color:var(--muted)}
.category-menu[open] .category-chevron{transform:rotate(180deg)}
.category-options{position:absolute;top:calc(100% + 6px);left:0;right:0;z-index:20;max-height:260px;overflow-y:auto;padding:6px;border:1px solid var(--border);border-radius:8px;background:var(--surface);box-shadow:var(--resource-shadow)}
.category-options button{display:block;width:100%;padding:9px 10px;border:0;border-radius:5px;background:transparent;color:var(--text);text-align:left;font-size:13px;white-space:normal;overflow-wrap:anywhere}
.category-options button:hover,.category-options button[aria-pressed="true"]{background:var(--mint-soft);color:var(--mint)}
.sidebar-discovery{margin:0 6px 16px;padding-bottom:16px;border-bottom:1px dashed var(--border)}
.sidebar-discovery .discovery-links{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));margin-top:0}
.sidebar-discovery .discovery-links a{justify-content:center}
.discovery-links{display:flex;flex-wrap:wrap;gap:10px;margin-top:16px}.discovery-links a{display:inline-flex;align-items:center;gap:6px;padding:6px 12px;border:1px solid var(--border);border-radius:7px;background:var(--surface);color:var(--mint);font-size:12px}.discovery-links a:hover{border-color:var(--mint);text-decoration:none}.discovery-links a:focus-visible{outline:2px solid var(--mint);outline-offset:3px}.discovery-links svg{width:16px;height:16px}
.tech-mark img{display:block;width:36px;height:36px;object-fit:contain}.tech-mark.large img{width:56px;height:56px}
.section-title{font-size:16px;margin:24px 0 0}.navigation-articles{margin-top:32px;padding-top:24px;border-top:1px solid var(--border)}.article-toolbar{display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:16px;margin-bottom:18px}.article-toolbar .section-title{margin:0}.article-toolbar p,.article-version-hint{font-size:12px;color:var(--muted);line-height:1.8}.article-toolbar p{margin:6px 0 0}.article-version-hint{margin:-12px 0 18px}.navigation-article-list{display:grid;gap:12px}.navigation-article-card{display:block;min-width:0;padding:20px;background:var(--surface);border:1px solid var(--border);border-radius:10px;color:var(--text);overflow-wrap:anywhere;transition:border-color .18s}.navigation-article-card:hover{border-color:var(--mint);text-decoration:none}.navigation-article-card:focus-visible{outline:2px solid var(--mint);outline-offset:3px}.navigation-article-card h4{font-size:16px;margin:0 0 8px}.navigation-article-card>p{font-size:13px;line-height:1.8;color:var(--muted);margin:0 0 16px;display:-webkit-box;-webkit-line-clamp:3;-webkit-box-orient:vertical;overflow:hidden}.article-meta{display:flex;align-items:center;flex-wrap:wrap;gap:10px;color:var(--muted);font-size:11px}.article-read{margin-left:auto;color:var(--mint)}
.resource-page{--mint:#15956b;--mint-primary:#3ecf9a;--mint-hover:#2bc48d;--tech-color:var(--mint);--mint-soft:rgba(62,207,154,0.10);--mint-border:rgba(62,207,154,0.18);--resource-shadow:0 8px 24px rgba(15,23,42,0.08);max-width:1440px;margin:20px auto 48px;color:var(--text)}
.resource-intro{display:flex;justify-content:space-between;align-items:center;gap:24px;padding:8px 4px 28px}.intro-label{display:flex;align-items:center;gap:8px;color:var(--mint);font-size:11px;font-weight:700;letter-spacing:2px}.mint-dot{display:inline-block;width:7px;height:7px;border-radius:50%;background:var(--mint-primary);flex-shrink:0}.resource-intro h1{margin:12px 0 8px;font-size:30px;letter-spacing:-1px}.resource-intro h1>span{margin-left:18px;color:var(--muted);font-size:20px;font-weight:400;letter-spacing:0}.resource-intro p{margin:0;color:var(--muted)}.collection-stats{display:flex;align-items:center;gap:28px;padding:0 18px}.collection-stats strong{font-size:27px;font-weight:650}.collection-stats strong span{display:block;font-size:12px;font-weight:400;color:var(--muted)}
.resource-workspace{display:grid;grid-template-columns:248px minmax(0,1fr);align-items:start;gap:24px}.technology-sidebar{position:sticky;top:65px;background:var(--surface);border:1px solid var(--border);border-radius:12px;padding:18px 12px}.sidebar-heading{display:flex;justify-content:space-between;align-items:center;padding:0 6px 16px}.sidebar-heading h2{font-size:15px;margin:0}.sidebar-heading>span{font-size:12px;color:var(--muted);border:1px solid var(--border);border-radius:5px;padding:0 6px}.search-box{display:flex;align-items:center;gap:8px;border:1px solid var(--border);border-radius:7px;padding:8px 10px;background:var(--bg)}.search-box svg{width:16px;height:16px;flex-shrink:0;color:var(--muted)}.search-box input{width:100%;min-width:0;border:0;background:transparent;color:var(--text);outline:none}.search-box:focus-within{outline:2px solid var(--mint);outline-offset:2px}.search-box input::placeholder{color:var(--muted);font-size:12px}.technology-list{display:grid;gap:6px}.technology-list button{display:flex;align-items:center;gap:10px;width:100%;text-align:left;padding:12px 10px;border:1px solid transparent;border-radius:8px;background:transparent}.technology-list button:hover{background:var(--bg)}.technology-list button[aria-pressed="true"]{border-color:var(--mint-border);background:var(--mint-soft)}.tech-mark{display:grid;place-items:center;flex-shrink:0;width:36px;height:36px;border-radius:9px;background:var(--mint-soft);color:var(--tech-color);font-size:15px;font-weight:750;letter-spacing:-1px}.technology-name{display:grid;gap:2px;min-width:0;overflow-wrap:anywhere}.technology-name b{font-size:14px;font-weight:650}.technology-name small{font-size:10px;color:var(--muted)}.tech-count{margin-left:auto;color:var(--muted);font-size:12px}.sidebar-note{display:flex;align-items:center;gap:10px;margin:24px 5px 0;padding:16px 0 0;border-top:1px dashed var(--border);color:var(--muted);font-size:12px}.sidebar-note svg{width:20px;height:20px;color:var(--mint)}.sidebar-note p{margin:0}.sidebar-note span{font-size:11px;opacity:.75}.sidebar-empty{padding:16px 8px;color:var(--muted);font-size:12px}.resource-content{min-width:0}.technology-detail{background:var(--surface);border:1px solid var(--border);border-radius:12px;padding:0px 28px 0}.technology-summary{display:flex;gap:15px;align-items:center}.tech-mark.large{width:56px;height:56px;font-size:24px;border-radius:13px}.technology-summary p{margin:0 0 2px;color:var(--muted);font-size:11px}.technology-summary p>span{margin:0 7px;opacity:.5}.technology-summary h2{display:flex;align-items:center;flex-wrap:wrap;gap:12px;font-size:26px;margin:0;line-height:1.4;overflow-wrap:anywhere}.technology-summary h2>span{font-size:11px;font-weight:400;color:var(--muted);border:1px solid var(--border);border-radius:20px;padding:2px 9px}.technology-description{color:var(--muted);font-size:13px;margin:18px 0 24px}.version-picker{display:flex;align-items:center;gap:16px;flex-wrap:wrap;border-top:1px solid var(--border);padding:17px 0}.version-label{font-size:12px;color:var(--muted)}.version-buttons{display:flex;gap:8px;flex-wrap:wrap}.version-buttons button{min-width:54px;border-radius:6px;padding:4px 12px;font-size:12px}.version-buttons button[aria-pressed="true"]{background:var(--mint-soft);border-color:var(--mint);color:var(--mint)}.version-hint{margin-left:auto;font-size:11px;color:var(--muted)}.resource-toolbar{display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:14px;margin:24px 0 16px}.kind-filters{display:flex;flex-wrap:wrap;gap:5px}.kind-filters button{padding:7px 9px;border:0;background:transparent;font-size:12px;color:var(--muted);border-radius:6px}.kind-filters button[aria-pressed="true"]{background:var(--mint-soft);color:var(--mint);font-weight:600}.resource-search{width:220px;padding:7px 10px;background:var(--surface)}.results-caption{display:flex;justify-content:space-between;align-items:center;color:var(--muted);font-size:11px;margin-bottom:24px}.results-caption b{font-weight:500;margin-left:4px}.resource-group{margin-bottom:28px}.resource-group>h3{display:flex;align-items:center;gap:8px;margin:0 0 13px;font-size:14px;font-weight:650}.group-marker{width:4px;height:14px;background:var(--mint);border-radius:4px}.resource-group h3 small{font-size:11px;color:var(--muted);font-weight:400;margin-left:2px}.group-line{flex:1;height:1px;background:var(--border);margin-left:8px;opacity:.6}.resource-grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:14px}.resource-card{display:flex;flex-direction:column;min-width:0;padding:18px;background:var(--surface);border:1px solid var(--border);border-radius:10px;color:var(--text);transition:border-color .18s,transform .18s,box-shadow .18s}.resource-card:hover{border-color:var(--mint);transform:translateY(-3px);box-shadow:var(--resource-shadow);text-decoration:none}.card-top{display:flex;align-items:center;gap:8px;margin-bottom:14px}.resource-symbol{display:grid;place-items:center;width:32px;height:32px;border-radius:8px;background:var(--mint-soft);color:var(--mint);font:650 14px/1 ui-monospace,monospace}.featured-badge{font-size:10px;color:var(--mint);background:var(--mint-soft);padding:2px 6px;border-radius:4px}.external-arrow{margin-left:auto;color:var(--muted);font-size:18px}.resource-card h4{font-size:14px;margin:0 0 7px;font-weight:650;overflow-wrap:anywhere}.resource-card>p{font-size:12px;line-height:1.8;color:var(--muted);margin:0 0 18px;flex:1;overflow-wrap:anywhere}.card-footer{display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:8px;padding-top:12px;border-top:1px solid var(--border);font-size:10px;color:var(--muted)}.resource-domain{overflow:hidden;white-space:nowrap;text-overflow:ellipsis;max-width:100%}.version-badge{max-width:100%;overflow-wrap:anywhere;background:var(--bg);border:1px solid var(--border);border-radius:4px;padding:1px 5px;font-size:9px}.resource-footnote{display:flex;align-items:center;flex-wrap:wrap;gap:8px;color:var(--muted);font-size:11px;margin:32px 0 0;padding-top:18px;border-top:1px dashed var(--border)}.resource-footnote>span:last-child{margin-left:auto}.resource-empty{text-align:center;padding:60px 16px;background:var(--surface);border:1px dashed var(--border);border-radius:10px;color:var(--muted)}.resource-empty>svg{width:28px;height:28px}.resource-empty h3{font-size:16px;color:var(--text)}.resource-empty p{font-size:13px}.resource-empty button{margin-top:8px;padding:7px 14px;color:var(--mint)}.resource-pagination{display:flex;justify-content:center;align-items:center;flex-wrap:wrap;gap:8px;margin:24px 0}.resource-pagination button{padding:5px 10px;border-radius:6px}.resource-pagination [aria-current]{background:var(--mint-soft);color:var(--mint)}.resource-pagination span{color:var(--muted);font-size:12px}.resource-pagination button:disabled{opacity:.45;cursor:default}
:global([data-theme="dark"]) .resource-page{--mint:#539dfd;--mint-primary:#539dfd;--mint-hover:#60a5fa;--mint-soft:rgba(83,157,253,0.10);--mint-border:rgba(83,157,253,0.18);--resource-shadow:0 8px 24px rgba(0,0,0,0.28)}
.resource-page :is(button,a,select):focus-visible{outline:2px solid var(--mint);outline-offset:3px}
.version-buttons button:hover,.kind-filters button:hover:not([aria-pressed="true"]),.resource-pagination button:hover:not(:disabled){background:var(--mint-soft);color:var(--mint);border-color:var(--mint-hover)}
.group-marker{background:var(--mint-primary)}
@media(min-width:1650px){.resource-page{margin-top:10px}}@media(max-width:1200px){.resource-grid{grid-template-columns:repeat(2,minmax(0,1fr))}.resource-workspace{grid-template-columns:220px minmax(0,1fr);gap:18px}.resource-search{width:100%}.resource-toolbar{gap:10px}}@media(max-width:760px){.resource-page{margin-top:8px}.resource-intro{padding-bottom:20px}.resource-intro h1{font-size:26px}.resource-intro h1>span{display:block;margin:6px 0 0;font-size:17px}.resource-intro p{font-size:12px}.collection-stats{gap:15px;padding:0}.collection-stats strong{font-size:22px}.collection-stats strong span{font-size:10px}.intro-label{font-size:9px;letter-spacing:1px}.resource-workspace{grid-template-columns:minmax(0,1fr);gap:18px}.technology-sidebar{position:static;padding:14px}.sidebar-heading{padding-bottom:12px}.technology-list{display:flex;overflow-x:auto;padding-bottom:4px}.technology-list button{width:auto;flex-shrink:0;padding:8px}.technology-list .tech-count,.sidebar-note{display:none}.technology-name small{font-size:9px}.technology-detail{padding:20px 18px 0}.version-picker{gap:10px}.version-hint{margin-left:0;width:100%;font-size:10px}.resource-toolbar{margin-top:18px}.resource-footnote>span:last-child{margin-left:0;width:100%}}@media(max-width:440px){.resource-grid{grid-template-columns:minmax(0,1fr)}.resource-card{padding:16px}.collection-stats{display:none}.kind-filters{gap:2px}.kind-filters button{padding:6px;font-size:11px}.resource-intro h1>span{display:inline;margin-left:12px;font-size:15px}.technology-summary h2{font-size:23px}}
</style>
