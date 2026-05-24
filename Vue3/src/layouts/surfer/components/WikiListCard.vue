<template>
    <div v-if="loading || (wikis && wikis.length > 0)"
        class="theme-bg-secondary theme-text-primary w-full p-5 mb-3 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
        <div class="flex mb-2">
            <!-- 知识库标题 -->
            <h2 class="theme-bg-secondary theme-text-primary flex items-center font-bold">
                <!-- 知识库图标 -->
                <FileTextOutlined class="w-4 h-4 me-2" />
                知识库
                <span v-if="!loading && wikis && wikis.length > 0" class="theme-bg-secondary theme-text-tertiary ml-2">( {{ wikis.length }} )</span>
            </h2>

            <span class="grow"></span>
            <!-- 查看更多 -->
            <a @click="router.push('/surfer/wiki/list')" class=" bg-gray-100 flex items-center px-2.5 py-1 text-xs font-medium text-center 
            text-gray-900  rounded-lg hover:bg-gray-200 focus:ring-4 focus:outline-none focus:ring-gray-200 
            dark:bg-gray-800 dark:text-white dark:border dark:border-gray-700 dark:hover:bg-gray-700 dark:hover:border-gray-700
             dark:focus:ring-gray-700">
                <RightOutlined class="w-[7px] h-[7px] text-gray-400 dark:text-white" />
            </a>
        </div>

        <!-- 加载状态 -->
        <div v-if="loading" class="flex flex-col gap-2">
            <div v-for="i in 4" :key="i" class="flex items-center justify-between p-3 border rounded-lg">
                <div class="flex items-center">
                    <div class="w-8 h-8 rounded mr-3 bg-gray-200 animate-pulse dark:bg-gray-700"></div>
                    <div class="flex-1">
                        <div class="h-4 bg-gray-200 rounded animate-pulse dark:bg-gray-700 mb-2" :style="{ width: Math.random() * 60 + 80 + 'px' }"></div>
                        <div class="h-3 bg-gray-200 rounded animate-pulse dark:bg-gray-700" :style="{ width: Math.random() * 80 + 120 + 'px' }"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 知识库列表 -->
        <div v-else class="text-sm flex flex-col gap-2 font-medium text-gray-600 rounded-lg dark:border-gray-600 dark:text-white">
            <a @click="goWikiArticleDetailPage(wiki.id, wiki.firstArticleId)" v-for="(wiki, index) in wikis"
                :key="index"
                class="cursor-pointer flex items-center justify-between p-3 border rounded-lg 
                hover:bg-gray-400 dark:text-gray-300 focus:ring-4 focus:outline-none focus:ring-gray-300 
                dark:bg-gray-800 dark:hover:bg-gray-700 dark:focus:ring-gray-800 dark:border-gray-700 dark:hover:text-white">
                <div class="flex items-center">
                    <img v-if="wiki.cover" :src="wiki.cover" alt="" class="w-8 h-8 rounded mr-3 object-cover" />
                    <div class="flex-1">
                        <div class="theme-text-primary font-medium">{{ wiki.title }}</div>
                        <div v-if="wiki.summary" class="theme-text-primary text-xs mt-1 line-clamp-1">{{ wiki.summary }}</div>
                    </div>
                </div>
                <div v-if="wiki.isTop" class="flex items-center">
                    <span class="inline-flex items-center justify-center px-2 py-1 text-xs font-semibold text-red-800 bg-red-200 rounded-full">
                        置顶
                    </span>
                </div>
            </a>
        </div>
    </div>
</template>

<script setup lang="ts">
import { getWikiList } from '@/api/surfer/wiki'
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { FileTextOutlined, RightOutlined } from '@ant-design/icons-vue'

// 定义知识库接口
interface Wiki {
    id: string | number
    title: string
    summary: string
    cover: string
    isTop: boolean
    firstArticleId: string | number
    weight?: number  // 权重字段，优先级最高
    sort?: number    // 排序字段，数字越大排序越靠前
}

// 定义API响应接口
interface WikiListResponse {
    success: boolean
    data: Wiki[]
}

const router = useRouter()

// 所有知识库
const wikis = ref<Wiki[]>([])
// 一次显示的知识库数
const size = ref<number>(100000)
// 加载状态
const loading = ref<boolean>(true)

getWikiList().then((res: WikiListResponse) => {
    if (res.success) {
        let wikiList = res.data || [];
        
        // 分两步排序：第一步处理weight>0的数据，第二步处理其他数据
        
        // 第一步：筛选出weight > 0的数据并排序
        const weightItems = wikiList.filter(item => 
            item.hasOwnProperty('weight') && 
            item.weight !== null && 
            item.weight !== undefined && 
            item.weight > 0
        );
        
        // 对weight > 0的数据按weight降序排序
        weightItems.sort((a, b) => {
            const weightA = a.weight || 0;
            const weightB = b.weight || 0;
            if (weightA !== weightB) {
                return weightB - weightA; // weight降序
            }
            // weight相同时，按sort降序排序
            const sortA = a.sort || 0;
            const sortB = b.sort || 0;
            if (sortA !== sortB) {
                return sortB - sortA;
            }
            // weight和sort都相同时，按id升序排序
            return Number(a.id) - Number(b.id);
        });
        
        // 第二步：筛选出weight <= 0或没有weight字段的数据
        const sortItems = wikiList.filter(item => 
            !item.hasOwnProperty('weight') || 
            item.weight === null || 
            item.weight === undefined || 
            item.weight <= 0
        );
        
        // 对这些数据按sort降序排序
        sortItems.sort((a, b) => {
            const sortA = a.sort || 0;
            const sortB = b.sort || 0;
            if (sortA !== sortB) {
                return sortB - sortA; // sort降序
            }
            // sort相同时，按id升序排序
            return Number(a.id) - Number(b.id);
        });
        
        // 合并两个数组：weight > 0的在前，其他的在后
        wikiList = [...weightItems, ...sortItems];
        
        wikis.value = wikiList.slice(0, 10);
    }
}).finally(() => {
    loading.value = false
})

// 跳转知识库文章详情页
const goWikiArticleDetailPage = (wikiId: string | number, articleId: string | number): void => {
    // 跳转时通过路径和query携带参数
    router.push({ path: '/surfer/wiki/' + wikiId, query: { articleId: String(articleId) } })
}
</script>
<style scoped lang="scss">
.line-clamp-1 {
    display: -webkit-box;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;
    overflow: hidden;
}
</style>
