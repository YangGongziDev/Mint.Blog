<template>
    <div class="wiki-list">
        <!-- 主内容区域 -->
        <main class="main-content container max-w-screen-xl mx-auto px-4 md:px-6 py-4">
            <!-- grid 表格布局，分为 4 列 -->
            <div class="grid grid-cols-12 gap-7 overflow-visible">
                <!-- 左边栏，占用 3 列 -->
                <div class="mt-[40px] col-span-12 md:col-span-8 lg:col-span-9 mb-3 overflow-visible">
                    <!-- grid 表格布局，分为 12 列 -->
                    <div class="wiki-grid grid grid-cols-12 gap-7 overflow-visible">
                        <div v-if="wikis && wikis.length > 0" v-for="(wiki, index) in wikis" :key="index" class="col-span-12 md:col-span-6 lg:col-span-4 animate__animated animate__fadeInUp overflow-visible">
                            <div class="theme-bg-secondary theme-text-primary wiki-card relative bg-white h-full border border-gray-200 rounded-lg hover:scale-[1.03] overflow-visible dark:bg-gray-800 dark:border-gray-700">
                                <!-- 知识库封面 -->
                                <!-- <a @click="goWikiArticleDetailPage(wiki.id, wiki.firstArticleId)" class="cursor-pointer"> -->
                                <div @click="goWikiArticleDetailPage(wiki.id, wiki.firstArticleId)" class="cursor-pointer">
                                    <img class="wiki-image rounded-t-lg h-36 w-full cursor-pointer"
                                    :src="wiki.cover" />
                                </div>
                                <div class="wiki-content p-5">
                                    <!-- 知识库标题 -->
                                    <div @click="goWikiArticleDetailPage(wiki.id, wiki.firstArticleId)" class="cursor-pointer">
                                        <h2 class="wiki-title mb-2 text-2xl font-bold tracking-tight">
                                            <span class="hover:border-gray-600 hover:border-b-2 dark:hover:border-gray-400">
                                                {{ wiki.title }}
                                                <div class="title-underline"></div>
                                            </span>
                                        </h2>
                                    </div>
                                    <!-- 知识库摘要 -->
                                    <p class="wiki-summary font-normal text-gray-500 dark:text-gray-400">
                                        {{ wiki.summary }}
                                    </p>
                                </div>

                                <!-- 是否置顶 -->
                                <div v-if="wiki.isTop" class="top-badge absolute inline-flex items-center justify-center w-14 h-7 text-xs font-bold text-white bg-red-500 border-2 border-white rounded-full -top-2 -end-2 z-10 dark:border-gray-900">
                                    置顶
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 右边侧边栏，占用一列 -->
                <aside class="sidebar col-span-12 md:col-span-4 lg:col-span-3 mt-[40px] mb-3">
                    <div class="sticky-container sticky top-[40px]">
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
    </div>
</template>

<script setup lang="ts">
import UserInfoCard from '@/layouts/surfer/components/UserInfoCard.vue'
import TagListCard from '@/layouts/surfer/components/TagListCard.vue'
import CategoryListCard from '@/layouts/surfer/components/CategoryListCard.vue'
import { getWikiList } from '@/api/surfer/wiki'
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import type { Ref } from 'vue'

// 定义Wiki接口
interface Wiki {
  id: string | number
  title: string
  summary: string
  cover: string
  isTop: boolean
  firstArticleId: string | number
  weight?: number  // 权重字段（优先级最高）
  sort?: number    // 排序字段
}

// 定义API响应接口
interface ApiResponse {
  success: boolean
  data: Wiki[]
}

const router = useRouter()

// 知识库
const wikis: Ref<Wiki[]> = ref([])
getWikiList().then((res: ApiResponse) => {
    if (res.success) {
        let wikiList = res.data || [];
        
        // 分两步排序：第一步处理weight>0的数据，第二步处理其他数据
        
        // 第一步：筛选出weight > 0的数据并排序
        const weightItems = wikiList.filter(item => 
            item.hasOwnProperty('weight') && 
            item.weight !== null && 
            item.weight !== undefined && 
            item.weight > 0
        );
        
        // 对weight > 0的数据按weight降序排序
        weightItems.sort((a, b) => {
            const weightA = a.weight || 0;
            const weightB = b.weight || 0;
            if (weightA !== weightB) {
                return weightB - weightA; // weight降序
            }
            // weight相同时，按sort降序排序
            const sortA = a.sort || 0;
            const sortB = b.sort || 0;
            if (sortA !== sortB) {
                return sortB - sortA;
            }
            // weight和sort都相同时，按id升序排序
            return Number(a.id) - Number(b.id);
        });
        
        // 第二步：筛选出weight <= 0或没有weight字段的数据
        const sortItems = wikiList.filter(item => 
            !item.hasOwnProperty('weight') || 
            item.weight === null || 
            item.weight === undefined || 
            item.weight <= 0
        );
        
        // 对这些数据按sort降序排序
        sortItems.sort((a, b) => {
            const sortA = a.sort || 0;
            const sortB = b.sort || 0;
            if (sortA !== sortB) {
                return sortB - sortA; // sort降序
            }
            // sort相同时，按id升序排序
            return Number(a.id) - Number(b.id);
        });
        
        // 合并两个数组：weight > 0的在前，其他的在后
        wikiList = [...weightItems, ...sortItems];
        
        wikis.value = wikiList;
    }
})

// 跳转文章详情页
const goWikiArticleDetailPage = (wikiId: string | number, articleId: string | number): void => {
    console.log('跳转' + wikiId + ',' + articleId)
    router.push({path: '/surfer/wiki/' + wikiId, query: {articleId: String(articleId)}})
}
</script>

<style lang="scss" scoped>
.wiki-list {
  .main-content {
    transition: all 0.3s ease;
    @media (prefers-color-scheme: dark) {
      background: linear-gradient(135deg, #1f2937 0%, #111827 100%);
    }
  }
  .wiki-grid {
    .wiki-card {
      position: relative;
      overflow: hidden;
      transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
      backdrop-filter: blur(10px);
      border-radius: 16px;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
      &::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(135deg, rgba(59, 130, 246, 0.1) 0%, rgba(147, 51, 234, 0.1) 100%);
        opacity: 0;
        transition: opacity 0.3s ease;
        z-index: 1;
        pointer-events: none;
      }
      &:hover {
        transform: translateY(-8px) scale(1.02);
        box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        &::before {
          opacity: 1;
        }
        .wiki-image {
          transform: scale(1.1);
        }
        .wiki-title {
          color: #3b82f6;
          
          .title-underline {
            width: 100%;
          }
        }
      }
      .wiki-image {
        transition: transform 0.4s ease;
        object-fit: cover;
      }
      .wiki-content {
        position: relative;
        z-index: 2;
        .wiki-title {
          position: relative;
          transition: color 0.3s ease;
          
          .title-underline {
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, #3b82f6, #8b5cf6);
            transition: width 0.3s ease;
          }
        }
        .wiki-summary {
          transition: color 0.3s ease;
          line-height: 1.6;
        }
      }
      .top-badge {
        animation: pulse 2s infinite;
        background: linear-gradient(135deg, #ef4444, #dc2626);
        box-shadow: 0 4px 14px 0 rgba(239, 68, 68, 0.4);
        &::before {
          content: '';
          position: absolute;
          top: -2px;
          left: -2px;
          right: -2px;
          bottom: -2px;
          background: linear-gradient(135deg, #ef4444, #dc2626);
          border-radius: inherit;
          z-index: -1;
          filter: blur(4px);
          opacity: 0.7;
        }
      }
    }
  }
  
  .sidebar {
    .sticky-container {
      transition: all 0.3s ease;
      
      > * {
        margin-bottom: 24px;
        animation: slideInRight 0.6s ease forwards;
        
        &:nth-child(1) { animation-delay: 0.1s; }
        &:nth-child(2) { animation-delay: 0.2s; }
        &:nth-child(3) { animation-delay: 0.3s; }
      }
    }
  }
}

// 动画定义
@keyframes pulse {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.8;
  }
}

@keyframes slideInRight {
  from {
    opacity: 0;
    transform: translateX(30px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

// 响应式设计
@media (max-width: 768px) {
  .wiki-list {
    .wiki-grid {
      .wiki-card {
        &:hover {
          transform: translateY(-4px) scale(1.01);
        }
      }
    }
  }
}

// 深色模式增强
@media (prefers-color-scheme: dark) {
  .wiki-list {
    .wiki-grid {
      .wiki-card {
        background: rgba(31, 41, 55, 0.8);
        border-color: rgba(75, 85, 99, 0.3);
        
        &::before {
          background: linear-gradient(135deg, rgba(59, 130, 246, 0.15) 0%, rgba(147, 51, 234, 0.15) 100%);
        }
        
        &:hover {
          background: rgba(31, 41, 55, 0.9);
          border-color: rgba(59, 130, 246, 0.5);
          
          .wiki-title {
            color: #60a5fa;
          }
        }
        
        .wiki-summary {
          color: #d1d5db;
        }
      }
    }
  }
}

/* 确保置顶标签完全可见 */
.wiki-list {
  overflow: visible !important;
}

.wiki-grid {
  overflow: visible !important;
}

.wiki-card {
  overflow: visible !important;
}

.top-badge {
  z-index: 999 !important;
  overflow: visible !important;
}
</style>
