<script setup lang="ts">
defineOptions({
  name: 'AboutPage'
});

const highlights = ['前后端分离', '博客后台管理', '文章与评论', 'Wiki 知识库', '统计分析'];

const stats = [
  { label: '项目版本', value: 'v2.0.0' },
  { label: '后端框架', value: '.NET 10' },
  { label: '数据库', value: 'PostgreSQL 18' },
  { label: '前端框架', value: 'Vue 3.5' }
];

const projectInfo = [
  { label: '项目名称', value: 'Mint.Blog' },
  { label: '作者', value: '程序员-杨工子' },
  { label: '开源协议', value: 'MIT' },
  { label: '项目定位', value: '个人博客 / 内容管理 / 知识整理' },
  { label: '项目仓库', value: 'https://github.com/YangMufa/Mint.Blog', link: 'https://github.com/YangMufa/Mint.Blog' },
  { label: '站点首页', value: 'https://www.yangmufa.cn', link: 'https://www.yangmufa.cn' },
  { label: '接口地址', value: 'https://www.yangmufa.cn/api/blog', link: 'https://www.yangmufa.cn/api/blog' },
  { label: '后台环境', value: '.NET 10 / SqlSugar / PostgreSQL / MinIO / JWT' },
  { label: '前端环境', value: 'Node.js 24+ / pnpm 10+ / Vite 8' }
];

const features = [
  {
    title: '文章管理',
    desc: '支持文章创建、编辑、删除、置顶、归档与搜索等常见博客能力。'
  },
  {
    title: '内容生态',
    desc: '包含分类、标签、评论、友链、博客设置等完整内容管理模块。'
  },
  {
    title: 'Wiki 模块',
    desc: '支持知识库目录组织与文章关联，适合沉淀专题化内容。'
  },
  {
    title: '统计分析',
    desc: '内置访问量与后台面板统计能力，便于观察站点运营情况。'
  }
];

const backendStack = [
  { name: '.NET', desc: '作为 Web API 主运行时，承担接口服务与业务处理。' },
  { name: 'DDD 分层', desc: '划分 Domain、Application、Infrastructure、WebApi，职责更清晰。' },
  { name: 'SqlSugar', desc: '负责数据库访问与数据模型映射。' },
  { name: 'PostgreSQL', desc: '作为核心业务数据存储，承载博客内容与统计数据。' },
  { name: 'JWT', desc: '提供后台登录鉴权与接口访问授权能力。' },
  { name: 'MinIO', desc: '用于图片与文件对象存储。' }
];

const frontendStack = [
  { name: 'Vue', desc: '负责页面渲染与组件化开发。' },
  { name: 'TypeScript', desc: '提升代码可维护性与类型安全。' },
  { name: 'Vite', desc: '提供快速开发体验与高效构建能力。' },
  { name: 'Ant Design Vue', desc: '承担后台界面组件与交互基础。' },
  { name: 'Tailwind CSS', desc: '辅助页面快速布局与视觉细节调整。' },
  { name: 'Pinia + Vue Router', desc: '用于状态管理、路由守卫与后台导航体系。' }
];
</script>

<template>
  <div class="about-page">
    <ACard :bordered="false" class="hero-card card-wrapper">
      <div class="hero-grid">
        <div>
          <div class="eyebrow">MINT.BLOG</div>
          <h1 class="hero-title">Mint.Blog 薄荷博客</h1>
          <p class="hero-desc">
            一个面向个人博客场景的前后端分离项目，聚焦文章发布、分类标签、评论互动、友情链接、Wiki、统计分析与后台管理。
          </p>

          <div class="hero-tags">
            <ATag v-for="item in highlights" :key="item" color="blue">{{ item }}</ATag>
          </div>
        </div>

        <div class="hero-panel">
          <div class="panel-title">项目速览</div>
          <div class="stats-grid">
            <div v-for="item in stats" :key="item.label" class="stat-item">
              <div class="stat-value">{{ item.value }}</div>
              <div class="stat-label">{{ item.label }}</div>
            </div>
          </div>
        </div>
      </div>
    </ACard>

    <ARow :gutter="[16, 16]">
      <ACol :xs="24" :xl="14">
        <ACard title="项目信息" :bordered="false" class="card-wrapper fill-card overflow-hidden">
          <div class="mobile-scroll-x">
            <ADescriptions bordered size="small" :column="1">
              <ADescriptionsItem v-for="item in projectInfo" :key="item.label" :label="item.label">
                <template v-if="item.link">
                  <a :href="item.link" class="text-primary" target="_blank" rel="noopener noreferrer">
                    {{ item.value }}
                  </a>
                </template>
                <template v-else>
                  {{ item.value }}
                </template>
              </ADescriptionsItem>
            </ADescriptions>
          </div>
        </ACard>
      </ACol>

      <ACol :xs="24" :xl="10">
        <ACard title="核心能力" :bordered="false" class="card-wrapper fill-card">
          <ul class="feature-list">
            <li v-for="item in features" :key="item.title" class="feature-item">
              <div class="feature-title">{{ item.title }}</div>
              <div class="feature-desc">{{ item.desc }}</div>
            </li>
          </ul>
        </ACard>
      </ACol>
    </ARow>

    <ARow :gutter="[16, 16]">
      <ACol :xs="24" :xl="12">
        <ACard title="后端技术栈" :bordered="false" class="card-wrapper fill-card">
          <div class="tech-grid">
            <div v-for="item in backendStack" :key="item.name" class="tech-item">
              <div class="tech-name">{{ item.name }}</div>
              <div class="tech-desc">{{ item.desc }}</div>
            </div>
          </div>
        </ACard>
      </ACol>

      <ACol :xs="24" :xl="12">
        <ACard title="前端技术栈" :bordered="false" class="card-wrapper fill-card">
          <div class="tech-grid">
            <div v-for="item in frontendStack" :key="item.name" class="tech-item">
              <div class="tech-name">{{ item.name }}</div>
              <div class="tech-desc">{{ item.desc }}</div>
            </div>
          </div>
        </ACard>
      </ACol>
    </ARow>
  </div>
</template>

<style scoped lang="scss">
.about-page {
  --about-primary: rgb(var(--primary-color));
  --about-primary-soft: rgb(var(--primary-color) / 10%);
  --about-primary-soft-strong: rgb(var(--primary-color) / 18%);
  --about-success-soft: rgb(var(--success-color) / 12%);
  --about-text: rgb(var(--base-text-color));
  --about-text-muted: rgb(var(--base-text-color) / 72%);
  --about-text-soft: rgb(var(--base-text-color) / 56%);
  --about-border: rgb(var(--base-text-color) / 10%);
  --about-border-strong: rgb(var(--base-text-color) / 14%);
  --about-panel-bg: rgb(var(--container-bg-color) / 72%);
  --about-card-bg: rgb(var(--base-text-color) / 3.5%);

  display: flex;
  flex-direction: column;
  gap: 16px;

  :deep(.ant-descriptions-view),
  :deep(.ant-descriptions-row > th),
  :deep(.ant-descriptions-row > td) {
    border-color: var(--about-border) !important;
  }

  :deep(.ant-descriptions-row > th) {
    background: rgb(var(--base-text-color) / 4%);
    color: var(--about-text);
  }

  :deep(.ant-descriptions-row > td) {
    background: transparent;
    color: var(--about-text-muted);
  }

  :deep(.ant-card-head-title) {
    color: var(--about-text);
  }
}

.hero-card {
  overflow: hidden;
  border: 1px solid var(--about-border);
  background:
    radial-gradient(circle at top right, var(--about-primary-soft-strong), transparent 30%),
    radial-gradient(circle at left bottom, var(--about-success-soft), transparent 28%),
    linear-gradient(135deg, rgb(var(--container-bg-color) / 96%), rgb(var(--layout-bg-color) / 100%));
}

.hero-grid {
  display: grid;
  grid-template-columns: minmax(0, 1.6fr) minmax(240px, 0.9fr);
  gap: 20px;
}

.eyebrow {
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 2px;
  color: var(--about-text-soft);
  margin-bottom: 8px;
}

.hero-title {
  font-size: 28px;
  font-weight: 700;
  color: var(--about-text);
  margin-bottom: 12px;
}

.hero-desc {
  font-size: 14px;
  line-height: 1.7;
  color: var(--about-text-muted);
  margin-bottom: 16px;
}

.hero-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.hero-panel {
  background: var(--about-panel-bg);
  border: 1px solid var(--about-border-strong);
  border-radius: 8px;
  padding: 20px;
  backdrop-filter: blur(4px);
}

.panel-title {
  font-size: 14px;
  font-weight: 600;
  color: var(--about-text);
  margin-bottom: 16px;
}

.stats-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
}

.stat-item {
  text-align: center;
}

.stat-value {
  font-size: 20px;
  font-weight: 700;
  color: var(--about-primary);
}

.stat-label {
  font-size: 12px;
  color: var(--about-text-soft);
  margin-top: 4px;
}

.feature-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.feature-item {
  padding: 12px;
  background: var(--about-card-bg);
  border-radius: 6px;
}

.feature-title {
  font-size: 14px;
  font-weight: 600;
  color: var(--about-text);
  margin-bottom: 4px;
}

.feature-desc {
  font-size: 13px;
  color: var(--about-text-muted);
  line-height: 1.6;
}

.tech-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
}

.tech-item {
  padding: 12px;
  background: var(--about-card-bg);
  border-radius: 6px;
}

.tech-name {
  font-size: 14px;
  font-weight: 600;
  color: var(--about-text);
  margin-bottom: 4px;
}

.tech-desc {
  font-size: 13px;
  color: var(--about-text-muted);
  line-height: 1.6;
}

.fill-card {
  height: 100%;
}

.card-wrapper {
  border-radius: 8px;
}

.mobile-scroll-x {
  width: 100%;
  overflow-x: auto;
}

@media (max-width: 640px) {
  .about-page {
    gap: 12px;
  }

  .hero-grid {
    grid-template-columns: 1fr;
    gap: 16px;
  }

  .hero-title {
    font-size: 22px;
    line-height: 1.25;
  }

  .hero-desc {
    font-size: 13px;
  }

  .hero-panel {
    padding: 16px;
  }

  .stats-grid,
  .tech-grid {
    grid-template-columns: 1fr;
  }

  .mobile-scroll-x :deep(.ant-descriptions) {
    min-width: 560px;
  }
}
</style>
