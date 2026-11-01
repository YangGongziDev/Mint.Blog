import http from 'axios';
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

export interface AdminFriendPageQuery {
  pageNumber: number;
  pageSize: number;
  name?: string;
  startDate?: string;
  endDate?: string;
  sortOrder?: TimeSortOrder;
}

export interface AdminFriendPageItem {
  id: string;
  name: string;
  description: string;
  url: string;
  rssUrl?: string | null;
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
  rssUrl?: string;
  description: string;
  email?: string;
}

export type FriendFeedMetadata = Partial<Pick<FriendFormModel, 'name' | 'url' | 'description' | 'avatar'>>;

type FriendFeedResponse = {
  success: boolean;
  data: FriendFeedMetadata;
  message?: string;
};

export async function parseFriendFeed(url: string, signal: AbortSignal): Promise<FriendFeedResponse> {
  // Public lookup uses inline feedback instead of the shared interceptor's global error notifications.
  const response = await http.get<FriendFeedResponse>('/surfer/friend/feed', {
    baseURL: axios.defaults.baseURL,
    params: { url },
    signal,
    timeout: 15000,
    validateStatus: status => status === 200 || status === 400
  });
  return response.data;
}

export function getFriendPageList(params: AdminFriendPageQuery) {
  return axios.get('/admin/friend', { params }) as Promise<{
    success: boolean;
    data: PageResult<AdminFriendPageItem>;
  }>;
}

export function createFriend(data: FriendFormModel) {
  return axios.post('/admin/friend', { ...data, rssUrl: data.rssUrl?.trim() || null }) as Promise<{ success: boolean; data: { id: string } }>;
}

export function updateFriend(friendId: string, data: FriendFormModel) {
  return axios.put(`/admin/friend/${friendId}`, { ...data, rssUrl: data.rssUrl?.trim() || null }) as Promise<{ success: boolean; data: { id: string } }>;
}

export function setFriendTop(friendId: string, isTop: boolean) {
  return axios.patch(`/admin/friend/${friendId}/top`, { friendId, isTop }) as Promise<{ success: boolean }>;
}

export function setFriendStatus(friendId: string, status: string) {
  return axios.patch(`/admin/friend/${friendId}/status`, { friendId, status }) as Promise<{ success: boolean }>;
}

export function updateFriendSort(friendId: string, sort: number) {
  return axios.patch(`/admin/friend/${friendId}/sort`, { friendId, sort }) as Promise<{
    success: boolean;
    data: { id: string; sort: number };
  }>;
}

export function moveFriendSortFirst(friendId: string) {
  return axios.patch(`/admin/friend/${friendId}/sort/first`) as Promise<{ success: boolean }>;
}

export function moveFriendSortLast(friendId: string) {
  return axios.patch(`/admin/friend/${friendId}/sort/last`) as Promise<{ success: boolean }>;
}

export function deleteFriend(friendId: string, deleteType: number) {
  return axios.patch(`/admin/friend/${friendId}/delete`, { friendId, deleteType }) as Promise<{
    success: boolean;
  }>;
}
