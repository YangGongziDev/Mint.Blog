<template>
  <header class="site-header" @keydown.esc="open = false">
    <NuxtLink to="/" class="brand" :aria-label="text('首页', 'Home')">
      <img :src="assetUrl(settings?.avatar) || defaultAvatar" alt="" width="35" height="35">
      <span>{{ settings?.author || '程序员杨工子' }}</span>
    </NuxtLink>
    <button class="menu-toggle icon-button" type="button" aria-controls="site-navigation" :aria-expanded="open" :aria-label="text('菜单', 'Menu')" @click="open = !open"><SiteIcon name="menu" /></button>
    <nav id="site-navigation" :class="{ open }" :aria-label="text('主导航', 'Main navigation')">
      <NuxtLink v-for="item in menus" :key="item.key" :class="{ 'menu-active': isMenuActive(item.target) }" :to="item.target" @click="open = false"><SiteIcon :name="item.key" />{{ locale === 'zh' ? item.zh : item.en }}</NuxtLink>
      <details ref="aboutMenu" class="about-menu" @keydown.esc="closeAboutMenu"><summary :class="{ 'menu-active': aboutActive }"><SiteIcon name="about" />{{ text('关于', 'About') }}<span aria-hidden="true">⌄</span></summary><div class="about-links"><NuxtLink v-for="item in aboutMenus" :key="item.key" :class="{ 'menu-active': isMenuActive(item.target) }" :to="item.target" @click="open = false; closeAboutMenu()"><SiteIcon :name="item.key" />{{ locale === 'zh' ? item.zh : item.en }}</NuxtLink></div></details>
    </nav>
    <div class="header-tools">
      <HeaderSearch />
      <a class="icon-button" :href="adminUrl" :title="text('后台', 'Admin')" :aria-label="text('后台', 'Admin')"><SiteIcon name="dashboard" /></a>
      <button class="icon-button" :title="text('切换语言', 'Change language')" :aria-label="text('切换语言', 'Change language')" @click="locale = locale === 'zh' ? 'en' : 'zh'"><SiteIcon name="language" /></button>
      <button class="icon-button theme-switch" type="button" :title="themeSwitchLabel" :aria-label="themeSwitchLabel" @click="cycleTheme">
        <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
          <template v-if="theme === 'system'"><rect x="3" y="4" width="18" height="13" rx="2" /><path d="M8 21h8m-4-4v4" /></template>
          <template v-else-if="theme === 'light'"><circle cx="12" cy="12" r="4" /><path d="M12 2v2m0 16v2M2 12h2m16 0h2M5 5l1.5 1.5m11 11L19 19M5 19l1.5-1.5m11-11L19 5" /></template>
          <path v-else d="M20.5 13A8.5 8.5 0 0 1 11 3.5 8.5 8.5 0 1 0 20.5 13Z" />
        </svg>
      </button>
      <button class="icon-button" type="button" aria-haspopup="dialog" aria-controls="site-preferences" :aria-expanded="preferencesOpen" :title="text('设置', 'Settings')" :aria-label="text('设置', 'Settings')" @click="openPreferences"><svg viewBox="0 0 24 24" width="22" height="22" aria-hidden="true"><path d="M4 3h7v15a3.5 3.5 0 0 1-7 0V3Zm7 3 7 4-7 12M14 14h7v7H8" fill="none" stroke="currentColor" stroke-width="1.7"/><circle cx="7.5" cy="17.5" r="1" fill="currentColor"/></svg></button>
    </div>
    <dialog id="site-preferences" ref="preferences" class="preferences-dialog" aria-labelledby="preferences-title" @close="preferencesOpen = false" @click="($event.target === preferences) && preferences?.close()">
      <section class="preferences-panel">
        <div class="preferences-heading"><h2 id="preferences-title">{{ text('站点设置', 'Site preferences') }}</h2><button type="button" autofocus @click="preferences?.close()">{{ text('关闭', 'Close') }}</button></div>
        <label class="preference-field"><span>{{ text('主题', 'Theme') }}</span><select v-model="theme"><option value="system">{{ text('自动（跟随系统）', 'Auto (system)') }}</option><option value="light">{{ text('日间', 'Light') }}</option><option value="dark">{{ text('夜间', 'Dark') }}</option></select></label>
        <label class="preference-field"><span>{{ text('语言', 'Language') }}</span><select v-model="locale"><option value="zh">中文</option><option value="en">English</option></select></label>
        <fieldset class="preference-primary">
          <legend>{{ text('主题主色', 'Primary theme color') }}</legend>
          <div class="preference-presets">
            <button v-for="preset in primaryColorPresets" :key="preset.color" type="button" class="preference-swatch" :style="{ '--swatch-color': preset.color }" :aria-label="`${text(preset.zh, preset.en)} ${preset.color}`" :title="`${text(preset.zh, preset.en)} ${preset.color}`" :aria-pressed="primaryColor === preset.color" @click="primaryColor = preset.color">
              <svg v-if="primaryColor === preset.color" viewBox="0 0 24 24" width="20" height="20" aria-hidden="true"><path d="m5 12 4 4L19 6" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" /></svg>
            </button>
          </div>
          <label class="preference-field preference-custom-color"><span>{{ text('自定义颜色', 'Custom color') }}</span><span class="preference-color"><input v-model="primaryColor" type="color"><code>{{ primaryColor }}</code></span></label>
        </fieldset>
        <label class="preference-field"><span>{{ text('显示页脚', 'Show footer') }}</span><input v-model="footerVisible" type="checkbox"></label>
        <button type="button" @click="resetPrimaryColorAndFooter">{{ text('仅恢复主色与页脚默认值', 'Reset only primary color and footer') }}</button>
        <p>{{ text('偏好保存在当前浏览器中，刷新后继续生效。', 'Preferences are saved in this browser and retained after refresh.') }}</p>
      </section>
    </dialog>
  </header>
</template>

<script setup lang="ts">
import type { SiteSettings } from '~/composables/useSiteSettings'
import defaultAvatar from '~/assets/images/avatar.svg'
defineProps<{ settings?: SiteSettings | null }>()
const { theme, locale, primaryColor, footerVisible, resetPrimaryColorAndFooter, text } = useSitePreferences()
const primaryColorPresets = [
  { color: '#ee2b7f', zh: '默认粉', en: 'Default pink' },
  { color: '#3ecf9a', zh: '薄荷绿', en: 'Mint green' },
  { color: '#539dfd', zh: '晴空蓝', en: 'Sky blue' },
  { color: '#4f7cff', zh: '靛蓝', en: 'Indigo' },
  { color: '#a543e6', zh: '紫罗兰', en: 'Violet' },
  { color: '#f5a630', zh: '琥珀橙', en: 'Amber' }
]
const themeLabel = computed(() => theme.value === 'system' ? text('自动（跟随系统）', 'Auto (system)') : theme.value === 'light' ? text('日间', 'Light') : text('夜间', 'Dark'))
const themeSwitchLabel = computed(() => `${text('当前主题', 'Current theme')}：${themeLabel.value}；${text('点击切换：自动 → 日间 → 夜间', 'Click to switch: Auto → Light → Dark')}`)
function cycleTheme() {
  theme.value = theme.value === 'system' ? 'light' : theme.value === 'light' ? 'dark' : 'system'
}
const adminSiteUrl = useRuntimeConfig().public.adminSiteUrl
const adminUrl = adminSiteUrl ? new URL('/home', adminSiteUrl).href : undefined
const assetUrl = useAssetUrl()
const open = ref(false)
const aboutMenu = ref<HTMLDetailsElement>()
function closeAboutMenu() {
  if (aboutMenu.value) aboutMenu.value.open = false
}
function handleOutsideClick(event: MouseEvent) {
  if (event.target instanceof Node && !aboutMenu.value?.contains(event.target)) closeAboutMenu()
}
onMounted(() => document.addEventListener('click', handleOutsideClick))
onBeforeUnmount(() => document.removeEventListener('click', handleOutsideClick))
const route = useRoute()
function isMenuActive(target: string) {
  return route.path === target || (target !== '/' && route.path.startsWith(`${target}/`))
}
watch(() => route.path, () => { open.value = false; closeAboutMenu() })
const preferences = ref<HTMLDialogElement>()
const preferencesOpen = ref(false)
const menus = [
  { key: 'dashboard', target: '/dashboard', zh: '看板', en: 'Dashboard' },
  { key: 'home', target: '/', zh: '首页', en: 'Home' },
  { key: 'column', target: '/columns', zh: '专栏', en: 'Columns' },
  { key: 'resource', target: '/resources', zh: '资源', en: 'Resources' },
  { key: 'archive', target: '/archives', zh: '归档', en: 'Archives' },
  { key: 'gallery', target: '/gallery', zh: '图库', en: 'Gallery' },
  { key: 'friend', target: '/friends', zh: '友链', en: 'Friends' },
  { key: 'message', target: '/messages', zh: '留言', en: 'Messages' }
]
const aboutMenus = [
  { key: 'author', target: '/author', zh: '作者', en: 'Author' },
  { key: 'about', target: '/about', zh: '系统', en: 'About' },
  { key: 'equipment', target: '/equipment', zh: '设备', en: 'Equipment' }
]
const aboutActive = computed(() => aboutMenus.some(item => isMenuActive(item.target)))
function openPreferences() {
  open.value = false
  preferences.value?.showModal()
  preferencesOpen.value = !!preferences.value?.open
}
onBeforeUnmount(() => preferences.value?.close())
</script>

<style scoped>
.preference-primary { min-width: 0; margin: 24px 0; padding: 0; border: 0; }
.preference-primary legend { margin-bottom: 12px; padding: 0; }
.preference-presets { display: flex; flex-wrap: wrap; gap: 10px; }
.preference-presets .preference-swatch { display: grid; place-items: center; width: 40px; height: 40px; padding: 0; border: 2px solid transparent; border-radius: 50%; background: var(--swatch-color); color: #fff; cursor: pointer; }
.preference-swatch svg { filter: drop-shadow(0 1px 1px #0008); }
.preference-swatch[aria-pressed="true"] { box-shadow: 0 0 0 2px var(--surface), 0 0 0 4px var(--swatch-color); }
.preference-swatch:focus-visible { outline: 2px solid var(--text); outline-offset: 4px; }
.preference-custom-color { flex-wrap: wrap; margin: 16px 0 0; }
</style>
