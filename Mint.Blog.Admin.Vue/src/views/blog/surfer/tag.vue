<template>
  <main class="mx-auto max-w-screen-2xl px-4 md:px-6 py-4">
    <div class="grid grid-cols-1 gap-7 lg:grid-cols-4">
      <div class="col-span-1 mt-0 mb-3 lg:col-span-3 lg:mt-2">
        <div
          v-if="allTags.length > 0"
          class="sticky top-4 z-20 mb-3 w-full rounded-lg border border-[#3ecf9a]/14 bg-white/95 px-2.5 py-2.5 shadow-sm backdrop-blur-md dark:border-[#334155] dark:bg-[#2c333e]/95 lg:top-6"
        >
          <h2 class="mb-1 flex items-center font-bold text-[#0d3d2d] dark:text-white">
            <TagOutlined class="mr-1 h-5 w-5 text-[#3ecf9a]" />
            标签
            <span class="ml-1 font-normal text-[#557468] dark:text-[#cbd5e1]">( {{ allTags.length }} )</span>
          </h2>
          <button
            class="tag-toggle mb-2 flex w-full cursor-pointer items-center justify-between rounded-lg border border-[#3ecf9a]/14 bg-[#f0faf5]/70 px-3 py-1.5 text-sm font-semibold text-[#15956b] transition-colors hover:bg-[#3ecf9a]/12 dark:border-[#539dfd]/18 dark:bg-[#539dfd]/8 dark:text-[#8cc8ff] dark:hover:bg-[#539dfd]/14"
            @click="isMobileTagCollapsed = !isMobileTagCollapsed"
          >
            {{ isMobileTagCollapsed ? '展开筛选' : '收起筛选' }}
            <DownOutlined v-if="isMobileTagCollapsed" class="text-xs" />
            <UpOutlined v-else class="text-xs" />
          </button>
          <div
            class="tag-list flex flex-wrap gap-x-1.5 gap-y-1.5 text-sm font-medium transition-[max-height] duration-300"
            :class="
              isMobileTagCollapsed
                ? 'max-h-[100px] overflow-y-auto overflow-x-hidden pr-1'
                : 'max-h-[180px] overflow-y-auto overflow-x-hidden pr-1'
            "
          >
            <button
              v-for="tag in allTags"
              :key="tag.id"
              class="tag-pill inline-flex cursor-pointer items-center rounded-xl border px-1.75 py-0.75 text-center text-sm font-medium transition-all duration-300"
              :class="[
                route.query.name === tag.name
                  ? 'active border-transparent bg-gradient-to-r from-[#3ecf9a] to-[#3ecf9a] text-white shadow-md dark:border-[#539dfd]/30 dark:bg-none dark:bg-[#539dfd]/10 dark:text-[#539dfd] dark:shadow-none'
                  : 'border-gray-200 text-[#557468] hover:border-[#3ecf9a]/30 hover:text-[#15956b] hover:-translate-y-0.5 hover:shadow-sm dark:border-[#334155] dark:text-[#cbd5e1] dark:hover:bg-white/5'
              ]"
              @click="goTagPage(tag.id, tag.name)"
            >
              #&nbsp;{{ tag.name }}
              <span
                class="ml-1 inline-flex h-5 w-5 shrink-0 items-center justify-center rounded-full text-xs font-semibold tabular-nums"
                :class="[
                  route.query.name === tag.name
                    ? 'bg-[#15956b] text-white dark:bg-[#539dfd] dark:text-white'
                    : 'bg-[#3ecf9a]/12 text-[#15956b] dark:bg-[#539dfd]/10 dark:text-[#539dfd]'
                ]"
              >
                {{ tag.articlesTotal ?? 0 }}
              </span>
            </button>
          </div>
          <button
            v-if="allTags.length > 8"
            class="tag-more-toggle mt-2 hidden w-full cursor-pointer items-center justify-center gap-1 rounded-lg border border-[#3ecf9a]/14 bg-[#f0faf5]/70 py-1 text-sm font-semibold text-[#15956b] transition-colors hover:bg-[#3ecf9a]/12 dark:border-[#539dfd]/18 dark:bg-[#539dfd]/8 dark:text-[#8cc8ff] dark:hover:bg-[#539dfd]/14 lg:flex"
            @click="isMobileTagCollapsed = !isMobileTagCollapsed"
          >
            {{ isMobileTagCollapsed ? `展开全部标签（${allTags.length}）` : '收起标签' }}
            <DownOutlined v-if="isMobileTagCollapsed" class="text-xs" />
            <UpOutlined v-else class="text-xs" />
          </button>
        </div>

        <div
          class="p-5 mb-4 rounded-lg border border-[#3ecf9a]/14 bg-white/84 dark:border-[#334155] dark:bg-[#2c333e]/72"
        >
          <div v-if="loading" class="space-y-3">
            <div v-for="i in 4" :key="i" class="flex items-center gap-3 p-3 animate-pulse">
              <div class="h-12 w-24 rounded-lg bg-[#15956b]/8 dark:bg-white/5"></div>
              <div class="flex-1 space-y-2">
                <div class="h-4 w-3/4 rounded bg-gray-200 dark:bg-white/5"></div>
                <div class="h-3 w-1/3 rounded bg-gray-200 dark:bg-white/5"></div>
              </div>
            </div>
          </div>
          <div v-else-if="!articles.length" class="flex flex-col items-center justify-center py-16">
            <div class="text-6xl font-black text-[#3ecf9a]/20">📭</div>
            <p class="mt-4 mb-2 text-[#557468] dark:text-[#cbd5e1]">此标签下还未发布文章哟~</p>
          </div>
          <ol v-else class="divide-y divide-gray-100 dark:divide-white/5">
            <li v-for="article in articles" :key="article.id">
              <button
                class="flex w-full items-center p-3 text-left rounded-lg hover:bg-[#f0faf5] dark:hover:bg-white/5 transition-colors cursor-pointer"
                @click="goArticleDetailPage(article.id)"
              >
                <img
                  v-if="article.cover"
                  class="w-24 h-12 mb-0 mr-3 rounded-lg object-cover shrink-0"
                  :src="article.cover"
                />
                <div
                  v-else
                  class="w-24 h-12 mb-0 mr-3 rounded-lg shrink-0 bg-[#15956b]/8 flex items-center justify-center text-[#3ecf9a]/40 text-lg font-bold"
                >
                  M
                </div>
                <div class="min-w-0">
                  <h2 class="text-base font-medium text-[#0d3d2d] dark:text-white line-clamp-1">
                    {{ article.title }}
                  </h2>
                  <span class="inline-flex items-center text-xs mt-1 text-[#557468] dark:text-[#cbd5e1]">
                    <CalendarOutlined class="w-2.5 h-2.5 mr-2" />
                    {{ article.createDate }}
                  </span>
                </div>
              </button>
            </li>
          </ol>
        </div>

        <div v-if="pages > 0" class="flex justify-center pt-4">
          <APagination
            :current="current"
            :page-size="size"
            :total="total"
            :show-size-changer="false"
            @change="goPage"
          />
        </div>
      </div>

      <div class="tag-sidebar col-span-1 mt-0 mb-3 lg:mt-2">
        <SurferSidebar hide-tags />
      </div>
    </div>
  </main>
</template>

<script setup lang="ts">
import { computed, onMounted, ref, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { CalendarOutlined, DownOutlined, TagOutlined, UpOutlined } from '@ant-design/icons-vue';
import { getTagArticlePageList, getTagList } from '@/service/blog/surfer/tag';
import SurferSidebar from '@/components/blog/surfer/sidebar-right.vue';

defineOptions({ name: 'SurferTagPage' });

type Api<T> = { success: boolean; data: T };
type TagItem = { id: number; name: string; articlesTotal: number; sort?: number };
type ArticleItem = { id: number; title: string; cover?: string; createDate?: string };
type PageResult = {
  success: boolean;
  data: ArticleItem[];
  current: number;
  size: number;
  total: number;
  pages: number;
};

const route = useRoute();
const router = useRouter();

const allTags = ref<TagItem[]>([]);
const articles = ref<ArticleItem[]>([]);
const tagName = ref((route.query.name as string) || '');
const tagId = ref((route.query.id as string) || '');
const current = computed(() => {
  const q = route.query.page;
  const n = Number(q);
  return Number.isFinite(n) && n > 0 ? n : 1;
});
const size = ref(10);
const total = ref(0);
const pages = ref(0);
const loading = ref(false);
const isMobileTagCollapsed = ref(true);

function getTagArticles(pageNo: number) {
  if (pageNo < 1 || (pages.value > 0 && pageNo > pages.value)) return;
  loading.value = true;
  articles.value = [];
  getTagArticlePageList<PageResult>({
    current: pageNo,
    size: size.value,
    id: tagId.value,
    tagId: tagId.value
  })
    .then(res => {
      if (res.success) {
        articles.value = res.data;
        size.value = res.size;
        total.value = res.total;
        pages.value = res.pages;
      }
    })
    .catch(() => {
      articles.value = [];
      total.value = 0;
      pages.value = 0;
    })
    .finally(() => {
      loading.value = false;
    });
}

function goArticleDetailPage(articleId: number) {
  router.push(`/blog/surfer/article/${articleId}`);
}
function goTagPage(id: number, name: string) {
  isMobileTagCollapsed.value = true;
  router.push({ path: '/blog/surfer/tag', query: { id: String(id), name } });
}
function goPage(page: number) {
  router.replace({ query: { ...route.query, page: page > 1 ? String(page) : undefined } });
}

const byArticles = <T extends { id: number; articlesTotal?: number }>(list: T[]) =>
  [...list].sort((a, b) => (b.articlesTotal || 0) - (a.articlesTotal || 0) || a.id - b.id);

watch(route, newRoute => {
  tagName.value = (newRoute.query.name as string) || '';
  tagId.value = (newRoute.query.id as string) || '';
  getTagArticles(current.value);
});

onMounted(async () => {
  try {
    const tags = await getTagList<Api<TagItem[]>>();
    if (tags.success && tags.data?.length) {
      const sorted = byArticles(tags.data.filter(tag => tag.articlesTotal > 0));
      allTags.value = sorted;
      if (!tagId.value && sorted.length > 0) {
        const first = sorted[0];
        await router.replace({ path: '/blog/surfer/tag', query: { id: String(first.id), name: first.name } });
        tagId.value = String(first.id);
        tagName.value = first.name;
      }
    }
  } catch {
    allTags.value = [];
  }
  getTagArticles(current.value);
});
</script>

<style scoped lang="scss">
@media (min-width: 1024px) {
  .tag-sidebar :deep(aside) {
    top: 0.5rem;
  }
}

.tag-toggle {
  display: none;
}

@media (max-width: 640px) {
  .tag-toggle {
    display: flex;
  }

  .tag-list.max-h-\[100px\] {
    display: none;
  }

  .tag-list.max-h-\[180px\] {
    overflow-y: auto;
  }

  .tag-sidebar :deep(aside) {
    top: 0;
  }
}
</style>
