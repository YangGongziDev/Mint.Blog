<template>
  <section :aria-busy="status === 'pending'">
    <header class="preview-panel dashboard-intro"><div class="intro-icon"><SiteIcon name="dashboard" /></div><div class="intro-copy"><h1>{{ text('前台仪表看板', 'Public dashboard') }}</h1><p>{{ text('总览文章、分类、标签和访问量，快速了解博客运行状态。', 'An overview of blog content and total views.') }}</p></div><dl v-if="data" class="intro-totals"><div><dt>{{ text('文章', 'Articles') }}</dt><dd>{{ data.articleTotalCount }}</dd></div><div><dt>{{ text('浏览', 'Views') }}</dt><dd>{{ data.pvTotalCount }}</dd></div></dl></header>
    <p v-if="status === 'pending'" role="status">{{ text('正在加载统计…', 'Loading statistics…') }}</p>
    <div v-else-if="error" class="preview-panel" role="alert"><p>{{ text('统计加载失败，请重试。', 'Could not load statistics. Please retry.') }}</p><button @click="refresh()">{{ text('重试', 'Retry') }}</button></div>
    <template v-else-if="data">
      <dl class="statistics-grid">
        <div v-for="(card, index) in cards" :key="card.key" class="stat-card" :style="{ background: `linear-gradient(135deg, ${gradients[index]})` }"><dt>{{ card.label }}</dt><dd :data-stat="card.key"><SiteIcon :name="icons[index]!" /><span>{{ card.value }}</span></dd></div>
      </dl>
      <p v-if="cards.every(card => Number(card.value) === 0)" role="status">{{ text('暂无统计数据', 'No statistics yet') }}</p>
      <div class="dashboard-charts">
        <section class="preview-panel">
          <h2>{{ text('内容趋势（人工派生）', 'Content trend (illustrative)') }}</h2>
          <p>{{ text('沿用旧看板计算规则，由总数人工派生；非时间序列、非各页面真实访问量。', 'Retains legacy formulas derived from totals; not a time series or measured page traffic.') }}</p>
          <div class="chart-legend" :aria-label="text('趋势系列', 'Trend series')"><button v-for="series in trendSeries" :key="series.key" type="button" :aria-pressed="!hiddenSeries.includes(series.key)" @click="hiddenSeries = toggle(hiddenSeries, series.key)"><i :style="{ background: series.color }" />{{ series.label }}</button></div>
          <div class="chart-interaction">
            <svg class="trend-chart" viewBox="0 0 580 260" role="group" :aria-label="text('人工派生的文章与访问趋势，具体点见下表', 'Illustrative content and view series; values in the table below')" @pointerleave="activeTrend = null" @keydown.esc="activeTrend = null; focusedTrend = null">
              <g v-for="step in 5" :key="step"><line x1="40" :y1="220 - (step - 1) * 42.5" x2="540" :y2="220 - (step - 1) * 42.5" stroke="var(--border)" /><text x="34" :y="224 - (step - 1) * 42.5" text-anchor="end" fill="currentColor" font-size="11">{{ Math.round(maxTrend * (step - 1) / 4) }}</text></g>
              <g v-for="series in visibleSeries" :key="series.key + hiddenSeries.join(',')" class="chart-enter">
                <path :d="points(series.key) + ' L540,220 L40,220 Z'" :fill="series.color" fill-opacity=".22" />
                <path :d="points(series.key)" fill="none" :stroke="series.color" stroke-width="2" />
              </g>
              <line v-if="selectedTrend && visibleSeries.length" :x1="40 + (activeTrend ?? focusedTrend ?? 0) * 100" :x2="40 + (activeTrend ?? focusedTrend ?? 0) * 100" y1="40" y2="220" stroke="var(--muted)" stroke-dasharray="4 4" />
              <text v-for="(point, i) in trend" :key="point.label" :x="40 + i * 100" y="248" text-anchor="middle" fill="currentColor" font-size="14">{{ point.label }}</text>
              <rect v-for="(point, i) in trend" :key="point.label" class="axis-target" :x="i === 0 ? 20 : i * 100 - 10" y="40" :width="i === 0 || i === 5 ? 70 : 100" height="215" fill="transparent" tabindex="0" role="button" :aria-label="trendDescription(i)" @pointerenter="activeTrend = i" @pointerdown="activeTrend = i" @click="activeTrend = i" @focus="activeTrend = null; focusedTrend = i" @blur="focusedTrend = null" @keydown.enter.prevent="activeTrend = i" @keydown.space.prevent="activeTrend = i" />
            </svg>
            <div v-if="selectedTrend && visibleSeries.length" class="chart-tooltip trend-tooltip" role="tooltip"><strong>{{ selectedTrend.label }}</strong><span v-for="series in visibleSeries" :key="series.key">{{ series.label }}: {{ selectedTrend[series.key] }}</span></div>
          </div>
          <table class="trend-table"><caption>{{ text('人工趋势点（非实测）', 'Illustrative points (not measured)') }}</caption><thead><tr><th>{{ text('入口', 'Entry') }}</th><th>{{ text('文章', 'Content') }}</th><th>{{ text('访问', 'Views') }}</th></tr></thead><tbody><tr v-for="point in trend" :key="point.label"><th>{{ point.label }}</th><td>{{ point.articles }}</td><td>{{ point.views }}</td></tr></tbody></table>
        </section>
        <section class="preview-panel">
          <h2>{{ text('内容占比', 'Content proportions') }}</h2>
          <p>{{ text('沿用旧看板：文章、专栏、访问、分类、标签总数混合展示，不代表流量分布。', 'Legacy mix of content and view totals; not a traffic distribution.') }}</p>
          <div class="chart-legend pie-legend" :aria-label="text('环图系列', 'Donut series')"><button v-for="card in segments" :key="card.key" type="button" :aria-pressed="!hiddenPie.includes(card.key)" @click="hiddenPie = toggle(hiddenPie, card.key)"><i :style="{ background: card.color }" />{{ card.label }}</button></div>
          <div class="chart-interaction">
            <svg class="pie-chart" viewBox="0 0 360 280" role="group" :aria-label="text('内容与访问总量混合环图', 'Mixed content and view totals donut chart')" @pointerleave="activePie = null" @keydown.esc="activePie = null; focusedPie = null">
              <circle v-if="!total" cx="180" cy="150" r="88" fill="none" stroke="var(--border)" stroke-width="55" />
              <g :key="hiddenPie.join(',')" class="chart-enter">
                <path v-for="card in visibleSegments" :key="card.key" class="pie-sector" :class="{ 'is-active': selectedPie?.key === card.key }" :d="card.path" :fill="card.color" fill-rule="evenodd" tabindex="0" role="button" :aria-label="pieDescription(card)" @pointerenter="activePie = card.key" @pointerdown="activePie = card.key" @click="activePie = card.key" @focus="activePie = null; focusedPie = card.key" @blur="focusedPie = null" @keydown.enter.prevent="activePie = card.key" @keydown.space.prevent="activePie = card.key" />
              </g>
              <text v-if="selectedPie" class="pie-center" x="180" y="144" text-anchor="middle" fill="currentColor" aria-hidden="true"><tspan x="180">{{ selectedPie.label }}</tspan><tspan x="180" dy="22">{{ selectedPie.value }} · {{ selectedPie.length.toFixed(1) }}%</tspan></text>
              <text v-else-if="!total" x="180" y="150" text-anchor="middle" fill="var(--muted)" font-size="12">{{ text('无可见数据', 'No visible data') }}</text>
            </svg>
            <div v-if="selectedPie" class="chart-tooltip pie-tooltip" role="tooltip">{{ pieDescription(selectedPie) }}</div>
          </div>
          <ul class="sr-only"><li v-for="card in cards" :key="card.key">{{ card.label }}: {{ card.value }}</li></ul>
        </section>
      </div>
    </template>
    <div class="dashboard-bottom"><section class="preview-panel quick-links"><h2>{{ text('快捷入口', 'Quick links') }}</h2><NuxtLink class="quick-entry" to="/"><SiteIcon name="article" /><span>{{ text('文章列表', 'Articles') }}<small>{{ text('浏览所有公开文章', 'Browse public articles') }}</small></span><span>{{ text('进入', 'Open') }}</span></NuxtLink><NuxtLink v-for="(link, index) in links" :key="link.path" class="quick-entry" :to="link.path"><SiteIcon :name="['column','category','tag'][index]!" /><span>{{ text(link.zh, link.en) }}<small>{{ text(['查看体系化专栏内容','按分类探索内容','按标签聚合内容'][index]!, ['Explore columns','Explore categories','Explore tags'][index]!) }}</small></span><span>{{ text('进入', 'Open') }}</span></NuxtLink></section><section class="preview-panel dashboard-note"><h2>{{ text('看板说明', 'About this dashboard') }}</h2><div><SiteIcon name="sprout" /><h3>Mint Blog</h3><p>{{ text('前台仪表看板用于展示博客公开数据概览，后续可继续接入访问趋势、热门文章和最近留言等真实统计。', 'A public overview of blog data. Measured trends, popular articles and recent messages are not yet integrated.') }}</p></div></section></div>
  </section>
</template>

<script setup lang="ts">
const { text } = useSitePreferences()
const { data, status, error, refresh } = await usePublicStatistics()
const cards = computed(() => data.value ? [
  { key: 'pvTotalCount', label: text('访问总量', 'Total views'), value: data.value.pvTotalCount, color: '#b96320' },
  { key: 'articleTotalCount', label: text('文章总数', 'Articles'), value: data.value.articleTotalCount, color: '#b95585' },
  { key: 'columnTotalCount', label: text('专栏总数', 'Columns'), value: data.value.columnTotalCount, color: '#168268' },
  { key: 'categoryTotalCount', label: text('分类总数', 'Categories'), value: data.value.categoryTotalCount, color: '#7152b1' },
  { key: 'tagTotalCount', label: text('标签总数', 'Tags'), value: data.value.tagTotalCount, color: '#287db1' }
] : [])
const trend = computed(() => {
  if (!data.value) return []
  const d = data.value
  const articles = [Number(d.articleTotalCount), Number(d.articleTotalCount), Number(d.categoryTotalCount), Number(d.tagTotalCount), Math.max(1, Math.round(Number(d.articleTotalCount) / 2)), Number(d.columnTotalCount)]
  const views = [0.18, 0.32, 0.12, 0.1, 0.08, 0.2].map(ratio => Math.round(Number(d.pvTotalCount) * ratio))
  return ['首页', '文章', '分类', '标签', '归档', '专栏'].map((label, i) => ({ label, articles: articles[i]!, views: views[i]! }))
})
const trendSeries = computed(() => [
  { key: 'articles' as const, label: text('文章', 'Articles'), color: '#8e9dff' },
  { key: 'views' as const, label: text('访问', 'Views'), color: '#26deca' }
])
const hiddenSeries = ref<string[]>([])
const visibleSeries = computed(() => trendSeries.value.filter(series => !hiddenSeries.value.includes(series.key)))
const activeTrend = ref<number | null>(null)
const focusedTrend = ref<number | null>(null)
const selectedTrend = computed(() => trend.value[activeTrend.value ?? focusedTrend.value ?? -1])
const toggle = (keys: string[], key: string) => keys.includes(key) ? keys.filter(item => item !== key) : [...keys, key]
const trendDescription = (index: number) => {
  const point = trend.value[index]!
  return [point.label, ...visibleSeries.value.map(series => `${series.label}: ${point[series.key]}`)].join(' · ')
}
const maxTrend = computed(() => Math.max(1, ...trend.value.flatMap(point => visibleSeries.value.map(series => point[series.key]))))
const points = (field: 'articles' | 'views') => {
  const coordinates = trend.value.map((point, i) => [40 + i * 100, 220 - point[field] / maxTrend.value * 170])
  return coordinates.map((point, i) => {
    if (!i) return `M${point[0]},${point[1]}`
    const previous = coordinates[i - 1]!
    return `C${previous[0]! + 50},${previous[1]} ${point[0]! - 50},${point[1]} ${point[0]},${point[1]}`
  }).join(' ')
}
const gradients = ['#fcbc25, #f68057', '#ec4786, #b955a4', '#43e97b, #38f9d7', '#865ec0, #5144b4', '#56cdf3, #719de3']
const icons = ['views', 'article', 'column', 'category', 'tag']
const pieColors = ['#5da8ff', '#8e9dff', '#fedc69', '#43e97b', '#26deca']
const pieCards = computed(() => [cards.value[1], cards.value[2], cards.value[0], cards.value[3], cards.value[4]].filter((card): card is NonNullable<typeof card> => !!card))
const hiddenPie = ref<string[]>([])
const activePie = ref<string | null>(null)
const focusedPie = ref<string | null>(null)
const total = computed(() => pieCards.value.reduce((sum, card) => sum + (hiddenPie.value.includes(card.key) ? 0 : Number(card.value)), 0))
// 圆角限制在各扇区内部，细片按角度缩小圆角以避免重叠。
const sectorPath = (offset: number, length: number) => {
  if (length <= 0) return ''
  const outer = 115.5
  const inner = 60.5
  const start = offset / 100 * Math.PI * 2 - Math.PI / 2
  const end = start + length / 100 * Math.PI * 2
  const at = (radius: number, angle: number) => `${180 + radius * Math.cos(angle)},${150 + radius * Math.sin(angle)}`
  if (length >= 100) return `M180,34.5 A115.5,115.5 0 1 1 180,265.5 A115.5,115.5 0 1 1 180,34.5 M180,89.5 A60.5,60.5 0 1 0 180,210.5 A60.5,60.5 0 1 0 180,89.5 Z`
  const corner = Math.min(10, (end - start) * inner / 4)
  const outerAngle = corner / outer
  const innerAngle = corner / inner
  return `M${at(outer, start + outerAngle)} A${outer},${outer} 0 ${end - start - 2 * outerAngle > Math.PI ? 1 : 0} 1 ${at(outer, end - outerAngle)} Q${at(outer, end)} ${at(outer - corner, end)} L${at(inner + corner, end)} Q${at(inner, end)} ${at(inner, end - innerAngle)} A${inner},${inner} 0 ${end - start - 2 * innerAngle > Math.PI ? 1 : 0} 0 ${at(inner, start + innerAngle)} Q${at(inner, start)} ${at(inner + corner, start)} L${at(outer - corner, start)} Q${at(outer, start)} ${at(outer, start + outerAngle)} Z`
}
const segments = computed(() => {
  let offset = 0
  return pieCards.value.map((card, index) => {
    const length = total.value && !hiddenPie.value.includes(card.key) ? Number(card.value) / total.value * 100 : 0
    const segment = { ...card, color: pieColors[index], length, path: sectorPath(offset, length) }
    offset += length
    return segment
  })
})
const visibleSegments = computed(() => segments.value.filter(card => card.length > 0))
const selectedPie = computed(() => visibleSegments.value.find(card => card.key === (activePie.value ?? focusedPie.value)))
const pieDescription = (card: typeof segments.value[number]) => `${card.label}: ${card.value} (${card.length.toFixed(1)}%)`
const links = [
  { zh: '专栏', en: 'Columns', path: '/columns' },
  { zh: '分类', en: 'Categories', path: '/categories' },
  { zh: '标签', en: 'Tags', path: '/tags' }
]
useSeoMeta({ title: () => text('统计看板', 'Dashboard'), description: () => text('博客文章、分类、标签、专栏及访问总量。趋势仅为人工派生展示，不是真实访问趋势。', 'Blog content and view totals. Trend points are illustrative, not measured traffic.') })
</script>

<style scoped>
.statistics-grid { padding: 12px; background: var(--surface); border-radius: 8px; }
.statistics-grid .stat-card { padding: 8px 16px 4px; border-radius: 8px; }
.stat-card dt { display: flex; justify-content: space-between; align-items: center; font-size: 16px; }
.stat-card dt :deep(svg) { width: 32px; height: 32px; }
.statistics-grid .stat-card dd { font-size: 30px; font-weight: 400; margin: 8px 0 0; }
.dashboard-charts { grid-template-columns: minmax(0,14fr) minmax(0,10fr); }
.dashboard-charts h2 { font-size: 16px; margin: 0 0 8px; }
.dashboard-charts p { font-size: 12px; min-height: 38px; }
.dashboard-charts .trend-chart { height: 300px; }
.trend-table { position: absolute; width: 1px !important; height: 1px; overflow: hidden; clip-path: inset(50%); }
.pie-chart { display: block; width: 100%; height: 270px; }
.chart-legend { display: flex; flex-wrap: wrap; justify-content: center; gap: 8px 12px; font-size: 12px; }
.chart-legend button { display: inline-flex; align-items: center; min-height: 32px; padding: 4px 6px; background: var(--surface); color: var(--text); border: 1px solid var(--border); border-radius: 6px; cursor: pointer; font: inherit; }
.chart-legend button[aria-pressed="false"] { color: var(--muted); text-decoration: line-through; }
.chart-legend button[aria-pressed="false"] i { opacity: .3; }
.chart-legend i { display: inline-block; width: 14px; height: 10px; border-radius: 2px; margin-right: 4px; }
.chart-interaction { position: relative; }
.chart-tooltip { position: absolute; top: 0; right: 8px; max-width: calc(100% - 16px); padding: 8px 12px; border: 1px solid var(--border); border-radius: 8px; background: var(--surface); color: var(--text); box-shadow: 0 4px 16px #0002; font-size: 12px; pointer-events: none; overflow-wrap: anywhere; }
.trend-tooltip span { display: block; margin-top: 4px; }
.pie-tooltip { top: auto; bottom: 0; }
.pie-center { font-size: 12px; pointer-events: none; }
.axis-target, .pie-sector { cursor: pointer; }
.chart-legend button:focus-visible, .axis-target:focus-visible, .pie-sector:focus-visible { outline: 2px solid var(--primary); outline-offset: 2px; }
.pie-sector { transition: opacity .2s ease; }
.pie-sector.is-active { opacity: .75; }
.chart-enter { animation: chart-reveal .45s ease-out both; }
@keyframes chart-reveal { from { opacity: 0; } to { opacity: 1; } }
@media (prefers-reduced-motion: reduce) { .chart-enter { animation: none; } .pie-sector { transition: none; } }
@media (max-width: 1199px) { .statistics-grid { grid-template-columns: repeat(4,minmax(0,1fr)) !important; } }
@media (max-width: 991px) { .statistics-grid { grid-template-columns: repeat(2,minmax(0,1fr)) !important; } }
@media (max-width: 575px) { .statistics-grid { grid-template-columns: 1fr !important; } }

.statistics-grid { display: grid; grid-template-columns: repeat(5, minmax(0, 1fr)); gap: 16px; margin: 24px 0; }
.stat-card { padding: 20px; border-radius: 16px; color: white; overflow-wrap: anywhere; }
.stat-card dd { font-size: clamp(22px, 3vw, 32px); margin: 10px 0 0; font-weight: 700; }
.dashboard-charts { display: grid; grid-template-columns: minmax(0,14fr) minmax(0,10fr); gap: 16px; margin-bottom: 16px; }
.dashboard-charts > * { min-width: 0; }
.dashboard-charts p { color: var(--muted); }
.trend-chart { width: 100%; height: auto; }
.trend-table { width: 100%; border-collapse: collapse; text-align: center; }
.trend-table th, .trend-table td { border-bottom: 1px solid var(--border); padding: 5px; }
.trend-table caption { color: var(--muted); }
.dashboard-intro { display: flex; gap: 12px; align-items: center; flex-wrap: wrap; }
.intro-icon { width: 72px; height: 72px; padding: 12px; border-radius: 16px; background: color-mix(in srgb,var(--primary) 10%,transparent); color: var(--primary); }
.intro-icon :deep(svg) { width: 100%; height: 100%; }
.intro-copy { flex: 1; min-width: 180px; }.intro-copy h1 { font-size: 20px; margin: 0; }.intro-copy p { color: #999; line-height: 30px; margin: 0; }
.intro-totals { display: flex; gap: 24px; margin: 0; }.intro-totals dt { color: var(--muted); }.intro-totals dd { font-size: 24px; margin: 0; }
.stat-card dd { display: flex; align-items: center; justify-content: space-between; }.stat-card dd :deep(svg) { width: 32px; height: 32px; }
.dashboard-bottom { display: grid; grid-template-columns: minmax(0,14fr) minmax(0,10fr); gap: 16px; }.dashboard-bottom h2 { font-size: 16px; margin: 0 0 16px; }
.quick-entry { display: flex; gap: 16px; align-items: center; padding: 12px 0; border-bottom: 1px solid var(--border); }.quick-entry > :deep(svg) { width: 48px; height: 48px; padding: 12px; border-radius: 12px; background: color-mix(in srgb,var(--primary) 10%,transparent); }.quick-entry > span:nth-child(2) { flex: 1; color: var(--text); }.quick-entry small { display: block; color: var(--muted); margin-top: 4px; }
.dashboard-note > div { height: calc(100% - 40px); padding: 24px; text-align: center; background: color-mix(in srgb,var(--primary) 5%,transparent); border-radius: 16px; display: flex; flex-direction: column; align-items: center; justify-content: center; }.dashboard-note :deep(svg) { width: 96px; height: 96px; color: var(--primary); }.dashboard-note p { color: var(--muted); line-height: 28px; }
@media (max-width: 991px) { .dashboard-bottom { grid-template-columns: 1fr; } }
@media (max-width: 900px) { .statistics-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); } .dashboard-charts { grid-template-columns: 1fr; } }
@media (max-width: 380px) { .stat-card { padding: 14px; } }
</style>
