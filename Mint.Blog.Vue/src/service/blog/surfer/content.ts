import axios from '../../axios';

export interface SurferBlogSummary {
  siteTitle: string;
  siteSubtitle: string;
  highlights: string[];
  roadmap: { title: string; desc: string }[];
}

export interface SurferBlogArticleCard {
  id: string;
  meta: string;
  title: string;
  desc: string;
}

export interface SurferBlogArticleDetail {
  id: string;
  title: string;
  publishedAt: string;
  category: string;
  views: number;
  paragraphs: string[];
  panels: { title: string; desc: string }[];
}

const mockSummary: SurferBlogSummary = {
  siteTitle: 'Mint Blog',
  siteSubtitle: 'Fresh content, gentle reading',
  highlights: ['首页', '文章列表', '文章详情', '分类标签', '归档搜索'],
  roadmap: [
    { title: 'Home', desc: '站点简介、推荐文章、最近更新与公共导航。' },
    { title: 'Article', desc: '文章列表、详情、目录、评论与上下篇阅读。' },
    { title: 'Discover', desc: '分类、标签、归档、搜索与关于页面。' }
  ]
};

const mockArticles: SurferBlogArticleCard[] = [
  {
    id: 'mint-blog-architecture',
    meta: 'Vue / TypeScript / Architecture',
    title: '前台文章列表占位卡片 01',
    desc: '后续可在这里挂接真实文章分页数据、推荐权重、置顶逻辑与摘要展示。'
  },
  {
    id: 'mint-blog-backend',
    meta: 'Backend / .NET / PostgreSQL',
    title: '前台文章列表占位卡片 02',
    desc: '后续可对接搜索、分类过滤、标签过滤和归档过滤能力。'
  }
];

const mockArticleDetail: Record<string, SurferBlogArticleDetail> = {
  'mint-blog-architecture': {
    id: 'mint-blog-architecture',
    title: '文章详情页骨架，后续可承接 Markdown / 评论 / 目录 / 推荐阅读',
    publishedAt: '2026-04-20',
    category: '架构设计',
    views: 1024,
    paragraphs: [
      '这一页用于承接博客文章详情，包括标题、摘要、目录、正文内容、相关推荐、评论列表以及上下篇导航。',
      '当前先放占位内容，等后续 API 与文章渲染方案确认后，再接入真实的文章详情数据与评论接口。'
    ],
    panels: [
      { title: 'Markdown', desc: '后续接入文章正文渲染与代码高亮。' },
      { title: 'TOC', desc: '后续接入文章目录与滚动定位能力。' },
      { title: 'Comments', desc: '后续接入评论展示与回复能力。' }
    ]
  },
  'mint-blog-backend': {
    id: 'mint-blog-backend',
    title: '后端文章详情占位页，可继续接评论与推荐系统',
    publishedAt: '2026-04-18',
    category: '后端开发',
    views: 768,
    paragraphs: [
      '这里保留第二篇文章详情的占位数据，方便前台详情页在动态路由下先形成闭环。',
      '等真实博客 API 就绪后，可以直接替换 mock 数据来源，而不需要重构页面结构。'
    ],
    panels: [
      { title: 'API', desc: '后续接入文章详情 API 与缓存逻辑。' },
      { title: 'Recommend', desc: '后续接入相关推荐与上下篇导航。' },
      { title: 'Discuss', desc: '后续接入评论、点赞与互动功能。' }
    ]
  }
};

export async function fetchSurferBlogSummary() {
  const { VITE_SERVICE_BASE_URL } = import.meta.env;

  if (!VITE_SERVICE_BASE_URL) {
    return { data: mockSummary, error: null };
  }

  try {
    const data = (await axios.get('/blog/surfer/home')) as SurferBlogSummary;
    return { data, error: null };
  } catch {
    return { data: mockSummary, error: null };
  }
}

export async function fetchSurferBlogArticles() {
  const { VITE_SERVICE_BASE_URL } = import.meta.env;

  if (!VITE_SERVICE_BASE_URL) {
    return { data: mockArticles, error: null };
  }

  try {
    const data = (await axios.post('/blog/surfer/article/list')) as SurferBlogArticleCard[];
    return { data, error: null };
  } catch {
    return { data: mockArticles, error: null };
  }
}

export async function fetchSurferBlogArticleDetail(articleId: string) {
  const fallback = mockArticleDetail[articleId] || mockArticleDetail['mint-blog-architecture'];
  const { VITE_SERVICE_BASE_URL } = import.meta.env;

  if (!VITE_SERVICE_BASE_URL) {
    return { data: fallback, error: null };
  }

  try {
    const data = (await axios.get(`/blog/surfer/article/${articleId}`)) as SurferBlogArticleDetail;
    return { data, error: null };
  } catch {
    return { data: fallback, error: null };
  }
}
