<script setup lang="ts">
import { computed, ref } from 'vue';
import { GithubOutlined, MailOutlined, QqOutlined, WechatOutlined } from '@ant-design/icons-vue';
import { useThemeStore } from '@/store/system/theme';
import siteProjectIcon1 from '@/assets/blog/surfer/author/img/i1.png';
import siteProjectIcon2 from '@/assets/blog/surfer/author/img/i2.png';
import siteProjectIcon3 from '@/assets/blog/surfer/author/img/i3.png';
import siteProjectIcon4 from '@/assets/blog/surfer/author/img/i4.png';
import siteProjectIcon5 from '@/assets/blog/surfer/author/img/i5.png';
import siteProjectIcon6 from '@/assets/blog/surfer/author/img/i6.png';
import qqImg from '@/assets/blog/surfer/author/img/QQGroup.jpg';
import weixinImg from '@/assets/blog/surfer/author/img/WeixinGroup.jpg';
import sponsorImg from '@/assets/blog/surfer/author/img/WeixinSponsor.jpg';

defineOptions({ name: 'SurferAuthorPage' });

type Showcase = { title: string; desc: string; img: string; link: string; type: '站点' | '项目' };
type ContactType = 'qq' | 'wechat' | 'sponsor';

const themeStore = useThemeStore();
const pageClass = computed(() => ({ dark: themeStore.darkMode }));
const modalOpen = ref(false);
const modalImage = ref('');

const profileTags = ['C#.Net', 'Vue3', 'Full Stack', 'Blog', 'Agent', '骑行', '旅者'];
const stats = [
  { label: '主栈', value: 'C# / Vue' },
  { label: '方向', value: 'B/S 全栈' },
  { label: '坐标', value: 'Guangzhou' }
];
const timelines = [
  { time: '2026.06', title: 'Mint.Blog V2 上线', desc: '.Net + Vue3 构建的新版本博客，合并旧版分支并完善后台能力。' },
  { time: '2024.12', title: 'Mint.Blog V1 上线', desc: '基于 Java + Vue3 的个人博客。' },
  { time: '2023.06', title: '工业自动化软件开发', desc: '参与新能源客户相关业务的软件代码编写与交付。' },
  { time: '2022.06', title: '系统学习与沉淀', desc: '重新整理知识体系，持续补齐工程化和全栈能力。' },
];
const showcases: Showcase[] = [
  {
    type: '站点',
    title: 'MintBlogV2',
    desc: '基于 .Net10 + Vue3 的个人博客。',
    img: siteProjectIcon1,
    link: 'https://www.yangmufa.cn'
  },
];
const skills = ['.Net', 'PostgreSQL', 'Vue3', 'TypeScript', 'Ant Design Vue', 'SCSS', 'Vite', 'RESTful API'];
const modalImages: Record<ContactType, string> = { qq: qqImg, wechat: weixinImg, sponsor: sponsorImg };

function openContact(type: ContactType) {
  modalImage.value = modalImages[type];
  modalOpen.value = true;
}
</script>

<template>
  <main class="author-page mx-auto max-w-screen-xl px-4 py-6 pb-12 md:px-6 md:py-8" :class="pageClass">
    <section class="author-hero">
      <div class="hero-avatar-wrap">
        <div class="hero-avatar"></div>
      </div>
      <div class="hero-content">
        <p class="eyebrow">About Author</p>
        <h1>
          你好，我是
          <span>程序员-杨工子</span>
        </h1>
        <p class="hero-desc">
          练习编程三年半，喜欢 CV、Tab、Agent。主要关注 C#.Net、Vue3 与 B/S 全栈开发，也把技术、生活和思考记录在 Mint
          Blog。
        </p>
        <div class="tag-list">
          <span v-for="tag in profileTags" :key="tag"># {{ tag }}</span>
        </div>
        <div class="contact-list">
          <APopover trigger="click">
            <template #content>
              <AButton type="link" href="https://github.com/DevCaikun">Github</AButton>
              <AButton type="link" href="https://gitee.com/DevCaikun">Gitee</AButton>
            </template>
            <button class="contact-btn">
              <GithubOutlined />
              Git
            </button>
          </APopover>
          <APopover title="网易邮箱" trigger="click">
            <template #content><AButton type="link" href="https://mail.163.com">yangmufa@163.com</AButton></template>
            <button class="contact-btn">
              <MailOutlined />
              Mail
            </button>
          </APopover>
          <button class="contact-btn" @click="openContact('qq')">
            <QqOutlined />
            QQ
          </button>
          <button class="contact-btn" @click="openContact('wechat')">
            <WechatOutlined />
            微信
          </button>
          <button class="contact-btn primary" @click="openContact('sponsor')">赞助</button>
        </div>
      </div>
    </section>

    <section class="stat-grid">
      <div v-for="item in stats" :key="item.label" class="stat-card">
        <span>{{ item.label }}</span>
        <strong>{{ item.value }}</strong>
      </div>
    </section>

    <ARow :gutter="[{ xs: 0, sm: 16, md: 28 }, 28]">
      <ACol :xs="24" :lg="16">
        <section class="panel">
          <div class="section-title">
            <span></span>
            <h2>站点与项目</h2>
          </div>
          <div class="showcase-grid">
            <a
              v-for="item in showcases"
              :key="item.title + item.type"
              class="showcase-card"
              :href="item.link"
              target="_blank"
              rel="noopener noreferrer"
            >
              <img :src="item.img" :alt="item.title" />
              <div>
                <small>{{ item.type }}</small>
                <h3>{{ item.title }}</h3>
                <p>{{ item.desc }}</p>
              </div>
            </a>
          </div>
        </section>
      </ACol>
      <ACol :xs="24" :lg="8">
        <section class="panel sticky-panel">
          <div class="section-title">
            <span></span>
            <h2>成长记录</h2>
          </div>
          <ol class="timeline">
            <li v-for="item in timelines" :key="item.time">
              <time>{{ item.time }}</time>
              <h3>{{ item.title }}</h3>
              <p>{{ item.desc }}</p>
            </li>
          </ol>
        </section>
      </ACol>
    </ARow>

    <section class="panel skill-panel">
      <div class="section-title">
        <span></span>
        <h2>技能关键词</h2>
      </div>
      <div class="skill-list">
        <span v-for="skill in skills" :key="skill">{{ skill }}</span>
      </div>
    </section>

    <AModal v-model:open="modalOpen" centered :footer="null" title="" width="300px">
      <img class="modal-image" :src="modalImage" alt="联系二维码" />
    </AModal>
  </main>
</template>

<style scoped lang="scss">
.author-page {
  color: #0d3d2d;
}
.author-hero,
.panel,
.stat-card {
  border: 1px solid rgb(62 207 154 / 50%);
  border-radius: 28px;
  background: #fff;
  box-shadow: 0 4px 24px rgb(0 0 0 / 6%);
}
.author-hero {
  display: grid;
  grid-template-columns: 220px 1fr;
  gap: 28px;
  align-items: center;
  padding: 34px;
  overflow: hidden;
  position: relative;
}
.author-hero::before {
  content: '';
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at 8% 12%, rgb(62 207 154 / 16%), transparent 34%);
  pointer-events: none;
}
.hero-avatar-wrap,
.hero-content {
  position: relative;
  z-index: 1;
}
.hero-avatar {
  width: 188px;
  aspect-ratio: 1;
  border-radius: 36px;
  background: url('@/assets/blog/surfer/author/img/HeadPortrait.jpg') center/cover;
  box-shadow: 0 18px 42px rgb(62 207 154 / 18%);
}
.eyebrow {
  margin: 0 0 8px;
  color: #3ecf9a;
  font-size: 13px;
  font-weight: 900;
  letter-spacing: 0.08em;
  text-transform: uppercase;
}
h1 {
  margin: 0;
  font-size: clamp(30px, 5vw, 52px);
  line-height: 1.15;
  font-weight: 950;
}
h1 span {
  color: #3ecf9a;
}
.hero-desc {
  max-width: 760px;
  margin: 14px 0 0;
  color: #60786e;
  font-size: 15px;
  line-height: 1.9;
  font-weight: 600;
}
.tag-list,
.contact-list,
.skill-list {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}
.tag-list {
  margin-top: 18px;
}
.tag-list span,
.skill-list span {
  border-radius: 999px;
  background: rgb(62 207 154 / 10%);
  padding: 6px 12px;
  color: #15956b;
  font-size: 12px;
  font-weight: 800;
}
.contact-list {
  margin-top: 22px;
}
.contact-btn {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  height: 36px;
  border-radius: 999px;
  background: rgb(62 207 154 / 10%);
  padding: 0 14px;
  color: #15956b;
  font-weight: 800;
  transition: 0.25s;
}
.contact-btn:hover,
.contact-btn.primary {
  background: #3ecf9a;
  color: #fff;
  transform: translateY(-2px);
}
.stat-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
  margin: 20px 0 28px;
}
.stat-card {
  padding: 18px 22px;
}
.stat-card span {
  display: block;
  color: #8aa093;
  font-size: 13px;
  font-weight: 800;
}
.stat-card strong {
  display: block;
  margin-top: 6px;
  font-size: 20px;
}
.panel {
  padding: 24px;
}
.sticky-panel {
  position: sticky;
  top: 18px;
  display: flex;
  max-height: calc(100vh - 140px);
  flex-direction: column;
}
.section-title {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 18px;
}
.section-title span {
  width: 10px;
  height: 28px;
  border-radius: 999px;
  background: #3ecf9a;
  box-shadow: 0 8px 18px rgb(62 207 154 / 28%);
}
.section-title h2 {
  margin: 0;
  font-size: 22px;
  font-weight: 950;
}
.showcase-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 14px;
}
.showcase-card {
  display: flex;
  gap: 14px;
  min-height: 132px;
  padding: 16px;
  border: 1px solid rgb(62 207 154 / 22%);
  border-radius: 22px;
  background: linear-gradient(135deg, rgb(255 255 255 / 96%), rgb(247 255 251 / 92%));
  transition: 0.25s;
}
.showcase-card:hover {
  transform: translateY(-3px);
  border-color: rgb(62 207 154 / 50%);
  box-shadow: 0 16px 36px rgb(62 207 154 / 12%);
}
.showcase-card img {
  width: 48px;
  height: 48px;
  flex: 0 0 auto;
  border-radius: 16px;
}
.showcase-card small {
  color: #3ecf9a;
  font-size: 12px;
  font-weight: 900;
}
.showcase-card h3 {
  margin: 4px 0 6px;
  color: #0d3d2d;
  font-size: 18px;
  font-weight: 950;
}
.showcase-card p,
.timeline p {
  margin: 0;
  color: #60786e;
  font-size: 13px;
  line-height: 1.7;
  font-weight: 600;
}
.timeline {
  margin: 0;
  padding: 0 8px 0 10px;
  overflow-y: auto;
  overscroll-behavior: contain;
  scrollbar-width: thin;
  scrollbar-color: rgb(62 207 154 / 45%) transparent;
}
.timeline::-webkit-scrollbar {
  width: 5px;
}
.timeline::-webkit-scrollbar-thumb {
  border-radius: 999px;
  background: rgb(62 207 154 / 45%);
}
.timeline::-webkit-scrollbar-track {
  background: transparent;
}
.timeline li {
  position: relative;
  list-style: none;
  padding: 0 0 22px 28px;
}
.timeline li::after {
  content: '';
  position: absolute;
  left: 6px;
  top: 18px;
  bottom: -4px;
  width: 2px;
  border-radius: 999px;
  background: rgb(62 207 154 / 24%);
}
.timeline li:last-child::after {
  display: none;
}
.timeline li::before {
  content: '';
  position: absolute;
  left: 0;
  top: 4px;
  width: 12px;
  height: 12px;
  border: 3px solid #fff;
  border-radius: 50%;
  background: #3ecf9a;
  box-shadow: 0 0 0 4px rgb(62 207 154 / 16%);
}
.timeline time {
  color: #3ecf9a;
  font-size: 12px;
  font-weight: 900;
}
.timeline h3 {
  margin: 5px 0 6px;
  font-size: 16px;
  font-weight: 950;
}
.skill-panel {
  margin-top: 28px;
}
.modal-image {
  display: block;
  max-width: 220px;
  max-height: 360px;
  margin: 12px auto;
  border-radius: 18px;
}
a:hover,
a:link,
a:visited,
a:active,
a:focus {
  color: inherit;
  text-decoration: none;
  outline: none;
}
.dark .author-hero,
.dark .panel,
.dark .stat-card {
  border-color: rgb(51 65 85);
  background: rgb(44 51 62 / 88%);
  box-shadow: 0 18px 52px rgb(83 157 253 / 8%);
}
.dark {
  color: #fff;
}
.dark .author-hero::before {
  background: radial-gradient(circle at 8% 12%, rgb(83 157 253 / 14%), transparent 34%);
}
.dark h1 span,
.dark .eyebrow,
.dark .section-title h2,
.dark .timeline time {
  color: #539dfd;
}
.dark .hero-desc,
.dark .showcase-card p,
.dark .timeline p,
.dark .stat-card span {
  color: #cbd5e1;
}
.dark .tag-list span,
.dark .skill-list span,
.dark .contact-btn {
  background: rgb(83 157 253 / 10%);
  color: #7fb8ff;
}
.dark .contact-btn:hover,
.dark .contact-btn.primary,
.dark .section-title span {
  background: #539dfd;
  color: #fff;
}
.dark .showcase-card {
  border-color: rgb(83 157 253 / 16%);
  background: linear-gradient(135deg, rgb(30 41 59 / 94%), rgb(15 23 42 / 92%));
}
.dark .showcase-card h3 {
  color: #fff;
}
.dark .timeline {
  scrollbar-color: rgb(83 157 253 / 45%) transparent;
}
.dark .timeline::-webkit-scrollbar-thumb {
  background: rgb(83 157 253 / 45%);
}
.dark .timeline li::before {
  background: #539dfd;
  box-shadow: 0 0 0 4px rgb(83 157 253 / 16%);
}
.dark .timeline li::after {
  background: rgb(83 157 253 / 24%);
}
@media (max-width: 991px) {
  .author-hero {
    grid-template-columns: 1fr;
    padding: 26px;
  }
  .hero-avatar {
    width: 148px;
    border-radius: 30px;
  }
  .stat-grid,
  .showcase-grid {
    grid-template-columns: 1fr;
  }
  .sticky-panel {
    position: static;
    max-height: none;
  }
  .timeline {
    overflow: visible;
  }
}
@media (max-width: 575px) {
  .author-page {
    padding-top: 16px;
  }
  .author-hero,
  .panel {
    border-radius: 24px;
    padding: 20px;
  }
  .stat-grid {
    gap: 10px;
  }
  .stat-card {
    padding: 14px;
  }
  .stat-card strong {
    font-size: 16px;
  }
  .contact-btn {
    height: 34px;
    padding: 0 12px;
  }
}
</style>
