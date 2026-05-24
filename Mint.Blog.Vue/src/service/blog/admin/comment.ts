import axios from '../../axios';

interface PageResult<T> {
  items?: T[];
  records?: T[];
  totalCount?: number;
  total?: number;
  pageNumber: number;
  pageSize: number;
}

export interface AdminCommentPageQuery {
  pageNumber: number;
  pageSize: number;
  routerUrl?: string;
  startDate?: string;
  endDate?: string;
  status?: number;
}

export interface AdminCommentPageItem {
  id: number;
  routerUrl: string;
  avatar: string;
  nickname: string;
  mail: string;
  website: string;
  createdAt: string;
  content: string;
  status: number;
  reason: string;
  isDeleted: boolean;
}

export interface ExamineCommentPayload {
  status: number;
  reason?: string | null;
}

export function getCommentPageList(params: AdminCommentPageQuery) {
  return axios.get('/blog/admin/comment', { params }) as Promise<{
    success: boolean;
    data: PageResult<AdminCommentPageItem>;
  }>;
}

export function examineComment(commentId: number, data: ExamineCommentPayload) {
  return axios.patch(`/blog/admin/comment/${commentId}/examine`, { id: commentId, ...data }) as Promise<{
    success: boolean;
  }>;
}

export function deleteComment(commentId: number, deleteType: number) {
  return axios.patch(`/blog/admin/comment/${commentId}/delete`, { id: commentId, deleteType }) as Promise<{
    success: boolean;
  }>;
}
