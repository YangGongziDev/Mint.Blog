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
  id: string;
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
    data: { id: string };
  }>;
}

export function updateTag(tagId: string, data: TagFormModel) {
  return axios.put(`/blog/admin/tag/${tagId}`, data) as Promise<{
    success: boolean;
    data: { id: string };
  }>;
}

export function updateTagSort(tagId: string, sort: number) {
  return axios.patch(`/blog/admin/tag/${tagId}/sort`, { tagId, sort }) as Promise<{
    success: boolean;
    data: { id: string; sort: number };
  }>;
}

export function moveTagSortFirst(tagId: string) {
  return axios.patch(`/blog/admin/tag/${tagId}/sort/first`) as Promise<{ success: boolean }>;
}

export function moveTagSortLast(tagId: string) {
  return axios.patch(`/blog/admin/tag/${tagId}/sort/last`) as Promise<{ success: boolean }>;
}

export function deleteTag(tagId: string, deleteType = 1) {
  return axios.delete(`/blog/admin/tag/${tagId}`, { data: { deleteType } }) as Promise<{
    success: boolean;
    data: { id: string };
  }>;
}
