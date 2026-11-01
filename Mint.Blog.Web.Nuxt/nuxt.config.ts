import { themeInitScript } from './app/utils/theme-init'

declare const process: { env: { NODE_ENV?: string } }

export default defineNuxtConfig({
  // 兼容日期，用于判断是否需要升级 Nuxt 版本
  compatibilityDate: '2025-07-25',
  // 开启 Nuxt 开发工具的配置
  devtools: { enabled: true },
  // 开发环境 Nuxt 服务端的配置
  devServer: { host: '0.0.0.0', port: 8080 },
  app: {
    head: {
      title: '首页',
      titleTemplate: '%s · 程序员杨工子',
      // 添加图标到浏览器页面标题栏
      link: [{ rel: 'icon', type: 'image/png', sizes: '64x64', href: '/favicon.png' }],
      script: [{
        id: 'mint-theme-init',
        tagPosition: 'head',
        tagPriority: 'critical',
        // 初始化主题，避免客户端挂载前出现主题闪烁。
        innerHTML: themeInitScript
      }]
    }
  },
  // 公共 CSS 文件
  css: ['~/assets/css/site.css', '~/assets/css/article.css'],
  runtimeConfig: {
    // Nuxt 服务端请求后端 API 的地址
    apiBase: 'http://localhost:7000/api',
    public: {
      // 前台站点地址，用于生成文章、RSS 等完整链接
      siteUrl: '',
      // 后台转跳到前台的路径：留空时禁止跳转
      adminSiteUrl: process.env.NODE_ENV === 'development' ? 'http://localhost:7100' : 'https://blog.yanggongzi.dev',
      // 资产资源的路径：留空时禁止跳转
      assetBaseUrl: 'http://localhost:7000/'
    }
  }
})
