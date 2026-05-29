<script setup lang="ts">
import { computed, onActivated, onMounted, ref, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { CalendarOutlined, EyeOutlined, FolderOutlined } from '@ant-design/icons-vue';
import { getArticlePageList } from '@/service/blog/surfer/article';
import defaultCoverImg1 from '@/assets/blog/surfer/home-default-article-cover/default-article-cover-image1.jpeg';
import defaultCoverImg2 from '@/assets/blog/surfer/home-default-article-cover/default-article-cover-image2.jpeg';
import Slide from '@/components/blog/surfer/slide.vue';
import SidebarRight from '@/components/blog/surfer/sidebar-right.vue';
import Starry from '@/components/blog/surfer/starry.vue';
import Typed from '@/components/blog/surfer/typed.vue';

defineOptions({ name: 'SurferHome' });

// --------------- types ---------------
type Api<T> = { success: boolean; data: T };
type Category = { id: number; name: string; articlesTotal: number; sort?: number };
type Tag = { id: number; name: string; sort?: number };
type Article = {
  id: number;
  title: string;
  summary?: string;
  cover?: string;
  createDate?: string;
  isTop?: boolean;
  readNum?: number;
  category?: Category;
  tags?: Tag[];
};
type Page = Api<Article[]> & { current: number; size: number; total: number; pages: number };

// --------------- state ---------------
const router = useRouter();
const route = useRoute();
const current = computed(() => {
  const q = route.query.page;
  const n = Number(q);
  return Number.isFinite(n) && n > 0 ? n : 1;
});
const articles = ref<Article[]>([]);
const size = ref(10);
const total = ref(0);
const pages = ref(0);
const loading = ref(true);
const homeHeroImages = Object.values(
  import.meta.glob('@/assets/blog/surfer/article-banner/*.{png,jpg,jpeg,webp,avif,gif}', {
    eager: true,
    import: 'default'
  })
) as string[];
let hasSkippedInitialActivated = false;

// Local swiper image & typed texts (no API dependency)
const swiperImage = ref('');
const swiperImageKey = ref(0);
const displayTexts = ['Mint Blog', '新鲜阅读，温柔写作', '技术·生活·思考'];

// --------------- helpers ---------------
function pickSwiperImage() {
  if (!homeHeroImages.length) {
    swiperImage.value = '';
    swiperImageKey.value += 1;
    return;
  }

  const lastImage = window.sessionStorage.getItem('blog-surfer:last-home-hero-image');
  const candidates = homeHeroImages.length > 1
    ? homeHeroImages.filter(image => image !== lastImage && image !== swiperImage.value)
    : homeHeroImages;
  const pool = candidates.length ? candidates : homeHeroImages.filter(image => image !== swiperImage.value);
  const nextPool = pool.length ? pool : homeHeroImages;
  const nextImage = nextPool[Math.floor(Math.random() * nextPool.length)];

  swiperImage.value = nextImage;
  swiperImageKey.value += 1;
  window.sessionStorage.setItem('blog-surfer:last-home-hero-image', nextImage);
}

const info = (a: Article) => a.summary?.trim() || '这是一篇精彩的文章，点击查看详细内容...';
function isValidUrl(raw?: string): boolean {
  if (!raw) return false;
  try {
    const url = new URL(raw);
    return url.protocol === 'http:' || url.protocol === 'https:';
  } catch {
    return false;
  }
}

const coverErrorVersion = ref(0);
const failedCoverIds = new Set<number>();

function onCoverError(articleId: number) {
  failedCoverIds.add(articleId);
  coverErrorVersion.value += 1;
}

const defaultCovers = [defaultCoverImg1, defaultCoverImg2] as const;

function pickDefaultCover(articleId: number): string {
  return defaultCovers[articleId % defaultCovers.length];
}

function coverUrl(a: Article): string {
  if (!isValidUrl(a.cover)) return pickDefaultCover(a.id);
  if (coverErrorVersion.value >= 0 && failedCoverIds.has(a.id)) {
    return pickDefaultCover(a.id);
  }
  return a.cover!;
}

const cover = (a: Article) => ({ backgroundImage: `url(${coverUrl(a)})` });
const views = (a: Article, i: number) => a.readNum ?? 100 + i * 37;
const primaryTag = (a: Article) => a.tags?.[0];

function formatDate(raw?: string): string {
  if (!raw) return '未知日期';
  const d = new Date(raw);
  if (!Number.isNaN(d.getTime())) {
    return d.toISOString().slice(0, 10);
  }
  return raw;
}

function toTop() {
  const el = document.querySelector('#__SCROLL_EL_ID__');
  if (el) el.scrollTo({ top: 0, behavior: 'smooth' });
  else window.scrollTo({ top: 0, behavior: 'smooth' });
}

// --------------- data fetching ---------------
async function fetchArticles() {
  const page = current.value;
  if (page < 1) return;
  loading.value = true;
  try {
    const res = await getArticlePageList<Page>({ current: page, size: size.value });
    if (res.success) {
      articles.value = res.data || [];
      total.value = res.total;
      pages.value = res.pages;
      toTop();
    }
  } catch {
    articles.value = [];
    total.value = 0;
    pages.value = 0;
  } finally {
    loading.value = false;
  }
}

// --------------- navigation ---------------
function goPage(page: number) {
  if (page !== current.value) {
    router.replace({ query: { page: page > 1 ? String(page) : undefined } });
  }
}

// --------------- navigation ---------------
function goArticle(id: number) {
  router.push(`/blog/surfer/article/${id}`);
}
function goCategory(id?: number, name?: string) {
  if (id) router.push({ path: '/blog/surfer/category', query: { id: String(id), name } });
}
function goTag(id: number, name: string) {
  router.push({ path: '/blog/surfer/tag', query: { id: String(id), name } });
}

// --------------- lifecycle ---------------
onMounted(() => {
  pickSwiperImage();
  fetchArticles();
});

onActivated(() => {
  if (!hasSkippedInitialActivated) {
    hasSkippedInitialActivated = true;
    return;
  }

  pickSwiperImage();
});

watch(
  () => route.query.page,
  () => {
    fetchArticles();
  }
);
</script>

<template>
  <Slide :key="swiperImageKey" :src="swiperImage" class="slide-hero">
    <Starry />
    <Typed
      :texts="displayTexts"
      class="absolute top-1/2 sm:top-[48%] left-1/2 -translate-x-1/2 -translate-y-1/2 sm:-translate-y-1/2 w-[80%] text-center text-white text-xl sm:text-[30px] leading-7 sm:leading-[40px] md:leading-[50px]"
      style="text-shadow: 0 2px 8px rgba(0,0,0,0.4)"
    />
  </Slide>

  <main class="mx-auto max-w-screen-xl px-4 py-0 md:px-6 pb-10 sm:pb-20">
    <ARow :gutter="[{ xs: 0, sm: 16, md: 28 }, 28]">
      <!-- ---- Article List (Left) ---- -->
      <ACol :xs="24" :lg="17">
        <section class="mt-0 space-y-4 md:mt-0">
          <!-- Loading skeleton -->
          <div v-if="loading" class="space-y-4">
            <article v-for="i in 4" :key="i" class="home-skeleton-card">
              <div class="home-skeleton-cover"></div>
              <div class="home-skeleton-body">
                <div class="home-skeleton-line home-skeleton-title"></div>
                <div class="home-skeleton-line home-skeleton-summary"></div>
                <div class="home-skeleton-line home-skeleton-summary-short"></div>
                <div class="home-skeleton-meta">
                  <span></span>
                  <span></span>
                  <span></span>
                </div>
                <div class="home-skeleton-tags">
                  <span></span>
                  <span></span>
                  <span></span>
                </div>
              </div>
            </article>
          </div>

          <!-- Empty state -->
          <div v-else-if="!articles.length" class="empty-card min-h-[310px]">
            <div class="empty-icon">M</div>
            <h2 class="mt-5 text-2xl font-black text-[#0d3d2d] dark:text-white">
              还没有发布文章
            </h2>
            <p
              class="mt-3 max-w-md text-center text-sm leading-7 text-[#60786e] dark:text-[#cbd5e1]"
            >
              数据准备好后，文章会以图文卡片的形式展示在这里。你也可以先浏览分类、标签或专栏内容。
            </p>
            <div class="mt-6 flex flex-wrap justify-center gap-2">
              <span class="tag-pill">Mint Blog</span>
              <span class="tag-pill">Fresh Reading</span>
              <span class="tag-pill">Coming Soon</span>
            </div>
          </div>

          <!-- ====== Card Layout ====== -->
          <template v-else>
            <article
              v-for="(a, i) in articles"
              :key="a.id"
              class="card group relative flex min-h-[154px] overflow-hidden sm:min-h-[190px] md:h-[200px] lg:h-[190px] xl:h-[220px]"
            >
              <img
                v-if="isValidUrl(a.cover)"
                :src="a.cover!"
                class="hidden"
                @error="onCoverError(a.id)"
              />
              <button class="mobile-cover sm:hidden" @click="goArticle(a.id)">
                <span :style="cover(a)"></span>
              </button>
              <button v-if="i % 2 === 0" class="cover left-cover" @click="goArticle(a.id)">
                <span :style="cover(a)"></span>
              </button>
              <div
                class="relative z-10 flex min-w-0 flex-1 flex-col justify-center py-4 pl-3 pr-[14px] text-left sm:w-[64%] sm:justify-between sm:p-5 sm:px-8 lg:px-6 xl:px-10"
              >
                <div class="min-w-0 cursor-pointer" @click="goArticle(a.id)">
                  <div
                    class="mb-2 flex items-center justify-between gap-2 sm:hidden"
                    :class="{ 'pr-[0px]': a.isTop }"
                  >
                    <ATooltip title="标签">
                      <button
                        class="mobile-category-pill"
                        :disabled="!primaryTag(a)"
                        @click.stop="primaryTag(a) && goTag(primaryTag(a)!.id, primaryTag(a)!.name)"
                      >
                        #&nbsp;{{ primaryTag(a)?.name || '无标签' }}
                      </button>
                    </ATooltip>
                    <span class="mobile-date">{{ formatDate(a.createDate) }}</span>
                  </div>
                  <h2
                    class="line-clamp-1 text-[18px] font-black leading-7 text-[#0d3d2d] hover:text-[#3ecf9a] dark:text-white dark:hover:text-[#539dfd] sm:text-xl md:text-2xl"
                  >
                    {{ a.title }}
                  </h2>
                  <p
                    class="mt-1 line-clamp-1 text-[14px] font-semibold leading-6 text-[#60786e] dark:text-[#cbd5e1] sm:mt-3 sm:line-clamp-2 sm:text-sm sm:leading-7 sm:indent-8 xl:line-clamp-3"
                  >
                    {{ info(a) }}
                  </p>
                </div>
                <div>
                  <div
                    class="mt-2 flex flex-wrap items-center justify-start gap-3 text-[13px] text-[#8aa093] sm:mt-4 sm:justify-start sm:text-xs"
                  >
                    <ATooltip title="分类">
                      <button
                        class="inline-flex cursor-pointer items-center gap-1"
                        @click.stop="goCategory(a.category?.id, a.category?.name)"
                      >
                        <span class="meta-icon meta-icon-category">
                          <FolderOutlined />
                        </span>
                        {{ a.category?.name || '未分类' }}
                      </button>
                    </ATooltip>
                    <ATooltip title="阅读量">
                      <span class="inline-flex cursor-default items-center gap-1">
                        <span class="meta-icon meta-icon-read">
                          <EyeOutlined />
                        </span>
                        {{ views(a, i) }}
                      </span>
                    </ATooltip>
                    <ATooltip title="发布时间">
                      <span class="hidden cursor-default items-center gap-1 sm:inline-flex">
                        <span class="meta-icon meta-icon-time">
                          <CalendarOutlined />
                        </span>
                        {{ formatDate(a.createDate) }}
                      </span>
                    </ATooltip>
                  </div>
                  <div class="mt-3 hidden flex-wrap justify-center gap-2 sm:flex sm:justify-start">
                    <ATooltip v-for="tag in (a.tags || []).slice(0, 4)" :key="tag.id" title="标签">
                      <button
                        class="tag"
                        @click.stop="goTag(tag.id, tag.name)"
                      >
                      #&nbsp;{{ tag.name }}
                      </button>
                    </ATooltip>
                  </div>
                </div>
              </div>
              <div
                class="card-cover-glow absolute inset-0 bg-cover bg-center opacity-20 blur-3xl dark:opacity-14"
                :style="cover(a)"
              ></div>
              <button v-if="i % 2 !== 0" class="cover right-cover" @click="goArticle(a.id)">
                <span :style="cover(a)"></span>
              </button>
              <div
                v-if="a.isTop"
                class="top-badge absolute z-30 rounded-full bg-gradient-to-r from-[#ff6b6b] to-[#ef4444] px-3 py-1 text-xs font-black text-white shadow-lg shadow-red-500/20"
              >
                置顶
              </div>
            </article>
          </template>

          <!-- Pagination -->
          <div v-if="pages > 0" class="surfer-pagination flex justify-center pt-0">
            <APagination
              :current="current"
              :page-size="size"
              :total="total"
              :show-size-changer="false"
              @change="goPage"
            />
          </div>
        </section>
      </ACol>

      <!-- ---- Sidebar (Right) ---- -->
      <ACol :xs="24" :lg="7" class="mt-0 lg:mt-0">
        <SidebarRight />
      </ACol>
    </ARow>
  </main>
</template>

<style scoped lang="scss">
.slide-hero {
  margin-left: -16px;
  margin-right: -16px;
}

.card,
.empty-card,
.home-skeleton-card {
  border: 1px solid rgb(62 207 154 / 50%);
  border-radius: 24px;
  background: rgb(255 255 255);
  box-shadow: 0 4px 24px rgba(0, 0, 0, 0.06);
}
.home-skeleton-card {
  display: flex;
  min-height: 190px;
  overflow: hidden;
  animation: pulse 1.6s ease-in-out infinite;
}
.home-skeleton-cover {
  width: 42%;
  min-width: 42%;
  background: linear-gradient(135deg, rgb(62 207 154 / 13%), rgb(62 207 154 / 5%));
  clip-path: polygon(0 0, 90% 0, 100% 100%, 0 100%);
}
.home-skeleton-body {
  display: flex;
  min-width: 0;
  flex: 1;
  flex-direction: column;
  justify-content: center;
  gap: 14px;
  padding: 24px 32px;
}
.home-skeleton-line,
.home-skeleton-meta span,
.home-skeleton-tags span {
  display: block;
  border-radius: 999px;
  background: rgb(62 207 154 / 12%);
}
.home-skeleton-title {
  width: min(68%, 360px);
  height: 26px;
}
.home-skeleton-summary {
  width: 92%;
  height: 14px;
}
.home-skeleton-summary-short {
  width: 64%;
  height: 14px;
}
.home-skeleton-meta,
.home-skeleton-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}
.home-skeleton-meta span {
  width: 88px;
  height: 20px;
}
.home-skeleton-tags span {
  width: 64px;
  height: 24px;
}
.empty-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 56px 24px;
}
.empty-icon {
  display: flex;
  width: 72px;
  height: 72px;
  align-items: center;
  justify-content: center;
  border-radius: 24px;
  background: linear-gradient(135deg, rgb(62 207 154 / 18%), rgb(127 231 191 / 30%));
  color: #3ecf9a;
  font-size: 32px;
  font-weight: 900;
  box-shadow: 0 16px 38px rgb(62 207 154 / 18%);
}

.tag-pill {
  border-radius: 999px;
  background: rgb(62 207 154 / 10%);
  padding: 5px 10px;
  color: #3ecf9a;
  font-size: 12px;
  font-weight: 700;
}

.card {
  transition: 0.3s;
}
.card:hover {
  transform: scale(1.015);
  border-color: rgb(62 207 154 / 40%);
}
@media (max-width: 639px) {
  .card,
  .home-skeleton-card {
    min-height: 154px;
    overflow: visible;
    border-color: rgb(62 207 154 / 30%);
    border-radius: 28px;
    background:
      radial-gradient(circle at 6% 0%, rgb(62 207 154 / 9%), transparent 38%),
      linear-gradient(135deg, rgb(255 255 255 / 96%), rgb(247 255 251 / 92%));
    box-shadow: 0 14px 36px rgb(62 207 154 / 10%);
  }

  .home-skeleton-cover {
    width: 112px;
    min-width: 112px;
    height: 118px;
    align-self: center;
    margin: 10px 0 10px 16px;
    border-radius: 18px;
    clip-path: none;
  }

  .home-skeleton-body {
    gap: 10px;
    padding: 18px 14px 18px 14px;
  }

  .home-skeleton-title {
    width: 82%;
    height: 22px;
  }

  .home-skeleton-summary-short,
  .home-skeleton-tags {
    display: none;
  }

  .home-skeleton-meta span {
    width: 70px;
    height: 18px;
  }

  .home-skeleton-meta span:nth-child(3) {
    display: none;
  }

  .card-cover-glow {
    display: none;
  }

  .card:hover {
    transform: none;
  }

  .dark .card {
    border-color: rgb(83 157 253 / 22%);
    background:
      radial-gradient(circle at 6% 0%, rgb(83 157 253 / 12%), transparent 38%),
      linear-gradient(135deg, rgb(30 41 59 / 94%), rgb(15 23 42 / 92%));
    box-shadow: 0 14px 36px rgb(83 157 253 / 10%);
  }
}
@media (max-width: 374px) {
  .mobile-cover {
    width: 98px;
    min-width: 98px;
    height: 108px;
    margin: 10px 0 10px 10px;
  }

  .mobile-category-pill {
    max-width: 76px;
    padding-inline: 10px;
  }
}
.cover {
  position: relative;
  z-index: 20;
  display: none;
  min-width: 42%;
  overflow: hidden;
}
.mobile-cover {
  position: relative;
  z-index: 20;
  width: 112px;
  min-width: 112px;
  height: 118px;
  align-self: center;
  overflow: hidden;
  border-radius: 18px;
  margin: 10px 0 10px 16px;
  box-shadow: 0 10px 28px rgb(62 207 154 / 14%);
}
.mobile-cover span {
  display: block;
  width: 100%;
  height: 100%;
  background-position: center;
  background-size: cover;
  transition: 0.5s;
}
.group:hover .mobile-cover span {
  transform: scale(1.08);
}
.mobile-category-pill {
  display: inline-flex;
  max-width: 9em;
  align-items: center;
  overflow: hidden;
  border-radius: 999px;
  background: rgb(62 207 154 / 12%);
  padding: 5px 10px;
  color: #15956b;
  font-size: 12px;
  font-weight: 700;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.mobile-date {
  flex-shrink: 0;
  color: #8aa093;
  font-size: 13px;
  font-weight: 700;
}
.top-badge {
  top: -10px;
  right: 12px;
  bottom: auto;
}
@media (min-width: 640px) {
  .top-badge {
    top: 12px;
    right: 12px;
    bottom: auto;
  }
}
.cover span {
  display: block;
  width: 100%;
  height: 100%;
  background-position: center;
  background-size: cover;
  transition: 0.5s;
}
.group:hover .cover span {
  transform: scale(1.1);
}
@media (min-width: 640px) {
  .cover {
    display: block;
  }
}
.left-cover {
  clip-path: polygon(0 0, 90% 0, 100% 100%, 0 100%);
}
.right-cover {
  clip-path: polygon(10% 0, 100% 0, 100% 100%, 0 100%);
}
.tag {
  border-radius: 999px;
  background: rgb(62 207 154 / 10%);
  padding: 5px 10px;
  color: #3ecf9a;
  font-size: 12px;
  font-weight: 700;
}
.tag:hover {
  background: rgb(62 207 154 / 16%);
  color: #3ecf9a;
}

.meta-icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 23px;
  height: 23px;
  border-radius: 50%;
  padding: 4px;
  margin-top: -2px;
  margin-right: 3px;
  vertical-align: middle;
  color: #fff;
  > svg,
  :deep(.anticon) {
    width: 14px;
    height: 14px;
  }
  :deep(svg) {
    width: 14px;
    height: 14px;
  }
}
.meta-icon-category {
  background: #4fa759;
  color: #fff;
}
.meta-icon-time {
  background: #ea3b24;
  color: #fff;
}
.meta-icon-read {
  background: #f59e0b;
  color: #fff;
}
.dark .card,
.dark .empty-card,
.dark .home-skeleton-card {
  border-color: rgb(51 65 85);
  background: rgb(44 51 62 / 88%);
  box-shadow: 0 18px 52px rgb(83 157 253 / 8%);
}
.dark .home-skeleton-cover,
.dark .home-skeleton-line,
.dark .home-skeleton-meta span,
.dark .home-skeleton-tags span {
  background: rgb(83 157 253 / 10%);
}
.dark .mobile-category-pill {
  background: rgb(83 157 253 / 14%);
  color: #7fb8ff;
}
.dark .mobile-date {
  color: #94a3b8;
}
.dark .tag {
  background: rgb(83 157 253 / 8%);
  color: #539dfd;
}
.dark .empty-icon {
  background: rgb(83 157 253 / 10%);
  color: #539dfd;
  box-shadow: 0 16px 38px rgb(83 157 253 / 14%);
}
</style>
