<template>
  <main class="mx-auto max-w-screen-2xl px-4 md:px-6 py-4">
    <div class="grid grid-cols-1 gap-7 lg:grid-cols-4">
      <div class="col-span-1 mt-0 mb-3 lg:col-span-3 lg:mt-2">
        <div
          class="sticky top-4 z-20 mb-3 w-full rounded-lg border border-[#3ecf9a]/14 bg-white/95 px-2.5 py-2.5 shadow-sm backdrop-blur-md dark:border-[#334155] dark:bg-[#2c333e]/95 lg:top-6"
        >
          <h2 class="mb-1 flex items-center font-bold text-[#0d3d2d] dark:text-white">
            <CalendarOutlined class="mr-1 h-5 w-5 text-[#3ecf9a]" />
            归档
            <span v-if="availableYears.length" class="ml-1 font-normal text-[#557468] dark:text-[#cbd5e1]">
              ( {{ availableYears.length }} )
            </span>
          </h2>

          <button
            class="archive-toggle mb-2 flex w-full cursor-pointer items-center justify-between rounded-lg border border-[#3ecf9a]/14 bg-[#f0faf5]/70 px-3 py-1.5 text-sm font-semibold text-[#15956b] transition-colors hover:bg-[#3ecf9a]/12 dark:border-[#539dfd]/18 dark:bg-[#539dfd]/8 dark:text-[#8cc8ff] dark:hover:bg-[#539dfd]/14"
            @click="isYearCollapsed = !isYearCollapsed"
          >
            {{ isYearCollapsed ? '展开筛选' : '收起筛选' }}
            <DownOutlined v-if="isYearCollapsed" class="text-xs" />
            <UpOutlined v-else class="text-xs" />
          </button>
          <div
            v-if="availableYears.length"
            class="archive-list flex flex-wrap gap-x-1.5 gap-y-1.5 text-sm font-medium transition-[max-height] duration-300"
            :class="
              isYearCollapsed
                ? 'max-h-[100px] overflow-y-auto overflow-x-hidden pr-1'
                : 'max-h-[180px] overflow-y-auto overflow-x-hidden pr-1'
            "
          >
            <button
              class="inline-flex cursor-pointer items-center rounded-xl border px-1.75 py-0.75 text-sm font-medium transition-all duration-300"
              :class="[
                !selectedYear
                  ? 'border-transparent bg-[#3ecf9a] text-white shadow-md dark:border-[#539dfd]/30 dark:bg-[#539dfd]/10 dark:text-[#539dfd] dark:shadow-none'
                  : 'border-gray-200 text-[#557468] hover:bg-gray-100 dark:border-[#334155] dark:text-[#cbd5e1] dark:hover:bg-white/5'
              ]"
              @click="selectYear('')"
            >
              全部
            </button>
            <button
              v-for="item in availableYears"
              :key="item.year"
              class="inline-flex cursor-pointer items-center rounded-xl border px-1.75 py-0.75 text-sm font-medium transition-all duration-300"
              :class="[
                selectedYear === String(item.year)
                  ? 'border-transparent bg-[#3ecf9a] text-white shadow-md dark:border-[#539dfd]/30 dark:bg-[#539dfd]/10 dark:text-[#539dfd] dark:shadow-none'
                  : 'border-gray-200 text-[#557468] hover:bg-gray-100 dark:border-[#334155] dark:text-[#cbd5e1] dark:hover:bg-white/5'
              ]"
              @click="selectYear(item.year)"
            >
              {{ item.year }} 年
              <span
                class="ml-1 inline-flex h-5 w-5 shrink-0 items-center justify-center rounded-full text-xs font-semibold tabular-nums"
                :class="[
                  selectedYear === String(item.year)
                    ? 'bg-[#15956b] text-white dark:bg-[#539dfd]'
                    : 'bg-[#3ecf9a]/12 text-[#15956b] dark:bg-[#539dfd]/10 dark:text-[#539dfd]'
                ]"
              >
                {{ item.articlesTotal }}
              </span>
            </button>
          </div>

          <button
            v-if="availableYears.length > 8"
            class="archive-more-toggle mt-2 hidden w-full cursor-pointer items-center justify-center gap-1 rounded-lg border border-[#3ecf9a]/14 bg-[#f0faf5]/70 py-1 text-sm font-semibold text-[#15956b] transition-colors hover:bg-[#3ecf9a]/12 dark:border-[#539dfd]/18 dark:bg-[#539dfd]/8 dark:text-[#8cc8ff] dark:hover:bg-[#539dfd]/14 lg:flex"
            @click="isYearCollapsed = !isYearCollapsed"
          >
            {{ isYearCollapsed ? `展开全部年份（${availableYears.length}）` : '收起年份' }}
            <DownOutlined v-if="isYearCollapsed" class="text-xs" />
            <UpOutlined v-else class="text-xs" />
          </button>
        </div>

        <div
          class="p-5 mb-4 rounded-lg border border-[#3ecf9a]/14 bg-white/84 dark:border-[#334155] dark:bg-[#2c333e]/72"
        >
          <div v-if="loading" class="space-y-5">
            <div v-for="i in 3" :key="i" class="animate-pulse">
              <div class="mb-3 h-5 w-24 rounded bg-[#15956b]/8 dark:bg-[#539dfd]/10"></div>
              <div v-for="j in 2" :key="j" class="mb-2 flex items-center gap-3 p-3">
                <div class="h-12 w-24 rounded-lg bg-[#15956b]/8 dark:bg-[#539dfd]/10"></div>
                <div class="flex-1 space-y-2">
                  <div class="h-4 w-3/4 rounded bg-gray-200 dark:bg-white/5"></div>
                  <div class="h-3 w-1/3 rounded bg-gray-200 dark:bg-white/5"></div>
                </div>
              </div>
            </div>
          </div>

          <div v-else-if="!archives.length" class="flex flex-col items-center justify-center py-16">
            <div class="text-6xl font-black text-[#3ecf9a]/20">—</div>
            <p class="mt-4 mb-2 text-[#557468] dark:text-[#cbd5e1]">
              {{ selectedYear ? `${selectedYear} 年还未发布文章哟~` : '还未发布文章哟~' }}
            </p>
          </div>

          <div v-else class="relative pl-5 sm:pl-7">
            <div
              class="absolute bottom-2 left-[7px] top-2 w-px bg-[#3ecf9a]/20 dark:bg-[#539dfd]/20 sm:left-[11px]"
            ></div>
            <section v-for="archive in archives" :key="archive.month" class="relative mb-7 last:mb-0">
              <div
                class="absolute -left-[19px] top-1.5 h-3 w-3 rounded-full border-2 border-white bg-[#3ecf9a] shadow-[0_0_0_4px_rgba(62,207,154,0.12)] dark:border-[#2c333e] dark:bg-[#539dfd] sm:-left-[23px]"
              ></div>
              <h3 class="mb-3 text-lg font-bold text-[#0d3d2d] dark:text-white">{{ archive.month }}</h3>
              <ol class="divide-y divide-gray-100 dark:divide-white/5">
                <li v-for="article in archive.articles" :key="article.id">
                  <button
                    class="flex w-full cursor-pointer items-center rounded-lg bg-transparent p-3 text-left transition-colors hover:bg-[#f0faf5] dark:bg-transparent dark:hover:bg-white/5"
                    @click="goArticle(article.id)"
                  >
                    <img
                      v-if="article.cover"
                      class="w-24 h-12 mb-0 mr-3 rounded-lg object-cover shrink-0"
                      :src="article.cover"
                      :alt="article.title"
                    />
                    <div
                      v-else
                      class="w-24 h-12 mb-0 mr-3 rounded-lg shrink-0 bg-[#15956b]/8 dark:bg-[#539dfd]/10 flex items-center justify-center text-[#3ecf9a]/40 text-lg font-bold"
                    >
                      M
                    </div>
                    <div class="min-w-0">
                      <h2 class="line-clamp-1 text-base font-medium text-[#0d3d2d] dark:text-white">
                        {{ article.title }}
                      </h2>
                      <span class="mt-1 inline-flex items-center text-xs text-[#557468] dark:text-[#cbd5e1]">
                        <CalendarOutlined class="mr-2 h-2.5 w-2.5" />
                        {{ article.createDate }}
                      </span>
                    </div>
                  </button>
                </li>
              </ol>
            </section>
          </div>
        </div>

        <div v-if="pages > 1" class="flex justify-center pt-4">
          <APagination
            :current="current"
            :page-size="size"
            :total="total"
            :show-size-changer="false"
            @change="goPage"
          />
        </div>
      </div>

      <div class="archive-sidebar col-span-1 mt-0 mb-3 lg:mt-2">
        <SurferSidebar />
      </div>
    </div>
  </main>
</template>

<script setup lang="ts">
import { computed, onMounted, ref, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { CalendarOutlined, DownOutlined, UpOutlined } from '@ant-design/icons-vue';
import { getArchivePageList, getArchiveYears } from '@/service/blog/surfer/archive';
import SurferSidebar from '@/components/blog/surfer/sidebar-right.vue';

defineOptions({ name: 'SurferArchivePage' });

type Api<T> = { success: boolean; data: T };
type ArticleItem = { id: number; title: string; cover?: string; createDate?: string };
type ArchiveMonth = { month: string; articles: ArticleItem[] };
type ArchiveYear = { year: number; articlesTotal: number };
type PageResult = {
  success: boolean;
  data: ArchiveMonth[];
  current: number;
  size: number;
  total: number;
  pages: number;
};

const route = useRoute();
const router = useRouter();
const archives = ref<ArchiveMonth[]>([]);
const selectedYear = ref((route.query.year as string) || '');
const availableYears = ref<ArchiveYear[]>([]);
const current = computed(() => {
  const page = Number(route.query.page);
  return Number.isFinite(page) && page > 0 ? page : 1;
});
const size = ref(20);
const total = ref(0);
const pages = ref(0);
const loading = ref(false);
const isYearCollapsed = ref(true);

function getArchives(pageNo: number) {
  if (pageNo < 1 || (pages.value > 0 && pageNo > pages.value)) return;

  loading.value = true;
  archives.value = [];
  getArchivePageList<PageResult>({
    current: pageNo,
    size: size.value,
    year: selectedYear.value
  })
    .then(res => {
      if (res.success) {
        archives.value = res.data || [];
        size.value = res.size;
        total.value = res.total;
        pages.value = res.pages;
      }
    })
    .catch(() => {
      archives.value = [];
      total.value = 0;
      pages.value = 0;
    })
    .finally(() => {
      loading.value = false;
    });
}

function selectYear(year: number | '') {
  isYearCollapsed.value = true;
  router.push({
    path: '/blog/surfer/archive',
    query: { year: year ? String(year) : undefined }
  });
}

function goArticle(articleId: number) {
  router.push(`/blog/surfer/article/${articleId}`);
}

function goPage(page: number) {
  router.replace({ query: { ...route.query, page: page > 1 ? String(page) : undefined } });
}

watch(
  () => [route.query.year, route.query.page],
  () => {
    selectedYear.value = (route.query.year as string) || '';
    getArchives(current.value);
  }
);

onMounted(async () => {
  try {
    const res = await getArchiveYears<Api<ArchiveYear[]>>();
    if (res.success) availableYears.value = [...(res.data || [])].sort((a, b) => b.year - a.year);
  } catch {
    availableYears.value = [];
  }

  getArchives(current.value);
});
</script>

<style scoped lang="scss">
@media (min-width: 1024px) {
  .archive-sidebar :deep(aside) {
    top: 20px;
  }
}

.archive-toggle {
  display: none;
}

@media (max-width: 640px) {
  .archive-toggle {
    display: flex;
  }

  .archive-list.max-h-\[100px\] {
    display: none;
  }

  .archive-list.max-h-\[180px\] {
    overflow-y: auto;
  }

  .archive-sidebar :deep(aside) {
    top: 0;
  }
}

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
</style>
