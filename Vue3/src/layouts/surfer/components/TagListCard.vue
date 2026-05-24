<template>
    <div v-if="loading || (tags && tags.length > 0)"
        class="theme-bg-secondary theme-text-primary w-full p-5 mb-3 bg-white border border-gray-200 rounded-lg ">
        <div class="flex mb-2">
            <!-- 标签标题 -->
            <h2 class="theme-bg-secondary theme-text-primary flex items-center font-bold text-gray-900 uppercase dark:text-white">
                <!-- 标签图标 -->
                <TagOutlined class="w-4 h-4 me-2" />
                标签
            </h2>

            <span class="grow"></span>
            <!-- 查看更多 -->
            <a @click="router.push('/surfer/tag/list')" class=" bg-gray-100 flex items-center px-2.5 py-1 text-xs font-medium text-center 
            text-gray-900  rounded-lg hover:bg-gray-200 focus:ring-4 focus:outline-none focus:ring-gray-200 
            dark:bg-gray-800 dark:text-white dark:border dark:border-gray-700 dark:hover:bg-gray-700 dark:hover:border-gray-700
             dark:focus:ring-gray-700">
                <RightOutlined class="w-[7px] h-[7px] text-gray-400 dark:text-white" />
            </a>
        </div>

        <!-- 加载状态 -->
        <div v-if="loading" class="flex flex-wrap gap-2">
            <div v-for="i in 8" :key="i" class="h-6 bg-gray-200 rounded animate-pulse dark:bg-gray-700" :style="{ width: Math.random() * 40 + 40 + 'px' }"></div>
        </div>
        <!-- 标签列表 -->
        <div v-else>
            <span v-for="(tag, index) in tags" :key="index" @click="goTagArticleListPage(tag.id, tag.name)"
                class="inline-block mb-1 cursor-pointer bg-green-100 text-green-800 text-xs font-medium me-2 px-2.5 py-0.5 
                rounded hover:bg-green-200 hover:text-green-900 dark:bg-green-900 dark:text-green-300 dark:hover:bg-green-950">
                {{ tag.name }}
            </span>
        </div>
    </div>
</template>

<script setup lang="ts">
import { getTagList } from '@/api/surfer/tag'
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { TagOutlined, RightOutlined } from '@ant-design/icons-vue'

// 定义标签接口
interface Tag {
    id: number
    name: string
    sort: number
}

// 定义API响应接口
interface TagListResponse {
    success: boolean
    data: Tag[]
}

const router = useRouter()

// 所有标签
const tags = ref<Tag[]>([])
// 一次显示的标签数
const size = ref<number>(100000)
// 加载状态
const loading = ref<boolean>(true)

getTagList({ size: size.value }).then((res: TagListResponse) => {
    if (res.success) {
        // 按sort字段降序排序，sort值大的在前面，sort值相同时按id升序
        tags.value = res.data.sort((a, b) => {
            const sortA = a.sort || 0
            const sortB = b.sort || 0
            if (sortA !== sortB) {
                return sortB - sortA // 降序
            }
            return a.id - b.id // id升序
        }).slice(0, 10)
    }
}).finally(() => {
    loading.value = false
})

// 跳转标签文章列表页
const goTagArticleListPage = (id: number, name: string): void => {
    // 跳转时通过 query 携带参数（标签 ID、标签名称）
    router.push({ path: '/surfer/tag/article/list', query: { id, name } })
}
</script>
