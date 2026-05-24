<template>
    <!-- 主内容区域 -->
    <main class="container max-w-screen-xl mx-auto px-4 md:px-6 py-4">
        <!-- grid 表格布局，分为 4 列 -->
        <div class="grid grid-cols-4 gap-7">
            <!-- 左边栏，占用 3 列 -->
            <div class="mt-[40px] col-span-4 md:col-span-3 mb-3">
                <!-- 分类列表 -->
                <div class="theme-bg-secondary theme-text-primary category-container w-full p-5 pb-7 mb-3 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
                    <!-- 分类标题 -->
                    <h2 class="category-title flex items-center mb-5 font-bold">
                        <!-- 文件夹图标 -->
                        <FolderOutlined class="inline icon w-5 h-5 mr-2" />
                        分类
                        <span v-if="categories && categories.length > 0" class="theme-bg-secondary theme-text-primary ml-2">( {{ categories.length }} )</span>
                    </h2>
                    <!-- 分类列表 -->
                    <div class="text-sm flex flex-wrap gap-3 font-medium text-gray-600 rounded-lg dark:border-gray-600 dark:text-white">
                        <a @click="goCategoryArticleListPage(category.id, category.name)"
                            v-for="(category, index) in categories" :key="index"
                            class="theme-text-primary cursor-pointer inline-flex items-center px-4 py-2 text-xs font-medium text-center border rounded-lg 
                              hover:bg-gray-400 dark:hover:bg-gray-700 focus:ring-4 focus:outline-none focus:ring-gray-300 
                              dark:bg-gray-800 dark:text-gray-300 dark:focus:ring-gray-800 dark:border-gray-700 dark:hover:text-white">
                            {{ category.name }}
                            <span class="inline-flex items-center justify-center w-4 h-4 ms-2 text-xs font-semibold text-sky-800 bg-sky-200 rounded-full">
                                {{ category.articlesTotal }}
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
                    <!-- 标签 -->
                    <TagListCard></TagListCard>
                    <!-- 知识库 -->
                    <WikiListCard></WikiListCard>
                </div>
            </aside>
        </div>

    </main>
</template>

<script setup lang="ts">
import UserInfoCard from '@/layouts/surfer/components/UserInfoCard.vue'
import TagListCard from '@/layouts/surfer/components/TagListCard.vue'
import WikiListCard from '@/layouts/surfer/components/WikiListCard.vue'
import { FolderOutlined } from '@ant-design/icons-vue'
import { getCategoryList } from '@/api/surfer/category.ts'
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import type { Ref } from 'vue'

// 定义分类接口
interface Category {
  id: number
  name: string
  articlesTotal: number
  sort: number
}

// 定义分页响应接口
interface PageResponse<T> {
  success: boolean
  data: T[]
  current: number
  size: number
  total: number
  pages: number
}

const router = useRouter()

// 跳转分类文章列表页
const goCategoryArticleListPage = (id: number, name: string): void => {
    // 跳转时通过 query 携带参数（分类 ID、分类名称）
    router.push({ path: '/surfer/category/article/list', query: { id: String(id), name } })
}

// 所有分类
const categories: Ref<Category[]> = ref([])
getCategoryList({}).then((res: PageResponse<Category>) => {
    if (res.success) {
        // 对分类按sort字段降序排序，sort相同时按id升序排序
        const sortedCategories = res.data.sort((a, b) => {
            if (a.sort !== b.sort) {
                return b.sort - a.sort; // sort降序
            }
            return a.id - b.id; // id升序
        });
        categories.value = sortedCategories
    }
})
</script>

<style scoped lang="scss">
// 分类列表页面样式
.category-container {
    transition: all 0.3s ease;
    &:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    }
    // 分类标题样式
    .category-title {
      position: relative;
      margin-bottom: 16px;
      &::after {
        content: '';
        position: absolute;
        bottom: -8px;
        left: 0;
        width: 100%;
        height: 3px;
        background: linear-gradient(90deg, #3b82f6, #06b6d4);
        border-radius: 2px;
      }
    }
}
// 分类标签样式
.category-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  
  .category-tag {
    display: inline-flex;
    align-items: center;
    padding: 8px 16px;
    font-size: 12px;
    font-weight: 500;
    text-align: center;
    border: 1px solid;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
    
    &:hover {
      transform: translateY(-1px);
    }
    
    .article-count {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      width: 16px;
      height: 16px;
      margin-left: 8px;
      font-size: 12px;
      font-weight: 600;
      border-radius: 9999px;
    }
  }
}

// 侧边栏样式
.sidebar {
  position: sticky;
  top: 88px;
  
  .sidebar-card {
    margin-bottom: 24px;
    
    &:last-child {
      margin-bottom: 0;
    }
  }
}

// 响应式设计
@media (max-width: 768px) {
  .category-list {
    .category-tags {
      .category-tag {
        font-size: 14px;
        padding: 12px 20px;
      }
    }
  }
}

</style>
