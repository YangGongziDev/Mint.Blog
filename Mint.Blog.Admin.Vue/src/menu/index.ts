import type { MenuModuleKey } from '@/router/types';
import type { AppMenuRecord } from './types';

import { systemMenus } from './system/system-backstage';
import { blogAdminMenus } from './blog/admin/blog-admin-backstage';
import { documentMenus } from './document/document-backstage';
import { blogSurferMenus } from './blog/surfer/blog-surfer-frontdesk';

export { systemMenus } from './system/system-backstage';
export { blogAdminMenus } from './blog/admin/blog-admin-backstage';
export { documentMenus } from './document/document-backstage';
export { blogSurferMenus } from './blog/surfer/blog-surfer-frontdesk';

export const backstageMenuOptions = [...systemMenus, ...blogAdminMenus, ...documentMenus].sort((a, b) => (a.order || 0) - (b.order || 0));
export const frontdeskMenuOptions = [...blogSurferMenus];

export const menuOptionsByModule: Record<MenuModuleKey, AppMenuRecord[]> = {
  backstage: backstageMenuOptions,
  frontdesk: frontdeskMenuOptions
};

export const menuOptions = [...backstageMenuOptions, ...frontdeskMenuOptions];

export { validateMenuSetup } from './validate';
export type { AppMenuRecord, MenuPermission } from './types';
