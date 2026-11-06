<template>
  <div v-if="article" class="article-detail-page">
    <SiteBanner class="article-detail-hero">
      <h1 :aria-label="article.title">{{ displayedTitle }}</h1>
      <div class="article-detail-tags">
        <NuxtLink class="article-detail-badge" :to="related('categories', article.categoryId, article.categoryName)"><span class="article-detail-badge-label">分类</span>{{ article.categoryName }}</NuxtLink>
        <NuxtLink class="article-detail-badge" :to="related('tags', article.tagId, article.tagName)"><span class="article-detail-badge-label">技术标签</span>{{ article.tagName }}</NuxtLink>
        <span v-if="article.tagVersionName" class="article-detail-badge"><span class="article-detail-badge-label">版本</span>{{ article.tagVersionName }}</span>
      </div>
      <div class="article-detail-meta">
        <time><i><SiteIcon name="date" /></i>{{ formatDateTime(article.createTime) }}</time>
        <span><i><SiteIcon name="eye" /></i>{{ article.readNum }}</span>
        <span><i><SiteIcon name="article" /></i>{{ article.totalWords }} 字</span>
        <span><i>◷</i>{{ article.readTime }}</span>
      </div>
    </SiteBanner>
    <div class="article-detail-grid" :class="{ 'without-toc': !desktopOpen || !rendered.headings.length }">
      <div class="article-detail-main">
        <article class="panel">
          <div ref="content" class="article-content" @click="contentClick" v-html="rendered.html" />
          <p class="sr-only" role="status">{{ feedback }}</p>
          <p class="muted">最后编辑于 {{ formatDateTime(article.updateTime) }}</p>
          <section class="article-copyright"><strong>版权声明</strong><p>{{ settings?.copyrightDeclaration || '保留所有权利，转载请注明出处和本文链接。' }}</p><span>本文链接：</span><a :href="articleUrl">{{ articleUrl }}</a></section>
          <nav class="article-adjacent" aria-label="上下篇"><NuxtLink v-if="article.preArticle" :to="`/articles/${encodeURIComponent(article.preArticle.articleId)}`">上一篇<br>{{ article.preArticle.articleTitle }}</NuxtLink><NuxtLink v-if="article.nextArticle" :to="`/articles/${encodeURIComponent(article.nextArticle.articleId)}`">下一篇<br>{{ article.nextArticle.articleTitle }}</NuxtLink></nav>
        </article>
        <PublicComments :key="id" :path="`/blog/surfer/article/${id}`" source="article" />
      </div>
      <component :is="isMobile ? 'dialog' : 'aside'" v-if="rendered.headings.length" v-show="isMobile || desktopOpen" id="article-toc" ref="tocElement" data-article-toc class="article-toc panel" aria-label="文章目录" @close="syncMobileToc" @cancel.prevent="closeMobileToc" @click="backdropClick"><h2><SiteIcon name="menu" /> 文章目录<button type="button" class="toc-mobile-close" aria-label="关闭目录" @click="closeMobileToc">×</button></h2><div class="toc-wrapper"><a v-for="heading in tocHeadings" :key="heading.id" :href="`#${heading.id}`" :style="{ marginLeft: `${heading.indent * 1.25}rem`, fontSize: `${Math.max(.7, 1 - heading.indent * .08)}rem` }" :aria-current="activeHeading === heading.id ? 'location' : undefined" @click.prevent="goHeading(heading.id)">{{ heading.title }}</a></div></component>
    </div>
    <dialog ref="preview" class="article-preview" aria-label="文章图片预览" @click="($event.target === preview) && preview?.close()"><button autofocus @click="preview?.close()">关闭图片预览</button><img :src="previewSrc || undefined" :alt="previewAlt"></dialog>
  </div>
</template>

<script setup lang="ts">
import { renderArticleMarkdown } from '~/utils/markdown'
import type { SelectionView } from '~/composables/usePublicContent'
definePageMeta({ key: route => route.params.id as string })
interface ArticleDetail extends SelectionView {
  id: string; title: string; summary: string; content: string; createTime: string; updateTime: string
  readNum: string; totalWords: number; readTime: string
  preArticle?: { articleId: string; articleTitle: string }; nextArticle?: { articleId: string; articleTitle: string }
}
const route = useRoute()
const id = String(route.params.id)
if (!/^\d+$/.test(id) || BigInt(id) > 9223372036854775807n) throw createError({ statusCode: 404, statusMessage: '文章不存在' })
const api = usePublicApi()
const { data: article, error } = await useAsyncData(`article-${id}`, async () => {
  const result = await api<{ success: boolean; data?: ArticleDetail; errorCode?: string }>('article/detail', { method: 'POST', body: { articleId: id } })
  if (!result.success || !result.data) throw createError({ statusCode: result.errorCode === '20010' ? 404 : 502, statusMessage: result.errorCode === '20010' ? '文章不存在' : '文章暂时无法加载' })
  return result.data
})
if (error.value) throw createError({ statusCode: error.value.statusCode === 404 ? 404 : 502, statusMessage: error.value.statusCode === 404 ? '文章不存在' : '文章暂时无法加载', fatal: true })
const { data: settings } = await useSiteSettings()
const rendered = computed(() => renderArticleMarkdown(article.value?.content || ''))
const related = (kind: string, value: string, name: string) => ({ path: `/${kind}`, query: { id: value, name } })
const formatDateTime = (value: string) => new Intl.DateTimeFormat('sv-SE', { timeZone: 'Asia/Shanghai', year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit', hourCycle: 'h23' }).format(new Date(value))
const currentUrl = useRequestURL()
const articleUrl = new URL(`/articles/${id}`, useRuntimeConfig().public.siteUrl || currentUrl.origin).href
useSeoMeta({ title: () => article.value?.title, description: () => article.value?.summary || article.value?.content.slice(0, 160), ogTitle: () => article.value?.title, ogDescription: () => article.value?.summary })
useHead({ link: [{ rel: 'canonical', href: articleUrl }] })
const content = ref<HTMLElement>()
const preview = ref<HTMLDialogElement>()
const previewSrc = ref('')
const previewAlt = ref('')
const activeHeading = ref('')
let headingScrollUntil = 0
const { desktopOpen, isMobile, tocElement, closeMobileToc, syncMobileToc, backdropClick } = useArticleToc(activeHeading)
const tocHeadings = computed(() => {
  const levels: number[] = []
  return rendered.value.headings.map(heading => {
    while (levels.length && levels[levels.length - 1]! >= heading.level) levels.pop()
    const indent = levels.length
    levels.push(heading.level)
    return { ...heading, indent }
  })
})
const feedback = ref('')
const displayedTitle = ref(article.value?.title || '')
let titleTimer: ReturnType<typeof setInterval> | undefined
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
function goHeading(id: string) {
  closeMobileToc()
  headingScrollUntil = Date.now() + 900
  document.getElementById(id)?.scrollIntoView({ behavior: window.matchMedia('(prefers-reduced-motion: reduce)').matches ? 'instant' : 'smooth', block: 'start' })
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
  if (!window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
    const letters = Array.from(article.value?.title || '')
    let position = 0
    displayedTitle.value = ''
    titleTimer = setInterval(() => { displayedTitle.value = letters.slice(0, ++position).join(''); if (position >= letters.length) clearInterval(titleTimer) }, 80)
  }
  updateHeading(); window.addEventListener('scroll', updateHeading, { passive: true }); window.addEventListener('resize', updateHeading) })
onBeforeUnmount(() => { clearInterval(titleTimer); window.removeEventListener('scroll', updateHeading); window.removeEventListener('resize', updateHeading); preview.value?.close() })
</script>

<style scoped>
.article-detail-hero h1 { display: -webkit-box; -webkit-box-orient: vertical; -webkit-line-clamp: 2; overflow: hidden; }
.article-detail-tags { align-items: center; }
.article-detail-tags .article-detail-badge { display: inline-flex; align-items: center; gap: 8px; padding: 4px 12px; border-radius: 99px; background: #ffffff24; box-shadow: inset 0 0 0 1px #ffffff40; color: #fff; font-weight: 600; font-variant-numeric: tabular-nums; overflow-wrap: anywhere; }
.article-detail-badge-label { flex-shrink: 0; padding-right: 8px; border-right: 1px solid #ffffff50; font-size: 12px; font-weight: 400; opacity: .8; }
.article-detail-meta > span:nth-of-type(1) i { background: #f59e0b; }
.article-detail-meta > span:nth-of-type(2) i { background: #a543e6; }
.article-detail-meta > span:nth-of-type(3) i { background: #5a9cf8; }
@media (max-width: 767px) {
  .article-detail-hero :deep(.banner-content) { transform: translateY(-10px); }
}
@media (max-width: 639px) {
  .article-detail-tags { margin-top: 10px; }
  .article-detail-tags .article-detail-badge { padding: 2px 5px; gap: 4px; }
  .article-detail-badge-label { padding-right: 3px; }
}
</style>
