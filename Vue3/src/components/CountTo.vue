<template>
  <!-- 显示 d.num 属性的四舍五入取整后的值（若不加四舍五入，滚动时会显示小数点后面的数字） -->
  <div :class="[customClass, 'count-to-container']">
    {{ d.num.toFixed(0) }}
  </div>
</template>

<script setup lang="ts">
import { reactive, watch, onMounted } from 'vue'
import gsap from 'gsap'

// 定义接口类型
interface CountData {
  num: number
}

interface Props {
  value?: number // 属性值名称
  customClass?: string // 自定义样式
  duration?: number // 动画持续时间
}

// 总数值
const d = reactive<CountData>({
  num: 0
})

// 对外暴露的属性值
const props = withDefaults(defineProps<Props>(), {
  value: 0, // 默认为 0
  customClass: '', // 默认为空
  duration: 0.5 // 默认动画时间为 0.5s
})

// 动画函数
const animateToValue = (): void => {
  // 从数值 0 滚动到 value 属性指定的值
  gsap.to(d, {
    duration: props.duration,
    num: props.value
  })
}

// 组件挂载时执行动画
onMounted(() => {
  animateToValue()
})

// 侦听属性, 监听 props.value 的变化，一旦 props.value 发生变化，就调用 animateToValue 函数执行动画
watch(() => props.value, () => animateToValue())
</script>

<style lang="scss" scoped>
.count-to-container {
  // 替换 @apply 为标准 CSS 属性
  display: inline-block;
  font-weight: 500;
  color: inherit;
  
  // 过渡动画
  transition: all 0.3s ease;
  
  &:hover {
    // 替换 @apply scale-105 为标准 transform
    transform: scale(1.05);
  }
  
  // SCSS 变量和混合
  $default-font-size: 16px;
  
  font-size: $default-font-size;
  
  // 响应式设计
  @media (max-width: 768px) {
    font-size: 14px;
  }
}
</style>