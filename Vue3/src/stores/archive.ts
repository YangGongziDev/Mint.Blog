import { defineStore } from 'pinia'
import { getArchiveYearList, getArchiveYears } from '@/api/surfer/archive.ts'

interface Article {
  id: number
  title: string
  cover: string
  createDate: string
}

interface ArchiveItem {
  month: string
  articles: Article[]
}

interface YearResponse {
  success: boolean
  data: ArchiveItem[]
}

// 将月份标签转为 YYYYMM key，便于合并与排序
const getMonthKey = (label: string): string => {
  const yearMatch = label.match(/(\d{4})/)
  const monthMatch = label.match(/(\d{1,2})(?=月|\-|\.|\/|\s|$)/)
  const y = yearMatch?.[1] || ''
  let m = monthMatch?.[1] || ''
  if (m.length === 1) m = '0' + m
  return `${y}${m}`
}

export const useArchiveStore = defineStore('archive', {
  state: () => ({
    // 年份归档缓存：year -> ArchiveItem[]（已按月份合并）
    yearArchives: {} as Record<number, ArchiveItem[]>,
    // 可选年份列表（供下拉菜单使用）
    archiveYears: [] as number[],
    // 加载状态：year -> boolean
    loadingYears: {} as Record<number, boolean>,
    // 错误状态：year -> string | undefined
    errorYears: {} as Record<number, string | undefined>,
    // 最近一次获取的时间戳：year -> number
    fetchedAt: {} as Record<number, number>,
    // 当前选中的筛选项（通过 Pinia 在各处共享）
    selectedYear: '' as string,
    selectedMonth: '' as string,
    // 当前页面显示的归档数据（分页或年度渲染后同步到此，方便其他组件复用）
    currentArchives: [] as ArchiveItem[],
    // 当前分页元信息（分页或年度模式下的统一元数据）
    pageCurrent: 1,
    pageSize: 100,
    pageTotal: 0,
    pagePages: 0,
  }),
  getters: {
    getYear: (state) => (year: number): ArchiveItem[] | undefined => state.yearArchives[year],
    isLoading: (state) => (year: number): boolean => !!state.loadingYears[year],
    getError: (state) => (year: number): string | undefined => state.errorYears[year],
  },
  actions: {
    // 获取所有可选年份列表，并持久化到 Pinia
    async getArchiveYears(): Promise<number[]> {
      try {
        const res: any = await getArchiveYears()
        if (!res || !res.success) throw new Error('加载年份失败')
        const yearsRaw: any[] = res.data || []
        // 统一转为 number 并倒序（最新在前）
        const years = (yearsRaw || [])
          .map((y) => Number(y))
          .filter((y) => !Number.isNaN(y))
          .sort((a, b) => b - a)
        // 若后端为空，至少提供当前年份
        if (years.length === 0) {
          years.push(new Date().getFullYear())
        }
        this.archiveYears = years
        return years
      } catch (e) {
        console.warn('获取归档年份失败：', e)
        // 失败时至少保留当前年份
        const fallback = [new Date().getFullYear()]
        this.archiveYears = fallback
        return fallback
      }
    },
    async fetchYear(year: number, opts?: { force?: boolean }): Promise<ArchiveItem[] | undefined> {
      if (!opts?.force && this.yearArchives[year]) {
        return this.yearArchives[year]
      }
      if (this.loadingYears[year]) return this.yearArchives[year]
      this.loadingYears[year] = true
      this.errorYears[year] = undefined
      try {
        const res: YearResponse | undefined = await getArchiveYearList(String(year))
        if (!res || !res.success) throw new Error('加载失败')
        const list = (res.data || [])
        // 按月份倒序排序（YYYYMM 数值降序）
        const merged = [...list].sort((a, b) => Number(getMonthKey(b.month)) - Number(getMonthKey(a.month)))

        this.yearArchives[year] = merged
        this.fetchedAt[year] = Date.now()
        return merged
      } catch (e: any) {
        this.errorYears[year] = e?.message || String(e)
        return undefined
      } finally {
        this.loadingYears[year] = false
      }
    },
    clearYear(year: number): void {
      delete this.yearArchives[year]
      delete this.loadingYears[year]
      delete this.errorYears[year]
      delete this.fetchedAt[year]
    },
    clearAll(): void {
      this.yearArchives = {}
      this.loadingYears = {}
      this.errorYears = {}
      this.fetchedAt = {}
      this.selectedYear = ''
      this.selectedMonth = ''
    },
    setSelectedYear(year: string): void {
      this.selectedYear = year || ''
    },
    setSelectedMonth(month: string): void {
      this.selectedMonth = month || ''
    },
    clearSelection(): void {
      this.selectedYear = ''
      this.selectedMonth = ''
    }
  }
}, {
  // 开启持久化（使用 pinia-plugin-persistedstate）
  // 如需仅持久化部分字段，可改为：paths: ['selectedYear','selectedMonth','yearArchives','fetchedAt']
  persist: true,
})