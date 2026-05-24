import axios from '../../axios';

interface PageResult<T> {
  items?: T[];
  records?: T[];
  totalCount?: number;
  total?: number;
  pageNumber: number;
  pageSize: number;
}

export interface AdminFriendPageQuery {
  pageNumber: number;
  pageSize: number;
  name?: string;
  startDate?: string;
  endDate?: string;
}

export interface AdminFriendPageItem {
  id: number;
  name: string;
  description: string;
  url: string;
  avatar: string;
  status: string;
  createdAt: string;
  category: string;
  isTop: boolean;
  email?: string | null;
  sort: number;
  isDeleted: boolean;
  updatedAt: string;
}

export interface FriendFormModel {
  name: string;
  avatar: string;
  category: string;
  url: string;
  description: string;
  email?: string;
}

export function getFriendPageList(params: AdminFriendPageQuery) {
  return axios.get('/blog/admin/friend', { params }) as Promise<{
    success: boolean;
    data: PageResult<AdminFriendPageItem>;
  }>;
}

export function createFriend(data: FriendFormModel) {
  return axios.post('/blog/admin/friend', data) as Promise<{ success: boolean; data: { id: number } }>;
}

export function updateFriend(friendId: number, data: FriendFormModel) {
  return axios.put(`/blog/admin/friend/${friendId}`, data) as Promise<{ success: boolean; data: { id: number } }>;
}

export function setFriendTop(friendId: number, isTop: boolean) {
  return axios.patch(`/blog/admin/friend/${friendId}/top`, { friendId, isTop }) as Promise<{ success: boolean }>;
}

export function setFriendStatus(friendId: number, status: string) {
  return axios.patch(`/blog/admin/friend/${friendId}/status`, { friendId, status }) as Promise<{ success: boolean }>;
}

export function updateFriendSort(friendId: number, sort: number) {
  return axios.patch(`/blog/admin/friend/${friendId}/sort`, { friendId, sort }) as Promise<{
    success: boolean;
    data: { id: number; sort: number };
  }>;
}

export function moveFriendSortFirst(friendId: number) {
  return axios.patch(`/blog/admin/friend/${friendId}/sort/first`) as Promise<{ success: boolean }>;
}

export function moveFriendSortLast(friendId: number) {
  return axios.patch(`/blog/admin/friend/${friendId}/sort/last`) as Promise<{ success: boolean }>;
}

export function deleteFriend(friendId: number, deleteType: number) {
  return axios.patch(`/blog/admin/friend/${friendId}/delete`, { friendId, deleteType }) as Promise<{
    success: boolean;
  }>;
}
