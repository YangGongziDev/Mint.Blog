import type { TimeSortOrder } from '@/utils/date-time';
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
  sortOrder?: TimeSortOrder;
}

export interface AdminColumnPageItem {
  id: string;
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
  columnId: string;
  deleteType: number;
}

export interface ColumnFormModel {
  title: string;
  summary: string;
  cover: string;
}

export interface AdminColumnCatalogItem {
  id: string;
  articleId: string;
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

export function getColumnCatalog(columnId: string) {
  return axios.get(`/blog/admin/column/${columnId}/catalog`) as Promise<{
    success: boolean;
    data: AdminColumnCatalogItem[];
  }>;
}

export function createColumn(data: ColumnFormModel) {
  return axios.post('/blog/admin/column', data) as Promise<{ success: boolean; data: { id: string } }>;
}

export function updateColumn(columnId: string, data: ColumnFormModel) {
  return axios.put(`/blog/admin/column/${columnId}`, data) as Promise<{ success: boolean; data: { id: string } }>;
}

export function setColumnPublish(columnId: string, isPublish: boolean) {
  return axios.patch(`/blog/admin/column/${columnId}/publish`, { columnId, isPublish }) as Promise<{
    success: boolean;
  }>;
}

export function setColumnTop(columnId: string, isTop: boolean) {
  return axios.patch(`/blog/admin/column/${columnId}/top`, { columnId, isTop }) as Promise<{
    success: boolean;
  }>;
}

export function updateColumnSort(columnId: string, sort: number) {
  return axios.patch(`/blog/admin/column/${columnId}/sort`, { columnId, sort }) as Promise<{
    success: boolean;
  }>;
}

export function updateColumnCatalog(columnId: string, data: UpdateColumnCatalogPayload) {
  return axios.put(`/blog/admin/column/${columnId}/catalog`, { columnId, ...data }) as Promise<{
    success: boolean;
  }>;
}

export function deleteColumn(columnId: string, deleteType = 1) {
  return axios.delete(`/blog/admin/column/${columnId}`, { data: { deleteType } }) as Promise<{ success: boolean }>;
}
