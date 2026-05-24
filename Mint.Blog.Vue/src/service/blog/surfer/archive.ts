import axios from '../../axios';

export function getArchivePageList<T = unknown>(data: unknown): Promise<T> {
  return axios.get('/blog/surfer/archive', { params: data }) as Promise<T>;
}

export function getArchiveYears<T = unknown>(): Promise<T> {
  return axios.get('/blog/surfer/archive/year') as Promise<T>;
}
