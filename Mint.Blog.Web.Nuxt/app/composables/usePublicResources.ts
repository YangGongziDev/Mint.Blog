import type { SelectionView } from './usePublicContent'

export interface NavigationCategory {
  id: string
  name: string
}

export interface NavigationTag {
  id: string
  name: string
  logoUrl?: string | null
  showInNavigation: boolean
  categoryId: string
  categoryName: string
  navigationDescription: string
  versionCount: string
  resourceCount: string
}

export interface TagVersion {
  id: string
  tagId: string
  name: string
  sort: string
  isGeneral: boolean
}

export type ResourceKind = 1 | 2 | 3 | 4

export interface PublicResource extends SelectionView {
  id: string
  title: string
  description: string
  url: string
  kind: ResourceKind
  isFeatured: boolean
  sort: string
}

export interface NavigationArticleQuery {
  tagId: string
  tagVersionId: string
  keyword?: string
  pageNumber: number
  pageSize: number
}

export interface ResourcePageQuery extends NavigationArticleQuery {
  kind?: ResourceKind
}

export interface ResourcePage {
  items: PublicResource[]
  pageNumber: number
  pageSize: number
  totalCount: number
}

export interface NavigationArticle extends SelectionView {
  id: string
  title: string
  summary: string
  cover: string
  createTime: string
}

export interface NavigationArticlePage {
  items: NavigationArticle[]
  pageNumber: number
  pageSize: number
  totalCount: number
}

export function isPublicSelectionId(value: unknown): value is string {
  return typeof value === 'string' && /^[1-9]\d{0,18}$/.test(value) && BigInt(value) <= 9223372036854775807n
}

export function usePublicResources() {
  const api = usePublicApi()
  async function get<T>(path: string, query: Record<string, string | number> = {}) {
    const result = await api<{ success: boolean; data: T | null }>(path, { query })
    if (!result.success || result.data === null) throw new Error('资源导航加载失败')
    return result.data
  }
  function selection(query: NavigationArticleQuery) {
    if (!isPublicSelectionId(query.tagId) || !isPublicSelectionId(query.tagVersionId)) throw new Error('请选择有效标签与版本')
    return {
      tagId: query.tagId, tagVersionId: query.tagVersionId,
      pageNumber: query.pageNumber, pageSize: query.pageSize,
      ...(query.keyword ? { keyword: query.keyword } : {})
    }
  }
  return {
    getCategories: () => get<NavigationCategory[]>('category'),
    getNavigationTags: (query: { categoryId?: string; keyword?: string }) => get<NavigationTag[]>('navigation-tags', {
      ...(query.categoryId ? { categoryId: query.categoryId } : {}),
      ...(query.keyword ? { keyword: query.keyword } : {})
    }),
    getVersions: async (tagId: string) => {
      if (!isPublicSelectionId(tagId)) throw new Error('标签参数无效')
      const items = await get<TagVersion[]>(`tags/${tagId}/versions`)
      if (items.some(item => item.tagId !== tagId || !isPublicSelectionId(item.id)) || new Set(items.map(item => item.id)).size !== items.length || items.filter(item => item.isGeneral === true).length !== 1) {
        throw new Error('标签版本数据异常：必须存在唯一有效通用版本，请重试或联系管理员修复。')
      }
      return items
    },
    getArticles: (query: NavigationArticleQuery) => get<NavigationArticlePage>(`tags/${query.tagId}/articles`, selection(query)),
    getResources: (query: ResourcePageQuery) => get<ResourcePage>('resources', {
      ...selection(query), ...(query.kind ? { kind: query.kind } : {})
    })
  }
}
