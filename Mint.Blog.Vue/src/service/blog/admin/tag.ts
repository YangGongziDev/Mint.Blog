import axios from '../../axios';

interface PageResult<T> {
  items?: T[];
  records?: T[];
  totalCount?: number;
  total?: number;
  pageNumber: number;
  pageSize: number;
}

export interface TagListItem {
  id: number;
  name: string;
  articlesTotal: number;
  createTime?: string;
  createdAt?: string;
  sort?: number | null;
  isDeleted?: boolean | number;
}

export interface TagFormModel {
  name: string;
}

export interface TagPageQuery {
  pageNumber: number;
  pageSize: number;
  keyword?: string;
  name?: string;
  startDate?: string;
  endDate?: string;
}

export function getTagList() {
  return axios.get('/blog/admin/tag') as Promise<{
    success: boolean;
    data: TagListItem[];
  }>;
}

export function getTagPageList(params: TagPageQuery) {
  return axios.get('/blog/admin/tag/page', { params }) as Promise<{
    success: boolean;
    data: PageResult<TagListItem>;
  }>;
}

export function createTag(data: TagFormModel) {
  return axios.post('/blog/admin/tag', data) as Promise<{
    success: boolean;
    data: { id: number };
  }>;
}

export function updateTag(tagId: number, data: TagFormModel) {
  return axios.put(`/blog/admin/tag/${tagId}`, data) as Promise<{
    success: boolean;
    data: { id: number };
  }>;
}

export function updateTagSort(tagId: number, sort: number) {
  return axios.patch(`/blog/admin/tag/${tagId}/sort`, { tagId, sort }) as Promise<{
    success: boolean;
    data: { id: number; sort: number };
  }>;
}

export function moveTagSortFirst(tagId: number) {
  return axios.patch(`/blog/admin/tag/${tagId}/sort/first`) as Promise<{ success: boolean }>;
}

export function moveTagSortLast(tagId: number) {
  return axios.patch(`/blog/admin/tag/${tagId}/sort/last`) as Promise<{ success: boolean }>;
}

export function deleteTag(tagId: number, deleteType = 1) {
  return axios.delete(`/blog/admin/tag/${tagId}`, { data: { tagId, deleteType } }) as Promise<{
    success: boolean;
    data: { id: number };
  }>;
}
