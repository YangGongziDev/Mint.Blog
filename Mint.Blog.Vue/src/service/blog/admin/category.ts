import axios from '../../axios';

interface PageResult<T> {
  items?: T[];
  records?: T[];
  totalCount?: number;
  total?: number;
  pageNumber: number;
  pageSize: number;
}

export interface CategoryListItem {
  id: number;
  name: string;
  articlesTotal: number;
  createTime?: string;
  createdAt?: string;
  sort?: number | null;
  isDeleted?: boolean | number;
}

export interface CategoryFormModel {
  name: string;
}

export interface CategoryPageQuery {
  pageNumber: number;
  pageSize: number;
  keyword?: string;
  name?: string;
  startDate?: string;
  endDate?: string;
}

export function getCategoryList() {
  return axios.get('/blog/admin/category') as Promise<{
    success: boolean;
    data: CategoryListItem[];
  }>;
}

export function getCategoryPageList(params: CategoryPageQuery) {
  return axios.get('/blog/admin/category/page', { params }) as Promise<{
    success: boolean;
    data: PageResult<CategoryListItem>;
  }>;
}

export function createCategory(data: CategoryFormModel) {
  return axios.post('/blog/admin/category', data) as Promise<{
    success: boolean;
    data: { id: number };
  }>;
}

export function updateCategory(categoryId: number, data: CategoryFormModel) {
  return axios.put(`/blog/admin/category/${categoryId}`, data) as Promise<{
    success: boolean;
    data: { id: number };
  }>;
}

export function updateCategorySort(categoryId: number, sort: number) {
  return axios.patch(`/blog/admin/category/${categoryId}/sort`, { categoryId, sort }) as Promise<{
    success: boolean;
    data: { id: number; sort: number };
  }>;
}

export function moveCategorySortFirst(categoryId: number) {
  return axios.patch(`/blog/admin/category/${categoryId}/sort/first`) as Promise<{ success: boolean }>;
}

export function moveCategorySortLast(categoryId: number) {
  return axios.patch(`/blog/admin/category/${categoryId}/sort/last`) as Promise<{ success: boolean }>;
}

export function deleteCategory(categoryId: number, deleteType = 1) {
  return axios.delete(`/blog/admin/category/${categoryId}`, { data: { categoryId, deleteType } }) as Promise<{
    success: boolean;
    data: { id: number };
  }>;
}
