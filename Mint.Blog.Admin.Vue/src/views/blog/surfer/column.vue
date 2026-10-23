<template>
  <main class="column-page mx-auto min-h-screen max-w-screen-2xl bg-layout px-4 py-4 md:px-6" :class="pageClass">
    <div class="grid grid-cols-1 gap-7 lg:grid-cols-4">
      <div class="col-span-1 mt-0 mb-3 lg:col-span-3 lg:mt-2">
        <div class="column-content">
          <div v-if="loading" class="column-grid">
            <article v-for="i in 6" :key="i" class="column-card skeleton-card">
              <div class="column-cover skeleton-cover"></div>
              <div class="column-info">
                <div class="skeleton-line title"></div>
                <div class="skeleton-line"></div>
                <div class="skeleton-line short"></div>
              </div>
            </article>
          </div>

          <div v-else-if="!columns.length" class="empty-box">
            <div>📚</div>
            <p>暂无专栏</p>
          </div>

          <div v-else class="column-grid">
            <article v-for="column in columns" :key="column.id" class="column-card" @click="goColumnDetail(column.id)">
              <div class="column-cover">
                <img v-if="shouldShowCover(column)" :src="column.cover || ''" alt="" loading="lazy" @error="markCoverFailed(column.id)" />
                <div v-else class="cover-placeholder"><BookOutlined /></div>
                <span v-if="column.isTop" class="top-badge">置顶</span>
                <div class="card-actions">
                  <button type="button"><ReadOutlined /> 查看专栏</button>
                </div>
              </div>
              <div class="column-info">
                <h3>{{ column.title }}</h3>
                <p>{{ column.summary || '暂无简介' }}</p>
              </div>
            </article>
          </div>
        </div>
      </div>

      <div class="col-span-1 mt-0 mb-3 lg:mt-2">
        <SurferSidebar class="lg:!top-2" hide-columns />
      </div>
    </div>
  </main>
</template>

<script setup lang="ts">
import { computed, nextTick, onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { BookOutlined, ReadOutlined } from '@ant-design/icons-vue';
import { getColumnList } from '@/service/blog/surfer/column';
import { useThemeStore } from '@/store/system/theme';
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
const themeStore = useThemeStore();
const pageClass = computed(() => ({ dark: themeStore.darkMode }));
const columns = ref<ColumnItem[]>([]);
const loading = ref(true);
const failedCoverIds = ref<Set<number>>(new Set());

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

function markCoverFailed(id: number) {
  failedCoverIds.value = new Set([...failedCoverIds.value, id]);
}

function shouldShowCover(column: ColumnItem) {
  return Boolean(column.cover) && !failedCoverIds.value.has(column.id);
}

onMounted(async () => {
  await nextTick();
  // #region debug-point A-B-C-D-E:column-mounted-styles
  (() => { const page = document.querySelector('.column-page'); const layout = document.querySelector('main#__SCROLL_EL_ID__') || document.getElementById('__SCROLL_EL_ID__'); const messagePage = document.querySelector('.message-page, main.min-h-screen.bg-layout'); fetch('http://127.0.0.1:7777/event', { method: 'POST', body: JSON.stringify({ sessionId: 'message-column-blue-bg', runId: 'post-fix', hypothesisId: 'A-B-C-D-E', location: 'column.vue:onMounted', msg: '[DEBUG] Column mounted DOM and computed backgrounds', data: { pageClass: page?.className, pageBackground: page ? getComputedStyle(page).backgroundColor : null, pageWidth: page ? getComputedStyle(page).width : null, layoutClass: layout?.className, layoutBackground: layout ? getComputedStyle(layout).backgroundColor : null, bodyBackground: getComputedStyle(document.body).backgroundColor, htmlBackground: getComputedStyle(document.documentElement).backgroundColor, layoutVariable: getComputedStyle(document.documentElement).getPropertyValue('--layout-bg-color'), messageNodePresent: Boolean(messagePage), mains: Array.from(document.querySelectorAll('main')).map(item => ({ className: item.className, background: getComputedStyle(item).backgroundColor })) }, ts: Date.now() }) }).catch(() => {}); })();
  // #region debug-point D:matching-background-rules
  setTimeout(() => { const page = document.querySelector('.column-page'); const collect = (target: Element | null) => { if (!target) return []; const matches: Array<{ selector: string; background: string; backgroundColor: string }> = []; const visit = (rules: CSSRuleList) => Array.from(rules).forEach(rule => { if (rule instanceof CSSStyleRule) { try { const selector = rule.selectorText.replaceAll(/::[-\w()]+/g, ''); if (target.matches(selector) && (rule.style.background || rule.style.backgroundColor)) matches.push({ selector: rule.selectorText, background: rule.style.background, backgroundColor: rule.style.backgroundColor }); } catch {} } else if ('cssRules' in rule) visit((rule as CSSGroupingRule).cssRules); }); Array.from(document.styleSheets).forEach(sheet => { try { visit(sheet.cssRules); } catch {} }); return matches; }; fetch('http://127.0.0.1:7777/event', { method: 'POST', body: JSON.stringify({ sessionId: 'message-column-blue-bg', runId: 'post-fix', hypothesisId: 'D', location: 'column.vue:style-rule-scan', msg: '[DEBUG] Matching background CSS rules', data: { htmlRules: collect(document.documentElement), pageRules: collect(page), htmlBackground: getComputedStyle(document.documentElement).backgroundColor, pageBackground: page ? getComputedStyle(page).backgroundColor : null }, ts: Date.now() }) }).catch(() => {}); }, 100);
  // #endregion
  const debugLoadStartedAt = performance.now();
  try {
    const res = await getColumnList<Api<ColumnItem[]>>();
    if (res.success) columns.value = byColumn(res.data || []);
  } catch {
    columns.value = [];
  } finally {
    loading.value = false;
    // #region debug-point F:column-loading-duration
    fetch('http://127.0.0.1:7777/event', { method: 'POST', body: JSON.stringify({ sessionId: 'message-column-blue-bg', runId: 'post-fix', hypothesisId: 'F', location: 'column.vue:getColumnList', msg: '[DEBUG] Column loading duration', data: { durationMs: Math.round(performance.now() - debugLoadStartedAt), columnCount: columns.value.length }, ts: Date.now() }) }).catch(() => {});
    // #endregion
  }
});
</script>

<style scoped lang="scss">
.column-page {
  color: #0d3d2d;
}

.column-content {
  width: 100%;
}

h3,
p {
  margin: 0;
}

.column-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 18px;
}

.column-card {
  overflow: hidden;
  border: 1px solid rgb(15 61 45 / 8%);
  border-radius: 24px;
  background: #fff;
  cursor: pointer;
  transition:
    transform 0.2s ease,
    box-shadow 0.2s ease;

  &:hover {
    transform: translateY(-4px);
    box-shadow: 0 18px 36px rgb(15 23 42 / 10%);
  }
}

.column-cover {
  position: relative;
  aspect-ratio: 16 / 10;
  overflow: hidden;
  background: rgb(62 207 154 / 8%);

  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.25s ease;
  }
}

.column-card:hover .column-cover img {
  transform: scale(1.06);
}

.cover-placeholder {
  display: flex;
  width: 100%;
  height: 100%;
  align-items: center;
  justify-content: center;
  color: rgb(62 207 154 / 42%);
  font-size: 46px;
  font-weight: 950;
}

.top-badge {
  position: absolute;
  top: 12px;
  right: 12px;
  border-radius: 999px;
  background: linear-gradient(135deg, #ff6b6b, #ef4444);
  padding: 5px 11px;
  color: #fff;
  font-size: 12px;
  font-weight: 950;
  box-shadow: 0 10px 20px rgb(239 68 68 / 24%);
}

.card-actions {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgb(15 23 42 / 48%);
  opacity: 0;
  transition: opacity 0.2s ease;

  button {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    border: 0;
    border-radius: 999px;
    background: #fff;
    padding: 9px 14px;
    color: #0d3d2d;
    font-size: 13px;
    font-weight: 900;
    cursor: pointer;
  }
}

.column-card:hover .card-actions {
  opacity: 1;
}

.column-info {
  padding: 7.5px 15px;

  h3 {
    color: #0d3d2d;
    font-size: 16px;
    font-weight: 950;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }

  p {
    display: -webkit-box;
    min-height: 44px;
    margin-top: 0px;
    overflow: hidden;
    color: #60786e;
    font-size: 13px;
    font-weight: 700;
    line-height: 1.7;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
  }
}

.empty-box {
  display: flex;
  min-height: 300px;
  flex-direction: column;
  align-items: center;
  justify-content: center;

  div {
    color: rgb(62 207 154 / 20%);
    font-size: 64px;
    font-weight: 950;
  }

  p {
    margin-top: 14px;
    color: #60786e;
    font-size: 14px;
    font-weight: 800;
  }
}

.skeleton-card {
  cursor: default;

  &:hover {
    transform: none;
    box-shadow: none;
  }
}

.skeleton-cover,
.skeleton-line {
  position: relative;
  overflow: hidden;
  background: rgb(62 207 154 / 8%);

  &::after {
    content: '';
    position: absolute;
    inset: 0;
    transform: translateX(-100%);
    background: linear-gradient(90deg, transparent, rgb(255 255 255 / 55%), transparent);
    animation: shimmer 1.2s infinite;
  }
}

.skeleton-line {
  height: 14px;
  margin-top: 12px;
  border-radius: 999px;

  &.title {
    width: 72%;
    height: 18px;
    margin-top: 0;
  }

  &.short {
    width: 58%;
  }
}

@keyframes shimmer {
  100% {
    transform: translateX(100%);
  }
}

.column-page.dark .toolbar h2,
.column-page.dark .column-info h3 {
  color: #f8fafc;
}

.column-page.dark .toolbar p,
.column-page.dark .column-info p,
.column-page.dark .empty-box p {
  color: #cbd5e1;
}

.column-page.dark .column-card {
  border-color: rgb(51 65 85 / 78%);
  background: rgb(30 41 59 / 58%);

  &:hover {
    box-shadow: 0 18px 36px rgb(0 0 0 / 28%);
  }
}

.column-page.dark .column-cover,
.column-page.dark .cover-placeholder {
  background: rgb(15 23 42 / 48%);
}

.column-page.dark .cover-placeholder {
  color: rgb(110 231 183 / 55%);
}

.column-page.dark .card-actions button {
  background: #1e293b;
  color: #d1fae5;
}

.column-page.dark .skeleton-cover,
.column-page.dark .skeleton-line {
  background: rgb(255 255 255 / 6%);

  &::after {
    background: linear-gradient(90deg, transparent, rgb(255 255 255 / 10%), transparent);
  }
}

@media (max-width: 1200px) {
  .column-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}

@media (max-width: 640px) {
  .column-grid {
    grid-template-columns: 1fr;
  }
}
</style>
