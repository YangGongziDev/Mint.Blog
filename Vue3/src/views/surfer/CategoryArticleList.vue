<template>
    <!-- 主内容区域 -->
    <main class="container max-w-screen-xl mx-auto px-4 md:px-6 py-4">
        <!-- grid 表格布局，分为 4 列 -->
        <div class="grid grid-cols-4 gap-7">
            <!-- 左边栏，占用 3 列 -->
            <div class="mt-[40px] col-span-4 md:col-span-3 mb-3">
                <!-- 分类 -->
                <div class="theme-bg-secondary w-full p-5 pb-7 mb-3 border rounded-lg sticky top-0 z-20 bg-white dark:bg-gray-800 dark:border-gray-700 shadow-sm">
                    <!-- 分类标题 -->
                    <h2 class="theme-text-primary flex items-center mb-5 font-bold">
                        <!-- 文件夹图标 -->
                        <FolderOutlined class="w-5 h-5 mr-2 text-blue-600" />
                        分类
                        <span v-if="categories && categories.length > 0"
                            class="ml-2 text-gray-600 font-normal dark:text-gray-300">
                            ( {{ categories.length }} )
                        </span>
                    </h2>
                    <!-- 分类列表 -->
                    <div class="text-sm flex flex-wrap gap-3 font-medium text-gray-600 rounded-lg dark:border-gray-600 dark:text-white">
                        <a @click="goCategoryArticleListPage(category.id, category.name)"
                            v-for="(category, index) in categories" :key="index"
                            :class="[route.query.name == category.name ? 'bg-sky-100 hover:bg-sky-200' : 'hover:bg-gray-400']"
                            class="theme-bg-secondary theme-text-primary inline-flex cursor-pointer items-center px-4 py-2 text-sm font-medium text-center border rounded-lg 
                                focus:ring-4 focus:outline-none focus:ring-gray-300 
                                dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-400 dark:focus:ring-gray-800 dark:border-gray-700 dark:hover:text-white">
                            {{ category.name }}
                            <span
                                class="inline-flex items-center justify-center w-4 h-4 ms-2 text-xs font-semibold text-sky-800 bg-sky-200 rounded-full">
                                {{ category.articlesTotal }}
                            </span>
                        </a>
                    </div>
                </div>

                <!-- 分类文章列表 -->
                <div class="p-5 mb-4 border rounded-lg">
                    <ol v-if="articles && articles.length > 0" class="divide-y divider-gray-200 dark:divide-gray-700">
                        <li v-for="(article, index) in articles" :key="index">
                            <a @click="goArticleDetailPage(article.id)" class="cursor-pointer items-center block p-3 sm:flex hover:bg-gray-400 hover:rounded-lg dark:hover:bg-gray-700">
                                <img class="w-24 h-12 mb-3 mr-3 rounded-lg sm:mb-0" :src="article.cover" />
                                <div class="text-gray-600 dark:text-gray-400">
                                    <h2 class="theme-text-primary text-base font-normal">
                                        {{ article.title }}
                                    </h2>
                                    <span
                                        class="theme-text-primary inline-flex items-center text-xs font-normal">
                                        <CalendarOutlined class="theme-text-primary w-2.5 h-2.5 mr-2" />
                                        {{ article.createDate }}
                                    </span>
                                </div>
                            </a>
                        </li>
                    </ol>

                    <!-- 该分类下没有文章提示，指定为 flex 布局，内容垂直水平居中，并纵向排列  -->
                    <div v-else class="flex items-center justify-center flex-col">
                        <img src="../../assets/Empty.svg" alt="暂无文章" class="w-80 h-60 mb-4" />
                        <p class="mt-2 mb-16 text-gray-400">此分类下还未发布文章哟~</p>
                    </div>
                </div>

                <!-- 分页 -->
                <nav aria-label="Page navigation example" class="mt-10 flex justify-center" v-if="total > 0">
                    <ul class="flex items-center -space-x-px h-10 text-base">
                        <!-- 上一页 -->
                        <li>
                            <a @click="getCategoryArticles(current - 1)"
                                class="flex items-center justify-center px-4 h-10 ml-0 leading-tight text-gray-500 bg-white border border-gray-300 rounded-l-lg hover:bg-gray-400 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                                :class="[current > 1 ? '' : 'cursor-not-allowed']">

                                <span class="sr-only">上一页</span>
                                <LeftOutlined class="w-3 h-3" />
                            </a>
                        </li>
                        <!-- 页码 -->
                        <li v-for="(pageNo, index) in pages" :key="index">
                            <a @click="getCategoryArticles(pageNo)"
                                class="flex items-center justify-center px-4 h-10 leading-tight border  dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                                :class="[pageNo == current ? 'text-sky-600  bg-sky-50 border-sky-500 hover:bg-sky-100 hover:text-sky-700' : 'text-gray-500 border-gray-300 bg-white hover:bg-gray-400 hover:text-gray-700']">
                                {{ index + 1 }}
                            </a>
                        </li>
                        <!-- 下一页 -->
                        <li>
                            <a @click="getCategoryArticles(current + 1)"
                                class="flex items-center justify-center px-4 h-10 leading-tight text-gray-500 bg-white border border-gray-300 rounded-r-lg hover:bg-gray-400 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                                :class="[current < pages ? '' : 'cursor-not-allowed']">
                                <span class="sr-only">下一页</span>
                                <RightOutlined class="w-3 h-3" />
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>

            <!-- 右边侧边栏，占用一列 -->
            <aside class="col-span-4 md:col-span-1 mt-[40px] mb-3">
              <div class="sticky top-[40px]">
                      <!-- 博主信息 -->
                      <UserInfoCard></UserInfoCard>
                      <!-- 标签 -->
                      <TagListCard></TagListCard>
                      <!-- 知识库 -->
                      <WikiListCard></WikiListCard>
                  </div>
              </aside>
        </div>
    </main>
</template>

<script setup>
import Header from '@/layouts/surfer/components/Header.vue'
import Footer from '@/layouts/surfer/components/Footer.vue'
import UserInfoCard from '@/layouts/surfer/components/UserInfoCard.vue'
import TagListCard from '@/layouts/surfer/components/TagListCard.vue'
import WikiListCard from '@/layouts/surfer/components/WikiListCard.vue'
import ScrollToTopButton from '@/layouts/surfer/components/ScrollToTopButton.vue'
import { FolderOutlined, CalendarOutlined, LeftOutlined, RightOutlined } from '@ant-design/icons-vue'
import { ref, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getCategoryArticlePageList, getCategoryList } from '@/api/surfer/category'

const route = useRoute()
const router = useRouter()

// 文章集合
const articles = ref([])
// 分类名称
const categoryName = ref(route.query.name)
// 分类 ID
const categoryId = ref(route.query.id)

// 监听路由
watch(route, (newRoute, oldRoute) => {
    categoryName.value = newRoute.query.name
    categoryId.value = newRoute.query.id
    getCategoryArticles(current.value)
})

// 当前页码
const current = ref(1)
// 每页显示的文章数
const size = ref(10)
// 总文章数
const total = ref(0)
// 总共多少页
const pages = ref(0)

function getCategoryArticles(currentNo) {
    // 上下页是否能点击判断，当要跳转上一页且页码小于 1 时，则不允许跳转；当要跳转下一页且页码大于总页数时，则不允许跳转
    if (currentNo < 1 || (pages.value > 0 && currentNo > pages.value)) return
    // 调用分页接口渲染数据
    getCategoryArticlePageList({ current: currentNo, size: size.value, id: categoryId.value }).then((res) => {
        if (res.success) {
            articles.value = res.data
            current.value = res.current
            size.value = res.size
            total.value = res.total
            pages.value = res.pages
            console.log(articles)
        }
    })
}
getCategoryArticles(current.value)

// 跳转文章详情页
const goArticleDetailPage = (articleId) => {
    router.push('/surfer/article/' + articleId)
}

// 所有分类
const categories = ref([])
getCategoryList({}).then((res) => {
    if (res.success) {
        categories.value = res.data
    }
})

// 跳转分类文章列表页
const goCategoryArticleListPage = (id, name) => {
    // 跳转时通过 query 携带参数（分类 ID、分类名称）
    router.push({ path: '/surfer/category/article/list', query: { id, name } })
}
</script>
