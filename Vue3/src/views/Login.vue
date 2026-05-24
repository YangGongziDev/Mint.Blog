<template>
    <!-- 使用 grid 网格布局，并指定列数为 2，高度占满全屏，添加渐变背景 -->
    <div class="grid grid-cols-1 lg:grid-cols-2 h-screen bg-gradient-to-br from-blue-50 via-indigo-50 to-purple-50 dark:from-gray-900 dark:via-gray-800 dark:to-gray-900 transition-all duration-500">
        <!-- 左侧品牌展示区域 -->
        <div class="hidden lg:flex lg:col-span-1 bg-gradient-to-br from-indigo-600 via-purple-600 to-blue-700 dark:from-gray-800 dark:via-gray-900 dark:to-black relative overflow-hidden transition-all duration-500 items-center justify-center">
            <!-- 背景装饰元素 -->
            <div class="absolute inset-0 bg-black/10 dark:bg-white/5"></div>
            <div class="absolute top-10 left-10 w-32 h-32 bg-white/10 rounded-full blur-xl"></div>
            <div class="absolute bottom-20 right-20 w-40 h-40 bg-white/5 rounded-full blur-2xl"></div>
            <!-- 内容区域 -->
            <div class="relative z-10 flex justify-center items-center h-full flex-col p-12 text-center">
                <!-- 品牌标题 -->
                <div class="mb-8 text-center">
                    <h1 class="font-black text-5xl lg:text-6xl mb-4 text-white drop-shadow-lg leading-tight text-center">Roc<span class="text-yellow-300">Blog</span></h1>
                    <div class="w-24 h-1 bg-gradient-to-r from-yellow-300 to-orange-400 mx-auto rounded-full"></div>
                </div>
                <!-- 描述文字 -->
                <div class="space-y-4 mb-8 max-w-md text-center">
                    <p class="text-white/90 text-2xl font-medium leading-relaxed text-center">
                        高性能现代化全栈博客系统
                      </p>
                      <p class="text-white/70 text-lg leading-relaxed text-center">
                      后端基于 C#.Net10 + Dapper + PostgreSql18 构建
                      </p>
                      <p class="text-white/70 text-lg leading-relaxed text-center">
                      前端基于 TypeScript6 + Vue3 + AntDesignVue4 构建
                    </p>
                </div>
                <!-- 特性标签 -->
                <div class="flex flex-wrap gap-2 justify-center mb-8">
                    <span class="px-3 py-1 bg-white/20 text-white text-lg rounded-full backdrop-blur-sm">响应式设计</span>
                    <span class="px-3 py-1 bg-white/20 text-white text-lg rounded-full backdrop-blur-sm">暗色模式</span>
                    <span class="px-3 py-1 bg-white/20 text-white text-lg rounded-full backdrop-blur-sm">优雅界面</span>
                    <span class="px-3 py-1 bg-white/20 text-white text-lg rounded-full backdrop-blur-sm">超高性能</span>
                </div>
                <!-- 开发者图片 -->
                <div class="relative flex justify-center">
                    <div class="absolute inset-0 bg-gradient-to-t from-white/20 to-transparent rounded-2xl"></div>
                    <img src="../assets/Developer.png" class="w-64 h-auto opacity-90 drop-shadow-2xl rounded-2xl" alt="Developer">
                </div>
            </div>
        </div>
        <!-- 右侧登录表单区域 -->
        <div class="col-span-1 lg:col-span-1 bg-white/80 dark:bg-gray-900/80 backdrop-blur-xl relative transition-all duration-500">
            <!-- 装饰性背景元素 -->
            <div class="absolute top-0 right-0 w-72 h-72 bg-gradient-to-bl from-indigo-100/50 to-transparent dark:from-indigo-900/20 rounded-full blur-3xl"></div>
            <div class="absolute bottom-0 left-0 w-96 h-96 bg-gradient-to-tr from-purple-100/30 to-transparent dark:from-purple-900/10 rounded-full blur-3xl"></div>
            <!-- 主题切换开关 -->
            <div class="absolute top-6 right-6 z-20">
                <label class="switch">
                    <input type="checkbox" :checked="darkSwitch" @change="toggleDark()">
                    <span class="slider"></span>
                </label>
            </div>
            <!-- 登录表单内容 -->
            <div class="relative z-10 flex justify-center items-center h-full flex-col px-8 lg:px-16">
                <!-- 移动端品牌标题 -->
                <div class="lg:hidden mb-8 text-center">
                    <h1 class="font-black text-4xl mb-2 typing-mobile">
                        <span class="bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">Roc</span><span class="bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent">Blog</span>
                    </h1>
                    <div class="w-52 h-3 lg:w-24 lg:h-1 bg-gradient-to-r from-yellow-300 to-orange-400 mx-auto rounded-full mb-4"></div>
                    <p class="text-gray-600 dark:text-gray-400 text-sm">现代化博客管理平台</p>
                </div>
                <!-- 欢迎标题 -->
                <div class="text-center mb-8">
                    <h2 class="font-bold text-3xl lg:text-4xl mb-3 text-gray-900 dark:text-white transition-colors duration-300">
                        欢迎回来
                    </h2>
                </div>
                <!-- 分隔线 -->
                <!-- <div class="flex items-center justify-center mb-8 text-gray-400 dark:text-gray-500 w-full max-w-sm">
                    <span class="h-px flex-1 bg-gradient-to-r from-transparent via-gray-300 to-transparent dark:via-gray-600"></span>
                    <span class="px-4 text-[20px] font-medium">账号密码登录</span>
                    <span class="h-px flex-1 bg-gradient-to-r from-transparent via-gray-300 to-transparent dark:via-gray-600"></span>
                </div> -->
                <!-- 登录表单 -->
                <div class="w-full max-w-sm">
                    <a-form ref="formRef" :rules="rules" :model="form" layout="vertical" class="space-y-6">
                        <a-form-item name="username" class="mb-0">
                            <label class="input-label">账号</label>
                            <div class="relative group input-wrapper">
                                <div class="input-icon-wrapper">
                                    <UserOutlined class="input-icon" />
                                </div>
                                <a-input 
                                    size="large" 
                                    v-model:value="form.username" 
                                    placeholder="输入您的用户名或邮箱" 
                                    allow-clear
                                    class="login-input"
                                />
                            </div>
                        </a-form-item>
                        <a-form-item name="password" class="mb-0">
                            <label class="input-label">密码</label>
                            <div class="relative group input-wrapper">
                                <div class="input-icon-wrapper">
                                    <LockOutlined class="input-icon" />
                                </div>
                                <a-input-password 
                                    size="large" 
                                    v-model:value="form.password" 
                                    placeholder="输入您的登录密码" 
                                    allow-clear
                                    class="login-input"
                                />
                            </div>
                        </a-form-item>
                        <div class="pt-6">
                            <a-button class="w-full login-button"
                                size="large" 
                                :loading="loading" 
                                type="primary" 
                                @click="onSubmit"
                            >
                                <span class="font-medium">立即登录</span>
                            </a-button>
                        </div>
                    </a-form>
                    <!-- 底部提示 -->
                    <div class="mt-8 text-center">
                        <p class="text-gray-600 dark:text-gray-400 text-sm lg:text-base transition-colors duration-300">
                            登录即表示您同意
                            <a href="#" class="text-indigo-600 dark:text-indigo-400 hover:underline">服务条款</a>
                            和
                            <a href="#" class="text-indigo-600 dark:text-indigo-400 hover:underline">隐私政策</a>
                        </p>
                        <p class="text-gray-600 dark:text-gray-400 text-sm lg:text-base transition-colors duration-300">
                          最终解释权归作者
                          <a href="#" class="text-indigo-600 dark:text-indigo-400 hover:underline">杨工子</a>
                          所有 2019-{{new Date().getFullYear()}}
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
// 引入 Ant Design Vue 中的用户、锁图标
import { UserOutlined, LockOutlined } from '@ant-design/icons-vue'
import { login } from '@/api/admin/user.ts'
import { ref, reactive, onMounted, onBeforeUnmount, type Ref } from 'vue'
import { useRouter } from 'vue-router'
import { showMessage } from '@/composables/util.ts'
import { setToken } from '@/composables/cookie.ts'
import { useUserStore } from '@/stores/user.ts'
import { useTheme } from '@/composables/useTheme'
import type { FormInstance } from 'ant-design-vue'

// 定义表单数据类型
interface LoginForm {
  username: string
  password: string
}

// 定义API响应类型
interface LoginResponse {
  success: boolean
  data: {
    token: string
  }
  message?: string
}

const userStore = useUserStore()

// 定义响应式的表单对象
const form: LoginForm = reactive({
    username: 'test',
    password: 'test'
    // username: 'admin',
    // password: 'admin'
})

const router = useRouter()
// 登录按钮加载
const loading: Ref<boolean> = ref(false)

// 使用统一的主题管理
const { isDark, darkSwitch, toggleDark } = useTheme();

// 表单引用
const formRef: Ref<FormInstance | null> = ref(null)
// 表单验证规则
const rules = {
    username: [
        {
            required: true,
            message: '用户名不能为空',
            trigger: 'blur'
        }
    ],
    password: [
        {
            required: true,
            message: '密码不能为空',
            trigger: 'blur',
        },
    ]
}

const onSubmit = (): void => {
    console.log('登录')
    // 先验证 form 表单字段
    formRef.value?.validate().then(() => {
        // 开始加载
        loading.value = true

        // 调用登录接口
        login(form.username, form.password).then((res: LoginResponse) => {
            console.log(res)
            // 判断是否成功
            if (res.success == true) {
                // 提示登录成功
                showMessage('登录成功')

                // 存储 Token 到 Cookie 中
                const token: string = res.data.token
                setToken(token)

                // 获取用户信息，并存储到全局状态中
                userStore.setUserInfo();

                // 跳转到后台首页
                router.push('/admin/home')
            } else {
                // 获取服务端返回的错误消息
                const message: string = res.message || '登录失败'
                // 提示错误消息
                showMessage(message, 'error')
            }
        }).catch((error) => {
            console.log(error)
            showMessage('登录失败', 'error')
        }).finally(() => {
            // 停止加载
            loading.value = false
        })
    }).catch(() => {
        console.log('表单验证不通过')
    })
}

// 按回车键后，执行登录事件
function onKeyUp(e: KeyboardEvent): void {
    console.log(e)
    if (e.key === 'Enter') {
        onSubmit()
    }
}

// 添加键盘监听
onMounted((): void => {
    console.log('添加键盘监听')
    document.addEventListener('keyup', onKeyUp)
})

// 移除键盘监听
onBeforeUnmount((): void => {
    document.removeEventListener('keyup', onKeyUp)
})

</script>

<style lang="scss" scoped>
/* 主题切换开关样式 */
.switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 32px;
  input {
    opacity: 0;
    width: 0;
    height: 0;
    &:checked + .slider {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      &:before {
        transform: translateX(28px);
        content: "🌙";
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 14px;
      }
    }
  }
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg, #ffeaa7 0%, #fab1a0 100%);
  transition: all 0.3s ease;
  border-radius: 32px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);

  &:before {
    position: absolute;
    content: "☀️";
    height: 24px;
    width: 24px;
    left: 4px;
    bottom: 4px;
    background-color: white;
    transition: all 0.3s ease;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
  }
  &:hover {
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
  }
}

/* 输入框标签样式 */
.input-label {
    display: block;
    font-size: 14px;
    font-weight: 600;
    color: #374151;
    margin-bottom: 8px;
    letter-spacing: 0.025em;
    transition: color 0.3s ease;
}

/* 输入框外层容器样式 */
.input-wrapper {
    position: relative;
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(248, 250, 252, 0.9) 100%);
    backdrop-filter: blur(20px);
    border: 1px solid rgba(226, 232, 240, 0.8);
    border-radius: 20px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08), 0 1px 3px rgba(0, 0, 0, 0.05);
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    overflow: hidden;
    padding-left: 56px;
}

.input-wrapper:hover {
    transform: translateY(-3px);
    border-color: rgba(139, 92, 246, 0.4);
    box-shadow: 0 8px 30px rgba(139, 92, 246, 0.12), 0 4px 12px rgba(0, 0, 0, 0.08);
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(248, 250, 252, 0.95) 100%);
}

.input-wrapper:focus-within {
    transform: translateY(-3px) scale(1.01);
    border-color: #8b5cf6;
    box-shadow: 0 0 0 4px rgba(139, 92, 246, 0.15), 0 12px 40px rgba(139, 92, 246, 0.2);
    background: linear-gradient(135deg, rgba(255, 255, 255, 1) 0%, rgba(248, 250, 252, 0.98) 100%);
}

/* 图标容器样式 */
.input-icon-wrapper {
    position: absolute;
    left: 0;
    top: 0;
    bottom: 0;
    width: 56px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, rgba(139, 92, 246, 0.1) 0%, rgba(168, 85, 247, 0.05) 100%);
    border-radius: 20px 0 0 20px;
    transition: all 0.3s ease;
    z-index: 1;
}

.input-wrapper:focus-within .input-icon-wrapper {
    background: linear-gradient(135deg, rgba(139, 92, 246, 0.15) 0%, rgba(168, 85, 247, 0.1) 100%);
}

/* 图标样式 */
.input-icon {
    font-size: 18px;
    color: #8b5cf6;
    transition: all 0.3s ease;
    opacity: 0.8;
}

.input-wrapper:focus-within .input-icon {
    color: #7c3aed;
    opacity: 1;
    transform: scale(1.1);
}

/* 登录表单样式 */
:deep(.login-input) {
  width: 100% !important;
  padding: 12px 16px !important;
  border-radius: 0 20px 20px 0 !important;
  .ant-input {
    border-radius: 0 20px 20px 0 !important;
    border: none !important;
    background: transparent !important;
    box-shadow: none !important;
  }
  .ant-input-affix-wrapper {
    border-radius: 0 20px 20px 0 !important;
    border: none !important;
    background: transparent !important;
    box-shadow: none !important;
    
    .ant-input {
      border-radius: 0 !important;
      border: none !important;
      background: transparent !important;
      box-shadow: none !important;
    }
  }
  .ant-input-password {
    border-radius: 0 20px 20px 0 !important;
    
    .ant-input {
      border-radius: 0 !important;
    }
  }
}

/* 确保所有表单项和输入框容器宽度一致 */
:deep(.ant-form-item) {
  width: 100% !important;
  
  .ant-form-item-control {
    width: 100% !important;
  }
  
  .ant-form-item-control-input {
    width: 100% !important;
  }
  
  .ant-form-item-control-input-content {
    width: 100% !important;
  }
}

/* 暗色模式下的标签样式 */
.dark .input-label {
    color: #e2e8f0;
}

/* 暗色模式下的输入框外层容器样式 */
.dark .input-wrapper {
    background: linear-gradient(135deg, rgba(30, 41, 59, 0.95) 0%, rgba(15, 23, 42, 0.9) 100%);
    border: 1px solid rgba(71, 85, 105, 0.6);
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2), 0 1px 3px rgba(0, 0, 0, 0.3);
}

.dark .input-wrapper:hover {
    transform: translateY(-3px);
    border-color: rgba(168, 85, 247, 0.6);
    box-shadow: 0 8px 30px rgba(168, 85, 247, 0.15), 0 4px 12px rgba(0, 0, 0, 0.25);
    background: linear-gradient(135deg, rgba(30, 41, 59, 0.98) 0%, rgba(15, 23, 42, 0.95) 100%);
}

.dark .input-wrapper:focus-within {
    transform: translateY(-3px) scale(1.01);
    border-color: #a855f7;
    box-shadow: 0 0 0 4px rgba(168, 85, 247, 0.2), 0 12px 40px rgba(168, 85, 247, 0.25);
    background: linear-gradient(135deg, rgba(30, 41, 59, 1) 0%, rgba(15, 23, 42, 0.98) 100%);
}

/* 暗色模式下的图标容器样式 */
.dark .input-icon-wrapper {
    background: linear-gradient(135deg, rgba(168, 85, 247, 0.15) 0%, rgba(139, 92, 246, 0.1) 100%);
}

.dark .input-wrapper:focus-within .input-icon-wrapper {
    background: linear-gradient(135deg, rgba(168, 85, 247, 0.2) 0%, rgba(139, 92, 246, 0.15) 100%);
}

/* 暗色模式下的图标样式 */
.dark .input-icon {
    color: #a855f7;
}

.dark .input-wrapper:focus-within .input-icon {
    color: #c084fc;
}

/* 暗色模式下的表单样式已移除 */

/* 登录按钮样式 */
:deep(.ant-btn) {
  height: 45.6px !important;
  border-radius: 12px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  font-weight: 600;
  font-size: 16px;
  transition: all 0.3s ease;
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
  position: relative;
  overflow: hidden;
  
  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s;
  }
  
  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.6);
    background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
    
    &::before {
      left: 100%;
    }
  }
  
  &:active {
    transform: translateY(0);
  }
  
  &:focus {
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.3);
  }
  
  &.ant-btn-loading {
    background: linear-gradient(135deg, #9ca3af 0%, #6b7280 100%);
    
    .ant-btn-loading-icon {
      color: white;
    }
  }
}

/* 表单验证状态样式已移除 */

/* 输入框图标动画已移除 */

/* 表单项间距优化 */
:deep(.ant-form-item) {
  margin-bottom: 24px;
  
  .ant-form-item-explain {
    margin-top: 8px;
    font-size: 14px;
    color: #ef4444;
    animation: slideDown 0.3s ease;
  }
}

@keyframes slideDown {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* 左侧区域动画效果 */
@keyframes float {
  0%, 100% {
    transform: translateY(0px);
  }
  50% {
    transform: translateY(-10px);
  }
}

@keyframes pulse {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.8;
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

/* 左侧装饰元素动画 */
.hidden.lg\:flex {
  .absolute:nth-child(2) {
    animation: pulse 4s ease-in-out infinite;
  }
  
  .absolute:nth-child(3) {
    animation: float 6s ease-in-out infinite;
  }
}

/* 品牌标题动画 */
.hidden.lg\:flex h1 {
  animation: fadeInUp 1s ease-out;
  
  span {
    animation: pulse 2s ease-in-out infinite;
  }
}

/* 特性标签悬浮效果 */
.hidden.lg\:flex .flex.flex-wrap span {
  transition: all 0.3s ease;
  cursor: default;
  
  &:hover {
    transform: translateY(-2px) scale(1.05);
    background: rgba(255, 255, 255, 0.3);
    box-shadow: 0 4px 15px rgba(255, 255, 255, 0.2);
  }
  
  &:nth-child(1) {
    animation-delay: 0.1s;
  }
  
  &:nth-child(2) {
    animation-delay: 0.2s;
  }
  
  &:nth-child(3) {
    animation-delay: 0.3s;
  }
}

/* 开发者图片悬浮效果 */
.hidden.lg\:flex img {
  transition: all 0.4s ease;
  animation: float 8s ease-in-out infinite;
  
  &:hover {
    transform: scale(1.05) rotate(2deg);
    filter: brightness(1.1);
  }
}

/* 渐变线条动画 */
.hidden.lg\:flex .w-24.h-1 {
  animation: pulse 3s ease-in-out infinite;
  position: relative;
  overflow: hidden;
  
  &::after {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
    animation: shimmer 2s infinite;
  }
}

@keyframes shimmer {
  0% {
    left: -100%;
  }
  100% {
    left: 100%;
  }
}

/* 右侧区域动画效果 */
@keyframes fadeInRight {
  from {
    opacity: 0;
    transform: translateX(30px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

.col-span-1.lg\:col-span-1 {
  animation: fadeInRight 0.8s ease-out;
}

/* 装饰性背景元素动画 */
.col-span-1.lg\:col-span-1 .absolute:nth-child(1) {
  animation: float 10s ease-in-out infinite;
}

.col-span-1.lg\:col-span-1 .absolute:nth-child(2) {
  animation: float 12s ease-in-out infinite reverse;
}

/* 主题切换开关容器动画 */
.absolute.top-6.right-6 {
  animation: fadeInUp 0.6s ease-out 0.4s both;
}

/* 微交互动画效果 */
@keyframes bounce {
  0%, 20%, 53%, 80%, 100% {
    transform: translate3d(0, 0, 0);
  }
  40%, 43% {
    transform: translate3d(0, -8px, 0);
  }
  70% {
    transform: translate3d(0, -4px, 0);
  }
  90% {
    transform: translate3d(0, -2px, 0);
  }
}

@keyframes shake {
  0%, 100% {
    transform: translateX(0);
  }
  10%, 30%, 50%, 70%, 90% {
    transform: translateX(-2px);
  }
  20%, 40%, 60%, 80% {
    transform: translateX(2px);
  }
}

@keyframes heartbeat {
  0% {
    transform: scale(1);
  }
  14% {
    transform: scale(1.1);
  }
  28% {
    transform: scale(1);
  }
  42% {
    transform: scale(1.1);
  }
  70% {
    transform: scale(1);
  }
}

/* 表单验证错误动画已移除 */

/* 登录按钮点击动画 */
.ant-btn-primary:active {
  animation: bounce 0.6s ease;
}

/* 特性标签点击动画 */
.hidden.lg\:flex .flex.flex-wrap span:active {
  animation: heartbeat 0.6s ease;
}

/* 页面加载动画 */
@keyframes slideInFromLeft {
  0% {
    opacity: 0;
    transform: translateX(-100%);
  }
  100% {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes slideInFromRight {
  0% {
    opacity: 0;
    transform: translateX(100%);
  }
  100% {
    opacity: 1;
    transform: translateX(0);
  }
}

/* 左侧区域入场动画 */
.hidden.lg\:flex {
  animation: slideInFromLeft 1s ease-out;
}

/* 右侧区域入场动画 */
.col-span-1.lg\:col-span-1 {
  animation: slideInFromRight 1s ease-out;
}

/* 输入框聚焦时的微动画已移除 */

/* 成功状态动画已移除 */

/* 主题切换开关动画增强 */
.theme-switch {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  
  &:hover {
    animation: pulse 0.5s ease;
  }
  
  &:active {
    animation: bounce 0.3s ease;
  }
}

/* 鼠标悬浮时的细节动效已移除 */

/* 文字打字机效果 */
@keyframes typing {
  from {
    width: 0;
  }
  to {
    width: 100%;
  }
}

@keyframes blink {
  0%, 50% {
    border-color: transparent;
  }
  51%, 100% {
    border-color: currentColor;
  }
}

/* 品牌标题打字机效果 */
.hidden.lg\:flex h1 {
  overflow: hidden;
  white-space: nowrap;
  border-right: 2px solid;
  animation: typing 2s steps(20) 0.5s both, blink 1s step-end infinite 2.5s;
  height: auto;
  min-height: 80px;
  line-height: 1.1;
  
  span {
    animation: none;
  }
}

/* 移动端品牌标题打字机效果 */
.typing-mobile {
  overflow: hidden;
  white-space: nowrap;
  border-right: 2px solid;
  animation: typing 2s steps(20) 0.5s both, blink 1s step-end infinite 2.5s;
  height: auto;
  min-height: 48px;
  line-height: 1.2;
  width: fit-content;
  margin: 0 auto 24px auto;
  
  span {
    animation: none;
  }
}

/* 页面整体淡入动画 */
.min-h-screen {
  animation: fadeIn 1.5s ease-out;
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

/* 加载状态优化 */
.ant-btn-loading {
  position: relative;
  overflow: hidden;
  
  &::after {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    animation: loading-shimmer 1.5s infinite;
  }
}

@keyframes loading-shimmer {
  0% {
    left: -100%;
  }
  100% {
    left: 100%;
  }
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .switch {
    width: 50px;
    height: 28px;
    input:checked + .slider:before {
      transform: translateX(22px);
    }
    
    .slider:before {
      height: 20px;
      width: 20px;
      font-size: 12px;
    }
  }
}

/* 平板端优化 */
@media (min-width: 768px) and (max-width: 1023px) {
  :deep(.login-input) {
    .ant-input, .ant-input-affix-wrapper {
      padding: 10px 14px;
      font-size: 15px;
    }
  }
  
  :deep(.login-button) {
    margin-top: 24px;
    .ant-btn {
      height: 45px !important;
      font-size: 15px;
    }
  }
}

/* 移动端优化 */
@media (max-width: 767px) {
  /* 主容器调整 */
  .grid {
    grid-template-columns: 1fr;
    min-height: 100vh;
  }
  
  /* 移动端表单区域 */
  .col-span-1 {
    padding: 16px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
  }
  
  /* 移动端登录表单内容容器 */
  .relative.z-10.flex.justify-center.items-center.h-full.flex-col {
    height: auto;
    justify-content: center;
    padding: 32px 16px;
  }
  
  /* 移动端品牌标题调整 */
  .lg\:hidden {
    margin-bottom: 32px;
    
    h1 {
      font-size: 40px;
    }
  }
  
  /* 欢迎标题调整 */
  .text-center {
    h2 {
      font-size: 32px;
      margin-bottom: 12px;
    }
    
    p {
      font-size: 14px;
    }
  }
  
  /* 表单样式调整 */
  :deep(.login-input) {
    
    .ant-input {
      /* padding: 14px 16px; */
      font-size: 16px;
      border-radius: 10px;
    }
    
    .ant-input-affix-wrapper {
      padding: 10px 16px;
      border-radius: 10px;
      .ant-input {
        padding: 10px 0;
      }
    }
  }
  
  /* 登录按钮调整 */
  :deep(.login-button) {
       height: 45px !important;
      font-size: 16px;
      border-radius: 10px;
      margin-top: 20px;
      .ant-btn {
        height: 45px !important;
        padding: 0 24px;
      }
  }
  
  /* 主题切换开关位置调整 */
  .absolute.top-6.right-6 {
    top: 16px;
    right: 16px;
  }
  
  /* 底部提示文字调整 */
  .mt-8.text-center {
    margin-top: 24px;
    
    p {
      font-size: 12px;
      line-height: 1.4;
    }
  }
}

/* 超小屏幕优化 */
@media (max-width: 480px) {
  .col-span-1 {
    padding: 12px;
  }
  
  .lg\:hidden {
    margin-bottom: 24px;
    
    h1 {
      font-size: 32px;
    }
  }
  
  .text-center {
    margin-bottom: 8px;
    
    h2 {
      font-size: 28px;
    }
  }
  
  .w-full.max-w-sm {
    max-width: 100%;
  }
  
  :deep(.login-input) {
    .ant-input, .ant-input-affix-wrapper {
      padding: 0px 0px;
    }
  }
  
  :deep(.login-button) {
    margin-top: 20px;
    .ant-btn {
      height: 60px !important;
      padding: 25px 0 25px 0;
    }
  }
}

/* 横屏模式优化 */
@media (max-height: 600px) and (orientation: landscape) {
  .grid {
    grid-template-columns: 1fr;
    overflow-y: auto;
  }
  
  .hidden.lg\:flex {
    display: none !important;
  }
  
  .col-span-1 {
    padding: 16px;
  }
  
  .lg\:hidden {
    margin-bottom: 16px;
    
    h1 {
      font-size: 28px;
    }
  }
  
  .text-center {
    margin-bottom: 16px;
    
    h2 {
      font-size: 24px;
      margin-bottom: 8px;
    }
  }
  
  .space-y-6 > * + * {
    margin-top: 16px;
  }
  
  .mt-8.text-center {
    margin-top: 16px;
  }
}

/* 动画效果 */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.login-form {
  animation: fadeInUp 0.6s ease-out 0.2s both;
}

/* 输入框图标优化 */
:deep(.login-input) {
  .anticon {
    font-size: 18px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    opacity: 0.7;
  }
  
  &:hover .anticon {
    opacity: 0.9;
    transform: scale(1.05);
  }
  
  &:focus-within .anticon {
    opacity: 1;
    transform: scale(1.1);
  }
}

/* 暗色模式下的图标 */
.dark :deep(.login-input) {
  .anticon {
    color: #64748b !important;
  }
  
  &:focus-within .anticon {
    color: #a855f7 !important;
  }
}
</style>