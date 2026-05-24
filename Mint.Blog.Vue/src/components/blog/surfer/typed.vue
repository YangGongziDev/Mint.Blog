<script setup lang="ts">
import { computed, onBeforeUnmount, ref, watch } from 'vue';

defineOptions({ name: 'SurferTyped' });

const props = withDefaults(
  defineProps<{
    texts: string[];
    loop?: boolean;
    typeSpeed?: number;
    deleteSpeed?: number;
    pause?: number;
  }>(),
  {
    loop: true,
    typeSpeed: 100,
    deleteSpeed: 30,
    pause: 2000
  }
);

const currentText = ref('');
const cursorVisible = ref(true);
const cursorRef = ref<ReturnType<typeof setInterval>>();
const textList = computed(() => props.texts.map(text => String(text || '')).filter(Boolean));
const textKey = computed(() => textList.value.join('\u0001'));
let timer: ReturnType<typeof setTimeout> | null = null;

function clearTimer() {
  if (timer) clearTimeout(timer);
  timer = null;
}

function typeText(text: string, onDone?: () => void) {
  clearTimer();
  currentText.value = '';

  const chars = Array.from(text);
  let index = 0;

  function step() {
    index += 1;
    currentText.value = chars.slice(0, index).join('');

    if (index < chars.length) {
      timer = setTimeout(step, props.typeSpeed);
      return;
    }

    timer = null;
    onDone?.();
  }

  if (!chars.length) return;
  timer = setTimeout(step, props.typeSpeed);
}

function deleteText(onDone: () => void) {
  clearTimer();

  let chars = Array.from(currentText.value);

  function step() {
    chars = chars.slice(0, -1);
    currentText.value = chars.join('');

    if (chars.length > 0) {
      timer = setTimeout(step, props.deleteSpeed);
      return;
    }

    timer = null;
    onDone();
  }

  timer = setTimeout(step, props.deleteSpeed);
}

function startLoop() {
  const texts = textList.value;
  if (!texts.length) {
    currentText.value = '';
    return;
  }

  let index = 0;

  function playCurrent() {
    typeText(texts[index], () => {
      if (!props.loop) return;

      timer = setTimeout(() => {
        deleteText(() => {
          index = (index + 1) % texts.length;
          playCurrent();
        });
      }, props.pause);
    });
  }

  playCurrent();
}

function restart() {
  clearTimer();
  currentText.value = '';
  startLoop();
}

cursorRef.value = setInterval(() => {
  cursorVisible.value = !cursorVisible.value;
}, 500);

watch(
  () => [textKey.value, props.loop, props.typeSpeed, props.deleteSpeed, props.pause] as const,
  restart,
  { immediate: true }
);

onBeforeUnmount(() => {
  clearTimer();
  if (cursorRef.value) clearInterval(cursorRef.value);
});
</script>

<template>
  <span class="typed-content"><span class="typed-text">{{ currentText }}</span><span class="typed-cursor" :class="{ blink: cursorVisible }">|</span></span>
</template>

<style scoped>
.typed-content {
  display: inline;
  white-space: inherit;
}

.typed-text,
.typed-cursor {
  display: inline;
}

.typed-cursor {
  margin-left: 0.08em;
  opacity: 0;
  transition: opacity 0.1s;
}

.typed-cursor.blink {
  opacity: 1;
}
</style>
