<template>
    <div class="theme-bg-secondary theme-text-primary w-full py-5 px-2 mb-3 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
        <div class="flex flex-col items-center">
            <!-- 博主头像 -->
            <div class="relative mb-4">
                <img class="w-20 h-20 rounded-full shadow"
                :src="blogSettingsStore.blogSettings.avatar"/>    
                <span class="bottom-0 start-10 absolute w-3.5 h-3.5 bg-green-400 border-2 border-white dark:border-gray-800 rounded-full"></span>
            </div>
            <!-- 博主昵称 -->
            <h5 class="theme-bg-secondary theme-text-primary mb-2 text-xl font-medium text-gray-900 dark:text-white">{{ blogSettingsStore.blogSettings.author }}</h5>
            <!-- 介绍语 -->
            <a-tooltip title="介绍语" placement="bottom">
                <span class="theme-bg-secondary theme-text-primary mb-6 text-sm text-gray-500 dark:text-gray-400">{{ blogSettingsStore.blogSettings.introduction }}</span>
            </a-tooltip>
             <!-- 文章数量、分类数量、标签数量、总访问量 -->
             <!-- flex 布局，justify-center 水平居中，gap-5 设置 flex 内子元素的间距 -->
             <div class="flex justify-center gap-5 mb-2 dark:text-gray-400">
                <!-- 加载状态 -->
                <template v-if="loading">
                    <div v-for="i in 4" :key="i" class="flex items-center flex-col gap-1">
                        <div class="w-8 h-6 bg-gray-200 rounded animate-pulse dark:bg-gray-700"></div>
                        <div class="w-12 h-4 bg-gray-200 rounded animate-pulse dark:bg-gray-700"></div>
                    </div>
                </template>
                <!-- 数据加载完成 -->
                <template v-else>
                    <!-- flex 布局，items-center 垂直居中，flex-col 设置子元素上下排列，hover: 用于设置鼠标移动到上面的样式，字体颜色、放大效果，cursor-pointer 指定鼠标移动到上面为小手指样式 -->
                    <div 
                        class="flex items-center flex-col gap-1 hover:text-sky-600 hover:scale-110 cursor-pointer">
                        <!-- 字体大小为 text-lg , 字体加粗 -->
                        <CountTo :value="statisticsInfo.articleTotalCount" customClass="text-lg font-bold"></CountTo>
                        <!-- 字体大小为 text-sm -->
                        <div class="text-sm">文章</div>
                    </div>
                    <div 
                        class="flex items-center flex-col gap-1 hover:text-sky-600 hover:scale-110 cursor-pointer">
                        <CountTo :value="statisticsInfo.categoryTotalCount" customClass="text-lg font-bold"></CountTo>
                        <div class="text-sm">分类</div>
                    </div>
                    <div
                        class="flex items-center flex-col gap-1 hover:text-sky-600 hover:scale-110 cursor-pointer">
                        <CountTo :value="statisticsInfo.tagTotalCount" customClass="text-lg font-bold"></CountTo>
                        <div class="text-sm">标签</div>
                    </div>
                    <div class="flex items-center flex-col gap-1">
                        <CountTo :value="statisticsInfo.pvTotalCount" customClass="text-lg font-bold"></CountTo>
                        <div class="text-sm">总访问量</div>
                    </div>
                </template>
            </div>

            <!-- 第三方平台主页跳转（如 GitHub 等） -->
            <div class="flex justify-center gap-2">
                <!-- GitHub -->
                <a-tooltip title="我的 GitHub" placement="bottom" v-if="blogSettingsStore.blogSettings.githubHomepage">
                    <GithubOutlined @click="jump(blogSettingsStore.blogSettings.githubHomepage)" 
                        class="hover:scale-110 mt-5 text-2xl text-gray-600 dark:text-gray-400 hover:text-blue-500 cursor-pointer" />
                </a-tooltip>
                <!-- Gitee -->
                <a-tooltip title="我的 Gitee" placement="bottom" v-if="blogSettingsStore.blogSettings.giteeHomepage">
                    <img :src="GiteeIcon" @click="jump(blogSettingsStore.blogSettings.giteeHomepage)" 
                        class="hover:scale-110 mt-5 w-7 h-7 cursor-pointer" alt="Gitee" />
                </a-tooltip>
                <!-- 知乎 -->
                <a-tooltip title="我的知乎" placement="bottom" v-if="blogSettingsStore.blogSettings.zhihuHomepage">
                    <ZhihuOutlined @click="jump(blogSettingsStore.blogSettings.zhihuHomepage)" 
                        class="hover:scale-110 mt-5 text-2xl text-gray-600 dark:text-gray-400 hover:text-blue-500 cursor-pointer" />
                </a-tooltip>
                <!-- CSDN -->
                <a-tooltip title="我的 CSDN" placement="bottom" v-if="blogSettingsStore.blogSettings.csdnHomepage">
                    <img :src="CsdnIcon" @click="jump(blogSettingsStore.blogSettings.csdnHomepage)" 
                        class="hover:scale-110 mt-5 w-7 h-7 cursor-pointer" alt="CSDN" />
                </a-tooltip>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { useBlogSettingsStore } from '@/stores/blogsettings.ts'
import { ref } from 'vue'
import { getStatisticsInfo } from '@/api/surfer/statistics'
import CountTo from '@/components/CountTo.vue'
import { GithubOutlined, ZhihuOutlined } from '@ant-design/icons-vue'
import GiteeIcon from '@/assets/icons/GitEE.svg'
import CsdnIcon from '@/assets/icons/CSDN.svg'

// 统计信息接口定义
interface StatisticsInfo {
  articleTotalCount: number
  categoryTotalCount: number
  tagTotalCount: number
  pvTotalCount: number
}

// API响应接口定义
interface ApiResponse<T> {
  success: boolean
  data: T
}



// 引入博客设置信息 store
const blogSettingsStore = useBlogSettingsStore()

const jump = (url: string): void => {
    // 在新窗口访问新的链接地址
    window.open(url, '_blank');
} 

// 统计信息(文章、分类、标签数量、总访问量)
const statisticsInfo = ref<StatisticsInfo>({
  articleTotalCount: 0,
  categoryTotalCount: 0,
  tagTotalCount: 0,
  pvTotalCount: 0
})

// 加载状态
const loading = ref<boolean>(true)

getStatisticsInfo().then((res: ApiResponse<StatisticsInfo>) => {
    if (res.success) {
        statisticsInfo.value = res.data
    }
}).finally(() => {
    loading.value = false
})
</script>
