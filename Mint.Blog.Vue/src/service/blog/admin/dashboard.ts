import axios from '../../axios';

export interface AdminDashboardStatistics {
  articleTotalCount: number;
  categoryTotalCount: number;
  tagTotalCount: number;
  wikiTotalCount: number;
  pvTotalCount: number;
}

export interface AdminDashboardPvStatistics {
  pvDates: string[];
  pvCounts: number[];
}

export interface AdminDashboardPublishArticleStatistics {
  dates: string[];
  counts: number[];
}

export function getDashboardStatistics() {
  return axios.get('/blog/admin/dashboard/statistics') as Promise<{
    success: boolean;
    data: AdminDashboardStatistics;
  }>;
}

export function getDashboardPvStatistics() {
  return axios.get('/blog/admin/dashboard/pv-statistics') as Promise<{
    success: boolean;
    data: AdminDashboardPvStatistics;
  }>;
}

export function getDashboardPublishArticleStatistics() {
  return axios.get('/blog/admin/dashboard/publish-article-statistics') as Promise<{
    success: boolean;
    data: AdminDashboardPublishArticleStatistics;
  }>;
}
