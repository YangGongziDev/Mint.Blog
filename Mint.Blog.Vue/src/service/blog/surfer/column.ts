import axios from '../../axios';

export function getColumnList<T = unknown>(): Promise<T> {
  return axios.get('/blog/surfer/column') as Promise<T>;
}

export function getColumnArticlePreNext<T = unknown>(data: unknown): Promise<T> {
  const d = data as Record<string, unknown>;
  return axios.get(`/blog/surfer/column/${d.id}/article/${d.articleId}/neighbor`) as Promise<T>;
}

export function getColumnCatalogs<T = unknown>(id: unknown): Promise<T> {
  return axios.get(`/blog/surfer/column/${id}/catalog`) as Promise<T>;
}
