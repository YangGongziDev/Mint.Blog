import axios from '../../axios';

export function getArchivePageList<T = unknown>(data: unknown): Promise<T> {
  const d = data as Record<string, unknown>;
  return axios.post('/blog/surfer/archive/list', {
    current: d.current,
    size: d.size,
    year: d.year || null
  }) as Promise<T>;
}

export function getArchiveYears<T = unknown>(): Promise<T> {
  return axios.get('/blog/surfer/archive/year') as Promise<T>;
}
