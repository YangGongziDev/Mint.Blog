import { safeRequest } from '../axios';

export interface RbacPermission {
  id: string;
  name: string | Record<string, string>;
  code: string;
  description: string | null;
  resource: string | null;
  action: string | null;
  type: 'menu' | 'button' | 'api';
  parentId: string | null;
  status: 'active' | 'inactive';
  children?: RbacPermission[];
}

export interface RbacRole {
  id: string;
  name: string;
  code: string;
  description: string | null;
  permissions: RbacPermission[];
  createdAt: string;
  updatedAt: string | null;
}

export interface RbacPage<T> {
  list: T[];
  total: number;
  current: number;
  pageSize: number;
}

export type RoleSearchParams = Partial<Api.Common.CommonSearchParams & Pick<RbacRole, 'name' | 'code'>>;
export interface RoleInput {
  name: string;
  code: string;
  description: string;
  permissionIds?: string[];
}

export async function fetchGetRoleList(params: RoleSearchParams = {}) {
  const { size, ...query } = params;
  const result = await safeRequest<RbacPage<RbacRole>>({
    url: '/system/roles', method: 'get', params: { ...query, pageSize: size }
  });
  return {
    ...result,
    data: result.data ? {
      records: result.data.list, total: result.data.total, current: result.data.current, size: result.data.pageSize
    } : null
  };
}

export function fetchGetAssignablePermissions() {
  return safeRequest<RbacPermission[]>({ url: '/system/roles/assignable-permissions', method: 'get' });
}

export function fetchCreateRole(data: RoleInput) {
  return safeRequest<RbacRole>({ url: '/system/roles', method: 'post', data });
}

export function fetchUpdateRole(id: string, data: RoleInput) {
  return safeRequest<RbacRole>({ url: `/system/roles/${id}`, method: 'put', data });
}

export function fetchDeleteRole(id: string) {
  return safeRequest<null>({ url: `/system/roles/${id}`, method: 'delete' });
}
