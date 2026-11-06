import type { TimeSortOrder } from '@/utils/date-time';
import axios from '../axios';

interface PageResult<T> { items?: T[]; records?: T[]; totalCount?: number; total?: number; pageNumber: number; pageSize: number }
export interface TagListItem {
  id: string;
  name: string;
  categoryId: string;
  categoryName: string;
  logoUrl: string;
  showInNavigation: boolean;
  navigationDescription: string;
  versionCount: number;
  articlesTotal: number;
  createTime?: string;
  createdAt?: string;
  sort?: string | null;
  isDeleted?: boolean | number;
}
export interface TagFormModel { name: string; categoryId: string; logoUrl?: string | null }
export interface TagPageQuery { pageNumber: number; pageSize: number; keyword?: string; name?: string; startDate?: string; endDate?: string; sortOrder?: TimeSortOrder }
export function getTagList() { return axios.get('/admin/tag') as Promise<{ success: boolean; data: TagListItem[] }>; }
export function getTagPageList(params: TagPageQuery) { return axios.get('/admin/tag/page', { params }) as Promise<{ success: boolean; data: PageResult<TagListItem> }>; }
export function createTag(data: TagFormModel) { return axios.post('/admin/tag', data) as Promise<{ success: boolean; data: { id: string } }>; }
export function updateTag(tagId: string, data: TagFormModel) { return axios.put(`/admin/tag/${tagId}`, data) as Promise<{ success: boolean; data: { id: string } }>; }
export function updateTagSort(tagId: string, sort: string, move?: 'up' | 'down' | 'first' | 'last') { return axios.patch(`/admin/tag/${tagId}/sort`, { tagId, sort, move }) as Promise<{ success: boolean; data: { id: string; sort: string } }>; }
export function moveTagSortFirst(tagId: string) { return axios.patch(`/admin/tag/${tagId}/sort/first`) as Promise<{ success: boolean }>; }
export function moveTagSortLast(tagId: string) { return axios.patch(`/admin/tag/${tagId}/sort/last`) as Promise<{ success: boolean }>; }
export function deleteTag(tagId: string, deleteType: 1 | 3 = 1) { return axios.delete(`/admin/tag/${tagId}`, { data: { deleteType } }) as Promise<{ success: boolean; data: { id: string } }>; }
