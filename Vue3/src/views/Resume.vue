<template>
  <div class="resume-container">
    <!-- 个人信息头部 -->
    <section class="hero-section">
      <div class="hero-content">
        <div class="avatar-container">
          <img :src="personalInfo.avatar" :alt="personalInfo.name" class="avatar" />
          <div class="avatar-ring"></div>
        </div>
        <div class="personal-info">
          <h1 class="name">{{ personalInfo.name }}</h1>
          <h2 class="title">{{ personalInfo.title }}</h2>
          <p class="summary">{{ personalInfo.summary }}</p>
          <div class="contact-info">
            <div class="contact-item">
              <MailOutlined class="icon" />
              <span>{{ personalInfo.email }}</span>
            </div>
            <div class="contact-item">
              <PhoneOutlined class="icon" />
              <span>{{ personalInfo.phone }}</span>
            </div>
            <div class="contact-item">
              <EnvironmentOutlined class="icon" />
              <span>{{ personalInfo.location }}</span>
            </div>
            <div class="contact-item">
              <GithubOutlined class="icon" />
              <a :href="personalInfo.github" target="_blank">GitHub</a>
            </div>
            <div class="contact-item">
                <GlobalOutlined class="icon" />
                <a :href="personalInfo.website" target="_blank">www.yangmufa.cn</a>
              </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 技能展示 -->
    <section class="skills-section">
      <div class="section-container">
        <h3 class="section-title">
          <CodeOutlined class="title-icon" />
          技术技能
        </h3>
        <div class="skills-grid">
          <div v-for="skill in skills" :key="skill.name" class="skill-item">
            <div class="skill-header">
              <span class="skill-name">{{ skill.name }}</span>
              <span class="skill-level">{{ skill.level }}%</span>
            </div>
            <div class="skill-bar">
              <div class="skill-progress" :style="{ width: skill.level + '%' }"></div>
            </div>
            <div class="skill-tags">
              <span v-for="tag in skill.tags" :key="tag" class="skill-tag">{{ tag }}</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 工作经历 -->
    <section class="experience-section">
      <div class="section-container">
        <h3 class="section-title">
          <CarryOutOutlined class="title-icon" />
          工作经历
        </h3>
        <div class="timeline">
          <div v-for="(exp, index) in workExperience" :key="index" class="timeline-item">
            <div class="timeline-marker"></div>
            <div class="timeline-content">
              <div class="experience-header">
                <h4 class="company">{{ exp.company }}</h4>
                <span class="period">{{ exp.period }}</span>
              </div>
              <h5 class="position">{{ exp.position }}</h5>
              <ul class="responsibilities">
                <li v-for="responsibility in exp.responsibilities" :key="responsibility">
                  {{ responsibility }}
                </li>
              </ul>
              <div class="tech-stack">
                <span v-for="tech in exp.technologies" :key="tech" class="tech-tag">
                  {{ tech }}
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 项目经验 -->
    <section class="projects-section">
      <div class="section-container">
        <h3 class="section-title">
          <ProjectOutlined class="title-icon" />
          项目经验
        </h3>
        <div class="projects-grid">
          <div v-for="project in projects" :key="project.name" class="project-card">
            <div class="project-header">
              <h4 class="project-name">{{ project.name }}</h4>
              <div class="project-links">
                <a v-if="project.github" :href="project.github" target="_blank" class="project-link">
                  <GithubOutlined />
                </a>
                <a v-if="project.demo" :href="project.demo" target="_blank" class="project-link">
                  <GlobalOutlined />
                </a>
              </div>
            </div>
            <p class="project-description">{{ project.description }}</p>
            <div class="project-highlights">
              <h5>主要功能：</h5>
              <ul>
                <li v-for="feature in project.features" :key="feature">{{ feature }}</li>
              </ul>
            </div>
            <div class="project-tech">
              <span v-for="tech in project.technologies" :key="tech" class="tech-tag">
                {{ tech }}
              </span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 教育背景 -->
    <section class="education-section">
      <div class="section-container">
        <h3 class="section-title">
          <BookOutlined class="title-icon" />
          教育背景
        </h3>
        <div class="education-list">
          <div v-for="edu in education" :key="edu.school" class="education-item">
            <div class="education-header">
              <h4 class="school">{{ edu.school }}</h4>
              <span class="period">{{ edu.period }}</span>
            </div>
            <p class="degree">{{ edu.degree }}</p>
            <p v-if="edu.gpa" class="gpa">GPA: {{ edu.gpa }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- 证书与荣誉 -->
    <section class="certificates-section">
      <div class="section-container">
        <h3 class="section-title">
          <TrophyOutlined class="title-icon" />
          证书与荣誉
        </h3>
        <div class="certificates-grid">
          <div v-for="cert in certificates" :key="cert.name" class="certificate-item">
            <div class="certificate-icon">
              <TrophyOutlined />
            </div>
            <div class="certificate-info">
              <h4 class="certificate-name">{{ cert.name }}</h4>
              <p class="certificate-issuer">{{ cert.issuer }}</p>
              <span class="certificate-date">{{ cert.date }}</span>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import {
  MailOutlined,
  PhoneOutlined,
  EnvironmentOutlined,
  GithubOutlined,
  CodeOutlined,
  CarryOutOutlined,
  ProjectOutlined,
  BookOutlined,
  TrophyOutlined,
  GlobalOutlined
} from '@ant-design/icons-vue'

// 个人信息
const personalInfo = ref({
  name: '杨工子',
  title: '.Net全栈开发工程师',
  avatar: '/Profile.jpg',
  summary: '3年开发经验，熟练掌握.Net、PostgreSql、Vue、TypeScript等现代前端技术栈，具备良好的代码规范和团队协作能力。',
  email: 'yangmufa@163.com',
  phone: '+86 188-0000-0000',
  location: '广州市黄浦区',
  github: 'https://gitee.com/yangmufa',
  website: 'https://www.yangmufa.cn'
})

// 技能列表
const skills = ref([
  {
    name: '前端开发',
    level: 90,
    tags: ['Vue.js', 'React', 'TypeScript', 'JavaScript']
  },
  {
    name: '后端开发',
    level: 75,
    tags: ['Node.js', 'Express', 'Koa', 'MySQL']
  },
  {
    name: '移动端开发',
    level: 70,
    tags: ['React Native', 'Flutter', 'Uni-app']
  },
  {
    name: '工程化工具',
    level: 85,
    tags: ['Webpack', 'Vite', 'Docker', 'CI/CD']
  }
])

// 工作经历
const workExperience = ref([
  {
    company: '某知名互联网公司',
    position: '高级前端开发工程师',
    period: '2021.03 - 至今',
    responsibilities: [
      '负责公司核心产品的前端架构设计和开发',
      '带领3人前端团队完成多个重要项目',
      '制定前端开发规范和最佳实践',
      '优化项目性能，首屏加载时间提升40%'
    ],
    technologies: ['Vue 3', 'TypeScript', 'Element Plus', 'Vite']
  },
  {
    company: '某创业公司',
    position: '前端开发工程师',
    period: '2019.06 - 2021.02',
    responsibilities: [
      '独立完成公司官网和管理后台的开发',
      '参与产品需求分析和技术方案设计',
      '维护和优化现有项目代码',
      '协助后端开发API接口设计'
    ],
    technologies: ['Vue 2', 'JavaScript', 'Ant Design', 'Webpack']
  }
])

// 项目经验
const projects = ref([
  {
    name: 'MintBlog 博客系统',
    description: '基于Vue 3 + TypeScript开发的现代化博客系统，支持文章管理、评论系统、标签分类等功能。',
    features: [
      '响应式设计，支持多端适配',
      'Markdown编辑器，支持实时预览',
      '用户权限管理系统',
      'SEO优化和性能优化'
    ],
    technologies: ['Vue 3', 'TypeScript', 'Ant Design Vue', 'Pinia'],
    github: 'https://github.com/example/mintblog',
    demo: 'https://mintblog.example.com'
  },
  {
    name: '电商管理后台',
    description: '企业级电商管理后台系统，包含商品管理、订单处理、用户管理、数据统计等模块。',
    features: [
      '可视化数据大屏展示',
      '权限控制和角色管理',
      '批量操作和导入导出',
      '实时消息推送'
    ],
    technologies: ['React', 'TypeScript', 'Ant Design', 'ECharts'],
    github: 'https://github.com/example/admin',
    demo: null
  }
])

// 教育背景
const education = ref([
  {
    school: '某知名大学',
    degree: '计算机科学与技术 本科',
    period: '2015.09 - 2019.06',
    gpa: '3.8/4.0'
  }
])

// 证书与荣誉
const certificates = ref([
  {
    name: '阿里云开发者认证',
    issuer: '阿里云',
    date: '2022.08'
  },
  {
    name: '优秀员工奖',
    issuer: '某知名互联网公司',
    date: '2022.12'
  },
  {
    name: 'CET-6 英语六级',
    issuer: '教育部考试中心',
    date: '2018.12'
  }
])
</script>

<style scoped lang="scss">
.resume-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  background: #f8fafc;
  min-height: 100vh;
}

// 个人信息头部
.hero-section {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 20px;
  padding: 60px 40px;
  margin-bottom: 40px;
  color: white;
  position: relative;
  overflow: hidden;

  &::before {
    content: '';
    position: absolute;
    top: -50%;
    right: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
    animation: float 6s ease-in-out infinite;
  }

  .hero-content {
    display: flex;
    align-items: center;
    gap: 40px;
    position: relative;
    z-index: 1;

    @media (max-width: 768px) {
      flex-direction: column;
      text-align: center;
      gap: 30px;
    }
  }

  .avatar-container {
    position: relative;
    flex-shrink: 0;

    .avatar {
      width: 150px;
      height: 150px;
      border-radius: 50%;
      border: 4px solid rgba(255, 255, 255, 0.3);
      object-fit: cover;
      transition: transform 0.3s ease;

      &:hover {
        transform: scale(1.05);
      }
    }

    .avatar-ring {
      position: absolute;
      top: -10px;
      left: -10px;
      right: -10px;
      bottom: -10px;
      border: 2px solid rgba(255, 255, 255, 0.2);
      border-radius: 50%;
      animation: pulse 2s infinite;
    }
  }

  .personal-info {
    flex: 1;

    .name {
      font-size: 48px;
      font-weight: 700;
      margin: 0 0 10px 0;
      background: linear-gradient(45deg, #fff, #e2e8f0);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }

    .title {
      font-size: 24px;
      font-weight: 500;
      margin: 0 0 20px 0;
      opacity: 0.9;
    }

    .summary {
      font-size: 17.6px;
      line-height: 1.6;
      margin: 0 0 30px 0;
      opacity: 0.8;
    }

    .contact-info {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 15px;

      .contact-item {
        display: flex;
        align-items: center;
        gap: 10px;
        font-size: 16px;

        .icon {
          font-size: 19.2px;
          opacity: 0.8;
        }

        a {
          color: inherit;
          text-decoration: none;
          transition: opacity 0.3s ease;

          &:hover {
            opacity: 0.8;
          }
        }
      }
    }
  }
}

// 通用样式
.section-container {
  background: white;
  border-radius: 16px;
  padding: 40px;
  margin-bottom: 30px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease, box-shadow 0.3s ease;

  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 25px -3px rgba(0, 0, 0, 0.1);
  }
}

.section-title {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 28.8px;
  font-weight: 600;
  margin: 0 0 30px 0;
  color: #1e293b;
  padding-bottom: 15px;
  border-bottom: 3px solid #e2e8f0;
  position: relative;

  &::after {
    content: '';
    position: absolute;
    bottom: -3px;
    left: 0;
    width: 60px;
    height: 3px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 2px;
  }

  .title-icon {
    font-size: 25.6px;
    color: #667eea;
  }
}

// 技能展示
.skills-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 25px;
}

.skill-item {
  padding: 20px;
  border: 1px solid #e2e8f0;
  border-radius: 12px;
  transition: all 0.3s ease;

  &:hover {
    border-color: #667eea;
    transform: translateY(-2px);
    box-shadow: 0 8px 25px -8px rgba(102, 126, 234, 0.3);
  }

  .skill-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 12px;

    .skill-name {
      font-weight: 600;
      color: #1e293b;
    }

    .skill-level {
      font-weight: 500;
      color: #667eea;
    }
  }

  .skill-bar {
    height: 8px;
    background: #e2e8f0;
    border-radius: 4px;
    overflow: hidden;
    margin-bottom: 15px;

    .skill-progress {
      height: 100%;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      border-radius: 4px;
      transition: width 1s ease;
    }
  }

  .skill-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;

    .skill-tag {
      padding: 4px 12px;
      background: #f1f5f9;
      color: #475569;
      border-radius: 20px;
      font-size: 13.6px;
      font-weight: 500;
    }
  }
}

// 工作经历时间线
.timeline {
  position: relative;
  padding-left: 30px;

  &::before {
    content: '';
    position: absolute;
    left: 15px;
    top: 0;
    bottom: 0;
    width: 2px;
    background: linear-gradient(to bottom, #667eea, #764ba2);
  }
}

.timeline-item {
  position: relative;
  margin-bottom: 40px;

  &:last-child {
    margin-bottom: 0;
  }

  .timeline-marker {
    position: absolute;
    left: -37px;
    top: 8px;
    width: 12px;
    height: 12px;
    background: #667eea;
    border: 3px solid white;
    border-radius: 50%;
    box-shadow: 0 0 0 3px #e2e8f0;
  }

  .timeline-content {
    background: #f8fafc;
    padding: 25px;
    border-radius: 12px;
    border-left: 4px solid #667eea;

    .experience-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      margin-bottom: 10px;
      flex-wrap: wrap;
      gap: 10px;

      .company {
        font-size: 20.8px;
        font-weight: 600;
        color: #1e293b;
        margin: 0;
      }

      .period {
        background: #667eea;
        color: white;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 14.4px;
        font-weight: 500;
      }
    }

    .position {
      font-size: 17.6px;
      font-weight: 500;
      color: #475569;
      margin: 0 0 15px 0;
    }

    .responsibilities {
      margin: 0 0 20px 0;
      padding-left: 20px;

      li {
        margin-bottom: 8px;
        line-height: 1.6;
        color: #64748b;
      }
    }

    .tech-stack {
      display: flex;
      flex-wrap: wrap;
      gap: 8px;

      .tech-tag {
        padding: 4px 12px;
        background: white;
        color: #667eea;
        border: 1px solid #e2e8f0;
        border-radius: 20px;
        font-size: 13.6px;
        font-weight: 500;
      }
    }
  }
}

// 项目经验
.projects-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
  gap: 25px;
}

.project-card {
  border: 1px solid #e2e8f0;
  border-radius: 16px;
  padding: 25px;
  transition: all 0.3s ease;

  &:hover {
    border-color: #667eea;
    transform: translateY(-4px);
    box-shadow: 0 12px 25px -8px rgba(102, 126, 234, 0.25);
  }

  .project-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 15px;

    .project-name {
      font-size: 20.8px;
      font-weight: 600;
      color: #1e293b;
      margin: 0;
    }

    .project-links {
      display: flex;
      gap: 10px;

      .project-link {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 36px;
        height: 36px;
        background: #f1f5f9;
        color: #475569;
        border-radius: 8px;
        text-decoration: none;
        transition: all 0.3s ease;

        &:hover {
          background: #667eea;
          color: white;
          transform: scale(1.1);
        }
      }
    }
  }

  .project-description {
    color: #64748b;
    line-height: 1.6;
    margin: 0 0 20px 0;
  }

  .project-highlights {
    margin-bottom: 20px;

    h5 {
      font-weight: 600;
      color: #374151;
      margin: 0 0 10px 0;
    }

    ul {
      margin: 0;
      padding-left: 20px;

      li {
        margin-bottom: 6px;
        color: #64748b;
        line-height: 1.5;
      }
    }
  }

  .project-tech {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;

    .tech-tag {
      padding: 4px 12px;
      background: #f1f5f9;
      color: #475569;
      border-radius: 20px;
      font-size: 13.6px;
      font-weight: 500;
    }
  }
}

// 教育背景
.education-list {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.education-item {
  padding: 20px;
  border: 1px solid #e2e8f0;
  border-radius: 12px;
  transition: all 0.3s ease;

  &:hover {
    border-color: #667eea;
    transform: translateY(-2px);
    box-shadow: 0 8px 25px -8px rgba(102, 126, 234, 0.3);
  }

  .education-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 10px;
    flex-wrap: wrap;
    gap: 10px;

    .school {
      font-size: 19.2px;
      font-weight: 600;
      color: #1e293b;
      margin: 0;
    }

    .period {
      background: #667eea;
      color: white;
      padding: 4px 12px;
      border-radius: 20px;
      font-size: 14.4px;
      font-weight: 500;
    }
  }

  .degree {
    font-size: 16px;
    color: #475569;
    margin: 0 0 8px 0;
  }

  .gpa {
    font-size: 14.4px;
    color: #64748b;
    margin: 0;
  }
}

// 证书与荣誉
.certificates-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 20px;
}

.certificate-item {
  display: flex;
  align-items: center;
  gap: 15px;
  padding: 20px;
  border: 1px solid #e2e8f0;
  border-radius: 12px;
  transition: all 0.3s ease;

  &:hover {
    border-color: #667eea;
    transform: translateY(-2px);
    box-shadow: 0 8px 25px -8px rgba(102, 126, 234, 0.3);
  }

  .certificate-icon {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 50px;
    height: 50px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border-radius: 12px;
    font-size: 24px;
  }

  .certificate-info {
    flex: 1;

    .certificate-name {
      font-size: 17.6px;
      font-weight: 600;
      color: #1e293b;
      margin: 0 0 5px 0;
    }

    .certificate-issuer {
      color: #475569;
      margin: 0 0 5px 0;
    }

    .certificate-date {
      font-size: 14.4px;
      color: #64748b;
    }
  }
}

// 动画
@keyframes float {
  0%, 100% {
    transform: translateY(0px) rotate(0deg);
  }
  50% {
    transform: translateY(-20px) rotate(180deg);
  }
}

@keyframes pulse {
  0%, 100% {
    opacity: 0.4;
    transform: scale(1);
  }
  50% {
    opacity: 0.8;
    transform: scale(1.05);
  }
}

// 响应式设计
@media (max-width: 768px) {
  .resume-container {
    padding: 15px;
  }

  .section-container {
    padding: 25px 20px;
  }

  .hero-section {
    padding: 40px 25px;
  }

  .skills-grid,
  .projects-grid,
  .certificates-grid {
    grid-template-columns: 1fr;
  }

  .timeline {
    padding-left: 25px;
  }

  .timeline-item .timeline-marker {
    left: -32px;
  }

  .section-title {
    font-size: 24px;
  }

  .personal-info .name {
    font-size: 35.2px;
  }

  .personal-info .title {
    font-size: 20.8px;
  }
}

@media (max-width: 480px) {
  .resume-container {
    padding: 10px;
  }

  .section-container {
    padding: 20px 15px;
  }

  .hero-section {
    padding: 30px 20px;
  }

  .personal-info .name {
    font-size: 28.8px;
  }

  .personal-info .title {
    font-size: 17.6px;
  }

  .personal-info .contact-info {
    grid-template-columns: 1fr;
  }
}
</style>
