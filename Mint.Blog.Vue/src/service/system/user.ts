import { safeRequest } from '../axios';

export function fetchGetUserList(params?: Api.SystemManage.UserSearchParams) {
  return safeRequest<Api.SystemManage.UserList>({
    url: '/system/getUserList',
    method: 'get',
    params
  });
}

export function fetchUpdateUser(userId: number, data: Pick<Api.SystemManage.User, 'userName' | 'displayName' | 'isDeleted'>) {
  return safeRequest({
    url: `/system/user/${userId}`,
    method: 'put',
    data: {
      userId,
      ...data
    }
  });
}

export function fetchUpdatePassword(data: { userName: string; password: string }) {
  return safeRequest({
    url: '/system/user/password',
    method: 'patch',
    data
  });
}
