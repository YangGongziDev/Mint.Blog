import { safeRequest } from '../axios';
import type { RbacPage, RbacPermission, RbacRole } from './role';

export interface RbacUser {
  id: string;
  username: string;
  realName: string;
  email: string | null;
  phone: string | null;
  avatar: string | null;
  gender: string | null;
  birthDate: string | null;
  bio: string | null;
  status: 'active' | 'inactive';
  roles: RbacRole[];
  permissions: RbacPermission[];
  createdAt: string;
  updatedAt: string | null;
}

export type UserSearchParams = Partial<Api.Common.CommonSearchParams & {
  username: string;
  realName: string;
  email: string;
  phone: string;
  status: RbacUser['status'];
}>;
export interface UserUpdateInput {
  realName: string;
  email?: string;
  phone?: string;
  status?: RbacUser['status'];
  roleIds?: string[];
}
export interface UserCreateInput extends UserUpdateInput {
  username: string;
  password: string;
}

export async function fetchGetUserList(params: UserSearchParams = {}) {
  const { size, ...query } = params;
  const result = await safeRequest<RbacPage<RbacUser>>({
    url: '/system/users', method: 'get', params: { ...query, pageSize: size }
  });
  return {
    ...result,
    data: result.data ? {
      records: result.data.list, total: result.data.total, current: result.data.current, size: result.data.pageSize
    } : null
  };
}

export function fetchGetUser(id: string) {
  return safeRequest<RbacUser>({ url: `/system/users/${id}`, method: 'get' });
}

export function fetchGetAssignableRoles() {
  return safeRequest<RbacRole[]>({ url: '/system/users/assignable-roles', method: 'get' });
}

export function fetchCreateUser(data: UserCreateInput) {
  return safeRequest<RbacUser>({ url: '/system/users', method: 'post', data });
}

export function fetchUpdateUser(id: string, data: UserUpdateInput) {
  return safeRequest<RbacUser>({ url: `/system/users/${id}`, method: 'put', data });
}

export function fetchDeleteUser(id: string) {
  return safeRequest<null>({ url: `/system/users/${id}`, method: 'delete' });
}

export function fetchUpdatePassword(data: { oldPassword: string; newPassword: string }) {
  return safeRequest<null>({ url: '/system/users/change-password', method: 'post', data });
}
