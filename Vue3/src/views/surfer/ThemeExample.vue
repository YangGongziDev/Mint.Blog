<template>
  <div class="theme-example theme-bg-primary p-6">
    <!-- 主题切换开关 -->
    <div class="mb-6 flex items-center justify-between">
      <h1 class="theme-text-primary text-2xl font-bold">通用主题系统示例</h1>
      <label class="theme-switch">
        <input type="checkbox" :checked="darkSwitch" @change="toggleDark()">
        <span class="theme-switch-slider"></span>
      </label>
    </div>

    <!-- 主题信息 -->
    <div class="theme-card p-4 mb-6">
      <h2 class="theme-text-primary text-lg font-semibold mb-2">当前主题信息</h2>
      <div class="space-y-2">
        <p class="theme-text-secondary">
          <span class="font-medium">主题名称:</span> 
          {{ currentThemeConfig.displayName }} {{ currentThemeConfig.icon }}
        </p>
        <p class="theme-text-secondary">
          <span class="font-medium">主题模式:</span> 
          {{ themeName }}
        </p>
        <p class="theme-text-secondary">
          <span class="font-medium">主色调:</span> 
          <span class="inline-block w-4 h-4 rounded ml-2" 
                :style="{ backgroundColor: currentThemeConfig.colors.primary }"></span>
          {{ currentThemeConfig.colors.primary }}
        </p>
      </div>
    </div>

    <!-- 组件示例 -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <!-- 卡片示例 -->
      <div class="theme-card p-4">
        <h3 class="theme-text-primary font-semibold mb-3">卡片组件</h3>
        <p class="theme-text-secondary mb-4">这是一个使用主题系统的卡片组件示例。</p>
        <div class="flex gap-2">
          <button class="theme-btn">主要按钮</button>
          <button class="theme-btn-secondary">次要按钮</button>
        </div>
      </div>

      <!-- 表单示例 -->
      <div class="theme-card p-4">
        <h3 class="theme-text-primary font-semibold mb-3">表单组件</h3>
        <div class="space-y-3">
          <input 
            type="text" 
            placeholder="请输入内容" 
            class="theme-input w-full"
            v-model="inputValue"
          >
          <textarea 
            placeholder="请输入描述" 
            class="theme-input w-full h-20 resize-none"
            v-model="textareaValue"
          ></textarea>
        </div>
      </div>

      <!-- 导航示例 -->
      <div class="theme-card p-4">
        <h3 class="theme-text-primary font-semibold mb-3">导航组件</h3>
        <nav class="space-y-2">
          <a href="#" class="theme-nav-item block" :class="{ active: activeNav === 'home' }" @click="activeNav = 'home'">首页</a>
          <a href="#" class="theme-nav-item block" :class="{ active: activeNav === 'about' }" @click="activeNav = 'about'">关于</a>
          <a href="#" class="theme-nav-item block" :class="{ active: activeNav === 'contact' }" @click="activeNav = 'contact'">联系</a>
        </nav>
      </div>
    </div>

    <!-- 颜色变量示例 -->
    <div class="theme-card p-4 mt-6">
      <h3 class="theme-text-primary font-semibold mb-3">CSS 变量示例</h3>
      <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
        <div class="text-center">
          <div class="w-full h-12 rounded mb-2" style="background-color: var(--theme-bg-primary)"></div>
          <p class="theme-text-tertiary text-sm">主背景</p>
        </div>
        <div class="text-center">
          <div class="w-full h-12 rounded mb-2" style="background-color: var(--theme-bg-secondary)"></div>
          <p class="theme-text-tertiary text-sm">次背景</p>
        </div>
        <div class="text-center">
          <div class="w-full h-12 rounded mb-2" style="background-color: var(--theme-accent)"></div>
          <p class="theme-text-tertiary text-sm">强调色</p>
        </div>
        <div class="text-center">
          <div class="w-full h-12 rounded mb-2 border-2" style="border-color: var(--theme-border)"></div>
          <p class="theme-text-tertiary text-sm">边框色</p>
        </div>
      </div>
    </div>

    <!-- 使用说明 -->
    <div class="theme-card p-4 mt-6">
      <h3 class="theme-text-primary font-semibold mb-3">使用说明</h3>
      <div class="theme-text-secondary space-y-2 text-sm">
        <p><strong>1. 引入主题系统:</strong></p>
        <pre class="theme-bg-tertiary p-2 rounded text-xs overflow-x-auto"><code>import { useTheme } from '@/composables/useTheme'</code></pre>
        
        <p><strong>2. 在组件中使用:</strong></p>
        <pre class="theme-bg-tertiary p-2 rounded text-xs overflow-x-auto"><code>const { isDark, darkSwitch, toggleDark, themeClass } = useTheme()</code></pre>
        
        <p><strong>3. 使用主题类名:</strong></p>
        <pre class="theme-bg-tertiary p-2 rounded text-xs overflow-x-auto"><code>&lt;div class="theme-card theme-text-primary"&gt;内容&lt;/div&gt;</code></pre>
        
        <p><strong>4. 使用CSS变量:</strong></p>
        <pre class="theme-bg-tertiary p-2 rounded text-xs overflow-x-auto"><code>background-color: var(--theme-bg-primary);</code></pre>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useTheme } from '@/composables/useTheme'

// 使用主题系统
const { 
  isDark, 
  darkSwitch, 
  toggleDark, 
  themeName, 
  currentThemeConfig 
} = useTheme()

// 示例数据
const inputValue = ref('')
const textareaValue = ref('')
const activeNav = ref('home')
</script>

<style scoped>
/* 组件特定样式可以在这里定义 */
.theme-example {
  min-height: 100vh;
  transition: all 0.3s ease;
}

/* 代码块样式 */
pre {
  font-family: 'Courier New', monospace;
  white-space: pre-wrap;
  word-wrap: break-word;
}

code {
  font-family: 'Courier New', monospace;
}
</style>