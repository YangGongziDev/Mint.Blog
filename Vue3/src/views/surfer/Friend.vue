<template>
  <div class="theme-bg-secondary theme-text-primary min-h-screen bg-gray-50 dark:bg-gray-900">
    <!-- 页面头部 -->
    <div class="theme-bg-secondary theme-text-primary bg-white dark:bg-gray-800 shadow-sm border-b border-gray-200 dark:border-gray-700">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
        <div class="text-center">
          <h1 class="theme-bg-secondary theme-text-primary text-3xl font-bold text-gray-900 dark:text-white mb-2">
            <LinkOutlined class="mr-3 text-blue-500" />
            友情链接
          </h1>
          <p class="theme-text-primary text-gray-600 dark:text-gray-400 max-w-2xl mx-auto mb-4">
            这里收录了一些优秀的技术博客和网站，欢迎大家互相学习交流
          </p>
          <div class="text-center">
             <div class="flex justify-center gap-4">
               <button 
                 @click="siteInfoModalVisible = true"
                 class="px-4 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg transition-colors duration-300 inline-flex items-center gap-2"
               >
                 <GlobalOutlined />
                 本站友链信息
               </button>
               <button 
                 @click="friendApplicationModalVisible = true"
                 class="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg transition-colors duration-300 inline-flex items-center gap-2"
               >
                 <MailOutlined />
                 申请友链
               </button>
             </div>
           </div>
        </div>
      </div>
    </div>

    <!-- 主要内容区域 -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <!-- 分类标签页 -->
      <div class="mb-8">
        <div class="flex flex-wrap gap-2 justify-center">
          <button 
            v-for="category in categories" 
            :key="category.key"
            @click="activeCategory = category.key"
            :class="[
              'theme-bg-secondary theme-text-primary border border-gray-300 dark:border-gray-600 px-4 py-2 rounded-lg font-medium transition-all duration-300',
              activeCategory === category.key 
                ? 'bg-blue-600 text-white shadow-lg' 
                : 'bg-gray-100 dark:bg-gray-800 text-gray-700 dark:text-gray-300 hover:bg-blue-50 dark:hover:bg-gray-700'
            ]"
          >
            {{ category.label }}
            <span class="ml-2 px-2 py-0.5 text-xs rounded-full" :class="[
              activeCategory === category.key 
                ? 'bg-blue-500 text-white' 
                : 'bg-gray-200 dark:bg-gray-700 text-gray-600 dark:text-gray-400'
            ]">
              {{ getCategoryCount(category.key) }}
            </span>
          </button>
        </div>
      </div>

      <!-- 加载状态 -->
      <div v-if="loading" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        <div v-for="i in 8" :key="i" class="animate-pulse">
          <div class="bg-white dark:bg-gray-800 rounded-xl p-6 shadow-sm">
            <div class="flex items-center space-x-4">
              <div class="w-12 h-12 bg-gray-300 dark:bg-gray-600 rounded-full"></div>
              <div class="flex-1">
                <div class="h-4 bg-gray-300 dark:bg-gray-600 rounded mb-2"></div>
                <div class="h-3 bg-gray-300 dark:bg-gray-600 rounded w-3/4"></div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 友链卡片网格 -->
      <div v-else-if="filteredFriends.length > 0" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        <div 
          v-for="friend in filteredFriends" 
          :key="friend.id"
          :class="[
            'theme-bg-secondary theme-text-primary friend-card bg-white dark:bg-gray-800 rounded-xl p-6 shadow-sm transition-all duration-300 border',
            friend.status === 'pending' 
              ? 'border-orange-200 dark:border-orange-700 bg-orange-50 dark:bg-orange-900/20' 
              : 'border-gray-200 dark:border-gray-700 hover:shadow-lg hover:border-blue-300 dark:hover:border-blue-600 group cursor-pointer'
          ]"
          @click="friend.status !== 'pending' ? visitFriend(friend) : null"
        >
          <div class="flex items-start space-x-4">
            <!-- 头像 -->
            <div class="flex-shrink-0">
              <img 
                :src="friend.avatar || '/Profile.jpg'"
                :alt="friend.name"
                :class="[
                  'w-12 h-12 rounded-full object-cover ring-2 transition-all duration-300',
                  friend.status === 'pending'
                    ? 'ring-orange-200 dark:ring-orange-600 opacity-70'
                    : 'ring-gray-200 dark:ring-gray-600 group-hover:ring-blue-300 dark:group-hover:ring-blue-600'
                ]"
                @error="handleImageError"
              />
            </div>
            
            <!-- 友链信息 -->
            <div class="flex-1 min-w-0">
              <!-- 标题行 -->
              <div class="mb-1">
                <h3 :class="[
                  'theme-text-primary text-lg font-semibold transition-colors duration-300 truncate',
                  friend.status === 'pending'
                    ? 'text-orange-700 dark:text-orange-400'
                    : 'text-gray-900 dark:text-white group-hover:text-blue-600 dark:group-hover:text-blue-400'
                ]">
                  {{ friend.name }}
                </h3>
              </div>
              
              <!-- 状态标签行 -->
              <div class="flex items-center gap-2 mb-2">
                <!-- 分类标签 -->
                <span class="px-2 py-0.5 text-xs font-medium rounded-full flex-shrink-0" :class="getCategoryStyle(friend.category)">
                  {{ getCategoryLabel(friend.category) }}
                </span>
                
                <!-- 待审核状态标识 -->
                <span v-if="friend.status === 'pending'" class="px-2 py-0.5 text-xs font-medium bg-orange-100 text-orange-600 dark:bg-orange-900/30 dark:text-orange-400 rounded-full flex-shrink-0">
                  待审核
                </span>
                <!-- 访问按钮（非待审核状态显示） -->
                <span v-else @click="visitFriend(friend.url)" class="px-2 py-0.5 text-xs font-medium rounded-full flex-shrink-0" :class="getCategoryStyle(friend.category)">
                  <ExportOutlined class="mr-1 text-xs" />访问
                </span>
                
                <!-- 置顶标识（仅对非pending状态显示） -->
                <span v-if="friend.status !== 'pending' && friend.isTop" class="px-2 py-0.5 text-xs font-medium bg-red-100 text-red-600 dark:bg-red-900/30 dark:text-red-400 rounded-full flex-shrink-0">
                  置顶
                </span>
              </div>
            </div>
          </div>
                      <!-- 描述信息 -->
            <div class="flex-1 min-w-0">
              <!-- 描述（pending状态不显示） -->
              <p v-if="friend.status !== 'pending'" class="theme-text-primary text-sm text-gray-600 dark:text-gray-400 mt-2 line-clamp-2 leading-relaxed text-left">
                {{ friend.description }}
              </p>
              <!-- 链接（pending状态不显示） -->
              <div v-if="friend.status !== 'pending'" class="flex items-center text-xs text-gray-500 dark:text-gray-500 mt-3 justify-start">
                <GlobalOutlined class="mr-1 flex-shrink-0" />
                <span class="theme-text-primary truncate text-left">{{ formatUrl(friend.url) }}</span>
              </div>
            </div>
        </div>
      </div>

      <!-- 空状态 -->
      <div v-else class="text-center py-16">
        <div class="theme-bg-secondary border border-gray-200 dark:border-gray-700 mx-auto w-24 h-24 bg-gray-100 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
          <LinkOutlined class="text-3xl text-gray-400" />
        </div>
        <h3 class="theme-text-primary text-lg font-medium text-gray-900 dark:text-white mb-2">暂无友链</h3>
        <p class="theme-text-primary text-gray-600 dark:text-gray-400">还没有添加任何友情链接</p>
      </div>
    </main>
  </div>
  <!-- 本站友链信息弹框 -->
    <a-modal 
      v-model:open="siteInfoModalVisible" 
      title="本站友链信息" 
      :mask-closable="false"
      :footer="null"
      :body-style="{ maxHeight: '70vh', overflowY: 'auto', padding: '0' }"
      width="600px"
    >
     <div class="p-6">
       <div class="text-center mb-6">
         <img src="@/assets/MintBlogLogo.png" alt="MintBlog" class="w-16 h-16 mx-auto mb-4 rounded-lg" />
         <h3 class="text-xl font-bold text-gray-800 dark:text-white mb-2">{{ siteInfo.name }}</h3>
         <p class="text-gray-600 dark:text-gray-300">分享技术 · 记录生活</p>
       </div>
       
       <div class="space-y-4">
         <!-- 网站名称 -->
         <div class="flex items-center justify-between p-3 bg-gray-50 dark:bg-gray-800 rounded-lg">
           <div class="flex items-center gap-3">
             <GlobalOutlined class="text-blue-500" />
             <div>
               <span class="font-medium text-gray-700 dark:text-gray-200">网站名称：</span>
               <span class="text-gray-900 dark:text-white font-medium">{{ siteInfo.name }}</span>
             </div>
           </div>
           <div class="flex gap-2">
             <a-button size="small" @click="copySingleInfo('网站名称', siteInfo.name)">
               <CopyOutlined />
             </a-button>
           </div>
         </div>
         
         <!-- 网站图标链接 -->
         <div class="flex items-center justify-between p-3 bg-gray-50 dark:bg-gray-800 rounded-lg">
           <div class="flex items-center gap-3">
             <div>
               <span class="font-medium text-gray-700 dark:text-gray-200">网站图标：</span>
               <span class="text-blue-600 dark:text-blue-400">{{ siteInfo.icon }}</span>
             </div>
           </div>
           <a-button size="small" @click="copySingleInfo('网站图标', siteInfo.icon)">
             <CopyOutlined />
           </a-button>
         </div>
         
         <!-- 网站分类 -->
         <div class="flex items-center justify-between p-3 bg-gray-50 dark:bg-gray-800 rounded-lg">
           <div class="flex items-center gap-3">
             <MailOutlined class="text-green-500" />
             <div>
               <span class="font-medium text-gray-700 dark:text-gray-200">网站分类：</span>
               <span class="text-gray-900 dark:text-white font-medium">{{ siteInfo.category }}</span>
             </div>
           </div>
           <a-button size="small" @click="copySingleInfo('网站分类', siteInfo.category)">
             <CopyOutlined />
           </a-button>
         </div>
         
         <!-- 网站网址 -->
         <div class="flex items-center justify-between p-3 bg-gray-50 dark:bg-gray-800 rounded-lg">
           <div class="flex items-center gap-3">
             <LinkOutlined class="text-purple-500" />
             <div>
               <span class="font-medium text-gray-700 dark:text-gray-200">网站网址：</span>
               <span class="text-blue-600 dark:text-blue-400">{{ siteInfo.url }}</span>
             </div>
           </div>
           <a-button size="small" @click="copySingleInfo('网站网址', siteInfo.url)">
             <CopyOutlined />
           </a-button>
         </div>
         
         <!-- 网站描述 -->
         <div class="flex items-start justify-between p-3 bg-gray-50 dark:bg-gray-800 rounded-lg">
           <div class="flex items-start gap-3 flex-1">
             <UserOutlined class="text-orange-500 mt-1" />
             <div class="flex-1">
               <span class="font-medium text-gray-700 dark:text-gray-200">网站描述：</span>
               <p class="text-gray-900 dark:text-white mt-1">
                 {{ siteInfo.description }}
               </p>
             </div>
           </div>
           <a-button size="small" @click="copySingleInfo('网站描述', siteInfo.description)" class="ml-2">
             <CopyOutlined />
           </a-button>
         </div>
         
         <!-- 复制全部按钮 -->
         <div class="pt-4 border-t border-gray-200 dark:border-gray-700">
           <a-button type="primary" block @click="copyAllInfo" class="bg-blue-600 hover:bg-blue-700">
             <CopyOutlined class="mr-2" />
             复制全部信息
           </a-button>
         </div>
       </div>
     </div>
   </a-modal>
  <!-- 友链申请模态框 -->
  <a-modal 
    v-model:open="friendApplicationModalVisible" 
    title="友链申请" 
    width="600px" 
    :footer="null"
    :mask-closable="false"
    :body-style="{ maxHeight: '70vh', overflowY: 'auto', padding: '0' }"
  >
    <div class="friend-application-content py-4 px-6">
      <div class="mb-6">
        <div class="flex items-center mb-4">
          <div class="w-8 h-8 rounded-full flex items-center justify-center mr-3 bg-blue-100 text-blue-500">
            <MailOutlined />
          </div>
          <div>
            <div class="font-medium text-gray-900 dark:text-white">友情链接申请</div>
            <div class="text-sm text-gray-500 mt-1">欢迎优质的技术博客申请友链交换！</div>
          </div>
        </div>
        
        <div class="application-info p-4 bg-gray-50 dark:bg-gray-800 rounded-lg mb-4">
          <div class="space-y-3 text-sm text-gray-600 dark:text-gray-400">
            <div class="space-y-2">
              <p class="font-medium text-gray-900 dark:text-white">申请要求：</p>
              <ul class="list-disc list-inside space-y-1 text-xs">
                <li>技术相关的原创博客</li>
                <li>内容质量较高，更新频率稳定</li>
                <li>网站访问正常，无违法内容</li>
              </ul>
            </div>
          </div>
        </div>

        <!-- 申请表单 -->
        <form @submit.prevent="submitFriendApplication" class="space-y-4">
          <!-- 网站名称 -->
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              网站名称 <span class="text-red-500">*</span>
            </label>
            <input 
              v-model="applicationForm.name"
              type="text" 
              required
              placeholder="请输入您的网站名称"
              :class="[
                'w-full px-3 py-2 border rounded-lg focus:ring-2 focus:border-transparent bg-white dark:bg-gray-700 text-gray-900 dark:text-white transition-colors',
                fieldErrors.name 
                  ? 'border-red-500 focus:ring-red-500' 
                  : 'border-gray-300 dark:border-gray-600 focus:ring-blue-500'
              ]"
              @blur="validateField('name')"
              @input="clearFieldError('name')"
            />
            <div v-if="fieldErrors.name" class="mt-1 text-sm text-red-500">
              {{ fieldErrors.name }}
            </div>
          </div>

          <!-- 网站图标链接 -->
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              网站图标链接 <span class="text-red-500">*</span>
            </label>
            <div class="relative">
              <input 
                v-model="applicationForm.avatar"
                type="url" 
                required
                placeholder="请输入网站图标的URL地址"
                :class="[
                  'w-full px-3 py-2 border rounded-lg focus:ring-2 focus:border-transparent bg-white dark:bg-gray-700 text-gray-900 dark:text-white transition-colors',
                  fieldErrors.avatar 
                    ? 'border-red-500 focus:ring-red-500' 
                    : 'border-gray-300 dark:border-gray-600 focus:ring-blue-500'
                ]"
                @blur="validateField('avatar')"
                @input="clearFieldError('avatar')"
              />
              <!-- 图标预览 -->
              <div v-if="applicationForm.avatar && !fieldErrors.avatar" class="absolute right-2 top-2">
                <img 
                  :src="applicationForm.avatar" 
                  alt="图标预览" 
                  class="w-6 h-6 rounded object-cover"
                  @error="() => {}"
                />
              </div>
            </div>
            <div v-if="fieldErrors.avatar" class="mt-1 text-sm text-red-500">
              {{ fieldErrors.avatar }}
            </div>
          </div>

          <!-- 网站分类 -->
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              网站分类 <span class="text-red-500">*</span>
            </label>
            <a-select 
              v-model:value="applicationForm.category"
              placeholder="请选择网站分类"
              class="w-full"
              :options="categoryOptions"
              :status="fieldErrors.category ? 'error' : ''"
              @blur="validateField('category')"
              @change="clearFieldError('category')"
            />
            <div v-if="fieldErrors.category" class="mt-1 text-sm text-red-500">
              {{ fieldErrors.category }}
            </div>
          </div>

          <!-- 网站网址 -->
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              网站网址 <span class="text-red-500">*</span>
            </label>
            <input 
              v-model="applicationForm.url"
              type="url" 
              required
              placeholder="请输入您的网站地址"
              :class="[
                'w-full px-3 py-2 border rounded-lg focus:ring-2 focus:border-transparent bg-white dark:bg-gray-700 text-gray-900 dark:text-white transition-colors',
                fieldErrors.url 
                  ? 'border-red-500 focus:ring-red-500' 
                  : 'border-gray-300 dark:border-gray-600 focus:ring-blue-500'
              ]"
              @blur="validateField('url')"
              @input="clearFieldError('url')"
            />
            <div v-if="fieldErrors.url" class="mt-1 text-sm text-red-500">
              {{ fieldErrors.url }}
            </div>
          </div>

          <!-- 网站描述 -->
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              网站描述 <span class="text-red-500">*</span>
              <span class="text-xs text-gray-500 ml-1">
                ({{ applicationForm.description.length }}/200)
              </span>
            </label>
            <textarea 
              v-model="applicationForm.description"
              required
              rows="3"
              maxlength="200"
              placeholder="请简要描述您的网站内容和特色（至少10个字符）"
              :class="[
                'w-full px-3 py-2 border rounded-lg focus:ring-2 focus:border-transparent bg-white dark:bg-gray-700 text-gray-900 dark:text-white resize-none transition-colors',
                fieldErrors.description 
                  ? 'border-red-500 focus:ring-red-500' 
                  : 'border-gray-300 dark:border-gray-600 focus:ring-blue-500'
              ]"
              @blur="validateField('description')"
              @input="clearFieldError('description')"
            ></textarea>
            <div v-if="fieldErrors.description" class="mt-1 text-sm text-red-500">
              {{ fieldErrors.description }}
            </div>
          </div>

          <!-- 联系邮箱 -->
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              联系邮箱
            </label>
            <input 
              v-model="applicationForm.email"
              type="email" 
              placeholder="请输入您的联系邮箱（可选）"
              :class="[
                'w-full px-3 py-2 border rounded-lg focus:ring-2 focus:border-transparent bg-white dark:bg-gray-700 text-gray-900 dark:text-white transition-colors',
                fieldErrors.email 
                  ? 'border-red-500 focus:ring-red-500' 
                  : 'border-gray-300 dark:border-gray-600 focus:ring-blue-500'
              ]"
              @blur="validateField('email')"
              @input="clearFieldError('email')"
            />
            <div v-if="fieldErrors.email" class="mt-1 text-sm text-red-500">
              {{ fieldErrors.email }}
            </div>
          </div>
        </form>
      </div>
      
      <!-- 申请按钮区域 -->
      <div class="modal-footer flex justify-end gap-3 pt-4 border-t border-gray-200 dark:border-gray-600">
        <a-button size="middle" @click="friendApplicationModalVisible = false">取消</a-button>
        <a-button 
          type="primary" 
          size="middle" 
          @click="handleSubmitFriendApplication"
          :loading="submitting"
          class="bg-blue-600 hover:bg-blue-700"
        >
          <MailOutlined class="mr-1" />
          {{ submitting ? '提交中...' : '提交申请' }}
        </a-button>
      </div>
    </div>
  </a-modal>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { 
  LinkOutlined, 
  GlobalOutlined, 
  ExportOutlined,
  MailOutlined,
  UserOutlined,
  CopyOutlined
} from '@ant-design/icons-vue'
import { message } from 'ant-design-vue'
import { getFriendPageList, submitFriendApplication, type Friend, type FriendApplicationForm, } from '@/api/surfer/friend'

// 响应式数据
const friends = ref<Friend[]>([])
const loading = ref(true)
const friendApplicationModalVisible = ref(false)
const siteInfoModalVisible = ref(false)
const activeCategory = ref('all')
const submitting = ref(false)

// 当前网站URL
const currentSiteUrl = ref(window.location.origin)

// 网站信息数据对象
const siteInfo = ref({
  name: '程序员-杨工子',
  icon: 'https://img.yangmufa.cn/mint-blog/8c492941ce294ff597feb51f4fd8ff92.jpg',
  category: '技术类',
  url: "https://www.yangmufa.cn",
  description: '我是程序员-杨工子；练习编程两年半，C#.Net全栈工程师、MintBlog(薄荷博客)作者。'
})

// 定义分页响应类型
interface PageResponse {
  success: boolean
  data: Friend[]
  current: number
  size: number
  total: number
  pages: number
}

// 复制单条信息
const copySingleInfo = async (label: string, value: string) => {
  try {
    await navigator.clipboard.writeText(value)
    message.success(`${label}已复制到剪贴板`)
  } catch (err) {
    message.error('复制失败，请手动复制')
  }
}

// 复制全部信息
const copyAllInfo = async () => {
  const keyLabels = {
    name: '网站名称',
    icon: '网站图标',
    category: '网站分类',
    url: '网站网址',
    description: '网站描述'
  }
  
  const infoText = Object.entries(siteInfo.value)
    .map(([key, value]) => `${keyLabels[key] || key}：${value}`)
    .join('\n')
  
  try {
    await navigator.clipboard.writeText(infoText)
    message.success('全部信息已复制到剪贴板')
  } catch (err) {
    message.error('复制失败，请手动复制')
  }
}

// 友链申请表单数据
const applicationForm = ref<FriendApplicationForm>({
  name: '',
  avatar: '',
  category: '',
  url: '',
  description: '',
  email: ''
})

// 字段错误状态
const fieldErrors = ref({
  name: '',
  avatar: '',
  category: '',
  url: '',
  description: '',
  email: ''
})

// 验证单个字段
const validateField = (field: string) => {
  const value = applicationForm.value[field as keyof FriendApplicationForm]
  
  switch (field) {
    case 'name':
      if (!value?.trim()) {
        fieldErrors.value.name = '请输入网站名称'
      } else {
        fieldErrors.value.name = ''
      }
      break
    case 'avatar':
      if (!value?.trim()) {
        fieldErrors.value.avatar = '请输入网站图标链接'
      } else {
        try {
          new URL(value)
          fieldErrors.value.avatar = ''
        } catch {
          fieldErrors.value.avatar = '请输入有效的图标链接地址'
        }
      }
      break
    case 'category':
      if (!value?.trim()) {
        fieldErrors.value.category = '请选择网站分类'
      } else {
        fieldErrors.value.category = ''
      }
      break
    case 'url':
      if (!value?.trim()) {
        fieldErrors.value.url = '请输入网站网址'
      } else {
        try {
          new URL(value)
          fieldErrors.value.url = ''
        } catch {
          fieldErrors.value.url = '请输入有效的网站地址'
        }
      }
      break
    case 'description':
      if (!value?.trim()) {
        fieldErrors.value.description = '请输入网站描述'
      } else if (value.trim().length < 10) {
        fieldErrors.value.description = '网站描述至少需要10个字符'
      } else {
        fieldErrors.value.description = ''
      }
      break
    case 'email':
      if (value?.trim()) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
        if (!emailRegex.test(value)) {
          fieldErrors.value.email = '请输入有效的邮箱地址'
        } else {
          fieldErrors.value.email = ''
        }
      } else {
        fieldErrors.value.email = ''
      }
      break
  }
}

// 清除字段错误
const clearFieldError = (field: string) => {
  fieldErrors.value[field as keyof typeof fieldErrors.value] = ''
}

// 分类标签映射
const categoryLabels: Record<string, string> = {
  tech: '技术类',
  tools: '工具类',
  navigation: '导航类',
  news: '新闻类',
  aggregate: '聚合类',
  life: '生活类',
  mintblog: 'MintBlog优秀站点'
}

// 动态分类配置 - 从接口数据中提取
const categories = computed(() => {
  const dynamicCategories = new Set<string>()
  
  // 从友链数据中提取所有分类
  friends.value.forEach(friend => {
    if (friend.category) {
      dynamicCategories.add(friend.category)
    }
  })
  
  // 构建分类列表
  const categoryList = [
    { key: 'all', label: '全部' },
    { key: 'top', label: '置顶' }
  ]
  
  // 添加动态分类
  Array.from(dynamicCategories).sort().forEach(category => {
    categoryList.push({
      key: category,
      label: categoryLabels[category] || category
    })
  })
  
  return categoryList
})

// 分类选项 - 用于表单选择器
const categoryOptions = computed(() => {
  return Object.entries(categoryLabels).map(([value, label]) => ({
    value,
    label
  }))
})

// 获取友链列表
const loadFriends = async () => {
  loading.value = true
  try {
    const response: PageResponse = await getFriendPageList({current: 1, size: 100000})
    if (response.success) {
      // 过滤出未删除的友链
      let friendList = response.data.filter(friend => !friend.isDeleted)
      
      // 处理状态字段，确保每个友链都有正确的status值
      friendList = friendList.map((item: any) => {
        // 只有在真正没有status字段时才设置默认值（与数据库默认值保持一致）
        if (!item.hasOwnProperty('status') || item.status === null || item.status === undefined) {
          item.status = 'pending'; // 默认为待审核状态，与数据库默认值一致
        }
        return item;
      });
      
      // 排序：
      // 第一步：挑选出 isTop 为 true 的数据，按照 createTime 字段降序排序（最新的在前）
      const topList = friendList
        .filter(item => item.isTop === true)
        .sort((a, b) => {
          const timeA = a.createTime ? new Date(a.createTime).getTime() : 0
          const timeB = b.createTime ? new Date(b.createTime).getTime() : 0
          if (timeA !== timeB) {
            return timeB - timeA // createTime 降序
          }
          // 次级规则：id 升序，保证稳定性
          return Number(a.id) - Number(b.id)
        })
      
      // 第二步：挑选出 isTop 为 false 的数据，按照 sort 字段排序（默认按降序，数值越大越靠前）
      const normalList = friendList
        .filter(item => !item.isTop)
        .sort((a, b) => {
          const sortA = a.sort ?? 0
          const sortB = b.sort ?? 0
          if (sortA !== sortB) {
            return sortB - sortA // sort 降序
          }
          // 次级规则：id 升序，保证稳定性
          return Number(a.id) - Number(b.id)
        })

      // 合并结果：先 isTop=true 的，再 isTop=false 的
      friends.value = [...topList, ...normalList]
    } else {
      message.error('获取友链列表失败')
    }
  } catch (error) {
    console.error('获取友链列表失败:', error)
    message.error('网络错误，请稍后重试')
    
    // 降级到模拟数据
    friends.value = [
      {
        id: 1,
        name: 'Hyde Blog',
        description: '一个轻量、简洁高效、灵活配置，易于扩展的 VitePress 主题',
        url: 'https://teek.seasir.top/friend-link',
        avatar: 'https://teek.seasir.top/avatar/avatar.webp',
        status: 'active',
        createTime: '2024-01-01T00:00:00Z',
        category: 'tech',
        isTop: true,
        email: 'admin@teek.seasir.top',
        sort: 1,
        isDeleted: false,
        updateTime: '2024-01-01T00:00:00Z'
      },
      {
        id: 2,
        name: 'Vue.js 官方文档',
        description: 'Vue.js 是一套用于构建用户界面的渐进式框架，易学易用，性能出色。',
        url: 'https://vuejs.org/',
        avatar: 'https://vuejs.org/logo.svg',
        status: 'active',
        createTime: '2024-01-02T00:00:00Z',
        category: 'tech',
        isTop: true,
        sort: 2,
        isDeleted: false,
        updateTime: '2024-01-02T00:00:00Z'
      },
      {
        id: 3,
        name: 'TypeScript 官方文档',
        description: 'TypeScript 是 JavaScript 的超集，为大型应用开发提供了类型安全。',
        url: 'https://www.typescriptlang.org/',
        avatar: 'https://www.typescriptlang.org/favicon-32x32.png',
        status: 'active',
        createTime: '2024-01-03T00:00:00Z',
        category: 'tech',
        isTop: false,
        sort: 3,
        isDeleted: false,
        updateTime: '2024-01-03T00:00:00Z'
      },
      {
        id: 4,
        name: '待审核友链',
        description: '这是一个待审核的友链，不应该显示描述和链接',
        url: 'https://pending-example.com/',
        avatar: '/Profile.jpg',
        status: 'pending',
        createTime: '2024-01-04T00:00:00Z',
        category: 'tech',
        isTop: true,
        sort: 4,
        isDeleted: false,
        updateTime: '2024-01-04T00:00:00Z'
      },
      {
        id: 5,
        name: '停用友链',
        description: '这是一个停用的友链，不应该显示',
        url: 'https://inactive-example.com/',
        avatar: '/Profile.jpg',
        status: 'inactive',
        createTime: '2024-01-05T00:00:00Z',
        category: 'tech',
        isTop: false,
        sort: 5,
        isDeleted: false,
        updateTime: '2024-01-05T00:00:00Z'
      },
      {
        id: 6,
        name: '另一个待审核友链',
        description: '这也是一个待审核的友链',
        url: 'https://another-pending.com/',
        avatar: '/Profile.jpg',
        status: 'pending',
        createTime: '2024-01-06T00:00:00Z',
        category: 'life',
        isTop: false,
        sort: 6,
        isDeleted: false,
        updateTime: '2024-01-06T00:00:00Z'
      }
    ]
  } finally {
    loading.value = false
  }
}

// 访问友链
const visitFriend = (friend: Friend) => {
  // 禁止访问pending状态的友链
  if (friend.status === 'pending') {
    return
  }
  window.open(friend.url, '_blank')
}

// 表单验证函数
const validateForm = (): boolean => {
  // 验证所有必填字段
  const fieldsToValidate = ['name', 'avatar', 'category', 'url', 'description']
  let hasErrors = false
  
  fieldsToValidate.forEach(field => {
    validateField(field)
    if (fieldErrors.value[field as keyof typeof fieldErrors.value]) {
      hasErrors = true
    }
  })
  
  // 验证邮箱（如果填写了）
  if (applicationForm.value.email?.trim()) {
    validateField('email')
    if (fieldErrors.value.email) {
      hasErrors = true
    }
  }
  
  return !hasErrors
}

// 重置表单
const resetForm = () => {
  applicationForm.value = {
    name: '',
    avatar: '',
    category: '',
    url: '',
    description: '',
    email: ''
  }
  
  // 清除所有错误状态
  Object.keys(fieldErrors.value).forEach(key => {
    fieldErrors.value[key as keyof typeof fieldErrors.value] = ''
  })
}

// 提交友链申请
const handleSubmitFriendApplication = () => {
  // 防重复提交
  if (submitting.value) {
    return
  }
  
  // 表单验证
  if (!validateForm()) {
    return
  }
  
  submitting.value = true
  
  submitFriendApplication(applicationForm.value)
    .then((res: any) => {
      if (res.success === true) {
        // 重置表单
        resetForm()
        
        // 关闭模态框
        friendApplicationModalVisible.value = false
        
        // 显示成功提示
        message.success(res.message || '友链申请提交成功！我们会尽快审核您的申请。')
        
        // 重新获取友链列表数据
        loadFriends()
      } else {
        // 处理业务错误
        const errorMessage = res?.message || '提交失败，请检查网络连接后重试'
        message.error(errorMessage)
      }
    })
    .catch((error: any) => {
      // 处理网络错误或其他异常
      console.error('友链申请提交失败:', error)
      
      let errorMessage = '提交失败，请稍后重试'
      
      if (error?.response?.status === 400) {
        errorMessage = '请求参数有误，请检查填写的信息'
      } else if (error?.response?.status === 429) {
        errorMessage = '提交过于频繁，请稍后再试'
      } else if (error?.response?.status >= 500) {
        errorMessage = '服务器暂时不可用，请稍后重试'
      } else if (error?.message?.includes('Network Error')) {
        errorMessage = '网络连接失败，请检查网络后重试'
      }
      
      message.error(errorMessage)
    })
    .finally(() => {
      submitting.value = false
    })
}

// 计算属性：过滤后的友链
const filteredFriends = computed(() => {
  // 过滤掉已删除和停用的友链
  const activeFriends = friends.value.filter(friend => !friend.isDeleted && friend.status !== 'inactive')

  // 工具函数：按 createTime 降序排序（次级按 id 升序保证稳定性）
  const sortByCreateTimeDesc = (list: Friend[]) => {
    return list.sort((a, b) => {
      const timeA = a.createTime ? new Date(a.createTime).getTime() : 0
      const timeB = b.createTime ? new Date(b.createTime).getTime() : 0
      if (timeA !== timeB) return timeB - timeA
      return Number(a.id) - Number(b.id)
    })
  }

  // 工具函数：按 sort 降序排序（次级按 id 升序保证稳定性）
  const sortBySortDesc = (list: Friend[]) => {
    return list.sort((a, b) => {
      const sortA = a.sort ?? 0
      const sortB = b.sort ?? 0
      if (sortA !== sortB) return sortB - sortA
      return Number(a.id) - Number(b.id)
    })
  }

  if (activeCategory.value === 'all') {
    // 非 pending 的按：isTop=true 按 createTime 降序；isTop=false 按 sort 降序
    const nonPending = activeFriends.filter(f => f.status !== 'pending')
    const pending = activeFriends.filter(f => f.status === 'pending')

    const topList = sortByCreateTimeDesc(nonPending.filter(f => f.isTop === true))
    const normalList = sortBySortDesc(nonPending.filter(f => !f.isTop))
    const pendingSorted = sortByCreateTimeDesc(pending)

    return [...topList, ...normalList, ...pendingSorted]
  }

  if (activeCategory.value === 'top') {
    // 置顶分类不显示 pending；并按 createTime 降序
    return sortByCreateTimeDesc(activeFriends.filter(friend => friend.isTop && friend.status !== 'pending'))
  }

  // 其它分类：也按上述两步排序，并将 pending 放最后
  const list = activeFriends.filter(friend => friend.category === activeCategory.value)
  const topList = sortByCreateTimeDesc(list.filter(f => f.isTop === true && f.status !== 'pending'))
  const normalList = sortBySortDesc(list.filter(f => !f.isTop && f.status !== 'pending'))
  const pendingSorted = sortByCreateTimeDesc(list.filter(f => f.status === 'pending'))
  return [...topList, ...normalList, ...pendingSorted]
})

// 获取分类数量
const getCategoryCount = (categoryKey: string) => {
  const activeFriends = friends.value.filter(friend => !friend.isDeleted && friend.status !== 'inactive')
  if (categoryKey === 'all') {
    return activeFriends.length
  }
  if (categoryKey === 'top') {
    // 置顶分类不计算pending状态的友链
    return activeFriends.filter(friend => friend.isTop && friend.status !== 'pending').length
  }
  return activeFriends.filter(friend => friend.category === categoryKey).length
}

// 获取分类标签
const getCategoryLabel = (category: string) => {
  return categoryLabels[category] || category
}

// 获取分类样式
const getCategoryStyle = (category: string) => {
  const styleMap: Record<string, string> = {
    tech: 'bg-blue-100 text-blue-600 dark:bg-blue-900/30 dark:text-blue-400',
    life: 'bg-green-100 text-green-600 dark:bg-green-900/30 dark:text-green-400',
    aggregate: 'bg-purple-100 text-purple-600 dark:bg-purple-900/30 dark:text-purple-400',
    mintblog: 'bg-orange-100 text-orange-600 dark:bg-orange-900/30 dark:text-orange-400'
  }
  return styleMap[category] || 'bg-gray-100 text-gray-600 dark:bg-gray-700 dark:text-gray-400'
}

// 格式化URL显示
const formatUrl = (url: string) => {
  try {
    const urlObj = new URL(url)
    return urlObj.hostname
  } catch {
    return url
  }
}

// 处理图片加载错误
const handleImageError = (event: Event) => {
  const img = event.target as HTMLImageElement
  img.src = '/Profile.jpg'
}

// 组件挂载时加载数据
onMounted(() => {
  loadFriends()
})
</script>

<style>
/* 友链申请弹框样式优化 - 使用全局样式确保生效 */
.ant-modal .ant-modal-close {
  top: 16px !important;
  right: 16px !important;
  width: 32px !important;
  height: 32px !important;
  border-radius: 50% !important;
  background: rgba(0, 0, 0, 0.06) !important;
  border: none !important;
  transition: all 0.3s ease !important;
  display: flex !important;
  align-items: center !important;
  justify-content: center !important;
}

.ant-modal .ant-modal-close:hover {
  background: rgba(239, 68, 68, 0.1) !important;
  transform: scale(1.1) !important;
}

.ant-modal .ant-modal-close-x {
  width: 16px !important;
  height: 16px !important;
  font-size: 16px !important;
  color: #6b7280 !important;
  display: flex !important;
  align-items: center !important;
  justify-content: center !important;
  transition: color 0.3s ease !important;
}

.ant-modal .ant-modal-close:hover .ant-modal-close-x {
  color: #ef4444 !important;
}

/* 深色模式适配 */
.dark .ant-modal .ant-modal-close {
  background: rgba(255, 255, 255, 0.1) !important;
}

.dark .ant-modal .ant-modal-close:hover {
  background: rgba(239, 68, 68, 0.2) !important;
}

.dark .ant-modal .ant-modal-close-x {
  color: #9ca3af !important;
}

.dark .ant-modal .ant-modal-close:hover .ant-modal-close-x {
  color: #f87171 !important;
}
</style>


<style scoped lang="scss">
.friend-card {
  &:hover {
    transform: translateY(-2px);
  }
}

.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

// 响应式设计
@media (max-width: 768px) {
  .friend-card {
    &:hover {
      transform: none;
    }
  }
}
</style>
