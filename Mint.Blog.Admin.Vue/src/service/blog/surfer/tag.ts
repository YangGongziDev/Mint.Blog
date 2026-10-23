import axios from '../../axios';

export function getTagList<T = unknown>(): Promise<T> {
  return axios.get('/blog/surfer/tag') as Promise<T>;
}

export function getTagArticlePageList<T = unknown>(data: unknown): Promise<T> {
  const d = data as Record<string, unknown>;
  return axios.post('/blog/surfer/article/api/blog/surfer/tag/article/list', {
    current: d.current,
    size: d.size,
    tagId: d.id
  }) as Promise<T>;
}
