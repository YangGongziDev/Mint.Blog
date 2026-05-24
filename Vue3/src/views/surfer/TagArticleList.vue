<template>
  <!-- 主内容区域 -->
  <main class="container max-w-7xl mx-auto px-4 md:px-6 py-4">
    <!-- grid 表格布局，分为 4 列 -->
    <div class="grid grid-cols-4 gap-7">
      <!-- 左边栏，占用 3 列 -->
      <div class="mt-[40px] col-span-4 md:col-span-3 mb-3">
        <!-- 标签 -->
        <!-- 标签区域：固定在当前位置（粘性顶部） -->
        <div v-if="tags && tags.length > 0"
          class="theme-bg-secondary theme-text-primary w-full p-5 pb-7 mb-3 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700 sticky top-0 z-20 shadow-sm"
        >
          <!-- 标签标题 -->
          <h2 class="theme-bg-secondary theme-text-primary flex items-center mb-5 font-bold" >
            <!-- 标签图标 -->
            <TagOutlined class="w-[19.2px] h-[19.2px] mr-2" />
            标签
            <span class="theme-bg-secondary theme-text-primary ml-2" >( {{ tags.length }} )</span>
          </h2>
          <div class="flex flex-wrap gap-3">
            <a v-for="(tag, index) in tags" :key="index" @click="goTagArticleListPage(tag.id, tag.name)" 
              :class="[ route.query.name == tag.name ? 'active bg-sky-100 hover:bg-sky-200' : 'hover:bg-gray-400', ]"
              class="tag-item cursor-pointer inline-flex items-center px-3.5 py-1.5 text-xs font-medium text-center border rounded-xl focus:ring-4 focus:outline-none focus:ring-gray-300 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700 dark:focus:ring-gray-800 dark:border-gray-700 dark:hover:text-white" >
              {{ tag.name }}
              <span class="theme-bg-secondary theme-text-primary tag-count inline-flex items-center justify-center w-4 h-4 ml-2 text-xs font-semibold text-sky-800 bg-sky-200 rounded-full" >
                {{ tag.articlesTotal }}
              </span>
            </a>
          </div>
        </div>
        <!-- 标签文章列表 -->
        <div class="theme-bg-secondary theme-text-primary p-5 mb-4 border border-gray-200 rounded-lg bg-white dark:bg-gray-800 dark:border-gray-700" >
          <ol v-if="articles && articles.length > 0" class="divide-y divide-gray-200 dark:divide-gray-700" >
            <li v-for="(article, index) in articles" :key="index">
              <a @click="goArticleDetailPage(article.id)" class="article-item cursor-pointer items-center block p-3 sm:flex hover:bg-gray-400 hover:rounded-lg dark:hover:bg-gray-700" >
                <img class="article-image w-24 h-12 mb-3 mr-3 rounded-lg sm:mb-0" :src="article.cover" />
                <div class="">
                  <h2 class="theme-text-primary text-base font-normal">
                    {{ article.title }}
                  </h2>
                  <span class="theme-text-primary inline-flex items-center text-xs font-normal text-gray-500 dark:text-gray-400" >
                    <CalendarOutlined class="inline w-2.5 h-2.5 mr-2 text-gray-400" />
                    {{ article.createDate }}
                  </span>
                </div>
              </a>
            </li>
          </ol>

          <!-- 该标签下没有文章提示，指定为 flex 布局，内容垂直水平居中，并纵向排列  -->
          <div
            v-else
            class="empty-state flex items-center justify-center flex-col"
          >
            <img
              src="../../assets/Empty.svg"
              alt="暂无文章"
              class="w-80 h-60 mb-4"
            />
            <p class="empty-text mt-2 mb-16 text-gray-400">
              此标签下还未发布文章哟~
            </p>
          </div>
        </div>

        <!-- 分页 -->
        <nav
          aria-label="Page navigation example"
          class="pagination mt-10 flex justify-center"
          v-if="total > 0"
        >
          <ul class="flex items-center -space-x-px h-10 text-base">
            <!-- 上一页 -->
            <li>
              <a
                @click="getTagArticles(current - 1)"
                class="page-item flex items-center justify-center px-4 h-10 ml-0 leading-tight text-gray-500 bg-white border border-gray-300 rounded-l-lg hover:bg-gray-00 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                :class="[current > 1 ? '' : 'disabled cursor-not-allowed']"
              >
                <span class="sr-only">上一页</span>
                <LeftOutlined class="w-3 h-3" />
              </a>
            </li>
            <!-- 页码 -->
            <li v-for="(pageNo, index) in pages" :key="index">
              <a @click="getTagArticles(pageNo)"
                class="page-item flex items-center justify-center px-4 h-10 leading-tight border dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                :class="[ pageNo == current
                    ? 'active text-sky-600  bg-sky-50 border-sky-500 hover:bg-sky-100 hover:text-sky-700'
                    : 'text-gray-500 border-gray-300 bg-white hover:bg-gray-100 hover:text-gray-700',
                ]"
              >
                {{ index + 1 }}
              </a>
            </li>
            <!-- 下一页 -->
            <li>
              <a @click="getTagArticles(current + 1)"
                class="page-item flex items-center justify-center px-4 h-10 leading-tight text-gray-500 bg-white border border-gray-300 rounded-r-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                :class="[current < pages ? '' : 'disabled cursor-not-allowed']"
              >
                <span class="sr-only">下一页</span>
                <RightOutlined class="w-3 h-3" />
              </a>
            </li>
          </ul>
        </nav>
      </div>
      <!-- 右边侧边栏，占用一列 -->
      <aside class="col-span-4 md:col-span-1 mt-[40px] mb-3">
        <div class="sticky top-[40px]">
          <!-- 博主信息 -->
          <UserInfoCard></UserInfoCard>
          <!-- 分类 -->
          <CategoryListCard></CategoryListCard>
          <!-- 标签 -->
          <TagListCard></TagListCard>
        </div>
      </aside>
    </div>
  </main>
</template>

<script setup lang="ts">
import UserInfoCard from "@/layouts/surfer/components/UserInfoCard.vue";
import TagListCard from "@/layouts/surfer/components/TagListCard.vue";
import CategoryListCard from "@/layouts/surfer/components/CategoryListCard.vue";
import { ref, watch } from "vue";
import { useRoute, useRouter } from "vue-router";
import { getTagArticlePageList, getTagList } from "@/api/surfer/tag.ts";
import {
  TagOutlined,
  CalendarOutlined,
  LeftOutlined,
  RightOutlined,
} from "@ant-design/icons-vue";
import type { Ref } from "vue";
import type { RouteLocationNormalizedLoaded, Router } from "vue-router";

// 定义文章类型
interface Article {
  id: string | number;
  title: string;
  cover: string;
  createDate: string;
}

// 定义标签类型
interface Tag {
  id: string | number;
  name: string;
  articlesTotal: number;
}

// 定义API响应类型
interface ApiResponse<T> {
  success: boolean;
  data: T;
  current?: number;
  size?: number;
  total?: number;
  pages?: number;
}

const route: RouteLocationNormalizedLoaded = useRoute();
const router: Router = useRouter();

// 文章集合
const articles: Ref<Article[]> = ref([]);
// 标签名称
const tagName: Ref<string> = ref(route.query.name as string);
// 标签 ID
const tagId: Ref<string | number> = ref(route.query.id as string | number);

// 监听路由
watch(route, (newRoute, oldRoute) => {
  tagName.value = newRoute.query.name as string;
  tagId.value = newRoute.query.id as string | number;
  getTagArticles(current.value);
});

// 当前页码
const current: Ref<number> = ref(1);
// 每页显示的文章数
const size: Ref<number> = ref(10);
// 总文章数
const total: Ref<number> = ref(0);
// 总共多少页
const pages: Ref<number> = ref(0);

function getTagArticles(currentNo: number): void {
  // 上下页是否能点击判断，当要跳转上一页且页码小于 1 时，则不允许跳转；当要跳转下一页且页码大于总页数时，则不允许跳转
  if (currentNo < 1 || (pages.value > 0 && currentNo > pages.value)) return;
  // 调用分页接口渲染数据
  getTagArticlePageList({
    current: currentNo,
    size: size.value,
    id: tagId.value,
  }).then((res: ApiResponse<Article[]>) => {
    if (res.success) {
      articles.value = res.data;
      current.value = res.current || 1;
      size.value = res.size || 10;
      total.value = res.total || 0;
      pages.value = res.pages || 0;
    }
  });
}
getTagArticles(current.value);

// 跳转文章详情页
const goArticleDetailPage = (articleId: string | number): void => {
  router.push("/surfer/article/" + articleId);
};

// 所有标签
const tags: Ref<Tag[]> = ref([]);
getTagList({}).then((res: ApiResponse<Tag[]>) => {
  if (res.success) {
    tags.value = res.data;
  }
});

// 跳转标签文章列表页
const goTagArticleListPage = (id: string | number, name: string): void => {
  // 跳转时通过 query 携带参数（标签 ID、标签名称）
  router.push({ path: "/surfer/tag/article/list", query: { id, name } });
};
</script>

<style lang="scss" scoped>
// 标签样式增强
.tag-item {
  transition: all 0.3s ease;

  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  }

  &.active {
    background: linear-gradient(135deg, #0ea5e9, #0284c7);
    color: white;

    .tag-count {
      background-color: rgba(255, 255, 255, 0.2);
      color: white;
    }
  }
}

// 文章列表项样式
.article-item {
  transition: all 0.3s ease;
  border-radius: 12px;

  &:hover {
    transform: translateX(8px);
    /* background-color: #f8fafc; */

    .article-image {
      transform: scale(1.05);
    }
  }

  .article-image {
    transition: transform 0.3s ease;
    object-fit: cover;
  }
}

// 分页样式增强
.pagination {
  .page-item {
    transition: all 0.3s ease;

    &:hover:not(.disabled) {
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    &.active {
      background: linear-gradient(135deg, #0ea5e9, #0284c7);
      border-color: #0ea5e9;
    }

    &.disabled {
      opacity: 0.5;
      cursor: not-allowed;
    }
  }
}

// 空状态样式
.empty-state {
  .empty-icon {
    opacity: 0.6;
    filter: grayscale(20%);
  }

  .empty-text {
    color: #64748b;
    font-size: 16px;
  }
}

// 响应式设计
@media (max-width: 768px) {
  .tag-item {
    font-size: 12px;
    padding: 8px 12px;
  }

  .article-item {
    padding: 12px;

    .article-image {
      width: 80px;
      height: 40px;
    }
  }
}

// 深色模式适配
@media (prefers-color-scheme: dark) {
  .article-item:hover {
    background-color: #1f2937;
  }

  .tag-item {
    &:hover {
      background-color: #374151;
    }
  }
}
</style>
