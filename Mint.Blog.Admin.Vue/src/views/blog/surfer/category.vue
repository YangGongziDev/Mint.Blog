<template>
  <main class="mx-auto max-w-screen-2xl px-4 md:px-6 py-4">
    <div class="grid grid-cols-1 gap-7 lg:grid-cols-4">
      <div class="col-span-1 mt-0 mb-3 lg:col-span-3 lg:mt-2">
        <div
          class="sticky top-4 z-20 mb-3 w-full rounded-lg border border-[#3ecf9a]/14 bg-white/95 px-2.5 py-2.5 shadow-sm backdrop-blur-md dark:border-[#334155] dark:bg-[#2c333e]/95 lg:top-6"
        >
          <h2 class="mb-1 flex items-center font-bold text-[#0d3d2d] dark:text-white">
            <FolderOutlined class="mr-1 h-5 w-5 text-[#3ecf9a]" />
            分类
            <span v-if="allCategories.length > 0" class="ml-1 font-normal text-[#557468] dark:text-[#cbd5e1]">
              ( {{ allCategories.length }} )
            </span>
          </h2>
          <button
            class="category-toggle mb-2 flex w-full cursor-pointer items-center justify-between rounded-lg border border-[#3ecf9a]/14 bg-[#f0faf5]/70 px-3 py-1.5 text-sm font-semibold text-[#15956b] transition-colors hover:bg-[#3ecf9a]/12 dark:border-[#539dfd]/18 dark:bg-[#539dfd]/8 dark:text-[#8cc8ff] dark:hover:bg-[#539dfd]/14"
            @click="isMobileCategoryCollapsed = !isMobileCategoryCollapsed"
          >
            {{ isMobileCategoryCollapsed ? '展开筛选' : '收起筛选' }}
            <DownOutlined v-if="isMobileCategoryCollapsed" class="text-xs" />
            <UpOutlined v-else class="text-xs" />
          </button>
          <div
            class="category-list flex flex-wrap gap-x-1.5 gap-y-1.5 text-sm font-medium transition-[max-height] duration-300"
            :class="
              isMobileCategoryCollapsed
                ? 'max-h-[100px] overflow-y-auto overflow-x-hidden pr-1'
                : 'max-h-[180px] overflow-y-auto overflow-x-hidden pr-1'
            "
          >
            <button
              v-for="category in allCategories"
              :key="category.id"
              class="inline-flex cursor-pointer items-center rounded-xl border px-1.75 py-0.75 text-center text-sm font-medium transition-all duration-300"
              :class="[
                route.query.name === category.name
                  ? 'border-transparent bg-gradient-to-r from-[#3ecf9a] to-[#3ecf9a] text-white shadow-md dark:border-[#539dfd]/30 dark:bg-none dark:bg-[#539dfd]/10 dark:text-[#539dfd] dark:shadow-none'
                  : 'border-gray-200 text-[#557468] hover:bg-gray-100 dark:border-[#334155] dark:text-[#cbd5e1] dark:hover:bg-white/5'
              ]"
              @click="goCategoryPage(category.id, category.name)"
            >
              {{ category.name }}
              <span
                class="ms-1 inline-flex h-5 w-5 shrink-0 items-center justify-center rounded-full text-xs font-semibold tabular-nums"
                :class="[
                  route.query.name === category.name
                    ? 'bg-[#15956b] text-white dark:bg-[#539dfd] dark:text-white'
                    : 'bg-[#3ecf9a]/12 text-[#15956b] dark:bg-[#539dfd]/10 dark:text-[#539dfd]'
                ]"
              >
                {{ category.articlesTotal ?? 0 }}
              </span>
            </button>
          </div>
          <button
            v-if="allCategories.length > 8"
            class="category-more-toggle mt-2 hidden w-full cursor-pointer items-center justify-center gap-1 rounded-lg border border-[#3ecf9a]/14 bg-[#f0faf5]/70 py-1 text-sm font-semibold text-[#15956b] transition-colors hover:bg-[#3ecf9a]/12 dark:border-[#539dfd]/18 dark:bg-[#539dfd]/8 dark:text-[#8cc8ff] dark:hover:bg-[#539dfd]/14 lg:flex"
            @click="isMobileCategoryCollapsed = !isMobileCategoryCollapsed"
          >
            {{ isMobileCategoryCollapsed ? `展开全部分类（${allCategories.length}）` : '收起分类' }}
            <DownOutlined v-if="isMobileCategoryCollapsed" class="text-xs" />
            <UpOutlined v-else class="text-xs" />
          </button>
        </div>

        <div
          class="p-5 mb-4 rounded-lg border border-[#3ecf9a]/14 bg-white/84 dark:border-[#334155] dark:bg-[#2c333e]/72"
        >
          <div v-if="loading" class="space-y-3">
            <div v-for="i in 4" :key="i" class="flex items-center gap-3 p-3 animate-pulse">
              <div class="h-12 w-24 rounded-lg bg-[#15956b]/8 dark:bg-[#539dfd]/10"></div>
              <div class="flex-1 space-y-2">
                <div class="h-4 w-3/4 rounded bg-gray-200 dark:bg-white/5"></div>
                <div class="h-3 w-1/3 rounded bg-gray-200 dark:bg-white/5"></div>
              </div>
            </div>
          </div>
          <div v-else-if="!articles.length" class="flex flex-col items-center justify-center py-16">
            <div class="text-6xl font-black text-[#3ecf9a]/20">📭</div>
            <p class="mt-4 mb-2 text-[#557468] dark:text-[#cbd5e1]">此分类下还未发布文章哟~</p>
          </div>
          <ol v-else class="divide-y divide-gray-100 dark:divide-white/5">
            <li v-for="article in articles" :key="article.id" class="rounded-lg bg-transparent dark:bg-transparent">
              <button
                class="flex w-full items-center p-3 text-left rounded-lg bg-transparent hover:bg-[#f0faf5] dark:bg-transparent dark:hover:bg-white/5 transition-colors cursor-pointer"
                @click="goArticleDetailPage(article.id)"
              >
                <img
                  v-if="article.cover"
                  class="w-24 h-12 mb-0 mr-3 rounded-lg object-cover shrink-0"
                  :src="article.cover"
                />
                <div
                  v-else
                  class="w-24 h-12 mb-0 mr-3 rounded-lg shrink-0 bg-[#15956b]/8 dark:bg-[#539dfd]/10 flex items-center justify-center text-[#3ecf9a]/40 text-lg font-bold"
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

      <div class="col-span-1 mt-0 mb-3 lg:mt-2">
        <SurferSidebar hide-categories />
      </div>
    </div>
  </main>
</template>

<script setup lang="ts">
import { computed, onMounted, ref, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { CalendarOutlined, DownOutlined, FolderOutlined, UpOutlined } from '@ant-design/icons-vue';
import { getCategoryArticlePageList, getCategoryList } from '@/service/blog/surfer/category';
import SurferSidebar from '@/components/blog/surfer/sidebar-right.vue';

defineOptions({ name: 'SurferCategoryPage' });

type Api<T> = { success: boolean; data: T };
type CategoryItem = { id: number; name: string; articlesTotal: number; sort?: number };
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

const allCategories = ref<CategoryItem[]>([]);
const articles = ref<ArticleItem[]>([]);
const categoryName = ref((route.query.name as string) || '');
const categoryId = ref((route.query.id as string) || '');
const current = computed(() => {
  const q = route.query.page;
  const n = Number(q);
  return Number.isFinite(n) && n > 0 ? n : 1;
});
const size = ref(10);
const total = ref(0);
const pages = ref(0);
const loading = ref(false);
const isMobileCategoryCollapsed = ref(true);

function getCategoryArticles(pageNo: number) {
  if (pageNo < 1 || (pages.value > 0 && pageNo > pages.value)) return;
  loading.value = true;
  articles.value = [];
  getCategoryArticlePageList<PageResult>({
    current: pageNo,
    size: size.value,
    id: categoryId.value,
    categoryId: categoryId.value
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
function goCategoryPage(id: number, name: string) {
  isMobileCategoryCollapsed.value = true;
  router.push({ path: '/blog/surfer/category', query: { id: String(id), name } });
}
function goPage(page: number) {
  router.replace({ query: { ...route.query, page: page > 1 ? String(page) : undefined } });
}

const byArticles = <T extends { id: number; articlesTotal?: number }>(list: T[]) =>
  [...list].sort((a, b) => (b.articlesTotal || 0) - (a.articlesTotal || 0) || a.id - b.id);

watch(route, newRoute => {
  categoryName.value = (newRoute.query.name as string) || '';
  categoryId.value = (newRoute.query.id as string) || '';
  getCategoryArticles(current.value);
});

onMounted(async () => {
  try {
    const cats = await getCategoryList<Api<CategoryItem[]>>();
    if (cats.success && cats.data?.length) {
      const sorted = byArticles(cats.data.filter(category => category.articlesTotal > 0));
      allCategories.value = sorted;
      if (!categoryId.value && sorted.length > 0) {
        const first = sorted[0];
        await router.replace({ path: '/blog/surfer/category', query: { id: String(first.id), name: first.name } });
        categoryId.value = String(first.id);
        categoryName.value = first.name;
      }
    }
  } catch {
    allCategories.value = [];
  }
  getCategoryArticles(current.value);
});
</script>

<style scoped lang="scss">
:global(html.dark) :deep(ol > li),
:global(html.dark) :deep(ol > li > button) {
  background-color: transparent !important;
}

:global(html.dark) :deep(ol > li > button:hover) {
  background-color: rgb(255 255 255 / 5%) !important;
}

:global(html.dark) :deep(.ant-pagination .ant-pagination-item),
:global(html.dark) :deep(.ant-pagination .ant-pagination-prev .ant-pagination-item-link),
:global(html.dark) :deep(.ant-pagination .ant-pagination-next .ant-pagination-item-link) {
  border-color: rgb(51 65 85);
  background-color: rgb(44 51 62 / 72%);
}

:global(html.dark) :deep(.ant-pagination .ant-pagination-item a),
:global(html.dark) :deep(.ant-pagination .ant-pagination-prev .ant-pagination-item-link),
:global(html.dark) :deep(.ant-pagination .ant-pagination-next .ant-pagination-item-link) {
  color: rgb(203 213 225);
}

:global(html.dark) :deep(.ant-pagination .ant-pagination-item-active) {
  border-color: #539dfd;
  background-color: rgb(83 157 253 / 12%);
}

:global(html.dark) :deep(.ant-pagination .ant-pagination-item-active a) {
  color: #8cc8ff;
}

:global(html.dark) :deep(.ant-pagination .ant-pagination-disabled .ant-pagination-item-link) {
  color: rgb(100 116 139);
}

.category-toggle {
  display: none;
}

@media (max-width: 640px) {
  .category-toggle {
    display: flex;
  }

  .category-list.max-h-\[100px\] {
    display: none;
  }

  .category-more-toggle {
    display: none;
  }
}
</style>
