<template>
  <div class="blog-settings p-6 h-full flex flex-col">
    <!-- 页面标题 -->
    <a-card :bordered="false" class="mb-15 search-card flex-shrink-0">
      <!-- flex 布局，内容垂直居中 -->
      <div class="flex justify-between items-center search-form">
        <div class="flex-shrink-0">
          <h1 class="text-3xl font-bold text-gray-900 dark:text-white mb-2">博客设置</h1>
          <p class="text-gray-600 dark:text-gray-400">管理您的博客基础信息和功能配置</p>
        </div>
        
        <!-- 保存按钮 -->
        <div class="flex-shrink-0">
          <a-button type="primary" :loading="btnLoading" @click="onSubmit" class="save-blog-btn" >
            <template v-if="!btnLoading">
              保存设置
            </template>
          </a-button>
        </div>
      </div>
    </a-card>
    
    <!-- 卡片组件 -->
    <a-card :bordered="false" class="flex-1 flex flex-col overflow-hidden shadow-xl rounded-2xl border-0 backdrop-blur-sm bg-white/80 dark:bg-gray-800/80">
      <div class="flex-1 overflow-y-auto">
        <a-form class="max-w-4xl mx-auto" 
        ref="formRef" 
        :model="form" 
        :label-col="{ span: 4 }" 
        :wrapper-col="{ span: 16 }" 
        :rules="rules"
      >
        <a-form-item>
          <div class="flex items-center mb-6">
            <div class="w-1 h-8 bg-gradient-to-b from-blue-500 to-purple-600 rounded-full mr-4"></div>
            <h2 class="text-xl font-bold text-gray-800 dark:text-white">基础设置</h2>
          </div>
        </a-form-item>
        <a-form-item label="博客名称" name="name">
          <a-input v-model:value="form.name" allow-clear />
        </a-form-item>
        <a-form-item label="作者名" name="author">
          <a-input v-model:value="form.author" allow-clear />
        </a-form-item>
        <a-form-item label="博客 LOGO" name="logo">
          <div class="upload-container">
            <a-upload
              class="logo-uploader"
              action=""
              :before-upload="handleLogoChange"
              :show-upload-list="false"
            >
              <div class="upload-area logo-area">
                <img v-if="form.logo" :src="form.logo" class="uploaded-image logo-image" alt="null" />
                <div v-else class="upload-placeholder">
                  <PlusOutlined class="upload-icon" />
                  <div class="upload-text">上传 LOGO</div>
                  <div class="upload-hint">建议尺寸: 200x200px</div>
                </div>
              </div>
            </a-upload>
          </div>
        </a-form-item>
        <a-form-item label="作者头像" name="avatar">
          <div class="upload-container">
            <a-upload
              class="avatar-uploader"
              action=""
              :before-upload="handleAvatarChange"
              :show-upload-list="false"
            >
              <div class="upload-area avatar-area">
                <img v-if="form.avatar" :src="form.avatar" class="uploaded-image avatar-image" alt="null" />
                <div v-else class="upload-placeholder">
                  <PlusOutlined class="upload-icon" />
                  <div class="upload-text">上传头像</div>
                  <div class="upload-hint">建议尺寸: 200x200px</div>
                </div>
              </div>
            </a-upload>
          </div>
        </a-form-item>
        <a-form-item label="介绍语" name="introduction">
          <a-textarea v-model:value="form.introduction" />
        </a-form-item>

        <a-form-item label="版权声明" name="copyrightDeclaration">
          <a-textarea
            v-model:value="form.copyrightDeclaration"
            :rows="3"
            :maxlength="300"
            show-count
            placeholder="请输入版权声明内容，例如：保留所有权利。未经许可不得转载。"
          />
        </a-form-item>

        <!-- 自动切换主题 -->
        <a-form-item label="自动切换主题" name="isAutoTheme">
          <a-switch
            v-model:checked="form.isAutoTheme"
            checked-children="开启"
            un-checked-children="关闭"
          />
          <div class="flex items-center ml-3">
            <InfoCircleOutlined class="mr-2" style="color: #909399" />
            <a-typography-text type="secondary" class="mx-1"
              >开启后将根据系统时间自动切换白天/黑夜主题</a-typography-text
            >
          </div>
        </a-form-item>

        <!-- 分割线 -->
        <a-divider class="my-8" />

        <a-form-item>
          <div class="flex items-center mb-6">
            <div class="w-1 h-8 bg-gradient-to-b from-green-500 to-teal-600 rounded-full mr-4"></div>
            <h2 class="text-xl font-bold text-gray-800 dark:text-white">第三方平台设置</h2>
          </div>
        </a-form-item>
        <!-- 开启 Github 访问 -->
        <a-form-item label="开启 GihHub 访问">
          <a-switch
            v-model:checked="isGithubChecked"
            @change="githubSwitchChange"
          />
        </a-form-item>
        <a-form-item label="GitHub 主页访问地址" v-if="isGithubChecked">
          <a-input
            v-model:value="form.githubHomepage"
            allow-clear
            placeholder="请输入 GitHub 主页访问的 URL"
          />
        </a-form-item>

        <!-- 开启 Gitee 访问 -->
        <a-form-item label="开启 Gitee 访问">
          <a-switch
            v-model:checked="isGiteeChecked"
            @change="giteeSwitchChange"
          />
        </a-form-item>
        <a-form-item label="Gitee 主页访问地址" v-if="isGiteeChecked">
          <a-input
            v-model:value="form.giteeHomepage"
            allow-clear
            placeholder="请输入 Gitee 主页访问的 URL"
          />
        </a-form-item>

        <!-- 开启知乎访问 -->
        <a-form-item label="开启知乎访问">
          <a-switch
            v-model:checked="isZhihuChecked"
            @change="zhihuSwitchChange"
          />
        </a-form-item>
        <a-form-item label="知乎主页访问地址" v-if="isZhihuChecked">
          <a-input
            v-model:value="form.zhihuHomepage"
            allow-clear
            placeholder="请输入知乎主页访问的 URL"
          />
        </a-form-item>

        <!-- 开启 CSDN 访问 -->
        <a-form-item label="开启 CSDN 访问">
          <a-switch
            v-model:checked="isCSDNChecked"
            @change="csdnSwitchChange"
          />
        </a-form-item>
        <a-form-item label="CSDN 主页访问地址" v-if="isCSDNChecked">
          <a-input
            v-model:value="form.csdnHomepage"
            allow-clear
            placeholder="请输入 CSDN 主页访问的 URL"
          />
        </a-form-item>

        <!-- 分割线 -->
        <a-divider class="my-8" />

        <a-form-item>
          <div class="flex items-center mb-6">
            <div class="w-1 h-8 bg-gradient-to-b from-orange-500 to-red-600 rounded-full mr-4"></div>
            <h2 class="text-xl font-bold text-gray-800 dark:text-white">评论设置</h2>
          </div>
        </a-form-item>
        <a-form-item label="敏感词过滤">
          <a-switch
            v-model:checked="form.isCommentSensiWordOpen"
            @change="sensiWordSwitchChange"
          />
          <div class="flex items-center ml-3">
            <InfoCircleOutlined class="mr-2" style="color: #909399" />
            <a-typography-text type="secondary" class="mx-1"
              >开启后，系统自动对发表的每条评论进行敏感词过滤</a-typography-text
            >
          </div>
        </a-form-item>
        <a-form-item label="开启审核">
          <a-switch
            v-model:checked="form.isCommentExamineOpen"
            @change="examineSwitchChange"
          />
          <div class="flex items-center ml-3">
            <InfoCircleOutlined class="mr-2" style="color: #909399" />
            <a-typography-text type="secondary" class="mx-1"
              >开启后，评论需要博主后台审核通过后，才会展示出来</a-typography-text
            >
          </div>
        </a-form-item>
        <a-form-item label="博主邮箱">
          <a-input
            v-model:value="form.mail"
            allow-clear
            placeholder="请输入博主邮箱地址"
          />
          <div class="flex items-center ml-3">
            <InfoCircleOutlined class="mr-2" style="color: #909399" />
            <a-typography-text type="secondary" class="mx-1"
              >当被评论后，用于主动发送邮件通知博主</a-typography-text
            >
          </div>
        </a-form-item>


      </a-form>
      </div>
    </a-card>
  </div>
</template>

<script setup lang="ts">
import { reactive, ref } from "vue";
import { PlusOutlined, InfoCircleOutlined } from "@ant-design/icons-vue";
import {
  getBlogSettingsDetail,
  updateBlogSettings,
} from "@/api/admin/blogsettings.ts";
import { uploadImage } from "@/api/admin/image.ts";
import { showMessage } from "@/composables/util.ts";
import type { FormInstance } from "ant-design-vue";

// 接口定义
interface BlogSettingsForm {
  name: string;
  author: string;
  logo: string;
  avatar: string;
  introduction: string;
  // 版权声明
  copyrightDeclaration: string;
  // 自动切换主题
  isAutoTheme: boolean;
  githubHomepage: string;
  giteeHomepage: string;
  zhihuHomepage: string;
  csdnHomepage: string;
  isCommentSensiWordOpen: boolean;
  isCommentExamineOpen: boolean;
  mail: string;
}

// 是否开启 GitHub
const isGithubChecked = ref<boolean>(false);
// 是否开启 Gitee
const isGiteeChecked = ref<boolean>(false);
// 是否开启知乎
const isZhihuChecked = ref<boolean>(false);
// 是否开启 CSDN
const isCSDNChecked = ref<boolean>(false);
// 是否显示保存按钮的 loading 状态，默认为 false
const btnLoading = ref<boolean>(false);

// 待上传的 Logo 文件
const pendingLogoImage = ref<File | null>(null);
// 待上传的头像文件
const pendingAvatarImage = ref<File | null>(null);
// 保存原始的 logo 和 avatar URL，用于获取原始文件名
const originalLogoUrl = ref<string>("");
const originalAvatarUrl = ref<string>("");

// 表单引用
const formRef = ref<FormInstance | null>(null);
// 表单对象
const form = reactive<BlogSettingsForm>({
  name: "",
  author: "",
  logo: "",
  avatar: "",
  introduction: "",
  copyrightDeclaration: "",
  isAutoTheme: false, // 是否自动切换主题
  githubHomepage: "",
  giteeHomepage: "",
  zhihuHomepage: "",
  csdnHomepage: "",
  isCommentSensiWordOpen: true, // 是否开启评论敏感词过滤
  isCommentExamineOpen: false, // 是否开启评论审核
  mail: "", // 博主邮箱
});

// 规则校验
const rules = {
  name: [{ required: true, message: "请输入博客名称", trigger: "blur" }],
  author: [{ required: true, message: "请输入作者名", trigger: "blur" }],
  logo: [{ required: true, message: "请上传博客 LOGO", trigger: "blur" }],
  avatar: [{ required: true, message: "请上传作者头像", trigger: "blur" }],
  introduction: [{ required: true, message: "请输入介绍语", trigger: "blur" }],
};

// 监听 Github Switch 改变事件
const githubSwitchChange = (checked: boolean): void => {
  if (checked === false) {
    form.githubHomepage = "";
  }
};

// 监听 Gitee Switch 改变事件
const giteeSwitchChange = (checked: boolean): void => {
  if (checked === false) {
    form.giteeHomepage = "";
  }
};

// 监听知乎 Switch 改变事件
const zhihuSwitchChange = (checked: boolean): void => {
  if (checked === false) {
    form.zhihuHomepage = "";
  }
};

// 监听 CSDN Switch 改变事件
const csdnSwitchChange = (checked: boolean): void => {
  if (checked === false) {
    form.csdnHomepage = "";
  }
};

// 初始化博客设置数据，并渲染到页面上
function initBlogSettings(): void {
  getBlogSettingsDetail().then((e: any) => {
    if (e.success) {
      // 设置表单数据
      form.name = e.data.name;
      form.author = e.data.author;
      form.logo = e.data.logo;
      form.avatar = e.data.avatar;
      form.introduction = e.data.introduction;
      // 版权声明
      form.copyrightDeclaration = e.data?.copyrightDeclaration ?? "";
      // 自动切换主题
      form.isAutoTheme = e.data?.isAutoTheme ?? false;
      
      // 保存原始 URL
      originalLogoUrl.value = e.data.logo;
      originalAvatarUrl.value = e.data.avatar;

      // 第三方平台信息设置
      if (e.data.githubHomepage) {
        isGithubChecked.value = true;
        form.githubHomepage = e.data.githubHomepage;
      }

      if (e.data.giteeHomepage) {
        isGiteeChecked.value = true;
        form.giteeHomepage = e.data.giteeHomepage;
      }

      if (e.data.zhihuHomepage) {
        isZhihuChecked.value = true;
        form.zhihuHomepage = e.data.zhihuHomepage;
      }

      if (e.data.csdnHomepage) {
        isCSDNChecked.value = true;
        form.csdnHomepage = e.data.csdnHomepage;
      }

      form.isCommentSensiWordOpen = e.data.isCommentSensiWordOpen;
      form.isCommentExamineOpen = e.data.isCommentExamineOpen;
      form.mail = e.data.mail;
    }
  });
}
initBlogSettings();

// 上传 logo 图片
const handleLogoChange = (file: File): boolean => {
  // 暂存文件，不立即上传
  pendingLogoImage.value = file;
  // 预览图片
  const reader = new FileReader();
  reader.onload = (e: ProgressEvent<FileReader>) => {
    if (e.target?.result) {
      form.logo = e.target.result as string; // 显示预览
    }
  };
  reader.readAsDataURL(file);
  return false; // 阻止自动上传
};

// 上传作者头像
const handleAvatarChange = (file: File): boolean => {
  // 暂存文件，不立即上传
  pendingAvatarImage.value = file;
  // 预览图片
  const reader = new FileReader();
  reader.onload = (e: ProgressEvent<FileReader>) => {
    if (e.target?.result) {
      form.avatar = e.target.result as string; // 显示预览
    }
  };
  reader.readAsDataURL(file);
  return false; // 阻止自动上传
};

// 从原始 logo URL 中提取原始文件名
const getOriginalImageName = (url: string): string => {
  if (!url) return "";
  const urlParts = url.split("/");
  return urlParts[urlParts.length - 1] || ""; // 获取 URL 最后一部分作为文件名，如果为 undefined 则返回空字符串
};

// 保存当前博客设置
const onSubmit = async (): Promise<void> => {
  if (!formRef.value) return;
  
  try {
    await formRef.value.validate();
    btnLoading.value = true;
    
    // 如果有待上传的 Logo 文件，先上传
    if (pendingLogoImage.value) {
      const oldImageName = getOriginalImageName(originalLogoUrl.value);
      const newImageOriginalName = `logo_${Date.now()}_${pendingLogoImage.value.name}`;
      const uploadRes = await uploadImage(
        pendingLogoImage.value,
        newImageOriginalName,
        oldImageName,
      );
      if (!uploadRes.success) {
        showMessage(uploadRes.message, "error");
        return;
      }
      form.logo = uploadRes.data.url;
      pendingLogoImage.value = null;
    }
    
    // 如果有待上传的头像文件，先上传
    if (pendingAvatarImage.value) {
      const oldImageName = getOriginalImageName(originalAvatarUrl.value);
      const newImageOriginalName = `avatar_${Date.now()}_${
        pendingAvatarImage.value.name
      }`;
      const uploadRes = await uploadImage(
        pendingAvatarImage.value,
        newImageOriginalName,
        oldImageName,
      );
      if (!uploadRes.success) {
        showMessage(uploadRes.message, "error");
        return;
      }
      form.avatar = uploadRes.data.url;
      pendingAvatarImage.value = null;
    }
    
    // 保存博客设置
    const res = await updateBlogSettings(form);
    if (!res.success) {
      showMessage(res.message, "error");
      return;
    }
    initBlogSettings();
    showMessage("保存成功");
  } catch (error) {
    console.error('Validation failed:', error);
  } finally {
    btnLoading.value = false;
  }
};

// 评论敏感词过滤 switch 组件 change 事件
const sensiWordSwitchChange = (checked: boolean): void => {
  form.isCommentSensiWordOpen = checked;
};

// 评论审核 switch 组件 change 事件
const examineSwitchChange = (checked: boolean): void => {
  form.isCommentExamineOpen = checked;
};
</script>

<style lang="scss" scoped>

.search-card {
    margin-bottom: 20px;
    .search-form {
      display: flex;
      align-items: center;
      gap: 16px;
      flex-wrap: wrap;

      .search-item {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 0;
        
        span {
          white-space: nowrap;
          font-weight: 500;
        }
      }
    }
  }
.blog-settings {
  height: calc(100vh - 165px); // 减去header和taglist的高度
  background: linear-gradient(135deg, #f8fafc 0%, #e0f2fe 100%);
  
  @media (prefers-color-scheme: dark) {
    background: linear-gradient(135deg, #1f2937 0%, #111827 100%);
  }
  
  :deep(.ant-card-body) {
    height: 100%;
    display: flex;
    flex-direction: column;
    padding: 24px;
    .ant-form{
      width: 100% !important;
    }
  }
}

// 上传容器样式
.upload-container {
  display: flex;
  align-items: center;
  gap: 16px;
}

// 上传区域基础样式
.upload-area {
  position: relative;
  border: 2px dashed #e5e7eb;
  border-radius: 16px;
  cursor: pointer;
  overflow: hidden;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
  
  &:hover {
    border-color: #3b82f6;
    background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
    transform: translateY(-2px);
    box-shadow: 0 10px 25px -5px rgba(59, 130, 246, 0.1), 0 4px 6px -2px rgba(59, 130, 246, 0.05);
  }
}

// LOGO 上传区域
.logo-area {
  width: 120px;
  height: 120px;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  overflow: hidden;
}

// 头像上传区域
.avatar-area {
  width: 120px;
  height: 120px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  position: relative;
  overflow: hidden;
}

// 上传的图片样式
.uploaded-image {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  transition: transform 0.3s ease;
  
  &:hover {
    transform: translate(-50%, -50%) scale(1.05);
  }
}

.logo-image {
  border-radius: 12px;
  max-width: 90%;
  max-height: 90%;
  width: auto;
  height: auto;
  object-fit: contain;
}

.avatar-image {
  border-radius: 50%;
  max-width: 90%;
  max-height: 90%;
  width: auto;
  height: auto;
  object-fit: contain;
}

// 上传占位符样式
.upload-placeholder {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 16px;
}

.upload-icon {
  font-size: 32px;
  color: #9ca3af;
  margin-bottom: 8px;
  transition: color 0.3s ease;
}

.upload-text {
  font-size: 14px;
  font-weight: 600;
  color: #374151;
  margin-bottom: 4px;
}

.upload-hint {
  font-size: 12px;
  color: #9ca3af;
}

.save-blog-btn {
  background: linear-gradient(135deg, #667eea 0%, #3bb4e4 100%) !important;
  border: none !important;
  box-shadow: 0 4px 15px 0 rgba(102, 126, 234, 0.3) !important;
  font-weight: 500 !important;
  padding: 8px 15px !important;
  height: auto !important;
  border-radius: 8px !important;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
  &:hover {
      transform: translateY(-2px) !important;
      box-shadow: 0 8px 25px 0 rgba(102, 126, 234, 0.4) !important;
      background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%) !important;
  }
  &:active {
      transform: translateY(0) !important;
      box-shadow: 0 4px 15px 0 rgba(102, 126, 234, 0.3) !important;
  }
  &:focus {
      box-shadow: 0 4px 15px 0 rgba(102, 126, 234, 0.3), 0 0 0 3px rgba(102, 126, 234, 0.1) !important;
  }
  // 移除按钮hover过渡效果，使变化立即生效
  .add-wiki-btn {
      transition: none !important;
  }
  .add-wiki-btn:hover {
      transition: none !important;
  }
      
}

// 深色模式适配
@media (prefers-color-scheme: dark) {
  .upload-area {
    background: linear-gradient(135deg, #1f2937 0%, #111827 100%);
    border-color: #374151;
    
    &:hover {
      border-color: #60a5fa;
      background: linear-gradient(135deg, #1e3a8a 0%, #1e40af 100%);
    }
  }
  
  .upload-icon {
    color: #6b7280;
  }
  
  .upload-text {
    color: #d1d5db;
  }
  
  .upload-hint {
    color: #6b7280;
  }
}

// 响应式设计
@media (max-width: 768px) {
  .upload-area {
    width: 100px;
    height: 100px;
  }
  
  .logo-area,
  .avatar-area {
    width: 100px;
    height: 100px;
  }
  
  .upload-icon {
    font-size: 24px;
  }
  
  .upload-text {
    font-size: 12px;
  }
  
  .upload-hint {
    font-size: 10px;
  }
}
</style>

<style lang="scss">
// 全局样式覆盖
.logo-uploader,
.avatar-uploader {
  .ant-upload {
    border: none !important;
    background: transparent !important;
    padding: 0 !important;
    
    &:hover {
      background: transparent !important;
    }
  }
}

// 表单项间距优化
.ant-form-item {
  margin-bottom: 24px;
  
  .ant-form-item-label {
    font-weight: 600;
    color: #374151;
    
    @media (prefers-color-scheme: dark) {
      color: #d1d5db;
    }
  }
}

// 输入框样式优化
.ant-input,
.ant-input-affix-wrapper {
  border-radius: 8px;
  border-color: #e5e7eb;
  transition: all 0.3s ease;
  
  &:hover {
    border-color: #3b82f6;
  }
  
  &:focus,
  &.ant-input-affix-wrapper-focused {
    border-color: #3b82f6;
    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
  }
}

// 文本域样式
.ant-input {
  &[type="textarea"] {
    min-height: 80px;
    resize: vertical;
  }
}

// 开关组件样式
.ant-switch {
  &.ant-switch-checked {
    background-color: #3b82f6;
  }
}

// 信息提示样式
.ant-typography {
  font-size: 14px;
}
</style>