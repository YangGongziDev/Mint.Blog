import { ref } from 'vue';
import { defineStore } from 'pinia';
import { SetupStoreId } from '@/enum';
import {
  fetchSurferBlogArchives,
  fetchSurferBlogCategories,
  fetchSurferBlogSearchState,
  fetchSurferBlogTags,
  type SurferBlogArchiveItem,
  type SurferBlogCategoryItem,
  type SurferBlogSearchState,
  type SurferBlogTagItem
} from '@/service/blog/surfer';

const defaultSearchState: SurferBlogSearchState = {
  title: '搜索页骨架',
  desc: '',
  placeholderTitle: '',
  placeholderDesc: ''
};

export const useSurferBlogDiscoveryStore = defineStore(`${SetupStoreId.App}-surfer-blog-discovery`, () => {
  const categories = ref<SurferBlogCategoryItem[]>([]);
  const tags = ref<SurferBlogTagItem[]>([]);
  const archives = ref<SurferBlogArchiveItem[]>([]);
  const searchState = ref<SurferBlogSearchState>(defaultSearchState);
  const loading = ref(false);
  const initialized = ref(false);

  async function loadCategories() {
    loading.value = true;
    const { data } = await fetchSurferBlogCategories();
    if (data) {
      categories.value = data;
    }
    loading.value = false;
  }

  async function loadTags() {
    loading.value = true;
    const { data } = await fetchSurferBlogTags();
    if (data) {
      tags.value = data;
    }
    loading.value = false;
  }

  async function loadArchives() {
    loading.value = true;
    const { data } = await fetchSurferBlogArchives();
    if (data) {
      archives.value = data;
    }
    loading.value = false;
  }

  async function loadSearchState() {
    loading.value = true;
    const { data } = await fetchSurferBlogSearchState();
    if (data) {
      searchState.value = data;
    }
    loading.value = false;
  }

  async function initDiscovery() {
    if (initialized.value) {
      return;
    }

    await Promise.all([loadCategories(), loadTags(), loadArchives(), loadSearchState()]);
    initialized.value = true;
  }

  return {
    loading,
    initialized,
    categories,
    tags,
    archives,
    searchState,
    loadCategories,
    loadTags,
    loadArchives,
    loadSearchState,
    initDiscovery
  };
});
