import { ref } from 'vue';
import { defineStore } from 'pinia';
import { SetupStoreId } from '@/enum';
import {
  fetchSurferBlogAboutState,
  fetchSurferBlogMessages,
  type SurferBlogAboutState,
  type SurferBlogMessageItem
} from '@/service/blog/surfer';

const defaultAboutState: SurferBlogAboutState = {
  title: '关于页骨架',
  desc: '',
  cards: []
};

export const useSurferBlogSiteStore = defineStore(`${SetupStoreId.App}-surfer-blog-site`, () => {
  const aboutState = ref<SurferBlogAboutState>(defaultAboutState);
  const messages = ref<SurferBlogMessageItem[]>([]);
  const loading = ref(false);
  const initialized = ref(false);

  async function loadAboutState() {
    loading.value = true;
    const { data } = await fetchSurferBlogAboutState();
    if (data) {
      aboutState.value = data;
    }
    loading.value = false;
  }

  async function loadMessages() {
    loading.value = true;
    const { data } = await fetchSurferBlogMessages();
    if (data) {
      messages.value = data;
    }
    loading.value = false;
  }

  async function initSite() {
    if (initialized.value) {
      return;
    }

    await Promise.all([loadAboutState(), loadMessages()]);
    initialized.value = true;
  }

  return {
    loading,
    initialized,
    aboutState,
    messages,
    loadAboutState,
    loadMessages,
    initSite
  };
});
