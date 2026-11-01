<template>
  <aside class="site-overview-cards" :aria-label="text('博客内容概览', 'Blog overview')">
    <section class="side-card author-card"><img class="author-avatar" :src="assetUrl(settings?.avatar) || defaultAvatar" alt="" width="80" height="80"><h2>{{ settings?.author || 'Mint Blog' }}</h2><p>{{ settings?.introduction }}</p><div class="author-counts"><div v-for="count in counts" :key="count[0]"><strong>{{ count[1] }}</strong><span>{{ count[0] }}</span></div></div></section>
    <section v-if="socials.length" class="side-card social-card">
      <h3>{{ text('社交', 'Social') }}</h3>
      <div class="social-icons">
        <span v-for="item in socials" :key="item.label" class="social-item">
          <a :href="assetUrl(item.url)" :aria-label="item.label" target="_blank" rel="noopener noreferrer">
            <svg v-if="item.label === 'GitHub'" class="github-icon" viewBox="64 64 896 896" fill="currentColor" aria-hidden="true">
              <path d="M511.6 76.3C264.3 76.2 64 276.4 64 523.5 64 718.9 189.3 885 363.8 946c23.5 5.9 19.9-10.8 19.9-22.2v-77.5c-135.7 15.9-141.2-73.9-150.3-88.9C215 726 171.5 718 184.5 703c30.9-15.9 62.4 4 98.9 57.9 26.4 39.1 77.9 32.5 104 26 5.7-23.5 17.9-44.5 34.7-60.8-140.6-25.2-199.2-111-199.2-213 0-49.5 16.3-95 48.3-131.7-20.4-60.5 1.9-112.3 4.9-120 58.1-5.2 118.5 41.6 123.2 45.3 33-8.9 70.7-13.6 112.9-13.6 42.4 0 80.2 4.9 113.5 13.9 11.3-8.6 67.3-48.8 121.3-43.9 2.9 7.7 24.7 58.3 5.5 118 32.4 36.8 48.9 82.7 48.9 132.3 0 102.2-59 188.1-200 212.9 23.5 23.2 38.1 55.4 38.1 91v112.5c0.8 9 0 17.9 15 17.9 177.1-59.7 304.6-227 304.6-424.1 0-247.2-200.4-447.3-447.5-447.3z" />
            </svg>
            <img v-else :src="item.image" alt="" width="30" height="30">
          </a>
          <span class="social-tooltip" aria-hidden="true">{{ item.label === 'Douyin' ? text('抖音', 'Douyin') : item.label }}</span>
        </span>
        <span v-for="item in qrCodes" :key="item.code" class="social-item">
          <button :aria-label="item.label" @click="openQr(item)"><img :src="item.image" alt="" width="30" height="30"></button>
          <span class="social-tooltip" aria-hidden="true">{{ item.label }}</span>
        </span>
      </div>
    </section>
    <dialog ref="qrDialog" class="qr-dialog" @click="($event.target === qrDialog) && qrDialog?.close()"><h3>{{ qr?.label }}</h3><img v-if="qr" :src="qr.code" :alt="qr.label"><button @click="qrDialog?.close()">{{ text('关闭', 'Close') }}</button></dialog>
    <section v-if="error" class="side-card" role="alert">{{ text('内容概览加载失败', 'Could not load content overview') }} <button @click="refresh()">{{ text('重试', 'Retry') }}</button></section>
    <section v-for="group in groups" :key="group.path" class="side-card"><h3>{{ group.title }}</h3><div class="content-pills" :class="{ 'column-list': group.path === '/columns', 'is-expanded': expanded[group.path] }"><NuxtLink v-for="entry in group.values" :key="entry.id" :to="entryUrl(group.path, entry)"><img v-if="group.path === '/columns' && assetUrl(entry.cover)" :src="assetUrl(entry.cover)" alt="" width="36" height="36" @error="columnCoverError"><span>{{ entry.name || entry.title }}</span><small>{{ entry.articlesTotal || 0 }}</small><em v-if="group.path === '/columns' && entry.isTop" class="column-pinned">{{ text('置顶', 'Pinned') }}</em></NuxtLink></div><button v-if="group.values.length > group.limit" class="side-more" @click="expanded[group.path] = !expanded[group.path]">{{ expanded[group.path] ? text('收起', 'Collapse') : text('展开全部', 'Show all') }}</button><p v-if="!group.values.length && !error">{{ text('暂无内容', 'No content yet') }}</p></section>
  </aside>
</template>

<script setup lang="ts">
import type { SiteSettings } from '~/composables/useSiteSettings'
import { columnReadingId } from '~/utils/columnReading'
import githubIcon from '~/assets/icons/github.svg'
import giteeIcon from '~/assets/icons/GitEE.svg'
import csdnIcon from '~/assets/icons/CSDN.svg'
import douyinIcon from '~/assets/icons/douyin.svg'
import wechatOfficialAccountIcon from '~/assets/icons/wechat-official-account.svg'
import wechatIcon from '~/assets/icons/wechat.svg'
import sponsorIcon from '~/assets/icons/sponsor.svg'
import wechatOfficialAccountQrCode from '~/assets/qrcodes/wechat-official-account.jpg'
import weixinGroupQrCode from '~/assets/qrcodes/WeixinGroup.jpg'
import weixinSponsorQrCode from '~/assets/qrcodes/WeixinSponsor.jpg'
import defaultAvatar from '~/assets/images/avatar.svg'
import defaultArticleCover from '~/assets/images/article-default-1.jpeg'
const { text } = useSitePreferences()
const api = usePublicApi()
const assetUrl = useAssetUrl()
const { data: statistics } = await usePublicStatistics()
type Entry = { id: string; name?: string; title?: string; articlesTotal?: number; cover?: string; isTop?: boolean; weight?: number; sort?: number; firstArticleId?: string }
const props = defineProps<{ settings?: SiteSettings | null }>()
const socials = computed(() => [
  { label: 'GitHub', url: props.settings?.githubHomepage, image: githubIcon },
  { label: 'Gitee', url: props.settings?.giteeHomepage, image: giteeIcon },
  { label: 'CSDN', url: props.settings?.csdnHomepage, image: csdnIcon },
  { label: 'Douyin', url: props.settings?.douyinHomepage, image: douyinIcon }
].filter(item => assetUrl(item.url)))
const qrCodes = [
  { label: '微信公众号', image: wechatOfficialAccountIcon, code: wechatOfficialAccountQrCode },
  { label: '微信', image: wechatIcon, code: weixinGroupQrCode },
  { label: '打赏', image: sponsorIcon, code: weixinSponsorQrCode }
]
const qr = ref<(typeof qrCodes)[number]>()
const qrDialog = ref<HTMLDialogElement>()
const openQr = (item: (typeof qrCodes)[number]) => { qr.value = item; qrDialog.value?.showModal() }
const { data: lists, error, refresh } = await useAsyncData('site-overview-cards', async () => {
  const results = await Promise.all(['category', 'tag', 'column'].map(path => api<{ success: boolean; data: Entry[] }>(path)))
  if (results.some(result => !result.success || !Array.isArray(result.data))) throw new Error('Content cards unavailable')
  return results.map((result, index) => [...result.data].sort((a, b) =>
    (index === 2 ? (b.weight || 0) - (a.weight || 0) || (b.sort || 0) - (a.sort || 0) : (b.articlesTotal || 0) - (a.articlesTotal || 0)) || a.id.length - b.id.length || a.id.localeCompare(b.id)
  ))
})
const groups = computed(() => [
  { title: text('分类', 'Categories'), path: '/categories', values: lists.value?.[0] || [], limit: 8 },
  { title: text('标签', 'Tags'), path: '/tags', values: lists.value?.[1] || [], limit: 12 },
  { title: text('专栏', 'Columns'), path: '/columns', values: lists.value?.[2] || [], limit: 5 }
])
const entryUrl = (path: string, entry: Entry) => {
  const articleId = columnReadingId(entry.firstArticleId)
  return path === '/columns'
    ? `/columns/${encodeURIComponent(entry.id)}${articleId ? '?' + new URLSearchParams({ articleId }) : ''}`
    : path + '?' + new URLSearchParams({ id: entry.id, name: entry.name || entry.title || '' })
}
const columnCoverError = (event: Event) => {
  const image = event.target as HTMLImageElement
  if (image.src !== new URL(defaultArticleCover, document.baseURI).href) image.src = defaultArticleCover
}
onMounted(() => {
  document.querySelectorAll<HTMLImageElement>('.content-pills img').forEach(image => {
    if (image.complete && !image.naturalWidth && image.src !== new URL(defaultArticleCover, document.baseURI).href) image.src = defaultArticleCover
  })
})
const expanded = ref<Record<string, boolean>>({})
const counts = computed(() => statistics.value ? [
  [text('专栏', 'Columns'), statistics.value.columnTotalCount], [text('文章', 'Articles'), statistics.value.articleTotalCount],
  [text('分类', 'Categories'), statistics.value.categoryTotalCount], [text('标签', 'Tags'), statistics.value.tagTotalCount], [text('访问', 'Views'), statistics.value.pvTotalCount]
] : [])
</script>

<style scoped>
.site-overview-cards { display: grid; align-content: start; gap: 16px; min-width: 0; --card-accent: #3ecf9a; --card-tint: #3ecf9a1a; --card-hover-border: #3ecf9a66; }
.side-card { min-width: 0; border: 1px solid #3ecf9a26; border-radius: 24px; background: #ffffffe0; box-shadow: 0 18px 52px #3ecf9a1a; backdrop-filter: blur(16px); padding: 20px; transition: transform .3s,border-color .3s,box-shadow .3s; }
.side-card h3 { margin: 0 0 12px; font-size: 14px; font-weight: 900; color: #0d3d2d; }
.author-card { text-align: center; }
.author-avatar { display: block; margin: auto; border: 3px solid #ffffffe6; border-radius: 52% 48% 46% 54% / 48% 52% 48% 52%; object-fit: cover; box-shadow: 0 0 0 6px #539dfd1a,0 12px 34px #539dfd33,0 0 42px #539dfd2e; animation: author-float 4s ease-in-out infinite,author-glow 2.8s ease-in-out infinite alternate,brand-morph 7s ease-in-out infinite; transition: transform .3s,box-shadow .3s,border-color .3s; }
.author-card h2 { margin: 12px 0 8px; font-size: 20px; font-weight: 900; color: #0d3d2d; overflow-wrap: anywhere; }
.author-card p { margin: 8px 0 0; color: #60786e; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; overflow-wrap: anywhere; }
.author-counts { display: grid; grid-template-columns: repeat(5,minmax(0,1fr)); gap: 6px; margin-top: 20px; }
.author-counts strong,.author-counts span { display: block; overflow-wrap: anywhere; }
.author-counts > div { min-width: 0; min-height: 58px; padding: 10px 4px; border-radius: 16px; background: var(--card-tint); }
.author-counts strong { font: 900 14px/1 monospace; font-variant-numeric: tabular-nums; color: var(--card-accent); }
.author-counts span { margin-top: 4px; font-size: 11px; line-height: 1; color: #60786e; }
.social-card { position: relative; z-index: 1; }
.social-icons { display: flex; flex-wrap: wrap; justify-content: center; gap: 12px; align-items: center; }
.social-item { position: relative; display: inline-flex; }
.github-icon { display: block; width: 30px; height: 30px; color: #181717; transition: color .2s; }
[data-theme="dark"] .github-icon { color: #ffffff; }
.social-icons a:is(:hover,:focus-visible) .github-icon { color: var(--card-accent); }
.social-tooltip { position: absolute; z-index: 2; top: calc(100% + 8px); left: 50%; transform: translateX(-50%); padding: 6px 9px; border-radius: 6px; background: #172b23; color: white; font-size: 12px; line-height: 1.5; white-space: nowrap; pointer-events: none; visibility: hidden; opacity: 0; transition: opacity .15s; }
.social-tooltip::before { content: ''; position: absolute; bottom: 100%; left: calc(50% - 4px); border: 4px solid transparent; border-bottom-color: #172b23; }
.social-item:hover .social-tooltip,.social-item:focus-within .social-tooltip { visibility: visible; opacity: 1; }
.social-icons a,.social-icons button { display: inline-flex; align-items: center; justify-content: center; flex-shrink: 0; border: 0; background: transparent; padding: 0; line-height: 0; color: #557468; transition: color .2s,opacity .2s; }
.social-icons img { display: block; opacity: .85; transition: opacity .2s; }
.qr-dialog { border: 0; border-radius: 16px; background: var(--surface); color: var(--text); max-width: min(400px,90vw); text-align: center; }
.qr-dialog::backdrop { background: #0007; }
.qr-dialog > img { display: block; max-width: 100%; max-height: 65vh; margin-bottom: 16px; }
.content-pills { display: flex; flex-wrap: wrap; align-content: start; gap: 8px; max-height: 160px; overflow-y: auto; scrollbar-width: thin; scrollbar-color: var(--card-accent) transparent; padding: 3px; }
.content-pills.column-list { max-height: 266px; }
.content-pills.is-expanded { max-height: 480px; }
.column-pinned { flex-shrink: 0; color: #ef4444; font-size: 12px; font-style: normal; font-weight: 400; }
[data-theme="dark"] .column-pinned { color: #f87171; }
.content-pills a { display: inline-flex; align-items: center; gap: 6px; min-width: 0; max-width: 100%; border-radius: 999px; padding: 5px 10px; color: var(--card-accent); background: var(--card-tint); font-size: 12px; font-weight: 700; transition: background .2s,color .2s; }
.content-pills a > span { min-width: 0; max-width: 140px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.content-pills small { flex-shrink: 0; border-radius: 999px; padding: 1px 6px; background: #15956b1f; color: #1ab782; font-size: 11px; font-weight: 900; line-height: 1.4; }
.content-pills img { flex-shrink: 0; object-fit: cover; border-radius: 12px; }
.column-list { display: grid; gap: 0; }
.column-list a { width: 100%; gap: 10px; border-radius: 14px; padding: 8px; color: #60786e; background: transparent; font-size: 13px; }
.column-list a > span { flex: 1; max-width: none; }
.side-more { width: 100%; border: 1px solid #3ecf9a24; border-radius: 999px; padding: 7px 10px; background: #3ecf9a14; color: #15956b; margin-top: 12px; font-size: 12px; font-weight: 800; transition: background .2s,color .2s,transform .2s; }
.site-overview-cards :is(a,button):focus-visible { outline: 2px solid var(--card-accent); outline-offset: 3px; }
.content-pills a:focus-visible { background: var(--card-tint); text-decoration: none; }
.social-icons :is(a,button):focus-visible img { opacity: 1; }
[data-theme="dark"] .site-overview-cards { --card-accent: #539dfd; --card-tint: #539dfd14; --card-hover-border: #539dfd66; }
[data-theme="dark"] .side-card { background: #2c333eb8; border-color: #334155; box-shadow: 0 18px 52px #539dfd14; }
[data-theme="dark"] .side-card h3 { color: #cbd5e1; }
[data-theme="dark"] .author-card h2 { color: white; }
[data-theme="dark"] :is(.author-card p,.author-counts span,.column-list a,.social-icons a,.social-icons button) { color: #cbd5e1; }
[data-theme="dark"] .author-avatar { border-color: #94beff38; }
[data-theme="dark"] .content-pills small { background: #539dfd1f; color: #8cc8ff; }
[data-theme="dark"] .side-more { border-color: #539dfd2e; background: #539dfd14; color: #8cc8ff; }
@media (hover: hover) and (pointer: fine) {
  .side-card:hover { transform: translateY(-4px); border-color: var(--card-hover-border); box-shadow: 0 24px 60px #3ecf9a29; }
  .author-avatar:hover { animation: none; border-radius: 48% 52% 55% 45% / 53% 46% 54% 47%; transform: translateY(-4px) scale(1.08) rotate(3deg); box-shadow: 0 0 0 8px #539dfd24,0 16px 44px #539dfd47,0 0 56px #539dfd42; }
  .social-icons :is(a,button):hover { color: var(--card-accent); }
  .social-icons :is(a,button):hover img { opacity: 1; }
  .content-pills a:hover { text-decoration: none; }
  .column-list a:hover { background: var(--card-tint); }
  .side-more:hover { background: #3ecf9a24; transform: translateY(-1px); }
  [data-theme="dark"] .side-card:hover { box-shadow: 0 24px 60px #539dfd24; }
  [data-theme="dark"] .side-more:hover { background: #539dfd24; }
}
@keyframes author-float { 0%,100% { transform: translateY(0); } 50% { transform: translateY(-7px); } }
@keyframes author-glow { from { box-shadow: 0 0 0 5px #539dfd14,0 10px 30px #539dfd29,0 0 32px #539dfd24; } to { box-shadow: 0 0 0 8px #539dfd24,0 16px 44px #539dfd42,0 0 54px #539dfd3d; } }
@media (min-width: 1024px) { .site-overview-cards { position: sticky; top: 85px; } }
@media (prefers-reduced-motion: reduce) { .side-card:hover,.author-avatar:hover,.side-more:hover { transform: none; } }
</style>
