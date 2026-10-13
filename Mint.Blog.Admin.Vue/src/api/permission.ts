import type { ApiResponse } from '@/types/api';
import type { Permission } from '@/types/auth';

import { request } from '@/utils/request';

/**
 * Get permission list
 */
export function getPermissionList(
  params?: Record<string, unknown>,
): Promise<ApiResponse<Permission[]>> {
  return request.get('/permissions', { params });
}

/**
 * Get permission by ID
 */
export function getPermissionById(id: string): Promise<ApiResponse<Permission>> {
  return request.get(`/permissions/${id}`);
}

/**
 * Create permission
 */
export type PermissionWriteParams = Omit<Permission, 'id' | 'children'>;

export function createPermission(data: PermissionWriteParams): Promise<ApiResponse<Permission>> {
  return request.post('/permissions', data);
}

/**
 * Update permission
 */
export function updatePermission(
  id: string,
  data: Partial<PermissionWriteParams>,
): Promise<ApiResponse<Permission>> {
  return request.put(`/permissions/${id}`, data);
}

/**
 * Delete permission
 */
export function deletePermission(id: string): Promise<ApiResponse<null>> {
  return request.delete(`/permissions/${id}`);
}
