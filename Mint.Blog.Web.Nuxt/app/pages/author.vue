<template>
  <div class="author-page">
    <section class="author-hero panel"><img class="portrait" :src="portrait" alt="程序员杨工子"><div class="hero-content"><p class="eyebrow">About Author</p><h1>你好，我是 <span>程序员杨工子</span></h1><p class="hero-desc">练习编程三年半，喜欢 CV、Tab、Agent。主要关注 C#.Net、Vue3 与 B/S 全栈开发，也把技术、生活和思考记录在 Mint Blog。</p><div class="tags"><span v-for="tag in tags" :key="tag"># {{ tag }}</span></div><div class="contacts">
      <details><summary><img :src="gitIcon" alt="">Git</summary><div class="popover"><a href="https://github.com/YangGongziDev" target="_blank" rel="noopener noreferrer">Github</a><a href="https://gitee.com/YangGongziDev" target="_blank" rel="noopener noreferrer">Gitee</a></div></details>
      <details><summary><img :src="mailIcon" alt="">Mail</summary><div class="popover"><strong>网易邮箱</strong><a href="https://mail.163.com" target="_blank" rel="noopener noreferrer">yanggongzi@163.com</a></div></details>
      <button type="button" @click="openContact('QQ', qq)"><img :src="qqIcon" alt="">QQ</button><button type="button" @click="openContact('微信', wechat)"><img :src="wechatIcon" alt="">微信</button><button class="primary" type="button" @click="openContact('赞助', sponsor)">赞助</button>
    </div></div></section>
    <section class="stats"><div v-for="item in stats" :key="item[0]" class="panel"><span>{{ item[0] }}</span><strong>{{ item[1] }}</strong></div></section>
    <div class="content-grid"><div><section class="panel"><h2>项目站点</h2><div class="showcases"><a v-for="item in showcases" :key="item[0]" href="https://www.yanggongzi.dev" target="_blank" rel="noopener noreferrer"><img :src="project" :alt="item[1]"><div><small>{{ item[0] }}</small><h3>{{ item[1] }}</h3><p>{{ item[2] }}</p></div></a></div></section><section class="panel skill-panel"><h2>技能关键词</h2><div class="tags"><span v-for="skill in skills" :key="skill">{{ skill }}</span></div></section></div><section class="panel growth"><h2>成长记录</h2><ol><li v-for="item in timelines" :key="item[0]"><time>{{ item[0] }}</time><h3>{{ item[1] }}</h3><p>{{ item[2] }}</p></li></ol></section></div>
    <dialog ref="modal" aria-labelledby="contact-title" @click="($event.target === modal) && modal?.close()"><h2 id="contact-title">{{ contact.title }}</h2><button type="button" autofocus @click="modal?.close()">关闭</button><img v-if="contact.image" class="contact-image" :src="contact.image" :alt="`${contact.title}二维码`"></dialog>
  </div>
</template>

<script setup lang="ts">
import portrait from '~/assets/author/img/HeadPortrait.jpg'
import project from '~/assets/author/img/i1.png'
import qq from '~/assets/author/img/QQGroup.jpg'
import wechat from '~/assets/author/img/WeixinGroup.jpg'
import sponsor from '~/assets/author/img/WeixinSponsor.jpg'
import gitIcon from '~/assets/author/svg/github.svg'
import mailIcon from '~/assets/author/svg/mail.svg'
import qqIcon from '~/assets/author/svg/qq.svg'
import wechatIcon from '~/assets/author/svg/wechat.svg'
useSeoMeta({ title: '作者', description: '程序员杨工子的技术、生活与成长记录。' })
const tags = ['C#.Net', 'Vue3', 'Full Stack', 'Blog', 'Agent', '骑行', '旅者']
const stats = [['主栈', 'C# / Vue'], ['方向', 'B/S 全栈'], ['坐标', 'Guangzhou']]
const skills = ['.Net', 'PostgreSQL', 'Vue3', 'TypeScript', 'Ant Design Vue', 'SCSS', 'Vite', 'RESTful API']
const timelines = [
  ['2027.10', 'Mint.Forge 上线', '基于Mint.Blog V3版本提炼的.Net12 + Vue3微服务快速开发框架。'],
  ['2026.08', 'Mint.Blog 上线', '.Net + Vue3 构建的新版本博客，合并学校时期的旧版分支并完善后台能力。'],
  ['2023.06', '进入.Net技术栈做工业自动化系统开发', '参与新能源客户相关业务的软件代码编写与交付。'],
  ['2022.07', '决定进入IT行业并系统学习与沉淀', '重新整理知识体系，持续补齐工程化和全栈能力。'],
  ['2022.05', '从贵州某途科技集团离职', '因个人原因，决定离职，开始谋求其他发展。']
]
const showcases = [
  ['全功能博客系统', 'Mint.Blog 功能齐全,清新时尚', '后端基于 .Net10 ,前端基于 Vue3(后台) + Nuxt(前台) 的全功能个人博客系统。'],
  ['百炼微服务快速开发框架', 'Mint.Forge 百炼成金,清新架构', '基于 .Net10 + Vue3 的微服务快速开发框架。']
]
const modal = ref<HTMLDialogElement>()
const contact = ref({ title: '', image: '' })
function openContact(title: string, image: string) { contact.value = { title, image }; modal.value?.showModal() }
onBeforeUnmount(() => modal.value?.close())
</script>

<style scoped>
.author-page{--accent:#3ecf9a;--author-text:#0d3d2d;--author-muted:#60786e;max-width:1280px;margin:auto;padding:24px 16px 48px;color:var(--author-text)}.panel{border:1px solid #3ecf9a80;border-radius:28px;background:var(--surface);box-shadow:0 4px 24px #0000000f;padding:24px;min-width:0}.author-hero{display:grid;grid-template-columns:220px minmax(0,1fr);gap:28px;align-items:center;padding:34px;background:radial-gradient(circle at 8% 12%,#3ecf9a29,transparent 34%),var(--surface)}.portrait{width:188px;aspect-ratio:1;border-radius:36px;object-fit:cover;box-shadow:0 18px 42px #3ecf9a2e}.eyebrow{margin:0 0 8px;color:var(--accent);font-size:13px;font-weight:900;letter-spacing:.08em;text-transform:uppercase}h1{font-size:clamp(30px,5vw,52px);line-height:1.15;font-weight:950;margin:0}h1 span{color:var(--accent)}.hero-desc{margin:14px 0 0;line-height:1.9;font-size:15px;color:var(--author-muted);font-weight:600}.tags,.contacts{display:flex;flex-wrap:wrap;gap:10px;margin-top:18px}.tags span,.contacts button,summary{border-radius:99px;background:color-mix(in srgb,var(--accent) 10%,transparent);padding:6px 12px;color:#15956b;font-weight:800;font-size:12px}.contacts{margin-top:22px;align-items:flex-start}.contacts button,summary{display:flex;align-items:center;gap:6px;min-height:36px;font-size:14px;border:0;cursor:pointer}.contacts img{width:18px;height:18px}.contacts .primary{background:var(--accent);color:white}details{position:relative}summary{list-style:none}summary::-webkit-details-marker{display:none}.popover{position:absolute;z-index:5;top:40px;left:0;display:grid;gap:8px;padding:14px;background:var(--surface);border:1px solid var(--border);border-radius:12px;box-shadow:0 8px 24px #0002}.popover a{white-space:nowrap}.stats{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:16px;margin:20px 0 28px}.stats .panel{padding:18px 22px}.stats span{display:block;color:var(--author-muted);font-size:13px}.stats strong{display:block;margin-top:6px;font-size:20px}.content-grid{display:grid;grid-template-columns:minmax(0,2fr) minmax(0,1fr);gap:28px;align-items:start}h2{display:flex;align-items:center;gap:10px;margin:0 0 18px;font-size:22px;font-weight:950}h2:before{content:'';width:10px;height:28px;border-radius:99px;background:var(--accent)}.showcases{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:14px}.showcases a{display:flex;gap:14px;padding:16px;border:1px solid #3ecf9a38;border-radius:22px;background:linear-gradient(135deg,#ffffff,#f7fffb);color:inherit;transition:transform .25s}.showcases a:hover{transform:translateY(-3px);text-decoration:none}.showcases img{width:48px;height:48px;flex-shrink:0;border-radius:16px}.showcases small,time{color:var(--accent);font-size:12px;font-weight:900}h3{margin:5px 0 6px;font-size:16px;font-weight:950}p{color:var(--author-muted)}.showcases p,.growth p{margin:0;font-size:13px;line-height:1.7;font-weight:600}.skill-panel{margin-top:28px}.growth{position:sticky;top:63px;max-height:calc(100vh - 90px);display:flex;flex-direction:column}.growth ol{margin:0;padding:0 8px 0 10px;overflow:auto;scrollbar-width:thin}.growth li{list-style:none;position:relative;padding:0 0 22px 28px;border-left:2px solid #3ecf9a3d}.growth li:before{content:'';position:absolute;left:-7px;top:4px;width:12px;height:12px;border-radius:50%;background:var(--accent)}dialog{width:min(300px,calc(100% - 24px));max-height:90vh;overflow:auto;border:1px solid var(--border);border-radius:20px;color:var(--text);background:var(--surface);padding:20px}dialog::backdrop{background:#0009}dialog button{display:block;margin-left:auto}.contact-image{display:block;max-width:100%;max-height:60vh;margin:12px auto;object-fit:contain;border-radius:18px}
.contacts summary img,
.contacts button:first-of-type img {
  filter: brightness(0) saturate(100%);
}
[data-theme="dark"] .author-page {
  --accent: #539dfd;
  --author-text: #f8fafc;
  --author-muted: #cbd5e1;
}
[data-theme="dark"] .panel {
  border-color: var(--border);
  box-shadow: 0 4px 24px #0003;
}
[data-theme="dark"] .author-hero {
  background: radial-gradient(circle at 8% 12%, #539dfd29, transparent 34%), var(--surface);
}
[data-theme="dark"] .portrait {
  box-shadow: 0 18px 42px #539dfd2e;
}
[data-theme="dark"] .showcases a {
  background: linear-gradient(135deg, var(--surface), var(--bg));
  border-color: var(--border);
}
[data-theme="dark"] .showcases a:hover,
[data-theme="dark"] .showcases a:focus-visible {
  border-color: var(--accent);
  background: linear-gradient(135deg, #539dfd14, transparent), var(--bg);
}
[data-theme="dark"] .growth li {
  border-left-color: #539dfd3d;
}
[data-theme="dark"] .tags span,
[data-theme="dark"] .contacts button,
[data-theme="dark"] summary {
  color: #7fb8ff;
}
[data-theme="dark"] .contacts summary img {
  filter: brightness(0) saturate(100%) invert(1);
}
[data-theme="dark"] .contacts button:first-of-type img {
  filter: brightness(0) saturate(100%) invert(74%) sepia(22%) saturate(1219%) hue-rotate(181deg) brightness(101%) contrast(101%);
}
[data-theme="dark"] .contacts button:hover,
[data-theme="dark"] summary:hover,
[data-theme="dark"] details[open] summary {
  background: #539dfd29;
  color: #b8d8ff;
}
[data-theme="dark"] .contacts .primary {
  background: var(--accent);
  color: #0f172a;
}
[data-theme="dark"] .contacts .primary:hover {
  background: #7fb8ff;
}
[data-theme="dark"] .popover {
  color: var(--author-text);
  border-color: var(--border);
  box-shadow: 0 8px 24px #0006;
}
[data-theme="dark"] .popover a {
  color: #7fb8ff;
}
[data-theme="dark"] .popover a:hover {
  color: #b8d8ff;
}
[data-theme="dark"] dialog {
  color: var(--author-text);
}
[data-theme="dark"] dialog button {
  color: #7fb8ff;
  border-color: var(--border);
  background: var(--bg);
}
[data-theme="dark"] dialog button:hover {
  color: #b8d8ff;
  border-color: var(--accent);
  background: #539dfd29;
}
[data-theme="dark"] .author-page :focus-visible {
  outline: 2px solid var(--accent);
  outline-offset: 3px;
}
@media(max-width:991px){.author-hero,.content-grid,.stats,.showcases{grid-template-columns:minmax(0,1fr)}.author-hero{padding:26px}.portrait{width:148px;border-radius:30px}.growth{position:static;max-height:none}.growth ol{overflow:visible}}@media(max-width:575px){.author-page{padding:16px 0 32px}.panel{border-radius:24px;padding:20px}.stats{gap:10px}.stats .panel{padding:14px}.stats strong{font-size:16px}.showcases a{flex-wrap:wrap}.popover{max-width:calc(100vw - 60px)}}@media(prefers-reduced-motion:reduce){.showcases a{transition:none}.showcases a:hover{transform:none}}
</style>
