<template>
  <section class="public-comments panel" :data-source="source" aria-label="评论">
    <h2>{{ source === 'article' || source === 'column' ? '全部评论' : '评论' }} <span v-if="list">({{ list.total }})</span></h2>
    <div class="comment-card">
    <p v-if="error" role="alert">评论暂时无法加载 <button type="button" @click="refresh()">重试</button></p>
    <form novalidate @submit.prevent="submit">
      <fieldset :disabled="submitting">
        <div class="comment-identity">
          <label>昵称 / QQ<input v-model="identity.nickname" name="nickname" autocomplete="nickname" required @blur="lookupQQ"></label>
          <label>邮箱(保密)<input v-model="identity.mail" name="mail" type="email" autocomplete="email" required></label>
          <label>网址(选填)<input v-model="identity.website" name="website" type="url" autocomplete="url"></label>
        </div>
        <p v-if="reply">回复 {{ reply.nickname }} <button type="button" @click="resetReply">取消回复</button></p>
        <label class="comment-content-label">评论内容<textarea ref="textarea" v-model="content" name="content" rows="4" maxlength="120" required placeholder="留下你的想法…" /></label>
        <div class="comment-actions"><button type="button" :aria-expanded="emojiOpen" @click="emojiOpen = !emojiOpen">表情</button><span>{{ content.length }}/120</span><button type="submit">{{ submitting ? '提交中…' : '发表评论' }}</button></div>
        <CommentEmoji v-if="emojiOpen" @select="insertEmoji" />
      </fieldset>
    </form>
    <p :class="{ 'comment-feedback-error': feedbackIsError }" :role="feedbackIsError ? 'alert' : 'status'" :aria-live="feedbackIsError ? 'assertive' : 'polite'">{{ feedback }}</p>
    <p v-if="list && !list.comments.length" class="muted">暂无评论，来发表第一条评论吧。</p>
    <article v-for="item in list?.comments" :key="item.id" class="comment-item">
      <img :src="assetUrl(item.avatar) || defaultAvatar" alt="" width="40" height="40" loading="lazy">
      <div><a v-if="safeWebsite(item.website)" :href="safeWebsite(item.website)" rel="nofollow noopener noreferrer">{{ item.nickname }}</a><strong v-else>{{ item.nickname }}</strong><time>{{ item.createdAt?.slice(0, 16).replace('T', ' ') }}</time><p>{{ item.content }}</p><button type="button" @click="startReply(item, item.id)">回复</button>
        <article v-for="child in item.childComments" :key="child.id" class="comment-item comment-child">
          <img :src="assetUrl(child.avatar) || defaultAvatar" alt="" width="32" height="32" loading="lazy"><div><a v-if="safeWebsite(child.website)" :href="safeWebsite(child.website)" rel="nofollow noopener noreferrer">{{ child.nickname }}</a><strong v-else>{{ child.nickname }}</strong><time>{{ child.createdAt?.slice(0, 16).replace('T', ' ') }}</time><p><span v-if="child.replyNickname">@{{ child.replyNickname }} </span>{{ child.content }}</p><button type="button" @click="startReply(child, item.id)">回复</button></div>
        </article>
      </div>
    </article>
    </div>
  </section>
</template>

<script setup lang="ts">
import defaultAvatar from '~/assets/images/avatar.svg'
interface CommentItem {
  id: string; avatar: string; nickname: string; website: string; content: string
  createdAt: string; replyNickname?: string; childComments: CommentItem[]
}
const props = defineProps<{ path: string; source: string }>()
const api = usePublicApi()
const assetUrl = useAssetUrl()
const { data: list, error, refresh } = await useAsyncData(`comments-${props.source}-${props.path}`, async () => {
  const result = await api<{ success: boolean; data: { total: number; comments: CommentItem[] } }>('comment', { query: { routerUrl: props.path } })
  if (!result.success) throw new Error('评论加载失败')
  return { ...result.data, comments: result.data.comments || [] }
}, { watch: [() => props.path] })
const identity = reactive({ avatar: '', nickname: '', mail: '', website: '' })
const content = ref('')
const textarea = ref<HTMLTextAreaElement>()
const emojiOpen = ref(false)
const submitting = ref(false)
const feedback = ref('')
const feedbackIsError = ref(false)
const reply = ref<{ id: string; parent: string; nickname: string }>()
function safeWebsite(value: string) {
  try { const url = new URL(value); return ['http:', 'https:'].includes(url.protocol) ? url.href : undefined }
  catch { return undefined }
}
function resetReply() { reply.value = undefined }
function startReply(item: CommentItem, parent: string) {
  reply.value = { id: item.id, parent, nickname: item.nickname }
  textarea.value?.focus()
}
async function insertEmoji(emoji: string) {
  const start = textarea.value?.selectionStart ?? content.value.length
  const end = textarea.value?.selectionEnd ?? start
  if (content.value.length - (end - start) + emoji.length > 120) { feedbackIsError.value = true; feedback.value = '评论最多 120 字'; return }
  content.value = content.value.slice(0, start) + emoji + content.value.slice(end)
  await nextTick()
  textarea.value?.focus()
  textarea.value?.setSelectionRange(start + emoji.length, start + emoji.length)
}
async function lookupQQ() {
  const qq = identity.nickname.trim()
  if (!/^\d+$/.test(qq)) return
  try {
    const result = await api<{ success: boolean; data?: typeof identity; message?: string }>('comment/qq-user-info', { query: { qq } })
    if (identity.nickname.trim() !== qq) return
    if (result.success && result.data) Object.assign(identity, { avatar: result.data.avatar, nickname: result.data.nickname, mail: result.data.mail })
    else { feedbackIsError.value = true; feedback.value = result.message || 'QQ 信息获取失败，请手动填写' }
  } catch { feedbackIsError.value = true; feedback.value = 'QQ 信息获取失败，请手动填写' }
}
async function submit() {
  if (submitting.value) return
  feedbackIsError.value = true
  if (!identity.nickname.trim()) { feedback.value = '请输入昵称'; return }
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(identity.mail.trim())) { feedback.value = '请输入有效邮箱'; return }
  const website = identity.website.trim()
  if (website && !safeWebsite(website)) { feedback.value = '请输入完整的网址（以 http:// 或 https:// 开头），或留空'; return }
  if (!content.value.trim() || content.value.length > 120) { feedback.value = '请输入 1–120 字评论'; return }
  submitting.value = true
  feedback.value = ''
  feedbackIsError.value = false
  const path = props.path
  try {
    const result = await api<{ success: boolean; message?: string; errorCode?: string }>('comment/publish', {
      method: 'POST', body: { ...identity, website, content: content.value.trim(), routerUrl: path, replyCommentId: reply.value?.id || null, parentCommentId: reply.value?.parent || null }
    })
    if (path !== props.path) return
    feedbackIsError.value = !result.success && result.errorCode !== 'comment_wait_examine'
    feedback.value = result.message || (result.success ? '评论发布成功' : '评论发布失败')
    if (result.success || result.errorCode === 'comment_wait_examine') {
      content.value = ''; resetReply()
      try { localStorage.setItem('surferCommentUserInfo', JSON.stringify(identity)) } catch { /* Browser storage may be disabled. */ }
      await refresh()
    }
  } catch { if (path === props.path) { feedbackIsError.value = true; feedback.value = '评论提交失败，请稍后重试' } }
  finally { submitting.value = false }
}
watch(() => props.path, () => { content.value = ''; resetReply(); feedback.value = ''; feedbackIsError.value = false })
onMounted(() => {
  try {
    const saved = JSON.parse(localStorage.getItem('surferCommentUserInfo') || 'null')
    if (saved) for (const key of ['avatar', 'nickname', 'mail', 'website'] as const) if (typeof saved[key] === 'string') identity[key] = saved[key]
  } catch { /* Ignore invalid or unavailable local storage. */ }
})
</script>

<style scoped>
.comment-feedback-error{color:#d54c4c}
.public-comments{margin-top:24px}.comment-identity{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:14px}fieldset{border:0;padding:0;margin:0;min-width:0}label{display:block;color:var(--muted)}input,textarea{display:block;width:100%;min-width:0;border:1px solid var(--border);border-radius:8px;background:var(--bg);color:var(--text);padding:10px;font:inherit}textarea{resize:vertical}.comment-content-label{margin-top:14px}.comment-actions{display:flex;gap:12px;align-items:center;margin-top:12px}.comment-actions button:last-child{margin-left:auto;background:var(--primary);color:white;padding:8px 16px}.comment-item{display:flex;gap:12px;padding:20px 0;border-top:1px solid var(--border);overflow-wrap:anywhere}.comment-item img{border-radius:50%;object-fit:cover;flex-shrink:0}.comment-item>div{min-width:0;flex:1}.comment-item p{white-space:pre-wrap}.comment-item time{display:block;color:var(--muted);font-size:12px}.comment-child{margin-top:16px;padding-bottom:0}@media(max-width:767px){.comment-identity{grid-template-columns:1fr}.comment-child{gap:6px}.comment-child img{width:24px;height:24px}}
.public-comments:is([data-source="article"],[data-source="column"]){margin-top:56px!important;padding:0!important;border:0!important;background:transparent!important}.public-comments:is([data-source="article"],[data-source="column"])>h2{text-align:center;font-size:14px;font-weight:400;margin:0 0 28px}.public-comments:is([data-source="article"],[data-source="column"]) .comment-card{padding:40px 20px;margin-bottom:12px;border:1px solid var(--border);border-radius:8px;background:var(--surface)}.public-comments:is([data-source="article"],[data-source="column"]) .comment-identity{display:flex;flex-wrap:wrap;gap:20px}.public-comments:is([data-source="article"],[data-source="column"]) .comment-identity label{flex:1 1 192px;display:flex;align-items:center;font-size:12px;white-space:nowrap;background:var(--bg);border:1px solid var(--border);border-radius:8px;overflow:hidden;padding-left:12px}.public-comments:is([data-source="article"],[data-source="column"]) input{border:0;border-left:1px solid var(--border);border-radius:0;background:var(--surface);margin-left:12px;padding:10px;font-size:12px}.public-comments:is([data-source="article"],[data-source="column"]) .comment-content-label{font-size:0;margin-top:16px}.public-comments:is([data-source="article"],[data-source="column"]) textarea{background:var(--surface);border-radius:8px 8px 0 0;padding:8px 16px;font-size:14px;border-bottom:0}.public-comments:is([data-source="article"],[data-source="column"]) .comment-actions{margin:0;padding:8px 12px;border:1px solid var(--border);border-radius:0 0 8px 8px}.public-comments:is([data-source="article"],[data-source="column"]) .comment-actions button:last-child{order:-1;margin-left:0;margin-right:auto;background:#3ecf9a}.public-comments:is([data-source="article"],[data-source="column"]) .comment-item{border:0;padding:0;margin-top:20px}.public-comments:is([data-source="article"],[data-source="column"]) .comment-item strong,.public-comments:is([data-source="article"],[data-source="column"]) .comment-item a{font-size:12px;color:#3ecf9a}.public-comments:is([data-source="article"],[data-source="column"]) .comment-item p{font-size:14px;margin:6px 0}.public-comments:is([data-source="article"],[data-source="column"]) .comment-item button{border:0;background:transparent;font-size:12px;color:var(--muted)}.public-comments:is([data-source="article"],[data-source="column"]) .comment-child img{width:24px;height:24px}@media(max-width:768px){.public-comments:is([data-source="article"],[data-source="column"]) input{font-size:16px}}
</style>
