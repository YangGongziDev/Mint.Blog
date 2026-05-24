import axios from '../../axios';

export interface SurferBlogCategoryItem {
  title: string;
  desc: string;
  count: string;
}

export interface SurferBlogTagItem {
  name: string;
  count: number;
}

export interface SurferBlogArchiveItem {
  date: string;
  summary: string;
}

export interface SurferBlogSearchState {
  title: string;
  desc: string;
  placeholderTitle: string;
  placeholderDesc: string;
}

const mockCategories: SurferBlogCategoryItem[] = [
  { title: '架构设计', desc: '系统划分、模块拆分、工程实践。', count: '12 篇文章' },
  { title: '后端开发', desc: '.NET、数据库、接口设计与性能优化。', count: '18 篇文章' },
  { title: '前端工程', desc: 'Vue、TypeScript、UI 与工程化。', count: '15 篇文章' },
  { title: '随笔记录', desc: '开发日志、思考记录与经验沉淀。', count: '9 篇文章' }
];

const mockTags: SurferBlogTagItem[] = [
  { name: 'Vue', count: 8 },
  { name: 'TypeScript', count: 10 },
  { name: '.NET', count: 12 },
  { name: 'PostgreSQL', count: 5 },
  { name: '架构', count: 7 },
  { name: '博客系统', count: 6 }
];

const mockArchives: SurferBlogArchiveItem[] = [
  { date: '2026 / 04', summary: '本月将来可展示文章归档列表与时间线。' },
  { date: '2026 / 03', summary: '这里可承接更早月份的文章索引。' },
  { date: '2026 / 02', summary: '归档页适合做时间维度的沉淀入口。' }
];

const mockSearchState: SurferBlogSearchState = {
  title: '搜索页骨架',
  desc: '后续这里会挂接全站搜索、关键字高亮、搜索建议以及文章结果列表。',
  placeholderTitle: 'Placeholder',
  placeholderDesc: '当前为搜索骨架页，后续接入真实搜索 API 后，可在这里显示搜索框、关键词推荐和搜索结果。'
};

export async function fetchSurferBlogCategories() {
  const { VITE_SERVICE_BASE_URL } = import.meta.env;

  if (!VITE_SERVICE_BASE_URL) {
    return { data: mockCategories, error: null };
  }

  try {
    const data = (await axios.get('/blog/surfer/category')) as SurferBlogCategoryItem[];
    return { data, error: null };
  } catch {
    return { data: mockCategories, error: null };
  }
}

export async function fetchSurferBlogTags() {
  const { VITE_SERVICE_BASE_URL } = import.meta.env;

  if (!VITE_SERVICE_BASE_URL) {
    return { data: mockTags, error: null };
  }

  try {
    const data = (await axios.get('/blog/surfer/tag')) as SurferBlogTagItem[];
    return { data, error: null };
  } catch {
    return { data: mockTags, error: null };
  }
}

export async function fetchSurferBlogArchives() {
  const { VITE_SERVICE_BASE_URL } = import.meta.env;

  if (!VITE_SERVICE_BASE_URL) {
    return { data: mockArchives, error: null };
  }

  try {
    const data = (await axios.get('/blog/surfer/archive')) as SurferBlogArchiveItem[];
    return { data, error: null };
  } catch {
    return { data: mockArchives, error: null };
  }
}

export async function fetchSurferBlogSearchState() {
  const { VITE_SERVICE_BASE_URL } = import.meta.env;

  if (!VITE_SERVICE_BASE_URL) {
    return { data: mockSearchState, error: null };
  }

  try {
    const data = (await axios.post('/blog/surfer/blog/search/state')) as SurferBlogSearchState;
    return { data, error: null };
  } catch {
    return { data: mockSearchState, error: null };
  }
}
