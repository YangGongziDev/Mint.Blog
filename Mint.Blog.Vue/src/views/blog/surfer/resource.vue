<script setup lang="ts">
import { computed, onMounted, ref } from 'vue';
import {
  BgColorsOutlined,
  BookOutlined,
  CloseOutlined,
  CloudOutlined,
  CodeOutlined,
  DatabaseOutlined,
  FolderOpenOutlined,
  HeartFilled,
  HeartOutlined,
  InboxOutlined,
  LinkOutlined,
  SearchOutlined,
  ToolOutlined
} from '@ant-design/icons-vue';

defineOptions({ name: 'SurferResourcePage' });

// 资源接口定义
interface Resource {
  id: string;
  name: string;
  description: string;
  url: string;
  category: string;
  tags: string[];
  icon: any;
  favorited: boolean;
}

// 分类接口定义
interface Category {
  key: string;
  name: string;
  icon: any;
}

// 响应式数据
const searchKeyword = ref('');
const activeCategory = ref('all');

// 分类配置
const categories: Category[] = [
  { key: 'all', name: '全部', icon: FolderOpenOutlined },
  { key: 'frontend', name: '前端开发', icon: CodeOutlined },
  { key: 'backend', name: '后端开发', icon: DatabaseOutlined },
  { key: 'tools', name: '开发工具', icon: ToolOutlined },
  { key: 'design', name: '设计资源', icon: BgColorsOutlined },
  { key: 'cloud', name: '云服务', icon: CloudOutlined },
  { key: 'docs', name: '文档教程', icon: BookOutlined }
];

// 资源数据
const resources = ref<Resource[]>([
  {
    id: '1',
    name: 'Vue.js',
    description: '渐进式 JavaScript 框架，用于构建用户界面',
    url: 'https://vuejs.org/',
    category: 'frontend',
    tags: ['框架', 'JavaScript', 'SPA'],
    icon: CodeOutlined,
    favorited: true
  },
  {
    id: '2',
    name: 'Ant Design Vue',
    description: '基于 Vue 3 的企业级 UI 组件库',
    url: 'https://antdv.com/',
    category: 'frontend',
    tags: ['UI库', 'Vue', '组件'],
    icon: CodeOutlined,
    favorited: false
  },
  {
    id: '3',
    name: 'Node.js',
    description: 'JavaScript 运行时环境，用于服务端开发',
    url: 'https://nodejs.org/',
    category: 'backend',
    tags: ['运行时', 'JavaScript', '服务端'],
    icon: DatabaseOutlined,
    favorited: true
  },
  {
    id: '4',
    name: 'Visual Studio Code',
    description: '轻量级但功能强大的代码编辑器',
    url: 'https://code.visualstudio.com/',
    category: 'tools',
    tags: ['编辑器', 'IDE', '开发'],
    icon: ToolOutlined,
    favorited: false
  },
  {
    id: '5',
    name: 'Figma',
    description: '协作式界面设计工具',
    url: 'https://www.figma.com/',
    category: 'design',
    tags: ['设计', 'UI/UX', '协作'],
    icon: BgColorsOutlined,
    favorited: true
  },
  {
    id: '6',
    name: 'Vercel',
    description: '前端应用部署和托管平台',
    url: 'https://vercel.com/',
    category: 'cloud',
    tags: ['部署', '托管', '前端'],
    icon: CloudOutlined,
    favorited: false
  },
  {
    id: '7',
    name: 'MDN Web Docs',
    description: 'Web 开发技术文档和学习资源',
    url: 'https://developer.mozilla.org/',
    category: 'docs',
    tags: ['文档', 'Web', '学习'],
    icon: BookOutlined,
    favorited: true
  }
]);

// 计算属性
const filteredResources = computed(() => {
  let filtered = resources.value;

  // 按分类筛选
  if (activeCategory.value !== 'all') {
    filtered = filtered.filter(resource => resource.category === activeCategory.value);
  }

  // 按搜索关键词筛选
  if (searchKeyword.value.trim()) {
    const keyword = searchKeyword.value.toLowerCase();
    filtered = filtered.filter(
      resource =>
        resource.name.toLowerCase().includes(keyword) ||
        resource.description.toLowerCase().includes(keyword) ||
        resource.tags.some(tag => tag.toLowerCase().includes(keyword))
    );
  }

  return filtered;
});

// 方法
const setActiveCategory = (category: string) => {
  activeCategory.value = category;
};

const getResourceCount = (category: string) => {
  if (category === 'all') {
    return resources.value.length;
  }
  return resources.value.filter(resource => resource.category === category).length;
};

const getCategoryName = (categoryKey: string) => {
  const category = categories.find(cat => cat.key === categoryKey);
  return category ? category.name : categoryKey;
};

const handleSearch = () => {
  // 搜索时自动切换到全部分类
  if (searchKeyword.value.trim()) {
    activeCategory.value = 'all';
  }
};

const clearSearch = () => {
  searchKeyword.value = '';
};

const openResource = (url: string) => {
  window.open(url, '_blank');
};

const toggleFavorite = (resourceId: string) => {
  const resource = resources.value.find(r => r.id === resourceId);
  if (resource) {
    resource.favorited = !resource.favorited;
  }
};

onMounted(() => {
  // 组件挂载后的初始化逻辑
});
</script>

<template>
  <div class="resource-container">
    <!-- 头部英雄区域 -->
    <div class="header-section">
      <div class="header-content">
        <div class="title-area">
          <h1 class="page-title">
            <FolderOpenOutlined class="title-icon" />
            编程资源导航
          </h1>
          <p class="page-subtitle">精选开发工具、文档教程、设计资源等实用链接</p>
        </div>

        <!-- 搜索区域 -->
        <div class="search-area">
          <div class="search-wrapper">
            <SearchOutlined class="search-icon" />
            <input
              v-model="searchKeyword"
              type="text"
              placeholder="搜索资源名称或描述..."
              class="search-input"
              @input="handleSearch"
            />
            <div v-if="searchKeyword" class="clear-search" @click="clearSearch">
              <CloseOutlined />
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 主要内容区域 -->
    <div class="main-content">
      <!-- 分类导航 -->
      <div class="category-nav">
        <div class="nav-wrapper">
          <button
            v-for="category in categories"
            :key="category.key"
            class="category-btn"
            :class="[{ active: activeCategory === category.key }]"
            @click="setActiveCategory(category.key)"
          >
            <component :is="category.icon" class="category-icon" />
            <span class="category-name">{{ category.name }}</span>
            <span class="category-count">({{ getResourceCount(category.key) }})</span>
          </button>
        </div>
      </div>

      <!-- 资源网格 -->
      <div class="resources-grid">
        <div
          v-for="resource in filteredResources"
          :key="resource.id"
          class="resource-card"
          @click="openResource(resource.url)"
        >
          <div class="card-header">
            <div class="resource-icon">
              <component :is="resource.icon" />
            </div>
            <div class="card-actions">
              <button
                class="favorite-btn"
                :class="{ active: resource.favorited }"
                @click.stop="toggleFavorite(resource.id)"
              >
                <HeartOutlined v-if="!resource.favorited" />
                <HeartFilled v-else />
              </button>
            </div>
          </div>

          <div class="card-content">
            <h3 class="resource-title">{{ resource.name }}</h3>
            <p class="resource-description">{{ resource.description }}</p>

            <div class="resource-tags">
              <span v-for="tag in resource.tags" :key="tag" class="resource-tag">
                {{ tag }}
              </span>
            </div>
          </div>

          <div class="card-footer">
            <div class="resource-info">
              <span class="resource-category">{{ getCategoryName(resource.category) }}</span>
            </div>

            <div class="resource-link">
              <LinkOutlined class="link-icon" />
              <span class="link-text">访问资源</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 空状态 -->
      <div v-if="filteredResources.length === 0" class="empty-state">
        <div class="empty-icon">
          <InboxOutlined />
        </div>
        <h3 class="empty-title">暂无相关资源</h3>
        <p class="empty-description">
          {{ searchKeyword ? '没有找到匹配的资源，请尝试其他关键词' : '该分类下暂无资源' }}
        </p>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.resource-container {
  background: #f7fbf8;
  min-height: 100vh;
}

// 头部英雄区域
.header-section {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 20px 20px;
  position: relative;
  overflow: hidden;

  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="dots" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="1" fill="%23ffffff" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23dots)"/></svg>')
      repeat;
  }

  .header-content {
    position: relative;
    max-width: 1200px;
    margin: 0 auto;
    z-index: 1;
  }
}

.title-area {
  text-align: center;
  margin-bottom: 20px;

  .page-title {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 16px;
    font-size: 48px;
    font-weight: 700;
    color: white;
    margin: 0 0 16px 0;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);

    .title-icon {
      font-size: 44.8px;
    }
  }

  .page-subtitle {
    font-size: 19.2px;
    color: rgba(255, 255, 255, 0.9);
    margin: 0;
  }
}

.search-area {
  display: flex;
  justify-content: center;

  .search-wrapper {
    position: relative;
    width: 100%;
    max-width: 600px;

    .search-icon {
      position: absolute;
      left: 20px;
      top: 50%;
      transform: translateY(-50%);
      color: #60786e;
      font-size: 19.2px;
      z-index: 2;
    }

    .search-input {
      width: 100%;
      padding: 16px 20px 16px 56px;
      border: none;
      border-radius: 50px;
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      font-size: 16px;
      color: #334155;
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
      transition: all 0.3s ease;

      &::placeholder {
        color: #94a3b8;
      }

      &:focus {
        outline: none;
        background: white;
        box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
        transform: translateY(-2px);
      }
    }

    .clear-search {
      position: absolute;
      right: 20px;
      top: 50%;
      transform: translateY(-50%);
      width: 24px;
      height: 24px;
      display: flex;
      align-items: center;
      justify-content: center;
      background: #dcfaeb;
      border-radius: 50%;
      color: #60786e;
      cursor: pointer;
      transition: all 0.3s ease;

      &:hover {
        background: #e2e8f0;
        color: #557468;
      }
    }
  }
}

// 主要内容
.main-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 48px 24px 80px;
}

// 分类导航
.category-nav {
  margin-bottom: 48px;

  .nav-wrapper {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
    justify-content: center;

    .category-btn {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 12px 20px;
      border: 2px solid #e2e8f0;
      border-radius: 50px;
      background: white;
      color: #60786e;
      font-size: 14.4px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s ease;

      &:hover {
        border-color: #15956b;
        color: #15956b;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.15);
      }

      &.active {
        border-color: #15956b;
        background: #15956b;
        color: white;
        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
      }

      .category-icon {
        font-size: 17.6px;
      }

      .category-count {
        font-size: 12.8px;
        opacity: 0.8;
      }
    }
  }
}

// 资源网格
.resources-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 24px;
}

// 资源卡片
.resource-card {
  background: white;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  border: 1px solid #dcfaeb;
  cursor: pointer;
  transition: all 0.3s ease;

  &:hover {
    transform: translateY(-4px);
    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
    border-color: #e2e8f0;
  }

  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 16px;

    .resource-icon {
      width: 48px;
      height: 48px;
      background: linear-gradient(135deg, #15956b, #1d4ed8);
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-size: 24px;
    }

    .card-actions {
      .favorite-btn {
        width: 32px;
        height: 32px;
        border: none;
        background: #f7fbf8;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #94a3b8;
        cursor: pointer;
        transition: all 0.3s ease;

        &:hover {
          background: #dcfaeb;
          color: #60786e;
        }

        &.active {
          background: #fef2f2;
          color: #ef4444;
        }
      }
    }
  }

  .card-content {
    margin-bottom: 20px;

    .resource-title {
      font-size: 20px;
      font-weight: 600;
      color: #0d3d2d;
      margin: 0 0 8px 0;
    }

    .resource-description {
      color: #60786e;
      line-height: 1.6;
      margin: 0 0 16px 0;
    }

    .resource-tags {
      display: flex;
      flex-wrap: wrap;
      gap: 6px;

      .resource-tag {
        padding: 4px 10px;
        background: #dcfaeb;
        color: #557468;
        border-radius: 12px;
        font-size: 12.8px;
        font-weight: 500;
      }
    }
  }

  .card-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: 16px;
    border-top: 1px solid #dcfaeb;

    .resource-info {
      .resource-category {
        font-size: 13.6px;
        color: #15956b;
        font-weight: 500;
      }
    }

    .resource-link {
      display: flex;
      align-items: center;
      gap: 6px;
      color: #15956b;
      font-size: 14.4px;
      font-weight: 500;

      .link-icon {
        font-size: 16px;
      }
    }
  }
}

// 空状态
.empty-state {
  text-align: center;
  padding: 80px 20px;

  .empty-icon {
    font-size: 64px;
    color: #cbd5e1;
    margin-bottom: 24px;
  }

  .empty-title {
    font-size: 24px;
    font-weight: 600;
    color: #557468;
    margin: 0 0 12px 0;
  }

  .empty-description {
    color: #94a3b8;
    margin: 0;
  }
}

// 响应式设计
@media (max-width: 768px) {
  .header-section {
    padding: 40px 16px 60px;
  }

  .title-area {
    .page-title {
      font-size: 40px;
      flex-direction: column;
      gap: 12px;
    }

    .page-subtitle {
      font-size: 16px;
    }
  }

  .search-area {
    .search-wrapper {
      .search-input {
        padding: 14px 16px 14px 48px;
      }
    }
  }

  .main-content {
    padding: 32px 16px 60px;
  }

  .category-nav {
    .nav-wrapper {
      .category-btn {
        padding: 10px 16px;
        font-size: 13.6px;

        .category-name {
          display: none;
        }
      }
    }
  }

  .resources-grid {
    grid-template-columns: 1fr;
    gap: 16px;

    .resource-card {
      padding: 20px;
    }
  }
}
</style>
