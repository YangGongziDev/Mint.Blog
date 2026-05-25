import axios from '../../axios';

export interface BlogStatisticsInfo {
  articleTotalCount: number;
  categoryTotalCount: number;
  tagTotalCount: number;
  columnTotalCount: number;
  pvTotalCount: number;
}

export function getStatisticsInfo<T = BlogStatisticsInfo>(): Promise<{ success: boolean; data: T }> {
  return axios.get('/blog/surfer/statistics') as Promise<{ success: boolean; data: T }>;
}
