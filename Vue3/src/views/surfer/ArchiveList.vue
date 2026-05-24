<template>
    <!-- 主内容区域 -->
    <main class="container max-w-screen-xl mx-auto px-4 md:px-6 py-4">
        <!-- grid 表格布局，分为 4 列 -->
        <div class="grid grid-cols-4 gap-7">
            <!-- 左边栏，占用 3 列 -->
            <div class="mt-[40px] col-span-4 md:col-span-3 mb-3">
                <!-- 筛选功能区域 -->
                <!-- 筛选功能区域：始终固定在页面顶部位置（sticky） -->
                <div class="theme-bg-secondary theme-text-primary p-4 mb-4 border border-gray-200 rounded-lg bg-white dark:bg-gray-800 dark:border-gray-700 sticky top-0 z-20 shadow-sm">
                    <div class="flex flex-col md:flex-row gap-4 items-start md:items-center">
                        <!-- 年份筛选 -->
                        <div class="flex items-center gap-2">
                            <label class="text-sm font-medium">年份:</label>
                            <select v-model="selectedYear" @change="handleYearChange" 
                                class="px-3 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:text-white">
                                <option value="" class="theme-bg-secondary theme-text-primary">全部年份</option>
                                <option v-for="year in availableYears" :key="year" :value="year" class="theme-bg-secondary theme-text-primary">{{ year }}</option>
                            </select>
                        </div>
                        <!-- 月份筛选 -->
                        <div class="flex items-center gap-2">
                            <label class="text-sm font-medium">月份:</label>
                            <select v-model="selectedMonth" @change="handleMonthChange" 
                                class="px-3 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:text-white">
                                <option value="" class="theme-bg-secondary theme-text-primary">全部月份</option>
                                <option v-for="month in availableMonths" :key="month.value" :value="month.value" class="theme-bg-secondary theme-text-primary">{{ month.label }}</option>
                            </select>
                        </div>
                        
                        <!-- 文章标题搜索 -->
                        <div class="flex items-center gap-2 flex-1">
                            <label class="theme-bg-secondary theme-text-primary text-sm font-medium">搜索:</label>
                            <div class="relative flex-1">
                                <input v-model="searchTitle" @input="handleSearchChange" 
                                    placeholder="输入文章标题关键词" 
                                    class="w-full px-3 py-2 pr-8 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:text-white dark:placeholder-gray-400">
                                <button v-if="searchTitle" @click="clearSearch"
                                    class="absolute right-2 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300">
                                    ✕
                                </button>
                            </div>
                        </div>
                        
                        <!-- 快速跳转 -->
                        <div class="flex items-center gap-2">
                            <button @click="quickJumpToLatest" 
                                class="px-3 py-2 bg-blue-500 text-white rounded-md text-sm hover:bg-blue-600 transition-colors">
                                最新
                            </button>
                            <button @click="quickJumpToOldest" 
                                class="px-3 py-2 bg-green-500 text-white rounded-md text-sm hover:bg-green-600 transition-colors">
                                最早
                            </button>
                        </div>
                        
                        <!-- 重置按钮 -->
                        <button @click="resetFilters" 
                            class="px-4 py-2 bg-gray-500 text-white rounded-md text-sm hover:bg-gray-600 transition-colors">
                            重置
                        </button>
                    </div>
                    
                    <!-- 筛选结果提示 -->
                    <div v-if="hasActiveFilters" class="mt-3 text-sm text-gray-600 dark:text-gray-400">
                        当前筛选: 
                        <span v-if="selectedYear" class="inline-block bg-blue-100 text-blue-800 px-2 py-1 rounded mr-2 dark:bg-blue-900 dark:text-blue-300">{{ selectedYear }}年</span>
                        <span v-if="selectedMonth" class="inline-block bg-green-100 text-green-800 px-2 py-1 rounded mr-2 dark:bg-green-900 dark:text-green-300">{{ getMonthLabel(selectedMonth) }}</span>
                        <span v-if="searchTitle" class="inline-block bg-purple-100 text-purple-800 px-2 py-1 rounded mr-2 dark:bg-purple-900 dark:text-purple-300">"{{ searchTitle }}"</span>
                    </div>
                </div>
                
                <!-- 归档列表：可滚动容器（隐藏滚动条） -->
                <div class="archive-list-scroll-container max-h-[70vh] overflow-y-auto pr-1">
                    <div v-if="archives.length > 0">
                        <div v-for="(archive, index) in archives" :key="index" :id="'archive-' + getMonthKey(archive.month)" class="theme-bg-secondary theme-text-primaryp mb-4 border border-gray-200 rounded-lg bg-white dark:bg-gray-800 dark:border-gray-700 scroll-mt-[80px]">
                        <time class="text-lg font-semibold">{{ archive.month }}</time>
                        <ol class="mt-3 divide-y divide-gray-200 dark:divide-gray-700">
                            <li v-for="(article, index2) in archive.articles" :key="index2">
                                <a @click="goArticleDetailPage(article.id)" class="items-center block p-3 sm:flex hover:bg-gray-400 hover:rounded-lg dark:hover:bg-gray-700">
                                    <img class="w-24 h-12 mb-3 mr-3 rounded-lg sm:mb-0"
                                        :src="article.cover"/>
                                    <div class="">
                                        <h2 class="text-base font-normal">{{ article.title }}</h2>
                                        <span class="theme-text-primary inline-flex items-center text-xs font-normal">
                                            <CalendarOutlined class="inline w-2.5 h-2.5 mr-2 text-gray-100" />
                                            {{ article.createDate }}
                                        </span>
                                    </div>
                                </a>
                            </li>
                        </ol>
                      </div>
                    </div>
                  <!-- 无数据状态 -->
                  <div v-else class="text-center py-12">
                        <div class="text-gray-400 dark:text-gray-500 text-6xl mb-4">📝</div>
                        <h3 class="text-lg font-medium text-gray-900 dark:text-white mb-2">暂无文章</h3>
                        <p class="text-gray-500 dark:text-gray-400">
                            <span v-if="hasActiveFilters">当前筛选条件下没有找到相关文章，请尝试调整筛选条件</span>
                            <span v-else>还没有发布任何文章</span>
                        </p>
                        <button v-if="hasActiveFilters" @click="resetFilters" 
                            class="mt-4 px-4 py-2 bg-blue-500 text-white rounded-md text-sm hover:bg-blue-600 transition-colors">
                            清除筛选条件
                        </button>
                  </div>
                </div>

                <!-- 分页 -->
                <nav aria-label="Page navigation example" class="mt-10 flex justify-center" v-if="pages > 1">
                    <ul class="flex items-center h-10 text-base [&>li:not(:first-child)]:ml-[-1px]">
                        <!-- 上一页 -->
                        <li>
                            <a @click="getArchives(current - 1)"
                                class="flex items-center justify-center px-4 h-10 ml-0 leading-tight text-gray-500 bg-white border border-gray-300 rounded-l-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                                :class="[current > 1 ? '' : 'cursor-not-allowed']"
                                >

                                <span class="sr-only">上一页</span>
                                <LeftOutlined class="w-3 h-3" />
                            </a>
                        </li>
                        <!-- 页码 -->
                        <li v-for="(pageNo, index) in pages" :key="index">
                            <a @click="getArchives(pageNo)"
                                class="flex items-center justify-center px-4 h-10 leading-tight border  dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                                :class="[pageNo == current ? 'text-blue-600  bg-blue-50 border-blue-300 hover:bg-blue-100 hover:text-blue-700' : 'text-gray-500 border-gray-300 bg-white hover:bg-gray-100 hover:text-gray-700']"
                                >
                                {{ index + 1 }}
                            </a>
                        </li>
                        <!-- 下一页 -->
                        <li>
                            <a @click="getArchives(current + 1)"
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

            <!-- 右边侧边栏，占用一列 -->
      <aside class="col-span-4 md:col-span-1 mt-[40px] mb-3">
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
        </div>

    </main>
</template>

<script setup lang="ts">
import UserInfoCard from '@/layouts/surfer/components/UserInfoCard.vue'
import TagListCard from '@/layouts/surfer/components/TagListCard.vue'
import CategoryListCard from '@/layouts/surfer/components/CategoryListCard.vue'
import WikiListCard from '@/layouts/surfer/components/WikiListCard.vue'
import { getArchivePageList, } from '@/api/surfer/archive.ts'
import { ref, computed, onMounted, nextTick, watch } from 'vue'
import { useRouter, useRoute, type Router } from 'vue-router'
import { useArchiveStore } from '@/stores/archive.ts'
import {
    CalendarOutlined,
    LeftOutlined,
    RightOutlined,
} from '@ant-design/icons-vue'

// 定义文章接口
interface Article {
    id: number
    title: string
    cover: string
    createDate: string
}

// 定义归档接口
interface Archive {
    month: string
    articles: Article[]
}

// 定义API响应接口
interface ApiResponse {
    success: boolean
    data: Archive[]
    current: number
    size: number
    total: number
    pages: number
}

const router: Router = useRouter()
const route = useRoute()
// 归档 Store：提供年份列表与年度数据
const archiveStore = useArchiveStore()

// 路由滚动只消费一次：首次按路由 year/month 进行滚动或回退筛选，随后不再重复触发
const routeScrollConsumed = ref<boolean>(false)

// 文章归档
const archives = ref<Archive[]>([])
// 当前页码
const current = ref<number>(1)
// 每页显示的文章数
const size = ref<number>(100)
// 总文章数
const total = ref<number>(0)
// 总共多少页
const pages = ref<number>(0)

// 筛选相关变量：默认从 Pinia 获取，并通过 v-model 改变时同步写回 Pinia
const selectedYear = computed<string>({
  get: () => archiveStore.selectedYear || '',
  set: (v: string) => { archiveStore.selectedYear = String(v || '') }
})
const selectedMonth = computed<string>({
  get: () => archiveStore.selectedMonth || '',
  set: (v: string) => { archiveStore.selectedMonth = String(v || '') }
})
const searchTitle = ref<string>('')
const searchTimeout = ref<number | null>(null)

// 可选年份列表（改为从 Pinia 获取）
const availableYears = computed<number[]>(() => archiveStore.archiveYears || [])

// 月份选项
const availableMonths = [
    { value: '01', label: '1月' },
    { value: '02', label: '2月' },
    { value: '03', label: '3月' },
    { value: '04', label: '4月' },
    { value: '05', label: '5月' },
    { value: '06', label: '6月' },
    { value: '07', label: '7月' },
    { value: '08', label: '8月' },
    { value: '09', label: '9月' },
    { value: '10', label: '10月' },
    { value: '11', label: '11月' },
    { value: '12', label: '12月' }
]

// 月份折叠状态（使用 YYYYMM 作为 key）
const collapsedMonths = ref<Set<string>>(new Set())

// 生成月份 Key（用于折叠与锚点定位）
const getMonthKey = (label: string): string => {
  const yearMatch = label.match(/(\d{4})/)
  // 兼容 1 位或 2 位月份
  const monthMatch = label.match(/(\d{1,2})(?=月|\-|\.|\/|\s|$)/)
  const y = yearMatch?.[1] || ''
  let m = monthMatch?.[1] || ''
  if (m.length === 1) m = '0' + m
  return `${y}${m}`
}

// 判断某月是否折叠
const isCollapsed = (label: string): boolean => collapsedMonths.value.has(getMonthKey(label))

// 切换折叠状态
const toggleMonthSection = (label: string): void => {
  const key = getMonthKey(label)
  if (collapsedMonths.value.has(key)) {
    collapsedMonths.value.delete(key)
  } else {
    collapsedMonths.value.add(key)
  }
}

// 根据年/月尝试滚动定位；若当前页不存在该月份，则回退为筛选
const tryScrollToMonth = (year: string, month: string): void => {
  if (!year || !month) return
  const key = `${year}${month}`
  const targetEl = document.getElementById('archive-' + key)
  if (targetEl) {
    targetEl.scrollIntoView({ behavior: 'smooth', block: 'start' })
  } else {
    // 当前页未包含该月份，使用筛选加载该月份
    selectedYear.value = year
    selectedMonth.value = month
    current.value = 1
    getArchives(current.value)
  }
}

function getArchives(currentNo: number): void {
    // 上下页是否能点击判断，当要跳转上一页且页码小于 1 时，则不允许跳转；当要跳转下一页且页码大于总页数时，则不允许跳转
    if (currentNo < 1 || (pages.value > 0 && currentNo > pages.value)) return
    
    // 构建查询参数
    const params: any = {
        current: currentNo, 
        size: size.value
    }
    
    // 添加筛选条件
    if (selectedYear.value) {
        params.year = selectedYear.value
    }
    if (selectedMonth.value) {
        params.month = selectedMonth.value
    }
    if (searchTitle.value.trim()) {
        params.title = searchTitle.value.trim()
    }
    
    // 调用分页接口渲染数据
    getArchivePageList(params).then((res: ApiResponse) => {
        if (res.success) {
            archives.value = res.data
            current.value = res.current
            size.value = res.size
            total.value = res.total
            pages.value = res.pages
            // 同步到 Pinia，方便其它组件及刷新后复用
            try {
              archiveStore.currentArchives = (res.data as any) || []
              archiveStore.pageCurrent = Number(res.current) || 1
              archiveStore.pageSize = Number(res.size) || size.value
              archiveStore.pageTotal = Number(res.total) || 0
              archiveStore.pagePages = Number(res.pages) || 0
            } catch (e) {
              console.warn('同步归档分页数据到 Pinia 失败：', e)
            }

            // 更新可用年份列表
            updateAvailableYears()

            // 若通过 Header 传入 year/month 并希望定位，尝试滚动（仅消费一次，随后清理 query 避免重复请求）
            const qYear = String(route.query.year || '')
            const qMonth = String(route.query.month || '')
            const needScroll = String(route.query.scroll || '') === '1' && !routeScrollConsumed.value
            if (needScroll && qYear && qMonth) {
              // 标记为已消费，避免后续重复触发
              routeScrollConsumed.value = true
              nextTick(() => tryScrollToMonth(qYear, qMonth))
              // 清理用于滚动的 query 参数，避免再次触发
              const newQuery: Record<string, any> = { ...route.query }
              delete newQuery.scroll
              delete newQuery.year
              delete newQuery.month
              router.replace({ path: route.path, query: newQuery })
            }
        }
    })
}

// 初始化：根据路由 query 判定是否需要筛选或滚动定位
onMounted(async () => {

  const qYear = String(route.query.year || '')
  const qMonth = String(route.query.month || '')
  const needScroll = String(route.query.scroll || '') === '1'

  // 从 Pinia 获取年份列表（持久化后刷新）
  await archiveStore.getArchiveYears()

  // 若 Pinia 未记录，则使用当前年与月作为默认选择
  if (!selectedYear.value) {
    selectedYear.value = String(new Date().getFullYear())
  }
  if (!selectedMonth.value) {
    const nowMonth = String(new Date().getMonth() + 1).padStart(2, '0')
    selectedMonth.value = nowMonth
  }

  // 若从归档菜单跳转并希望定位，则优先使用 Pinia 的选择；Pinia 为空时回退到路由参数
  if (needScroll) {
    const yearToUse = selectedYear.value || qYear
    const monthToUse = selectedMonth.value || qMonth
    const loaded = await renderFromStoreYear(yearToUse)
    if (loaded) {
      await nextTick()
      tryScrollToMonth(yearToUse, monthToUse)
      // 清理用于滚动的 query 参数，避免再次触发
      const newQuery: Record<string, any> = { ...route.query }
      delete newQuery.scroll
      delete newQuery.year
      delete newQuery.month
      router.replace({ path: route.path, query: newQuery })
      return
    }
  }

  // 常规渲染：按 Pinia 的年份加载；失败则回退到分页接口
  const loadedNormal = await renderFromStoreYear(selectedYear.value)
  if (!loadedNormal) {
    getArchives(current.value)
  }
})

// 监听store中selectedYear和selectedMonth的变化，当从Header组件选择年份或月份时自动更新数据
watch([() => archiveStore.selectedYear, () => archiveStore.selectedMonth], async ([newYear, newMonth], [oldYear, oldMonth]) => {
  // 只有当值真正发生变化时才重新加载数据
  if (newYear !== oldYear || newMonth !== oldMonth) {
    console.log('Store变化检测到:', { newYear, newMonth, oldYear, oldMonth })
    
    // 如果有选择的年份，尝试从store加载该年份的数据
    if (newYear) {
      const loaded = await renderFromStoreYear(newYear)
      if (!loaded) {
        // 如果store中没有数据，回退到API加载
        getArchives(current.value)
      }
    } else {
      // 如果没有选择年份，加载默认数据
      getArchives(current.value)
    }
  }
}, { immediate: false })

// 跳转文章详情页
const goArticleDetailPage = (articleId: number): void => {
    router.push('/surfer/article/' + articleId)
}

// 更新可用年份列表：改为调用 Pinia 的 action 以保持统一来源
const updateAvailableYears = async (): Promise<void> => {
    await archiveStore.getArchiveYears()
}

// 使用 Pinia 的当年归档数据进行渲染；成功返回 true
async function renderFromStoreYear(yearStr: string): Promise<boolean> {
  const y = Number(yearStr)
  if (!y || Number.isNaN(y)) return false
  // 读取/拉取该年的归档数据
  const data = await archiveStore.fetchYear(y)
  if (data && data.length > 0) {
    archives.value = data as any
    // 一次性展示该年所有月份，重置分页信息
    current.value = 1
    pages.value = 1
    size.value = 100
    total.value = data.reduce((sum, m) => sum + (m.articles?.length || 0), 0)
    // 同步到 Pinia，统一页面数据来源
    archiveStore.currentArchives = (data as any) || []
    archiveStore.pageCurrent = 1
    archiveStore.pageSize = 100
    archiveStore.pageTotal = total.value
    archiveStore.pagePages = 1
    return true
  }
  return false
}

// 计算是否有激活的筛选条件
const hasActiveFilters = computed(() => {
    return selectedYear.value || selectedMonth.value || searchTitle.value.trim()
})

// 获取月份标签
const getMonthLabel = (monthValue: string): string => {
    const month = availableMonths.find(m => m.value === monthValue)
    return month ? month.label : monthValue
}

// 年份筛选变化处理
const handleYearChange = (): void => {
    // current.value = 1 // 重置到第一页
    // getArchives(current.value)
    // 从 Pinia 获取当年归档数据
    renderFromStoreYear(selectedYear.value)
}

// 月份筛选变化处理
const handleMonthChange = (): void => {
    // current.value = 1 // 重置到第一页
    // getArchives(current.value)
    // 从 Pinia 获取当月归档数据
}

// 搜索防抖定时器
let searchTimer: NodeJS.Timeout | null = null

// 搜索
const handleSearchChange = (): void => {
    // 清除之前的定时器
    if (searchTimer) {
        clearTimeout(searchTimer)
    }
    
    // 设置新的防抖定时器
    searchTimer = setTimeout(() => {
        // 重置到第一页
        current.value = 1
        // 执行搜索
        getArchives(current.value)
    }, 300) // 300ms 防抖延迟
}

// 清除搜索
const clearSearch = (): void => {
    searchTitle.value = ''
    // 清除防抖定时器
    if (searchTimer) {
        clearTimeout(searchTimer)
    }
    // 重置到第一页并重新加载数据
    current.value = 1
    getArchives(current.value)
}

// 重置所有筛选条件
const resetFilters = (): void => {
    selectedYear.value = ''
    selectedMonth.value = ''
    searchTitle.value = ''
    current.value = 1
    getArchives(current.value)
}

// 提取月份标签中的月份数字（如 "2025-10" -> 10, "2024年10月" -> 10）
function getMonthNumber(label: string): number {
  // 处理 "YYYY-MM" 格式
  if (label.includes('-')) {
    const parts = label.split('-')
    return Number(parts[1] || '0')
  }
  // 处理 "YYYY年MM月" 格式
  const monthMatch = label.match(/(\d{1,2})(?=月)/)
  return Number(monthMatch?.[1] || '0')
}



// 提取字符串中的年份数字（如 '2025年' -> 2025），无效返回 0
function extractYearNum(input: string): number {
  const yStr = (input || '').match(/\d{4}/)?.[0] || ''
  const y = Number(yStr)
  return Number.isNaN(y) ? 0 : y
}

// 快速跳转到最新文章
const quickJumpToLatest = (): void => {
  // 直接对当前显示的数据进行排序
  if (!archives.value || archives.value.length === 0) {
    console.log('没有数据可排序')
    return
  }
  
  // 创建数据副本进行排序
  const sortedData = [...archives.value].sort((a, b) => {
    const monthA = getMonthNumber(a.month)
    const monthB = getMonthNumber(b.month)
    return monthB - monthA // 降序：大月份在前
  })
  
  // 对每个月内的文章也进行排序
  sortedData.forEach(monthData => {
    if (monthData.articles && monthData.articles.length > 0) {
      monthData.articles.sort((a, b) => {
        const timeA = new Date(a.createDate).getTime()
        const timeB = new Date(b.createDate).getTime()
        return timeB - timeA // 降序：最新文章在前
      })
    }
  })
  
  // 更新显示数据
  archives.value = sortedData
}

// 快速跳转到最早文章
const quickJumpToOldest = (): void => {
  // 直接对当前显示的数据进行排序
  if (!archives.value || archives.value.length === 0) {
    console.log('没有数据可排序')
    return
  }
  
  // 创建数据副本进行排序
  const sortedData = [...archives.value].sort((a, b) => {
    const monthA = getMonthNumber(a.month)
    const monthB = getMonthNumber(b.month)
    return monthA - monthB // 升序：小月份在前
  })
  
  // 对每个月内的文章也进行排序
  sortedData.forEach(monthData => {
    if (monthData.articles && monthData.articles.length > 0) {
      monthData.articles.sort((a, b) => {
        const timeA = new Date(a.createDate).getTime()
        const timeB = new Date(b.createDate).getTime()
        return timeA - timeB // 升序：最早文章在前
      })
    }
  })
  
  // 更新显示数据
  archives.value = sortedData
}
</script>

<style lang="scss" scoped>
/* 隐藏归档列表滚动容器的滚动条，同时保留滚动功能 */
.archive-list-scroll-container {
  scrollbar-width: none; /* Firefox */
  -ms-overflow-style: none; /* IE/Edge */
}
.archive-list-scroll-container::-webkit-scrollbar {
  width: 0;
  height: 0;
  display: none; /* Chrome/Safari */
}

</style>
