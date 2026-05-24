<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { BookOutlined } from '@ant-design/icons-vue';
import { getColumnList } from '@/service/blog/surfer/column';
import SurferSidebar from '@/components/blog/surfer/sidebar-right.vue';

defineOptions({ name: 'SurferColumnPage' });

type ColumnItem = {
  id: number;
  title: string;
  summary?: string;
  cover?: string;
  isTop?: boolean;
  firstArticleId: number;
  weight?: number;
  sort?: number;
};
type Api<T> = { success: boolean; data: T };

const router = useRouter();
const columns = ref<ColumnItem[]>([]);
const loading = ref(true);

const byColumn = (list: ColumnItem[]) =>
  [...list].sort((a, b) => {
    const wa = a.weight || 0;
    const wb = b.weight || 0;
    if (wa !== wb) return (wb > 0 ? wb : 0) - (wa > 0 ? wa : 0);
    const sa = a.sort || 0;
    const sb = b.sort || 0;
    if (sa !== sb) return sb - sa;
    return Number(a.id) - Number(b.id);
  });

function goColumnDetail(id: number) {
  router.push({ path: `/blog/surfer/column/${id}` });
}

onMounted(async () => {
  try {
    const res = await getColumnList<Api<ColumnItem[]>>();
    if (res.success) columns.value = byColumn(res.data || []);
  } catch {
    columns.value = [];
  } finally {
    loading.value = false;
  }
});
</script>

<template>
  <main class="mx-auto max-w-screen-2xl px-4 md:px-6 py-4">
    <div class="grid grid-cols-1 gap-7 lg:grid-cols-4">
      <div class="col-span-1 mt-0 mb-1 lg:mt-10 lg:col-span-3 lg:mb-3">
        <div
          class="w-full p-5 pb-7 mb-3 rounded-lg border border-[#3ecf9a]/14 bg-white/84 dark:border-[#334155] dark:bg-[#2c333e]/72"
        >
          <h2 class="flex items-center mb-5 font-bold text-[#0d3d2d] dark:text-white">
            <BookOutlined class="w-5 h-5 mr-2 text-[#3ecf9a]" />
            专栏
            <span v-if="columns.length" class="ml-2 font-normal text-[#557468] dark:text-[#cbd5e1]">
              ( {{ columns.length }} )
            </span>
          </h2>

          <div v-if="loading" class="grid gap-5 sm:grid-cols-2 xl:grid-cols-3">
            <div
              v-for="i in 6"
              :key="i"
              class="animate-pulse rounded-xl border border-[#3ecf9a]/14 bg-white/72 p-0 dark:bg-[#232931]/72 dark:border-[#334155]"
            >
              <div class="h-36 w-full rounded-t-xl bg-[#3ecf9a]/8 dark:bg-white/5"></div>
              <div class="p-5 space-y-3">
                <div class="h-5 w-3/4 rounded bg-gray-200 dark:bg-white/5"></div>
                <div class="h-4 w-full rounded bg-gray-200 dark:bg-white/5"></div>
                <div class="h-4 w-2/3 rounded bg-gray-200 dark:bg-white/5"></div>
              </div>
            </div>
          </div>

          <div v-else-if="!columns.length" class="flex flex-col items-center justify-center py-16">
            <div class="text-6xl font-black text-[#3ecf9a]/20">📚</div>
            <p class="mt-4 text-[#557468] dark:text-[#cbd5e1]">暂无专栏</p>
          </div>

          <div v-else class="grid gap-5 sm:grid-cols-2 xl:grid-cols-3">
            <div
              v-for="column in columns"
              :key="column.id"
              class="group relative cursor-pointer rounded-xl border border-[#3ecf9a]/14 bg-white/72 transition-all duration-300 hover:-translate-y-1 hover:shadow-lg hover:border-[#3ecf9a]/40 dark:bg-[#232931]/72 dark:border-[#334155]"
              @click="goColumnDetail(column.id)"
            >
              <img
                v-if="column.cover"
                class="h-36 w-full rounded-t-xl object-cover transition-transform duration-300 group-hover:scale-105"
                :src="column.cover"
              />
              <div
                v-else
                class="flex h-36 w-full items-center justify-center rounded-t-xl bg-[#3ecf9a]/8 text-4xl text-[#3ecf9a]/30 font-black"
              >
                {{ column.title?.charAt(0) }}
              </div>
              <div class="p-5">
                <h3 class="mb-2 text-lg font-bold text-[#0d3d2d] dark:text-white line-clamp-1">
                  {{ column.title }}
                </h3>
                <p class="text-sm leading-relaxed text-[#60786e] dark:text-[#cbd5e1] line-clamp-2">
                  {{ column.summary || '暂无简介' }}
                </p>
              </div>
              <div
                v-if="column.isTop"
                class="absolute right-2 top-2 rounded-full bg-gradient-to-r from-[#ff6b6b] to-[#ef4444] px-3 py-1 text-xs font-black text-white shadow-md"
              >
                置顶
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="col-span-1 mt-10 mb-3">
        <SurferSidebar hide-columns />
      </div>
    </div>
  </main>
</template>
