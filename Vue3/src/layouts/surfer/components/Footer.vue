<template>
    <footer class="theme-bg-tertiary theme-text-primary overflow-hidden">
      <div class="relative max-w-screen-xl w-full mx-auto py-12 px-6">
          <!-- 主要内容区域 -->
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 mb-8">
              <!-- 版权信息 -->
              <div class="space-y-4 lg:col-span-2">
                  <div class="flex items-center space-x-3 group">
                      <div class="w-10 h-10 bg-gradient-to-br from-blue-600 via-blue-500 to-purple-600 rounded-xl flex items-center justify-center brand-logo shadow-lg group-hover:shadow-xl transition-all duration-300">
                          <span class="text-white font-bold text-lg">R</span>
                      </div>
                      <div>
                          <span class="text-xl font-bold bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent">MintBlog</span>
                          <p class="theme-text-primary !mb-0 text-xs">技术分享平台</p>
                      </div>
                  </div>
                  <p class="theme-text-primary text-sm leading-relaxed max-w-md">
                      专注于技术分享与知识传播的个人博客平台，致力于为开发者提供高质量的技术内容和学习资源。
                  </p>
                  <!-- 社交媒体链接 -->
                  <div class="flex space-x-3 pt-2">
                      <a href="#" class="social-link w-8 h-8 bg-blue-500 hover:bg-blue-600 text-white rounded-lg flex items-center justify-center transition-all duration-300 hover:scale-110 hover:shadow-lg">
                          <span class="text-sm font-bold">杨</span>
                      </a>
                      <a href="#" class="social-link w-8 h-8 bg-gray-800 hover:bg-gray-900 text-white rounded-lg flex items-center justify-center transition-all duration-300 hover:scale-110 hover:shadow-lg">
                          <span class="text-sm font-bold">工</span>
                      </a>
                      <a href="#" class="social-link w-8 h-8 bg-blue-400 hover:bg-blue-500 text-white rounded-lg flex items-center justify-center transition-all duration-300 hover:scale-110 hover:shadow-lg">
                          <span class="text-sm font-bold">子</span>
                      </a>
                  </div>
              </div>
              <!-- 快速链接 -->
              <div class="space-y-4">
                  <h3 class="theme-text-primary text-xm font-bold uppercase tracking-wider flex items-center">
                      <span class="w-2 h-2 bg-blue-500 rounded-full mr-2 animate-pulse"></span>
                      快速导航
                  </h3>
                  <ul class="space-y-3">
                      <li>
                        <a href="/" class="theme-text-primary nav-link text-sm text-gray-600 dark:text-gray-400 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 flex items-center group">
                          <span class="w-1 h-1 bg-blue-500 rounded-full mr-2 opacity-0 group-hover:opacity-100 transition-opacity duration-200"></span>
                          首页
                        </a>
                      </li>
                      <li>
                        <a href="/surfer/category/list" class="theme-text-primary nav-link text-sm text-gray-600 dark:text-gray-400 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 flex items-center group">
                          <span class="w-1 h-1 bg-blue-500 rounded-full mr-2 opacity-0 group-hover:opacity-100 transition-opacity duration-200"></span>
                          分类
                        </a>
                      </li>
                      <li>
                        <a href="/surfer/tag/list" class="theme-text-primary nav-link text-sm text-gray-600 dark:text-gray-400 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 flex items-center group">
                          <span class="w-1 h-1 bg-blue-500 rounded-full mr-2 opacity-0 group-hover:opacity-100 transition-opacity duration-200"></span>
                          标签
                        </a>
                      </li>
                      <li>
                        <a href="/surfer/archive/list" class="theme-text-primary nav-link text-sm text-gray-600 dark:text-gray-400 hover:text-blue-600 dark:hover:text-blue-400 transition-all duration-300 flex items-center group">
                          <span class="w-1 h-1 bg-blue-500 rounded-full mr-2 opacity-0 group-hover:opacity-100 transition-opacity duration-200"></span>
                          归档
                        </a>
                      </li>
                  </ul>
              </div>
              <!-- 联系信息 -->
              <div class="space-y-4">
                  <h3 class="theme-text-primary text-xm font-bold uppercase tracking-wider flex items-center">
                      <span class="w-2 h-2 bg-purple-500 rounded-full mr-2 animate-pulse"></span>
                      联系方式
                  </h3>
                  <div class="space-y-3">
                      <a href="https://www.yangmufa.cn/surfer/author" target="_blank" class="contact-link text-sm text-gray-600 dark:text-gray-400 hover:text-purple-600 dark:hover:text-purple-400 transition-all duration-300 flex items-center space-x-2 group p-2 rounded-lg hover:bg-purple-50/50 dark:hover:bg-purple-900/20">
                          <span class="text-lg group-hover:scale-110 transition-transform duration-200">🌐</span>
                          <span class="theme-text-primary font-medium">关于作者</span>
                          <span class="text-xs opacity-0 group-hover:opacity-100 transition-opacity duration-200">→</span>
                      </a>
                      <a href="https://www.yangmufa.cn/surfer/forum" target="_blank" class="contact-link text-sm text-gray-600 dark:text-gray-400 hover:text-purple-600 dark:hover:text-purple-400 transition-all duration-300 flex items-center space-x-2 group p-2 rounded-lg hover:bg-purple-50/50 dark:hover:bg-purple-900/20">
                          <span class="text-lg group-hover:scale-110 transition-transform duration-200">📧</span>
                          <span class="theme-text-primary font-medium">技术交流欢迎</span>
                          <span class="text-xs opacity-0 group-hover:opacity-100 transition-opacity duration-200">→</span>
                      </a>
                      <a href="https://www.yangmufa.cn/surfer/home" target="_blank" class="contact-link text-sm text-gray-600 dark:text-gray-400 hover:text-purple-600 dark:hover:text-purple-400 transition-all duration-300 flex items-center space-x-2 group p-2 rounded-lg hover:bg-purple-50/50 dark:hover:bg-purple-900/20">
                          <span class="text-lg group-hover:scale-110 transition-transform duration-200">🖥️</span>
                          <span class="theme-text-primary font-medium">持续学习分享</span>
                          <span class="text-xs opacity-0 group-hover:opacity-100 transition-opacity duration-200">→</span>
                      </a>
                  </div>
              </div>
          </div>
          <!-- 分割线 -->
          <div class="border-t border-gray-200/50 dark:border-gray-700/50 pt-8">
              <div class="flex flex-col md:flex-row md:items-center md:justify-between space-y-4 md:space-y-0">
                  <!-- 版权声明 -->
                  <div class="flex flex-col sm:flex-row sm:items-center space-y-2 sm:space-y-0 sm:space-x-4">
                      <span class="text-sm text-gray-500 dark:text-gray-400">
                          © {{new Date().getFullYear()}}
                          <a href="https://www.yangmufa.cn/surfer/author" target="_blank" class="font-medium text-blue-400 hover:text-blue-600 dark:hover:text-blue-400 transition-colors duration-200">杨工子</a>
                          . All Rights Reserved.
                      </span>
                  </div>
                  <!-- 备案信息 -->
                  <div class="flex items-center space-x-2">
                      <img src="@/assets/Gonan.png" alt="备案图标" class="w-4 h-4 opacity-70" />
                      <a href="https://beian.miit.gov.cn" target="_blank" class="text-blue-400 text-sm hover:text-blue-600 dark:hover:text-blue-400 transition-colors duration-200">
                          黔ICP备19007557号
                      </a>
                  </div>
              </div>
          </div>
      </div>
    </footer>
</template>
<script setup lang="ts">
</script>

<style lang="scss" scoped>
// Footer 组件的自定义样式
footer {
  // 添加微妙的阴影效果
  box-shadow: 0 -1px 3px 0 rgba(0, 0, 0, 0.1), 0 -1px 2px 0 rgba(0, 0, 0, 0.06);
  backdrop-filter: blur(10px);
  
  // 响应式设计优化
  @media (max-width: 768px) {
    .grid {
      gap: 24px;
    }
  }
  
  // 导航链接悬停效果
  .nav-link {
    position: relative;
    padding: 4px 0;
    
    &:hover {
      transform: translateX(4px);
    }
    
    &::after {
      content: '';
      position: absolute;
      width: 0;
      height: 1px;
      bottom: 0;
      left: 0;
      background: linear-gradient(90deg, #3b82f6, #8b5cf6);
      transition: width 0.3s ease;
    }
    
    &:hover::after {
      width: 100%;
    }
  }
  
  // 联系链接特殊效果
  .contact-link {
    position: relative;
    overflow: hidden;
    
    &::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(147, 51, 234, 0.1), transparent);
      transition: left 0.5s ease;
    }
    
    &:hover::before {
      left: 100%;
    }
  }
  
  // 社交媒体链接效果
  .social-link {
    position: relative;
    overflow: hidden;
    
    &::before {
      content: '';
      position: absolute;
      top: 50%;
      left: 50%;
      width: 0;
      height: 0;
      background: rgba(255, 255, 255, 0.2);
      border-radius: 50%;
      transform: translate(-50%, -50%);
      transition: width 0.4s ease, height 0.4s ease;
    }
    
    &:hover::before {
      width: 120%;
      height: 120%;
    }
  }
  
  // 品牌logo动画效果
  .brand-logo {
    transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
    position: relative;
    
    &:hover {
      transform: rotate(5deg) scale(1.1);
      box-shadow: 0 8px 25px rgba(59, 130, 246, 0.3);
    }
    
    &::after {
      content: '';
      position: absolute;
      inset: -2px;
      background: linear-gradient(45deg, #3b82f6, #8b5cf6, #3b82f6);
      border-radius: inherit;
      opacity: 0;
      z-index: -1;
      transition: opacity 0.3s ease;
    }
    
    &:hover::after {
      opacity: 0.3;
      animation: rotate 2s linear infinite;
    }
  }
}

// 深色模式下的特殊效果
.dark footer {
  box-shadow: 0 -1px 3px 0 rgba(0, 0, 0, 0.3), 0 -1px 2px 0 rgba(0, 0, 0, 0.2);
}

// 动画定义
@keyframes float {
  0%, 100% {
    transform: translateY(0px);
  }
  50% {
    transform: translateY(-10px);
  }
}

@keyframes float-delayed {
  0%, 100% {
    transform: translateY(0px) translateX(0px);
  }
  33% {
    transform: translateY(-8px) translateX(4px);
  }
  66% {
    transform: translateY(4px) translateX(-4px);
  }
}

@keyframes rotate {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

// 自定义动画类
.animate-float {
  animation: float 6s ease-in-out infinite;
}

.animate-float-delayed {
  animation: float-delayed 8s ease-in-out infinite;
  animation-delay: 2s;
}
</style>