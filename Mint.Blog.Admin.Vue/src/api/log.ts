import type { ApiResponse, PageResult } from '@/types/api';
import type {
  OperationLog,
  LoginLog,
  OperationLogQueryParams,
  LoginLogQueryParams,
} from '@/types/log';

import { request } from '@/utils/request';

/**
 * 获取操作日志列表
 */
export function getOperationLogList(
  params: OperationLogQueryParams,
): Promise<ApiResponse<PageResult<OperationLog>>> {
  return request.get('/log/operation/list', { params });
}

/**
 * 获取登录日志列表
 */
export function getLoginLogList(params: LoginLogQueryParams): Promise<ApiResponse<PageResult<LoginLog>>> {
  return request.get('/log/login/list', { params });
}

/**
 * 清空操作日志
 */
export function clearOperationLog(): Promise<ApiResponse<void>> {
  return request.delete('/log/operation/clear');
}

/**
 * 清空登录日志
 */
export function clearLoginLog(): Promise<ApiResponse<void>> {
  return request.delete('/log/login/clear');
}
