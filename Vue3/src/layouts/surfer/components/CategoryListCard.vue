<template>
    <div v-if="loading || (categories && categories.length > 0)" 
        class="theme-bg-secondary theme-text-primary category-container w-full p-5 mb-3 bg-white border border-gray-200 rounded-lg ">
        <!-- 分类标题 -->
        <div class="flex mb-3">
            <h2 class="theme-bg-secondary theme-text-primary flex items-center font-bold ">
                <!-- 文件夹图标 -->
                <FolderOutlined class="inline icon w-4 h-4 mr-2" />
                分类
                <span v-if="!loading && categories && categories.length > 0" class="ml-2">( {{ categories.length }} )</span>
            </h2>
            <span class="grow"></span>

            <!-- 查看更多 -->
            <a @click="router.push('/surfer/category/list')" class=" bg-gray-100 flex items-center px-2.5 py-1 text-xs font-medium text-center
            text-gray-900  rounded-lg hover:bg-gray-200 focus:ring-4 focus:outline-none focus:ring-gray-200 
            dark:bg-gray-800 dark:text-white dark:border dark:border-gray-700 dark:hover:bg-gray-700 dark:hover:border-gray-700
             dark:focus:ring-gray-700">
                <RightOutlined class="w-[7px] h-[7px] text-gray-400 dark:text-white" />
            </a>

        </div>

        <!-- 加载状态 -->
        <div v-if="loading" class="flex flex-wrap gap-3">
            <div v-for="i in 6" :key="i" class="flex items-center px-3 py-1.5 border rounded-lg">
                <div class="h-4 bg-gray-200 rounded animate-pulse dark:bg-gray-700" :style="{ width: Math.random() * 30 + 40 + 'px' }"></div>
                <div class="w-4 h-4 ml-2 bg-gray-200 rounded-full animate-pulse dark:bg-gray-700"></div>
            </div>
        </div>
        <!-- 分类列表 -->
        <div v-else class="theme-bg-secondary theme-text-primary text-sm flex flex-wrap gap-3 font-medium text-gray-600 rounded-lg">
            <a @click="goCategoryArticleListPage(category.id, category.name)" v-for="(category, index) in categories"
                :key="index"
                class="cursor-pointer inline-flex items-center px-3 py-1.5 text-xs font-medium text-center border rounded-lg 
                hover:bg-gray-400 dark:hover:bg-gray-700 focus:ring-4 focus:outline-none focus:ring-gray-300 dark:bg-gray-800 dark:text-gray-300 
                  dark:focus:ring-gray-800 dark:border-gray-700 dark:hover:text-white">
                {{ category.name }}
                <span class="inline-flex items-center justify-center w-4 h-4 ml-2 text-xs font-semibold text-sky-800 bg-sky-200 rounded-full">
                    {{ category.articlesTotal }}
                </span>
            </a>
        </div>
    </div>
</template>

<script setup lang="ts">
import { getCategoryList } from '@/api/surfer/category'
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { RightOutlined, FolderOutlined } from '@ant-design/icons-vue'

// 定义分类接口
interface Category {
  id: number
  name: string
  articlesTotal: number
  sort: number
}

// 定义API响应接口
interface ApiResponse {
  success: boolean
  data: Category[]
}

const router = useRouter()

// 跳转分类文章列表页
const goCategoryArticleListPage = (id: number, name: string): void => {
    // 跳转时通过 query 携带参数（分类 ID、分类名称）
    router.push({ path: '/surfer/category/article/list', query: { id: id.toString(), name } })
}

// 所有分类
const categories = ref<Category[]>([])
// 一次显示的分类数
const size = ref<number>(100000)
// 加载状态
const loading = ref<boolean>(true)

getCategoryList({ size: size.value }).then((res: ApiResponse) => {
    if (res.success) {
        // 按sort降序排序，sort相同时保持原有顺序（稳定排序）
        const sortedCategories = res.data
            .map((item, index) => ({ ...item, originalIndex: index })) // 记录原始索引
            .sort((a, b) => {
                const sortA = a.sort || 0;
                const sortB = b.sort || 0;
                if (sortA !== sortB) {
                    return sortB - sortA; // sort降序
                }
                // sort相同时，保持原有顺序
                return a.originalIndex - b.originalIndex;
            }).map(({ originalIndex, ...item }) => item);
        categories.value = sortedCategories.slice(0, 10)
    }
}).finally(() => {
    loading.value = false
})
</script>

<style scoped lang="scss">

</style>
