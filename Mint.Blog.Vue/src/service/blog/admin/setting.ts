import axios from '../../axios';

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

export function getBlogSettingsDetail() {
  return axios.get('/blog/admin/setting') as Promise<{
    success: boolean;
    data: BlogSettingsDetail;
  }>;
}

export function updateBlogSettings(data: UpdateBlogSettingsPayload) {
  return axios.put('/blog/admin/setting', data) as Promise<{
    success: boolean;
    data: null;
  }>;
}
