import type { ApiResponse, PageParams, PageResult } from '@/types/api';
import type { Permission, Role } from '@/types/auth';

import { request } from '@/utils/request';

/**
 * Get role list
 */
export function getRoleList(params: PageParams): Promise<ApiResponse<PageResult<Role>>> {
  return request.get('/roles', { params });
}

/**
 * Get role by ID
 */
export function getAssignablePermissions(): Promise<ApiResponse<Permission[]>> {
  return request.get('/roles/assignable-permissions');
}

export function getRoleById(id: string): Promise<ApiResponse<Role>> {
  return request.get(`/roles/${id}`);
}

/**
 * Create role
 */
export type CreateRoleParams = Pick<Role, 'name' | 'code'> & {
  description?: string;
  permissionIds: string[];
};
export type UpdateRoleParams = Partial<CreateRoleParams>;

export function createRole(data: CreateRoleParams): Promise<ApiResponse<Role>> {
  return request.post('/roles', data);
}

/**
 * Update role
 */
export function updateRole(id: string, data: UpdateRoleParams): Promise<ApiResponse<Role>> {
  return request.put(`/roles/${id}`, data);
}

/**
 * Delete role
 */
export function deleteRole(id: string): Promise<ApiResponse<null>> {
  return request.delete(`/roles/${id}`);
}
