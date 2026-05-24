<template>
    <!-- 主内容区域 -->
    <main class="max-w-screen-xl mx-auto px-4 md:px-6 py-4">
        <a-row :gutter="[{ xs: 0, sm: 16, md: 28, lg: 28 }, 28]" class="w-full">
            <!-- 左侧主列：桌面端占 18 栅格，移动端 24 栅格 -->
            <a-col :xs="24" :md="18">
              <div class="mt-[40px] mb-3">
                <!-- 文章列表，经典交替布局 -->
                <div class="space-y-4">
<!--                     <div v-for="(article, index) in articles" :key="index" >-->
<!--                        <test></test>-->
<!--                     </div>-->
                    
                  <div v-for="(article, index) in articles" :key="index" 
                         class="theme-bg-secondary theme-text-primary classics-article-item bg-white border border-gray-200 
                         relative flex h-[190px] md:h-60 lg:h-52 xl:h-60 animate__animated animate__fadeInUp rounded-lg overflow-hidden">
                    
                        
                      <!-- 偶数索引：左图右文 -->
                      <div v-if="index % 2 === 0" 
                            class="relative min-w-[45%] overflow-hidden hidden sm:block z-30"
                            :style="{ clipPath: 'polygon(0 0, 90% 0, 100% 100%, 0 100%)' }">
                          <div class="w-full h-full bg-cover bg-no-repeat bg-center scale-100 hover:scale-125 transition-transform duration-300 cursor-pointer"
                                :style="{ backgroundImage: `url(${article.cover || getDefaultCover()})` }"
                                @click="goArticleDetailPage(article.id)">
                          </div>
                      </div>

                      <!-- 文章内容区域 -->
                      <div class="relative w-full sm:w-[65%] py-5 px-5 sm:px-10 lg:px-5 xl:px-10 z-20">
                          <div @click="goArticleDetailPage(article.id)" 
                                class="flex flex-col justify-between flex-1 text-center sm:text-start cursor-pointer">
                              <!-- 文章标题 -->
                              <a-tooltip 
                                  :title="article.title.length > 15 ? article.title : ''" 
                                  placement="top"
                                  :disabled="article.title.length <= 15">
                                  <h3 class="theme-text-primary overflow-hidden relative w-full mb-3 text-white hover:text-blue-400 text-lg md:text-xl lg:text-[22px] xl:text-2xl line-clamp-1 transition-colors duration-200">
                                      {{ article.title }}
                                  </h3>
                              </a-tooltip>
                              <!-- 文章摘要 -->
                              <a-tooltip 
                                  :title="getArticleInfo(article).length > 50 ? getArticleInfo(article) : ''" 
                                  placement="top"
                                  :disabled="getArticleInfo(article).length <= 50">
                                  <p class="theme-text-primary text-[#cecece] text-sm sm:text-[15px] leading-7 sm:indent-8 line-clamp-2 xl:line-clamp-3 mb-4">
                                      {{ getArticleInfo(article) }}
                                  </p>
                              </a-tooltip>
                              <!-- 文章信息 -->
                              <div :class="`flex ${index % 2 === 0 ? 'sm:justify-start' : 'sm:justify-start'} justify-center pt-5 text-end space-x-4 sm:space-x-8`">
                                  <!-- 发布时间 -->
                                  <div class="flex items-center text-xs text-white">
                                      <span class="pr-1">
                                          <CalendarOutlined class="p-1 mt-[-2px] mr-[3px] text-[23px] text-white rounded-full align-middle bg-[#539dfd]" />
                                      </span>
                                      <span class="theme-text-primary">{{ article.createDate }}</span>
                                  </div>

                                  <!-- 浏览量（模拟数据） -->
                                  <div class="flex items-center text-xs text-white">
                                      <span class="pr-1">
                                          <EyeOutlined class="p-1 mt-[-2px] mr-[3px] text-[23px] text-white rounded-full align-middle bg-[#eb373a]" />
                                      </span>
                                      <span class="theme-text-primary">{{ getRandomViews() }}</span>
                                  </div>

                                  <!-- 所属分类 -->
                                  <div @click.stop="goCategoryArticleListPage(article.category.id, article.category.name)" class="flex items-center text-xs text-white">
                                      <span class="pr-1">
                                          <FolderOutlined class="p-1 mt-[-2px] mr-[3px] text-[23px] text-white rounded-full align-middle bg-[#f5a630]" />
                                      </span>
                                      <span class="theme-text-primary cursor-pointer hover:underline">
                                          {{ article.category.name }}
                                      </span>
                                  </div>
                              </div>
                              <!-- 标签显示 -->
                              <div class="flex flex-wrap gap-2 mb-3 mt-3">
                                  <span v-for="(tag, tagIndex) in article.tags.slice(0, 4)" :key="tagIndex" 
                                      @click.stop="goTagArticleListPage(tag.id, tag.name)"
                                      class="tag-item cursor-pointer bg-green-100 text-green-800 text-xs font-medium px-2 py-1 rounded dark:bg-green-900 dark:text-green-300 hover:bg-green-200 transition-colors duration-200">
                                      {{ tag.name }}
                                  </span>
                              </div>
                          </div>
                      </div>

                      <!-- 模糊背景 -->
                      <div class="classics-article-bg absolute inset-0 bg-cover bg-center"
                            :style="{ 
                                filter: 'blur(88px) brightness(0.99)', 
                                backgroundImage: `url(${article.cover || getDefaultCover()})` 
                            }">
                      </div>

                      <!-- 奇数索引：右图左文 -->
                      <div v-if="index % 2 !== 0" 
                            class="relative min-w-[45%] overflow-hidden hidden sm:block z-30"
                            :style="{ clipPath: 'polygon(10% 0, 100% 0, 100% 100%, 0 100%)' }">
                          <div class="w-full h-full bg-cover bg-no-repeat bg-center scale-100 hover:scale-125 transition-transform duration-300 cursor-pointer"
                                :style="{ backgroundImage: `url(${article.cover || getDefaultCover()})` }"
                                @click="goArticleDetailPage(article.id)">
                          </div>
                      </div>

                      <!-- 置顶标识 -->
                      <div v-if="article.isTop" 
                            class="archive-badge absolute inline-flex items-center justify-center w-14 h-7 text-xs font-bold text-white bg-red-500 border-2 border-white rounded-full top-2 right-2 z-30 dark:border-gray-900">
                          置顶
                      </div>


                    </div>

                </div>
                <!-- 分页 -->
                <nav aria-label="Page navigation example" class="mt-10 flex justify-center">
                    <ul class="flex items-center -space-x-px h-10 text-base">
                        <!-- 上一页 -->
                        <li>
                            <a @click="getArticles(current - 1)"
                                class="flex items-center justify-center px-4 h-10 ml-0 leading-tight text-gray-500 bg-white border border-gray-300 rounded-l-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                                :class="[current > 1 ? '' : 'cursor-not-allowed']"
                                >

                                <span class="sr-only">上一页</span>
                                <LeftOutlined class="w-3 h-3" />
                            </a>
                        </li>
                        <!-- 页码 -->
                        <li v-for="(pageNo, index) in pages" :key="index">
                            <a @click="getArticles(pageNo)"
                                class="pagination-item flex items-center justify-center px-4 h-10 leading-tight border dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                                :class="[pageNo == current ? 'active text-gray-500 border-gray-300 bg-white' : 'text-gray-500 border-gray-300 bg-white']"
                                >
                                {{ index + 1 }}
                            </a>
                        </li>
                        <!-- 下一页 -->
                        <li>
                            <a @click="getArticles(current + 1)"
                                class="flex items-center justify-center px-4 h-10 leading-tight text-gray-500 bg-white border border-gray-300 rounded-r-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                                :class="[current < pages ? '' : 'cursor-not-allowed']"
                                >
                                <span class="sr-only">下一页</span>
                                <RightOutlined class="w-3 h-3" />
                            </a>
                        </li>
                    </ul>
                </nav>
              </div>
            </a-col>
            <!-- 右侧侧栏：桌面端占 6 栅格，移动端 24 栅格 -->
            <a-col :xs="24" :md="6">
              <aside class="mt-[40px] mb-3 animate__animated animate__fadeInUp">
                  <div class="sticky top-[40px]">
                      <!-- 博主信息 -->
                      <UserInfoCard></UserInfoCard>
                      <!-- 分类 -->
                      <CategoryListCard></CategoryListCard>
                      <!-- 标签 -->
                      <TagListCard></TagListCard>
                      <!-- 知识库 -->
                      <WikiListCard></WikiListCard>
                  </div>
              </aside>
            </a-col>
        </a-row>
    </main>
</template>

<script setup lang="ts">
import test from '@/layouts/surfer/components/test.vue'
import UserInfoCard from '@/layouts/surfer/components/UserInfoCard.vue'
import CategoryListCard from '@/layouts/surfer/components/CategoryListCard.vue'
import TagListCard from '@/layouts/surfer/components/TagListCard.vue'
import WikiListCard from '@/layouts/surfer/components/WikiListCard.vue'
import { CalendarOutlined, FolderOutlined, LeftOutlined, RightOutlined, EyeOutlined } from '@ant-design/icons-vue'
import { ref, computed } from 'vue'
import { getArticlePageList } from '@/api/surfer/article.ts'
import { useRouter } from 'vue-router'
import type { Router } from 'vue-router'


// 定义文章类型
interface Article {
  id: number
  title: string
  summary?: string
  cover: string
  createDate: string
  isTop: boolean
  category: {
    id: number
    name: string
  }
  tags: Array<{
    id: number
    name: string
  }>
}

// 定义分页响应类型
interface PageResponse {
  success: boolean
  data: Article[]
  current: number
  size: number
  total: number
  pages: number
}

const router: Router = useRouter()

// 跳转分类文章列表页
const goCategoryArticleListPage = (id: number, name: string): void => {
    // 跳转时通过 query 携带参数（分类 ID、分类名称）
    router.push({path: '/surfer/category/article/list', query: {id, name}})
}

// 文章集合
const articles = ref<Article[]>([])
// 当前页码
const current = ref<number>(1)
// 每页显示的文章数
const size = ref<number>(10)
// 总文章数
const total = ref<number>(0)
// 总共多少页
const pages = ref<number>(0)

function getArticles(currentNo: number): void {
    // 上下页是否能点击判断，当要跳转上一页且页码小于 1 时，则不允许跳转；当要跳转下一页且页码大于总页数时，则不允许跳转
    if (currentNo < 1 || (pages.value > 0 && currentNo > pages.value)) return
    // 调用分页接口渲染数据
    getArticlePageList({current: currentNo, size: size.value}).then((res: PageResponse) => {
        if (res.success) {
            articles.value = res.data
            current.value = res.current
            size.value = res.size
            total.value = res.total
            pages.value = res.pages
            // 滚动到页面顶部
            const scrollContainer = document.querySelector('.surfer-layout-main') as HTMLElement
            if (scrollContainer) {
                scrollContainer.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                })
            } else {
                // 回退到window滚动
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                })
            }
        }
    })
}
getArticles(current.value)

// 跳转文章详情页
const goArticleDetailPage = (articleId: number): void => {
    router.push('/surfer/article/' + articleId)
}

// 跳转标签文章列表页
const goTagArticleListPage = (id: number, name: string): void => {
    // 跳转时通过 query 携带参数（标签 ID、标签名称）
    router.push({path: '/surfer/tag/article/list', query: {id, name}})
}

// 生成文章摘要信息
const getArticleInfo = (article: Article): string => {
    if (article.summary?.trim()?.length) {
        return article.summary
    } else {
        return '这是一篇精彩的文章，点击查看详细内容...'
    }
}

// 获取默认封面
const getDefaultCover = (): string => {
    return 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSIjZjNmNGY2Ii8+PHRleHQgeD0iNTAlIiB5PSI1MCUiIGZvbnQtZmFtaWx5PSJBcmlhbCwgc2Fucy1zZXJpZiIgZm9udC1zaXplPSIxNCIgZmlsbD0iIzk5YTNhZiIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZHk9Ii4zZW0iPuWbvueJh+WKoOi9veWksei0pTwvdGV4dD48L3N2Zz4='
}

// 生成随机浏览量（模拟数据）
const getRandomViews = (): number => {
    return Math.floor(Math.random() * 1000) + 100
}
</script>

<style lang="scss" scoped>

.archive-badge {
    animation: pulse 2s infinite;
    background: linear-gradient(135deg, #ef4444, #dc2626);
    box-shadow: 0 4px 14px 0 rgba(239, 68, 68, 0.4);

    &::before {
        content: '';
        position: absolute;
        top: -2px;
        left: -2px;
        right: -2px;
        bottom: -2px;
        background: linear-gradient(135deg, #ef4444, #dc2626);
        border-radius: inherit;
        z-index: -1;
        filter: blur(4px);
        opacity: 0.7;
    }
}

.classics-article-item {
    /* background: linear-gradient(135deg, #1a1a1a, #2d2d2d); */
    border-radius: 12px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
    transition: all 0.3s ease;
    
    &:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 40px rgba(0, 0, 0, 0.4);
    }
}

.article-card {
  transition: transform 0.2s ease-in-out;
  &:hover {
    transform: scale(1.03);
  }
}

.tag-item {
  transition: all 0.2s ease-in-out;
  &:hover {
    background-color: rgb(187 247 208);
    color: rgb(20 83 45);
  }
}

.pagination-item {
  transition: all 0.2s ease-in-out;
  
  &.active {
    color: rgb(2 132 199);
    background-color: rgb(240 249 255);
    border-color: rgb(14 165 233);
    
    &:hover {
      background-color: rgb(219 234 254);
      color: rgb(3 105 161);
    }
  }
  
  &:not(.active):hover {
    background-color: rgb(243 244 246);
    color: rgb(55 65 81);
  }
}

// 文章卡片圆角处理
.classics-article-item {
  border-radius: 8px;
  overflow: hidden;
  
  // 确保所有子元素都遵循圆角边界
  * {
    border-radius: inherit;
  }
  
  // 封面图片容器的圆角处理
  .relative.min-w-\[45\%\] {
    border-radius: 0;
    
    div {
      border-radius: 0;
    }
  }
}

// 响应式优化
@media (max-width: 640px) {
  .classics-article-item {
    height: auto !important;
    min-height: 200px;
  }
}

// 文本截断样式
.line-clamp-1 {
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

// 深色主题下的特殊样式
:deep(.dark) {
  .classics-article-item {
    /* background: linear-gradient(135deg, #0f0f0f, #1a1a1a); */
  }
}
</style>
