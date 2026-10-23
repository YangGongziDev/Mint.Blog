import axios from '../../axios';

export interface UploadFileResult {
  url: string;
}

export function uploadBlogFile(newFile: File, newFileOriginalName: string, oldFileName?: string) {
  const formData = new FormData();
  formData.append('newFile', newFile);
  formData.append('newFileOriginalName', newFileOriginalName);
  if (oldFileName) formData.append('oldFileName', oldFileName);

  return axios.post('/blog/admin/file/upload', formData) as Promise<{
    success: boolean;
    data: UploadFileResult;
  }>;
}

export function deleteBlogFile(oldFileName: string) {
  return axios.post('/blog/admin/file/delete', JSON.stringify(oldFileName), {
    headers: { 'Content-Type': 'application/json' }
  }) as Promise<{
    success: boolean;
    data: null;
  }>;
}
