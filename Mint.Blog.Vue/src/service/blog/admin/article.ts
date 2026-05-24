import axios from '../../axios';

interface PageResult<T> {
  items?: T[];
  records?: T[];
  totalCount?: number;
  total?: number;
  pageNumber: number;
  pageSize: number;
}

export interface ArticleTagItem {
  id: number;
  name: string;
}

export interface AdminArticleListItem {
  id: string;
  title: string;
  summary: string;
  cover: string;
  categoryId: number;
  categoryName: string;
  tags: ArticleTagItem[];
  isTop: boolean;
  isDeleted?: boolean | number;
  readCount: number;
  createTime?: string;
  createdAt: string;
}

export interface AdminArticleDetail extends AdminArticleListItem {
  content: string;
  updatedAt: string;
}

export interface ArticleFormModel {
  title: string;
  summary: string;
  content: string;
  cover: string;
  categoryId?: number;
  tagIds: number[];
}

export interface ArticleDraftDetail {
  id: string;
  articleId?: string | null;
  title: string;
  summary: string;
  content: string;
  cover: string;
  categoryId?: number | null;
  tagIds: number[];
  createdAt: string;
  updatedAt: string;
}

export interface ArticleDraftListItem {
  id: string;
  articleId?: string | null;
  title: string;
  summary: string;
  cover: string;
  categoryId?: number | null;
  categoryName: string;
  isNewArticleDraft: boolean;
  createdAt: string;
  updatedAt: string;
}

export interface SaveArticleDraftPayload extends Omit<ArticleFormModel, 'categoryId'> {
  draftId?: string | null;
  articleId?: string | null;
  categoryId?: number | null;
}

export interface ArticlePageQuery {
  pageNumber: number;
  pageSize: number;
  categoryId?: number;
  tagId?: number;
  title?: string;
  startDate?: string;
  endDate?: string;
}

export function getArticlePageList(params: ArticlePageQuery) {
  return axios.get('/blog/admin/article', { params }) as Promise<{
    success: boolean;
    data: PageResult<AdminArticleListItem>;
  }>;
}

export function getArticleDetail(articleId: string) {
  return axios.get(`/blog/admin/article/${articleId}`) as Promise<{
    success: boolean;
    data: AdminArticleDetail;
  }>;
}

export function createArticle(data: ArticleFormModel) {
  return axios.post('/blog/admin/article', data) as Promise<{ success: boolean; data: { id: string } }>;
}

export function updateArticle(articleId: string, data: ArticleFormModel) {
  return axios.put(`/blog/admin/article/${articleId}`, data) as Promise<{ success: boolean; data: { id: string } }>;
}

export function setArticleTop(articleId: string, isTop: boolean) {
  return axios.patch(`/blog/admin/article/${articleId}/top`, { articleId, isTop }) as Promise<{ success: boolean }>;
}

export function deleteArticle(articleId: string, deleteType: number) {
  return axios.delete(`/blog/admin/article/${articleId}`, {
    data: { articleId, deleteType }
  }) as Promise<{ success: boolean }>;
}

export function getArticleDraftPageList(params: { pageNumber: number; pageSize: number }) {
  return axios.get('/blog/admin/article-draft', { params }) as Promise<{
    success: boolean;
    data: PageResult<ArticleDraftListItem>;
  }>;
}

export function getArticleDraftDetail(draftId: string) {
  return axios.get(`/blog/admin/article-draft/${draftId}`) as Promise<{ success: boolean; data: ArticleDraftDetail }>;
}

export function getArticleDraftByArticleId(articleId: string) {
  return axios.get(`/blog/admin/article-draft/by-article/${articleId}`) as Promise<{
    success: boolean;
    data: ArticleDraftDetail | null;
  }>;
}

export function saveArticleDraft(data: SaveArticleDraftPayload) {
  return axios.post('/blog/admin/article-draft', data) as Promise<{ success: boolean; data: { id: string } }>;
}

export function publishArticleDraft(draftId: string) {
  return axios.post(`/blog/admin/article-draft/${draftId}/publish`) as Promise<{ success: boolean; data: { id: string } }>;
}

export function deleteArticleDraft(draftId: string) {
  return axios.delete(`/blog/admin/article-draft/${draftId}`) as Promise<{ success: boolean }>;
}
