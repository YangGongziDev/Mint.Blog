import { defineStore } from 'pinia'
import { ref } from 'vue'
import { getBlogSettingsDetail } from '@/api/surfer/blogsettings.ts'

// 博客设置接口定义
interface BlogSettings {
  name: string
  author: string
  logo: string
  avatar: string
  introduction: string
  // 版权声明（来自接口）
  copyrightDeclaration?: string
  githubHomepage?: string
  giteeHomepage?: string
  zhihuHomepage?: string
  csdnHomepage?: string
  // 自动切换主题
  isAutoTheme?: boolean
}

export const useBlogSettingsStore = defineStore('blogsettings', () => {
  // 博客设置信息
  const blogSettings = ref<BlogSettings>({
    name: '博客',
    author: '作者',
    logo: '',
    avatar: '',
    introduction: '欢迎来到我的博客',
    copyrightDeclaration: '',
    githubHomepage: '',
    giteeHomepage: '',
    zhihuHomepage: '',
    csdnHomepage: '',
    isAutoTheme: false
  })

  // 获取博客设置信息
  function getBlogSettings() {
    // 调用后台获取博客设置信息接口
    console.log('获取博客设置信息')
    getBlogSettingsDetail().then(res => {
      if (res.success) {
        blogSettings.value = res.data
      }
    }).catch(error => {
      console.error('获取博客设置信息失败:', error)
      // 设置默认值，避免页面崩溃
      blogSettings.value = {
        name: '博客',
        author: '作者',
        logo: '',
        avatar: '',
        introduction: '欢迎来到我的博客',
        copyrightDeclaration: '',
        githubHomepage: '',
        giteeHomepage: '',
        zhihuHomepage: '',
        csdnHomepage: '',
        isAutoTheme: false
      }
    })
  }


  return { blogSettings, getBlogSettings }
})