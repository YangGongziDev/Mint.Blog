<script setup lang="ts">
import { computed, onMounted, ref } from 'vue';
import { message } from 'ant-design-vue';
import {
  CopyOutlined,
  ExportOutlined,
  GlobalOutlined,
  LinkOutlined,
  MailOutlined,
  TeamOutlined,
  UserOutlined
} from '@ant-design/icons-vue';
import Starry from '@/components/blog/surfer/starry.vue';
import {
  type Friend,
  type FriendApplicationForm,
  getFriendPageList,
  submitFriendApplication
} from '@/service/blog/surfer/friend';

defineOptions({ name: 'SurferFriendPage' });

// 响应式数据
const friends = ref<Friend[]>([]);
const loading = ref(true);
const friendApplicationModalVisible = ref(false);
const siteInfoModalVisible = ref(false);
const activeCategory = ref('all');
const submitting = ref(false);
const friendHeroImages = Object.values(
  import.meta.glob('@/assets/blog/surfer/article-banner/*.{png,jpg,jpeg,webp,avif,gif}', {
    eager: true,
    import: 'default'
  })
) as string[];
const friendHeroImage = ref('');
const friendHeroImageKey = ref(0);
const friendHeroStyle = computed(() => {
  if (!friendHeroImage.value) return undefined;
  return { backgroundImage: `url(${friendHeroImage.value})` };
});

function pickFriendHeroImage() {
  if (!friendHeroImages.length) {
    friendHeroImage.value = '';
    friendHeroImageKey.value += 1;
    return;
  }

  const lastImage = window.sessionStorage.getItem('blog-surfer:last-friend-hero-image');
  const candidates =
    friendHeroImages.length > 1
      ? friendHeroImages.filter(image => image !== lastImage && image !== friendHeroImage.value)
      : friendHeroImages;
  const pool = candidates.length ? candidates : friendHeroImages.filter(image => image !== friendHeroImage.value);
  const nextPool = pool.length ? pool : friendHeroImages;
  const nextImage = nextPool[Math.floor(Math.random() * nextPool.length)];

  friendHeroImage.value = nextImage;
  friendHeroImageKey.value += 1;
  window.sessionStorage.setItem('blog-surfer:last-friend-hero-image', nextImage);
}

// 网站信息数据对象
const siteInfo = ref({
  name: '程序员-杨工子',
  icon: 'https://img.yangmufa.cn/blog-system/author-avatar.jpg',
  category: '技术类',
  url: 'https://www.yangmufa.cn',
  description: '我是程序员-杨工子；练习编程两年半，C#.Net全栈工程师、MintBlog(薄荷博客)作者。'
});

// 定义分页响应类型
interface PageResponse {
  success: boolean;
  data: Friend[];
  current: number;
  size: number;
  total: number;
  pages: number;
}

// 复制单条信息
const copySingleInfo = async (label: string, value: string) => {
  try {
    await navigator.clipboard.writeText(value);
    message.success(`${label}已复制到剪贴板`);
  } catch {
    message.error('复制失败，请手动复制');
  }
};

// 复制全部信息
const copyAllInfo = async () => {
  const keyLabels: Record<keyof typeof siteInfo.value, string> = {
    name: '网站名称',
    icon: '网站图标',
    category: '网站分类',
    url: '网站网址',
    description: '网站描述'
  };

  const infoText = Object.entries(siteInfo.value)
    .map(([key, value]) => `${keyLabels[key as keyof typeof siteInfo.value] || key}：${value}`)
    .join('\n');

  try {
    await navigator.clipboard.writeText(infoText);
    message.success('全部信息已复制到剪贴板');
  } catch {
    message.error('复制失败，请手动复制');
  }
};

// 友链申请表单数据
const applicationForm = ref<FriendApplicationForm>({
  name: '',
  avatar: '',
  category: '',
  url: '',
  description: '',
  email: ''
});

// 字段错误状态
const fieldErrors = ref({
  name: '',
  avatar: '',
  category: '',
  url: '',
  description: '',
  email: ''
});

// 验证单个字段
const validateField = (field: string) => {
  const value = applicationForm.value[field as keyof FriendApplicationForm];

  switch (field) {
    case 'name':
      if (!value?.trim()) {
        fieldErrors.value.name = '请输入网站名称';
      } else {
        fieldErrors.value.name = '';
      }
      break;
    case 'avatar':
      if (!value?.trim()) {
        fieldErrors.value.avatar = '请输入网站图标链接';
      } else {
        try {
          new URL(value);
          fieldErrors.value.avatar = '';
        } catch {
          fieldErrors.value.avatar = '请输入有效的图标链接地址';
        }
      }
      break;
    case 'category':
      if (!value?.trim()) {
        fieldErrors.value.category = '请选择网站分类';
      } else {
        fieldErrors.value.category = '';
      }
      break;
    case 'url':
      if (!value?.trim()) {
        fieldErrors.value.url = '请输入网站网址';
      } else {
        try {
          new URL(value);
          fieldErrors.value.url = '';
        } catch {
          fieldErrors.value.url = '请输入有效的网站地址';
        }
      }
      break;
    case 'description':
      if (!value?.trim()) {
        fieldErrors.value.description = '请输入网站描述';
      } else if (value.trim().length < 10) {
        fieldErrors.value.description = '网站描述至少需要10个字符';
      } else {
        fieldErrors.value.description = '';
      }
      break;
    case 'email':
      if (value?.trim()) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(value)) {
          fieldErrors.value.email = '请输入有效的邮箱地址';
        } else {
          fieldErrors.value.email = '';
        }
      } else {
        fieldErrors.value.email = '';
      }
      break;
  }
};

// 清除字段错误
const clearFieldError = (field: string) => {
  fieldErrors.value[field as keyof typeof fieldErrors.value] = '';
};

// 分类标签映射
const categoryLabels: Record<string, string> = {
  tech: '技术类',
  tools: '工具类',
  navigation: '导航类',
  news: '新闻类',
  aggregate: '聚合类',
  life: '生活类',
  rocblog: 'RocBlog优秀站点'
};

// 动态分类配置 - 从接口数据中提取
const categories = computed(() => {
  const dynamicCategories = new Set<string>();

  // 从友链数据中提取所有分类
  friends.value.forEach(friend => {
    if (friend.category) {
      dynamicCategories.add(friend.category);
    }
  });

  // 构建分类列表
  const categoryList = [
    { key: 'all', label: '全部' },
    { key: 'top', label: '置顶' }
  ];

  // 添加动态分类
  Array.from(dynamicCategories)
    .sort()
    .forEach(category => {
      categoryList.push({
        key: category,
        label: categoryLabels[category] || category
      });
    });

  return categoryList;
});

// 分类选项 - 用于表单选择器
const categoryOptions = computed(() => {
  return Object.entries(categoryLabels).map(([value, label]) => ({
    value,
    label
  }));
});

// 获取友链列表
const loadFriends = async () => {
  loading.value = true;
  try {
    const response: PageResponse = await getFriendPageList({ current: 1, size: 100000 });
    if (response.success) {
      // 过滤出未删除的友链
      const friendList = response.data.filter(friend => !friend.isDeleted);

      // 排序：
      // 第一步：挑选出 isTop 为 true 的数据，按照 createTime 字段降序排序（最新的在前）
      const topList = friendList
        .filter(item => item.isTop === true)
        .sort((a, b) => {
          const timeA = a.createTime ? new Date(a.createTime).getTime() : 0;
          const timeB = b.createTime ? new Date(b.createTime).getTime() : 0;
          if (timeA !== timeB) {
            return timeB - timeA; // createTime 降序
          }
          // 次级规则：id 升序，保证稳定性
          return Number(a.id) - Number(b.id);
        });

      // 第二步：挑选出 isTop 为 false 的数据，按照 sort 字段排序（默认按降序，数值越大越靠前）
      const normalList = friendList
        .filter(item => !item.isTop)
        .sort((a, b) => {
          const sortA = a.sort ?? 0;
          const sortB = b.sort ?? 0;
          if (sortA !== sortB) {
            return sortB - sortA; // sort 降序
          }
          // 次级规则：id 升序，保证稳定性
          return Number(a.id) - Number(b.id);
        });

      // 合并结果：先 isTop=true 的，再 isTop=false 的
      friends.value = [...topList, ...normalList];
    } else {
      message.error('获取友链列表失败');
    }
  } catch (error) {
    console.error('获取友链列表失败:', error);
    message.error('网络错误，请稍后重试');

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
    ];
  } finally {
    loading.value = false;
  }
};

// 访问友链
const visitFriend = (url: string) => {
  window.open(url, '_blank');
};

// 表单验证函数
const validateForm = (): boolean => {
  // 验证所有必填字段
  const fieldsToValidate = ['name', 'avatar', 'category', 'url', 'description'];
  let hasErrors = false;

  fieldsToValidate.forEach(field => {
    validateField(field);
    if (fieldErrors.value[field as keyof typeof fieldErrors.value]) {
      hasErrors = true;
    }
  });

  // 验证邮箱（如果填写了）
  if (applicationForm.value.email?.trim()) {
    validateField('email');
    if (fieldErrors.value.email) {
      hasErrors = true;
    }
  }

  return !hasErrors;
};

// 重置表单
const resetForm = () => {
  applicationForm.value = {
    name: '',
    avatar: '',
    category: '',
    url: '',
    description: '',
    email: ''
  };

  // 清除所有错误状态
  Object.keys(fieldErrors.value).forEach(key => {
    fieldErrors.value[key as keyof typeof fieldErrors.value] = '';
  });
};

// 提交友链申请
const handleSubmitFriendApplication = () => {
  // 防重复提交
  if (submitting.value) {
    return;
  }

  // 表单验证
  if (!validateForm()) {
    return;
  }

  submitting.value = true;

  submitFriendApplication(applicationForm.value)
    .then((res: any) => {
      if (res.success === true) {
        // 重置表单
        resetForm();

        // 关闭模态框
        friendApplicationModalVisible.value = false;

        // 显示成功提示
        message.success(res.message || '友链申请提交成功！我们会尽快审核您的申请。');

        // 重新获取友链列表数据
        loadFriends();
      } else {
        // 处理业务错误
        const errorMessage = res?.message || '提交失败，请检查网络连接后重试';
        message.error(errorMessage);
      }
    })
    .catch((error: any) => {
      // 处理网络错误或其他异常
      console.error('友链申请提交失败:', error);

      let errorMessage = '提交失败，请稍后重试';

      if (error?.response?.status === 400) {
        errorMessage = '请求参数有误，请检查填写的信息';
      } else if (error?.response?.status === 429) {
        errorMessage = '提交过于频繁，请稍后再试';
      } else if (error?.response?.status >= 500) {
        errorMessage = '服务器暂时不可用，请稍后重试';
      } else if (error?.message?.includes('Network Error')) {
        errorMessage = '网络连接失败，请检查网络后重试';
      }

      message.error(errorMessage);
    })
    .finally(() => {
      submitting.value = false;
    });
};

interface FriendGroup {
  key: string;
  title: string;
  friends: Friend[];
}

// 计算属性：过滤后的友链分组
const friendGroups = computed<FriendGroup[]>(() => {
  const visibleFriends = friends.value.filter(friend => !friend.isDeleted);

  const sortByCreateTimeDesc = (list: Friend[]) => {
    return [...list].sort((a, b) => {
      const timeA = a.createTime ? new Date(a.createTime).getTime() : 0;
      const timeB = b.createTime ? new Date(b.createTime).getTime() : 0;
      if (timeA !== timeB) return timeB - timeA;
      return Number(a.id) - Number(b.id);
    });
  };

  const sortBySortDesc = (list: Friend[]) => {
    return [...list].sort((a, b) => {
      const sortA = a.sort ?? 0;
      const sortB = b.sort ?? 0;
      if (sortA !== sortB) return sortB - sortA;
      return Number(a.id) - Number(b.id);
    });
  };

  if (activeCategory.value === 'top') {
    const topFriends = sortByCreateTimeDesc(visibleFriends.filter(friend => friend.isTop && friend.status === 'active'));
    return topFriends.length ? [{ key: 'top', title: '置顶友链', friends: topFriends }] : [];
  }

  const scopedFriends =
    activeCategory.value === 'all' ? visibleFriends : visibleFriends.filter(friend => friend.category === activeCategory.value);

  const topFriends = sortByCreateTimeDesc(scopedFriends.filter(friend => friend.isTop && friend.status === 'active'));
  const activeFriends = sortBySortDesc(scopedFriends.filter(friend => friend.status === 'active' && !friend.isTop));
  const pendingFriends = sortByCreateTimeDesc(scopedFriends.filter(friend => friend.status === 'pending'));
  const inactiveFriends = sortBySortDesc(scopedFriends.filter(friend => friend.status === 'inactive'));

  return [
    { key: 'top', title: '置顶', friends: topFriends },
    { key: 'active', title: '已确认', friends: activeFriends },
    { key: 'pending', title: '待审核', friends: pendingFriends },
    { key: 'inactive', title: '已停用', friends: inactiveFriends }
  ].filter(group => group.friends.length > 0);
});

const filteredFriends = computed(() => friendGroups.value.flatMap(group => group.friends));

// 获取分类数量
const getCategoryCount = (categoryKey: string) => {
  const visibleFriends = friends.value.filter(friend => !friend.isDeleted);
  if (categoryKey === 'all') {
    return visibleFriends.length;
  }
  if (categoryKey === 'top') {
    return visibleFriends.filter(friend => friend.isTop && friend.status === 'active').length;
  }
  return visibleFriends.filter(friend => friend.category === categoryKey).length;
};

// 获取分类标签
const getCategoryLabel = (category: string) => {
  return categoryLabels[category] || category;
};

// 获取分类样式
const getCategoryStyle = (category: string) => {
  const styleMap: Record<string, string> = {
    tech: 'bg-blue-100 text-blue-600 dark:bg-blue-900/30 dark:text-blue-400',
    life: 'bg-green-100 text-green-600 dark:bg-zinc-800/30 dark:text-zinc-300',
    aggregate: 'bg-purple-100 text-purple-600 dark:bg-purple-900/30 dark:text-purple-400',
    rocblog: 'bg-orange-100 text-orange-600 dark:bg-orange-900/30 dark:text-orange-400'
  };
  return styleMap[category] || 'bg-gray-100 text-gray-600 dark:bg-gray-700 dark:text-gray-400';
};

// 格式化URL显示
const formatUrl = (url: string) => {
  try {
    const urlObj = new URL(url);
    return urlObj.hostname;
  } catch {
    return url;
  }
};

const fallbackAvatar = `data:image/svg+xml;utf8,${encodeURIComponent(
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 96 96"><rect width="96" height="96" rx="48" fill="#e8f7ef"/><circle cx="48" cy="36" r="16" fill="#3ecf9a"/><path d="M20 82c4-18 16-28 28-28s24 10 28 28" fill="#3ecf9a" opacity=".85"/></svg>'
)}`;

// 处理图片加载错误
const handleImageError = (event: Event) => {
  const img = event.target as HTMLImageElement;
  img.onerror = null;
  img.src = fallbackAvatar;
};

// 组件挂载时加载数据
onMounted(() => {
  pickFriendHeroImage();
  loadFriends();
});
</script>

<template>
  <div class="friend-page theme-text-primary min-h-screen">
    <section
      :key="friendHeroImageKey"
      class="friend-hero relative h-[340px] overflow-hidden bg-cover bg-center sm:h-[420px] md:h-[500px]"
      :style="friendHeroStyle"
    >
      <div class="absolute inset-0 bg-black/35"></div>
      <div class="friend-stars absolute inset-0 overflow-hidden">
        <Starry />
      </div>

      <div
        class="friend-hero-inner relative z-10 mx-auto flex h-full max-w-screen-2xl items-center justify-center px-4 text-white md:px-6"
      >
        <div class="friend-hero-content w-full max-w-5xl text-center custom-text-shadow md:-translate-y-8">
          <div class="mb-5 flex justify-center">
            <span
              class="inline-flex h-16 w-16 items-center justify-center rounded-2xl bg-white/18 text-3xl text-white shadow-2xl backdrop-blur-sm"
            >
              <LinkOutlined />
            </span>
          </div>
          <h1 class="mb-5 text-3xl font-bold leading-tight text-white sm:mb-8 sm:text-4xl md:text-5xl">
            友情链接
          </h1>
          <p class="mx-auto mb-7 max-w-2xl text-sm leading-7 text-white/86 sm:text-base">
            这里收录了一些优秀的技术博客和网站，欢迎互相学习交流。
          </p>
          <div class="flex flex-wrap justify-center gap-3">
            <button
              class="inline-flex items-center gap-2 rounded-full bg-white/18 px-5 py-2.5 text-sm font-semibold text-white backdrop-blur-sm transition-all hover:-translate-y-0.5 hover:bg-white/26"
              @click="siteInfoModalVisible = true"
            >
              <GlobalOutlined />
              本站友链信息
            </button>
            <button
              class="inline-flex items-center gap-2 rounded-full bg-[#3ecf9a] px-5 py-2.5 text-sm font-semibold text-white shadow-lg shadow-[#3ecf9a]/25 transition-all hover:-translate-y-0.5 hover:bg-[#15956b] dark:bg-[#539dfd] dark:shadow-[#539dfd]/25 dark:hover:bg-[#8cc8ff]"
              @click="friendApplicationModalVisible = true"
            >
              <MailOutlined />
              申请友链
            </button>
          </div>
          <div class="mx-auto mt-7 flex max-w-4xl flex-wrap items-center justify-center gap-x-4 gap-y-2 text-xs text-white/90 sm:gap-x-6 sm:gap-y-3 sm:text-sm">
            <div class="flex items-center">
              <span class="hero-meta-icon bg-[#4fa759]"><TeamOutlined /></span>
              {{ friends.length }} 个站点
            </div>
            <div class="flex items-center">
              <span class="hero-meta-icon bg-[#5a9cf8]"><GlobalOutlined /></span>
              {{ categories.length }} 个分类
            </div>
          </div>
        </div>
      </div>

      <div class="friend-hero-fade absolute inset-x-0 bottom-0 h-[22%]"></div>
    </section>

    <div class="friend-ripple" aria-hidden="true">
      <svg
        class="waves"
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 24 150 28"
        preserveAspectRatio="none"
        shape-rendering="auto"
      >
        <defs>
          <path id="friend-gentle-wave" d="M-160 44c30 0 58-18 88-18s58 18 88 18s58-18 88-18s58 18 88 18v44h-352z" />
        </defs>
        <g class="parallax">
          <use href="#friend-gentle-wave" x="48" y="0" />
          <use href="#friend-gentle-wave" x="48" y="3" />
          <use href="#friend-gentle-wave" x="48" y="5" />
          <use href="#friend-gentle-wave" x="48" y="7" />
        </g>
      </svg>
    </div>

    <!-- 主要内容区域 -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 pb-20">
      <!-- 分类标签页 -->
      <div class="friend-category-bar sticky top-0 z-30 -mx-4 mb-8 border-b px-4 py-3 backdrop-blur-md sm:-mx-6 sm:px-6 lg:-mx-8 lg:px-8">
        <div class="flex flex-wrap gap-2 justify-center">
          <button
            v-for="category in categories"
            :key="category.key"
            class="friend-category-button border px-4 py-2 rounded-lg font-medium transition-all duration-300"
            :class="[
              activeCategory === category.key
                ? 'friend-category-button-active shadow-lg'
                : 'friend-category-button-normal'
            ]"
            @click="activeCategory = category.key"
          >
            {{ category.label }}
            <span
              class="ml-2 px-2 py-0.5 text-xs rounded-full"
              :class="[
                activeCategory === category.key
                  ? 'friend-category-count-active'
                  : 'friend-category-count-normal'
              ]"
            >
              {{ getCategoryCount(category.key) }}
            </span>
          </button>
        </div>
      </div>

      <!-- 加载状态 -->
      <div v-if="loading" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        <div v-for="i in 8" :key="i" class="animate-pulse">
          <div class="friend-card-skeleton rounded-xl p-6 shadow-sm">
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

      <!-- 友链卡片分组 -->
      <div v-else-if="friendGroups.length > 0" class="space-y-10">
        <section v-for="group in friendGroups" :key="group.key" class="friend-group">
          <div class="mb-5 flex items-center justify-between gap-4">
            <div>
              <h2 class="theme-text-primary text-xl font-bold text-gray-900 dark:text-white">
                {{ group.title }}
              </h2>
              <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">共 {{ group.friends.length }} 个站点</p>
            </div>
            <div class="h-px flex-1 bg-gray-200 dark:bg-gray-700"></div>
          </div>

          <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            <div
              v-for="friend in group.friends"
              :key="friend.id"
              class="friend-card theme-text-primary relative rounded-xl p-6 shadow-sm transition-all duration-300 border"
              :class="[
                friend.status === 'active'
                  ? 'friend-card-active group cursor-pointer'
                  : friend.status === 'pending'
                    ? 'friend-card-pending'
                    : 'friend-card-inactive opacity-70'
              ]"
              @click="friend.status === 'active' ? visitFriend(friend.url) : null"
            >
              <span
                v-if="friend.status === 'active' && friend.isTop"
                class="absolute right-3 top-3 rounded-full bg-red-100 px-2 py-0.5 text-xs font-medium text-red-600 shadow-sm dark:bg-red-900/30 dark:text-red-400"
              >
                置顶
              </span>
              <div class="flex items-start space-x-4">
                <!-- 头像 -->
                <div class="flex-shrink-0">
                  <img
                    :src="friend.avatar || fallbackAvatar"
                    :alt="friend.name"
                    class="w-12 h-12 rounded-full object-cover ring-2 transition-all duration-300"
                    :class="[
                      friend.status === 'active'
                        ? 'ring-gray-200 dark:ring-gray-600 group-hover:ring-blue-300 dark:group-hover:ring-blue-600'
                        : 'ring-orange-200 dark:ring-orange-600 opacity-70'
                    ]"
                    @error="handleImageError"
                  />
                </div>

                <!-- 友链信息 -->
                <div class="flex-1 min-w-0">
                  <!-- 标题行 -->
                  <div class="mb-1">
                    <h3
                      class="theme-text-primary text-lg font-semibold transition-colors duration-300 truncate"
                      :class="[
                        friend.status === 'active'
                          ? 'text-gray-900 dark:text-white group-hover:text-blue-600 dark:group-hover:text-blue-400'
                          : friend.status === 'pending'
                            ? 'text-orange-700 dark:text-orange-400'
                            : 'text-gray-500 dark:text-gray-400'
                      ]"
                    >
                      {{ friend.name }}
                    </h3>
                  </div>

                  <!-- 状态标签行 -->
                  <div class="flex items-center gap-2 mb-2">
                    <!-- 分类标签 -->
                    <span
                      class="px-2 py-0.5 text-xs font-medium rounded-full flex-shrink-0"
                      :class="getCategoryStyle(friend.category)"
                    >
                      {{ getCategoryLabel(friend.category) }}
                    </span>

                    <!-- 待审核状态标识 -->
                    <span
                      v-if="friend.status === 'pending'"
                      class="px-2 py-0.5 text-xs font-medium bg-orange-100 text-orange-600 dark:bg-orange-900/30 dark:text-orange-400 rounded-full flex-shrink-0"
                    >
                      待审核
                    </span>
                    <span
                      v-else-if="friend.status === 'inactive'"
                      class="px-2 py-0.5 text-xs font-medium bg-gray-100 text-gray-500 dark:bg-gray-700 dark:text-gray-400 rounded-full flex-shrink-0"
                    >
                      已停用
                    </span>
                  </div>
                </div>
              </div>
              <!-- 描述信息 -->
              <div class="flex-1 min-w-0">
                <!-- 描述（启用状态显示） -->
                <p
                  v-if="friend.status === 'active'"
                  class="theme-text-primary text-sm text-gray-600 dark:text-gray-400 mt-2 line-clamp-2 leading-relaxed text-left"
                >
                  {{ friend.description }}
                </p>
                <!-- 链接（启用状态显示） -->
                <div
                  v-if="friend.status === 'active'"
                  class="flex items-center text-xs text-gray-500 dark:text-gray-500 mt-3 justify-start"
                >
                  <span
                    class="ml-[-2px] inline-flex items-center rounded-full px-2 py-0.5 text-xs font-medium flex-shrink-0"
                    :class="getCategoryStyle(friend.category)"
                    @click.stop="visitFriend(friend.url)"
                  >
                    <ExportOutlined class="mr-1 text-xs" />
                    访问{{ formatUrl(friend.url) }}
                  </span>
                </div>
              </div>
            </div>
          </div>
        </section>
      </div>

      <!-- 空状态 -->
      <div v-else class="text-center py-16">
        <div
          class="empty-state-card mx-auto w-24 h-24 rounded-full flex items-center justify-center mb-4"
        >
          <LinkOutlined class="text-3xl text-gray-400" />
        </div>
        <h3 class="theme-text-primary text-lg font-medium text-gray-900 dark:text-white mb-2">暂无友链</h3>
        <p class="theme-text-primary text-gray-600 dark:text-gray-400">还没有添加任何友情链接</p>
      </div>
    </main>
  </div>
  <!-- 本站友链信息弹框 -->
  <AModal
    v-model:open="siteInfoModalVisible"
    title="本站友链信息"
    :mask-closable="false"
    :footer="null"
    :body-style="{ maxHeight: '70vh', overflowY: 'auto', padding: '0' }"
    width="600px"
  >
    <div class="p-6">
      <div class="text-center mb-6">
        <img src="@/assets/system/svg/logo.svg" alt="Mint Blog" class="w-16 h-16 mx-auto mb-4 rounded-lg" />
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
            <AButton size="small" @click="copySingleInfo('网站名称', siteInfo.name)">
              <CopyOutlined />
            </AButton>
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
          <AButton size="small" @click="copySingleInfo('网站图标', siteInfo.icon)">
            <CopyOutlined />
          </AButton>
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
          <AButton size="small" @click="copySingleInfo('网站分类', siteInfo.category)">
            <CopyOutlined />
          </AButton>
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
          <AButton size="small" @click="copySingleInfo('网站网址', siteInfo.url)">
            <CopyOutlined />
          </AButton>
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
          <AButton size="small" class="ml-2" @click="copySingleInfo('网站描述', siteInfo.description)">
            <CopyOutlined />
          </AButton>
        </div>

        <!-- 复制全部按钮 -->
        <div class="pt-4 border-t border-gray-200 dark:border-gray-700">
          <AButton type="primary" block class="bg-blue-600 hover:bg-blue-700" @click="copyAllInfo">
            <CopyOutlined class="mr-2" />
            复制全部信息
          </AButton>
        </div>
      </div>
    </div>
  </AModal>
  <!-- 友链申请模态框 -->
  <AModal
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
        <form class="space-y-4" @submit.prevent="handleSubmitFriendApplication">
          <!-- 网站名称 -->
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              网站名称
              <span class="text-red-500">*</span>
            </label>
            <input
              v-model="applicationForm.name"
              type="text"
              required
              placeholder="请输入您的网站名称"
              class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:border-transparent bg-white dark:bg-gray-700 text-gray-900 dark:text-white transition-colors"
              :class="[
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
              网站图标链接
              <span class="text-red-500">*</span>
            </label>
            <div class="relative">
              <input
                v-model="applicationForm.avatar"
                type="url"
                required
                placeholder="请输入网站图标的URL地址"
                class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:border-transparent bg-white dark:bg-gray-700 text-gray-900 dark:text-white transition-colors"
                :class="[
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
              网站分类
              <span class="text-red-500">*</span>
            </label>
            <ASelect
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
              网站网址
              <span class="text-red-500">*</span>
            </label>
            <input
              v-model="applicationForm.url"
              type="url"
              required
              placeholder="请输入您的网站地址"
              class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:border-transparent bg-white dark:bg-gray-700 text-gray-900 dark:text-white transition-colors"
              :class="[
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
              网站描述
              <span class="text-red-500">*</span>
              <span class="text-xs text-gray-500 ml-1">({{ applicationForm.description.length }}/200)</span>
            </label>
            <textarea
              v-model="applicationForm.description"
              required
              rows="3"
              maxlength="200"
              placeholder="请简要描述您的网站内容和特色（至少10个字符）"
              class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:border-transparent bg-white dark:bg-gray-700 text-gray-900 dark:text-white resize-none transition-colors"
              :class="[
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
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">联系邮箱</label>
            <input
              v-model="applicationForm.email"
              type="email"
              placeholder="请输入您的联系邮箱（可选）"
              class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:border-transparent bg-white dark:bg-gray-700 text-gray-900 dark:text-white transition-colors"
              :class="[
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
        <AButton size="middle" @click="friendApplicationModalVisible = false">取消</AButton>
        <AButton
          type="primary"
          size="middle"
          :loading="submitting"
          class="bg-blue-600 hover:bg-blue-700"
          @click="handleSubmitFriendApplication"
        >
          <MailOutlined class="mr-1" />
          {{ submitting ? '提交中...' : '提交申请' }}
        </AButton>
      </div>
    </div>
  </AModal>
</template>

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
.friend-page {
  --friend-bg: rgb(var(--layout-bg-color));
  --friend-card-bg: rgb(var(--container-bg-color));
  --friend-card-soft-bg: rgb(var(--base-text-color) / 3.5%);
  --friend-card-hover-border: rgb(var(--primary-color) / 55%);
  --friend-border: rgb(var(--base-text-color) / 10%);
  --friend-border-strong: rgb(var(--base-text-color) / 16%);
  --friend-text: rgb(var(--base-text-color));
  --friend-text-muted: rgb(var(--base-text-color) / 66%);
  --friend-primary-soft: rgb(var(--primary-color) / 10%);
  --friend-primary-strong: rgb(var(--primary-color));
  --friend-pending-bg: rgb(245 158 11 / 10%);
  --friend-pending-border: rgb(245 158 11 / 26%);
  --friend-inactive-bg: rgb(var(--base-text-color) / 4.5%);

  background: var(--friend-bg);
}

.friend-category-bar {
  border-color: var(--friend-border);
  background: color-mix(in srgb, var(--friend-bg) 88%, transparent);
}

.friend-category-button {
  border-color: var(--friend-border-strong);
  color: var(--friend-text);
}

.friend-category-button-active {
  border-color: var(--friend-primary-strong);
  background: var(--friend-primary-strong);
  color: #fff;
}

.friend-category-button-normal {
  background: var(--friend-card-bg);
}

.friend-category-button-normal:hover {
  border-color: var(--friend-card-hover-border);
  background: var(--friend-primary-soft);
}

.friend-category-count-active {
  background: rgb(255 255 255 / 18%);
  color: #fff;
}

.friend-category-count-normal {
  background: rgb(var(--base-text-color) / 7%);
  color: var(--friend-text-muted);
}

.friend-card,
.friend-card-skeleton,
.empty-state-card {
  border-color: var(--friend-border);
  background: var(--friend-card-bg);
}

.friend-card-active:hover {
  border-color: var(--friend-card-hover-border);
  box-shadow: 0 16px 40px rgb(var(--primary-color) / 12%);
}

.friend-card-pending {
  border-color: var(--friend-pending-border);
  background: var(--friend-pending-bg);
}

.friend-card-inactive {
  border-color: var(--friend-border);
  background: var(--friend-inactive-bg);
}

.friend-card {
  &:hover {
    transform: translateY(-2px);
  }
}

.friend-hero-content {
  transform: translateY(-18px);
}

.friend-stars {
  z-index: 1;
  pointer-events: none;
}

.hero-meta-icon {
  display: inline-flex;
  width: 20px;
  height: 20px;
  align-items: center;
  justify-content: center;
  margin-right: 6px;
  border-radius: 999px;
  color: #fff;
  font-size: 12px;
  box-shadow: 0 6px 16px rgb(0 0 0 / 24%);
}

.friend-ripple {
  position: relative;
  z-index: 5;
  height: 1px;
}

.friend-ripple .waves {
  position: relative;
  z-index: 2;
  width: 100%;
  height: 15%;
  min-height: 80px;
  max-height: 150px;
  margin-bottom: -7px;
  transform: translateY(-100%);
}

.friend-ripple .parallax > use {
  animation: friend-wave-move 25s cubic-bezier(0.55, 0.5, 0.45, 0.5) infinite;
}

.friend-ripple .parallax > use:nth-child(1) {
  fill: rgb(247 251 248 / 70%);
  animation-delay: -2s;
  animation-duration: 7s;
}

.friend-ripple .parallax > use:nth-child(2) {
  fill: rgb(247 251 248 / 50%);
  animation-delay: -3s;
  animation-duration: 10s;
}

.friend-ripple .parallax > use:nth-child(3) {
  fill: rgb(247 251 248 / 30%);
  animation-delay: -4s;
  animation-duration: 13s;
}

.friend-ripple .parallax > use:nth-child(4) {
  fill: #f7fbf8;
  animation-delay: -5s;
  animation-duration: 20s;
}

.dark .friend-ripple .parallax > use,
html.dark .friend-ripple .parallax > use {
  fill: rgb(35 41 49 / 90%);
}

@keyframes friend-wave-move {
  0% {
    transform: translate3d(-90px, 0, 0);
  }

  100% {
    transform: translate3d(85px, 0, 0);
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
  .friend-hero-content {
    transform: translateY(0);
  }

  .friend-ripple .waves {
    height: 40px;
    min-height: 40px;
  }

  .friend-card {
    &:hover {
      transform: none;
    }
  }
}
</style>
