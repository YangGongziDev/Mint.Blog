import axios from '../axios';

export interface ResourceApiResponse<T> { success: boolean; data: T; message?: string; errorCode?: string }
export interface NavigationTag {
  id: string;
  name: string;
  logoUrl: string;
  showInNavigation: boolean;
  categoryId: string;
  categoryName: string;
  navigationDescription: string;
  versionCount: string;
  resourceCount: string;
}
export interface TagVersion {
  id: string;
  tagId: string;
  name: string;
  sort: string;
  isGeneral: boolean;
  articleCount: string;
  resourceCount: string;
}
export type ResourceKind = 1 | 2 | 3 | 4;
export interface ResourceForm {
  tagId: string;
  tagVersionId: string;
  title: string;
  description: string;
  url: string;
  kind: ResourceKind;
  isFeatured: boolean;
  sort: string;
}
export interface ResourceItem extends ResourceForm {
  id: string;
  categoryId: string;
  categoryName: string;
  tagName: string;
  tagVersionName: string;
  isGeneral: boolean;
  isDeleted: boolean;
}
export interface NavigationTagQuery { categoryId?: string; keyword?: string }
export interface NavigationTagForm { showInNavigation: boolean; navigationDescription: string }
export interface TagVersionForm { name: string; sort: string }
export interface ResourcePageQuery {
  pageNumber: number;
  pageSize: number;
  tagId?: string;
  tagVersionId?: string;
  kind?: ResourceKind;
  keyword?: string;
  isDeleted?: boolean;
}
export interface ResourcePage { items: ResourceItem[]; pageNumber: number; pageSize: number; totalCount: number }
type Saved = ResourceApiResponse<{ id: string }>;
export function getNavigationTags(params: NavigationTagQuery = {}) {
  return axios.get('/admin/navigation-tags', { params }) as Promise<ResourceApiResponse<NavigationTag[]>>;
}
export function configureNavigationTag(tagId: string, data: NavigationTagForm) {
  return axios.patch(`/admin/navigation-tags/${tagId}`, data) as Promise<Saved>;
}
export function getTagVersions(tagId: string) {
  return axios.get(`/admin/tags/${tagId}/versions`) as Promise<ResourceApiResponse<TagVersion[]>>;
}
export function createTagVersion(tagId: string, data: TagVersionForm) {
  return axios.post(`/admin/tags/${tagId}/versions`, data) as Promise<Saved>;
}
export function updateTagVersion(tagId: string, tagVersionId: string, data: TagVersionForm & { tagId?: string }) {
  return axios.put(`/admin/tags/${tagId}/versions/${tagVersionId}`, data) as Promise<Saved>;
}
export function deleteTagVersion(tagId: string, tagVersionId: string) {
  return axios.delete(`/admin/tags/${tagId}/versions/${tagVersionId}`) as Promise<Saved>;
}
export function getResourcePage(params: ResourcePageQuery) {
  return axios.get('/admin/resources', { params }) as Promise<ResourceApiResponse<ResourcePage>>;
}
export function getResourceDetail(resourceId: string) {
  return axios.get(`/admin/resources/${resourceId}`) as Promise<ResourceApiResponse<ResourceItem>>;
}
export function createResource(data: ResourceForm) { return axios.post('/admin/resources', data) as Promise<Saved>; }
export function updateResource(resourceId: string, data: ResourceForm) { return axios.put(`/admin/resources/${resourceId}`, data) as Promise<Saved>; }
export function deleteResource(resourceId: string) { return axios.delete(`/admin/resources/${resourceId}`) as Promise<Saved>; }
export function restoreResource(resourceId: string) { return axios.post(`/admin/resources/${resourceId}/restore`) as Promise<Saved>; }
