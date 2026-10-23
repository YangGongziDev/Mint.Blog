import axios from '../../axios';

export function getUserInfoByQQ<T = unknown>(qq: unknown): Promise<T> {
  return axios.get('/blog/surfer/comment/qq-user-info', { params: { qq } }) as Promise<T>;
}

export function publishComment<T = unknown>(data: unknown): Promise<T> {
  return axios.post('/blog/surfer/comment/publish', data) as Promise<T>;
}

export function getComments<T = unknown>(routerUrl: unknown): Promise<T> {
  return axios.get('/blog/surfer/comment', { params: { routerUrl } }) as Promise<T>;
}
