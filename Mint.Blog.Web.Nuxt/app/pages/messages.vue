<template>
  <div class="messages-page">
    <header class="message-intro">
      <p class="eyebrow">Message Board</p>
      <h1>{{ text('留言板', 'Message Board') }}</h1>
      <p>{{ text('写下你的想法、建议或问候。每一条留言都会成为这个小站的一部分。', 'Share your thoughts, suggestions or greetings. Every message becomes part of this little site.') }}</p>
    </header>
    <div class="message-board-grid">
      <section ref="formPanel" class="message-panel message-form-panel" aria-labelledby="message-form-title">
        <h2 id="message-form-title">{{ text('留下足迹', 'Leave a message') }}</h2>
        <form novalidate @submit.prevent="submitMessage">
          <fieldset :disabled="submitting">
            <label for="message-nickname">{{ text('昵称', 'Nickname') }} *</label>
            <input id="message-nickname" v-model="form.nickname" name="nickname" autocomplete="nickname" required maxlength="50" :aria-invalid="!!errors.nickname" aria-describedby="message-nickname-error" @blur="validate('nickname')" @input="errors.nickname = ''">
            <p v-if="errors.nickname" id="message-nickname-error" class="field-error">{{ errors.nickname }}</p>
            <label for="message-email">{{ text('邮箱（可选，不公开）', 'Email (optional, private)') }}</label>
            <input id="message-email" v-model="form.email" name="email" type="email" autocomplete="email" maxlength="200" :aria-invalid="!!errors.email" aria-describedby="message-email-error" @blur="validate('email')" @input="errors.email = ''">
            <p v-if="errors.email" id="message-email-error" class="field-error">{{ errors.email }}</p>
            <label for="message-website">{{ text('网站（可选）', 'Website (optional)') }}</label>
            <input id="message-website" v-model="form.website" name="website" type="url" autocomplete="url" maxlength="500" placeholder="https://" :aria-invalid="!!errors.website" aria-describedby="message-website-error" @blur="validate('website')" @input="errors.website = ''">
            <p v-if="errors.website" id="message-website-error" class="field-error">{{ errors.website }}</p>
            <label for="message-content">{{ text('留言内容', 'Message') }} *</label>
            <textarea id="message-content" v-model="form.content" name="content" rows="5" required :placeholder="text('想说点什么…', 'What would you like to say…')" :aria-invalid="!!errors.content" aria-describedby="message-content-error" @blur="validate('content')" @input="errors.content = ''" />
            <p v-if="errors.content" id="message-content-error" class="field-error">{{ errors.content }}</p>
            <fieldset class="color-options">
              <legend>{{ text('选择便签颜色', 'Note color') }}</legend>
              <label v-for="color in colors" :key="color.value" class="color-option" :style="{ backgroundColor: color.value }" :title="color.name">
                <input v-model="form.color" type="radio" name="color" :value="color.value" :aria-label="color.name"><span aria-hidden="true">{{ form.color === color.value ? '✓' : '' }}</span>
              </label>
            </fieldset>
            <button class="submit-message" type="submit" :disabled="submitting">{{ submitting ? text('提交中…', 'Submitting…') : text('发布留言', 'Publish message') }}</button>
          </fieldset>
        </form>
        <p v-if="feedback" class="submission-feedback" :class="{ 'field-error': submissionFailed }" :role="submissionFailed ? 'alert' : 'status'">{{ feedback }}</p>
      </section>
      <section class="message-panel message-list-panel" :style="panelHeight ? { height: `${panelHeight}px` } : undefined" aria-labelledby="message-list-title" :aria-busy="status === 'pending'">
        <header class="message-list-header"><h2 id="message-list-title">{{ text('最新留言', 'Latest messages') }}</h2><span v-if="listing && !error">{{ text('共', 'Total') }} {{ listing.totalCount }} {{ text('条', 'messages') }}</span></header>
        <div class="message-list-scroll">
          <p v-if="status === 'pending'" role="status">{{ text('正在加载留言…', 'Loading messages…') }}</p>
          <p v-else-if="error" role="alert">{{ text('留言暂时无法加载，请稍后重试。', 'Messages unavailable. Please retry.') }} <button type="button" @click="refresh()">{{ text('重试', 'Retry') }}</button></p>
          <div v-else-if="listing?.items.length" class="message-notes">
            <article v-for="item in listing.items" :key="item.id" class="message-note" :style="{ backgroundColor: noteBackground(item.color) }">
              <header><h3>{{ item.nickname }}</h3><time :datetime="item.createdAt">{{ formatDate(item.createdAt) }}</time></header>
              <p>{{ item.content }}</p>
              <a v-if="safeWebsite(item.website)" :href="safeWebsite(item.website)" target="_blank" rel="nofollow noopener noreferrer">{{ text('访问主页', 'Visit website') }}</a>
            </article>
          </div>
          <p v-else class="empty-messages">{{ page > 1 ? text('此页暂无留言，可返回上一页。', 'No messages on this page. Go back a page.') : text('暂无留言，来发布第一条吧', 'No messages yet. Be the first!') }}</p>
        </div>
        <nav v-if="page > 1 || totalPages > 1" class="message-pagination" :aria-label="text('留言分页', 'Message pages')">
          <NuxtLink v-if="page > 1" :to="pageLink(page - 1)">{{ text('上一页', 'Previous') }}</NuxtLink>
          <span aria-current="page">{{ page }} / {{ totalPages }}</span>
          <NuxtLink v-if="page < totalPages" :to="pageLink(page + 1)">{{ text('下一页', 'Next') }}</NuxtLink>
        </nav>
      </section>
    </div>
  </div>
</template>

<script setup lang="ts">
type MessageItem = { id: string | number; nickname: string; website: string | null; content: string; color: string; createdAt: string }
type MessagePage = { items: MessageItem[]; pageNumber: number; pageSize: number; totalCount: number }
type ApiResponse<T> = { success: boolean; data: T; message?: string }
const api = usePublicApi()
const route = useRoute()
const router = useRouter()
const hash = ref('')
onMounted(() => { hash.value = route.hash })
watch(() => route.hash, value => { hash.value = value })
const { text } = useSitePreferences()
const pageSize = 12
const page = computed(() => {
  const value = route.query.page
  if (typeof value !== 'string' || !/^[1-9]\d*$/.test(value)) return 1
  const number = Number(value)
  return Number.isSafeInteger(number) && number <= Math.floor(2147483647 / pageSize) ? number : 1
})
const { data: listing, error, status, refresh } = await useAsyncData(
  () => `public-messages-${page.value}`,
  async () => {
    const result = await api<ApiResponse<MessagePage>>('message/list', { method: 'POST', body: { PageNumber: page.value, PageSize: pageSize } })
    if (!result.success || !Array.isArray(result.data?.items)) throw new Error('留言加载失败')
    return result.data
  }
)
const totalPages = computed(() => Math.max(1, Math.ceil((listing.value?.totalCount || 0) / pageSize)))
function pageLink(number: number) {
  return { path: route.path, query: { ...route.query, page: number > 1 ? String(number) : undefined }, hash: hash.value }
}
function safeWebsite(value: string | null) {
  try { const url = new URL(value || ''); return ['http:', 'https:'].includes(url.protocol) ? url.href : undefined }
  catch { return undefined }
}
function noteBackground(color: string) { return `${/^#[\da-f]{6}$/i.test(color) ? color : '#3ecf9a'}18` }
function formatDate(value: string) {
  const date = new Date(value)
  return Number.isNaN(date.getTime()) ? '' : new Intl.DateTimeFormat('zh-CN', { year: 'numeric', month: '2-digit', day: '2-digit', timeZone: 'Asia/Shanghai' }).format(date)
}
const colors = [
  { value: '#3ecf9a', name: '薄荷绿' }, { value: '#539dfd', name: '天空蓝' },
  { value: '#f59e0b', name: '琥珀黄' }, { value: '#ef4444', name: '珊瑚红' },
  { value: '#a855f7', name: '紫罗兰' }, { value: '#14b8a6', name: '青绿色' }
]
const emptyForm = () => ({ nickname: '', email: '', website: '', content: '', color: '#3ecf9a' })
const form = reactive(emptyForm())
type Field = 'nickname' | 'email' | 'website' | 'content'
const errors = reactive<Record<Field, string>>({ nickname: '', email: '', website: '', content: '' })
const fields: Field[] = ['nickname', 'email', 'website', 'content']
const submitting = ref(false)
const feedback = ref('')
const submissionFailed = ref(false)
function validate(field: Field) {
  const value = form[field].trim()
  errors[field] = ''
  if (field === 'nickname' && (!value || value.length > 50)) errors[field] = text('请填写 1–50 字昵称', 'Enter a nickname of 1–50 characters')
  else if (field === 'content' && !value) errors[field] = text('请填写留言内容', 'Enter your message')
  else if (field === 'email' && value && (value.length > 200 || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value))) errors[field] = text('请输入有效邮箱（最多 200 字）', 'Enter a valid email (up to 200 characters)')
  else if (field === 'website' && value && (value.length > 500 || !safeWebsite(value))) errors[field] = text('请输入完整 HTTP/HTTPS 网址（最多 500 字）', 'Enter a full HTTP/HTTPS URL (up to 500 characters)')
}
async function submitMessage() {
  if (submitting.value) return
  fields.forEach(validate)
  submissionFailed.value = true
  if (fields.some(field => errors[field])) { feedback.value = text('请检查表单中的错误', 'Please correct the form'); return }
  submitting.value = true
  feedback.value = ''
  try {
    const result = await api<ApiResponse<{ id: string | number }>>('message', {
      method: 'POST', body: { nickname: form.nickname.trim(), email: form.email.trim() || null, website: form.website.trim() || null, content: form.content.trim(), color: form.color }
    })
    if (!result.success) { feedback.value = result.message || text('留言提交失败，填写内容已保留', 'Submission failed; your entries are preserved'); return }
    Object.assign(form, emptyForm())
    submissionFailed.value = false
    feedback.value = text('留言发布成功', 'Message published')
    try {
      if (page.value !== 1) await router.push(pageLink(1))
      await refresh()
      if (error.value) throw error.value
    } catch {
      feedback.value = text('留言已发布，但列表刷新失败，请重新加载列表；无需再次提交。', 'Published, but the list could not refresh. Reload the list; do not submit again.')
    }
  } catch (error) {
    const failure = error as { statusCode?: number; data?: { message?: string; data?: { message?: string } } }
    feedback.value = failure.statusCode === 429 ? text('提交过于频繁，请稍后再试', 'Too many submissions. Try later.')
      : failure.statusCode === 400 ? (failure.data?.data?.message || failure.data?.message || text('信息有误，请检查后重试', 'Invalid information. Check and retry.'))
      : text('提交未确认，请检查网络并刷新列表确认是否已发布；填写内容已保留。', 'Submission not confirmed. Check the connection and list before retrying; your entries are preserved.')
  } finally { submitting.value = false }
}
const formPanel = ref<HTMLElement>()
const panelHeight = ref<number>()
let observer: ResizeObserver | undefined
function syncHeight() { panelHeight.value = window.innerWidth >= 1024 ? formPanel.value?.offsetHeight : undefined }
onMounted(() => {
  syncHeight()
  observer = new ResizeObserver(syncHeight)
  if (formPanel.value) observer.observe(formPanel.value)
  window.addEventListener('resize', syncHeight)
})
onBeforeUnmount(() => { observer?.disconnect(); window.removeEventListener('resize', syncHeight) })
useSeoMeta({ title: () => text('留言板', 'Messages'), description: () => text('写下你的想法、建议或问候。', 'Share your thoughts, suggestions or greetings.') })
</script>

<style scoped>
.messages-page { max-width: 1024px; margin: 24px auto 40px; color: var(--text); }
.message-intro,.message-panel { border: 1px solid #3ecf9a40; border-radius: 24px; background: var(--surface); box-shadow: 0 2px 5px #00000005; }
.message-intro { margin-bottom: 24px; padding: 32px; }.message-intro .eyebrow { color: #3ecf9a; font-weight: 700; letter-spacing: .24em; text-transform: uppercase; margin: 0; }.message-intro h1 { font-size: 36px; margin: 12px 0; font-weight: 900; }.message-intro>p:last-child { color: var(--muted); max-width: 680px; line-height: 2; margin-bottom: 0; }
.message-board-grid { display: grid; grid-template-columns: 380px minmax(0,1fr); gap: 24px; align-items: start; }.message-panel { min-width: 0; padding: 24px; }.message-panel h2 { margin: 0; font-size: 20px; font-weight: 900; }
fieldset { border: 0; padding: 0; margin: 0; min-width: 0; }form { margin-top: 20px; }form>fieldset>label { display: block; margin: 16px 0 6px; color: var(--muted); }form>fieldset>label:first-child { margin-top: 0; }
input:not([type="radio"]),textarea { display: block; width: 100%; padding: 10px 12px; font: inherit; color: var(--text); background: var(--bg); border: 1px solid var(--border); border-radius: 8px; }textarea { resize: vertical; min-height: 120px; }[aria-invalid="true"] { border-color: #dc5252!important; }.field-error { color: #d54c4c; font-size: 13px; }.submission-feedback { overflow-wrap: anywhere; margin-bottom: 0; }
.color-options { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 16px; }.color-options legend { margin-bottom: 10px; color: var(--muted); font-weight: 700; }.color-option { position: relative; width: 32px; height: 32px; border-radius: 50%; cursor: pointer; }.color-option input { position: absolute; inset: 0; opacity: 0; margin: 0; width: 100%; height: 100%; cursor: pointer; }.color-option span { display: grid; place-items: center; height: 100%; color: #102b21; font-weight: 900; }.color-option:has(input:checked) { outline: 2px solid var(--text); outline-offset: 2px; }.color-option:has(input:focus-visible) { outline: 3px solid var(--primary); outline-offset: 3px; }
.submit-message { display: block; width: 100%; margin-top: 24px; padding: 10px; border-radius: 8px; border-color: #3ecf9a; background: #3ecf9a; color: #0d3d2d; font-weight: 700; }button:disabled,fieldset:disabled { opacity: .65; }button:disabled { cursor: wait; }
.message-list-panel { display: flex; flex-direction: column; min-height: 0; }.message-list-header { display: flex; justify-content: space-between; align-items: center; gap: 12px; margin-bottom: 20px; }.message-list-header>span { padding: 4px 12px; border-radius: 20px; background: #3ecf9a18; color: var(--muted); font-size: 12px; }.message-list-scroll { flex: 1 1 auto; min-height: 0; overflow-y: auto; overscroll-behavior: contain; scrollbar-width: thin; scrollbar-color: #3ecf9a73 transparent; }.message-notes { display: grid; grid-template-columns: repeat(2,minmax(0,1fr)); gap: 16px; }.message-note { padding: 20px; border: 1px solid var(--border); border-radius: 24px; overflow-wrap: anywhere; }.message-note header { display: flex; flex-wrap: wrap; justify-content: space-between; gap: 8px; }.message-note h3 { margin: 0; font-size: 14px; max-width: 100%; }.message-note time { font-size: 12px; color: var(--muted); }.message-note p { white-space: pre-wrap; line-height: 2; margin: 12px 0; }.message-note a { color: #269c73; font-size: 12px; font-weight: 700; }.empty-messages { color: var(--muted); text-align: center; padding: 30px 0; }.message-pagination { display: flex; justify-content: center; flex-wrap: wrap; gap: 16px; padding-top: 24px; margin-top: auto; }.message-pagination a { color: var(--text); }.message-pagination span { color: var(--muted); }
@media(max-width:1023px) { .message-board-grid { grid-template-columns: 1fr; }.messages-page { margin-top: 16px; }.message-list-panel { height: auto; } }
@media(max-width:639px) { .message-intro,.message-panel { padding: 22px; }.message-intro h1 { font-size: 30px; }.message-notes { grid-template-columns: 1fr; }.message-board-grid { gap: 18px; } }
</style>
