<script setup lang="ts">
import { computed, onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { DownOutlined, GithubOutlined, UpOutlined, ZhihuOutlined } from '@ant-design/icons-vue';
import { getBlogSettingsDetail } from '@/service/blog/surfer/setting';
import { getCategoryList } from '@/service/blog/surfer/category';
import { getStatisticsInfo } from '@/service/blog/surfer/statistics';
import { getTagList } from '@/service/blog/surfer/tag';
import { getColumnList } from '@/service/blog/surfer/column';
import GiteeIcon from '@/assets/system/svg/GitEE.svg';
import CsdnIcon from '@/assets/system/svg/CSDN.svg';
import WeChatIcon from '@/assets/blog/surfer/author/svg/wechat.svg';
import WechatOfficialAccountIcon from '@/assets/blog/surfer/author/svg/wechat-official-account.svg';
import SponsorIcon from '@/assets/blog/surfer/author/svg/sponsor.svg';
import DouyinIcon from '@/assets/blog/surfer/author/svg/douyin.svg';
import DefaultAvatar from '@/assets/system/svg/avatar.svg';
import WechatOfficialAccountQrCode from '@/assets/blog/surfer/author/img/wechat-official-account.jpg';
import WeixinGroupQrCode from '@/assets/blog/surfer/author/img/WeixinGroup.jpg';
import WeixinSponsorQrCode from '@/assets/blog/surfer/author/img/WeixinSponsor.jpg';

defineOptions({ name: 'SurferSidebar' });

defineProps<{
  hideCategories?: boolean;
  hideTags?: boolean;
  hideColumns?: boolean;
}>();

type Api<T> = { success: boolean; data: T };
type Category = { id: number; name: string; articlesTotal: number; sort?: number };
type Tag = { id: number; name: string; articlesTotal: number; sort?: number };
type Column = {
  id: number | string;
  title: string;
  cover?: string;
  articlesTotal: number;
  isTop?: boolean;
  firstArticleId: number | string;
  sort?: number;
  weight?: number;
};
type Settings = {
  author?: string;
  avatar?: string;
  introduction?: string;
  githubHomepage?: string;
  giteeHomepage?: string;
  csdnHomepage?: string;
  zhihuHomepage?: string;
  douyinHomepage?: string;
};
type Stat = {
  articleTotalCount: number;
  categoryTotalCount: number;
  tagTotalCount: number;
  columnTotalCount?: number;
  pvTotalCount: number;
};

const router = useRouter();
const categories = ref<Category[]>([]);
const tags = ref<Tag[]>([]);
const columns = ref<Column[]>([]);
const settings = ref<Settings>({});
const stat = ref<Stat>({ articleTotalCount: 0, categoryTotalCount: 0, tagTotalCount: 0, columnTotalCount: 0, pvTotalCount: 0 });
const loading = ref(true);
const defaultAvatar = DefaultAvatar;
const visibleCategoryLimit = 8;
const visibleTagLimit = 12;
const visibleColumnLimit = 5;
const isCategoriesExpanded = ref(false);
const isTagsExpanded = ref(false);
const isColumnsExpanded = ref(false);
const isWechatOfficialAccountQrCodeOpen = ref(false);
const isWeixinGroupQrCodeOpen = ref(false);
const isWeixinSponsorQrCodeOpen = ref(false);

function formatCount(n: number): string {
  if (n >= 10000) {
    const v = n / 10000;
    return v % 1 === 0 ? `${v}万` : `${v.toFixed(1)}万`;
  }
  if (n >= 1000) {
    const v = n / 1000;
    return v % 1 === 0 ? `${v}k` : `${v.toFixed(1)}k`;
  }
  return String(n);
}

const statCards = computed(() => [
  { label: '专栏', value: stat.value.columnTotalCount ?? 0 },
  { label: '文章', value: stat.value.articleTotalCount },
  { label: '分类', value: stat.value.categoryTotalCount },
  { label: '标签', value: stat.value.tagTotalCount },
  { label: '访问', value: stat.value.pvTotalCount }
]);

const hasSocialLinks = computed(() =>
  Boolean(
    settings.value.githubHomepage ||
    settings.value.giteeHomepage ||
    settings.value.csdnHomepage ||
    settings.value.zhihuHomepage ||
    settings.value.douyinHomepage
  )
);

const visibleCategories = computed(() =>
  isCategoriesExpanded.value ? categories.value : categories.value.slice(0, visibleCategoryLimit)
);
const visibleTags = computed(() => (isTagsExpanded.value ? tags.value : tags.value.slice(0, visibleTagLimit)));
const visibleColumns = computed(() => (isColumnsExpanded.value ? columns.value : columns.value.slice(0, visibleColumnLimit)));

const hasMoreCategories = computed(() => categories.value.length > visibleCategoryLimit);
const hasMoreTags = computed(() => tags.value.length > visibleTagLimit);
const hasMoreColumns = computed(() => columns.value.length > visibleColumnLimit);

function resolveImageUrl(url?: string) {
  if (!url) return defaultAvatar;
  if (/^(https?:|data:|blob:)/i.test(url)) return url;
  return url.startsWith('/') ? url : `/${url}`;
}

const authorAvatar = computed(() => resolveImageUrl(settings.value.avatar));

function handleAvatarError() {
  settings.value.avatar = defaultAvatar;
}

const byArticles = <T extends { id: number; articlesTotal?: number }>(list: T[]) =>
  [...list].sort((a, b) => (b.articlesTotal || 0) - (a.articlesTotal || 0) || a.id - b.id);

const byColumn = (list: Column[]) =>
  [...list].sort(
    (a, b) => (b.weight || 0) - (a.weight || 0) || (b.sort || 0) - (a.sort || 0) || Number(a.id) - Number(b.id)
  );

function goCategory(id?: number, name?: string) {
  if (id) router.push({ path: '/blog/surfer/category', query: { id: String(id), name } });
}
function goTag(id: number, name: string) {
  router.push({ path: '/blog/surfer/tag', query: { id: String(id), name } });
}
function goColumn(columnId: string | number, articleId: string | number) {
  router.push({ path: `/blog/surfer/column/${columnId}`, query: { articleId: String(articleId) } });
}
function jump(url: string) {
  window.open(url, '_blank', 'noopener,noreferrer');
}

onMounted(async () => {
  loading.value = true;
  try {
    const [s, st, c, t, w] = await Promise.all([
      getBlogSettingsDetail<Api<Settings>>().catch(() => null),
      getStatisticsInfo<Stat>().catch(() => null),
      getCategoryList<Api<Category[]>>().catch(() => null),
      getTagList<Api<Tag[]>>().catch(() => null),
      getColumnList<Api<Column[]>>().catch(() => null)
    ]);
    if (s?.success) settings.value = s.data || {};
    if (st?.success) stat.value = st.data || stat.value;
    if (c?.success) categories.value = byArticles(c.data || []);
    if (t?.success) tags.value = byArticles(t.data || []);
    if (w?.success) columns.value = byColumn(w.data || []);
  } finally {
    loading.value = false;
  }
});
</script>

<template>
  <aside class="space-y-4 lg:sticky lg:top-10">
    <section class="side-card text-center">
      <div v-if="loading" class="mx-auto h-20 w-20 animate-pulse rounded-full bg-[#3ecf9a]/10 dark:bg-white/8"></div>
      <template v-else>
        <img
          class="sidebar-avatar mx-auto h-20 w-20 object-cover"
          :src="authorAvatar"
          alt="作者头像"
          @error="handleAvatarError"
        />
        <h3 class="mt-3 text-xl font-black text-[#0d3d2d] dark:text-white">
          {{ settings.author || 'Mint Blog' }}
        </h3>
        <p class="mt-2 line-clamp-2 text-sm text-[#60786e] dark:text-[#cbd5e1]">
          {{ settings.introduction || 'Fresh content, gentle reading' }}
        </p>
      </template>
      <div class="mt-5 grid grid-cols-5 gap-1.5">
        <div
          v-for="item in statCards"
          :key="item.label"
          class="flex min-h-[58px] items-center justify-center rounded-2xl bg-[#3ecf9a]/10 px-1 py-2.5 text-center dark:bg-[#539dfd]/8"
        >
          <div class="flex min-w-8 flex-col items-center justify-center">
            <div
              class="w-full text-center font-mono text-sm font-black leading-none tabular-nums text-[#3ecf9a] dark:text-[#539dfd]"
            >
              {{ formatCount(item.value) }}
            </div>
            <div
              class="mt-1 w-full whitespace-nowrap text-center text-[11px] leading-none text-[#60786e] dark:text-[#cbd5e1]"
            >
              {{ item.label }}
            </div>
          </div>
        </div>
      </div>
    </section>

    <section v-if="hasSocialLinks" class="side-card">
      <h3 class="side-title">社交</h3>
      <div class="flex justify-center gap-3">
        <ATooltip v-if="settings.githubHomepage" title="GitHub" placement="bottom">
          <GithubOutlined
            class="text-[30px] text-[#557468] dark:text-[#cbd5e1] hover:text-[#3ecf9a] dark:hover:text-[#539dfd] cursor-pointer transition-colors"
            @click="jump(settings.githubHomepage!)"
          />
        </ATooltip>
        <ATooltip v-if="settings.giteeHomepage" title="Gitee" placement="bottom">
          <img
            :src="GiteeIcon"
            class="w-[30px] h-[30px] cursor-pointer hover:opacity-100 transition-opacity"
            alt="Gitee"
            @click="jump(settings.giteeHomepage!)"
          />
        </ATooltip>
        <ATooltip v-if="settings.csdnHomepage" title="CSDN" placement="bottom">
          <img
            :src="CsdnIcon"
            class="w-[30px] h-[30px] cursor-pointer hover:opacity-100 transition-opacity"
            alt="CSDN"
            @click="jump(settings.csdnHomepage!)"
          />
        </ATooltip>
        <!-- <ATooltip v-if="settings.zhihuHomepage" title="知乎" placement="bottom">
          <ZhihuOutlined
            class="text-[30px] text-[#557468] dark:text-[#cbd5e1] hover:text-[#3ecf9a] dark:hover:text-[#539dfd] cursor-pointer transition-colors"
            @click="jump(settings.zhihuHomepage!)"
          />
        </ATooltip> -->
        <ATooltip title="抖音" placement="bottom">
          <img
            :src="DouyinIcon"
            class="w-[30px] h-[30px] cursor-pointer hover:opacity-100 transition-opacity"
            alt="Douyin"
            @click="jump(settings.douyinHomepage!)"
          />
        </ATooltip>

        <ATooltip title="微信公众号" placement="bottom">
          <img
            :src="WechatOfficialAccountIcon"
            class="w-[30px] h-[30px] cursor-pointer hover:opacity-100 transition-opacity"
            alt="微信公众号"
            @click="isWechatOfficialAccountQrCodeOpen = true"
          />
        </ATooltip>
        <ATooltip title="微信" placement="bottom">
          <img
            :src="WeChatIcon"
            class="w-[30px] h-[30px] cursor-pointer hover:opacity-100 transition-opacity"
            alt="微信"
            @click="isWeixinGroupQrCodeOpen = true"
          />
        </ATooltip>
        <ATooltip title="打赏" placement="bottom">
          <img
            :src="SponsorIcon"
            class="w-[30px] h-[30px] cursor-pointer hover:opacity-100 transition-opacity"
            alt="打赏"
            @click="isWeixinSponsorQrCodeOpen = true"
          />
        </ATooltip>

      </div>
    </section>

    <section v-if="!hideCategories" class="side-card">
      <h3 class="side-title">分类</h3>
      <div v-if="categories.length" class="flex flex-wrap gap-2">
        <button v-for="c in visibleCategories" :key="c.id" class="tag" @click="goCategory(c.id, c.name)">
          <span class="tag-name">{{ c.name }}</span><span class="tag-count">{{ c.articlesTotal }}</span>
        </button>
      </div>
      <button v-if="hasMoreCategories" class="side-more" @click="isCategoriesExpanded = !isCategoriesExpanded">
        {{ isCategoriesExpanded ? '收起分类' : `展开全部 ${categories.length}` }}
        <UpOutlined v-if="isCategoriesExpanded" class="text-[10px]" />
        <DownOutlined v-else class="text-[10px]" />
      </button>
      <div v-if="!categories.length" class="mini-empty">暂无分类，发布文章后会自动归档。</div>
    </section>

    <section v-if="!hideTags" class="side-card">
      <h3 class="side-title">标签</h3>
      <div v-if="tags.length" class="flex flex-wrap gap-2">
        <button v-for="tag in visibleTags" :key="tag.id" class="tag" @click="goTag(tag.id, tag.name)">
          <span class="tag-name">{{ tag.name }}</span><span class="tag-count">{{ tag.articlesTotal ?? 0 }}</span>
        </button>
      </div>
      <button v-if="hasMoreTags" class="side-more" @click="isTagsExpanded = !isTagsExpanded">
        {{ isTagsExpanded ? '收起标签' : `展开全部 ${tags.length}` }}
        <UpOutlined v-if="isTagsExpanded" class="text-[10px]" />
        <DownOutlined v-else class="text-[10px]" />
      </button>
      <div v-if="!tags.length" class="mini-empty">暂无标签，后续内容会在这里聚合。</div>
    </section>

    <section v-if="!hideColumns" class="side-card">
      <h3 class="side-title">专栏</h3>
      <div v-if="columns.length">
        <button v-for="column in visibleColumns" :key="column.id" class="column" @click="goColumn(column.id, column.firstArticleId)">
          <img v-if="column.cover" :src="column.cover" alt="" class="h-9 w-9 rounded-xl object-cover" />
          <span class="min-w-0 flex-1 truncate text-left">{{ column.title }}</span>
          <span class="tag-count">{{ column.articlesTotal ?? 0 }}</span>
          <em v-if="column.isTop" class="text-xs text-red-500 not-italic">置顶</em>
        </button>
      </div>
      <button v-if="hasMoreColumns" class="side-more" @click="isColumnsExpanded = !isColumnsExpanded">
        {{ isColumnsExpanded ? '收起专栏' : `展开全部 ${columns.length}` }}
        <UpOutlined v-if="isColumnsExpanded" class="text-[10px]" />
        <DownOutlined v-else class="text-[10px]" />
      </button>
      <div v-if="!columns.length" class="mini-empty">暂无专栏，专题内容整理后会展示在这里。</div>
    </section>

    <AModal v-model:open="isWechatOfficialAccountQrCodeOpen" :footer="null" centered destroy-on-close title="微信公众号">
      <div class="flex justify-center py-2">
        <img :src="WechatOfficialAccountQrCode" alt="微信公众号二维码" class="max-h-[420px] max-w-full rounded-2xl object-contain" />
      </div>
    </AModal>

    <AModal v-model:open="isWeixinGroupQrCodeOpen" :footer="null" centered destroy-on-close title="微信">
      <div class="flex justify-center py-2">
        <img :src="WeixinGroupQrCode" alt="微信二维码" class="max-h-[420px] max-w-full rounded-2xl object-contain" />
      </div>
    </AModal>

    <AModal v-model:open="isWeixinSponsorQrCodeOpen" :footer="null" centered destroy-on-close title="打赏">
      <div class="flex justify-center py-2">
        <img :src="WeixinSponsorQrCode" alt="打赏二维码" class="max-h-[420px] max-w-full rounded-2xl object-contain" />
      </div>
    </AModal>
  </aside>
</template>

<style scoped lang="scss">
.side-card {
  border: 1px solid rgb(62 207 154 / 15%);
  border-radius: 24px;
  background: rgb(255 255 255 / 88%);
  box-shadow: 0 18px 52px rgb(62 207 154 / 10%);
  backdrop-filter: blur(16px);
  padding: 20px;
  transition:
    transform 0.3s,
    border-color 0.3s,
    box-shadow 0.3s;
}
.side-card:hover {
  transform: translateY(-4px);
  border-color: rgb(62 207 154 / 40%);
  box-shadow: 0 24px 60px rgb(62 207 154 / 16%);
}
.sidebar-avatar {
  flex-shrink: 0;
  border: 3px solid rgb(255 255 255 / 90%);
  border-radius: 52% 48% 46% 54% / 48% 52% 48% 52%;
  animation:
    sidebar-avatar-float 4s ease-in-out infinite,
    sidebar-avatar-glow 2.8s ease-in-out infinite alternate,
    sidebar-avatar-morph 7s ease-in-out infinite;
  box-shadow:
    0 0 0 6px rgb(83 157 253 / 10%),
    0 12px 34px rgb(83 157 253 / 20%),
    0 0 42px rgb(83 157 253 / 18%);
  transition:
    transform 0.3s ease,
    box-shadow 0.3s ease,
    border-color 0.3s ease;
}
.sidebar-avatar:hover {
  border-radius: 48% 52% 55% 45% / 53% 46% 54% 47%;
  transform: translateY(-4px) scale(1.08) rotate(3deg);
  box-shadow:
    0 0 0 8px rgb(83 157 253 / 14%),
    0 16px 44px rgb(83 157 253 / 28%),
    0 0 56px rgb(83 157 253 / 26%);
}
@keyframes sidebar-avatar-float {
  0%,
  100% {
    transform: translateY(0);
  }

  50% {
    transform: translateY(-7px);
  }
}
@keyframes sidebar-avatar-glow {
  from {
    box-shadow:
      0 0 0 5px rgb(83 157 253 / 8%),
      0 10px 30px rgb(83 157 253 / 16%),
      0 0 32px rgb(83 157 253 / 14%);
  }

  to {
    box-shadow:
      0 0 0 8px rgb(83 157 253 / 14%),
      0 16px 44px rgb(83 157 253 / 26%),
      0 0 54px rgb(83 157 253 / 24%);
  }
}
@keyframes sidebar-avatar-morph {
  0%,
  100% {
    border-radius: 52% 48% 46% 54% / 48% 52% 48% 52%;
  }

  25% {
    border-radius: 44% 56% 52% 48% / 58% 44% 56% 42%;
  }

  50% {
    border-radius: 58% 42% 45% 55% / 45% 58% 42% 55%;
  }

  75% {
    border-radius: 47% 53% 58% 42% / 52% 45% 55% 48%;
  }
}
.side-title {
  margin-bottom: 12px;
  color: #0d3d2d;
  font-weight: 900;
  white-space: nowrap;
}
.tag {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  border-radius: 999px;
  background: rgb(62 207 154 / 10%);
  padding: 5px 10px;
  color: #3ecf9a;
  font-size: 12px;
  font-weight: 700;
}
.tag-name {
  max-width: 140px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.tag-count {
  flex-shrink: 0;
  border-radius: 999px;
  background: rgb(21 149 107 / 12%);
  padding: 1px 6px;
  color: #1ab782;
  font-size: 11px;
  font-weight: 900;
  line-height: 1.4;
}
.column {
  display: flex;
  align-items: center;
  gap: 10px;
  width: 100%;
  padding: 8px;
  border-radius: 14px;
  font-size: 13px;
  font-weight: 700;
  color: #60786e;
  transition: 0.2s;
  &:hover {
    background: rgb(62 207 154 / 10%);
  }
}
.side-more {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 4px;
  width: 100%;
  margin-top: 12px;
  padding: 7px 10px;
  border: 1px solid rgb(62 207 154 / 14%);
  border-radius: 999px;
  background: rgb(62 207 154 / 8%);
  color: #15956b;
  cursor: pointer;
  font-size: 12px;
  font-weight: 800;
  transition:
    background 0.2s,
    color 0.2s,
    transform 0.2s;

  &:hover {
    background: rgb(62 207 154 / 14%);
    transform: translateY(-1px);
  }
}
.mini-empty {
  font-size: 12px;
  color: #a0b8ad;
  padding: 8px 0;
}
.dark {
  .side-card {
    background: rgb(44 51 62 / 72%);
    border-color: rgb(51 65 85);
    box-shadow: 0 18px 52px rgb(83 157 253 / 8%);
    &:hover {
      border-color: rgb(83 157 253 / 40%);
      box-shadow: 0 24px 60px rgb(83 157 253 / 14%);
    }
  }
  .side-title {
    color: #cbd5e1;
  }
  .sidebar-avatar {
    border-color: rgb(148 190 255 / 22%);
    box-shadow:
      0 0 0 6px rgb(83 157 253 / 10%),
      0 12px 34px rgb(83 157 253 / 18%),
      0 0 42px rgb(83 157 253 / 16%);
  }
  .sidebar-avatar:hover {
    box-shadow:
      0 0 0 8px rgb(83 157 253 / 14%),
      0 16px 44px rgb(83 157 253 / 26%),
      0 0 56px rgb(83 157 253 / 24%);
  }
  .side-more {
    border-color: rgb(83 157 253 / 18%);
    background: rgb(83 157 253 / 8%);
    color: #8cc8ff;

    &:hover {
      background: rgb(83 157 253 / 14%);
    }
  }
  .mini-empty {
    color: #94a3b8;
  }
}
</style>
