import type { SelectionView } from '~/composables/usePublicContent'

export function columnReadingId(value: unknown): string | undefined {
  if (typeof value !== 'string' || !/^\d+$/.test(value) || value.length > 19) return undefined
  const id = BigInt(value)
  return id > 0n && id <= 9223372036854775807n ? id.toString() : undefined
}

export interface ColumnReadingArticle extends SelectionView {
  id: string; title: string; summary: string; content: string; createTime: string; updateTime: string
  readNum: string; totalWords: number; readTime: string
}

export interface ColumnReadingLink { articleId: string; articleTitle: string }
export interface ColumnReadingNeighbors { preArticle?: ColumnReadingLink; nextArticle?: ColumnReadingLink }
