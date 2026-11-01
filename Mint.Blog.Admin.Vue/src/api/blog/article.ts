import type { TimeSortOrder } from '@/utils/date-time';
import axios from '../axios';

interface PageResult<T> {
  items?: T[];
  records?: T[];
  totalCount?: number;
  total?: number;
  pageNumber: number;
  pageSize: number;
}
interface ArticlePageResult<T> { items: T[]; pageNumber: number; pageSize: number; totalCount: number }
export interface ArticleSelection { tagId: string; tagVersionId: string }
export type DraftSelection = ArticleSelection | { tagId: null; tagVersionId: null };
export interface SelectionView extends ArticleSelection {
  categoryId: string;
  categoryName: string;
  tagName: string;
  tagVersionName: string;
  isGeneral: boolean;
}
export interface AdminArticleListItem extends SelectionView {
  id: string;
  title: string;
  summary: string;
  cover: string;
  isTop: boolean;
  visibility: 1 | 2;
  isDeleted?: boolean | number;
  readCount: string;
  createTime?: string;
  createdAt: string;
}
export interface AdminArticleDetail extends AdminArticleListItem { content: string; updatedAt: string }
export interface ArticleFormModel {
  title: string;
  summary: string;
  content: string;
  cover: string;
  tagId: string | null;
  tagVersionId: string | null;
  visibility: 1 | 2;
}
export interface ArticleDraftDetail extends ArticleFormModel {
  id: string;
  articleId?: string | null;
  categoryId: string | null;
  categoryName: string;
  tagName: string;
  tagVersionName: string;
  isGeneral: boolean;
  createdAt: string;
  updatedAt: string;
}
export interface ArticleDraftListItem extends Omit<ArticleDraftDetail, 'content' | 'visibility'> { isNewArticleDraft: boolean }
export type SaveArticleDraftPayload = Omit<ArticleFormModel, 'tagId' | 'tagVersionId'> & DraftSelection & {
  draftId?: string | null;
  articleId?: string | null;
};
export interface ArticlePageQuery {
  pageNumber: number;
  pageSize: number;
  categoryId?: string;
  tagId?: string;
  tagVersionId?: string;
  title?: string;
  startDate?: string;
  endDate?: string;
  sortOrder?: TimeSortOrder;
}
export function getArticlePageList(params: ArticlePageQuery) {
  return axios.get('/admin/articles', { params }) as Promise<{ success: boolean; data: ArticlePageResult<AdminArticleListItem> }>;
}
export function getArticleDetail(articleId: string) {
  return axios.get(`/admin/articles/${articleId}`) as Promise<{ success: boolean; data: AdminArticleDetail }>;
}
export function createArticle(data: ArticleFormModel & ArticleSelection) {
  return axios.post('/admin/articles', data) as Promise<{ success: boolean; data: { id: string } }>;
}
export function updateArticle(articleId: string, data: ArticleFormModel & ArticleSelection) {
  return axios.put(`/admin/articles/${articleId}`, data) as Promise<{ success: boolean; data: { id: string } }>;
}
export function setArticleTop(articleId: string, isTop: boolean) {
  return axios.patch(`/admin/articles/${articleId}`, { isTop }) as Promise<{ success: boolean }>;
}
export function setArticleVisibility(articleId: string, visibility: 1 | 2) {
  return axios.patch(`/admin/articles/${articleId}`, { visibility }) as Promise<{ success: boolean }>;
}
export function deleteArticle(articleId: string, deleteType: number) {
  return axios.delete(`/admin/articles/${articleId}`, { params: { deleteType } }) as Promise<{ success: boolean }>;
}
export function getArticleDraftPageList(params: { pageNumber: number; pageSize: number }) {
  return axios.get('/admin/article-draft', { params }) as Promise<{ success: boolean; data: PageResult<ArticleDraftListItem> }>;
}
export function getArticleDraftDetail(draftId: string) {
  return axios.get(`/admin/article-draft/${draftId}`) as Promise<{ success: boolean; data: ArticleDraftDetail }>;
}
export function getArticleDraftByArticleId(articleId: string) {
  return axios.get(`/admin/article-draft/by-article/${articleId}`) as Promise<{ success: boolean; data: ArticleDraftDetail | null }>;
}
export function saveArticleDraft(data: SaveArticleDraftPayload) {
  return axios.post('/admin/article-draft', data) as Promise<{ success: boolean; data: { id: string } }>;
}
export function publishArticleDraft(draftId: string) {
  return axios.post(`/admin/article-draft/${draftId}/publish`) as Promise<{ success: boolean; data: { id: string } }>;
}
export function deleteArticleDraft(draftId: string) {
  return axios.delete(`/admin/article-draft/${draftId}`) as Promise<{ success: boolean }>;
}
