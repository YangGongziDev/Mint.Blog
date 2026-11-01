<template>
  <NuxtRouteAnnouncer />
  <NuxtLoadingIndicator />
  <NuxtLayout><NuxtPage /></NuxtLayout>
</template>

<script setup lang="ts">
const { locale, isDark, primaryColor } = useSitePreferences()
useHead(() => ({ htmlAttrs: { lang: locale.value, 'data-theme': isDark.value ? 'dark' : 'light', style: { '--primary': primaryColor.value } } }))
</script>
