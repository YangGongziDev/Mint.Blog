import type { RouteRecordRaw } from 'vue-router';
import { getBlogWebUrl } from '@/utils/blog-web-url';

const documents = [
  ['project', getBlogWebUrl('column', '1')],
  ['project-link', getBlogWebUrl('column', '1')],
  ['dotnet', 'https://c.biancheng.net/csharp/'],
  ['postgresql', 'https://neon.com/postgresql/tutorial'],
  ['rustfs', 'https://docs.rustfs.com/installation/'],
  ['vue', 'https://www.vueframework.com/docs/v3/cn/guide/introduction.html'],
  ['pinia', 'https://pinia.vuejs.org/zh/introduction.html'],
  ['tailwindcss', 'https://www.tailwindcss.cn/docs/installation'],
  ['antd', 'https://antdv.com/components/overview-cn']
] as const;

export const documentRoutes: RouteRecordRaw[] = documents.map(([key, url]) => ({
  path: `/document/${key}`,
  name: `document_${key}`,
  component: () => import('@/components/system/iframe-page.vue'),
  props: { url },
  meta: { title: `document_${key}`, i18nKey: `route.document_${key}` as App.I18n.I18nKey, public: true, hideInMenu: true }
}));
