<template>
  <!-- 主内容区域 -->
  <main class="container max-w-7xl mx-auto px-4 md:px-6 py-4">
    <!-- grid 表格布局，分为 4 列 -->
    <div class="grid grid-cols-4 gap-7">
      <!-- 左边栏，占用 3 列 -->
      <div class="mt-[40px] col-span-4 md:col-span-3 mb-3">
        <!-- 标签 -->
        <div v-if="tags && tags.length > 0"
          class="theme-bg-secondary theme-text-primary tag-container w-full p-5 pb-7 mb-3 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
          <!-- 标签标题 -->
          <h2 class="theme-bg-secondary theme-text-primary tag-title flex items-center mb-5 font-bold ">
            <!-- 标签图标 -->
            <TagOutlined class="tag-icon icon w-4 h-4 mr-2" />
            标签
            <span class="theme-bg-secondary theme-text-primary ml-2" >
              ( {{ tags.length }} )
              </span>
          </h2>
          <!-- 标签列表 -->
          <div class="flex flex-wrap gap-3">
            <a v-for="(tag, index) in tags" :key="index" @click="goTagArticleListPage(tag.id, tag.name)" 
              class="tag-item cursor-pointer hover:bg-gray-400 dark:hover:bg-gray-700 inline-flex items-center px-3.5 py-1.5 text-xs font-medium text-center border rounded-xl
               focus:ring-4 focus:outline-none focus:ring-gray-300 dark:bg-gray-800 dark:text-gray-300 
               dark:focus:ring-gray-800 dark:border-gray-700 dark:hover:text-white" >
              {{ tag.name }}
              <span class="tag-count inline-flex items-center justify-center w-4 h-4 ml-2 text-xs font-semibold text-sky-800 bg-sky-200 rounded-full" >
                {{ tag.articlesTotal }}
              </span>
            </a>
          </div>
        </div>
      </div>

      <!-- 右边侧边栏，占用一列 -->
      <aside class="col-span-4 md:col-span-1 mt-[40px] mb-3">
        <div class="sticky top-[40px]">
          <!-- 博主信息 -->
          <UserInfoCard></UserInfoCard>
          <!-- 分类 -->
          <CategoryListCard></CategoryListCard>
          <!-- 知识库 -->
          <WikiListCard></WikiListCard>
        </div>
      </aside>
    </div>
  </main>
</template>

<script setup lang="ts">
import UserInfoCard from "@/layouts/surfer/components/UserInfoCard.vue";
import CategoryListCard from "@/layouts/surfer/components/CategoryListCard.vue";
import WikiListCard from '@/layouts/surfer/components/WikiListCard.vue'
import { TagOutlined } from "@ant-design/icons-vue";
import { getTagList } from "@/api/surfer/tag";
import { ref } from "vue";
import { useRouter } from "vue-router";
import type { Ref } from "vue";
import type { Router } from "vue-router";

// 定义标签类型
interface Tag {
  id: string | number;
  name: string;
  articlesTotal: number;
  sort: number;
}

// 定义API响应类型
interface ApiResponse<T> {
  success: boolean;
  data: T;
}

const router: Router = useRouter();

// 所有标签
const tags: Ref<Tag[]> = ref([]);
getTagList({}).then((res: ApiResponse<Tag[]>) => {
  if (res.success) {
    // 按sort字段降序排序，sort值大的在前面，sort值相同时按id升序
    tags.value = res.data.sort((a, b) => {
      const sortA = a.sort || 0;
      const sortB = b.sort || 0;
      if (sortA !== sortB) {
        return sortB - sortA; // 降序
      }
      return Number(a.id) - Number(b.id); // id升序
    });
  }
});

// 跳转标签文章列表页
const goTagArticleListPage = (id: string | number, name: string): void => {
  // 跳转时通过 query 携带参数（标签 ID、标签名称）
  router.push({ path: "/surfer/tag/article/list", query: { id, name } });
};
</script>

<style lang="scss" scoped>
// 标签容器样式
.tag-container {
  transition: all 0.3s ease;
  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
  }
}

// 标签标题样式
.tag-title {
  position: relative;
  margin-bottom: 16px;
  &::after {
    content: "";
    position: absolute;
    bottom: -8px;
    left: 0;
    width: 100%;
    height: 3px;
    background: linear-gradient(90deg, #3b82f6, #06b6d4);
    border-radius: 2px;
  }
}
// 标签项样式
.tag-item {
  position: relative;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  overflow: hidden;
  &::before {
    content: "";
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(
      90deg,
      transparent,
      rgba(255, 255, 255, 0.2),
      transparent
    );
    transition: left 0.5s;
  }
  &:hover {
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 8px 20px rgba(59, 130, 246, 0.15);
    border-color: #3b82f6;
    &::before {
      left: 100%;
    }
    .tag-count {
      background: linear-gradient(135deg, #3b82f6, #06b6d4);
      color: white;
      transform: scale(1.1);
    }
  }
  &:active {
    transform: translateY(0) scale(0.98);
  }
}

// 标签计数样式
.tag-count {
  transition: all 0.3s ease;
  background: linear-gradient(135deg, #0ea5e9, #06b6d4);

  @media (prefers-color-scheme: dark) {
    background: linear-gradient(135deg, #1e40af, #0369a1);
  }
}

// 标签图标动画
.tag-icon {
  transition: transform 0.3s ease;

  .tag-container:hover & {
    transform: rotate(10deg) scale(1.1);
  }
}

// 响应式设计
@media (max-width: 768px) {
  .tag-item {
    &:hover {
      transform: none;
      box-shadow: 0 4px 12px rgba(59, 130, 246, 0.1);
    }
  }
}

// 暗色模式适配
@media (prefers-color-scheme: dark) {
  .tag-item {
    &:hover {
      box-shadow: 0 8px 20px rgba(59, 130, 246, 0.2);
      border-color: #60a5fa;
    }
  }

  .tag-title::after {
    background: linear-gradient(90deg, #60a5fa, #22d3ee);
  }
}
</style>
