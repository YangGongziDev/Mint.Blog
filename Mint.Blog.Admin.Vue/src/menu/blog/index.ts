import type { AppMenuRecord } from '@/menu/types';

export const blogMenus: AppMenuRecord[] = [
  { id: 'home', parentId: null, menuType: 'route', routerName: 'home', path: '/home', tableName: 'home', enabled: true, menuI18nKey: 'route.home', icon: 'mdi:monitor-dashboard', order: 1, permission: ['Search'] },
  { id: 'blog', parentId: null, menuType: 'folder', path: '/blog', tableName: '.', enabled: true, menuI18nKey: 'route.blog', icon: 'mdi:book-open-page-variant-outline', order: 2 },
  ...[
    ['article', 'mdi:file-document-edit-outline'],
    ['category', 'mdi:shape-outline'],
    ['tag', 'mdi:tag-multiple-outline'],
    ['tag-version', 'mdi:tag-clock-outline'],
    ['resource', 'mdi:compass-outline'],
    ['column', 'mdi:bookshelf'],
    ['comment', 'mdi:comment-text-multiple-outline'],
    ['friend', 'mdi:link-variant'],
    ['image', 'mdi:image-multiple-outline'],
    ['gallery', 'mdi:view-gallery-outline'],
    ['settings', 'mdi:cog-outline']
  ].map(([key, icon], index): AppMenuRecord => ({
    id: `blog_${key}`, parentId: 'blog', menuType: 'route', routerName: `blog_${key}`, path: `/blog/${key}`, tableName: `blog_${key}`, enabled: true, menuI18nKey: `route.blog_${key}`, icon, order: index + 1, permission: ['Search']
  }))
];
export const documentMenus: AppMenuRecord[] = [
  { id: 'document', parentId: null, menuType: 'folder', path: '/document', tableName: '.', enabled: true, menuI18nKey: 'route.document', icon: 'mdi:file-document-multiple-outline', order: 4 },
  ...['project', 'project-link', 'dotnet', 'postgresql', 'rustfs', 'vue', 'pinia', 'tailwindcss', 'antd'].map((key, index): AppMenuRecord => ({
    id: `document_${key}`, parentId: 'document', menuType: 'iframe', routerName: `document_${key}`, path: `/document/${key}`, tableName: `document_${key}`, enabled: true, menuI18nKey: `route.document_${key}`, icon: 'mdi:file-link-outline', order: index + 1, permission: ['Search']
  }))
];
