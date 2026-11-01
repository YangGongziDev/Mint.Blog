<template>
  <div class="about-page">
    <section class="card hero"><div><div class="eyebrow">MINT.BLOG</div><h1>Mint.Blog 薄荷博客</h1><p>一个面向个人博客场景的前后端分离项目，聚焦文章发布、分类标签、评论互动、友情链接、专栏、统计分析与后台管理。</p><div class="tags"><span v-for="item in highlights" :key="item">{{ item }}</span></div></div><div class="overview"><h2>项目速览</h2><div class="stats"><div v-for="item in stats" :key="item[0]"><strong>{{ item[1] }}</strong><small>{{ item[0] }}</small></div></div></div></section>
    <div class="info-grid"><section class="card"><h2>项目信息</h2><dl><div v-for="item in projectInfo" :key="item.label"><dt>{{ item.label }}</dt><dd><a v-if="item.link" :href="item.link" target="_blank" rel="noopener noreferrer">{{ item.value }}</a><template v-else>{{ item.value }}</template></dd></div></dl></section><section class="card"><h2>核心能力</h2><div class="features"><article v-for="item in features" :key="item[0]"><h3>{{ item[0] }}</h3><p>{{ item[1] }}</p></article></div></section></div>
    <div class="stack-grid"><section v-for="stack in stacks" :key="stack.title" class="card"><h2>{{ stack.title }}</h2><div class="tech-grid"><article v-for="item in stack.items" :key="item[0]"><h3>{{ item[0] }}</h3><p>{{ item[1] }}</p></article></div></section></div>
  </div>
</template>

<script setup lang="ts">
useSeoMeta({ title: '关于', description: 'Mint.Blog 薄荷博客项目信息与技术栈。' })
const highlights = ['前后端分离', '博客后台管理', '文章与评论', '专栏', '统计分析']
const stats = [['项目版本', 'v3.0.0'], ['后端框架', '.NET 10'], ['数据库', 'PostgreSQL 18'], ['前端框架', 'Vue 3.5']]
const projectInfo = [
  { label: '项目名称', value: 'Mint.Blog 薄荷博客' },
  { label: '项目定位', value: '个人博客 / 内容管理 / 知识速查 / 资源导航' },
  { label: '后台环境', value: '.NET 10 / SqlSugar / PostgreSQL / RustFS / JWT' },
  { label: '前端环境', value: 'Node.js 26+ / PNPM 10+ / Vite 8' },
  { label: '开源协议', value: 'MIT license', link: 'https://github.com/YangGongziDev/Mint.Blog/blob/main/LICENSE' },
  { label: '项目仓库', value: 'https://github.com/YangGongziDev/Mint.Blog', link: 'https://github.com/YangGongziDev/Mint.Blog' },
  { label: '站点首页', value: 'https://www.yanggongzi.dev', link: 'https://www.yanggongzi.dev' },
  { label: '关于作者', value: '程序员杨工子', link: 'https://www.yanggongzi.dev/author' },
  { label: '友链RSS', value: 'https://www.yanggongzi.dev/api/rss', link: 'https://www.yanggongzi.dev/api/rss' }
]
const features = [
  ['文章管理', '支持文章创建、编辑、删除、置顶、归档与搜索等常见博客能力。'],
  ['内容生态', '包含分类、标签、评论、友链、博客设置等完整内容管理模块。'],
  ['专栏 模块', '支持专栏组织与文章关联，适合沉淀专题化内容。'],
  ['统计分析', '内置访问量与后台面板统计能力，便于观察站点运营情况。']
]
const stacks = [
  { title: '后端技术栈', items: [['.NET', '作为 Web API 主运行时，承担接口服务与业务处理。'], ['DDD 分层', '划分 Domain、Application、Infrastructure、WebApi，职责更清晰。'], ['SqlSugar', '负责数据库访问与数据模型映射。'], ['PostgreSQL', '作为核心业务数据存储，承载博客内容与统计数据。'], ['JWT', '提供后台登录鉴权与接口访问授权能力。'], ['RustFS', '用于图片与文件对象存储。']] },
  { title: '前端技术栈', items: [['Vue', '负责页面渲染与组件化开发。'], ['TypeScript', '提升代码可维护性与类型安全。'], ['Vite', '提供快速开发体验与高效构建能力。'], ['Antdv Next', '承担后台界面组件与交互基础。'], ['Nuxt', '承担前台界面组件与交互基础。'], ['Tailwind CSS', '辅助页面快速布局与视觉细节调整。'], ['Pinia + Vue Router', '用于状态管理、路由守卫与后台导航体系。']] }
]
</script>

<style scoped>
.about-page{display:grid;gap:16px;max-width:1536px;margin:auto}.card{background:var(--surface);border-radius:8px;padding:24px;min-width:0}.hero{display:grid;grid-template-columns:minmax(0,1.6fr) minmax(240px,.9fr);gap:20px;border:1px solid var(--border);background:radial-gradient(circle at top right,color-mix(in srgb,var(--primary) 18%,transparent),transparent 30%),radial-gradient(circle at left bottom,#3ecf9a1f,transparent 28%),var(--surface)}h1{font-size:28px;margin:0 0 12px}h2{font-size:16px;margin:0 0 16px}h3{font-size:14px;margin:0 0 4px}p{margin:0;color:var(--muted);line-height:1.7}.eyebrow{font-size:12px;letter-spacing:2px;color:var(--muted);margin-bottom:8px}.tags{display:flex;flex-wrap:wrap;gap:8px;margin-top:16px}.tags span{background:color-mix(in srgb,var(--primary) 10%,transparent);color:var(--primary);border-radius:4px;padding:2px 8px}.overview{border:1px solid var(--border);border-radius:8px;padding:20px;background:color-mix(in srgb,var(--surface) 72%,transparent)}.stats,.tech-grid,.stack-grid{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:16px}.stats{text-align:center}.stats strong{display:block;font-size:20px;color:var(--primary)}small{color:var(--muted)}.info-grid{display:grid;grid-template-columns:minmax(0,14fr) minmax(0,10fr);gap:16px}.features{display:grid;gap:12px}article{padding:12px;border-radius:6px;background:color-mix(in srgb,var(--text) 3.5%,transparent)}article p{font-size:13px}.tech-grid{gap:12px}dl{margin:0;border:1px solid var(--border);border-bottom:0}dl>div{display:grid;grid-template-columns:90px minmax(0,1fr);border-bottom:1px solid var(--border)}dt,dd{padding:8px;margin:0;overflow-wrap:anywhere}dt{background:color-mix(in srgb,var(--text) 4%,transparent);border-right:1px solid var(--border)}dd{color:var(--muted)}@media(max-width:900px){.hero,.info-grid,.stack-grid{grid-template-columns:minmax(0,1fr)}}@media(max-width:640px){.about-page{gap:12px}.card{padding:18px}h1{font-size:22px}.stats,.tech-grid{grid-template-columns:1fr}}
</style>
