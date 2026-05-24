<template>
  <ASpace direction="vertical" :size="16" class="w-full">
    <ACard :bordered="false" class="card-wrapper">
      <ARow :gutter="[16, 16]" align="middle">
        <ACol :span="24" :md="18">
          <div class="flex flex-col items-start gap-4 sm:flex-row sm:items-center">
            <div class="h-[72px] w-[72px] shrink-0 overflow-hidden rounded-full">
              <img src="@/assets/blog/surfer/author/author-yangmufa-picture.jpg" class="size-full" />
            </div>
            <div class="pl-0 sm:pl-[12px]">
              <h3 class="text-[16px] font-semibold sm:text-[18px]">
                {{ $t('page.home.greeting', { userName: authStore.userInfo.displayName }) }}
              </h3>
              <p class="text-sm text-base-text/60 leading-[24px] sm:text-base sm:leading-[30px]">博客后台仪表盘，实时查看内容和访问数据。</p>
            </div>
          </div>
        </ACol>
        <ACol :span="24" :md="6">
          <ASpace class="w-full flex-wrap justify-start md:justify-end" :size="16">
            <AStatistic title="文章" :value="statistics.articleTotalCount" />
            <AStatistic title="PV" :value="statistics.pvTotalCount" />
          </ASpace>
        </ACol>
      </ARow>
    </ACard>

    <ACard :bordered="false" size="small" class="card-wrapper">
      <DefineGradientBg v-slot="{ $slots, gradientColor }">
        <div class="rounded-[8px] px-[16px] pb-[4px] pt-[8px] text-white" :style="{ backgroundImage: gradientColor }">
          <component :is="$slots.default" />
        </div>
      </DefineGradientBg>

      <ARow :gutter="[16, 16]">
        <ACol v-for="item in cardData" :key="item.key" :span="24" :md="12" :lg="6" class="dashboard-stat-col">
          <GradientBg :gradient-color="getGradientColor(item.color)" class="flex-1">
            <h3 class="text-[14px] sm:text-[16px]">{{ item.title }}</h3>
            <div class="flex justify-between pt-[12px]">
              <SvgIcon :icon="item.icon" class="text-[28px] sm:text-[32px]" />
              <CountTo :start-value="0" :end-value="item.value" class="text-[24px] text-white sm:text-[30px]" />
            </div>
          </GradientBg>
        </ACol>
      </ARow>
    </ACard>

    <ARow :gutter="[16, 16]">
      <ACol :span="24" :lg="14">
        <ACard title="近一周 PV 访问量" :bordered="false" class="card-wrapper">
          <div :ref="(el: any) => { if (el) pvChartDomRef = el }" class="h-[280px] overflow-hidden sm:h-[320px] lg:h-[360px]"></div>
        </ACard>
      </ACol>
      <ACol :span="24" :lg="10">
        <ACard title="近一年文章发布统计" :bordered="false" class="card-wrapper">
          <div :ref="(el: any) => { if (el) publishChartDomRef = el }" class="h-[280px] overflow-hidden sm:h-[320px] lg:h-[360px]"></div>
        </ACard>
      </ACol>
    </ARow>

    <ARow :gutter="[16, 16]">
      <ACol :span="24" :lg="14">
        <ACard title="迁移进度" :bordered="false" size="small" class="card-wrapper">
          <AList :data-source="migrationItems">
            <template #renderItem="{ item }">
              <AListItem class="!items-start !px-0 sm:!px-4">
                <AListItemMeta :title="item.title" :description="item.description">
                  <template #avatar>
                    <div class="flex size-12 items-center justify-center rounded-xl bg-primary/10">
                      <SvgIcon :icon="item.icon" class="text-[24px] text-primary" />
                    </div>
                  </template>
                </AListItemMeta>
              </AListItem>
            </template>
          </AList>
        </ACard>
      </ACol>
      <ACol :span="24" :lg="10">
        <ACard title="后台说明" :bordered="false" size="small" class="h-full min-h-0 flex flex-col card-wrapper">
          <div class="h-full flex flex-col justify-center rounded-2xl bg-primary/5 p-6 text-center">
            <SvgIcon icon="mdi:monitor-dashboard" class="mx-auto text-[72px] text-primary sm:text-[96px]" />
            <h3 class="mt-4 text-lg font-bold">Mint Blog Admin</h3>
            <p class="mt-2 text-sm leading-7 text-base-text/70">
              该页面已从旧项目 `Home.vue` 迁移，并改为使用 DDD 后端 `api/blog-admin/dashboard` 统计接口。
            </p>
          </div>
        </ACard>
      </ACol>
    </ARow>
  </ASpace>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue';
import { createReusableTemplate } from '@vueuse/core';
import { useAuthStore } from '@/store/system/auth';
import { useEcharts } from '@/hooks/chart/use-echarts';
import {
  getDashboardPublishArticleStatistics,
  getDashboardPvStatistics,
  getDashboardStatistics,
  type AdminDashboardStatistics
} from '@/service/blog/admin/dashboard';

const authStore = useAuthStore();

defineOptions({ name: 'BlogAdminHome' });

const statistics = ref<AdminDashboardStatistics>({
  articleTotalCount: 0,
  categoryTotalCount: 0,
  tagTotalCount: 0,
  wikiTotalCount: 0,
  pvTotalCount: 0
});

interface CardData {
  key: keyof AdminDashboardStatistics;
  title: string;
  value: number;
  color: {
    start: string;
    end: string;
  };
  icon: string;
}

const cardData = computed<CardData[]>(() => [
  {
    key: 'articleTotalCount',
    title: '文章',
    value: statistics.value.articleTotalCount,
    color: { start: '#ec4786', end: '#b955a4' },
    icon: 'mdi:file-document-multiple-outline'
  },
  {
    key: 'wikiTotalCount',
    title: '知识库',
    value: statistics.value.wikiTotalCount,
    color: { start: '#43e97b', end: '#38f9d7' },
    icon: 'mdi:bookshelf'
  },
  {
    key: 'categoryTotalCount',
    title: '分类',
    value: statistics.value.categoryTotalCount,
    color: { start: '#865ec0', end: '#5144b4' },
    icon: 'mdi:shape-outline'
  },
  {
    key: 'tagTotalCount',
    title: '标签',
    value: statistics.value.tagTotalCount,
    color: { start: '#56cdf3', end: '#719de3' },
    icon: 'mdi:tag-multiple-outline'
  },
  {
    key: 'pvTotalCount',
    title: '总浏览量',
    value: statistics.value.pvTotalCount,
    color: { start: '#fcbc25', end: '#f68057' },
    icon: 'mdi:eye-outline'
  }
]);

interface GradientBgProps {
  gradientColor: string;
}

const [DefineGradientBg, GradientBg] = createReusableTemplate<GradientBgProps>();

function getGradientColor(color: CardData['color']) {
  return `linear-gradient(to bottom right, ${color.start}, ${color.end})`;
}

const { domRef: pvChartDomRef, updateOptions: updatePvOptions } = useEcharts(() => ({
  tooltip: { trigger: 'axis' },
  grid: { top: '10%', left: '3%', right: '4%', bottom: '3%', containLabel: true },
  xAxis: { type: 'category', boundaryGap: false, data: [] as string[] },
  yAxis: { type: 'value' },
  series: [
    {
      color: '#8e9dff',
      name: 'PV',
      type: 'line',
      smooth: true,
      areaStyle: {},
      data: [] as number[]
    }
  ]
}));

const { domRef: publishChartDomRef, updateOptions: updatePublishOptions } = useEcharts(() => ({
  tooltip: { trigger: 'axis' },
  grid: { top: '10%', left: '3%', right: '4%', bottom: '3%', containLabel: true },
  xAxis: { type: 'category', data: [] as string[] },
  yAxis: { type: 'value' },
  series: [
    {
      color: '#26deca',
      name: '发布文章',
      type: 'bar',
      barMaxWidth: 28,
      data: [] as number[]
    }
  ]
}));

const migrationItems = [
  {
    title: '后台 Home 已迁移',
    description: '旧 Home.vue 已迁移为 blog-admin/home.vue，并接入真实统计接口。',
    icon: 'mdi:check-circle-outline'
  },
  {
    title: 'Service 已归档',
    description: 'dashboard.ts 已放入 service/blog/admin，后续模块按同一结构扩展。',
    icon: 'mdi:folder-check-outline'
  },
  {
    title: '后续迁移',
    description: '下一步建议迁移 Category / Tag 管理页面。',
    icon: 'mdi:source-branch'
  }
];

async function loadDashboard() {
  const [statisticsRes, pvRes, publishRes] = await Promise.all([
    getDashboardStatistics(),
    getDashboardPvStatistics(),
    getDashboardPublishArticleStatistics()
  ]);

  if (statisticsRes.success) statistics.value = statisticsRes.data;

  if (pvRes.success) {
    updatePvOptions(opts => {
      opts.xAxis.data = pvRes.data.pvDates;
      opts.series[0].data = pvRes.data.pvCounts;
      return opts;
    });
  }

  if (publishRes.success) {
    updatePublishOptions(opts => {
      opts.xAxis.data = publishRes.data.dates;
      opts.series[0].data = publishRes.data.counts;
      return opts;
    });
  }
}

onMounted(() => {
  loadDashboard();
});
</script>

<style scoped lang="scss">
@media (min-width: 1200px) {
  :deep(.dashboard-stat-col) {
    flex: 0 0 20%;
    max-width: 20%;
  }
}
</style>
