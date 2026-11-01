<template>
  <footer class="site-footer">
    <div ref="animals" class="footer-animals" :style="{ visibility: animalsVisible ? 'visible' : 'hidden' }"><img src="~/assets/images/animals.png" alt="" width="660"></div>
    <div v-show="!animalsVisible" class="fixed-animals" aria-hidden="true"><img src="~/assets/images/animals.png" alt="" width="660"></div>
    <div class="footer-main">
      <p class="footer-line"><img :src="assetUrl(settings?.avatar) || defaultAvatar" alt="" width="30" height="30"><span>© 2025–{{ year }} <NuxtLink to="/author">{{ settings?.author || '程序员杨工子' }}</NuxtLink> · All Rights Reserved.</span></p>
      <p class="footer-line"><img :src="assetUrl(settings?.logo) || defaultAvatar" alt="" width="30" height="30"><span>{{ text('基于开源项目', 'Powered by') }} <a href="https://gitee.com/YangGongziDev/Mint.Blog" target="_blank" rel="noopener noreferrer">Mint.Blog</a> {{ text('构建', '') }}</span></p>
      <!-- <p v-if="settings?.copyrightDeclaration">{{ settings.copyrightDeclaration }}</p> -->
      <!-- <p class="text-sm text-[#60786e] transition-colors duration-300 dark:text-[#cbd5e1] lg:text-base">
        <span>最终解释权归作者</span>
        <span class="login-footnote-author"><NuxtLink to="/author">{{ settings?.author || '程序员杨工子' }}</NuxtLink></span>
        <span>所有 2026-{{ new Date().getFullYear() }}</span>
      </p> -->
    </div>
  </footer>
</template>

<script setup lang="ts">
import type { SiteSettings } from '~/composables/useSiteSettings'
import defaultAvatar from '~/assets/images/avatar.svg'
defineProps<{ settings?: SiteSettings | null }>()
const assetUrl = useAssetUrl()
const { text } = useSitePreferences()
const year = new Date().getFullYear()
const animals = ref<HTMLElement>()
const animalsVisible = ref(false)
let observer: IntersectionObserver | undefined
onMounted(() => {
  observer = new IntersectionObserver(entries => {
    const entry = entries[0]
    animalsVisible.value = !!entry?.isIntersecting && entry.intersectionRatio >= 1
  }, { threshold: [0, 1] })
  if (animals.value) observer.observe(animals.value)
})
onBeforeUnmount(() => observer?.disconnect())
</script>
