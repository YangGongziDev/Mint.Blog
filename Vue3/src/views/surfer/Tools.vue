<template>
  <div class="tools-container">
    <!-- 头部区域 -->
    <div class="header-section">
      <div class="header-content">
        <div class="title-area">
          <h1 class="page-title">
            <ToolOutlined class="title-icon" />
            在线工具
          </h1>
          <p class="page-subtitle">精选实用的在线开发工具，提升咱的工作效率</p>
        </div>
        
        <!-- 搜索区域 -->
        <div class="search-area">
          <div class="search-wrapper">
            <SearchOutlined class="search-icon" />
            <input 
              v-model="searchQuery" 
              type="text" 
              placeholder="搜索工具名称或描述..."
              class="search-input"
              @input="handleSearch"
            />
            <div v-if="searchQuery" class="clear-search" @click="clearSearch">
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
            :class="['category-btn', { active: activeCategory === category.key }]"
            @click="setActiveCategory(category.key)"
          >
            <component :is="category.icon" class="category-icon" />
            <span class="category-name">{{ category.name }}</span>
            <span class="category-count">({{ getCategoryCount(category.key) }})</span>
          </button>
        </div>
      </div>

      <!-- 工具网格 -->
      <div class="tools-grid">
        <div 
          v-for="tool in filteredTools" 
          :key="tool.id"
          class="tool-card"
          @click="openTool(tool)"
        >
          <div class="tool-header">
            <div class="tool-icon">
              <component :is="tool.icon" />
            </div>
            <div class="tool-actions">
              <button 
                class="favorite-btn"
                :class="{ active: tool.isFavorite }"
                @click.stop="toggleFavorite(tool)"
              >
                <HeartOutlined v-if="!tool.isFavorite" />
                <HeartFilled v-else />
              </button>
            </div>
          </div>
          
          <div class="tool-content">
            <h3 class="tool-title">{{ tool.name }}</h3>
            <p class="tool-description">{{ tool.description }}</p>
            
            <div class="tool-tags">
              <span 
                v-for="tag in tool.tags" 
                :key="tag"
                class="tool-tag"
              >
                {{ tag }}
              </span>
            </div>
          </div>
          
          <div class="tool-footer">
            <div class="tool-stats">
              <span class="stat-item">
                <EyeOutlined class="stat-icon" />
                {{ tool.views }}
              </span>
              <span class="stat-item">
                <LikeOutlined class="stat-icon" />
                {{ tool.likes }}
              </span>
            </div>
            
            <div class="tool-link">
              <LinkOutlined class="link-icon" />
              <span class="link-text">访问工具</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 空状态 -->
      <div v-if="filteredTools.length === 0" class="empty-state">
        <div class="empty-icon">
          <InboxOutlined />
        </div>
        <h3 class="empty-title">暂无相关工具</h3>
        <p class="empty-description">
          {{ searchQuery ? '没有找到匹配的工具，请尝试其他关键词' : '该分类下暂无工具' }}
        </p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import {
  ToolOutlined,
  SearchOutlined,
  CloseOutlined,
  CodeOutlined,
  BgColorsOutlined,
  FileTextOutlined,
  SafetyOutlined,
  CloudOutlined,
  CalculatorOutlined,
  HeartOutlined,
  HeartFilled,
  EyeOutlined,
  LikeOutlined,
  LinkOutlined,
  InboxOutlined,
  ApiOutlined,
  FormatPainterOutlined,
  FileImageOutlined,
  LockOutlined,
  DatabaseOutlined,
  FunctionOutlined
} from '@ant-design/icons-vue'

// 工具接口定义
interface Tool {
  id: string
  name: string
  description: string
  url: string
  category: string
  tags: string[]
  icon: any
  views: number
  likes: number
  isFavorite: boolean
}

// 分类接口定义
interface Category {
  key: string
  name: string
  icon: any
}

// 搜索关键词
const searchQuery = ref('')

// 当前激活的分类
const activeCategory = ref('all')

// 分类数据
const categories = ref<Category[]>([
  { key: 'all', name: '全部', icon: ToolOutlined },
  { key: 'development', name: '开发工具', icon: CodeOutlined },
  { key: 'design', name: '设计工具', icon: BgColorsOutlined },
  { key: 'text', name: '文本处理', icon: FileTextOutlined },
  { key: 'security', name: '安全工具', icon: SafetyOutlined },
  { key: 'network', name: '网络工具', icon: CloudOutlined },
  { key: 'utility', name: '实用工具', icon: CalculatorOutlined }
])

// 工具数据
const tools = ref<Tool[]>([
  // 开发工具
  {
    id: '1',
    name: 'JSON 格式化',
    description: '在线 JSON 格式化、压缩、验证工具',
    url: 'https://jsonformatter.org/',
    category: 'development',
    tags: ['JSON', '格式化', '验证'],
    icon: ApiOutlined,
    views: 15420,
    likes: 892,
    isFavorite: false
  },
  {
    id: '2',
    name: '正则表达式测试',
    description: '在线正则表达式测试和调试工具',
    url: 'https://regex101.com/',
    category: 'development',
    tags: ['正则', '测试', '调试'],
    icon: FunctionOutlined,
    views: 12350,
    likes: 756,
    isFavorite: true
  },
  {
    id: '3',
    name: 'Base64 编解码',
    description: '在线 Base64 编码解码工具',
    url: 'https://www.base64encode.org/',
    category: 'development',
    tags: ['Base64', '编码', '解码'],
    icon: LockOutlined,
    views: 9876,
    likes: 543,
    isFavorite: false
  },
  {
    id: '4',
    name: 'SQL 格式化',
    description: '在线 SQL 语句格式化和美化工具',
    url: 'https://sqlformat.org/',
    category: 'development',
    tags: ['SQL', '格式化', '数据库'],
    icon: DatabaseOutlined,
    views: 8765,
    likes: 432,
    isFavorite: false
  },
  
  // 设计工具
  {
    id: '5',
    name: '颜色选择器',
    description: '在线颜色选择和调色板工具',
    url: 'https://colorhunt.co/',
    category: 'design',
    tags: ['颜色', '调色板', '设计'],
    icon: BgColorsOutlined,
    views: 18900,
    likes: 1234,
    isFavorite: true
  },
  {
    id: '6',
    name: 'CSS 生成器',
    description: '在线 CSS 样式生成器工具',
    url: 'https://css3generator.com/',
    category: 'design',
    tags: ['CSS', '生成器', '样式'],
    icon: FormatPainterOutlined,
    views: 14567,
    likes: 876,
    isFavorite: false
  },
  {
    id: '7',
    name: '图片压缩',
    description: '在线图片压缩和优化工具',
    url: 'https://tinypng.com/',
    category: 'design',
    tags: ['图片', '压缩', '优化'],
    icon: FileImageOutlined,
    views: 22100,
    likes: 1567,
    isFavorite: true
  },
  
  // 文本处理
  {
    id: '8',
    name: 'Markdown 编辑器',
    description: '在线 Markdown 编辑和预览工具',
    url: 'https://dillinger.io/',
    category: 'text',
    tags: ['Markdown', '编辑器', '预览'],
    icon: FileTextOutlined,
    views: 16789,
    likes: 987,
    isFavorite: false
  },
  {
    id: '9',
    name: '文本差异对比',
    description: '在线文本差异对比工具',
    url: 'https://www.diffchecker.com/',
    category: 'text',
    tags: ['文本', '对比', '差异'],
    icon: FileTextOutlined,
    views: 11234,
    likes: 654,
    isFavorite: false
  },
  
  // 安全工具
  {
    id: '10',
    name: 'MD5 加密',
    description: '在线 MD5 哈希加密工具',
    url: 'https://www.md5hashgenerator.com/',
    category: 'security',
    tags: ['MD5', '加密', '哈希'],
    icon: LockOutlined,
    views: 13456,
    likes: 789,
    isFavorite: false
  },
  {
    id: '11',
    name: '密码生成器',
    description: '在线安全密码生成工具',
    url: 'https://passwordsgenerator.net/',
    category: 'security',
    tags: ['密码', '生成器', '安全'],
    icon: SafetyOutlined,
    views: 19876,
    likes: 1123,
    isFavorite: true
  },
  
  // 网络工具
  {
    id: '12',
    name: 'IP 地址查询',
    description: '在线 IP 地址查询和定位工具',
    url: 'https://www.whatismyipaddress.com/',
    category: 'network',
    tags: ['IP', '查询', '定位'],
    icon: CloudOutlined,
    views: 25678,
    likes: 1456,
    isFavorite: false
  },
  
  // 实用工具
  {
    id: '13',
    name: '时间戳转换',
    description: '在线时间戳转换工具',
    url: 'https://www.epochconverter.com/',
    category: 'utility',
    tags: ['时间戳', '转换', '时间'],
    icon: CalculatorOutlined,
    views: 17890,
    likes: 1034,
    isFavorite: false
  },
  {
    id: '14',
    name: 'QR 码生成器',
    description: '在线二维码生成工具',
    url: 'https://www.qr-code-generator.com/',
    category: 'utility',
    tags: ['二维码', '生成器', 'QR'],
    icon: CalculatorOutlined,
    views: 21345,
    likes: 1234,
    isFavorite: true
  }
])

// 计算过滤后的工具
const filteredTools = computed(() => {
  let result = tools.value
  
  // 按分类过滤
  if (activeCategory.value !== 'all') {
    result = result.filter(tool => tool.category === activeCategory.value)
  }
  
  // 按搜索关键词过滤
  if (searchQuery.value.trim()) {
    const query = searchQuery.value.toLowerCase().trim()
    result = result.filter(tool => 
      tool.name.toLowerCase().includes(query) ||
      tool.description.toLowerCase().includes(query) ||
      tool.tags.some(tag => tag.toLowerCase().includes(query))
    )
  }
  
  return result
})

// 获取分类下的工具数量
const getCategoryCount = (categoryKey: string) => {
  if (categoryKey === 'all') {
    return tools.value.length
  }
  return tools.value.filter(tool => tool.category === categoryKey).length
}

// 设置激活的分类
const setActiveCategory = (categoryKey: string) => {
  activeCategory.value = categoryKey
}

// 处理搜索
const handleSearch = () => {
  // 搜索时自动切换到全部分类
  if (searchQuery.value.trim()) {
    activeCategory.value = 'all'
  }
}

// 清除搜索
const clearSearch = () => {
  searchQuery.value = ''
}

// 切换收藏状态
const toggleFavorite = (tool: Tool) => {
  tool.isFavorite = !tool.isFavorite
}

// 打开工具
const openTool = (tool: Tool) => {
  // 增加浏览量
  tool.views++
  
  // 在新窗口打开工具链接
  window.open(tool.url, '_blank')
}

onMounted(() => {
  // 组件挂载后的初始化逻辑
})
</script>

<style scoped lang="scss">
.tools-container {
  background: #f8fafc;
  min-height: 100vh;
}

// 头部区域
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
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="dots" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="1" fill="%23ffffff" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23dots)"/></svg>') repeat;
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
      color: #64748b;
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
      background: #f1f5f9;
      border-radius: 50%;
      color: #64748b;
      cursor: pointer;
      transition: all 0.3s ease;
      
      &:hover {
        background: #e2e8f0;
        color: #475569;
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
      color: #64748b;
      font-size: 14.4px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s ease;
      
      &:hover {
        border-color: #3b82f6;
        color: #3b82f6;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.15);
      }
      
      &.active {
        border-color: #3b82f6;
        background: #3b82f6;
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

// 工具网格
.tools-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 24px;
  
  .tool-card {
    background: white;
    border-radius: 16px;
    padding: 24px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
    border: 1px solid #f1f5f9;
    cursor: pointer;
    transition: all 0.3s ease;
    
    &:hover {
      transform: translateY(-4px);
      box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
      border-color: #e2e8f0;
    }
    
    .tool-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      margin-bottom: 16px;
      
      .tool-icon {
        width: 48px;
        height: 48px;
        background: linear-gradient(135deg, #3b82f6, #1d4ed8);
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 24px;
      }
      
      .tool-actions {
        .favorite-btn {
          width: 32px;
          height: 32px;
          border: none;
          background: #f8fafc;
          border-radius: 8px;
          display: flex;
          align-items: center;
          justify-content: center;
          color: #94a3b8;
          cursor: pointer;
          transition: all 0.3s ease;
          
          &:hover {
            background: #f1f5f9;
            color: #64748b;
          }
          
          &.active {
            background: #fef2f2;
            color: #ef4444;
          }
        }
      }
    }
    
    .tool-content {
      margin-bottom: 20px;
      
      .tool-title {
        font-size: 20px;
        font-weight: 600;
        color: #1e293b;
        margin: 0 0 8px 0;
      }
      
      .tool-description {
        color: #64748b;
        line-height: 1.6;
        margin: 0 0 16px 0;
      }
      
      .tool-tags {
        display: flex;
        flex-wrap: wrap;
        gap: 6px;
        
        .tool-tag {
          padding: 4px 10px;
          background: #f1f5f9;
          color: #475569;
          border-radius: 12px;
          font-size: 12.8px;
          font-weight: 500;
        }
      }
    }
    
    .tool-footer {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding-top: 16px;
      border-top: 1px solid #f1f5f9;
      
      .tool-stats {
        display: flex;
        gap: 16px;
        
        .stat-item {
          display: flex;
          align-items: center;
          gap: 4px;
          color: #94a3b8;
          font-size: 13.6px;
          
          .stat-icon {
            font-size: 16px;
          }
        }
      }
      
      .tool-link {
        display: flex;
        align-items: center;
        gap: 6px;
        color: #3b82f6;
        font-size: 14.4px;
        font-weight: 500;
        
        .link-icon {
          font-size: 16px;
        }
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
    color: #475569;
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
  
  .tools-grid {
    grid-template-columns: 1fr;
    gap: 16px;
    
    .tool-card {
      padding: 20px;
    }
  }
}
</style>
