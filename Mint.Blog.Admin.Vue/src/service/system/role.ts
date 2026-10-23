import { safeRequest } from '../axios';

export function fetchGetRoleList(params?: Api.SystemManage.RoleSearchParams) {
  return safeRequest<Api.SystemManage.RoleList>({
    url: '/system/getRoleList',
    method: 'get',
    params
  });
}

export function fetchGetAllRoles() {
  return safeRequest<Api.SystemManage.Role[]>({
    url: '/system/getAllRole',
    method: 'get'
  });
}

export function fetchUpdateUserRole(id: number, data: Pick<Api.SystemManage.Role, 'userName' | 'role'>) {
  return safeRequest({
    url: `/system/userRole/${id}`,
    method: 'put',
    data: {
      id,
      ...data
    }
  });
}
