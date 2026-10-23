import axios from '../../axios';

export function getArticlePageList<T = unknown>(data: unknown): Promise<T> {
  return axios.post('/blog/surfer/article/list', data) as Promise<T>;
}

export function getArticleDetail<T = unknown>(articleId: unknown): Promise<T> {
  return axios.post('/blog/surfer/article/detail', { articleId }) as Promise<T>;
}

export function getArticleSearchPageList<T = unknown>(params: {
  keyword: string;
  pageNumber?: number;
  pageSize?: number;
}): Promise<T> {
  return axios.get('/blog/surfer/article/search', { params }) as Promise<T>;
}
