import axios from '../../axios';

export function getBlogSettingsDetail<T = unknown>(): Promise<T> {
  return axios.get('/blog/surfer/setting') as Promise<T>;
}
