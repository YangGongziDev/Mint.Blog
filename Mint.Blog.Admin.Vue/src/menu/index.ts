import { blogMenus, documentMenus } from './blog';
import { systemMenus } from './system';

export const menuOptions = [...systemMenus, ...blogMenus, ...documentMenus].sort((a, b) => (a.order || 0) - (b.order || 0));

export { validateMenuSetup } from './validate';
export type { AppMenuRecord, MenuPermission } from './types';
