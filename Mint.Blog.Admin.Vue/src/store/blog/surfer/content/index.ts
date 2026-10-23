import { computed, ref } from 'vue';
import { defineStore } from 'pinia';
import { SetupStoreId } from '@/enum';
import {
  fetchSurferBlogArticleDetail,
  fetchSurferBlogArticles,
  fetchSurferBlogSummary,
  type SurferBlogArticleCard,
  type SurferBlogArticleDetail,
  type SurferBlogSummary
} from '@/service/blog/surfer';

const defaultSummary: SurferBlogSummary = {
  siteTitle: 'Mint Blog',
  siteSubtitle: 'Fresh content, gentle reading',
  highlights: [],
  roadmap: []
};

const defaultArticleDetail: SurferBlogArticleDetail = {
  id: '',
  title: '',
  publishedAt: '',
  category: '',
  views: 0,
  paragraphs: [],
  panels: []
};

export const useSurferBlogContentStore = defineStore(`${SetupStoreId.App}-surfer-blog-content`, () => {
  const summary = ref<SurferBlogSummary>(defaultSummary);
  const articles = ref<SurferBlogArticleCard[]>([]);
  const articleDetail = ref<SurferBlogArticleDetail>(defaultArticleDetail);
  const loading = ref(false);
  const initialized = ref(false);

  const featuredArticles = computed(() => articles.value.slice(0, 2));

  async function loadSummary() {
    loading.value = true;
    const { data } = await fetchSurferBlogSummary();
    if (data) {
      summary.value = data;
    }
    loading.value = false;
  }

  async function loadArticles() {
    loading.value = true;
    const { data } = await fetchSurferBlogArticles();
    if (data) {
      articles.value = data;
    }
    loading.value = false;
  }

  async function loadArticleDetail(articleId: string) {
    loading.value = true;
    const { data } = await fetchSurferBlogArticleDetail(articleId);
    if (data) {
      articleDetail.value = data;
    }
    loading.value = false;
  }

  async function initHome() {
    if (initialized.value) {
      return;
    }

    await Promise.all([loadSummary(), loadArticles()]);
    initialized.value = true;
  }

  return {
    loading,
    initialized,
    summary,
    articles,
    featuredArticles,
    articleDetail,
    loadSummary,
    loadArticles,
    loadArticleDetail,
    initHome
  };
});
