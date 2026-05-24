# 🎨 MintBlog 主题系统使用指南

## 📖 概述

MintBlog 主题系统是一个基于 Vue 3 + TypeScript 的现代化主题管理解决方案，支持明暗主题切换、CSS 变量动态更新和组件级主题定制。

## 🚀 快速开始

### 1. 引入主题系统

```typescript
import { useTheme } from '@/composables/useTheme'

// 在组件中使用
const { 
  isDark, 
  darkSwitch, 
  toggleDark, 
  themeName, 
  currentThemeConfig 
} = useTheme()
```

### 2. 基本使用

```vue
<template>
  <div class="theme-bg-primary">
    <!-- 主题切换开关 -->
    <label class="theme-switch">
      <input type="checkbox" :checked="darkSwitch" @change="toggleDark()">
      <span class="theme-switch-slider"></span>
    </label>
    
    <!-- 使用主题样式 -->
    <h1 class="theme-text-primary">标题</h1>
    <p class="theme-text-secondary">内容</p>
  </div>
</template>

<script setup lang="ts">
import { useTheme } from '@/composables/useTheme'

const { darkSwitch, toggleDark } = useTheme()
</script>
```

## 🎨 主题类名系统

### 背景类名

| 类名 | 描述 | 用途 |
|------|------|------|
| `theme-bg-primary` | 主背景色 | 页面主要背景 |
| `theme-bg-secondary` | 次要背景色 | 卡片、侧边栏背景 |
| `theme-bg-tertiary` | 第三级背景色 | 代码块、引用背景 |

### 文本类名

| 类名 | 描述 | 用途 |
|------|------|------|
| `theme-text-primary` | 主文本色 | 标题、重要文本 |
| `theme-text-secondary` | 次要文本色 | 正文、描述文本 |
| `theme-text-tertiary` | 第三级文本色 | 辅助信息、标签 |

### 组件类名

| 类名 | 描述 | 用途 |
|------|------|------|
| `theme-card` | 卡片样式 | 内容卡片 |
| `theme-btn` | 主要按钮 | 重要操作按钮 |
| `theme-btn-secondary` | 次要按钮 | 辅助操作按钮 |
| `theme-input` | 输入框样式 | 表单输入控件 |
| `theme-nav-item` | 导航项样式 | 导航链接 |

## 🎛️ CSS 变量系统

### 颜色变量

```css
/* 背景色 */
--theme-bg-primary: 主背景色
--theme-bg-secondary: 次要背景色
--theme-bg-tertiary: 第三级背景色

/* 文本色 */
--theme-text-primary: 主文本色
--theme-text-secondary: 次要文本色
--theme-text-tertiary: 第三级文本色

/* 功能色 */
--theme-accent: 强调色
--theme-border: 边框色
--theme-shadow: 阴影色
```

### 使用示例

```css
.custom-component {
  background-color: var(--theme-bg-primary);
  color: var(--theme-text-primary);
  border: 1px solid var(--theme-border);
  box-shadow: 0 2px 4px var(--theme-shadow);
}
```

## 🔧 API 参考

### useTheme() 返回值

| 属性 | 类型 | 描述 |
|------|------|------|
| `isDark` | `Ref<boolean>` | 是否为暗黑模式 |
| `darkSwitch` | `Ref<boolean>` | 开关状态 (true=黑夜, false=白天) |
| `toggleDark` | `Function` | 切换主题函数 |
| `themeName` | `ComputedRef<string>` | 当前主题名称 |
| `currentThemeConfig` | `ComputedRef<ThemeConfig>` | 当前主题配置 |
| `themeClass` | `ComputedRef<string>` | 主题类名 |
| `isLight` | `ComputedRef<boolean>` | 是否为明亮模式 |

### 主题配置接口

```typescript
interface ThemeConfig {
  name: string
  displayName: string
  icon: string
  colors: {
    primary: string
    secondary: string
    accent: string
    background: string
    surface: string
    text: string
  }
}
```

## 📱 组件示例

### 主题切换开关

```vue
<template>
  <label class="theme-switch">
    <input 
      type="checkbox" 
      :checked="darkSwitch" 
      @change="toggleDark()"
    >
    <span class="theme-switch-slider"></span>
  </label>
</template>

<script setup lang="ts">
import { useTheme } from '@/composables/useTheme'

const { darkSwitch, toggleDark } = useTheme()
</script>
```

### 主题信息显示

```vue
<template>
  <div class="theme-card p-4">
    <h3 class="theme-text-primary">当前主题</h3>
    <p class="theme-text-secondary">
      {{ currentThemeConfig.displayName }} {{ currentThemeConfig.icon }}
    </p>
    <p class="theme-text-tertiary">
      模式: {{ themeName }}
    </p>
  </div>
</template>

<script setup lang="ts">
import { useTheme } from '@/composables/useTheme'

const { themeName, currentThemeConfig } = useTheme()
</script>
```

### 响应式卡片组件

```vue
<template>
  <div class="theme-card p-6 rounded-lg">
    <h2 class="theme-text-primary text-xl font-bold mb-4">卡片标题</h2>
    <p class="theme-text-secondary mb-4">卡片内容描述</p>
    <div class="flex gap-2">
      <button class="theme-btn px-4 py-2 rounded">主要操作</button>
      <button class="theme-btn-secondary px-4 py-2 rounded">次要操作</button>
    </div>
  </div>
</template>
```

## 🎯 最佳实践

### 1. 组件设计原则

- **优先使用主题类名**：避免硬编码颜色值
- **保持语义化**：使用有意义的类名
- **响应式设计**：确保在不同主题下都有良好的视觉效果

### 2. 性能优化

```typescript
// ✅ 推荐：解构需要的属性
const { darkSwitch, toggleDark } = useTheme()

// ❌ 避免：引入整个对象
const theme = useTheme()
```

### 3. 样式组织

```scss
// 组件特定样式
.my-component {
  // 使用主题变量
  background: var(--theme-bg-primary);
  
  // 主题特定样式
  &.dark {
    // 暗黑模式特定样式
  }
  
  &.light {
    // 明亮模式特定样式
  }
}
```

## 🔄 主题事件系统

### 监听主题变化

```typescript
// 监听全局主题变化事件
window.addEventListener('theme-changed', (event) => {
  const { isDark, darkSwitch } = event.detail
  console.log('主题已切换:', isDark ? '暗黑模式' : '明亮模式')
})
```

### 自定义主题响应

```typescript
import { watch } from 'vue'
import { useTheme } from '@/composables/useTheme'

const { isDark } = useTheme()

// 监听主题变化
watch(isDark, (newValue) => {
  // 执行自定义逻辑
  if (newValue) {
    // 暗黑模式逻辑
  } else {
    // 明亮模式逻辑
  }
})
```

## 🛠️ 自定义主题

### 扩展主题配置

```typescript
// 在 useTheme.ts 中添加新主题
const themes = {
  light: {
    name: 'light',
    displayName: '明亮模式',
    icon: '☀️',
    colors: {
      primary: '#3b82f6',
      // ... 其他颜色
    }
  },
  dark: {
    name: 'dark',
    displayName: '暗黑模式', 
    icon: '🌙',
    colors: {
      primary: '#60a5fa',
      // ... 其他颜色
    }
  },
  // 添加新主题
  custom: {
    name: 'custom',
    displayName: '自定义主题',
    icon: '🎨',
    colors: {
      primary: '#8b5cf6',
      // ... 自定义颜色
    }
  }
}
```

## 📚 参考示例

完整的使用示例可以参考：
- `src/views/surfer/ThemeExample.vue` - 主题系统演示页面
- `src/components/ThemeDemo.vue` - 主题切换组件
- `src/layouts/surfer/components/Header.vue` - 头部主题集成

## 🐛 常见问题

### Q: 主题切换后样式没有更新？
A: 确保使用了正确的主题类名或 CSS 变量，避免使用硬编码的颜色值。

### Q: 如何在 SSR 中使用主题系统？
A: 主题系统会自动处理服务端渲染的兼容性，确保在客户端激活时正确应用主题。

### Q: 可以同时支持多个主题吗？
A: 当前版本支持明暗两种主题，可以通过扩展配置添加更多主题选项。

## 📄 许可证

本主题系统遵循项目的开源许可证。

---

**更新时间**: 2024年
**版本**: 1.0.0
**维护者**: MintBlog 开发团队