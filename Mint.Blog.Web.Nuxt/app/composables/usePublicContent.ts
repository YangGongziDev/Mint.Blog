export interface SelectionView {
  tagId: string
  tagVersionId: string
  categoryId: string
  categoryName: string
  tagName: string
  tagVersionName: string
  isGeneral: boolean
}

export interface PublicArticle extends SelectionView {
  id: string
  title: string
  summary: string
  cover: string
  createDate: string
  isTop: boolean
  readNum: string
}

export interface PublicArticlePage {
  success: boolean
  data: PublicArticle[]
  current: number
  size: number
  total: number
  pages: number
}

export interface PublicStatistics {
  articleTotalCount: string
  categoryTotalCount: string
  tagTotalCount: string
  columnTotalCount: string
  pvTotalCount: string
}

export function usePublicStatistics() {
  const api = usePublicApi()
  return useAsyncData('public-statistics', async () => {
    const result = await api<{ success: boolean; data: PublicStatistics }>('statistics')
    if (!result.success || !result.data) throw new Error('Public statistics unavailable')
    return result.data
  })
}
