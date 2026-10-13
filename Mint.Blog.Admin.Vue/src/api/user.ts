import type { ApiResponse, PageParams, PageResult } from '@/types/api';
import type { Role, User } from '@/types/auth';

import { request } from '@/utils/request';

/**
 * Get user list
 */
export function getUserList(params: PageParams): Promise<ApiResponse<PageResult<User>>> {
  return request.get('/users', { params });
}

/**
 * Get user by ID
 */
export function getAssignableRoles(): Promise<ApiResponse<Role[]>> {
  return request.get('/users/assignable-roles');
}

export function getUserById(id: string): Promise<ApiResponse<User>> {
  return request.get(`/users/${id}`);
}

/**
 * Create user
 */
export type UpdateUserParams = Partial<
  Pick<User, 'realName' | 'email' | 'phone' | 'gender' | 'birthDate' | 'bio' | 'avatar' | 'status'>
> & { roleIds?: string[] };

export type CreateUserParams = UpdateUserParams & {
  username: string;
  password: string;
};

export function createUser(data: CreateUserParams): Promise<ApiResponse<User>> {
  return request.post('/users', data);
}

/**
 * Update user
 */
export function updateUser(id: string, data: UpdateUserParams): Promise<ApiResponse<User>> {
  return request.put(`/users/${id}`, data);
}

/**
 * Delete user
 */
export function deleteUser(id: string): Promise<ApiResponse<null>> {
  return request.delete(`/users/${id}`);
}

/**
 * Change password
 */
export interface ChangePasswordParams {
  oldPassword: string;
  newPassword: string;
}

export function changePassword(params: ChangePasswordParams): Promise<ApiResponse<null>> {
  return request.post('/users/change-password', params);
}
