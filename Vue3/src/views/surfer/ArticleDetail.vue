<template>
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
    <!-- 主内容区域 -->
    <main class="container max-w-screen-xl mx-auto px-4 md:px-6 py-4">
        <!-- 使用 Ant Design Vue 栅格系统替代原有 CSS Grid -->
        <a-row :gutter="[28, 28]">
            <!-- 左侧主列：桌面端占 18 栅格，移动端 24 栅格 -->
            <a-col :xs="24" :md="18">
              <div class="mb-3">
                <!-- 文章卡片父容器 -->
                <div class="theme-bg-secondary theme-text-primary w-full p-5 mb-3 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
                    <!-- 文章 -->
                    <article>
                        <!-- 正文 -->
                        <div>
                            <div ref="articleContentRef" v-viewer v-html="article.content" class="theme-bg-secondary theme-text-primary mt-5 article-content"></div>
                            <!-- <div ref="articleContentRef" v-viewer v-html="article.content" class="article-content mt-5"></div> -->
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
                                © {{ new Date(article.createTime).getFullYear() }} <span class="text-blue-500">{{ blogSettingsStore.blogSettings.author }}</span> 保留所有权利，转载请注明出处和原文连接。
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
                        <nav class="flex flex-row mt-7">
                            <!-- basis-1/2 用于占用 flex 布局的一半空间 -->
                            <div class="basis-1/2">
                                <!-- h-full 指定高度占满 -->
                                <a v-if="article.preArticle" @click="router.push('/surfer/article/' + article.preArticle.articleId)"
                                    class="theme-bg-secondary theme-text-primary cursor-pointer flex flex-col h-full p-4 mr-3 text-base font-medium text-gray-500 bg-white border border-gray-300 rounded-lg hover:border-sky-500 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">
                                    <div>
                                        <LeftOutlined class="inline w-3.5 h-3.5 mr-2 mb-1" />
                                        上一篇
                                    </div>
                                    <div>{{ article.preArticle.articleTitle }}</div>
                                </a>
                            </div>

                            <div class="basis-1/2">
                                <!-- text-right 指定文字居右显示 -->
                                <a v-if="article.nextArticle" @click="router.push('/surfer/article/' + article.nextArticle.articleId)"
                                    class="theme-bg-secondary theme-text-primary cursor-pointer flex flex-col h-full text-right p-4 text-base font-medium text-gray-500 bg-white border border-gray-300 rounded-lg hover:border-sky-500 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">
                                    <div>
                                        下一篇
                                        <RightOutlined class="inline w-3.5 h-3.5 ml-2 mb-1" />
                                    </div>
                                    <div>{{ article.nextArticle.articleTitle }}</div>
                                </a>
                            </div>
                        </nav>
                    </article>
                </div>
                <!-- 评论组件 -->
                <Comment></Comment>
              </div>
            </a-col>
            <!-- 右侧侧栏：桌面端占 6 栅格，移动端 24 栅格 -->
            <a-col :xs="24" :md="6">
              <aside>
                  <!-- 文章目录 -->
                  <Toc></Toc>
              </aside>
            </a-col>
        </a-row>
    </main>
</template>

<script setup lang="ts">
import Toc from '@/layouts/surfer/components/Toc.vue'
import { getArticleDetail } from '@/api/surfer/article'
import { useRoute, useRouter } from 'vue-router'
import { ref, watch, onMounted, nextTick, computed } from 'vue'
import hljs from 'highlight.js'
import 'highlight.js/styles/tokyo-night-dark.css'
import Comment from '@/components/surfer/Comment.vue'
import type { Ref } from 'vue'
import type { RouteLocationNormalized } from 'vue-router'
import { FileTextOutlined, ClockCircleOutlined, CalendarOutlined, FolderOutlined, EyeOutlined, LeftOutlined, RightOutlined, CopyrightOutlined, LinkOutlined } from '@ant-design/icons-vue'
import { useBlogSettingsStore } from '@/stores/blogsettings'

// 定义文章接口
interface Tag {
  id: number
  name: string
}

// 版权声明（来自博客设置接口）
const blogSettingsStore = useBlogSettingsStore();
// 原文链接（默认使用当前页面完整地址）
const currentArticleUrl = computed(() => {
  return window.location.href
})

interface Article {
  id?: number
  title?: string
  content?: string
  tags?: Tag[]
  totalWords?: number
  readTime?: string
  createTime?: string
  categoryId?: number
  categoryName?: string
  readNum?: number
  preArticle?: {
    articleId: number
    articleTitle: string
  }
  nextArticle?: {
    articleId: number
    articleTitle: string
  }
}

interface ApiResponse {
  success: boolean
  errorCode?: string
  data?: Article
}

// 组件挂载后的初始化
onMounted(() => {
    // Ant Design Vue tooltips 会自动初始化
})

const route = useRoute()
const router = useRouter()

// 文章数据
const article: Ref<Article> = ref({})


// 获取文章详情
function refreshArticleDetail(articleId: string | string[]) {
    getArticleDetail(route.params.articleId).then((res: ApiResponse) => {
        // 该文章不存在(错误码为 20010)
        if (!res.success && res.errorCode == '20010') {
            // 手动跳转 404 页面
            router.push({ path: '/404' })
            return
        }

        article.value = res.data || {}

        nextTick(() => {
            // 获取所有 pre code 节点
            let highlight = document.querySelectorAll('pre code')
            // 循环高亮
            highlight.forEach((block) => {
                hljs.highlightElement(block as HTMLElement)
            })

            // 获取所有的 pre 节点
            let preElements = document.querySelectorAll('pre')
            preElements.forEach(preElement => {
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
}
refreshArticleDetail(route.params.articleId || '')

// 跳转分类文章列表页
const goCategoryArticleListPage = (id: number, name: string) => {
    // 跳转时通过 query 携带参数（分类 ID、分类名称）
    router.push({ path: '/surfer/category/article/list', query: { id, name } })
}

// 跳转标签文章列表页
const goTagArticleListPage = (id: number, name: string) => {
    // 跳转时通过 query 携带参数（标签 ID、标签名称）
    router.push({ path: '/surfer/tag/article/list', query: { id, name } })
}

// 监听路由
watch(route, (newRoute: RouteLocationNormalized, oldRoute: RouteLocationNormalized) => {
    // 重新渲染文章详情
    refreshArticleDetail(newRoute.params.articleId || '')
})

// 复制内容到剪切板
function copyToClipboard(text: string) {
    const textarea = document.createElement('textarea');
    textarea.value = text;
    document.body.appendChild(textarea);
    textarea.select();
    document.execCommand('copy');
    document.body.removeChild(textarea);
}

const handleMouseEnter = (event: Event) => {
    // 鼠标移入，显示按钮
    const target = event.target as HTMLElement;
    let copyBtn = target.querySelector('button');
    if (copyBtn) {
        copyBtn.classList.remove('hidden');
        copyBtn.classList.add('block');
    }
}

const handleMouseLeave = (event: Event) => {
    // 鼠标移出，隐藏按钮
    const target = event.target as HTMLElement;
    let copyBtn = target.querySelector('button');
    if (copyBtn) {
        copyBtn.classList.add('hidden');
    }
}
</script>

<style scoped lang="scss">
/* 代码块样式 */

/* h1, h2, h3, h4, h5, h6 标题样式 */
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

/* p 段落样式 */
:deep(.article-content p) {
    letter-spacing: .3px;
    margin: 0 0 20px;
    line-height: 30px;
    color: #9e9e9e;
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
    color: #9e9e9e;
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
    color: #9e9e9e;
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
    color: #9e9e9e;
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
</style>
