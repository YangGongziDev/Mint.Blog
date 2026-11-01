<template>
  <div class="site-shell">
    <a class="skip-link" href="#main">{{ text('跳到正文', 'Skip to content') }}</a>
    <SiteHeader :settings="settings" />
    <div v-if="error" class="settings-error" role="alert">
      {{ text('站点设置加载失败，当前显示基础布局。', 'Site settings could not be loaded. Showing the base layout.') }}
      <button type="button" :disabled="status === 'pending'" @click="refresh()">{{ text('重试', 'Retry') }}</button>
    </div>
    <p v-else-if="status === 'pending'" role="status">{{ text('正在加载设置…', 'Loading settings…') }}</p>
    <main id="main"><slot /></main>
    <SiteFooter v-if="footerVisible" :settings="settings" />
    <FloatingTools />
    <ClickCoreValues />
  </div>
</template>

<script setup lang="ts">
const { data: settings, error, status, refresh } = await useSiteSettings()
const { text, footerVisible } = useSitePreferences()
</script>

