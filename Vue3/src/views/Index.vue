<template>
  <router-view />
</template>

<script setup lang="ts">

import { onMounted, onUnmounted, watch } from 'vue'
import { useBlogSettingsStore } from '@/stores/blogsettings'
import { useAutoTheme } from '@/composables/useAutoTheme'


// 博客设置 store
const blogSettingsStore = useBlogSettingsStore()
// 自动主题功能
const { setAutoThemeEnabled } = useAutoTheme()
// 监听博客设置中的自动主题开关
watch(
  () => blogSettingsStore.blogSettings.isAutoTheme,
  (isAutoTheme) => {
    if (isAutoTheme !== undefined) {
      setAutoThemeEnabled(isAutoTheme)
    }
  },
  { immediate: true }
)
// 应用启动时获取博客设置
onMounted(() => {
  blogSettingsStore.getBlogSettings();
})


// 已移除移动端检测与警告逻辑

// 页面点击文字特效：核心价值观随机显示
const coreValues = [
  '富强', '民主', '文明', '和谐',
  '自由', '平等', '公正', '法治',
  '爱国', '敬业', '诚信', '友善'
]

const brightColors = [
  '#3b82f6', // primary
  '#8b5cf6', // accent
  '#10b981', // success
  '#f59e0b', // warning
  '#ef4444', // error
  '#06b6d4', // info
]

// 安全随机取值函数：兼容 noUncheckedIndexedAccess，确保返回 T
const pickRandom = <T>(arr: T[], fallback: T): T => {
  const len = arr.length
  if (len === 0) return fallback
  const item = arr[Math.floor(Math.random() * len)]
  return (item ?? fallback)
}

const handleClick = (e: MouseEvent) => {
  // 统一展示点击特效

  const text = pickRandom(coreValues, '富强')
  const span = document.createElement('span')
  span.textContent = text

  // 随机颜色和大小（使用鲜亮调色板）
  const color = pickRandom(brightColors, '#3b82f6')
  const fontSize = 14 + Math.floor(Math.random() * 6) // 14-20px
  // 更快的飘走并消失（600-900ms之间随机）
  const duration = 600 + Math.floor(Math.random() * 300)

  // 使用 client 坐标，避免滚动造成位置偏差
  const x = e.clientX
  const y = e.clientY

  // 基础样式
  span.style.position = 'fixed'
  span.style.left = `${x}px`
  span.style.top = `${y - 20}px`
  span.style.zIndex = '999999'
  span.style.pointerEvents = 'none'
  span.style.userSelect = 'none'
  span.style.fontWeight = 'bold'
  span.style.color = color
  span.style.fontSize = `${fontSize}px`
  span.style.transform = 'translate(-50%, -50%)'
  span.style.whiteSpace = 'nowrap'
  span.style.textShadow = '0 2px 8px rgba(0,0,0,0.15)'
  // 使用过渡而非动画，避免 scoped 样式下 @keyframes 可能不生效的问题
  span.style.transition = `transform ${duration}ms ease-out, opacity ${duration}ms ease-out`
  span.style.opacity = '1'

  document.body.appendChild(span)
  // 触发过渡
  requestAnimationFrame(() => {
    requestAnimationFrame(() => {
      span.style.transform = 'translate(-50%, -50%) translateY(-60px)'
      span.style.opacity = '0'
    })
  })
  // 在过渡结束后移除元素
  setTimeout(() => span.remove(), duration + 80)
}

onMounted(() => {
  window.addEventListener('click', handleClick)
})

onUnmounted(() => {
  window.removeEventListener('click', handleClick)
})
</script>

<style scoped lang="scss">

/* 点击文字上浮淡出动画（作用于全局创建的元素） */
@keyframes floatUpFade {
  0% {
    transform: translate(-50%, -50%) translateY(0);
    opacity: 1;
  }
  100% {
    transform: translate(-50%, -50%) translateY(-60px);
    opacity: 0;
  }
}

</style>