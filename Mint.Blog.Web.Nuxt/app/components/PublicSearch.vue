<template>
  <section class="public-search">
    <form action="/search" @submit.prevent="submit"><label>搜索文章<input v-model="input" name="keyword" type="search" placeholder="输入关键词…" autocomplete="off" @input="onInput" @compositionstart="onCompositionStart" @compositionend="onCompositionEnd"></label><input type="hidden" name="pageNumber" value="1"><input type="hidden" name="pageSize" :value="pageSize"><button type="submit">搜索</button></form>
    <p v-if="status === 'pending'" role="status">搜索中…</p><p v-else-if="error" role="alert">搜索暂时不可用，请修改关键词重试。</p>
    <template v-else-if="data"><p role="status">找到 {{ data.totalCount }} 篇文章</p><ul><li v-for="item in data.items" :key="item.id"><NuxtLink :to="`/articles/${encodeURIComponent(item.id)}`" @click="emit('navigate')"><template v-for="(part, index) in parts(item.title)" :key="index"><mark v-if="part.match">{{ part.text }}</mark><template v-else>{{ part.text }}</template></template></NuxtLink><p>{{ item.summary }}</p></li></ul><p v-if="!data.items.length">没有找到相关文章</p><nav v-if="data.totalPages > 1" aria-label="搜索分页"><button :disabled="page <= 1" @click="search(page - 1)">上一页</button><span>{{ page }} / {{ data.totalPages }}</span><button :disabled="page >= data.totalPages" @click="search(page + 1)">下一页</button></nav></template>
    <p v-else>输入关键词搜索文章标题和摘要。</p>
  </section>
</template>

<script setup lang="ts">
const props = withDefaults(defineProps<{ keyword?: string; pageNumber?: number; pageSize?: number }>(), { keyword: '', pageNumber: 1, pageSize: 8 })
const emit = defineEmits<{ navigate: [] }>()
const route = useRoute()
const router = useRouter()
const input = ref(props.keyword)
// 同一轮路由更新的搜索参数一起提交，避免请求新关键词与旧页码的中间组合。
const parameters = shallowRef({ keyword: props.keyword.trim(), pageNumber: props.pageNumber, pageSize: props.pageSize })
watch(() => [props.keyword, props.pageNumber, props.pageSize] as const, ([value, pageNumber, pageSize]) => {
  parameters.value = { keyword: value.trim(), pageNumber, pageSize }
})
const keyword = computed(() => parameters.value.keyword)
const page = computed(() => parameters.value.pageNumber)
const api = usePublicApi()
interface SearchItem { id: string; title: string; summary: string }
const key = computed(() => JSON.stringify(['search', parameters.value]))
const { data, status, error } = await useAsyncData(key, async () => {
  const { keyword, pageNumber, pageSize } = parameters.value
  if (!keyword) return null
  const result = await api<{ success: boolean; data: { items: SearchItem[]; totalCount: number; totalPages: number } }>('article/search', { query: { keyword, pageNumber, pageSize } })
  if (!result.success) throw new Error('搜索失败')
  return { ...result.data, totalPages: Math.ceil(result.data.totalCount / pageSize) }
})
let timer: ReturnType<typeof setTimeout> | undefined
let isComposing = false
function search(number = 1) {
  clearTimeout(timer)
  if (isComposing) return
  const value = input.value.trim()
  const pageNumber = value !== keyword.value ? 1 : number
  return router.push({ path: '/search', query: { ...route.query, keyword: value || undefined, pageNumber: String(pageNumber), pageSize: String(props.pageSize) }, hash: route.hash })
}
function onCompositionStart() {
  isComposing = true
  clearTimeout(timer)
}
function onCompositionEnd(event: CompositionEvent) {
  isComposing = false
  input.value = (event.target as HTMLInputElement).value
  onInput(event)
}
function onInput(event: Event) {
  clearTimeout(timer)
  if (isComposing || (event as InputEvent).isComposing) return
  timer = setTimeout(() => { void search() }, 300)
}
function submit() {
  if (isComposing) return
  void search()
  emit('navigate')
}
watch(() => route.fullPath, () => { clearTimeout(timer); input.value = typeof route.query.keyword === 'string' ? route.query.keyword : '' }, { flush: 'sync' })
onBeforeUnmount(() => clearTimeout(timer))
function parts(title: string) {
  const needle = keyword.value.toLocaleLowerCase()
  if (!needle) return [{ text: title, match: false }]
  const result: { text: string; match: boolean }[] = []
  let offset = 0
  while (offset < title.length) {
    const index = title.toLocaleLowerCase().indexOf(needle, offset)
    if (index < 0) { result.push({ text: title.slice(offset), match: false }); break }
    if (index > offset) result.push({ text: title.slice(offset, index), match: false })
    result.push({ text: title.slice(index, index + needle.length), match: true }); offset = index + needle.length
  }
  return result
}
</script>

<style scoped>
form{display:flex;gap:12px;align-items:end}label{flex:1;min-width:0}input[type=search]{display:block;width:100%;padding:12px;border:1px solid var(--border);background:var(--bg);color:var(--text);border-radius:8px;font:inherit}form button{padding:12px}ul{list-style:none;padding:0}li{padding:16px 0;border-bottom:1px solid var(--border);overflow-wrap:anywhere}li a{font-size:18px}li p{color:var(--muted);margin-bottom:0}mark{background:#3ecf9a40;color:inherit;border-radius:3px}nav{display:flex;justify-content:center;gap:16px}
</style>
