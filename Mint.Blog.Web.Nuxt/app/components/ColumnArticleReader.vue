<template>
  <section class="column-reader" :class="{ 'without-toc': !desktopOpen }" :aria-busy="status === 'pending'">
    <p v-if="status === 'pending'" class="panel" role="status">正在加载文章…</p>
    <div v-else-if="error" class="panel" role="alert"><h2>{{ error.statusCode === 404 ? '404 · 文章不存在或已下架' : '文章暂时无法加载' }}</h2><p>可选择目录中的其他文章，或稍后重试。</p><button type="button" @click="refresh()">重新加载文章</button></div>
    <article v-else-if="article" class="panel">
      <header>
        <h2 ref="title" class="column-article-title">{{ article.title }}</h2>
        <div class="column-article-tags"><span># {{ article.tagName }}</span><span>{{ article.tagVersionName }}</span></div>
        <div class="column-article-meta muted"><span v-if="article.categoryName">{{ article.categoryName }}</span><time :datetime="article.createTime">发布于 {{ formatDateTime(article.createTime) }}</time><span>{{ article.readNum }} 次阅读</span><span>{{ article.totalWords }} 字</span><span>{{ article.readTime }}</span></div>
      </header>
      <button v-if="tocHeadings.length" type="button" class="column-toc-toggle" :aria-expanded="tocOpen" aria-controls="column-article-toc" @click="toggleToc"><SiteIcon name="menu" /> 文章目录</button>
      <div v-if="article.content" ref="content" class="article-content" @click="contentClick" v-html="rendered.html" />
      <p v-else class="muted">本文暂无正文。</p>
      <p class="sr-only" role="status">{{ feedback }}</p>
      <p class="muted">最后编辑于 {{ formatDateTime(article.updateTime) }}</p>
      <section class="article-copyright"><strong>版权声明</strong><p>{{ settings?.copyrightDeclaration || '保留所有权利，转载请注明出处和本文链接。' }}</p><span>本文链接：</span><a :href="articleUrl">{{ articleUrl }}</a></section>
      <p v-if="neighborStatus === 'pending'" role="status">正在加载上下篇…</p>
      <p v-else-if="neighborError" role="alert">上下篇暂时无法加载 <button type="button" @click="refreshNeighbors()">重试</button></p>
      <nav v-else class="article-adjacent" aria-label="专栏上下篇"><NuxtLink v-if="previous" :to="articleLocation(previous.articleId)" @click.capture="emit('select', $event, previous.articleId)">上一篇<br>{{ previous.articleTitle }}</NuxtLink><NuxtLink v-if="next" :to="articleLocation(next.articleId)" @click.capture="emit('select', $event, next.articleId)">下一篇<br>{{ next.articleTitle }}</NuxtLink></nav>
    </article>
    <component :is="isMobile ? 'dialog' : 'aside'" v-if="article && !error && tocHeadings.length" v-show="isMobile || desktopOpen" id="column-article-toc" ref="tocElement" data-article-toc class="column-article-toc article-toc panel" aria-label="当前文章标题目录" @close="syncMobileToc" @cancel.prevent="closeMobileToc" @click="backdropClick"><h2><SiteIcon name="menu" /> 文章目录<button type="button" class="toc-mobile-close" aria-label="关闭目录" @click="closeMobileToc">×</button></h2><div class="toc-wrapper"><a v-for="heading in tocHeadings" :key="heading.id" :href="`#${heading.id}`" :style="{ marginLeft: `${heading.indent * 1.25}rem`, fontSize: `${Math.max(.7, 1 - heading.indent * .08)}rem` }" :aria-current="activeHeading === heading.id ? 'location' : undefined" @click.prevent="goHeading(heading.id)">{{ heading.title }}</a></div></component>
    <dialog ref="preview" class="article-preview" aria-label="文章图片预览" @click="($event.target === preview) && preview?.close()"><button autofocus type="button" @click="preview?.close()">关闭图片预览</button><img :src="previewSrc || undefined" :alt="previewAlt"></dialog>
  </section>
</template>

<script setup lang="ts">
import { renderArticleMarkdown } from '~/utils/markdown'
import { columnReadingId, type ColumnReadingArticle, type ColumnReadingNeighbors } from '~/utils/columnReading'
const props = defineProps<{ columnId: string; articleId: string; articleIds: string[]; columnTitle: string }>()
const emit = defineEmits<{ ready: [articleId: string, title: HTMLElement]; select: [event: MouseEvent, articleId: string] }>()
const title = ref<HTMLElement>()
onMounted(() => { if (article.value && !error.value && title.value) emit('ready', props.articleId, title.value) })
const route = useRoute()
const api = usePublicApi()
const { data: settings } = await useSiteSettings()
const { data: article, error, status, refresh } = await useAsyncData(`column-article-${props.columnId}-${props.articleId}`, async () => {
  if (!props.articleIds.includes(props.articleId)) throw createError({ statusCode: 404, statusMessage: '文章不在此专栏中' })
  const result = await api<{ success: boolean; data?: ColumnReadingArticle; errorCode?: string }>('article/detail', { method: 'POST', body: { articleId: props.articleId, columnId: props.columnId } })
  if (!result.success || !result.data) throw createError({ statusCode: result.errorCode === '20010' ? 404 : 502, statusMessage: result.errorCode === '20010' ? '文章不存在或已下架' : '文章暂时无法加载' })
  return result.data
})
if (import.meta.server && error.value?.statusCode === 404) {
  const event = useRequestEvent()
  if (event) setResponseStatus(event, 404)
}
const { data: neighbors, error: neighborError, status: neighborStatus, refresh: refreshNeighbors } = await useAsyncData(`column-neighbors-${props.columnId}-${props.articleId}`, async () => {
  if (!props.articleIds.includes(props.articleId)) return null
  const result = await api<{ success: boolean; data?: ColumnReadingNeighbors }>(`column/${props.columnId}/article/${props.articleId}/neighbor`)
  if (!result.success || !result.data) throw new Error('上下篇暂时无法加载')
  return result.data
})
function memberLink(link?: { articleId: string; articleTitle: string }) {
  const id = columnReadingId(link?.articleId)
  return id && props.articleIds.includes(id) && id !== props.articleId ? { articleId: id, articleTitle: link!.articleTitle } : undefined
}
const previous = computed(() => memberLink(neighbors.value?.preArticle))
const next = computed(() => memberLink(neighbors.value?.nextArticle))
watch([status, article], async () => {
  await nextTick()
  if (article.value && !error.value && title.value) emit('ready', props.articleId, title.value)
})
const articleLocation = (id: string) => ({ path: route.path, query: { ...route.query, articleId: id }, hash: '' })
const rendered = computed(() => renderArticleMarkdown(article.value?.content || ''))
const tocHeadings = computed(() => {
  const levels: number[] = []
  return rendered.value.headings.map(heading => {
    while (levels.length && levels[levels.length - 1]! >= heading.level) levels.pop()
    const indent = levels.length
    levels.push(heading.level)
    return { ...heading, indent }
  })
})
const url = useRequestURL()
const articleUrl = new URL(`/columns/${props.columnId}?${new URLSearchParams({ articleId: props.articleId })}`, useRuntimeConfig().public.siteUrl || url.origin).href
useSeoMeta({
  title: () => `${article.value?.title || (error.value ? '文章暂时无法阅读' : '加载中')} · ${props.columnTitle}`,
  description: () => article.value?.summary || article.value?.content.slice(0, 160),
  ogTitle: () => article.value?.title, ogDescription: () => article.value?.summary,
  robots: () => error.value ? 'noindex, nofollow' : 'index, follow'
})
useHead({ link: [{ rel: 'canonical', href: articleUrl }] })
const formatDateTime = (value: string) => new Intl.DateTimeFormat('sv-SE', { timeZone: 'Asia/Shanghai', year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit', hourCycle: 'h23' }).format(new Date(value))
const content = ref<HTMLElement>()
const preview = ref<HTMLDialogElement>()
const previewSrc = ref('')
const previewAlt = ref('')
const feedback = ref('')
async function contentClick(event: MouseEvent) {
  const target = event.target
  if (!(target instanceof Element)) return
  const button = target.closest<HTMLButtonElement>('.code-copy')
  if (button) {
    try { await navigator.clipboard.writeText(button.closest('.code-block-wrapper')?.querySelector('code')?.textContent || ''); feedback.value = '代码已复制' }
    catch { feedback.value = '复制失败，请选择代码手动复制' }
  }
  if (target instanceof HTMLImageElement) {
    event.preventDefault()
    previewSrc.value = target.currentSrc || target.src
    previewAlt.value = target.alt
    preview.value?.showModal()
  }
}
const activeHeading = ref('')
let headingScrollUntil = 0
const { tocOpen, desktopOpen, isMobile, tocElement, toggleToc, closeMobileToc, syncMobileToc, backdropClick } = useArticleToc(activeHeading)
function goHeading(id: string) {
  closeMobileToc()
  headingScrollUntil = Date.now() + 900
  content.value?.querySelector<HTMLElement>(`#${id}`)?.scrollIntoView({ behavior: window.matchMedia('(prefers-reduced-motion: reduce)').matches ? 'instant' : 'smooth', block: 'start' })
  activeHeading.value = id
}
function updateHeading() {
  if (Date.now() < headingScrollUntil) return
  const headings = content.value?.querySelectorAll<HTMLElement>('h1,h2,h3,h4,h5,h6')
  let active = headings?.[0]?.id || ''
  const scrollPadding = parseFloat(getComputedStyle(document.documentElement).scrollPaddingTop) || 0
  headings?.forEach(heading => {
    const offset = (parseFloat(getComputedStyle(heading).scrollMarginTop) || 0) + scrollPadding
    if (heading.getBoundingClientRect().top <= offset + 1) active = heading.id
  })
  activeHeading.value = active
}
onMounted(() => {
  updateHeading()
  window.addEventListener('scroll', updateHeading, { passive: true })
  window.addEventListener('resize', updateHeading)
})
onBeforeUnmount(() => {
  window.removeEventListener('scroll', updateHeading)
  window.removeEventListener('resize', updateHeading)
  preview.value?.close()
})
</script>

<style scoped>
.column-reader{min-width:0}.column-article-title{font-size:clamp(24px,3vw,36px);overflow-wrap:anywhere}.column-article-tags,.column-article-meta{display:flex;flex-wrap:wrap;gap:12px;margin:16px 0}.column-article-tags{color:var(--primary)}.column-article-meta{font-size:13px}.article-content{margin-top:24px}
.column-reader{display:grid;grid-template-columns:minmax(0,1fr);gap:24px;align-items:start}.column-reader:not(.without-toc):has(.column-article-toc){grid-template-columns:minmax(0,1fr) minmax(180px,220px)}.column-reader>article{min-width:0;padding:20px}.column-article-title{margin-top:0}.column-toc-toggle{display:none}@media(max-width:767px){.column-reader:not(.without-toc):has(.column-article-toc){grid-template-columns:minmax(0,1fr)}.column-toc-toggle{display:none}.column-reader>article{padding:18px}}
@media(min-width:1100px){.column-reader:not(.without-toc):has(.column-article-toc){grid-template-columns:minmax(0,1fr) clamp(260px,calc(20vw + 40px),320px)}}
</style>
