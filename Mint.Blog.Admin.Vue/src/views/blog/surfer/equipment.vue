<template>
  <main class="equipment-page mx-auto max-w-screen-xl px-4 py-4 md:px-6" :class="pageClass">
    <div class="mt-10 mb-3">
        <section class="hero panel">
          <div>
            <p class="eyebrow">Equipment</p>
            <h1>我的开发装备</h1>
            <p class="hero-desc">这里记录日常开发、写博客、调试服务和折腾项目时使用的设备与软件环境。装备不一定昂贵，稳定、顺手、能持续输出才最重要。</p>
            <div class="hero-tags">
              <span><ThunderboltOutlined /> 高效开发</span>
              <span><RocketOutlined /> 快速交付</span>
            </div>
          </div>
          <div class="screen-card">
            <div class="screen-dot"><i></i><i></i><i></i></div>
            <b></b><b></b><b></b>
            <div class="terminal">pnpm run dev</div>
          </div>
        </section>

        <section class="summary-grid">
          <div v-for="item in summary" :key="item.label" class="summary-card panel">
            <span>{{ item.label }}</span>
            <strong>{{ item.value }}</strong>
          </div>
        </section>

        <section class="panel section-panel">
          <div class="section-title">
            <i></i>
            <div>
              <h2>硬件设备</h2>
              <p>从主力开发机到扩展外设，组成一套适合日常编码的工作台。</p>
            </div>
          </div>
          <div class="equipment-grid">
            <article v-for="item in equipments" :key="item.name" class="device-card" :style="{ '--accent': item.accent }">
              <div class="card-head">
                <div class="device-icon"><component :is="item.icon" /></div>
                <div><small>{{ item.category }}</small><h3>{{ item.name }}</h3></div>
              </div>
              <p>{{ item.description }}</p>
              <ul><li v-for="spec in item.specs" :key="spec">{{ spec }}</li></ul>
              <div class="tag-list"><span v-for="tag in item.tags" :key="tag"># {{ tag }}</span></div>
            </article>
          </div>
        </section>

        <div class="bottom-grid">
          <section class="panel section-panel">
            <div class="section-title compact"><i></i><h2>使用场景</h2></div>
            <div class="workflow-list">
              <div v-for="item in workflows" :key="item.title" class="workflow-item">
                <div class="workflow-icon"><component :is="item.icon" /></div>
                <div><h3>{{ item.title }}</h3><p>{{ item.desc }}</p></div>
              </div>
            </div>
          </section>
          <section class="panel section-panel">
            <div class="section-title compact"><i></i><h2>软件环境</h2></div>
            <div class="software-grid">
              <div v-for="item in softwareStack" :key="item.title" class="software-item">
                <strong>{{ item.title }}</strong><span>{{ item.desc }}</span>
              </div>
            </div>
          </section>
        </div>
    </div>
  </main>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { ApiOutlined, AppleOutlined, CodeOutlined, DesktopOutlined, LaptopOutlined, RocketOutlined, ThunderboltOutlined, ToolOutlined } from '@ant-design/icons-vue';
import { useThemeStore } from '@/store/system/theme';

interface EquipmentItem {
  name: string;
  category: string;
  description: string;
  icon: unknown;
  specs: string[];
  tags: string[];
  accent: string;
}

interface SimpleItem {
  title: string;
  desc: string;
  icon?: unknown;
}

defineOptions({ name: 'SurferEquipmentPage' });

const themeStore = useThemeStore();
const pageClass = computed(() => ({ dark: themeStore.darkMode }));

const summary = [
  { label: '主力设备', value: 'MacBook Pro' },
  { label: '开发方向', value: '.NET / Vue' },
  { label: '工作方式', value: '双屏 + 终端' }
];

const equipments: EquipmentItem[] = [
  {
    name: 'MacBook Pro',
    category: '主力开发机',
    description: '日常编码、调试、写作和本地服务运行的主力设备，兼顾性能与便携。',
    icon: AppleOutlined,
    specs: ['Apple Silicon', '64GB Memory', '1TB SSD', 'MacOS'],
    tags: ['Coding', 'Blog', 'Agent'],
    accent: '#3ecf9a'
  },
  {
    name: 'Windows Desktop',
    category: '备用工作站',
    description: '用于 Windows 环境调试、工业软件验证和多端兼容测试。',
    icon: DesktopOutlined,
    specs: ['Windows 11', 'Visual Studio', 'SQL Tools', 'Docker'],
    tags: ['C#', '.NET', 'Database'],
    accent: '#60a5fa'
  },
  {
    name: 'External Display',
    category: '扩展屏幕',
    description: '双屏工作流：一屏写代码，一屏看文档、接口、日志或预览页面。',
    icon: LaptopOutlined,
    specs: ['27 inch', '2K / 4K', 'Type-C', 'Low Blue Light'],
    tags: ['效率', '阅读', '预览'],
    accent: '#a78bfa'
  },
  {
    name: 'Developer Kit',
    category: '常用外设',
    description: '键盘、鼠标、耳机和移动硬盘组成的轻量开发套件。',
    icon: ToolOutlined,
    specs: ['Mechanical Keyboard', 'Wireless Mouse', 'Headset', 'Portable SSD'],
    tags: ['输入', '备份', '会议'],
    accent: '#f59e0b'
  }
];

const workflows: SimpleItem[] = [
  { title: '本地开发', desc: 'Vite、.NET、数据库服务本地运行，配合浏览器实时预览。', icon: CodeOutlined },
  { title: '接口联调', desc: '通过 Swagger、Apifox 和日志窗口快速定位前后端问题。', icon: ApiOutlined },
  { title: '自动化辅助', desc: '使用 Agent 辅助阅读代码、整理文档和处理重复性工程任务。', icon: RocketOutlined }
];

const softwareStack: SimpleItem[] = [
  { title: 'Cursor / VS Code', desc: '主要代码编辑器' },
  { title: 'Visual Studio', desc: '.NET 项目调试' },
  { title: 'iTerm2 / PowerShell', desc: '终端与脚本执行' },
  { title: 'Docker Desktop', desc: '容器化服务' },
  { title: 'PostgreSQL', desc: '数据存储与验证' },
  { title: 'Git', desc: '版本管理' }
];
</script>

<style scoped lang="scss">
.equipment-page { color: #0d3d2d; background-color: rgb(var(--layout-bg-color)); }
.panel { border: 1px solid rgb(62 207 154 / 42%); border-radius: 28px; background: rgb(255 255 255 / 88%); box-shadow: 0 8px 28px rgb(15 23 42 / 7%); }
h1, h2, h3, p { margin: 0; }
.hero { position: relative; display: grid; grid-template-columns: minmax(0, 1.15fr) minmax(280px, .85fr); gap: 30px; align-items: center; overflow: hidden; padding: 34px; }
.hero::before { content: ''; position: absolute; inset: 0; background: radial-gradient(circle at 8% 18%, rgb(62 207 154 / 18%), transparent 34%), radial-gradient(circle at 86% 12%, rgb(96 165 250 / 14%), transparent 28%); pointer-events: none; }
.hero > * { position: relative; z-index: 1; }
.eyebrow { margin: 0 0 10px; color: #3ecf9a; font-size: 13px; font-weight: 900; letter-spacing: .1em; text-transform: uppercase; }
h1 { font-size: clamp(32px, 5vw, 54px); line-height: 1.12; font-weight: 950; }
.hero-desc { max-width: 760px; margin-top: 16px; color: #60786e; font-size: 15px; font-weight: 600; line-height: 1.9; }
.hero-tags, .tag-list { display: flex; flex-wrap: wrap; gap: 10px; }
.hero-tags { margin-top: 22px; }
.hero-tags span, .tag-list span { display: inline-flex; align-items: center; gap: 6px; border-radius: 999px; background: rgb(62 207 154 / 10%); padding: 7px 12px; color: #15956b; font-size: 12px; font-weight: 900; }
.screen-card { width: min(100%, 360px); justify-self: center; border: 1px solid rgb(62 207 154 / 28%); border-radius: 24px; background: linear-gradient(145deg, #0f172a, #1f2937); padding: 18px; box-shadow: 0 26px 58px rgb(15 23 42 / 22%); }
.screen-dot { display: flex; gap: 7px; margin-bottom: 22px; }
.screen-dot i { width: 10px; height: 10px; border-radius: 50%; background: #ef4444; }
.screen-dot i:nth-child(2) { background: #f59e0b; }
.screen-dot i:nth-child(3) { background: #22c55e; }
.screen-card b { display: block; width: 76%; height: 12px; margin-top: 12px; border-radius: 999px; background: linear-gradient(90deg, #3ecf9a, rgb(62 207 154 / 14%)); }
.screen-card b:nth-of-type(1) { width: 92%; }
.screen-card b:nth-of-type(3) { width: 48%; }
.terminal { margin-top: 24px; border-radius: 16px; background: rgb(255 255 255 / 8%); padding: 14px; color: #a7f3d0; font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace; font-size: 13px; font-weight: 800; }
.summary-grid { display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 16px; margin-top: 20px; }
.summary-card { padding: 18px 20px; }
.summary-card span { display: block; color: #6b8078; font-size: 12px; font-weight: 800; }
.summary-card strong { display: block; margin-top: 6px; color: #0d3d2d; font-size: 20px; font-weight: 950; }
.section-panel { margin-top: 20px; padding: 24px; }
.section-title { display: flex; gap: 12px; align-items: flex-start; margin-bottom: 20px; }
.section-title i { width: 5px; height: 24px; margin-top: 4px; border-radius: 999px; background: #3ecf9a; }
.section-title h2 { color: #0d3d2d; font-size: 22px; font-weight: 950; }
.section-title p { margin-top: 6px; color: #6b8078; font-size: 13px; font-weight: 600; line-height: 1.7; }
.section-title.compact { align-items: center; }
.equipment-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 18px; }
.device-card { --accent: #3ecf9a; position: relative; overflow: hidden; border: 1px solid rgb(15 61 45 / 8%); border-radius: 24px; background: linear-gradient(180deg, rgb(255 255 255 / 92%), rgb(248 253 251 / 92%)); padding: 22px; transition: transform .2s ease, box-shadow .2s ease; }
.device-card:hover { transform: translateY(-4px); box-shadow: 0 18px 36px rgb(15 23 42 / 10%); }
.device-card::after { content: ''; position: absolute; top: -42px; right: -42px; width: 108px; height: 108px; border-radius: 50%; background: color-mix(in srgb, var(--accent) 18%, transparent); }
.card-head { position: relative; z-index: 1; display: flex; gap: 14px; align-items: center; }
.device-icon, .workflow-icon { display: inline-flex; align-items: center; justify-content: center; flex: 0 0 auto; border-radius: 18px; background: color-mix(in srgb, var(--accent, #3ecf9a) 14%, white); color: var(--accent, #3ecf9a); }
.device-icon { width: 52px; height: 52px; font-size: 24px; }
.card-head small { color: var(--accent); font-size: 12px; font-weight: 900; }
.card-head h3 { margin-top: 4px; color: #0d3d2d; font-size: 19px; font-weight: 950; }
.device-card > p { margin-top: 14px; color: #60786e; font-size: 14px; font-weight: 600; line-height: 1.8; }
ul { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 10px; margin: 18px 0 0; padding: 0; list-style: none; }
li { border-radius: 14px; background: rgb(62 207 154 / 8%); padding: 9px 10px; color: #245545; font-size: 12px; font-weight: 800; }
.tag-list { margin-top: 16px; }
.bottom-grid { display: grid; grid-template-columns: minmax(0, .92fr) minmax(0, 1.08fr); gap: 20px; }
.workflow-list { display: grid; gap: 14px; }
.workflow-item { display: flex; gap: 14px; align-items: flex-start; border-radius: 20px; background: rgb(62 207 154 / 8%); padding: 16px; }
.workflow-icon { width: 42px; height: 42px; font-size: 20px; }
.workflow-item h3, .software-item strong { color: #0d3d2d; font-size: 15px; font-weight: 950; }
.workflow-item p, .software-item span { margin-top: 5px; color: #60786e; font-size: 13px; font-weight: 600; line-height: 1.7; }
.software-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 12px; }
.software-item { border-radius: 18px; background: rgb(248 253 251 / 92%); padding: 15px; }
.software-item strong, .software-item span { display: block; }
.equipment-page.dark .panel { border-color: rgb(51 65 85 / 90%); background: rgb(44 51 62 / 74%); box-shadow: 0 8px 28px rgb(0 0 0 / 18%); }
.equipment-page.dark h1, .equipment-page.dark .section-title h2, .equipment-page.dark .summary-card strong, .equipment-page.dark .card-head h3, .equipment-page.dark .workflow-item h3, .equipment-page.dark .software-item strong { color: #f8fafc; }
.equipment-page.dark .hero-desc, .equipment-page.dark .section-title p, .equipment-page.dark .device-card > p, .equipment-page.dark .workflow-item p, .equipment-page.dark .software-item span, .equipment-page.dark .summary-card span { color: #cbd5e1; }
.equipment-page.dark .device-card, .equipment-page.dark .software-item { border-color: rgb(51 65 85 / 78%); background: rgb(30 41 59 / 58%); }
.equipment-page.dark .device-card:hover { box-shadow: 0 18px 36px rgb(0 0 0 / 28%); }
.equipment-page.dark .device-icon, .equipment-page.dark .workflow-icon { background: color-mix(in srgb, var(--accent, #3ecf9a) 18%, #0f172a); }
.equipment-page.dark .hero-tags span, .equipment-page.dark .tag-list span { background: rgb(62 207 154 / 14%); color: #6ee7b7; }
.equipment-page.dark li, .equipment-page.dark .workflow-item { background: rgb(15 23 42 / 38%); color: #d1fae5; }
@media (max-width: 1024px) { .hero, .bottom-grid { grid-template-columns: 1fr; } }
@media (max-width: 768px) { .hero, .section-panel { border-radius: 22px; padding: 22px; } .summary-grid, .equipment-grid, .software-grid, ul { grid-template-columns: 1fr; } }
</style>
