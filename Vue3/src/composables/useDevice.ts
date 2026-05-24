import { computed } from 'vue'
import { useBreakpoints, breakpointsTailwind, useMediaQuery } from '@vueuse/core'

/**
 * 响应式设备检测钩子
 * 仅区分：PC 端（>= lg）与移动端（< lg，包含手机+平板）
 */
export const useDevice = () => {
  const breakpoints = useBreakpoints(breakpointsTailwind)

  const isTouchDevice = useMediaQuery('(hover: none) and (pointer: coarse)')

  const isDesktop = computed(() => breakpoints.greaterOrEqual('lg').value && !isTouchDevice.value)
  const isMobile = computed(() => !isDesktop.value)

  return {
    isMobile,
    isDesktop,
    // 暴露原始 breakpoints 对象以便进行自定义判断
    breakpoints
  }
}
