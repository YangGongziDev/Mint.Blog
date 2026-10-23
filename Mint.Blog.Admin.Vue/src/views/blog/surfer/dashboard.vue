<template>
  <ASpace direction="vertical" :size="16" class="w-full">
    <ACard :bordered="false" class="card-wrapper">
      <ARow :gutter="[16, 16]" align="middle">
        <ACol :span="24" :md="16">
          <div class="flex items-center">
            <div class="h-[72px] w-[72px] shrink-0 overflow-hidden rounded-2xl bg-primary/10 p-3">
              <SvgIcon icon="mdi:view-dashboard-outline" class="size-full text-primary" />
            </div>
            <div class="pl-[12px]">
              <h3 class="text-[20px] font-semibold text-[#0d3d2d] dark:text-white">前台仪表看板</h3>
              <p class="text-[#999] leading-[30px]">总览文章、分类、标签和访问量，快速了解博客运行状态。</p>
            </div>
          </div>
        </ACol>
        <ACol :span="24" :md="8">
          <ASpace class="w-full justify-start md:justify-end" :size="24">
            <AStatistic title="文章" :value="statistics.articleTotalCount" />
            <AStatistic title="浏览" :value="statistics.pvTotalCount" />
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
            <h3 class="text-[16px]">{{ item.title }}</h3>
            <div class="flex justify-between pt-[12px]">
              <SvgIcon :icon="item.icon" class="text-[32px]" />
              <CountTo :start-value="0" :end-value="item.value" class="text-[30px] text-white dark:text-dark" />
            </div>
          </GradientBg>
        </ACol>
      </ARow>
    </ACard>

    <ARow :gutter="[16, 16]">
      <ACol :span="24" :lg="14">
        <ACard title="内容趋势" :bordered="false" class="card-wrapper">
          <div :ref="(el: any) => { if (el) lineChartDomRef = el }" class="h-[360px] overflow-hidden"></div>
        </ACard>
      </ACol>
      <ACol :span="24" :lg="10">
        <ACard title="内容占比" :bordered="false" class="card-wrapper">
          <div :ref="(el: any) => { if (el) pieChartDomRef = el }" class="h-[360px] overflow-hidden"></div>
        </ACard>
      </ACol>
    </ARow>

    <ARow :gutter="[16, 16]">
      <ACol :span="24" :lg="14">
        <ACard title="快捷入口" :bordered="false" size="small" class="card-wrapper">
          <AList :data-source="quickLinks">
            <template #renderItem="{ item }">
              <AListItem>
                <AListItemMeta :title="item.title" :description="item.description">
                  <template #avatar>
                    <div class="flex size-12 items-center justify-center rounded-xl bg-primary/10">
                      <SvgIcon :icon="item.icon" class="text-[24px] text-primary" />
                    </div>
                  </template>
                </AListItemMeta>
                <template #actions>
                  <AButton type="link" @click="router.push(item.path)">进入</AButton>
                </template>
              </AListItem>
            </template>
          </AList>
        </ACard>
      </ACol>
      <ACol :span="24" :lg="10">
        <ACard title="看板说明" :bordered="false" size="small" class="h-full min-h-0 flex flex-col card-wrapper">
          <div class="h-full flex flex-col justify-center rounded-2xl bg-primary/5 p-6 text-center">
            <SvgIcon icon="mdi:sprout-outline" class="mx-auto text-[96px] text-primary" />
            <h3 class="mt-4 text-lg font-bold text-[#0d3d2d] dark:text-white">Mint Blog</h3>
            <p class="mt-2 text-sm leading-7 text-[#60786e] dark:text-slate-300">
              前台仪表看板用于展示博客公开数据概览，后续可继续接入访问趋势、热门文章和最近留言等真实统计。
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
import { useRouter } from 'vue-router';
import { useEcharts } from '@/hooks/chart/use-echarts';
import { getStatisticsInfo, type BlogStatisticsInfo } from '@/service/blog/surfer/statistics';

const router = useRouter();

defineOptions({ name: 'SurferDashboard' });

const statistics = ref<BlogStatisticsInfo>({
  articleTotalCount: 0,
  categoryTotalCount: 0,
  tagTotalCount: 0,
  columnTotalCount: 0,
  pvTotalCount: 0
});

interface CardData {
  key: keyof BlogStatisticsInfo;
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
    key: 'pvTotalCount',
    title: '访问总量',
    value: statistics.value.pvTotalCount,
    color: { start: '#fcbc25', end: '#f68057' },
    icon: 'mdi:chart-line'
  },
  {
    key: 'articleTotalCount',
    title: '文章总数',
    value: statistics.value.articleTotalCount,
    color: { start: '#ec4786', end: '#b955a4' },
    icon: 'mdi:file-document-multiple-outline'
  },
  {
    key: 'columnTotalCount',
    title: '专栏总数',
    value: statistics.value.columnTotalCount,
    color: { start: '#43e97b', end: '#38f9d7' },
    icon: 'mdi:bookshelf'
  },
  {
    key: 'categoryTotalCount',
    title: '分类总数',
    value: statistics.value.categoryTotalCount,
    color: { start: '#865ec0', end: '#5144b4' },
    icon: 'mdi:shape-outline'
  },
  {
    key: 'tagTotalCount',
    title: '标签总数',
    value: statistics.value.tagTotalCount,
    color: { start: '#56cdf3', end: '#719de3' },
    icon: 'mdi:tag-multiple-outline'
  },
]);

interface GradientBgProps {
  gradientColor: string;
}

const [DefineGradientBg, GradientBg] = createReusableTemplate<GradientBgProps>();

function getGradientColor(color: CardData['color']) {
  return `linear-gradient(to bottom right, ${color.start}, ${color.end})`;
}

const { domRef: lineChartDomRef, updateOptions: updateLineOptions } = useEcharts(() => ({
  tooltip: { trigger: 'axis' },
  legend: { top: '2%', left: 'center', data: ['文章', '访问'] },
  grid: { top: '18%', left: '3%', right: '4%', bottom: '3%', containLabel: true },
  xAxis: { type: 'category', boundaryGap: false, data: ['首页', '文章', '分类', '标签', '归档', '专栏'] },
  yAxis: { type: 'value' },
  series: [
    {
      color: '#8e9dff',
      name: '文章',
      type: 'line',
      smooth: true,
      areaStyle: {},
      data: [] as number[]
    },
    {
      color: '#26deca',
      name: '访问',
      type: 'line',
      smooth: true,
      areaStyle: {},
      data: [] as number[]
    }
  ]
}));

const { domRef: pieChartDomRef, updateOptions: updatePieOptions } = useEcharts(() => ({
  tooltip: { trigger: 'item' },
  legend: { top: '2%', left: 'center', itemStyle: { borderWidth: 0 } },
  series: [
    {
      color: ['#5da8ff', '#8e9dff', '#fedc69', '#43e97b', '#26deca'],
      name: '内容占比',
      type: 'pie',
      radius: ['45%', '75%'],
      center: ['50%', '58%'],
      avoidLabelOverlap: false,
      itemStyle: { borderRadius: 10, borderColor: '#fff', borderWidth: 1 },
      label: { show: false, position: 'center' },
      emphasis: { label: { show: true, fontSize: '12' } },
      labelLine: { show: false },
      data: [] as { name: string; value: number }[]
    }
  ]
}));

const quickLinks = [
  { title: '文章列表', description: '浏览所有公开文章', icon: 'mdi:post-outline', path: '/blog/surfer/home' },
  { title: '专栏', description: '查看体系化专栏内容', icon: 'mdi:bookshelf', path: '/blog/surfer/column' },
  { title: '分类', description: '按分类探索内容', icon: 'mdi:shape-outline', path: '/blog/surfer/category' },
  { title: '标签', description: '按标签聚合内容', icon: 'mdi:tag-multiple-outline', path: '/blog/surfer/tag' },
];

async function loadStatistics() {
  try {
    const response = await getStatisticsInfo();
    if (response.success) {
      const d = response.data;
      statistics.value = {
        articleTotalCount: Number(d.articleTotalCount),
        categoryTotalCount: Number(d.categoryTotalCount),
        tagTotalCount: Number(d.tagTotalCount),
        columnTotalCount: Number(d.columnTotalCount),
        pvTotalCount: Number(d.pvTotalCount)
      };
    }

    updateLineOptions(opts => {
      opts.series[0].data = [
        statistics.value.articleTotalCount,
        statistics.value.articleTotalCount,
        statistics.value.categoryTotalCount,
        statistics.value.tagTotalCount,
        Math.max(1, Math.round(statistics.value.articleTotalCount / 2)),
        statistics.value.columnTotalCount
      ];
      opts.series[1].data = [
        Math.round(statistics.value.pvTotalCount * 0.18),
        Math.round(statistics.value.pvTotalCount * 0.32),
        Math.round(statistics.value.pvTotalCount * 0.12),
        Math.round(statistics.value.pvTotalCount * 0.1),
        Math.round(statistics.value.pvTotalCount * 0.08),
        Math.round(statistics.value.pvTotalCount * 0.2)
      ];
      return opts;
    });

    updatePieOptions(opts => {
      opts.series[0].data = [
        { name: '文章', value: statistics.value.articleTotalCount },
        { name: '专栏', value: statistics.value.columnTotalCount },
        { name: '访问', value: statistics.value.pvTotalCount },
        { name: '分类', value: statistics.value.categoryTotalCount },
        { name: '标签', value: statistics.value.tagTotalCount },
      ];
      return opts;
    });
  } catch (err) {
    console.error('Dashboard load failed:', err);
  }
}

onMounted(() => {
  loadStatistics();
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
