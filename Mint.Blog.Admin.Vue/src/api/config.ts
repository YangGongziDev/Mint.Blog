import type { ApiResponse, PageResult } from '@/types/api';
import type { SysConfig, SysConfigQueryParams } from '@/types/config';

import { request } from '@/utils/request';

export function getConfigList(params: SysConfigQueryParams): Promise<ApiResponse<PageResult<SysConfig>>> {
  return request.get('/config/list', { params });
}

export function getConfigByKey(key: string): Promise<ApiResponse<SysConfig>> {
  return request.get(`/config/key/${key}`);
}

export function createConfig(data: Partial<SysConfig>): Promise<ApiResponse<SysConfig>> {
  return request.post('/config', data);
}

export function updateConfig(
  id: string,
  data: Partial<SysConfig>,
): Promise<ApiResponse<SysConfig>> {
  return request.put(`/config/${id}`, data);
}

export function deleteConfig(id: string): Promise<ApiResponse<void>> {
  return request.delete(`/config/${id}`);
}
