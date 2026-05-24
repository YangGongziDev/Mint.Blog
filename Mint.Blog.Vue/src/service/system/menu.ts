import { safeRequest } from '../axios';

export function fetchGetAllPages() {
  return safeRequest<string[]>({
    url: '/system/getAllPage',
    method: 'get'
  });
}

export function fetchGetMenuTree() {
  return safeRequest<Api.SystemManage.MenuTree[]>({
    url: '/system/getMenuTree',
    method: 'get'
  });
}
