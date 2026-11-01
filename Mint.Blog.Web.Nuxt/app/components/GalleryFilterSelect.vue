<template>
  <details ref="root" class="gallery-select" @keydown.esc="escape">
    <summary ref="trigger" :aria-label="label">
      <span>{{ options.find(option => option.value === value)?.label || label }}</span>
      <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="m6 9 6 6 6-6" /></svg>
    </summary>
    <div class="select-options" role="group" :aria-label="label">
      <button v-for="option in options" :key="option.value" type="button" :aria-pressed="option.value === value" @click="select(option.value)">{{ option.label }}</button>
    </div>
  </details>
</template>

<script setup lang="ts">
const value = defineModel<string>({ required: true })
defineProps<{ label: string; options: { value: string; label: string }[] }>()
const root = ref<HTMLDetailsElement>()
const trigger = ref<HTMLElement>()
function close() {
  if (root.value) root.value.open = false
}
function select(next: string) {
  value.value = next
  close()
  trigger.value?.focus()
}
function outside(event: PointerEvent) {
  if (event.target instanceof Node && !root.value?.contains(event.target)) close()
}
function escape(event: KeyboardEvent) {
  if (!root.value?.open) return
  event.preventDefault()
  event.stopPropagation()
  close()
  trigger.value?.focus()
}
onMounted(() => document.addEventListener('pointerdown', outside))
onBeforeUnmount(() => document.removeEventListener('pointerdown', outside))
</script>

<style scoped>
.gallery-select{position:relative;min-width:140px;max-width:100%;font:inherit}
.gallery-select[open]{z-index:20}
summary{display:flex;align-items:center;justify-content:space-between;gap:16px;min-height:38px;box-sizing:border-box;border:1px solid #3ecf9a4d;border-radius:99px;padding:6px 16px;background:var(--surface);color:var(--text);cursor:pointer;list-style:none}
summary::-webkit-details-marker{display:none}
summary span{min-width:0;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
summary svg{flex-shrink:0}
summary:focus-visible{outline:2px solid var(--primary);outline-offset:2px}
.select-options{position:absolute;top:calc(100% + 8px);left:0;min-width:100%;width:max-content;max-width:min(320px,calc(100vw - 64px));max-height:240px;overflow:auto;box-sizing:border-box;padding:6px;border:1px solid var(--border);border-radius:12px;background:var(--surface);box-shadow:0 8px 24px #0003}
.select-options button{display:block;width:100%;border:0;border-radius:6px;padding:9px 12px;text-align:left;overflow-wrap:anywhere;background:transparent;color:var(--text);font:inherit;cursor:pointer}
.select-options button:hover,.select-options button:focus-visible,.select-options button[aria-pressed="true"]{background:color-mix(in srgb,var(--primary) 14%,var(--surface));color:var(--primary)}
@media(max-width:640px){.gallery-select{width:100%;font-size:16px}.select-options{width:100%;max-width:100%}}
</style>
