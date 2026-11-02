<template>
  <div v-if="ready" class="floating-tools-layer">
    <div class="floating-tools" :class="{ 'is-dragging': dragging }" :style="{ transform: `translate3d(${position.x}px, ${position.y}px, 0)` }">
      <TransitionGroup name="floating-action" tag="div" class="floating-actions">
        <div v-for="(action, index) in actions" v-show="expanded" :key="action.id" class="floating-action-wrap" :style="actionStyle(index)">
          <button type="button" class="floating-action-item" :class="{ 'is-disabled': action.id === 'toc' && !tocAvailable }" :aria-disabled="action.id === 'toc' && !tocAvailable ? true : undefined" :aria-expanded="action.id === 'toc' ? tocOpen : undefined" :aria-label="action.label" :title="action.label" @click="runAction(action.id)">
            <svg viewBox="0 0 24 24" aria-hidden="true"><path :d="action.path" :transform="action.id === 'share' ? 'translate(-1 0)' : undefined" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" /></svg>
          </button>
        </div>
      </TransitionGroup>
      <button ref="mainButton" type="button" class="floating-main-button" :aria-expanded="expanded" :aria-label="expanded ? text('收起功能菜单', 'Collapse tools') : text('展开功能菜单', 'Expand tools')" :title="text('点击展开或收起，拖动调整位置', 'Click to toggle, drag to reposition')" @pointerdown="pointerDown" @pointermove="pointerMove" @pointerup="pointerEnd" @pointercancel="pointerEnd" @lostpointercapture="pointerEnd" @click="toggleExpanded">
        <svg viewBox="0 0 24 24" aria-hidden="true" :class="{ 'is-expanded': expanded }"><path v-if="expanded" d="M9 9H6a3 3 0 1 1 3-3v12a3 3 0 1 1-3-3h12a3 3 0 1 1-3 3V6a3 3 0 1 1 3 3H9Z" /><g v-else><path d="m9.5 3-.5 2-1.5 1-2-.5-2.5 4 1.5 1.5v2L3 14.5l2.5 4 2-.5L9 19l.5 2h5l.5-2 1.5-1 2 .5 2.5-4-1.5-1.5v-2L21 9.5l-2.5-4-2 .5L15 5l-.5-2Z" /><circle cx="12" cy="12" r="3" /></g></svg>
      </button>
    </div>
    <p v-show="feedback" class="floating-feedback" role="status" aria-live="polite">{{ feedback }}</p>
  </div>
</template>

<script setup lang="ts">
interface Position { x: number; y: number }
const STORAGE_KEY = 'blogSurferFloatingToolsPositionV3'
const { text } = useSitePreferences()
const route = useRoute()
const ready = ref(false)
const expanded = ref(true)
const dragging = ref(false)
const position = ref<Position>({ x: 24, y: 180 })
const viewport = ref({ width: 0, height: 0 })
const mainButton = ref<HTMLButtonElement>()
const tocOpen = ref(false)
const tocAvailable = ref(false)
const feedback = ref('')
const size = computed(() => viewport.value.width < 768 ? 46 : 52)
const radius = computed(() => viewport.value.width < 768 ? 56 : 62)
let pointer: { id: number; x: number; y: number; start: Position } | undefined
let suppressClick = false
let observer: MutationObserver | undefined
let feedbackTimer: ReturnType<typeof setTimeout> | undefined
let disposed = false
const actions = computed(() => [
  { id: 'top', label: text('返回顶部', 'Back to top'), path: 'M12 19V5m-6 6 6-6 6 6' },
  { id: 'toc', label: tocAvailable.value ? text('文章目录', 'Article contents') : text('当前页面暂无目录', 'No contents on this page'), path: 'M8 6h13M8 12h13M8 18h13M3 6h.01M3 12h.01M3 18h.01' },
  { id: 'share', label: text('分享', 'Share'), path: 'm8.6 10.5 6.8-4M8.6 13.5l6.8 4M9 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0ZM21 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm0 14a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z' }
])

function clamp(next: Position): Position {
  // 预留上下动作按钮的空间，拖到边缘后展开也不会超出视口。
  const verticalPadding = radius.value + 24 - size.value / 2
  const minY = Math.min(verticalPadding, Math.max(0, (viewport.value.height - size.value) / 2))
  const minX = Math.min(12, Math.max(0, (viewport.value.width - size.value) / 2))
  return {
    x: Math.min(Math.max(minX, next.x), Math.max(minX, viewport.value.width - size.value - minX)),
    y: Math.min(Math.max(minY, next.y), Math.max(minY, viewport.value.height - size.value - minY))
  }
}
function savePosition() {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(position.value)) } catch { /* 存储不可用时仍允许拖动。 */ }
}
function resize() {
  viewport.value = { width: window.innerWidth, height: window.innerHeight }
  position.value = clamp(position.value)
  savePosition()
  void nextTick(updateHeadings)
}
function actionStyle(index: number) {
  const center = size.value / 2
  const inward = position.value.x + center > viewport.value.width / 2 ? -1 : 1
  const x = index === 1 ? inward * radius.value : 0
  const y = index === 0 ? -radius.value : index === 2 ? radius.value : 0
  const boundedX = Math.min(Math.max(24, position.value.x + center + x), Math.max(24, viewport.value.width - 24))
  const boundedY = Math.min(Math.max(24, position.value.y + center + y), Math.max(24, viewport.value.height - 24))
  return { transform: `translate(${boundedX - position.value.x - center}px, ${boundedY - position.value.y - center}px)`, '--action-delay': `${index * 60}ms` }
}
function pointerDown(event: PointerEvent) {
  if (event.button !== 0 || !event.isPrimary || pointer) return
  suppressClick = false
  dragging.value = false
  pointer = { id: event.pointerId, x: event.clientX, y: event.clientY, start: { ...position.value } }
  mainButton.value?.setPointerCapture(event.pointerId)
}
function pointerMove(event: PointerEvent) {
  if (!pointer || pointer.id !== event.pointerId) return
  const x = event.clientX - pointer.x
  const y = event.clientY - pointer.y
  if (Math.max(Math.abs(x), Math.abs(y)) > 4) {
    dragging.value = true
    suppressClick = true
  }
  if (dragging.value) position.value = clamp({ x: pointer.start.x + x, y: pointer.start.y + y })
}
function pointerEnd(event: PointerEvent) {
  if (!pointer || pointer.id !== event.pointerId) return
  pointer = undefined
  if (event.type !== 'pointerup') suppressClick = true
  if (mainButton.value?.hasPointerCapture(event.pointerId)) mainButton.value.releasePointerCapture(event.pointerId)
  if (dragging.value) savePosition()
  dragging.value = false
}
function toggleExpanded(event: MouseEvent) {
  // 鼠标拖动后的合成点击不展开，键盘触发仍然可用。
  if (suppressClick && event.detail !== 0) { suppressClick = false; return }
  expanded.value = !expanded.value
}
function updateHeadings() {
  const content = document.querySelector('#main .article-content')
  const toc = document.querySelector<HTMLElement>('#main [data-article-toc]')
  tocAvailable.value = Boolean(toc && content?.querySelector('h1,h2,h3,h4,h5,h6'))
  tocOpen.value = Boolean(tocAvailable.value && toc?.getClientRects().length)
}
function toggleToc() {
  updateHeadings()
  if (!tocAvailable.value) { notify(text('当前页面暂无目录', 'No contents on this page')); return }
  window.dispatchEvent(new CustomEvent('blog-surfer:toggle-toc'))
  void nextTick(updateHeadings)
}
function scrollBehavior(): ScrollBehavior { return window.matchMedia('(prefers-reduced-motion: reduce)').matches ? 'instant' : 'smooth' }
function notify(value: string) {
  clearTimeout(feedbackTimer)
  feedback.value = value
  feedbackTimer = setTimeout(() => { feedback.value = '' }, 4000)
}
async function copyUrl(url: string) {
  if (window.isSecureContext && navigator.clipboard?.writeText) {
    try { await navigator.clipboard.writeText(url); return } catch { /* 剪贴板权限不足时尝试兼容复制。 */ }
  }
  const textarea = document.createElement('textarea')
  textarea.value = url
  textarea.style.cssText = 'position:fixed;opacity:0;left:0;top:0'
  document.body.appendChild(textarea)
  try {
    textarea.select()
    if (!document.execCommand('copy')) throw new Error('复制失败')
  } finally { textarea.remove(); mainButton.value?.focus({ preventScroll: true }) }
}
async function share() {
  const title = document.querySelector<HTMLMetaElement>('meta[property="og:title"]')?.content || document.title
  const description = document.querySelector<HTMLMetaElement>('meta[property="og:description"]')?.content || title
  const url = window.location.href
  if (navigator.share) {
    try {
      await navigator.share({ title, text: description, url })
      if (!disposed) notify(text('已完成分享', 'Shared successfully'))
      return
    } catch (error) {
      if (error instanceof Error && error.name === 'AbortError') return
    }
  }
  try {
    await copyUrl(url)
    if (!disposed) notify(text('链接已复制，快去分享吧', 'Link copied. Ready to share!'))
  } catch {
    if (!disposed) notify(text('分享失败，请手动复制浏览器地址', 'Unable to share. Please copy the address manually.'))
  }
}
function runAction(id: string) {
  if (id === 'top') window.scrollTo({ top: 0, behavior: scrollBehavior() })
  else if (id === 'toc') toggleToc()
  else void share()
}
watch(() => route.fullPath, () => {
  if (!import.meta.client) return
  tocOpen.value = false
  tocAvailable.value = false
  void nextTick(() => { if (!disposed) updateHeadings() })
})
onMounted(() => {
  viewport.value = { width: window.innerWidth, height: window.innerHeight }
  let stored: Position | undefined
  try {
    const parsed = JSON.parse(localStorage.getItem(STORAGE_KEY) || 'null')
    if (parsed && Number.isFinite(parsed.x) && Number.isFinite(parsed.y)) stored = { x: parsed.x, y: parsed.y }
  } catch { /* 损坏或受限的存储不影响默认位置。 */ }
  position.value = clamp(stored || { x: 24, y: window.innerHeight * 0.75 - size.value / 2 })
  ready.value = true
  updateHeadings()
  // 只观察正文区域，异步专栏文章替换后更新目录，不观察悬浮组件自身。
  const main = document.getElementById('main')
  if (main) {
    observer = new MutationObserver(updateHeadings)
    observer.observe(main, { childList: true, subtree: true, characterData: true, attributes: true, attributeFilter: ['style', 'class', 'open'] })
  }
  window.addEventListener('resize', resize)
})
onBeforeUnmount(() => {
  disposed = true
  observer?.disconnect()
  window.removeEventListener('resize', resize)
  clearTimeout(feedbackTimer)
})
</script>

<style scoped>
.floating-tools-layer { position: fixed; inset: 0; z-index: 999; pointer-events: none; }
.floating-tools { position: absolute; left: 0; top: 0; width: 52px; height: 52px; user-select: none; }
.floating-main-button,.floating-action-item { display: flex; align-items: center; justify-content: center; border: 1px solid #94a3b848; border-radius: 999px; box-shadow: 0 12px 30px #0f172a29; backdrop-filter: blur(12px); pointer-events: auto; transition: transform .2s,box-shadow .2s,background-color .2s; }
.floating-main-button { position: relative; z-index: 2; width: 52px; height: 52px; padding: 12px; color: #fff; background: linear-gradient(135deg,#22c55e,#0ea5e9); cursor: grab; touch-action: none; }
.is-dragging .floating-main-button { cursor: grabbing; }
.floating-main-button:hover { transform: scale(1.06); box-shadow: 0 16px 38px #0ea5e947; }
.floating-main-button:active { transform: scale(.96); }
.floating-main-button svg { width: 25px; height: 25px; flex-shrink: 0; fill: none; stroke: currentColor; stroke-width: 1.8; stroke-linejoin: round; transition: transform .3s; }
.floating-main-button svg.is-expanded { transform: rotate(180deg); }
.floating-actions { position: absolute; left: 50%; top: 50%; width: 0; height: 0; }
.floating-action-wrap { position: absolute; left: 0; top: 0; }
.floating-action-item { width: 42px; height: 42px; padding: 8px; color: var(--text); background: color-mix(in srgb,var(--surface) 94%,transparent); transform: translate(-50%,-50%); }
.floating-action-item svg { width: 28px; height: 28px; }
.floating-action-item:hover { color: var(--primary); border-color: var(--primary); transform: translate(-50%,-50%) scale(1.08); }
.floating-action-item.is-disabled { opacity: .48; cursor: not-allowed; }
.floating-action-enter-active,.floating-action-leave-active { transition: opacity .24s ease var(--action-delay),transform .28s ease var(--action-delay); }
.floating-action-enter-from,.floating-action-leave-to { opacity: 0; transform: translate(0,0) scale(.2) !important; }
.floating-feedback { position: fixed; left: 50%; bottom: calc(24px + env(safe-area-inset-bottom)); transform: translateX(-50%); width: max-content; max-width: calc(100vw - 32px); margin: 0; padding: 12px 20px; border: 1px solid var(--border); border-radius: 12px; color: var(--text); background: var(--surface); box-shadow: 0 12px 30px #0003; }
@media(max-width:767px) { .floating-tools,.floating-main-button { width: 46px; height: 46px; } .floating-main-button { padding: 10px; } .floating-action-item { width: 38px; height: 38px; padding: 7px; } }
</style>
