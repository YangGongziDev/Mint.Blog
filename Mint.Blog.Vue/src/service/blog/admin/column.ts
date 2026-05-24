import axios from '../../axios';

interface PageResult<T> {
  items?: T[];
  records?: T[];
  totalCount?: number;
  total?: number;
  pageNumber: number;
  pageSize: number;
}

export interface AdminColumnPageQuery {
  pageNumber: number;
  pageSize: number;
  title?: string;
  startDate?: string;
  endDate?: string;
}

export interface AdminColumnPageItem {
  id: number;
  title: string;
  cover: string;
  summary: string;
  sort: number;
  weight: number;
  createdAt: string;
  articlesTotal: number;
  isTop: boolean;
  isPublish: boolean;
  isDeleted?: boolean | number;
}

export interface DeleteColumnPayload {
  columnId: number;
  deleteType: number;
}

export interface ColumnFormModel {
  title: string;
  summary: string;
  cover: string;
}

export interface AdminColumnCatalogItem {
  id: number;
  articleId: number;
  title: string;
  sort: number;
  level: number;
  isDeleted: boolean;
  editing: boolean;
  children: AdminColumnCatalogItem[];
}

export interface UpdateColumnCatalogPayload {
  catalogs: AdminColumnCatalogItem[];
}

export function getColumnPageList(params: AdminColumnPageQuery) {
  return axios.get('/blog/admin/column', { params }) as Promise<{
    success: boolean;
    data: PageResult<AdminColumnPageItem>;
  }>;
}

export function getColumnCatalog(columnId: number) {
  return axios.get(`/blog/admin/column/${columnId}/catalog`) as Promise<{
    success: boolean;
    data: AdminColumnCatalogItem[];
  }>;
}

export function createColumn(data: ColumnFormModel) {
  return axios.post('/blog/admin/column', data) as Promise<{ success: boolean; data: { id: number } }>;
}

export function updateColumn(columnId: number, data: ColumnFormModel) {
  return axios.put(`/blog/admin/column/${columnId}`, data) as Promise<{ success: boolean; data: { id: number } }>;
}

export function setColumnPublish(columnId: number, isPublish: boolean) {
  return axios.patch(`/blog/admin/column/${columnId}/publish`, { columnId: columnId, isPublish }) as Promise<{ success: boolean }>;
}

export function setColumnTop(columnId: number, isTop: boolean) {
  return axios.patch(`/blog/admin/column/${columnId}/top`, { columnId: columnId, isTop }) as Promise<{ success: boolean }>;
}

export function updateColumnSort(columnId: number, sort: number) {
  return axios.patch(`/blog/admin/column/${columnId}/sort`, { columnId: columnId, sort }) as Promise<{ success: boolean }>;
}

export function updateColumnCatalog(columnId: number, data: UpdateColumnCatalogPayload) {
  return axios.put(`/blog/admin/column/${columnId}/catalog`, { columnId: columnId, ...data }) as Promise<{ success: boolean }>;
}

export function deleteColumn(columnId: number, deleteType = 1) {
  return axios.delete(`/blog/admin/column/${columnId}`, { data: { columnId, deleteType } }) as Promise<{ success: boolean }>;
}
