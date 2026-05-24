import axios from '../../axios';

export function getCategoryList<T = unknown>(): Promise<T> {
  return axios.get('/blog/surfer/category') as Promise<T>;
}

export function getCategoryArticlePageList<T = unknown>(data: unknown): Promise<T> {
  const d = data as Record<string, unknown>;
  return axios.post('/blog/surfer/article/api/blog/surfer/category/article/list', {
    current: d.current,
    size: d.size,
    categoryId: d.id
  }) as Promise<T>;
}
