import axios from '../axios';

export interface BlogSettingsDetail {
  logo: string;
  name: string;
  author: string;
  introduction: string;
  copyrightDeclaration: string;
  avatar: string;
  githubHomepage: string;
  csdnHomepage: string;
  giteeHomepage: string;
  zhihuHomepage: string;
  douyinHomepage: string;
  mail: string;
  isCommentSensitiveWordOpen: boolean;
  isCommentExamineOpen: boolean;
  isAutoTheme: boolean;
}

export type UpdateBlogSettingsPayload = BlogSettingsDetail;

export function getPublicBlogSettingsDetail<T = unknown>(): Promise<T> {
  return axios.get('/surfer/setting') as Promise<T>;
}

export function getBlogSettingsDetail() {
  return axios.get('/admin/setting') as Promise<{
    success: boolean;
    data: BlogSettingsDetail;
  }>;
}

export function updateBlogSettings(data: UpdateBlogSettingsPayload) {
  return axios.put('/admin/setting', data) as Promise<{
    success: boolean;
    data: null;
  }>;
}
