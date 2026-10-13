import type { ApiResponse, PageResult } from '@/types/api';
import type { SysFile, SysFileQueryParams } from '@/types/file';

import { request } from '@/utils/request';

export function getFileList(params: SysFileQueryParams): Promise<ApiResponse<PageResult<SysFile>>> {
  return request.get('/file/list', { params });
}

export function uploadFile(file: File): Promise<ApiResponse<SysFile>> {
  const data = new FormData();
  data.append('file', file);
  return request.post('/file/upload', data, { headers: { 'Content-Type': 'multipart/form-data' }, timeout: 120000 });
}

export function deleteFile(id: string): Promise<ApiResponse<void>> {
  return request.delete(`/file/${id}`);
}
