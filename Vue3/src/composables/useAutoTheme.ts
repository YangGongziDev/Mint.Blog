import { ref, watch, onMounted, onUnmounted } from 'vue'
import { useTheme } from './useTheme'

/**
 * 自动主题切换 composable
 * 根据时间自动在白天和黑夜主题之间切换
 */
export function useAutoTheme() {
  const { setTheme } = useTheme()
  
  // 是否启用自动切换
  const isAutoThemeEnabled = ref(false)
  
  // 定时器引用
  let themeTimer: ReturnType<typeof setTimeout> | null = null;
  
  // 白天模式时间范围 (6:00 - 18:00)
  const DAY_START_HOUR = 6
  const DAY_END_HOUR = 18
  
  /**
   * 根据当前时间判断应该使用什么主题
   */
  const getCurrentThemeByTime = (): 'light' | 'dark' => {
    const now = new Date()
    const currentHour = now.getHours()
    
    // 6:00-18:00 为白天模式，其他时间为黑夜模式
    return (currentHour >= DAY_START_HOUR && currentHour < DAY_END_HOUR) ? 'light' : 'dark'
  }
  
  /**
   * 应用基于时间的主题
   */
  const applyTimeBasedTheme = () => {
    if (!isAutoThemeEnabled.value) return
    
    const targetTheme = getCurrentThemeByTime()
    setTheme(targetTheme)
    
    console.log(`[自动主题] 当前时间: ${new Date().toLocaleTimeString()}, 切换到: ${targetTheme === 'light' ? '白天' : '黑夜'}模式`)
  }
  
  /**
   * 计算下次主题切换的时间
   */
  const getNextThemeChangeTime = (): Date => {
    const now = new Date()
    const currentHour = now.getHours()
    const nextChange = new Date(now)
    
    if (currentHour < DAY_START_HOUR) {
      // 当前是凌晨，下次切换是早上6点
      nextChange.setHours(DAY_START_HOUR, 0, 0, 0)
    } else if (currentHour < DAY_END_HOUR) {
      // 当前是白天，下次切换是晚上6点
      nextChange.setHours(DAY_END_HOUR, 0, 0, 0)
    } else {
      // 当前是晚上，下次切换是明天早上6点
      nextChange.setDate(nextChange.getDate() + 1)
      nextChange.setHours(DAY_START_HOUR, 0, 0, 0)
    }
    
    return nextChange
  }
  
  /**
   * 启动自动主题切换
   */
  const startAutoTheme = () => {
    if (!isAutoThemeEnabled.value) return
    
    // 立即应用当前时间对应的主题
    applyTimeBasedTheme()
    
    // 清除现有定时器
    if (themeTimer) {
      clearTimeout(themeTimer)
    }
    
    // 计算下次切换时间
    const nextChangeTime = getNextThemeChangeTime()
    const timeUntilChange = nextChangeTime.getTime() - Date.now()
    
    console.log(`[自动主题] 下次切换时间: ${nextChangeTime.toLocaleString()}, 剩余: ${Math.round(timeUntilChange / 1000 / 60)}分钟`)
    
    // 设置定时器
    themeTimer = setTimeout(() => {
      applyTimeBasedTheme()
      // 递归设置下一次切换
      startAutoTheme()
    }, timeUntilChange)
  }
  
  /**
   * 停止自动主题切换
   */
  const stopAutoTheme = () => {
    if (themeTimer) {
      clearTimeout(themeTimer)
      themeTimer = null
    }
    console.log('[自动主题] 已停止自动切换')
  }
  
  /**
   * 设置自动主题开关状态
   */
  const setAutoThemeEnabled = (enabled: boolean) => {
    isAutoThemeEnabled.value = enabled
    
    if (enabled) {
      console.log('[自动主题] 已启用自动切换')
      startAutoTheme()
    } else {
      console.log('[自动主题] 已禁用自动切换')
      stopAutoTheme()
    }
  }
  
  /**
   * 手动触发主题检查（用于测试）
   */
  const checkThemeNow = () => {
    const currentTheme = getCurrentThemeByTime()
    const nextChange = getNextThemeChangeTime()
    
    return {
      currentTime: new Date().toLocaleString(),
      recommendedTheme: currentTheme,
      nextChangeTime: nextChange.toLocaleString(),
      isAutoEnabled: isAutoThemeEnabled.value
    }
  }
  
  // 监听自动主题开关变化
  watch(isAutoThemeEnabled, (enabled) => {
    if (enabled) {
      startAutoTheme()
    } else {
      stopAutoTheme()
    }
  })
  
  // 组件卸载时清理定时器
  onUnmounted(() => {
    stopAutoTheme()
  })
  
  return {
    // 状态
    isAutoThemeEnabled,
    
    // 方法
    setAutoThemeEnabled,
    startAutoTheme,
    stopAutoTheme,
    applyTimeBasedTheme,
    getCurrentThemeByTime,
    checkThemeNow,
    
    // 配置
    DAY_START_HOUR,
    DAY_END_HOUR
  }
}

export default useAutoTheme