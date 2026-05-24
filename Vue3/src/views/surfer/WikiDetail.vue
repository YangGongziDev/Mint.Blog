<template>
    <div class="wiki-detail">
      <main class="theme-bg-secondary theme-text-primary grow container max-w-8xl mx-auto px-4 sm:px-6 md:px-8 py-4">
          <!-- 左边栏 -->
          <div class="wiki-sidebar transition-all duration-300 hidden lg:block fixed inset-0 top-[88px] 
                right-auto w-[304px] pb-10 pr-6 overflow-y-auto"
              :class="[isExpand ? 'left-[max(0px,calc(50%-720px))] w-[320px] pl-8' : 'left-0 w-0 pl-0 2xl:left-[max(0px,calc(50%-720px))] 2xl:w-[304px] 2xl:pl-8']"
              >
              <div class="flex">
                  <!-- 知识库目录 -->
                  <div class="grow transition-all duration-300" :class="[isExpand ? 'block' : 'hidden 2xl:block']">
                      <a-collapse v-model:activeKey="activeKeys" ghost class="last:pb-[17.6px]">
                          <a-collapse-panel v-for="(catalog, index) in catalogs" :key="catalog.id" class="">
                              <template #header>
                                  <span class="theme-text-primary font-bold flex items-center text-[19.2px]" v-html="catalog.title"></span>
                              </template>
                              <ul class="scrollbar-none">
                                <!-- 二级目录标题 -->
                                <li v-for="(childCatalog, index2) in catalog.children" :key="index2" class="theme-text-primary catalog-item flex items-center pl-10 py-2 pr-3 rounded-lg cursor-pointer 
                                    dark:text-gray-400 mt-1.5 border-1"
                                    :class="[childCatalog.articleId == route.query.articleId ? 'active bg-sky-50 text-sky-600 dark:bg-sky-950 dark:text-sky-500' : 'hover:bg-gray-100 dark:hover:bg-gray-800']"
                                    @click="goWikiArticleDetailPage(childCatalog.articleId)" v-html="childCatalog.title">
                                </li>
                              </ul>
                          </a-collapse-panel>
                      </a-collapse>
                  </div>
                  <!-- 点击收缩、展开 -->
                  <div class="expand-toggle hidden md:inline-block 2xl:hidden transition-all duration-300" :class="{ 'expanded': isExpand }" @click="shrinkAndExpand">
                    <div id="left-toc-sidebar" class="left-toc-sidebar top-[88px]">
                      <span id="left-toc-sidebar-arrow" class="arrow start flex items-center justify-center -rotate-90" :class="[isExpand ? '-rotate-90' : 'rotate-90']"></span>
                    </div>
                  </div>
              </div>
          </div>
          <!-- 中间栏 -->
          <div class="transition-all duration-300" :class="[isExpand ? 'lg:pl-[360px]' : 'lg:pl-0 2xl:pl-[360px]']">
              <div class="theme-bg-secondary theme-text-primary max-w-3xl mx-auto xl:max-w-none xl:ml-0 xl:mr-[248px] xl:pr-16">
                  <!-- 文章 -->
                  <article class="article-container">
                      <!-- 文章标题、标签、Meta 信息 -->
                      <div class="theme-bg-secondary theme-text-primary bg-white dark:bg-gray-900">
                          <div class="max-w-screen-xl flex flex-col flex-wrap mx-auto px-4 md:px-6 pb-14 pt-10">
                              <!-- 文章标题 -->
                              <h1 class="font-bold text-4xl md:text-5xl mb-8 dark:text-white">{{ article.title }}</h1>
                              <!-- 标签集合 -->
                              <div v-if="article.tags && article.tags.length > 0" class="mb-5">
                                  <span @click="goTagArticleListPage(tag.id!, tag.name!)" v-for="(tag, index) in article.tags" :key="index"
                                      class="inline-block mb-1 cursor-pointer bg-green-100 text-green-800 text-sm font-medium mr-2 
                                      px-2.5 py-0.5 rounded-md hover:bg-green-200 hover:text-green-900 
                                      dark:bg-green-900 dark:hover:bg-green-950 dark:text-green-300">
                                      # {{ tag.name }}
                                  </span>
                              </div>
                              <!-- Meta 信息 -->
                              <div class="flex gap-3 md:gap-6 text-gray-400 items-center text-sm">
                                  <!-- 字数 -->
                                  <a-tooltip title="总字数">
                                      <div class="flex items-center">
                                          <FileTextOutlined class="w-4 h-4 mr-1 text-gray-400" />
                                          {{ article.totalWords }}
                                      </div>
                                  </a-tooltip>
                                  <!-- 阅读时长 -->
                                  <div class="hidden md:block">
                                      <a-tooltip title="阅读时长">
                                          <div class="flex items-center">
                                              <ClockCircleOutlined class="w-4 h-4 mr-1.5 text-gray-400" />
                                              {{ article.readTime }}
                                          </div>
                                      </a-tooltip>
                                  </div>

                                  <!-- 发布时间 -->
                                  <a-tooltip title="发布时间">
                                      <div class="flex items-center">
                                          <CalendarOutlined class="w-[18px] h-[18px] mr-1 text-gray-400" />
                                          {{ article.createTime }}
                                      </div>
                                  </a-tooltip>

                                  <!-- 分类 -->
                                  <a-tooltip title="分类">
                                      <div class="flex items-center">
                                          <FolderOutlined class="w-4 h-4 mr-1.5 text-gray-400" />
                                          <a @click="goCategoryArticleListPage(article.categoryId!, article.categoryName!)"
                                              class="cursor-pointer mr-1 hover:underline">{{ article.categoryName }}</a>
                                      </div>
                                  </a-tooltip>

                                  <!-- 阅读量 -->
                                  <a-tooltip title="阅读量">
                                      <div class="flex items-center">
                                          <EyeOutlined class="w-[18px] h-[18px] mr-1 text-gray-400" />
                                          {{ article.readNum }}
                                      </div>
                                  </a-tooltip>
                              </div>
                          </div>
                      </div>
                      <!-- 正文 -->
                      <div>
                          <div ref="articleContentRef" v-viewer v-html="article.content" class="theme-bg-secondary theme-text-primary p-5 border border-gray-200 rounded-lg mt-0 backdrop-blur-sm article-content"></div>
                      </div>

                      <!-- 最后编辑时间 -->
                      <div class="flex items-center text-gray-500 text-sm">
                          <EditOutlined class="icon inline-block w-4 h-4 me-1 mt-5 mb-5" />
                          最后编辑于 {{ article.updateTime }}
                      </div>

                      <!-- 版权声明 -->
                      <div class="mt-6 mb-6">
                        <div class="flex items-start gap-3 p-4 rounded-xl border shadow-sm bg-gray-50/80 text-gray-700 border-gray-200 dark:bg-gray-800/60 dark:text-gray-300 dark:border-gray-700">
                          <div class="flex-shrink-0">
                            <CopyrightOutlined class="w-5 h-5 text-sky-500 dark:text-sky-400 mt-0.5" />
                          </div>
                          <div>
                            <p class="text-sm font-bold  uppercase tracking-wide text-gray-500 dark:text-gray-400 mb-1">版权声明</p>
                            <p v-if="blogSettingsStore.blogSettings.copyrightDeclaration" class="whitespace-pre-line text-sm leading-relaxed">
                              © {{ new Date(article.createTime).getFullYear() }} <span class="text-blue-500">{{ blogSettingsStore.blogSettings.author }}</span> {{ blogSettingsStore.blogSettings.copyrightDeclaration }}
                            </p>
                            <p v-else class="whitespace-pre-line text-sm leading-relaxed">
                              © {{ new Date(article.createTime).getFullYear() }} <span class="text-blue-500">{{ blogSettingsStore.blogSettings.author }}</span> 保留所有权利。转载请注明出处和原文连接。
                            </p>
                            <!-- 原文链接 -->
                            <div class="mt-2 text-xs text-gray-500 dark:text-gray-400 flex items-start gap-1">
                              <LinkOutlined class="mt-[2px] w-3.5 h-3.5 text-gray-400 dark:text-gray-500" />
                              <span class="text-sm shrink-0">原文链接：</span>
                              <a :href="currentArticleUrl" target="_blank" class="text-sm text-sky-600 dark:text-sky-400 hover:underline break-all">{{ currentArticleUrl }}</a>
                            </div>
                          </div>
                        </div>
                      </div>

                      <!-- 上下篇 -->
                      <nav class="article-navigation flex flex-row mt-7" v-if="preNext">
                          <!-- basis-1/2 用于占用 flex 布局的一半空间 -->
                          <div class="basis-1/2">
                              <!-- h-full 指定高度占满 -->
                              <a v-if="preNext.preArticle" @click="goWikiArticleDetailPage(preNext.preArticle.articleId)"
                                  class="nav-button cursor-pointer flex flex-col h-full p-4 me-3 text-base font-medium text-gray-500 bg-white border border-gray-300 rounded-lg hover:border-sky-500 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">
                                  <div>
                                      <LeftOutlined class="inline w-3.5 h-3.5 me-2 mb-1" />
                                      上一篇
                                  </div>
                                  <div v-html="preNext.preArticle.articleTitle"></div>
                              </a>
                          </div>

                          <div class="basis-1/2">
                              <!-- text-right 指定文字居右显示 -->
                              <a v-if="preNext.nextArticle"
                                  @click="goWikiArticleDetailPage(preNext.nextArticle.articleId)"
                                  class="nav-button cursor-pointer flex flex-col h-full text-right p-4 text-base font-medium text-gray-500 bg-white border border-gray-300 rounded-lg hover:border-sky-500 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">
                                  <div>
                                      下一篇
                                      <RightOutlined class="inline w-3.5 h-3.5 ms-2 mb-1" />
                                  </div>
                                  <div v-html="preNext.nextArticle.articleTitle"></div>
                              </a>
                          </div>
                      </nav>
                  </article>

                  <!-- 评论组件 -->
                  <Comment customeCss=""></Comment>
              </div>
          </div>
          <!-- 右边栏 -->
          <div class="fixed top-[100.8px] bottom-0 right-[max(0px,calc(50%-800px))] 
              w-[312px] py-10 overflow-y-auto hidden xl:block">
              <WikiToc></WikiToc>
          </div>
      </main>
    </div>
</template>

<script setup lang="ts">
import { ref, watch, onMounted, nextTick, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import type { RouteLocationNormalized } from 'vue-router'
import { FileTextOutlined, ClockCircleOutlined, CalendarOutlined, FolderOutlined, EyeOutlined, EditOutlined, LeftOutlined, RightOutlined, LinkOutlined } from '@ant-design/icons-vue'
import WikiToc from '@/layouts/surfer/components/WikiToc.vue'
import { getArticleDetail } from '@/api/surfer/article.ts'
import { getWikiArticlePreNext, getWikiCatalogs } from '@/api/surfer/wiki.ts'
import hljs from 'highlight.js/lib/common'
import 'highlight.js/styles/tokyo-night-dark.css'
import Comment from '@/components/surfer/Comment.vue'
import { useBlogSettingsStore } from '@/stores/blogsettings'

// 类型定义
interface WikiCatalog {
  id: string | number
  title: string
  children: WikiCatalogChild[]
}

// 版权声明（来自博客设置接口）
const blogSettingsStore = useBlogSettingsStore();
// 原文链接（默认使用当前页面完整地址）
const currentArticleUrl = computed(() => {
  return window.location.href
})
interface WikiCatalogChild {
  articleId: string | number
  title: string
}

interface Article {
  title: string
  content: string
  totalWords: number
  readTime: string
  createTime: string
  updateTime: string
  categoryId: string | number
  categoryName: string
  readNum: number
}

interface PreNextArticle {
  articleId: string | number
  articleTitle: string
}

interface PreNext {
  preArticle: PreNextArticle | null
  nextArticle: PreNextArticle | null
}

interface ApiResponse<T> {
  success: boolean
  data: T
  errorCode?: string
}

onMounted(() => {
})

const route = useRoute()
const router = useRouter()

const catalogs = ref<WikiCatalog[]>([])

// 获取当前知识库的目录数据
getWikiCatalogs(route.params.wikiId as string).then((res: ApiResponse<WikiCatalog[]>) => {
    if (res.success) {
        catalogs.value = res.data
    }
})

// 文章数据
const article = ref<Article>({} as Article)
// 上下页
const preNext = ref<PreNext | null>(null)

// 获取文章详情
function refreshArticleDetail(articleId: string | number | undefined): void {
    if (!articleId) {
        // 该知识库下暂未添加文章
        return
    }

    // 文章详情
    getArticleDetail(articleId).then((res: ApiResponse<Article>) => {
        // 该文章不存在(错误码为 20010)
        if (!res.success && res.errorCode == '20010') {
            // 手动跳转 404 页面
            router.push({ path: '/404' })
            return
        }

        article.value = res.data

        nextTick(() => {
            // 获取所有 pre code 节点
            let highlight = document.querySelectorAll('pre code')
            // 循环高亮
            highlight.forEach((block) => {
                hljs.highlightElement(block as HTMLElement)
            })

            let preElements = document.querySelectorAll('pre')
            preElements.forEach((preElement: Element) => {
                // 找到第一个 code 元素
                let firstCode = preElement.querySelector('code');
                if (firstCode) {
                    let copyCodeBtn = '<button class="hidden copy-code-btn flex items-center justify-center"><div class="copy-icon"></div></button>'
                    firstCode.insertAdjacentHTML('beforebegin', copyCodeBtn);

                    // 获取刚插入的按钮
                    let copyBtn = firstCode.previousSibling as HTMLButtonElement;
                    if (copyBtn) {
                        copyBtn.addEventListener('click', () => {
                            // 添加 copied 样式
                            copyBtn.classList.add('copied');
                            const textContent = preElement.textContent || '';
                            copyToClipboard(textContent);
                            // 1.5 秒后移除 copied 样式
                            setTimeout(() => {
                                copyBtn.classList.remove('copied');
                            }, 1500);
                        });
                    }
                }

                // 添加事件监听器
                preElement.addEventListener('mouseenter', handleMouseEnter);
                preElement.addEventListener('mouseleave', handleMouseLeave);
            })

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
        })

    })

    // 上下页
    getWikiArticlePreNext({ id: route.params.wikiId as string, articleId: articleId }).then((res: ApiResponse<PreNext>) => {
        if (res.success) {
            preNext.value = res.data
        }
    })
}
refreshArticleDetail(route.query.articleId as string)

const handleMouseEnter = (event: Event): void => {
    // 鼠标移入，显示按钮
    let copyBtn = (event.target as HTMLElement).querySelector('button');
    if (copyBtn) {
        copyBtn.classList.remove('hidden');
        copyBtn.classList.add('block');
    }
}

const handleMouseLeave = (event: Event): void => {
    // 鼠标移出，隐藏按钮
    let copyBtn = (event.target as HTMLElement).querySelector('button');
    if (copyBtn) {
        copyBtn.classList.add('hidden');
    }
}

function copyToClipboard(text: string): void {
    const textarea = document.createElement('textarea');
    textarea.value = text;
    document.body.appendChild(textarea);
    textarea.select();
    document.execCommand('copy');
    document.body.removeChild(textarea);
}

// 跳转文章详情页
const goWikiArticleDetailPage = (articleId: string | number): void => {
    router.push({ path: '/surfer/wiki/' + route.params.wikiId, query: { articleId } })
}

// 跳转分类文章列表页
const goCategoryArticleListPage = (categoryId: string | number, categoryName: string): void => {
    router.push({ path: '/surfer/category/' + categoryId, query: { categoryName } })
}

// 监听路由
watch(route, (newRoute: RouteLocationNormalized, oldRoute: RouteLocationNormalized) => {
    // 重新渲染文章详情
    refreshArticleDetail(newRoute.query.articleId as string)
})

// 目录是否展开，默认为 true
const isExpand = ref<boolean>(true)
// 点击收缩、展开
const shrinkAndExpand = (): void => {
    isExpand.value = !isExpand.value
}

// Ant Design Collapse组件的活动键
const activeKeys = ref<(string | number)[]>([])
</script>

<style lang="scss" scoped>
/* 代码块样式 */
:deep(code) {
    font-size: 98%;
    background-color: rgba(175, 184, 193, 0.2);
    padding: 2px 4px;
    border-radius: 3px;
    font-family: 'Fira Code', 'Monaco', 'Consolas', monospace;
}

:deep(pre) {
    position: relative; /* 为三个点提供相对定位基准 */
    margin-bottom: 20px;
    border-radius: 6px;
    background: #21252b;
    overflow-x: auto;
}

:deep(pre code.hljs) {
    padding: 32px 16px 11.2px 16px;
    border-radius: 6px;
    background: transparent;
    font-family: 'Fira Code', 'Monaco', 'Consolas', monospace;
    line-height: 1.5;
}

:deep(pre:before) {
    background: #fc625d;
    border-radius: 50%;
    box-shadow: 20px 0 #fdbc40, 40px 0 #35cd4b;
    content: ' ';
    height: 10px;
    width: 10px;
    position: absolute;
    top: 10px;
    left: 10px;
    z-index: 1;
}

// Wiki详情页面样式
.wiki-detail {
  // 折叠面板主题样式
  :deep(.ant-collapse) {
    .ant-collapse-header {
      .ant-collapse-arrow {
        color: var(--theme-text-primary) !important;
        transition: color 0.3s ease;
        
        &:hover {
          color: var(--theme-accent) !important;
        }
      }
    }
    // 暗黑模式下的箭头颜色
    .dark & {
      .ant-collapse-header {
        .ant-collapse-arrow {
          color: var(--theme-text-primary) !important;
          &:hover {
            color: var(--theme-accent) !important;
          }
        }
      }
    }
  }

  // 主容器样式
  .main {
    background-color: #fff;
    transition: background-color 0.3s ease;
  }
  
  // 左侧目录样式
  .wiki-sidebar {
    transition: all 0.3s ease;
    // 隐藏滚动条，但保留滚动功能
    scrollbar-width: none; /* Firefox */
    -ms-overflow-style: none; /* IE 和 Edge */
    &::-webkit-scrollbar { /* Chrome, Safari, Opera */
      width: 0px;
      height: 0px;
      display: none;
    }
    // 目录项悬停效果
    .catalog-item {
      transition: all 0.2s ease;
      border-radius: 8px;
      
      &:hover {
        background-color: rgba(59, 130, 246, 0.1);
        transform: translateX(4px);
      }
      
      &.active {
        background: linear-gradient(135deg, #3b82f6, #1d4ed8);
        color: white;
        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
      }
    }
  }
  
  // 文章内容区域
  .article-container {
    /* border: #009879 1px solid; */
    .article-header {     
      .article-meta {
        .meta-item {
          transition: all 0.2s ease;
          border-radius: 6px;
          padding: 4px 8px;
          &:hover {
            background-color: rgba(59, 130, 246, 0.1);
            transform: scale(1.05);
          }
        }
      }
    }
    
    .article-content {
      animation: fadeInUp 0.6s ease-out;
    }
    
    .article-navigation {
      .nav-button {
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        
        &::before {
          content: '';
          position: absolute;
          top: 0;
          left: -100%;
          width: 100%;
          height: 100%;
          background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
          transition: left 0.5s ease;
        }
        
        &:hover {
          transform: translateY(-2px);
          box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
          
          &::before {
            left: 100%;
          }
        }
      }
    }
  }
  
  // 收缩展开按钮
  .expand-toggle {
    transition: all 0.3s ease;
    
    &:hover {
      background-color: rgba(59, 130, 246, 0.1);
      transform: scale(1.1);
    }
    
    .arrow {
      transition: transform 0.3s ease;
    }
    
    &.expanded .arrow {
      transform: rotate(180deg);
    }
  }
}

// 动画定义
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes slideInLeft {
  from {
    opacity: 0;
    transform: translateX(-30px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

// 响应式设计
@media (max-width: 768px) {
  .wiki-detail {
    .wiki-sidebar {
      transform: translateX(-100%);
      
      &.expanded {
        transform: translateX(0);
      }
    }
  }
}

/* ===== 同步自 ArticleDetail.vue 的文章内容样式，覆盖 WikiDetail 自定义，确保两页一致 ===== */
/* 标题样式 */
:deep(.article-content h1,
.article-content h2,
.article-content h3,
.article-content h4,
.article-content h5,
.article-content h6) {
  color: #292525;
  line-height: 150%;
  font-family: PingFang SC, Helvetica Neue, Helvetica, Hiragino Sans GB, Microsoft YaHei, "\5FAE\8F6F\96C5\9ED1", Arial, sans-serif;
}

:deep(.article-content h2) {
  line-height: 1.5;
  font-weight: 700;
  font-synthesis: style;
  font-size: 24px;
  margin-top: 40px;
  margin-bottom: 26px;
  line-height: 140%;
  border-bottom: 1px solid rgb(241 245 249);
  padding-bottom: 15px;
}

:deep(.dark .article-content h2) {
  --tw-text-opacity: 1;
  color: rgb(226 232 240/var(--tw-text-opacity));
  border-bottom: 1px solid;
  border-color: rgb(55 65 81 / 1);
}

:deep(.article-content h3) {
  font-size: 20px;
  margin-top: 40px;
  margin-bottom: 16px;
  font-weight: 600;
}

:deep(.dark .article-content h3) {
  --tw-text-opacity: 1;
  color: rgb(226 232 240/var(--tw-text-opacity));
}

:deep(.article-content h4) {
  font-size: 18px;
  margin-top: 30px;
  margin-bottom: 16px;
  font-weight: 600;
}

:deep(.dark .article-content h4) {
  --tw-text-opacity: 1;
  color: rgb(226 232 240/var(--tw-text-opacity));
}

:deep(.article-content h5) {
  font-size: 16px;
  margin-top: 30px;
  margin-bottom: 14px;
  font-weight: 600;
}

:deep(.dark .article-content h5) {
  --tw-text-opacity: 1;
  color: rgb(226 232 240/var(--tw-text-opacity));
}

:deep(.article-content h6) {
  font-size: 16px;
  margin-top: 30px;
  margin-bottom: 14px;
  font-weight: 600;
}

:deep(.dark .article-content h6) {
  --tw-text-opacity: 1;
  color: rgb(226 232 240/var(--tw-text-opacity));
}

/* 段落样式 */
:deep(.article-content p) {
  letter-spacing: .3px;
  margin: 0 0 20px;
  line-height: 30px;
  color: #4c4e4d;
  font-weight: 400;
  word-break: normal;
  word-wrap: break-word;
  font-family: -apple-system, BlinkMacSystemFont, PingFang SC, Hiragino Sans GB, Microsoft Yahei, Arial, sans-serif;
}

:deep(.dark .article-content p) {
  color: #9e9e9e;
}

/* blockquote 引用样式 */
:deep(.article-content blockquote) {
  border-left: 2.3px solid rgb(52, 152, 219);
  quotes: none;
  background: rgb(236, 240, 241);
  color: #777;
  font-size: 16px;
  margin-bottom: 20px;
  padding: 24px;
}

:deep(.dark .article-content blockquote) {
  quotes: none;
  --tw-bg-opacity: 1;
  background-color: rgb(31 41 55 / var(--tw-bg-opacity));
  border-left: 2.3px solid #555;
  color: #666;
  font-size: 16px;
  margin-bottom: 20px;
  padding: 4px 0 4px 16px;
}

/* 设置 blockquote 中最后一个 p 标签的 margin-bottom 为 0 */
:deep(.article-content blockquote p:last-child) {
  margin-bottom: 0;
}

/* 斜体样式 */
:deep(.article-content em) {
  color: #c849ff;
}

/* 超链接样式 */
:deep(.article-content a) {
  color: #167bc2;
}

:deep(.article-content a:hover) {
  text-decoration: underline;
}

/* ul 样式 */
:deep(.article-content ul) {
  padding-left: 32px;
}

:deep(.dark .article-content ul) {
  padding-left: 32px;
  color: #9e9e9e;
}

:deep(.article-content > ul) {
  margin-bottom: 20px;
}

:deep(.article-content ul li) {
  list-style-type: disc;
  padding-top: 5px;
  padding-bottom: 5px;
  font-size: 16px;
  color: #666;
}

:deep(.article-content ul li p) {
  margin-bottom: 0!important;
}

:deep(.article-content ul ul li) {
  list-style-type: square;
}

/* ol 样式 */
:deep(.article-content ol) {
  list-style-type: decimal;
  padding-left: 32px;
}

:deep(.dark .article-content ol) {
  color: #9e9e9e;
}

/* 图片样式 */
:deep(.article-content img) {
  max-width: 100%;
  overflow: hidden;
  display: block;
  margin: 0 auto;
  border-radius: 8px;
}

:deep(.article-content img:hover,
img:focus) {
  box-shadow: 2px 2px 10px 0 rgba(0, 0, 0, .15);
}

/* 图片描述文字 */
:deep(.image-caption) {
  min-width: 20%;
  max-width: 80%;
  min-height: 43px;
  display: block;
  padding: 10px;
  margin: 0 auto;
  font-size: 13px;
  color: #999;
  text-align: center;
}

/* code 样式 */
:deep(.article-content code:not(pre code)) {
  padding: 2px 4px;
  margin: 0 2px;
  font-size: 95% !important;
  border-radius: 4px;
  color: rgb(41, 128, 185);
  background-color: rgba(27, 31, 35, 0.05);
  font-family: Operator Mono, Consolas, Monaco, Menlo, monospace;
}

:deep(.dark .article-content code:not(pre code)) {
  padding: 2px 4px;
  margin: 0 2px;
  font-size: .85em;
  border-radius: 5px;
  color: #abb2bf;
  background: #333;
  font-family: Operator Mono, Consolas, Monaco, Menlo, monospace;
}

/* 表格样式 */
:deep(table) {
  margin-bottom: 20px;
  width: 100%;
}

:deep(table tr) {
  background-color: #fff;
  border-top: 1px solid #c6cbd1;
}

:deep(table th) {
  padding: 6px 13px;
  border: 1px solid #dfe2e5;
}

:deep(table td) {
  padding: 6px 13px;
  border: 1px solid #dfe2e5;
}

:deep(table tr:nth-child(2n)) {
  background-color: #f6f8fa;
}

:deep(.dark table tr) {
  background-color: rgb(31 41 55 / 1);
}

:deep(.dark table) {
  color: #9e9e9e;
}

:deep(.dark table th) {
  border: 1px solid #394048;
}

:deep(.dark table td) {
  border: 1px solid #394048;
}

:deep(.dark table tr:nth-child(2n)) {
  background-color: rgb(21 41 55 / 1);
}

/* hr 横线 */
:deep(hr) {
  margin-bottom: 20px;
}

:deep(.dark hr) {
  --tw-border-opacity: 1;
  border-color: rgb(55 65 81 / var(--tw-border-opacity));
}

/* 复制代码按钮（保持与 ArticleDetail 一致） */
:deep(.copy-code-btn) {
  border-width: 0;
  cursor: pointer;
  position: absolute;
  top: 0.5em;
  right: 0.5em;
  z-index: 5;
  width: 40px;
  height: 40px;
  padding: 0;
  border-radius: 8px;
  opacity: 0;
  transition: opacity .4s;
  opacity: 1
}

:deep(.copy-code-btn:hover) {
  background: #2f3542;
}

:deep(.copy-icon) {
  --copy-icon: url("data:image/svg+xml;utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' height='20' width='20' stroke='rgba(128,128,128,1)' stroke-width='2'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' d='M9 5H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2M9 5a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2M9 5a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2'/%3E%3C/svg%3E");
  background: currentcolor;
  -webkit-mask-image: var(--copy-icon);
  mask-image: var(--copy-icon);
  -webkit-mask-position: 50%;
  mask-position: 50%;
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;
  -webkit-mask-size: 1em;
  mask-size: 1em;
  width: 20px;
  height: 20px;
  padding: 10px;
  color: #9e9e9e;
  font-size: 20px;
}

:deep(.copied) {
  display: flex;
  background: #2f3542;
}

:deep(.copied:after) {
  content: "已复制";
  position: absolute;
  top: 0;
  right: calc(100% + 4px);
  display: block;
  height: 40px;
  padding: 10px;
  border-radius: 8px;
  background: #2f3542;
  color: #9e9e9e;
  font-weight: 500;
  line-height: 20px;
  white-space: nowrap;
  font-size: 14px;
  font-family: -apple-system, BlinkMacSystemFont, PingFang SC, Hiragino Sans GB, Microsoft Yahei, Arial, sans-serif;
}

:deep(.copied .copy-icon) {
  --copied-icon: url("data:image/svg+xml;utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' height='20' width='20' stroke='rgba(128,128,128,1)' stroke-width='2'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' d='M9 5H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2M9 5a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2M9 5a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2m-6 9 2 2 4-4'/%3E%3C/svg%3E");
  -webkit-mask-image: var(--copied-icon);
  mask-image: var(--copied-icon);
}
/* ===== END 同步样式 ===== */

// 响应式设计
@media (max-width: 768px) {
  .wiki-detail {
    .wiki-sidebar {
      transform: translateX(-100%);
      
      &.expanded {
        transform: translateX(0);
      }
    }
  }
}

// 图片描述样式
:deep(.article-content) {
  // 标题样式
  h1, h2, h3, h4, h5, h6 {
    line-height: 150%;
    font-family: PingFang SC, Helvetica Neue, Helvetica, Hiragino Sans GB, Microsoft YaHei, "\5FAE\8F6F\96C5\9ED1", Arial, sans-serif;
    transition: color 0.3s ease;
    
    &:hover {
      color: #3b82f6;
    }
  }
  
  h2 {
    line-height: 1.5;
    font-weight: 700;
    font-synthesis: style;
    font-size: 24px;
    margin-top: 40px;
    margin-bottom: 26px;
    line-height: 140%;
    border-bottom: 1px solid rgb(241 245 249);
    padding-bottom: 15px;
    position: relative;
    
    &::after {
      content: '';
      position: absolute;
      bottom: -1px;
      left: 0;
      width: 0;
      height: 2px;
      background: linear-gradient(90deg, #3b82f6, #1d4ed8);
      transition: width 0.3s ease;
    }
    
    &:hover::after {
      width: 100%;
    }
  }
  
  h3 {
    font-size: 20px;
    margin-top: 40px;
    margin-bottom: 16px;
    font-weight: 600;
  }
  
  h4 {
    font-size: 18px;
    margin-top: 30px;
    margin-bottom: 16px;
    font-weight: 600;
  }
  
  h5 {
    font-size: 16px;
    margin-top: 30px;
    margin-bottom: 14px;
    font-weight: 600;
  }
  
  h6 {
    font-size: 16px;
    margin-top: 30px;
    margin-bottom: 14px;
    font-weight: 600;
  }
  
  // 引用块样式
  blockquote {
    border-left: 2.3px solid rgb(52, 152, 219);
    quotes: none;
    background: rgb(236, 240, 241);
    color: #777;
    font-size: 16px;
    margin-bottom: 20px;
    padding: 24px;
    border-radius: 0 8px 8px 0;
    position: relative;
    transition: all 0.3s ease;
    
    &::before {
      content: '"';
      position: absolute;
      top: -10px;
      left: 10px;
      font-size: 32px;
      color: rgb(52, 152, 219);
      opacity: 0.3;
    }
    
    &:hover {
      background: rgb(226, 230, 231);
      transform: translateX(4px);
    }
    
    p:last-child {
      margin-bottom: 0;
    }
  }
  
  // 段落样式
  p {
    letter-spacing: .3px;
    margin: 0 0 20px;
    line-height: 30px;
    color: #4c4e4d;
    font-weight: 400;
    word-break: normal;
    word-wrap: break-word;
    font-family: -apple-system, BlinkMacSystemFont, PingFang SC, Hiragino Sans GB, Microsoft Yahei, Arial, sans-serif;
    transition: color 0.3s ease;
  }
  
  // 强调文本
  em {
    color: #c849ff;
    font-style: italic;
  }
  
  // 链接样式
  a {
    color: #2980b9;
    transition: all 0.3s ease;
    position: relative;
    
    &:hover {
      text-decoration: underline;
      color: #1d4ed8;
    }
    
    &::after {
      content: '';
      position: absolute;
      bottom: -2px;
      left: 0;
      width: 0;
      height: 2px;
      background: linear-gradient(90deg, #2980b9, #1d4ed8);
      transition: width 0.3s ease;
    }
    
    &:hover::after {
      width: 100%;
    }
  }
}

  // 列表样式
  ul {
    padding-left: 32px;
    margin-bottom: 20px;
    
    li {
      list-style-type: disc;
      padding-top: 5px;
      padding-bottom: 5px;
      font-size: 16px;
      transition: all 0.2s ease;
      
      &:hover {
        transform: translateX(2px);
        color: #3b82f6;
      }
      
      &::marker {
        color: #3b82f6;
      }
      
      p {
        margin-bottom: 0 !important;
      }
    }
    
    ul li {
      list-style-type: square;
    }
  }
  
  // 有序列表样式
  ol {
    list-style-type: decimal;
    padding-left: 32px;
    margin-bottom: 20px;
    
    li {
      transition: all 0.2s ease;
      
      &:hover {
        transform: translateX(2px);
        color: #3b82f6;
      }
      
      &::marker {
        color: #3b82f6;
        font-weight: 600;
      }
    }
  }
  
  // 图片样式
  img {
    max-width: 100%;
    overflow: hidden;
    display: block;
    margin: 0 auto;
    border-radius: 8px;
    transition: all 0.3s ease;
    
    &:hover,
    &:focus {
      box-shadow: 2px 2px 10px 0 rgba(0, 0, 0, .15);
      transform: scale(1.02);
    }
  }
  
  // 图片描述样式
  .image-caption {
    min-width: 20%;
    max-width: 80%;
    min-height: 43px;
    display: block;
    padding: 10px;
    margin: 0 auto;
    font-size: 13px;
    color: #999;
    text-align: center;
    opacity: 0.8;
    transition: opacity 0.3s ease;
    
    &:hover {
      opacity: 1;
    }
  }
  
  // 行内代码样式
  code:not(pre code) {
    padding: 2px 4px;
    margin: 0 2px;
    font-size: 95% !important;
    border-radius: 4px;
    color: rgb(41, 128, 185);
    background-color: rgba(27, 31, 35, 0.05);
    font-family: Operator Mono, Consolas, Monaco, Menlo, monospace;
    transition: all 0.2s ease;
    
    &:hover {
      background-color: rgba(27, 31, 35, 0.1);
      transform: scale(1.05);
    }
  }
  
  code {
    font-size: 98%;
  }
  
  // 代码块样式
  pre {
    margin-bottom: 20px;
    padding-top: 30px;
    background: #21252b;
    border-radius: 6px;
    position: relative;
    transition: all 0.3s ease;
    
    &:hover {
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    }
    
    code.hljs {
      padding: 11.2px 16px;
      border-bottom-left-radius: 6px;
      border-bottom-right-radius: 6px;
    }
    
    &:before {
      background: #fc625d;
      border-radius: 50%;
      box-shadow: 20px 0 #fdbc40, 40px 0 #35cd4b;
      content: ' ';
      height: 10px;
      margin-top: -19px;
      margin-left: 10px;
      position: absolute;
      width: 10px;
    }
  }

  // 表格样式
  table {
    border-collapse: collapse;
    margin: 25px 0;
    font-size: 0.9em;
    font-family: sans-serif;
    min-width: 400px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
    width: 100%;
    border-radius: 8px;
    overflow: hidden;
    transition: all 0.3s ease;
    
    &:hover {
      box-shadow: 0 0 30px rgba(0, 0, 0, 0.2);
      transform: translateY(-2px);
    }
    
    tr {
      background-color: #fff;
      border-top: 1px solid #c6cbd1;
      transition: background-color 0.3s ease;
      
      &:hover {
        background-color: #e8f4fd;
      }
      
      &:nth-child(2n) {
        background-color: #f6f8fa;
        
        &:hover {
          background-color: #e8f4fd;
        }
      }
    }
    
    th {
      background: linear-gradient(135deg, #009879, #00b894);
      color: #ffffff;
      font-weight: bold;
      padding: 12px 15px;
      text-align: left;
      border: 1px solid #dfe2e5;
      position: relative;
      
      &::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 0;
        height: 2px;
        background: #ffffff;
        transition: width 0.3s ease;
      }
      
      &:hover::after {
        width: 100%;
      }
    }
    
    td {
      padding: 12px 15px;
      border: 1px solid #dfe2e5;
      transition: all 0.2s ease;
      
      &:hover {
        background-color: rgba(59, 130, 246, 0.05);
      }
    }
  }
  
  // 分割线样式
  hr {
    border: none;
    height: 1px;
    background: linear-gradient(to right, transparent, #ccc, transparent);
    margin: 32px 0;
    position: relative;
    
    &::after {
      content: '';
      position: absolute;
      top: -1px;
      left: 50%;
      transform: translateX(-50%);
      width: 0;
      height: 3px;
      background: linear-gradient(90deg, #3b82f6, #1d4ed8);
      transition: width 0.3s ease;
    }
    
    &:hover::after {
      width: 100px;
    }
  }

  // 复制代码按钮样式
  .copy-code-btn {
    border-width: 0;
    cursor: pointer;
    position: absolute;
    top: 0.5em;
    right: 0.5em;
    z-index: 5;
    width: 40px;
    height: 40px;
    padding: 0;
    border-radius: 8px;
    opacity: 1;
    transition: all 0.3s ease;
    background: rgba(47, 53, 66, 0.8);
    backdrop-filter: blur(4px);
    
    &:hover {
      background: linear-gradient(135deg, #2f3542, #1a1f2e);
      transform: scale(1.1);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
    }
    
    &.copied {
      display: flex;
      background: linear-gradient(135deg, #10b981, #059669);
      
      &::after {
        content: "已复制";
        position: absolute;
        top: 0;
        right: calc(100% + 4px);
        display: block;
        height: 40px;
        padding: 10px;
        border-radius: 8px;
        background: linear-gradient(135deg, #10b981, #059669);
        color: #ffffff;
        font-weight: 500;
        line-height: 20px;
        white-space: nowrap;
        font-size: 14px;
        font-family: -apple-system, BlinkMacSystemFont, PingFang SC, Hiragino Sans GB, Microsoft Yahei, Arial, sans-serif;
        animation: slideInRight 0.3s ease;
      }
      
      .copy-icon {
        --copied-icon: url("data:image/svg+xml;utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' height='20' width='20' stroke='rgba(128,128,128,1)' stroke-width='2'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' d='M9 5H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2M9 5a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2M9 5a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2m-6 9 2 2 4-4'/%3E%3C/svg%3E");
        -webkit-mask-image: var(--copied-icon);
        mask-image: var(--copied-icon);
        color: #ffffff;
      }
    }
  }
  
  .copy-icon {
    --copy-icon: url("data:image/svg+xml;utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' height='20' width='20' stroke='rgba(158,158,158,1)' stroke-width='2'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' d='M9 5H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2M9 5a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2M9 5a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2'/%3E%3C/svg%3E");
    background: currentcolor;
    -webkit-mask-image: var(--copy-icon);
    mask-image: var(--copy-icon);
    -webkit-mask-position: 50%;
    mask-position: 50%;
    -webkit-mask-repeat: no-repeat;
    mask-repeat: no-repeat;
    -webkit-mask-size: 1em;
    mask-size: 1em;
    width: 20px;
    height: 20px;
    padding: 10px;
    color: #9e9e9e;
    font-size: 20px;
    transition: color 0.3s ease;
  }
  
  // 滚动条样式
  ::-webkit-scrollbar {
    width: 8px;
    height: 8px;
  }
  
  ::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 4px;
  }
  
  ::-webkit-scrollbar-thumb {
    background: linear-gradient(135deg, #c1c1c1, #a8a8a8);
    border-radius: 4px;
    transition: background 0.3s ease;
    
    &:hover {
      background: linear-gradient(135deg, #a8a8a8, #909090);
    }
  }
  
  // 动画定义
  @keyframes slideInRight {
    from {
      opacity: 0;
      transform: translateX(10px);
    }
    to {
      opacity: 1;
      transform: translateX(0);
    }
  }

// 旋转样式
.rotate-180 {
  --tw-rotate: 180deg;
  transform: translate(var(--tw-translate-x), var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y));
}

// 收缩、展开侧边栏样式
.left-toc-sidebar {
  position: fixed;
  bottom: 0;
  z-index: 100;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 32px;
  transition: all 0.3s ease;
  border-radius: 8px 8px 0 0;
  backdrop-filter: blur(8px);
  background: rgba(255, 255, 255, 0.8);
  
  &:hover {
    background: rgba(59, 130, 246, 0.1);
    cursor: pointer;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  }
  
  // 箭头样式
  .arrow {
    display: inline-block;
    vertical-align: middle;
    width: 1em;
    height: 1em;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='rgba(59,130,246,0.8)' d='M7.41 15.41L12 10.83l4.59 4.58L18 14l-6-6-6 6z'/%3E%3C/svg%3E");
    line-height: normal;
    transition: all 0.3s ease;
    
    &:hover {
      transform: scale(1.1);
    }
  }
  
  // 暗黑主题样式
  :global(html[class=dark]) & {
    background: rgba(31, 41, 55, 0.8);
    
    &:hover {
      background: rgba(59, 130, 246, 0.2);
    }
    
    .arrow {
      background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='rgba(147,197,253,0.8)' d='M7.41 15.41L12 10.83l4.59 4.58L18 14l-6-6-6 6z'/%3E%3C/svg%3E");
    }
  }
}

</style>