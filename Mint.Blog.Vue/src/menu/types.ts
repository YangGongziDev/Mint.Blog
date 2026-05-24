import type { RouteKey } from '@/router/types';

export type AppMenuType = 'folder' | 'route' | 'iframe' | 'external';

export type MenuPermission =
  | 'Search'
  | 'Add'
  | 'Delete'
  | 'Update'
  | 'Import'
  | 'Export'
  | 'Upload'
  | 'Audit';

export interface AppMenuRecord {
  id: string;
  parentId: string | null;
  menuType: AppMenuType;
  routerName?: RouteKey;
  path: string;
  tableName: string;
  enabled: boolean;
  menuI18nKey: App.I18n.I18nKey;
  icon?: string;
  order?: number;
  permission?: MenuPermission[];
}

export interface AppMenuNode extends AppMenuRecord {
  key: string;
  routeKey?: RouteKey;
  children?: AppMenuNode[];
}

export function transformMenuRecordsToNodes(records: AppMenuRecord[]): AppMenuNode[] {
  return records.map(record => ({
    ...record,
    key: record.routerName || record.id,
    routeKey: record.routerName
  }));
}

export function isMenuFolder(menuType?: AppMenuType | null) {
  return menuType === 'folder';
}
