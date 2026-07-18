import axios from '../../axios';

export interface GalleryCategoryItem {
  id: string;
  name: string;
  description: string;
  sort: number;
  enabled: boolean;
  createdAt?: string;
  updatedAt?: string;
}

export interface GalleryImageItem {
  id: string;
  name: string;
  categoryId: string;
  categoryName: string;
  resolution: string;
  ratio: string;
  time?: string;
  url: string;
  sourceType: 'local' | 'external';
  bucketName: string;
  objectName: string;
  fileName: string;
  sort: number;
  enabled: boolean;
  createdAt?: string;
  updatedAt?: string;
}

export interface GalleryPageQuery {
  pageNumber: number;
  pageSize: number;
  keyword?: string;
  categoryId?: string;
  resolution?: string;
  ratio?: string;
  sortOrder?: 'timeDesc' | 'timeAsc' | 'nameAsc' | 'nameDesc';
}

export interface SurferGalleryQuery {
  pageNumber: number;
  pageSize: number;
  keyword?: string;
  categoryId?: string;
  resolution?: string;
  ratio?: string;
  sortOrder?: 'timeDesc' | 'timeAsc' | 'nameAsc' | 'nameDesc';
}

export interface SaveGalleryCategoryPayload {
  name: string;
  description?: string;
  sort: number;
  enabled: boolean;
}

export interface SaveGalleryImagePayload {
  name: string;
  categoryId: string;
  resolution?: string;
  ratio?: string;
  time?: string;
  url: string;
  sourceType: 'local' | 'external';
  bucketName?: string;
  objectName?: string;
  fileName?: string;
  sort: number;
  enabled: boolean;
}

export function getSurferGalleryCategories() {
  return axios.get('/blog/surfer/gallery/categories') as Promise<{ success: boolean; data: GalleryCategoryItem[] }>;
}

export function getSurferGalleryImages(params: SurferGalleryQuery) {
  return axios.get('/blog/surfer/gallery/images', { params }) as Promise<{
    success: boolean;
    data: { items?: GalleryImageItem[]; records?: GalleryImageItem[]; totalCount?: number; total?: number; pageNumber: number; pageSize: number };
  }>;
}

export function getGalleryCategoryPageList(params: GalleryPageQuery) {
  return axios.get('/blog/admin/gallery/categories', { params }) as Promise<{
    success: boolean;
    data: { items?: GalleryCategoryItem[]; records?: GalleryCategoryItem[]; totalCount?: number; total?: number; pageNumber: number; pageSize: number };
  }>;
}

export function getGalleryCategoryOptions() {
  return axios.get('/blog/admin/gallery/categories/options') as Promise<{ success: boolean; data: GalleryCategoryItem[] }>;
}

export function createGalleryCategory(payload: SaveGalleryCategoryPayload) {
  return axios.post('/blog/admin/gallery/categories', payload) as Promise<{ success: boolean; data: { id: string } }>;
}

export function updateGalleryCategory(id: string, payload: SaveGalleryCategoryPayload) {
  return axios.put(`/blog/admin/gallery/categories/${id}`, payload) as Promise<{ success: boolean }>;
}

export function deleteGalleryCategory(id: string) {
  return axios.delete(`/blog/admin/gallery/categories/${id}`) as Promise<{ success: boolean }>;
}

export function getGalleryImagePageList(params: GalleryPageQuery) {
  return axios.get('/blog/admin/gallery/images', { params }) as Promise<{
    success: boolean;
    data: { items?: GalleryImageItem[]; records?: GalleryImageItem[]; totalCount?: number; total?: number; pageNumber: number; pageSize: number };
  }>;
}

export function createGalleryImage(payload: SaveGalleryImagePayload) {
  return axios.post('/blog/admin/gallery/images', payload) as Promise<{ success: boolean; data: { id: string } }>;
}

export function updateGalleryImage(id: string, payload: SaveGalleryImagePayload) {
  return axios.put(`/blog/admin/gallery/images/${id}`, payload) as Promise<{ success: boolean }>;
}

export function deleteGalleryImage(id: string) {
  return axios.delete(`/blog/admin/gallery/images/${id}`) as Promise<{ success: boolean }>;
}
