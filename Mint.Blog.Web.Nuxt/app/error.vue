<template>
  <NuxtLayout>
    <section class="preview-panel" role="alert">
      <h1>{{ error.statusCode }}</h1>
      <p>{{ error.statusCode === 404 ? text('找不到此页面', 'Page not found') : text('页面暂时无法加载', 'This page is temporarily unavailable') }}</p>
      <button type="button" @click="clearError({ redirect: '/' })">{{ text('返回首页', 'Return home') }}</button>
    </section>
  </NuxtLayout>
</template>

<script setup lang="ts">
import type { NuxtError } from '#app'
defineProps<{ error: NuxtError }>()
const { text, locale, isDark, primaryColor } = useSitePreferences()
useHead(() => ({ title: text('页面错误', 'Page error'), htmlAttrs: { lang: locale.value, 'data-theme': isDark.value ? 'dark' : 'light', style: { '--primary': primaryColor.value } } }))
</script>
