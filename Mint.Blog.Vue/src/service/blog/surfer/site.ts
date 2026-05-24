import axios from '../../axios';

export interface SurferBlogAboutCard {
  title: string;
  desc: string;
}

export interface SurferBlogAboutState {
  title: string;
  desc: string;
  cards: SurferBlogAboutCard[];
}

export interface SurferBlogMessageItem {
  name: string;
  date: string;
  content: string;
}

const mockAboutState: SurferBlogAboutState = {
  title: '关于页骨架',
  desc: '后续这里可以展示站点作者简介、项目背景、技术栈、内容方向、联系方式以及个人作品链接。',
  cards: [
    { title: '作者介绍', desc: '开发背景、关注方向与内容沉淀方式。' },
    { title: '站点定位', desc: '博客系统、知识整理、工程实践与技术记录。' },
    { title: '技术栈', desc: '后端 .NET + 前端 Vue + PostgreSQL。' },
    { title: '联系信息', desc: '后续可展示邮箱、站点、仓库与社交链接。' }
  ]
};

const mockMessages: SurferBlogMessageItem[] = [
  { name: 'Visitor A', date: '2026-04-20', content: '这里将来展示公开留言和站长回复。' },
  { name: 'Visitor B', date: '2026-04-18', content: '后续可扩展分页、回复线程和审核状态。' }
];

export async function fetchSurferBlogAboutState() {
  const { VITE_SERVICE_BASE_URL } = import.meta.env;

  if (!VITE_SERVICE_BASE_URL) {
    return { data: mockAboutState, error: null };
  }

  try {
    const data = (await axios.post('/blog/surfer/blog/about')) as SurferBlogAboutState;
    return { data, error: null };
  } catch {
    return { data: mockAboutState, error: null };
  }
}

export async function fetchSurferBlogMessages() {
  const { VITE_SERVICE_BASE_URL } = import.meta.env;

  if (!VITE_SERVICE_BASE_URL) {
    return { data: mockMessages, error: null };
  }

  try {
    const data = (await axios.post('/blog/surfer/message/list')) as SurferBlogMessageItem[];
    return { data, error: null };
  } catch {
    return { data: mockMessages, error: null };
  }
}
