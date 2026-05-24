import axios from '../../axios';

export interface MessageItem {
  id: number;
  nickname: string;
  website: string | null;
  content: string;
  color: string;
  createdAt: string;
}

export interface MessagePagedResult {
  items: MessageItem[];
  pageNumber: number;
  pageSize: number;
  totalCount: number;
}

export function getMessageList(pageNumber = 1, pageSize = 10) {
  return axios.post('/blog/surfer/message/list', { PageNumber: pageNumber, PageSize: pageSize }) as Promise<{
    success: boolean;
    data: MessagePagedResult;
  }>;
}

export function publishMessage(data: {
  nickname: string;
  email?: string;
  website?: string;
  content: string;
  color: string;
}) {
  return axios.post('/blog/surfer/message', data) as Promise<{ success: boolean; data: { id: number } }>;
}
