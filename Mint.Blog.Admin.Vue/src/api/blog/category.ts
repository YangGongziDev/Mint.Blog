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

export interface CategoryListItem {
  id: string;
  name: string;
  articlesTotal: number;
  createTime?: string;
  createdAt?: string;
  sort?: string | null;
  isDeleted?: boolean | number;
}

export interface CategoryFormModel { name: string }
export interface CategoryPageQuery {
  pageNumber: number;
  pageSize: number;
  keyword?: string;
  name?: string;
  startDate?: string;
  endDate?: string;
  sortOrder?: TimeSortOrder;
}
export function getCategoryList() {
  return axios.get('/admin/category') as Promise<{ success: boolean; data: CategoryListItem[] }>;
}
export function getCategoryPageList(params: CategoryPageQuery) {
  return axios.get('/admin/category/page', { params }) as Promise<{ success: boolean; data: PageResult<CategoryListItem> }>;
}
export function createCategory(data: CategoryFormModel) {
  return axios.post('/admin/category', data) as Promise<{ success: boolean; data: { id: string } }>;
}
export function updateCategory(categoryId: string, data: CategoryFormModel) {
  return axios.put(`/admin/category/${categoryId}`, data) as Promise<{ success: boolean; data: { id: string } }>;
}
export function updateCategorySort(categoryId: string, sort: string) {
  return axios.patch(`/admin/category/${categoryId}/sort`, { categoryId, sort }) as Promise<{ success: boolean; data: { id: string; sort: string } }>;
}
export function moveCategorySortFirst(categoryId: string) {
  return axios.patch(`/admin/category/${categoryId}/sort/first`) as Promise<{ success: boolean }>;
}
export function moveCategorySortLast(categoryId: string) {
  return axios.patch(`/admin/category/${categoryId}/sort/last`) as Promise<{ success: boolean }>;
}
export function deleteCategory(categoryId: string, deleteType = 1) {
  return axios.delete(`/admin/category/${categoryId}`, { data: { deleteType } }) as Promise<{ success: boolean; data: { id: string } }>;
}
