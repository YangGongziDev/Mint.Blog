<template>
  <div class="friends-page">
    <SiteBanner class="friends-hero">
      <h1>{{ text('友情链接', 'Friends') }}</h1>
      <p class="hero-description">{{ text('这里收录了一些优秀的技术博客和网站，欢迎互相学习交流。', 'Discover excellent blogs and websites. Learn and share together.') }}</p>
      <div class="hero-actions">
        <button type="button" @click="copyFeedback = ''; infoDialog?.showModal()">{{ text('本站信息', 'Site information') }}</button>
        <button type="button" class="primary" @click="applicationFeedback = ''; applicationDialog?.showModal()">{{ text('提交友链', 'Apply for a link') }}</button>
      </div>
      <p class="hero-stats">{{ friends.length }} {{ text('个站点', 'sites') }} · {{ Math.max(0, categories.length - 2) }} {{ text('个分类', 'categories') }}<span v-if="listing?.example"> · {{ text('示例数据', 'Example data') }}</span></p>
    </SiteBanner>
    <div class="friends-content" :aria-busy="status === 'pending'">
      <p v-if="listing?.example" class="example-notice" role="status">{{ text('公开友链接口暂不可用，以下为示例数据，并非本站实际收录或审核结果。', 'The public API is unavailable. These are examples, not actual listings or review results.') }} <button type="button" :disabled="status === 'pending'" @click="refresh()">{{ text('重新加载', 'Retry') }}</button></p>
      <p v-if="feedback" class="feedback" role="status">{{ feedback }}</p>
      <div class="category-bar">
        <button type="button" class="category-toggle" :aria-expanded="expanded" aria-controls="friends-categories" @click="expanded = !expanded">{{ expanded ? text('收起筛选', 'Collapse filters') : text('展开筛选', 'Expand filters') }}</button>
        <nav id="friends-categories" class="category-list" :class="{ expanded }" :aria-label="text('友链分类', 'Friend categories')">
          <button v-for="category in categories" :key="category.key" type="button" :aria-pressed="activeCategory === category.key" @click="activeCategory = category.key">{{ category.label }} <span>{{ count(category.key) }}</span></button>
        </nav>
      </div>
      <p v-if="status === 'pending'" role="status">{{ text('正在加载友链…', 'Loading friends…') }}</p>
      <template v-else-if="groups.length">
        <section v-for="group in groups" :key="group.key" class="friend-group">
          <header><div><h2>{{ group.title }}</h2><p>{{ text('共', '') }} {{ group.items.length }} {{ text('个站点', 'sites') }}</p></div><hr></header>
          <div class="friend-grid">
            <component :is="friend.status === 'active' && httpUrl(friend.url) ? 'a' : 'article'" v-for="friend in group.items" :key="friend.id" class="friend-card" :class="friend.status" :href="friend.status === 'active' ? httpUrl(friend.url) : undefined" :target="friend.status === 'active' ? '_blank' : undefined" :rel="friend.status === 'active' ? 'noopener noreferrer' : undefined">
              <span v-if="friend.status === 'active' && friend.isTop" class="pinned">{{ text('置顶', 'Pinned') }}</span>
              <div class="friend-heading"><img :src="assetUrl(friend.avatar) || fallbackAvatar" :alt="friend.name" width="48" height="48" loading="lazy" @error="imageError"><div><h3>{{ friend.name }}</h3><span class="badge" :data-category="friend.category">{{ labels[friend.category] || friend.category || text('未分类', 'Uncategorized') }}</span><span v-if="friend.status !== 'active'" class="badge">{{ friend.status === 'pending' ? text('待审核', 'Pending review') : text('已停用', 'Inactive') }}</span></div></div>
              <template v-if="friend.status === 'active'"><p class="friend-description">{{ friend.description }}</p><span v-if="httpUrl(friend.url)" class="visit">{{ text('访问', 'Visit') }} {{ hostname(friend.url) }} ↗</span></template>
            </component>
          </div>
        </section>
      </template>
      <div v-else class="empty"><h2>{{ text('暂无友链', 'No friends yet') }}</h2><p>{{ text('还没有添加任何友情链接', 'No links in this category yet.') }}</p></div>
    </div>
    <dialog ref="infoDialog" class="friend-dialog" aria-labelledby="friend-info-title">
      <header><h2 id="friend-info-title">{{ text('本站信息', 'Site information') }}</h2><button type="button" :aria-label="text('关闭', 'Close')" @click="infoDialog?.close()">×</button></header>
      <img class="site-avatar" :src="assetUrl(settings?.avatar || settings?.logo) || fallbackAvatar" alt="" width="64" height="64" @error="imageError">
      <h3 class="site-name">{{ settings?.name || 'Mint Blog' }}</h3>
      <dl><div v-for="item in siteInfo" :key="item.label"><dt>{{ item.label }}</dt><dd>{{ item.value }}</dd><button type="button" @click="copy(item.value)">{{ text('复制', 'Copy') }}</button></div></dl>
      <div class="info-actions">
        <button type="button" class="primary" @click="copy(rssUrl, text('RSS链接复制成功', 'RSS link copied successfully'))">订阅RSS(推荐)</button>
        <button type="button" class="primary" @click="copy(siteInfo.map(item => `${item.label}：${item.value}`).join('\n'), text('友链文本信息复制成功', 'Friend link information copied successfully'))">{{ text('复制文本信息', 'Copy all information') }}</button>
      </div>
      <p role="status">{{ copyFeedback }}</p>
    </dialog>
    <dialog ref="applicationDialog" class="friend-dialog application-dialog" aria-labelledby="friend-apply-title" @cancel.prevent="closeApplication" @close="cancelFeed">
      <header><h2 id="friend-apply-title">{{ text('友链申请', 'Friend application') }}</h2><button type="button" :disabled="submitting" :aria-label="text('关闭', 'Close')" @click="closeApplication">×</button></header>
      <p>{{ text('欢迎优质的技术博客交换友链！提交后需等待审核。', 'Quality technology blogs are welcome! Applications require review.') }}</p>
      <ul class="requirements"><li>{{ text('技术相关的原创博客', 'Original technology-related blog') }}</li><li>{{ text('内容质量较高，更新频率稳定', 'Quality content and regular updates') }}</li><li>{{ text('网站访问正常，无违法内容', 'Accessible website without illegal content') }}</li></ul>
      <form novalidate @submit.prevent="submitApplication">
        <fieldset :disabled="submitting">
          <div class="form-field"><label for="friend-feed">{{ text('RSS订阅链接（推荐，支持 RSS / Atom）', 'RSS / Atom URL (optional)') }}</label><input id="friend-feed" v-model="feedUrl" type="url" maxlength="1000" aria-describedby="friend-feed-status" @input="feedInput"><p id="friend-feed-status" role="status">{{ feedStatus || text('填写后自动解析；分类和邮箱需手动填写，未获取的信息会保留原值。', 'Auto-fills available details; category and email must be entered manually. Other fields are preserved.') }}</p></div>
          <div v-for="field in fields" :key="field" class="form-field">
            <label :for="`friend-${field}`">{{ fieldLabels[field] }}<span v-if="field !== 'email'"> *</span><small v-if="field === 'description'"> ({{ form.description.length }}/200)</small></label>
            <select v-if="field === 'category'" :id="`friend-${field}`" v-model="form.category" required :aria-invalid="!!errors[field]" :aria-describedby="`friend-${field}-error`" @blur="validate(field)" @change="errors[field] = ''"><option value="" disabled>{{ text('请选择网站分类', 'Select a category') }}</option><option v-for="(label, key) in labels" :key="key" :value="key">{{ label }}</option></select>
            <textarea v-else-if="field === 'description'" :id="`friend-${field}`" v-model="form[field]" required rows="3" maxlength="200" :aria-invalid="!!errors[field]" :aria-describedby="`friend-${field}-error`" @blur="validate(field)" @input="errors[field] = ''" />
            <input v-else :id="`friend-${field}`" v-model="form[field]" :type="field === 'email' ? 'email' : ['avatar', 'url'].includes(field) ? 'url' : 'text'" :required="field !== 'email'" :aria-invalid="!!errors[field]" :aria-describedby="`friend-${field}-error`" @blur="validate(field)" @input="errors[field] = ''">
            <img v-if="field === 'avatar' && httpUrl(form.avatar) && !errors.avatar" :src="httpUrl(form.avatar)" :alt="text('图标预览', 'Icon preview')" width="32" height="32" @error="imageError">
            <p v-if="errors[field]" :id="`friend-${field}-error`" class="field-error">{{ errors[field] }}</p>
          </div>
        </fieldset>
        <p v-if="applicationFeedback" class="field-error" role="alert">{{ applicationFeedback }}</p>
        <footer><button type="button" :disabled="submitting" @click="closeApplication">{{ text('取消', 'Cancel') }}</button><button type="submit" class="primary" :disabled="submitting">{{ submitting ? text('提交中…', 'Submitting…') : text('提交申请', 'Submit application') }}</button></footer>
      </form>
    </dialog>
  </div>
</template>

<script setup lang="ts">
import fallbackAvatar from '~/assets/images/avatar.svg'

type Friend = { id: string | number; name: string; description?: string; url: string; avatar?: string; status?: string; createdAt?: string; createTime?: string; category?: string; isTop?: boolean; sort?: number; isDeleted?: boolean }
type Response<T> = { success: boolean; data: T; message?: string }
type Field = 'name' | 'avatar' | 'category' | 'url' | 'description' | 'email'
const api = usePublicApi()
const assetUrl = useAssetUrl()
const { text } = useSitePreferences()
const { data: settings } = await useSiteSettings()
const config = useRuntimeConfig()
const origin = useRequestURL().origin
const siteUrl = computed(() => config.public.siteUrl || origin)
const rssUrl = computed(() => new URL('/api/rss', siteUrl.value).href)
const siteInfo = computed(() => [
  { label: text('网站名称', 'Name'), value: settings.value?.name || 'Mint Blog' },
  { label: text('网站图标', 'Icon'), value: assetUrl(settings.value?.avatar || settings.value?.logo) || new URL(fallbackAvatar, siteUrl.value).href },
  { label: text('网站分类', 'Category'), value: text('技术类', 'Technology') },
  { label: text('网站网址', 'Website'), value: siteUrl.value },
  { label: text('网站描述', 'Description'), value: settings.value?.introduction || text('分享技术 · 记录生活', 'Share technology and life') }
])
const labels = computed<Record<string, string>>(() => ({ tech: text('技术类', 'Technology'), tools: text('工具类', 'Tools'), navigation: text('导航类', 'Navigation'), news: text('新闻类', 'News'), aggregate: text('聚合类', 'Aggregators'), life: text('生活类', 'Life'), mintblog: text('MintBlog优秀站点', 'MintBlog sites') }))
const mockFriends: Friend[] = [
  { id: 1, name: 'Hyde Blog', description: '一个轻量、简洁高效、灵活配置，易于扩展的 VitePress 主题', url: 'https://teek.seasir.top/friend-link', avatar: 'https://teek.seasir.top/avatar/avatar.webp', status: 'active', category: 'tech', isTop: true, createdAt: '2024-01-01', sort: 1 },
  { id: 2, name: 'Vue.js 官方文档', description: 'Vue.js 是一套用于构建用户界面的渐进式框架。', url: 'https://vuejs.org/', avatar: 'https://vuejs.org/logo.svg', status: 'active', category: 'tech', isTop: true, createdAt: '2024-01-02', sort: 2 },
  { id: 3, name: 'TypeScript 官方文档', description: 'TypeScript 是 JavaScript 的超集，为大型应用开发提供类型安全。', url: 'https://www.typescriptlang.org/', avatar: 'https://www.typescriptlang.org/favicon-32x32.png', status: 'active', category: 'tech', sort: 3 },
  { id: 4, name: '待审核友链（示例）', url: '', status: 'pending', category: 'tech', isTop: true, createdAt: '2024-01-04' },
  { id: 5, name: '停用友链（示例）', url: '', status: 'inactive', category: 'tech', sort: 5 },
  { id: 6, name: '另一个待审核友链（示例）', url: '', status: 'pending', category: 'life', createdAt: '2024-01-06' }
]
const { data: listing, status, refresh } = await useAsyncData('public-friends', async () => {
  try {
    const result = await api<Response<{ items: Friend[] }>>('friend', { query: { pageNumber: 1, pageSize: 100000 } })
    if (!result.success || !Array.isArray(result.data?.items)) throw new Error('Friends unavailable')
    return { items: result.data.items, example: false }
  } catch { return { items: mockFriends, example: true } }
})
const friends = computed(() => (listing.value?.items || []).filter(item => !item.isDeleted).map(item => ({ ...item, status: item.status || 'active', category: item.category || '' })))
const activeCategory = ref('all')
const expanded = ref(false)
const categories = computed(() => [
  { key: 'all', label: text('全部', 'All') }, { key: 'top', label: text('置顶', 'Pinned') },
  ...[...new Set(friends.value.map(item => item.category).filter(Boolean))].sort().map(key => ({ key, label: labels.value[key] || key }))
])
watch(categories, values => { if (!values.some(item => item.key === activeCategory.value)) activeCategory.value = 'all' })
const count = (key: string) => friends.value.filter(item => key === 'all' || (key === 'top' ? item.isTop && item.status === 'active' : item.category === key)).length
const idOrder = (a: Friend, b: Friend) => String(a.id).length - String(b.id).length || String(a.id).localeCompare(String(b.id))
const time = (item: Friend) => Date.parse(item.createTime || item.createdAt || '') || 0
const byTime = (a: Friend, b: Friend) => time(b) - time(a) || idOrder(a, b)
const bySort = (a: Friend, b: Friend) => (b.sort || 0) - (a.sort || 0) || idOrder(a, b)
const groups = computed(() => {
  const scoped = friends.value.filter(item => ['all', 'top'].includes(activeCategory.value) || item.category === activeCategory.value)
  const top = { key: 'top', title: text('置顶', 'Pinned'), items: scoped.filter(item => item.isTop && item.status === 'active').sort(byTime) }
  if (activeCategory.value === 'top') return top.items.length ? [top] : []
  return [top,
    { key: 'active', title: text('已确认', 'Confirmed'), items: scoped.filter(item => item.status === 'active' && !item.isTop).sort(bySort) },
    { key: 'pending', title: text('待审核', 'Pending review'), items: scoped.filter(item => item.status === 'pending').sort(byTime) },
    { key: 'inactive', title: text('已停用', 'Inactive'), items: scoped.filter(item => item.status === 'inactive').sort(bySort) }
  ].filter(group => group.items.length)
})
function httpUrl(value: string) {
  try { const url = new URL(value); return ['http:', 'https:'].includes(url.protocol) ? url.href : undefined } catch { return undefined }
}
function hostname(value: string) { try { return new URL(value).hostname } catch { return value } }
function imageError(event: Event) {
  const image = event.target as HTMLImageElement
  if (image.getAttribute('src') !== fallbackAvatar) image.src = fallbackAvatar
}
const infoDialog = ref<HTMLDialogElement>()
const applicationDialog = ref<HTMLDialogElement>()
const feedback = ref('')
const copyFeedback = ref('')
async function copy(value: string, successMessage = text('已复制到剪贴板', 'Copied to clipboard')) {
  try { await navigator.clipboard.writeText(value); copyFeedback.value = successMessage }
  catch { copyFeedback.value = text('复制失败，请选中文本手动复制', 'Copy failed. Select and copy the text manually.') }
}
const emptyForm = () => ({ name: '', avatar: '', category: '', url: '', description: '', email: '' })
const form = reactive(emptyForm())
const errors = reactive(emptyForm())
const fields: Field[] = ['name', 'avatar', 'category', 'url', 'description', 'email']
const fieldLabels = computed<Record<Field, string>>(() => ({ name: text('网站名称', 'Website name'), avatar: text('网站图标链接', 'Icon URL'), category: text('网站分类', 'Category'), url: text('网站网址', 'Website URL'), description: text('网站描述', 'Description'), email: text('联系邮箱（可选）', 'Email (optional)') }))
function validate(field: Field) {
  const value = form[field].trim()
  errors[field] = ''
  if (field !== 'email' && !value) errors[field] = text('请填写此项', 'This field is required')
  else if (['avatar', 'url'].includes(field) && !httpUrl(value)) errors[field] = text('请输入完整的 HTTP/HTTPS 地址', 'Enter a full HTTP/HTTPS URL')
  else if (field === 'category' && !Object.hasOwn(labels.value, value)) errors[field] = text('请选择有效分类', 'Select a valid category')
  else if (field === 'description' && (value.length < 10 || value.length > 200)) errors[field] = text('网站描述须为10至200个字符', 'Description must be 10–200 characters')
  else if (field === 'email' && value && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) errors[field] = text('请输入有效的邮箱地址', 'Enter a valid email address')
}
const feedUrl = ref('')
const feedStatus = ref('')
const submitting = ref(false)
const applicationFeedback = ref('')
let feedTimer: ReturnType<typeof setTimeout> | undefined
let revision = 0
function cancelFeed() { revision++; clearTimeout(feedTimer) }
function closeApplication() { if (!submitting.value) { cancelFeed(); applicationDialog.value?.close() } }
async function lookupFeed() {
  cancelFeed()
  const url = feedUrl.value.trim()
  if (!url) { feedStatus.value = ''; return }
  if (!httpUrl(url) || url.length > 1000) { feedStatus.value = text('订阅链接须为不超过1000个字符的 HTTP/HTTPS 地址', 'Feed must be an HTTP/HTTPS URL of at most 1000 characters'); return }
  const current = revision
  const original = { ...form }
  feedStatus.value = text('正在解析订阅源…', 'Reading feed…')
  try {
    const result = await api<Response<Partial<Record<Field, string>>>>('friend/feed', { query: { url } })
    if (current !== revision || submitting.value) return
    if (!result.success) { feedStatus.value = result.message || text('解析失败，请手动填写', 'Unable to read feed; enter details manually'); return }
    let filled = 0
    for (const field of ['name', 'avatar', 'url', 'description'] as const) {
      const value = result.data?.[field]?.trim()
      if (value && form[field] === original[field]) { form[field] = value; validate(field); filled++ }
    }
    feedStatus.value = filled ? text('已填充可获取的信息，请核对；分类和邮箱需手动填写。', 'Details filled. Verify them and enter category and email manually.') : text('未获取可填充信息或字段已修改，请手动补全。', 'No details available or fields changed. Complete them manually.')
  } catch {
    if (current === revision) feedStatus.value = text('无法解析订阅源，可手动填写，不影响申请。', 'Feed unavailable. You can still apply manually.')
  }
}
function feedInput() {
  cancelFeed()
  feedStatus.value = ''
  if (feedUrl.value.trim()) feedTimer = setTimeout(lookupFeed, 600)
}
async function submitApplication() {
  if (submitting.value) return
  fields.forEach(validate)
  applicationFeedback.value = ''
  const rssUrl = feedUrl.value.trim()
  if (rssUrl && (!httpUrl(rssUrl) || rssUrl.length > 1000)) {
    applicationFeedback.value = text('请修正 RSS 订阅链接，或留空后提交', 'Correct the feed URL or leave it blank'); return
  }
  if (fields.some(field => errors[field])) { applicationFeedback.value = text('请检查表单中的错误', 'Please correct the highlighted fields'); return }
  submitting.value = true
  cancelFeed()
  try {
    const body = Object.fromEntries(fields.map(field => [field, form[field].trim()]))
    const result = await api<Response<{ id: string | number }>>('friend', { method: 'POST', body: { ...body, rssUrl: rssUrl || null } })
    if (!result.success) { applicationFeedback.value = result.message || text('提交失败，请稍后重试', 'Submission failed. Try again later.'); return }
    Object.assign(form, emptyForm()); Object.assign(errors, emptyForm()); feedUrl.value = ''; feedStatus.value = ''
    applicationDialog.value?.close()
    feedback.value = text('友链申请提交成功！请等待审核，通过审核后才可访问。', 'Application submitted! Please wait for review before your link becomes accessible.')
    await refresh()
  } catch (error) {
    const failure = error as { statusCode?: number; data?: { message?: string; data?: { message?: string } } }
    applicationFeedback.value = failure.statusCode === 429 ? text('提交过于频繁，请稍后再试', 'Too many submissions. Try again later.') : failure.statusCode === 400 ? (failure.data?.data?.message || failure.data?.message || text('请求参数有误，请检查信息', 'Invalid request. Check the form.')) : failure.statusCode && failure.statusCode >= 500 ? text('服务器暂时不可用，请稍后重试', 'Server unavailable. Try again later.') : text('提交失败，请检查网络后重试；填写内容已保留。', 'Submission failed. Check your connection; your entries are preserved.')
  } finally { submitting.value = false }
}
onBeforeUnmount(cancelFeed)
useSeoMeta({ title: () => text('友情链接', 'Friends'), description: () => text('优秀的技术博客和网站，欢迎互相学习交流。', 'Discover blogs and websites, learn and share together.') })
</script>

<style scoped>
.friends-page { color: var(--text); }
:global(main:has(> .friends-page)) { padding: 0; }
.friends-hero { height: 400px; background-color: #203e47; }
.friends-hero h1 { font-size: 44px; margin: 0 0 10px; color: white; }
.hero-description { color: #ffffffe0; font-size: 16px; }
.hero-actions { display: flex; justify-content: center; flex-wrap: wrap; gap: 12px; margin-top: 22px; }
.hero-actions button { padding: 10px 22px; border: 0; border-radius: 24px; background: #ffffff30; color: white; font-weight: 600; backdrop-filter: blur(6px); }
button.primary { background: var(--primary); color: white; border-color: var(--primary); }
.hero-stats { margin-top: 18px; color: #ffffffe6; }
.friends-content { max-width: 1280px; margin: auto; padding: 0 24px 80px; }
.category-bar { position: sticky; top: 45px; z-index: 25; padding: 14px 0; background: color-mix(in srgb,var(--bg) 90%,transparent); backdrop-filter: blur(12px); }
.category-list { display: flex; flex-wrap: wrap; justify-content: center; gap: 8px; }
.category-list button { border-radius: 12px; padding: 5px 9px; }
.category-list button[aria-pressed="true"] { background: var(--primary); color: white; border-color: var(--primary); }
.category-list span { display: inline-block; margin-left: 6px; padding: 0 7px; border-radius: 15px; background: #8882; font-size: 12px; }
.category-toggle { display: none; }
.example-notice { border: 1px solid #b98a39; background: #d8aa2512; border-radius: 8px; padding: 12px; }
.feedback { padding: 12px; border: 1px solid var(--primary); border-radius: 8px; overflow-wrap: anywhere; }
.friend-group { margin: 12px 0 36px; }
.friend-group header { display: flex; align-items: center; gap: 20px; margin-bottom: 18px; }
.friend-group h2 { margin: 0; }.friend-group header p { margin: 4px 0 0; color: var(--muted); font-size: 13px; }
.friend-group hr { flex: 1; border: 0; border-top: 1px solid var(--border); }
.friend-grid { display: grid; grid-template-columns: repeat(4,minmax(0,1fr)); gap: 24px; }
.friend-card { position: relative; display: block; padding: 18px 16px; border: 1px solid var(--border); border-radius: 12px; background: var(--surface); color: var(--text); box-shadow: 0 2px 6px #00000008; transition: transform .2s,border-color .2s,box-shadow .2s; }
a.friend-card:hover { transform: translateY(-2px); border-color: var(--primary); box-shadow: 0 12px 30px color-mix(in srgb,var(--primary) 12%,transparent); text-decoration: none; }
.friend-card.pending { background: #f59e0b12; border-color: #f59e0b44; }.friend-card.inactive { opacity: .7; background: color-mix(in srgb,var(--text) 4%,var(--bg)); }
.friend-heading { display: flex; align-items: flex-start; gap: 14px; }.friend-heading img { flex-shrink: 0; border-radius: 50%; object-fit: cover; outline: 2px solid var(--border); }.friend-heading>div { min-width: 0; flex: 1; }.friend-heading h3 { font-size: 17px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; margin: 0 0 8px; padding-right: 24px; }
.badge { display: inline-block; border-radius: 12px; padding: 1px 7px; margin: 0 4px 3px 0; font-size: 11px; color: var(--muted); background: color-mix(in srgb,var(--text) 7%,transparent); }.badge[data-category="tech"] { color: #3888d8; background: #539dfd18; }.badge[data-category="mintblog"] { color: #b97924; background: #f59e0b18; }.badge[data-category="life"] { color: #269e73; background: #3ecf9a18; }
.pinned { position: absolute; top: 7px; right: 9px; font-size: 11px; color: #d85454; background: #ef444419; padding: 1px 6px; border-radius: 10px; }
.friend-description { font-size: 13px; color: var(--muted); display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; min-height: 40px; margin: 12px 0; }.visit { display: inline-block; max-width: 100%; overflow-wrap: anywhere; font-size: 11px; color: var(--primary); background: color-mix(in srgb,var(--primary) 9%,transparent); border-radius: 14px; padding: 2px 8px; }
.empty { text-align: center; padding: 70px 12px; color: var(--muted); }
.friend-dialog { width: min(500px,calc(100% - 24px)); max-height: 85vh; padding: 24px; border: 1px solid var(--border); border-radius: 12px; color: var(--text); background: var(--surface); overflow-y: auto; }.friend-dialog::backdrop { background: #0009; }.friend-dialog header { display: flex; justify-content: space-between; align-items: center; gap: 12px; margin-bottom: 18px; }.friend-dialog header h2 { margin: 0; }.friend-dialog header button { font-size: 20px; }.site-avatar { display: block; margin: auto; border-radius: 12px; object-fit: cover; }.site-name { text-align: center; }.friend-dialog dl>div { display: flex; flex-wrap: wrap; gap: 8px; padding: 12px; margin: 10px 0; border-radius: 8px; background: var(--bg); }.friend-dialog dt { font-weight: 600; }.friend-dialog dd { margin: 0; flex: 1; min-width: 100px; overflow-wrap: anywhere; white-space: pre-wrap; }.info-actions { display: grid; gap: 10px; }.friend-dialog button { padding: 6px 12px; }
.application-dialog { width: min(600px,calc(100% - 24px)); }.requirements { padding: 16px 16px 16px 32px; background: var(--bg); border-radius: 8px; color: var(--muted); }.form-field { margin: 16px 0; }.form-field label { display: block; margin-bottom: 6px; font-weight: 500; }.form-field small,.form-field>p { font-size: 12px; color: var(--muted); }.form-field input,.form-field textarea,.form-field select { width: 100%; padding: 9px 12px; border: 1px solid var(--border); border-radius: 8px; background: var(--bg); color: var(--text); font: inherit; }.form-field textarea { resize: vertical; }.form-field [aria-invalid="true"] { border-color: #dc5252; }.form-field>p.field-error,.field-error { color: #d54c4c; }.form-field>img { margin-top: 6px; object-fit: cover; border-radius: 6px; }fieldset { border: 0; margin: 0; padding: 0; min-width: 0; }.application-dialog footer { display: flex; justify-content: flex-end; gap: 12px; border-top: 1px solid var(--border); padding-top: 18px; }button:disabled { cursor: wait; opacity: .6; }
@media(max-width:1199px) { .friend-grid { grid-template-columns: repeat(3,minmax(0,1fr)); } }
@media(max-width:900px) { .friend-grid { grid-template-columns: repeat(2,minmax(0,1fr)); gap: 18px; } }
@media(max-width:767px) { .friends-hero { height: 240px; }.friends-hero h1 { font-size: 30px; }.hero-description { font-size: 13px; }.hero-actions { margin-top: 12px; }.friends-content { padding: 0 16px 60px; }.category-toggle { display: block; width: 100%; margin-bottom: 8px; color: var(--primary); border-color: color-mix(in srgb,var(--primary) 30%,transparent); }.category-list:not(.expanded) { display: none; } }
@media(max-width:639px) { .friends-hero { height: 153px; }.friends-hero h1,.hero-description { display: none; }.hero-stats { font-size: 12px; }.friend-grid { grid-template-columns: minmax(0,1fr); }.friend-dialog { padding: 18px; }.hero-actions button { padding: 8px 18px; } }
</style>
