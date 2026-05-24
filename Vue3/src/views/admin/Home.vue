<template>
    <main class="container p-6">
        <!-- grid 表格布局，分为 4 列 -->
        <div class="grid grid-cols-4 gap-7">
            <!-- 文章数 -->
            <div class="col-span-4 md:col-span-1">
                <!-- 卡片 -->
                <div
                    class="flex items-center h-full w-full px-5 py-7 mb-3 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
                    <FileTextOutlined class="icon w-10 h-10 text-orange-500" />
                    <div class="ml-5">
                        <h2 class="mb-1">文章</h2>
                        <CountTo :value="articleTotalCount" customClass="font-bold text-2xl"></CountTo>
                    </div>
                </div>
            </div>

            <!-- 分类数 -->
            <div class="col-span-4 md:col-span-1">
                <!-- 卡片 -->
                <div
                    class="flex items-center h-full w-full px-5 py-7 mb-3 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
                    <AppstoreOutlined class="icon w-10 h-10 text-orange-600" />
                    <div class="ml-5">
                        <h2 class="mb-1">分类</h2>
                        <CountTo :value="categoryTotalCount" customClass="font-bold text-2xl"></CountTo>
                    </div>
                </div>
            </div>

            <!-- 标签数 -->
            <div class="col-span-4 md:col-span-1">
                <!-- 卡片 -->
                <div
                    class="flex items-center h-full w-full px-5 py-7 mb-3 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
                    <TagsOutlined class="icon w-10 h-10 text-pink-500" />
                    <div class="ml-5">
                        <h2 class="mb-1">标签</h2>
                        <CountTo :value="tagTotalCount" customClass="font-bold text-2xl"></CountTo>
                    </div>
                </div>
            </div>

            <!-- 总浏览量 -->
            <div class="col-span-4 md:col-span-1">
                <!-- 卡片 -->
                <div
                    class="flex items-center h-full w-full px-5 py-7 mb-3 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
                    <EyeOutlined class="icon w-10 h-10 text-yellow-500" />
                <div class="ml-5">
                    <h2 class="mb-1">总浏览量</h2>
                    <CountTo :value="pvTotalCount" customClass="font-bold text-2xl"></CountTo>
                </div>
            </div>
        </div>

        <!-- 文章发布热点图 -->
        <div class="col-span-4 md:col-span-2">
            <!-- 卡片 -->
            <div
                class="w-full h-full px-5 py-7 mb-3 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
                <h2 class="flex items-center mb-2 font-bold text-gray-600 uppercase dark:text-white">
                    <!-- 日历图标 -->
                    <CalendarOutlined class="icon w-5 h-5 mr-2 text-orange-500" />
                    近半年文章发布热点图
                </h2>
               <ArticlePublishCalendar :value="articlePublishInfo"></ArticlePublishCalendar>
            </div>
        </div>

        <!-- 文章日 PV 访问量折线图 -->
        <div class="col-span-4 md:col-span-2">
            <!-- 卡片 -->
            <div
                class="w-full h-full px-5 py-7 mb-3 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
                <h2 class="flex items-center mb-2 font-bold text-gray-600 uppercase dark:text-white">
                    <!-- 折线图标 -->
                    <LineChartOutlined class="icon w-5 h-5 mr-2 text-purple-500" />
                    近一周 PV 访问量
                </h2>
                <ArticlePVLineChat :value="chartData"></ArticlePVLineChat>
            </div>
        </div>
    </div>

</main></template>

<script setup lang="ts">
import { ref, computed, type Ref } from 'vue'
import { getBaseStatisticsInfo, getPublishArticleStatisticsInfo, getArticlePVStatisticsInfo } from '@/api/admin/dashboard.ts'
import CountTo from '@/components/CountTo.vue'
import ArticlePublishCalendar from '@/components/admin/ArtilcePublishCalendar.vue'
import ArticlePVLineChat from '@/components/admin/ArticlePVLineChat.vue'
import {
    FileTextOutlined,
    AppstoreOutlined,
    TagsOutlined,
    EyeOutlined,
    CalendarOutlined,
    LineChartOutlined
} from '@ant-design/icons-vue'

// 定义API响应数据类型
interface BaseStatisticsData {
  articleTotalCount: number
  categoryTotalCount: number
  tagTotalCount: number
  pvTotalCount: number
}

interface ApiResponse<T> {
  success: boolean
  data: T
}

interface ArticlePublishInfo {
  [key: string]: number
}

interface ArticlePVInfo {
  [key: string]: number
}

// 定义图表数据类型接口
interface ChartData {
    pvDates: string[]
    pvCounts: number[]
}

// 文章总数，默认值为 0
const articleTotalCount: Ref<number> = ref(0)
// 分类总数
const categoryTotalCount: Ref<number> = ref(0)
// 标签总数
const tagTotalCount: Ref<number> = ref(0)
// PV 总访问量
const pvTotalCount: Ref<number> = ref(0)

getBaseStatisticsInfo({}).then((res: ApiResponse<BaseStatisticsData>) => {
    if (res.success) {
        articleTotalCount.value = res.data.articleTotalCount
        categoryTotalCount.value = res.data.categoryTotalCount
        tagTotalCount.value = res.data.tagTotalCount
        pvTotalCount.value = res.data.pvTotalCount
    }
})

// 按日统计文章发布数据
const articlePublishInfo: Ref<ArticlePublishInfo> = ref({})
getPublishArticleStatisticsInfo({}).then((res: ApiResponse<ArticlePublishInfo>) => {
    if (res.success) {
        articlePublishInfo.value = res.data
    }
})

// 近一周文章 PV 数据
const articlePVInfo: Ref<ArticlePVInfo> = ref({})
getArticlePVStatisticsInfo({}).then((res: ApiResponse<ArticlePVInfo>) => {
    if (res.success) {
        articlePVInfo.value = res.data
    }
})

// 将 ArticlePVInfo 转换为 ChartData 格式的计算属性
const chartData = computed<ChartData | null>(() => {
    const keys = Object.keys(articlePVInfo.value)
    if (keys.length === 0) {
        return null
    }
    
    return {
        pvDates: keys,
        pvCounts: keys.map(key => articlePVInfo.value[key] || 0)
    }
})

</script>

<style lang="scss" scoped>
// 自定义样式可以在这里添加
// 使用 Tailwind CSS 4 语法

// 卡片悬停效果
.bg-white {
  transition: box-shadow 0.3s ease;
  
  &:hover {
    box-shadow: 0 10px 25px oklch(0% 0 0 / 0.1);
  }
}

// 图标样式
.icon {
  flex-shrink: 0;
}

// 响应式网格调整
@media (inline-size <= 768px) {
  .grid {
    gap: 16px;
  }
}

// 支持逻辑属性的样式
@supports (margin-inline-start: 0) {
  .ml-5 {
    margin-inline-start: 20px;
    margin-left: unset;
  }
  
  .mr-2 {
    margin-inline-end: 8px;
    margin-right: unset;
  }
  
  .mb-1 {
    margin-block-end: 4px;
    margin-bottom: unset;
  }
  
  .mb-2 {
    margin-block-end: 8px;
    margin-bottom: unset;
  }
  
  .mb-3 {
    margin-block-end: 12px;
    margin-bottom: unset;
  }
}
</style>