<script setup lang="ts">
import { computed, onMounted, ref, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { CalendarOutlined } from '@ant-design/icons-vue';
import { getArchivePageList } from '@/service/blog/surfer/archive';
import SurferSidebar from '@/components/blog/surfer/sidebar-right.vue';

defineOptions({ name: 'SurferArchivePage' });

type ArticleItem = { id: number; title: string; cover?: string; createDate?: string };
type ArchiveMonth = { month: string; articles: ArticleItem[] };
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
const current = computed(() => {
  const q = route.query.page;
  const n = Number(q);
  return Number.isFinite(n) && n > 0 ? n : 1;
});
const size = ref(20);
const total = ref(0);
const pages = ref(0);
const loading = ref(true);

const selectedYear = ref('');
const availableYears = ref<number[]>([]);

function getArchives(pageNo: number) {
  if (pageNo < 1 || (pages.value > 0 && pageNo > pages.value)) return;
  loading.value = true;
  archives.value = [];
  const params: Record<string, unknown> = { current: pageNo, size: size.value };
  if (selectedYear.value) params.year = selectedYear.value;

  getArchivePageList<PageResult>(params)
    .then(res => {
      if (res.success) {
        archives.value = res.data || [];
        size.value = res.size;
        total.value = res.total;
        pages.value = res.pages;

        const years = new Set<number>();
        (res.data || []).forEach(m => {
          const y = Number.parseInt((m.month || '').slice(0, 4), 10);
          if (!Number.isNaN(y)) years.add(y);
        });
        availableYears.value = [...years].sort((a, b) => b - a);
        if (!selectedYear.value && availableYears.value.length > 0) {
          selectedYear.value = String(availableYears.value[0]);
        }
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

function goArticle(id: number) {
  router.push(`/blog/surfer/article/${id}`);
}
function goPage(page: number) {
  router.replace({ query: { ...route.query, page: page > 1 ? String(page) : undefined } });
}

watch(selectedYear, () => {
  router.replace({ query: { ...route.query, page: undefined } });
  getArchives(1);
});

onMounted(() => {
  getArchives(current.value);
});
</script>

<template>
  <main class="mx-auto max-w-screen-2xl px-4 md:px-6 py-4">
    <div class="grid grid-cols-1 gap-7 lg:grid-cols-4">
      <div class="mt-10 col-span-1 lg:col-span-3 mb-3">
        <div
          class="w-full p-5 pb-7 mb-3 rounded-lg border border-[#3ecf9a]/14 bg-white/84 dark:border-[#334155] dark:bg-[#2c333e]/72"
        >
          <h2 class="flex items-center mb-5 font-bold text-[#0d3d2d] dark:text-white">
            <CalendarOutlined class="w-5 h-5 mr-2 text-[#3ecf9a]" />
            归档
          </h2>
          <div v-if="availableYears.length" class="flex flex-wrap items-center gap-3">
            <span class="text-sm font-medium text-[#557468] dark:text-[#cbd5e1]">年份:</span>
            <select
              v-model="selectedYear"
              class="rounded-lg border border-[#3ecf9a]/20 bg-white/72 px-3 py-2 text-sm text-[#3ecf9a] outline-none focus:border-[#3ecf9a] dark:bg-[#2c333e]/72 dark:text-white dark:border-[#334155]"
            >
              <option v-for="y in availableYears" :key="y" :value="String(y)">{{ y }}</option>
            </select>
          </div>
        </div>

        <div v-if="loading" class="space-y-4">
          <div
            v-for="i in 3"
            :key="i"
            class="animate-pulse rounded-lg border border-[#3ecf9a]/14 bg-white/84 p-5 dark:border-[#334155] dark:bg-[#2c333e]/72"
          >
            <div class="mb-3 h-5 w-24 rounded bg-[#15956b]/8 dark:bg-white/5"></div>
            <div v-for="j in 2" :key="j" class="mb-3 flex items-center gap-3">
              <div class="h-12 w-24 rounded-lg bg-[#15956b]/8 dark:bg-white/5"></div>
              <div class="h-4 w-3/5 rounded bg-gray-200 dark:bg-white/5"></div>
            </div>
          </div>
        </div>

        <div v-else-if="!archives.length" class="flex flex-col items-center justify-center py-16">
          <div class="text-6xl font-black text-[#3ecf9a]/20">📝</div>
          <p class="mt-4 text-[#557468] dark:text-[#cbd5e1]">还没有发布文章</p>
        </div>

        <template v-else>
          <div
            v-for="archive in archives"
            :key="archive.month"
            class="mb-4 rounded-lg border border-[#3ecf9a]/14 bg-white/84 p-5 dark:border-[#334155] dark:bg-[#2c333e]/72"
          >
            <h3 class="mb-3 text-lg font-bold text-[#0d3d2d] dark:text-white">
              {{ archive.month }}
            </h3>
            <ol class="divide-y divide-gray-100 dark:divide-white/5">
              <li v-for="article in archive.articles" :key="article.id">
                <button
                  class="flex w-full items-center p-3 text-left rounded-lg hover:bg-[#f0faf5] dark:hover:bg-white/5 transition-colors cursor-pointer"
                  @click="goArticle(article.id)"
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
        </template>
      </div>

      <div class="col-span-1 mt-10 mb-3">
        <SurferSidebar />
      </div>
    </div>
  </main>
</template>
