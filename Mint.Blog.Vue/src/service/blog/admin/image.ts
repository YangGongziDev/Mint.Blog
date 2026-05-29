import axios from '../../axios';

export interface UploadImageResult {
  url: string;
}

export interface MinioBucketItem {
  name: string;
  isPublic: boolean;
  creationDate?: string;
}

export interface ManagedImageArticleReference {
  articleId: string;
  articleTitle: string;
  articleUrl: string;
}

export interface ManagedImageListItem {
  bucketName: string;
  objectName: string;
  fileName: string;
  url: string;
  size: number;
  lastModified?: string;
  referencedArticles: ManagedImageArticleReference[];
}

export interface ObjectMoveConflict {
  sourceUrl: string;
  sourceBucketName: string;
  sourceObjectName: string;
  targetBucketName: string;
  targetObjectName: string;
  targetUrl: string;
  canOverwrite: boolean;
}

export interface ManagedImagePageQuery {
  pageNumber: number;
  pageSize: number;
  bucketName?: string;
  fileName?: string;
  used?: boolean;
  sortOrder?: 'lastModifiedDesc' | 'lastModifiedAsc' | 'nameAsc' | 'nameDesc';
}

export function getMinioBuckets() {
  return axios.get('/blog/admin/image/buckets') as Promise<{
    success: boolean;
    data: MinioBucketItem[];
  }>;
}

export function createMinioBucket(bucketName: string, isPublic: boolean) {
  return axios.post('/blog/admin/image/buckets', { bucketName, isPublic }) as Promise<{ success: boolean }>;
}

export function setMinioBucketPublic(bucketName: string, isPublic: boolean) {
  return axios.patch(`/blog/admin/image/buckets/${encodeURIComponent(bucketName)}/public`, { isPublic }) as Promise<{
    success: boolean;
  }>;
}

export function deleteMinioBucket(bucketName: string) {
  return axios.delete(`/blog/admin/image/buckets/${encodeURIComponent(bucketName)}`) as Promise<{ success: boolean }>;
}

export function getManagedImagePageList(params: ManagedImagePageQuery) {
  return axios.get('/blog/admin/image', { params }) as Promise<{
    success: boolean;
    data: {
      items?: ManagedImageListItem[];
      records?: ManagedImageListItem[];
      totalCount?: number;
      total?: number;
      pageNumber: number;
      pageSize: number;
    };
  }>;
}

export function renameBlogImage(oldImageName: string, newImageName: string) {
  return axios.post('/blog/admin/image/rename', { oldImageName, newImageName }) as Promise<{
    success: boolean;
    data: { url: string };
  }>;
}

export function moveBlogImage(oldImageName: string, targetBucketName: string) {
  return axios.post('/blog/admin/image/move', { oldImageName, targetBucketName }) as Promise<{
    success: boolean;
    data: { url: string };
  }>;
}

export function moveBlogImagesPrecheck(oldImageNames: string[], targetBucketName: string) {
  return axios.post('/blog/admin/image/move-many/precheck', { oldImageNames, targetBucketName }) as Promise<{
    success: boolean;
    data: { conflicts: ObjectMoveConflict[] };
  }>;
}

export function moveBlogImages(oldImageNames: string[], targetBucketName: string, overwriteExisting = false) {
  return axios.post('/blog/admin/image/move-many', { oldImageNames, targetBucketName, overwriteExisting }) as Promise<{
    success: boolean;
    data: { urls: string[] };
  }>;
}

export interface UploadBlogImagePayload {
  newImageFile: File;
  newImageOriginalName: string;
  oldImageName?: string;
  bucketName?: string;
}

export function uploadBlogImage(payload: UploadBlogImagePayload) {
  const formData = new FormData();
  formData.append('newImageFile', payload.newImageFile);
  formData.append('newImageOriginalName', payload.newImageOriginalName);
  if (payload.oldImageName) formData.append('oldImageName', payload.oldImageName);
  if (payload.bucketName) formData.append('bucketName', payload.bucketName);

  return axios.post('/blog/admin/image/upload', formData) as Promise<{
    success: boolean;
    data: UploadImageResult;
  }>;
}

export function deleteBlogImage(oldImageName: string) {
  return axios.post('/blog/admin/image/delete', JSON.stringify(oldImageName), {
    headers: { 'Content-Type': 'application/json' }
  }) as Promise<{
    success: boolean;
    data: null;
  }>;
}

export function deleteBlogImages(oldImageNames: string[]) {
  return axios.post('/blog/admin/image/delete-many', oldImageNames) as Promise<{
    success: boolean;
    data: { deletedCount: number; skippedUsedCount: number };
  }>;
}
