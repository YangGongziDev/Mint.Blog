<template>
  <div class="app-logo">
    <img class="logo" :src="logoSrc" alt="no logoSvg" @error="handleError" />
  </div>
</template>

<script setup lang="ts">
import { computed, ref, watch } from 'vue';
import logoSvg from '@/assets/system/svg/logo.svg';

interface Props {
  src?: string;
}

const props = defineProps<Props>();
const loadFailed = ref(false);
const logoSrc = computed(() => (!loadFailed.value && props.src ? props.src : logoSvg));

watch(
  () => props.src,
  () => {
    loadFailed.value = false;
  }
);

function handleError() {
  if (logoSrc.value !== logoSvg) loadFailed.value = true;
}
</script>

<style>
.app-logo {
  position: relative;
  width: var(--lw, 48px);
  height: var(--lh, 48px);
}

.app-logo .logo {
  display: block;
  width: 100%;
  height: 100%;
  object-fit: contain;
}
</style>

<style scoped>
.app-logo {
  --logo-color-300: rgb(var(--primary-300-color));
  --logo-color-400: rgb(var(--primary-400-color));
  --logo-color-500: rgb(var(--primary-500-color));
  --logo-color-600: rgb(var(--primary-600-color));
  --logo-color-700: rgb(var(--primary-700-color));
}
</style>
