import { ref, computed, watch, type Ref } from 'vue'
import { useDark, useToggle } from '@vueuse/core'

/**
 * 通用主题管理组合式函数
 * 提供统一的主题切换逻辑和状态管理
 */
export function useTheme() {

  // 是否为黑夜模式 (true=黑夜模式, false=白天模式)
  const darkSwitch: Ref<boolean> = ref(false)

  // 使用 VueUse 的 useDark 管理暗黑模式
  const isDark1 = useDark({
    onChanged(dark: boolean): void {
      // 更新 DOM 类名, 并且VueUse 内部会自动添加 color-scheme 样式,
      // color-scheme: dark 会触发浏览器的原生暗色模式行为
      if (dark) {
        document.documentElement.classList.add('dark')
        darkSwitch.value = true  // 黑夜模式时设为true
      } else {
        document.documentElement.classList.remove('dark')
        darkSwitch.value = false // 白天模式时设为false
      }
      // 触发主题变更事件
      window.dispatchEvent(new CustomEvent('theme-changed', {
        detail: { isDark: dark, darkSwitch: dark }
      }))
    },
  });
  const isDark = useDark({
    selector: 'html', // 指定选择器
    attribute: 'class', // 使用 class 而不是 data 属性
    valueDark: 'dark', // 暗色模式的类名
    valueLight: '', // 亮色模式的类名
    disableTransition: false,
    onChanged(dark: boolean): void {
      // 手动控制类名，VueUse 不会自动添加 color-scheme
      if (dark) {
        document.documentElement.classList.add('dark')
        darkSwitch.value = true
      } else {
        document.documentElement.classList.remove('dark')
        darkSwitch.value = false
      }
      // 触发主题变更事件
      window.dispatchEvent(new CustomEvent('theme-changed', {
        detail: { isDark: dark, darkSwitch: dark }
      }))
    },
  })
  
  // 切换主题函数
  const toggleDark = useToggle(isDark)
  
  // 计算属性：当前主题名称
  const themeName = computed(() => isDark.value ? 'dark' : 'light')
  
  // 计算属性：主题类名
  const themeClass = computed(() => ({
    'theme-light': !darkSwitch.value,  // 白天模式时为true
    'theme-dark': darkSwitch.value,    // 黑夜模式时为true
    'dark': isDark.value
  }))
  
  // 设置主题
  const setTheme = (theme: 'light' | 'dark') => {
    if (theme === 'dark' && !isDark.value) {
      toggleDark()
    } else if (theme === 'light' && isDark.value) {
      toggleDark()
    }
  }
  
  // 获取主题相关的CSS变量值
  const getThemeVar = (varName: string): string => {
    return getComputedStyle(document.documentElement)
      .getPropertyValue(`--theme-${varName}`)
      .trim()
  }
  
  // 设置主题相关的CSS变量
  const setThemeVar = (varName: string, value: string): void => {
    document.documentElement.style.setProperty(`--theme-${varName}`, value)
  }
  
  // 主题配置对象
  const themeConfig = {
    light: {
      name: 'light',
      displayName: '白天模式',
      icon: '☀️',
      colors: {
        primary: '#3b82f6',
        background: '#ffffff',
        text: '#1f2937'
      }
    },
    dark: {
      name: 'dark',
      displayName: '暗黑模式', 
      icon: '🌙',
      colors: {
        primary: '#60a5fa',
        background: '#1f2937',
        text: '#f9fafb'
      }
    }
  }
  
  // 获取当前主题配置
  const currentThemeConfig = computed(() => 
    themeConfig[themeName.value as keyof typeof themeConfig]
  )
  
  // 监听系统主题变化
  const watchSystemTheme = () => {
    const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)')
    
    const handleChange = (e: MediaQueryListEvent) => {
      // 只有在用户没有手动设置主题时才跟随系统
      const hasUserPreference = localStorage.getItem('vueuse-color-scheme')
      if (!hasUserPreference) {
        setTheme(e.matches ? 'dark' : 'light')
      }
    }
    
    mediaQuery.addEventListener('change', handleChange)
    
    // 返回清理函数
    return () => mediaQuery.removeEventListener('change', handleChange)
  }
  
  // 主题切换动画
  const animateThemeChange = () => {
    document.documentElement.classList.add('no-transition')
    
    // 短暂禁用过渡动画，然后重新启用
    setTimeout(() => {
      document.documentElement.classList.remove('no-transition')
    }, 50)
  }
  
  // 监听主题变化，添加动画效果
  watch(isDark, () => {
    animateThemeChange()
  })
  
  return {
    // 状态
    isDark,
    darkSwitch,
    themeName,
    themeClass,
    currentThemeConfig,
    
    // 方法
    toggleDark,
    setTheme,
    getThemeVar,
    setThemeVar,
    watchSystemTheme,
    
    // 配置
    themeConfig
  }
}

/**
 * 主题存储管理
 * 提供主题状态的持久化存储
 */
export function useThemeStore() {
  const { isDark, darkSwitch, toggleDark, setTheme, themeName } = useTheme()
  
  // 保存主题偏好到本地存储
  const saveThemePreference = (theme: 'light' | 'dark') => {
    localStorage.setItem('user-theme-preference', theme)
  }
  
  // 从本地存储加载主题偏好
  const loadThemePreference = (): 'light' | 'dark' | null => {
    return localStorage.getItem('user-theme-preference') as 'light' | 'dark' | null
  }
  
  // 初始化主题
  const initTheme = () => {
    const savedTheme = loadThemePreference()
    if (savedTheme) {
      setTheme(savedTheme)
    }
  }
  
  // 监听主题变化并保存
  watch(themeName, (newTheme) => {
    saveThemePreference(newTheme as 'light' | 'dark')
  })
  
  return {
    isDark,
    darkSwitch,
    toggleDark,
    setTheme,
    themeName,
    saveThemePreference,
    loadThemePreference,
    initTheme
  }
}

/**
 * 主题工具函数
 */
export const themeUtils = {
  // 检查是否支持暗黑模式
  supportsDarkMode: () => {
    return window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches
  },
  
  // 获取系统主题偏好
  getSystemTheme: (): 'light' | 'dark' => {
    return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
  },
  
  // 应用主题到特定元素
  applyThemeToElement: (element: HTMLElement, theme: 'light' | 'dark') => {
    element.classList.remove('theme-light', 'theme-dark')
    element.classList.add(`theme-${theme}`)
  },
  
  // 创建主题切换按钮
  createThemeToggle: (container: HTMLElement, useThemeInstance: ReturnType<typeof useTheme>) => {
    const button = document.createElement('button')
    button.className = 'theme-switch'
    button.innerHTML = `
      <input type="checkbox" ${useThemeInstance.isDark.value ? 'checked' : ''}>
      <span class="theme-switch-slider"></span>
    `
    
    button.addEventListener('click', () => {
      useThemeInstance.toggleDark()
    })
    
    container.appendChild(button)
    return button
  }
}

export default useTheme