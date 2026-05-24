<template>
    <!-- 返回顶部按钮ToTop -->
    <Transition name="scroll-btn" appear>
        <div v-show="showScrollToTopBtn" @click="scrollToTop"
            class="scroll-to-top-btn group z-50 cursor-pointer fixed w-12 h-12 flex items-center justify-center rounded-full shadow-lg border theme-border theme-bg-tertiary/90 backdrop-blur-sm transition-all duration-200 hover:shadow-xl active:scale-95">
            <img v-if="!isDark" :src="BackToTopIcon1" alt="返回顶部" class="w-10 h-10 transition-transform duration-200 group-hover:-translate-y-0.5" />
            <img v-else :src="BackToTopIcon2" alt="返回顶部" class="w-10 h-10 transition-transform duration-200 group-hover:-translate-y-0.5" />
        </div>
    </Transition>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from 'vue'
import { useTheme } from '@/composables/useTheme'
import BackToTopIcon1 from '@/assets/BackToTop1.svg'
import BackToTopIcon2 from '@/assets/BackToTop2.svg'

// 使用主题管理
const { isDark } = useTheme()

// 是否展示返回顶部按钮
const showScrollToTopBtn = ref<boolean>(false)

// 滚动容器引用
const scrollContainer = ref<HTMLElement | null>(null)

// 添加滚动监听
// onMounted(() => window.addEventListener('scroll', handleScroll))
onMounted(() => {
    // 查找正确的滚动容器
    scrollContainer.value = document.querySelector('.surfer-layout-main') as HTMLElement
    if (scrollContainer.value) {
        scrollContainer.value.addEventListener('scroll', handleScroll)
    } else {
        // 如果找不到滚动容器，回退到监听window
        window.addEventListener('scroll', handleScroll)
    }
})

// 移除滚动监听
// onBeforeUnmount(() => window.removeEventListener('scroll', handleScroll))
onBeforeUnmount(() => {
    if (scrollContainer.value) {
        scrollContainer.value.removeEventListener('scroll', handleScroll)
    } else {
        window.removeEventListener('scroll', handleScroll)
    }
})

const handleScroll = (): void => {
    let scrollY = 0
    if (scrollContainer.value) {
        // 使用滚动容器的scrollTop
        scrollY = scrollContainer.value.scrollTop
    } else {
        // 回退到window的scrollY
        scrollY = window.scrollY
    }
    // 如果页面滚动超过300px，显示回到顶部按钮，否则隐藏
	// showScrollToTopBtn.value = window.scrollY > 300
    showScrollToTopBtn.value = scrollY > 300
}

// 滚动到顶部
const scrollToTop = (): void => {
    // window.scrollTo({
    //     top: 0, // 距离顶部位置
    //     behavior: 'smooth' // 平滑滚动效果
    // });
    if (scrollContainer.value) {
        // 滚动容器回到顶部
        scrollContainer.value.scrollTo({
            top: 0, // 距离顶部位置
            behavior: 'smooth' // 平滑滚动效果
        });
    } else {
        // 回退到window滚动
        window.scrollTo({
            top: 0, // 距离顶部位置
            behavior: 'smooth' // 平滑滚动效果
        });
    }
}
</script>

<style scoped lang="scss">
/* 按钮出现/消失的过渡动画 */
.scroll-btn-enter-active,
.scroll-btn-leave-active {
    transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
}

.scroll-btn-enter-from {
    opacity: 0;
    transform: translateY(20px) scale(0.8);
}

.scroll-btn-leave-to {
    opacity: 0;
    transform: translateY(20px) scale(0.8);
}

/* 按钮悬停时的额外效果 */
.scroll-to-top-btn {
    bottom: calc(16px + env(safe-area-inset-bottom));
    right: calc(16px + env(safe-area-inset-right));
}


</style>
