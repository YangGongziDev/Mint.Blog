<template>
  <div ref="containerRef" class="header-search">
    <div class="desktop-search">
      <div class="search-field">
        <svg class="search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><circle cx="10.5" cy="10.5" r="6.5" /><path d="m16 16 5 5" /></svg>
        <input ref="inputRef" v-model="query" type="search" aria-label="搜索文章" placeholder="搜索文章..." autocomplete="off" :aria-expanded="open" @input="onInput" @compositionstart="onCompositionStart" @compositionend="onCompositionEnd" @keydown.enter="submitSearch" @focus="open = Boolean(query.trim())">
      </div>
      <div v-if="open" class="search-results desktop-results" :aria-busy="loading">
        <p v-if="loading" role="status">搜索中…</p>
        <p v-else-if="error" role="alert">搜索暂时不可用，请修改关键词重试。</p>
        <p v-else-if="!results.length" role="status">未找到相关文章</p>
        <ul v-else>
          <li v-for="article in results" :key="article.id">
            <NuxtLink :to="`/articles/${encodeURIComponent(article.id)}`" @click="closeAll">
              <template v-for="(part, index) in parts(article.title)" :key="index"><mark v-if="part.match">{{ part.text }}</mark><template v-else>{{ part.text }}</template></template>
            </NuxtLink>
          </li>
        </ul>
        <NuxtLink v-if="query.trim()" :to="searchTarget" @click="closeAll">查看全部结果</NuxtLink>
      </div>
    </div>
    <button class="mobile-trigger" type="button" aria-label="搜索文章" aria-haspopup="dialog" @click="openModal">
      <svg class="search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><circle cx="10.5" cy="10.5" r="6.5" /><path d="m16 16 5 5" /></svg>
    </button>
    <Teleport to="body">
      <dialog ref="dialogRef" class="search-dialog" aria-label="搜索文章" @click="onDialogClick" @cancel.prevent="closeAll" @close="onDialogClose">
        <div class="mobile-toolbar">
          <div class="search-field">
            <svg class="search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><circle cx="10.5" cy="10.5" r="6.5" /><path d="m16 16 5 5" /></svg>
            <input ref="modalInputRef" v-model="query" type="search" aria-label="搜索文章" placeholder="搜索文章..." autocomplete="off" @input="onInput" @compositionstart="onCompositionStart" @compositionend="onCompositionEnd" @keydown.enter="submitSearch">
          </div>
          <button type="button" class="cancel-button" @click="closeAll">取消</button>
        </div>
        <div class="search-results mobile-results" :aria-busy="loading">
          <p v-if="loading" role="status">搜索中…</p>
          <p v-else-if="error" role="alert">搜索暂时不可用，请修改关键词重试。</p>
          <p v-else-if="!query.trim()" role="status">输入关键词搜索文章</p>
          <p v-else-if="!results.length" role="status">未找到相关文章</p>
          <ul v-else>
            <li v-for="article in results" :key="article.id">
              <NuxtLink :to="`/articles/${encodeURIComponent(article.id)}`" @click="closeAll">
                <template v-for="(part, index) in parts(article.title)" :key="index"><mark v-if="part.match">{{ part.text }}</mark><template v-else>{{ part.text }}</template></template>
              </NuxtLink>
            </li>
          </ul>
          <NuxtLink v-if="query.trim()" :to="searchTarget" @click="closeAll">查看全部结果</NuxtLink>
        </div>
      </dialog>
    </Teleport>
  </div>
</template>

<script setup lang="ts">
interface ArticleResult { id: string | number; title: string }
interface SearchResponse { success: boolean; data: { items: ArticleResult[] } }

const api = usePublicApi()
const route = useRoute()
const query = ref('')
const searchTarget = computed(() => ({
  path: '/search',
  query: { keyword: query.value.trim(), pageNumber: '1', pageSize: '8' }
}))
const results = ref<ArticleResult[]>([])
const open = ref(false)
const loading = ref(false)
const error = ref(false)
const containerRef = ref<HTMLDivElement>()
const inputRef = ref<HTMLInputElement>()
const modalInputRef = ref<HTMLInputElement>()
const dialogRef = ref<HTMLDialogElement>()
let composing = false
let timer: ReturnType<typeof setTimeout> | undefined
let requestVersion = 0
let viewportFrame = 0
let stopViewport: (() => void) | undefined
let restoreScroll: (() => void) | undefined
let finishClose: (() => void) | undefined

function syncViewport() {
  const dialog = dialogRef.value
  if (!dialog?.open) return
  const viewport = window.visualViewport
  dialog.style.setProperty('--search-viewport-height', `${viewport?.height ?? window.innerHeight}px`)
  // Measure at top: 0 so browsers already anchoring fixed dialogs to the visual viewport aren't compensated twice.
  dialog.style.setProperty('--search-viewport-top', '0px')
  const origin = dialog.getBoundingClientRect().top
  dialog.style.setProperty('--search-viewport-top', `${(viewport?.offsetTop ?? 0) - origin}px`)
}

function scheduleViewport() {
  cancelAnimationFrame(viewportFrame)
  viewportFrame = requestAnimationFrame(() => {
    viewportFrame = 0
    syncViewport()
  })
}

function lockModal() {
  finishClose?.()
  const { scrollX, scrollY } = window
  const body = document.body
  const properties = ['position', 'top', 'left', 'width']
  const styles = properties.map(name => [name, body.style.getPropertyValue(name), body.style.getPropertyPriority(name)] as const)
  Object.assign(body.style, { position: 'fixed', top: `-${scrollY}px`, left: `-${scrollX}px`, width: '100%' })
  restoreScroll = () => {
    for (const [name, value, priority] of styles) {
      if (value) body.style.setProperty(name, value, priority)
      else body.style.removeProperty(name)
    }
    window.scrollTo({ left: scrollX, top: scrollY, behavior: 'instant' })
    restoreScroll = undefined
  }
  const viewport = window.visualViewport
  viewport?.addEventListener('resize', scheduleViewport)
  viewport?.addEventListener('scroll', scheduleViewport)
  window.addEventListener('resize', scheduleViewport)
  stopViewport = () => {
    viewport?.removeEventListener('resize', scheduleViewport)
    viewport?.removeEventListener('scroll', scheduleViewport)
    window.removeEventListener('resize', scheduleViewport)
    cancelAnimationFrame(viewportFrame)
    viewportFrame = 0
    dialogRef.value?.style.removeProperty('--search-viewport-top')
    dialogRef.value?.style.removeProperty('--search-viewport-height')
    stopViewport = undefined
  }
}

function unlockModal() {
  stopViewport?.()
  if (!restoreScroll || finishClose) return
  const viewport = window.visualViewport
  if (!viewport || (viewport.height >= window.innerHeight && viewport.offsetTop === 0)) {
    restoreScroll()
    return
  }
  // Keep the background fixed until the blur/keyboard viewport animation settles, then restore once.
  let settleTimer: ReturnType<typeof setTimeout>
  const maxTimer = setTimeout(() => finishClose?.(), 800)
  const settle = () => {
    clearTimeout(settleTimer)
    settleTimer = setTimeout(() => finishClose?.(), 150)
  }
  finishClose = () => {
    clearTimeout(settleTimer)
    clearTimeout(maxTimer)
    viewport.removeEventListener('resize', settle)
    viewport.removeEventListener('scroll', settle)
    restoreScroll?.()
    finishClose = undefined
  }
  viewport.addEventListener('resize', settle)
  viewport.addEventListener('scroll', settle)
  settle()
}

function onCompositionStart() {
  composing = true
  clearTimeout(timer)
  requestVersion++
  loading.value = false
}

function onCompositionEnd(event: CompositionEvent) {
  composing = false
  query.value = (event.target as HTMLInputElement).value
  onInput(event)
}

function onInput(event: Event) {
  clearTimeout(timer)
  const version = ++requestVersion
  if (composing || (event as InputEvent).isComposing) return
  const keyword = query.value.trim()
  results.value = []
  error.value = false
  open.value = Boolean(keyword)
  loading.value = Boolean(keyword)
  if (!keyword) return
  timer = setTimeout(async () => {
    try {
      const response = await api<SearchResponse>('article/search', {
        query: { keyword, pageSize: 8, pageNumber: 1 }
      })
      if (version !== requestVersion) return
      if (!response.success) throw new Error('搜索失败')
      results.value = response.data?.items || []
    } catch {
      if (version === requestVersion) error.value = true
    } finally {
      if (version === requestVersion) loading.value = false
    }
  }, 300)
}

function submitSearch(event: KeyboardEvent) {
  if (composing || event.isComposing || event.keyCode === 229 || !query.value.trim()) return
  event.preventDefault()
  const target = searchTarget.value
  closeAll()
  return navigateTo(target)
}

function parts(title: string) {
  const keyword = query.value.trim().toLocaleLowerCase()
  if (!keyword) return [{ text: title, match: false }]
  const segments: { text: string; match: boolean }[] = []
  let offset = 0
  while (offset < title.length) {
    const index = title.toLocaleLowerCase().indexOf(keyword, offset)
    if (index < 0) {
      segments.push({ text: title.slice(offset), match: false })
      break
    }
    if (index > offset) segments.push({ text: title.slice(offset, index), match: false })
    segments.push({ text: title.slice(index, index + keyword.length), match: true })
    offset = index + keyword.length
  }
  return segments
}

function closeAll() {
  clearTimeout(timer)
  requestVersion++
  composing = false
  open.value = false
  query.value = ''
  results.value = []
  loading.value = false
  error.value = false
  inputRef.value?.blur()
  modalInputRef.value?.blur()
  if (dialogRef.value?.open) dialogRef.value.close()
  unlockModal()
}

function openModal() {
  if (!dialogRef.value || dialogRef.value.open) return
  closeAll()
  lockModal()
  dialogRef.value.showModal()
  syncViewport()
  modalInputRef.value?.focus({ preventScroll: true })
  scheduleViewport()
}

function onClickOutside(event: MouseEvent) {
  if (!dialogRef.value?.open && !containerRef.value?.contains(event.target as Node)) open.value = false
}

function onDialogClick(event: MouseEvent) {
  if (event.target !== dialogRef.value) return
  const bounds = dialogRef.value.getBoundingClientRect()
  if (event.clientX < bounds.left || event.clientX > bounds.right || event.clientY < bounds.top || event.clientY > bounds.bottom) closeAll()
}

function onKeydown(event: KeyboardEvent) {
  if (event.key === 'Escape') closeAll()
}

function onDialogClose() {
  if (!dialogRef.value?.open) closeAll()
}

watch(() => route.fullPath, closeAll)
onMounted(() => {
  document.addEventListener('click', onClickOutside)
  document.addEventListener('keydown', onKeydown)
})
onBeforeUnmount(() => {
  closeAll()
  finishClose?.()
  document.removeEventListener('click', onClickOutside)
  document.removeEventListener('keydown', onKeydown)
})
</script>

<style scoped>
.header-search { position: relative; }
.header-search, .search-dialog { --search-text: #3ecf9a; }
.desktop-search { width: 200px; }
.desktop-search .search-field { padding-block: 3px; }
.search-field { display: flex; align-items: center; gap: 8px; min-width: 0; padding: 6px 12px; border: 1px solid var(--border); border-radius: 8px; background: var(--surface); transition: border-color .2s; }
.search-field:focus-within { border-color: #3ecf9a; }
.search-icon { flex-shrink: 0; width: 16px; height: 16px; color: var(--muted); }
.search-field input { width: 100%; min-width: 0; padding: 0; border: 0; outline: none; background: transparent; color: var(--search-text); font: inherit; }
.search-field input::placeholder { color: var(--muted); }
.search-results { padding: 4px; color: var(--text); background: var(--surface); overflow-y: auto; overscroll-behavior: contain; }
.desktop-results { position: absolute; top: 100%; right: 0; z-index: 60; width: 320px; max-height: 320px; margin-top: 4px; border: 1px solid var(--border); border-radius: 8px; box-shadow: 0 8px 24px #0002; }
.search-results ul { list-style: none; padding: 0; margin: 0; }
.search-results li { margin: 0; padding: 0; }
.search-results a { display: block; padding: 8px 12px; border-radius: 6px; color: var(--search-text); text-decoration: none; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.search-results a:hover, .search-results a:focus-visible { background: #3ecf9a1a; }
.search-results mark { color: #eb373a; background: transparent; font-weight: 800; }
.search-results p { padding: 20px 8px; margin: 0; text-align: center; color: var(--muted); }
.mobile-trigger { display: none; flex-shrink: 0; align-items: center; justify-content: center; width: 32px; height: 34px; padding: 4px; border: 0; background: transparent; cursor: pointer; }
.mobile-trigger .search-icon { width: 24px; height: 24px; color: var(--text); }
.search-dialog { position: fixed; inset: var(--search-viewport-top, 0px) 0 auto; box-sizing: border-box; width: 100%; max-width: 100%; max-height: 100vh; max-height: var(--search-viewport-height, 100dvh); margin: 0; padding: 12px; padding-top: max(12px, env(safe-area-inset-top)); border: 0; overflow: hidden; overscroll-behavior: contain; color: var(--text); background: var(--surface); }
.search-dialog[open] { display: flex; flex-direction: column; }
.search-dialog::backdrop { background: #0006; }
.mobile-toolbar { display: flex; flex-shrink: 0; align-items: center; gap: 8px; }
.mobile-toolbar .search-field { flex: 1; padding-block: 8px; }
.cancel-button { flex-shrink: 0; padding: 4px 8px; border: 1px solid var(--border); color: var(--text); background: var(--surface); cursor: pointer; }
.mobile-results { min-height: 0; max-height: 60vh; max-height: 60dvh; margin-top: 12px; }
:global([data-theme="dark"]) .header-search, :global([data-theme="dark"]) .search-dialog { --search-text: #fff; }
@media (max-width: 767px) {
  .desktop-search { display: none; }
  .mobile-trigger { display: inline-flex; }
}
</style>
