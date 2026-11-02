<template>
  <section class="site-banner" :style="{ backgroundImage: image ? `linear-gradient(#0006,#0006),url('${image}')` : 'linear-gradient(#0006,#0006)' }">
    <div class="star-field" aria-hidden="true"><div class="stars"><i v-for="(star, index) in stars" :key="index" :style="star" /></div></div>
    <div class="banner-content"><slot /></div>
    <svg class="banner-waves" viewBox="0 24 150 28" preserveAspectRatio="none" aria-hidden="true"><defs><path id="mint-banner-wave" d="M-160 44c30 0 58-14 88-14s58 14 88 14 58-14 88-14 58 14 88 14v44h-352z" /></defs><g><use href="#mint-banner-wave" x="48" y="0" /><use href="#mint-banner-wave" x="48" y="6" /><use href="#mint-banner-wave" x="48" y="12" /><use href="#mint-banner-wave" x="48" y="18" /></g></svg>
  </section>
</template>

<script setup lang="ts">
const props = defineProps<{ image?: string }>()
const images = Object.entries(import.meta.glob<string>('~/assets/article-banner/*.{png,jpg,jpeg,webp,avif,gif}', {
  eager: true,
  import: 'default',
  query: '?url&no-inline',
})).sort(([a], [b]) => a < b ? -1 : a > b ? 1 : 0).map(([, url]) => url)
const lastImage = useCookie<string>('mint-banner-last', { path: '/', sameSite: 'lax' })
const nuxtApp = useNuxtApp()
const route = useRoute()
function pickImage() {
  const candidates = images.map((url, index) => ({ url, key: `i:${index}` }))
    .filter(image => image.key !== lastImage.value)
  const image = candidates[Math.floor(Math.random() * candidates.length)]!
  lastImage.value = image.key
  return image.url
}
// SSR 选择写入请求内 payload；水合复用，客户端再次挂载才重新选择。
const selected = useState<string>(`site-banner:${route.path}`, () => '')
const previous = useState<string>(`site-banner-previous:${route.path}`, () => '')
if (import.meta.server || !nuxtApp.isHydrating) {
  previous.value = images.find((_, index) => `i:${index}` === lastImage.value) || ''
  selected.value = props.image || pickImage()
}
if (import.meta.server) useResponseHeader('Cache-Control').value = 'private, no-store'
const image = ref(props.image || selected.value)
useHead(() => ({ link: image.value ? [{ rel: 'preload', as: 'image', href: image.value }] : [] }))
const readiness = new Map<string, Promise<boolean>>()
const pending = new Set<() => void>()
let stopped = false
let generation = 0
let idleId: number | undefined
let preloadTimer: ReturnType<typeof setTimeout> | undefined

function ensureImageReady(src: string) {
  const cached = readiness.get(src)
  if (cached) return cached
  const ready = new Promise<boolean>(resolve => {
    const element = new Image()
    let settled = false
    const finish = (success: boolean) => {
      if (settled) return
      settled = true
      clearTimeout(timer)
      element.onload = element.onerror = null
      pending.delete(cancel)
      resolve(success)
    }
    const cancel = () => finish(false)
    const timer = setTimeout(cancel, 10000)
    pending.add(cancel)
    element.onload = async () => {
      try {
        if (typeof element.decode === 'function') await element.decode()
        finish(element.naturalWidth > 0)
      } catch {
        finish(false)
      }
    }
    element.onerror = cancel
    element.src = src
  })
  readiness.set(src, ready)
  return ready
}

function schedulePreload() {
  const run = async () => {
    idleId = undefined
    preloadTimer = undefined
    if (stopped) return
    const batch = images.filter(src => !readiness.has(src)).slice(0, 2)
    await Promise.all(batch.map(ensureImageReady))
    if (!stopped && images.some(src => !readiness.has(src))) schedulePreload()
  }
  if ('requestIdleCallback' in window) idleId = window.requestIdleCallback(run, { timeout: 8000 })
  else preloadTimer = setTimeout(run, 5000)
}

async function resolveImage() {
  const current = ++generation
  const first = props.image || selected.value
  const candidates = [first, ...images.filter(src => src !== first && src !== previous.value)]
  for (const candidate of candidates) {
    if (stopped || current !== generation) return
    const ready = await ensureImageReady(candidate)
    if (stopped || current !== generation) return
    if (!ready) continue
    image.value = candidate
    if (candidate !== props.image) {
      selected.value = candidate
      lastImage.value = `i:${images.indexOf(candidate)}`
    }
    return
  }
  image.value = ''
}

onBeforeUnmount(() => {
  stopped = true
  generation++
  if (idleId !== undefined) window.cancelIdleCallback(idleId)
  clearTimeout(preloadTimer)
  pending.forEach(cancel => cancel())
})
const stars = ref<{ transform: string; transformOrigin: string }[]>([])
onMounted(() => {
  void resolveImage().then(() => { if (!stopped) schedulePreload() })
  watch(() => props.image, () => { void resolveImage() })
  stars.value = Array.from({ length: 800 }, () => {
    const radius = 800 + Math.random() * 300
    const scale = .2 + Math.random()
    return {
      transformOrigin: `0 0 ${radius}px`,
      transform: `translate3d(0,0,-${radius}px) rotateY(${Math.random() * 360}deg) rotateX(${Math.random() * -50}deg) scale(${scale},${scale})`,
    }
  })
})
</script>

<style scoped>
.site-banner { height: 363px; position: relative; overflow: hidden; display: grid; place-items: center; background-position: center; background-size: cover; color: white; }
.site-banner::after { content: ''; position: absolute; inset: 76% 0 0; background: linear-gradient(transparent,var(--bg)); }
.banner-content { position: relative; z-index: 10; text-align: center; padding: 16px; }
.star-field { position: absolute; top: 0; left: 0; width: 100%; height: 180%; overflow: hidden; pointer-events: none; }
.stars { position: absolute; left: 50%; bottom: 0; transform: perspective(400px) rotateZ(20deg) rotateX(-40deg) rotateY(0); transform-style: preserve-3d; perspective-origin: 50% 100%; animation: sky-turn 90s linear infinite; }
.stars i { width: 2px; height: 2px; position: absolute; top: 0; left: 0; background: #f7f7b6; backface-visibility: hidden; }
@keyframes sky-turn {
  from { transform: perspective(400px) rotateZ(20deg) rotateX(-40deg) rotateY(0); }
  to { transform: perspective(400px) rotateZ(20deg) rotateX(-40deg) rotateY(-360deg); }
}
@media (min-width: 640px) { .star-field { height: 160%; } }
@media (min-width: 768px) { .star-field { height: 150%; } }
.banner-waves { position: absolute; bottom: 0; width: 100%; height: 71px; z-index: 11; pointer-events: none; }
.banner-waves use { fill: color-mix(in srgb,var(--bg) 85%,transparent); animation: wave-drift 7s cubic-bezier(.55,.5,.45,.5) infinite; }
.banner-waves use:nth-child(2) { opacity: .59; animation-duration: 10s; animation-delay: -3s; }
.banner-waves use:nth-child(3) { opacity: .26; animation-duration: 13s; animation-delay: -4s; }
.banner-waves use:nth-child(4) { opacity: .06; animation-duration: 20s; animation-delay: -5s; }
@keyframes wave-drift { from { transform: translateX(-90px); } to { transform: translateX(85px); } }
@media (max-width: 767px) { .site-banner { height: 296px; } }
@media (max-width: 639px) { .site-banner { height: 240px; } .banner-waves { height: 28px; } }
@media (prefers-reduced-motion: reduce) { .stars, .banner-waves use { animation: none; } }
</style>
