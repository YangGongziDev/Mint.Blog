<template>
  <div class="article-create p-6 h-full flex flex-col">
    <!-- 页面标题 -->
    <a-card :bordered="false" class="mb-5">
      <div class="flex justify-between items-center">
        <h2 class="text-xl font-bold">写文章</h2>
        <div class="flex gap-3">
          <a-button @click="goBack" :disabled="isPublishing">取消</a-button>
          <a-button type="primary" @click="publishArticleSubmit" :loading="isPublishing">
            <template #icon v-if="!isPublishing">
              <SaveOutlined />
            </template>
            {{ publishButtonText }}
          </a-button>
        </div>
        <!-- 上传进度提示 -->
        <div v-if="uploadProgress.show" class="mt-3">
          <a-progress 
            :percent="uploadProgress.percent" 
            :status="uploadProgress.status"
            :show-info="true"
          >
            <template #format="percent">
              {{ uploadProgress.text }} {{ percent }}%
            </template>
          </a-progress>
        </div>
      </div>
    </a-card>
    <!-- 文章表单 -->
    <a-card :bordered="false" class="table-card flex-1 overflow-hidden">
      <div class="form-wrapper">
        <a-form class="article-form" 
          :model="form"
          ref="publishArticleFormRef"
          layout="vertical"
          size="large"
          :rules="rules"
        >
        <a-form-item label="标题" name="title">
          <a-input
            v-model:value="form.title"
            autocomplete="off"
            size="large"
            :maxlength="50"
            show-count
            allow-clear
          />
        </a-form-item>
        <a-form-item label="内容" name="content">
          <!-- Markdown 编辑器 -->
          <MdEditor
            v-model="form.content"
            @onUploadImg="onUploadImg"
            editorId="publishArticleEditor"
          />
        </a-form-item>
        <a-form-item label="封面" name="cover">
          <div class="flex gap-4 items-start">
            <a-upload
              class="logo-uploader"
              action=""
              :before-upload="handleCoverChange"
              :show-upload-list="false"
            >
              <div class="upload-area logo-area">
                <img v-if="coverPreviewUrl" :src="coverPreviewUrl" class="uploaded-image logo-image" />
                <div v-else class="upload-placeholder">
                  <PlusOutlined class="upload-icon" />
                  <div class="upload-text">上传封面</div>
                  <div class="upload-hint">支持 JPG、PNG 格式</div>
                </div>
              </div>
            </a-upload>
            
            <a-button type="default" @click="showImageSelector">
              <template #icon><PictureOutlined /></template>
              从正文选择
            </a-button>
          </div>
        </a-form-item>

        <!-- 图片选择弹窗 -->
        <a-modal
          v-model:open="imageSelectorVisible"
          title="从正文选择图片"
          @ok="handleImageSelectConfirm"
          width="600px"
        >
          <div v-if="contentImages.length === 0" class="text-center py-8 text-gray-400">
            正文中暂无图片
          </div>
          <div v-else class="grid grid-cols-3 gap-4">
            <div 
              v-for="(img, index) in contentImages" 
              :key="index"
              class="cursor-pointer border-2 rounded-lg overflow-hidden relative aspect-video group"
              :class="selectedImageIndex === index ? 'border-primary' : 'border-transparent hover:border-gray-300'"
              @click="selectedImageIndex = index"
            >
              <img :src="img" class="w-full h-full object-cover" />
              <div 
                v-if="selectedImageIndex === index" 
                class="absolute inset-0 bg-primary/20 flex items-center justify-center"
              >
                <CheckCircleOutlined class="text-2xl text-primary" />
              </div>
            </div>
          </div>
        </a-modal>
        <a-form-item label="摘要" name="summary">
          <a-textarea
            v-model:value="form.summary"
            :rows="3"
            placeholder="请输入文章摘要"
          />
        </a-form-item>
        <a-form-item label="分类" name="categoryId">
          <div class="w-60">
            <!-- 分类选择 -->
            <a-select
              v-model:value="form.categoryId"
              :filter-option="false"
              placeholder="请输入文章分类"
              :search-value="categorySearchValue"
              @search="remoteCategoryMethod"
              @focus="handleCategoryFocus"
              :loading="categorySelectLoading"
              size="large"
              allow-clear
              show-search
            > 
              <a-select-option
                v-for="item in categories"
                :key="item.value"
                :value="item.value"
              >
                {{ item.label }}
              </a-select-option>
            </a-select>
          </div>
        </a-form-item>
        <a-form-item label="标签" name="tags">
          <div class="w-60">
            <!-- 标签选择 -->
            <a-select
              v-model:value="form.tags"
              mode="multiple"
              :filter-option="false"
              placeholder="请输入文章标签"
              :search-value="searchValue"
              @search="remoteMethod"
              @focus="handleTagFocus"
              :loading="tagSelectLoading"
              size="large"
              allow-clear
              show-search
            >
              <a-select-option
                v-for="item in tags"
                :key="item.value"
                :value="item.value"
              >
                {{ item.label }}
              </a-select-option>
            </a-select>
          </div>
        </a-form-item>
        </a-form>
      </div>
    </a-card>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, computed, onMounted, onActivated } from "vue";
import { SaveOutlined, PlusOutlined, PictureOutlined, CheckCircleOutlined } from "@ant-design/icons-vue";
import { publishArticle } from "@/api/admin/article";
import { uploadImage } from "@/api/admin/image.ts";
import { getCategorySelectList, searchCategories } from "@/api/admin/category";
import { searchTags, getTagSelectList } from "@/api/admin/tag";
import { showMessage, extractImagesFromMarkdown } from "@/composables/util.ts";
import { MdEditor } from "md-editor-v3";
import "md-editor-v3/lib/style.css";
import { useRouter } from "vue-router";
import type { FormInstance, UploadFile } from "ant-design-vue";

const router = useRouter();

// 发布文章表单引用
const publishArticleFormRef = ref<FormInstance>();
// 待上传的头像文件
const pendingCoverImage = ref<File | null>(null);
// 封面预览 URL
const coverPreviewUrl = ref<string>('');

// 图片选择器相关
const imageSelectorVisible = ref(false);
const contentImages = ref<string[]>([]);
const selectedImageIndex = ref<number>(-1);

// 显示图片选择器
const showImageSelector = () => {
  contentImages.value = extractImagesFromMarkdown(form.content);
  if (contentImages.value.length === 0) {
    showMessage('正文中暂无图片', 'warning');
    return;
  }
  selectedImageIndex.value = -1;
  imageSelectorVisible.value = true;
};

// 确认选择图片
const handleImageSelectConfirm = () => {
  if (selectedImageIndex.value > -1 && contentImages.value[selectedImageIndex.value]) {
    const selectedUrl = contentImages.value[selectedImageIndex.value];
    coverPreviewUrl.value = selectedUrl;
    // 如果选择了正文图片，清除可能存在的待上传文件
    pendingCoverImage.value = null;
    form.cover = selectedUrl;
    imageSelectorVisible.value = false;
    showMessage('已选择封面图', 'success');
  } else {
    showMessage('请选择一张图片', 'warning');
  }
};
// 待上传的内容图片文件列表
interface PendingImage {
  id: string;
  file: File;
  previewUrl: string;
  finalUrl: string | null;
}
const pendingContentImages = ref<PendingImage[]>([]);
// 搜索值
const searchValue = ref<string>('');
// 分类搜索值
const categorySearchValue = ref<string>('');
// 分类选择加载状态
const categorySelectLoading = ref<boolean>(false);
// 发布状态管理
const isPublishing = ref<boolean>(false);
// 上传进度管理
const uploadProgress = reactive({
  show: false,
  percent: 0,
  status: 'active' as 'active' | 'success' | 'exception',
  text: '准备上传'
});
// 发布按钮文本
const publishButtonText = computed(() => {
  if (isPublishing.value) {
    return uploadProgress.text;
  }
  return '发布';
});

// 表单对象
interface PublishArticleForm {
  id: number | null;
  title: string;
  content: string;
  cover: string;
  categoryId: number | null;
  tags: number[];
  summary: string;
}

const form = reactive<PublishArticleForm>({
  id: null,
  title: "",
  content: "",
  cover: "",
  categoryId: null,
  tags: [],
  summary: "",
});

// 表单校验规则
const rules = {
  title: [
    { required: true, message: "请输入文章标题", trigger: "blur" },
    {
      min: 1,
      max: 50,
      message: "文章标题要求大于1个字符，小于50个字符",
      trigger: "blur",
    },
  ],
  content: [{ required: true, message: "请输入文章内容", trigger: "change" }],
  cover: [{ required: true, message: "请上传文章封面", trigger: "change" }],
  categoryId: [{ required: true, message: "请选择文章分类", trigger: "change" }],
  tags: [{ required: true, message: "请选择文章标签", trigger: "change" }],
};

// 上传文章封面图片
const handleCoverChange = (file: UploadFile): boolean => {
  // 暂存文件，不立即上传
  pendingCoverImage.value = file as unknown as File;
  // 设置封面字段为文件名，用于通过表单验证
  form.cover = file.name || 'cover-uploaded';
  
  // 预览图片
  const reader = new FileReader();
  reader.onload = (e: ProgressEvent<FileReader>) => {
    if (e.target?.result) {
      // 设置预览 URL
      coverPreviewUrl.value = e.target.result as string;
      console.log('封面图片预览已生成');
    }
  };
  reader.readAsDataURL(file as unknown as File);
  
  // 手动触发表单验证
  publishArticleFormRef.value?.validateFields(['cover']);
  
  // 返回 false 阻止自动上传
  return false;
};

// 编辑器图片上传（延迟上传，先预览）
const onUploadImg = async (files: File[], callback: (urls: string[]) => void): Promise<void> => {
  const previewUrls: string[] = [];
  
  files.forEach((file: File) => {
    // 生成唯一的文件ID
    const fileId = `temp_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
    
    // 创建预览URL
    const previewUrl = URL.createObjectURL(file);
    previewUrls.push(previewUrl);
    
    // 存储文件信息，包含文件对象和预览URL的映射
    pendingContentImages.value.push({
      id: fileId,
      file: file,
      previewUrl: previewUrl,
      finalUrl: null // 最终上传后的URL
    });
    
    console.log("==> 图片已添加到待上传列表，预览URL：" + previewUrl);
  });
  
  // 调用 callback 函数，返回预览URL供编辑器显示
  callback(previewUrls);
};

// 分类选项接口
interface CategoryOption {
  value: number;
  label: string;
  sort?: number;
}

// 标签选项接口
interface TagOption {
  value: number;
  label: string;
}

// 文章分类
const categories = ref<CategoryOption[]>([]);

// 标签 select Loading 状态，默认不显示
const tagSelectLoading = ref<boolean>(false);
// 文章标签
const tags = ref<TagOption[]>([]);

// 根据用户输入的标签名称，远程模糊查询
const remoteMethod = (query: string): void => {
  console.log("远程搜索：" + query);
  searchValue.value = query;
  // 显示 loading
  tagSelectLoading.value = true;
  
  // 如果用户的查询关键词不为空，调用搜索接口
  if (query) {
    // 调用标签模糊查询接口
    searchTags(query)
      .then((e: any) => {
        if (e.success) {
          // 设置到 tags 变量中，并按 sort 字段降序排序
          tags.value = e.data.sort((a: any, b: any) => {
            // 按 sort 字段降序排序（值越大越靠前）
            const sortA = Number(a.sort) || 0;
            const sortB = Number(b.sort) || 0;
            // 如果 sort 相同，保持原有顺序不变
            return sortB - sortA;
          });
        }
      })
      .finally(() => (tagSelectLoading.value = false)); // 隐藏 loading
  } else {
    // 如果搜索框为空，显示全部标签数据
    getTagSelectList().then(res => {
      if (res.success) {
        tags.value = res.data.sort((a: any, b: any) => {
          // 按 sort 字段降序排序（值越大越靠前）
          const sortA = Number(a.sort) || 0;
          const sortB = Number(b.sort) || 0;
          // 如果 sort 相同，保持原有顺序不变
          return sortB - sortA;
        });
      }
    }).finally(() => (tagSelectLoading.value = false)); // 隐藏 loading
  }
};

// 根据用户输入的分类名称，远程模糊查询
const remoteCategoryMethod = (query: string): void => {
  console.log("远程搜索分类：" + query);
  categorySearchValue.value = query;
  // 显示 loading
  categorySelectLoading.value = true;
  
  // 如果用户的查询关键词不为空，调用搜索接口
  if (query) {
    // 调用分类模糊查询接口
    searchCategories(query)
      .then((e: any) => {
        if (e.success) {
          // 设置到 categories 变量中，并按 sort 字段降序排序
          categories.value = e.data.sort((a: any, b: any) => {
            // 按 sort 字段降序排序（值越大越靠前）
            const sortA = Number(a.sort) || 0;
            const sortB = Number(b.sort) || 0;
            // 如果 sort 相同，保持原有顺序不变
            return sortB - sortA;
          });
        }
      })
      .finally(() => (categorySelectLoading.value = false)); // 隐藏 loading
  } else {
    // 如果搜索框为空，显示全部分类数据
    getCategorySelectList().then((e) => {
      if (e.success) {
        categories.value = e.data.sort((a: any, b: any) => {
          // 按 sort 字段降序排序（值越大越靠前）
          const sortA = Number(a.sort) || 0;
          const sortB = Number(b.sort) || 0;
          // 如果 sort 相同，保持原有顺序不变
          return sortB - sortA;
        });
      }
    }).finally(() => (categorySelectLoading.value = false)); // 隐藏 loading
  }
};

// 处理分类输入框获得焦点
const handleCategoryFocus = (): void => {
  // 如果搜索值为空且分类列表为空，则加载全部分类数据
  if (!categorySearchValue.value && categories.value.length === 0) {
    categorySelectLoading.value = true;
    getCategorySelectList().then((e) => {
      if (e.success) {
        categories.value = e.data.sort((a: any, b: any) => {
          // 按 sort 字段降序排序（值越大越靠前）
          const sortA = Number(a.sort) || 0;
          const sortB = Number(b.sort) || 0;
          // 如果 sort 相同，保持原有顺序不变
          return sortB - sortA;
        });
      }
    }).finally(() => (categorySelectLoading.value = false));
  }
};

// 处理标签输入框获得焦点
const handleTagFocus = (): void => {
  // 如果搜索值为空且标签列表为空，则加载全部标签数据
  if (!searchValue.value && tags.value.length === 0) {
    tagSelectLoading.value = true;
    getTagSelectList().then(res => {
      if (res.success) {
        tags.value = res.data.sort((a: any, b: any) => {
          // 按 sort 字段降序排序（值越大越靠前）
          const sortA = Number(a.sort) || 0;
          const sortB = Number(b.sort) || 0;
          // 如果 sort 相同，保持原有顺序不变
          return sortB - sortA;
        });
      }
    }).finally(() => (tagSelectLoading.value = false));
  }
};

// 发布文章
const publishArticleSubmit = async (): Promise<void> => {
  // 防止重复提交
  if (isPublishing.value) {
    console.log("正在发布中，请勿重复点击");
    return;
  }
  
  console.log("提交 md 内容：" + form.content);
  
  // 校验表单
  try {
    await publishArticleFormRef.value?.validate();
  } catch (error) {
    console.error("表单验证失败：", error);
    showMessage("请检查文章资料填写是否完整", "error");
    return;
  }
  
  // 开始发布流程
  isPublishing.value = true;
  uploadProgress.show = true;
  uploadProgress.percent = 0;
  uploadProgress.status = 'active';
  uploadProgress.text = '准备发布';
  
  try {
    // 计算总的上传任务数
    const contentImagesCount = pendingContentImages.value.filter(img => form.content.includes(img.previewUrl)).length;
    const coverImageCount = pendingCoverImage.value ? 1 : 0;
    const totalTasks = contentImagesCount + coverImageCount + 1; // +1 for article submission
    let completedTasks = 0;
    
    const updateProgress = (taskName: string) => {
      completedTasks++;
      uploadProgress.percent = Math.round((completedTasks / totalTasks) * 100);
      uploadProgress.text = taskName;
    };
    
    // 先上传内容中的图片
    if (contentImagesCount > 0) {
      uploadProgress.text = '上传内容图片';
      await uploadContentImages();
      updateProgress('内容图片上传完成');
    } else {
      updateProgress('跳过内容图片上传');
    }
    
    // 如果有待上传的封面图片，再上传封面图片
    if (pendingCoverImage.value) {
      uploadProgress.text = '上传封面图片';
      const newImageOriginalName = pendingCoverImage.value.name;
      try {
        const uploadRes = await uploadImageWithRetry(pendingCoverImage.value, newImageOriginalName, "");
        // 设置封面URL为上传后的地址
        form.cover = uploadRes.data.url;
        console.log("封面图片上传成功:", form.cover);
        updateProgress('封面图片上传完成');
      } catch (error) {
        const message = error instanceof Error ? error.message : "文件上传失败！";
        console.error("封面图片上传失败:", message);
        uploadProgress.status = 'exception';
        uploadProgress.text = '封面上传失败';
        showMessage(message, "error");
        return;
      }
    } else {
      updateProgress('跳过封面图片上传');
    }
    
    // 提交文章
    uploadProgress.text = '提交文章';
    await submitArticle();
    updateProgress('发布完成');
    uploadProgress.status = 'success';
    
    // 延迟隐藏进度条，让用户看到成功状态
    setTimeout(() => {
      uploadProgress.show = false;
    }, 1500);
    
  } catch (error) {
    console.error("发布失败：", error);
    uploadProgress.status = 'exception';
    uploadProgress.text = '发布失败';
    showMessage("发布失败，请重试", "error");
    
    // 延迟隐藏进度条
    setTimeout(() => {
      uploadProgress.show = false;
    }, 3000);
  } finally {
    isPublishing.value = false;
  }
};

// 带重试机制的图片上传函数
const uploadImageWithRetry = async (file: File, fileName: string, oldImageName: string = "", maxRetries: number = 3): Promise<any> => {
  let lastError: Error | null = null;
  
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      console.log(`尝试上传图片 ${fileName}，第 ${attempt}/${maxRetries} 次`);
      const res = await uploadImage(file, fileName, oldImageName);
      
      if (res.success !== false) {
        console.log(`图片上传成功: ${fileName}`);
        return res;
      } else {
        throw new Error(res.message || '上传失败');
      }
    } catch (error) {
      lastError = error instanceof Error ? error : new Error('未知错误');
      console.warn(`图片上传失败 (${attempt}/${maxRetries}): ${lastError.message}`);
      
      // 如果不是最后一次尝试，等待一段时间后重试
      if (attempt < maxRetries) {
        const delay = Math.min(1000 * Math.pow(2, attempt - 1), 5000); // 指数退避，最大5秒
        console.log(`等待 ${delay}ms 后重试...`);
        await new Promise(resolve => setTimeout(resolve, delay));
      }
    }
  }
  
  // 所有重试都失败了
  throw new Error(`图片上传失败（已重试${maxRetries}次）: ${lastError?.message || '未知错误'}`);
};

// 上传内容中的图片
const uploadContentImages = async (): Promise<void> => {
  console.log("开始处理内容图片上传...");
  
  if (pendingContentImages.value.length === 0) {
    console.log("没有待上传的内容图片，跳过上传步骤");
    return Promise.resolve();
  }
  
  // 过滤出仍在文章内容中的图片
  const activeImages = pendingContentImages.value.filter((imageInfo: PendingImage) => {
    return form.content.includes(imageInfo.previewUrl);
  });
  
  // 清理不再使用的图片的预览URL
  const unusedImages = pendingContentImages.value.filter((imageInfo: PendingImage) => {
    return !form.content.includes(imageInfo.previewUrl);
  });
  unusedImages.forEach((imageInfo: PendingImage) => {
    URL.revokeObjectURL(imageInfo.previewUrl);
  });
  
  if (activeImages.length === 0) {
    console.log("没有需要上传的图片（已过滤掉所有未使用的图片）");
    pendingContentImages.value = [];
    return Promise.resolve();
  }
  
  console.log(`开始上传 ${activeImages.length} 张内容图片（已过滤掉 ${unusedImages.length} 张未使用的图片）...`);
  
  try {
    // 逐个上传图片，避免并发过多导致的问题
    for (let i = 0; i < activeImages.length; i++) {
      const imageInfo = activeImages[i];
      console.log(`正在上传第 ${i + 1}/${activeImages.length} 张图片: ${imageInfo.file.name}`);
      
      try {
        const res = await uploadImageWithRetry(imageInfo.file, imageInfo.file.name, "");
        imageInfo.finalUrl = res.data.url;
        console.log(`图片上传成功 (${i + 1}/${activeImages.length}): ${imageInfo.previewUrl} -> ${imageInfo.finalUrl}`);
      } catch (error) {
        const errorMsg = `图片上传失败 (${i + 1}/${activeImages.length}): ${error instanceof Error ? error.message : '未知错误'}`;
        console.error(errorMsg);
        throw new Error(errorMsg);
      }
    }
    
    console.log("所有内容图片上传完成，开始更新文章内容中的图片URL...");
    
    // 替换文章内容中的预览URL为真实URL
    let updatedContent = form.content;
    activeImages.forEach((imageInfo: PendingImage) => {
      if (imageInfo.finalUrl) {
        // 更新内容
        updatedContent = updatedContent.replace(
          new RegExp(imageInfo.previewUrl.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), 'g'),
          imageInfo.finalUrl
        );
        
        // 关键修复：如果封面图也是这个预览URL，也需要同步更新为最终URL
        if (form.cover === imageInfo.previewUrl) {
          form.cover = imageInfo.finalUrl;
          console.log(`封面图URL已自动更新: ${imageInfo.previewUrl} -> ${imageInfo.finalUrl}`);
        }
      }
    });
    form.content = updatedContent;
    console.log("文章内容中的图片URL已更新完成");
    
    // 清理活跃图片的预览URL和待上传列表
    activeImages.forEach((imageInfo: PendingImage) => {
      URL.revokeObjectURL(imageInfo.previewUrl);
    });
    pendingContentImages.value = [];
    
  } catch (error) {
    console.error("批量上传图片失败：", error);
    // 重新抛出错误，让上层函数处理
    throw new Error(`内容图片上传失败: ${error instanceof Error ? error.message : '未知错误'}`);
  }
};

// 提交文章
const submitArticle = async (): Promise<void> => {
  try {
    const res = await publishArticle(form);
    if (res.success == false) {
      // 获取服务端返回的错误消息
      let message = res.message;
      // 提示错误消息
      showMessage(message, "error");
      throw new Error(message);
    }
    showMessage("发布成功");
    // 跳转回文章列表
    router.push("/admin/article/list");
  } catch (error) {
    console.error("发布文章失败：", error);
    const message = error instanceof Error ? error.message : "发布失败，请重试";
    showMessage(message, "error");
    throw error; // 重新抛出错误以便上层处理
  }
};

// 返回文章列表
const goBack = (): void => {
  router.push("/admin/article/list");
};

// 清空表单数据
const resetForm = (): void => {
  form.id = null;
  form.title = "";
  form.content = "";
  form.cover = "";
  form.categoryId = null;
  form.tags = [];
  form.summary = "";
  
  // 清空封面相关数据
  pendingCoverImage.value = null;
  coverPreviewUrl.value = '';
  
  // 清空内容图片数据
  pendingContentImages.value = [];
  
  // 清空表单验证状态
  publishArticleFormRef.value?.resetFields();
};

// 页面初始化
onMounted(() => {
  // 清空表单
  resetForm();
  
  // 获取分类数据
  getCategorySelectList().then((e) => {
    console.log("获取分类数据");
    categories.value = e.data.sort((a: any, b: any) => {
      // 按 sort 字段降序排序（值越大越靠前）
      const sortA = a.sort || 0;
      const sortB = b.sort || 0;
      // 如果 sort 相同，保持原有顺序不变
      return sortB - sortA;
    });
    console.log('排序后的分类数据：', sortedCategories);
  });

  // 渲染标签数据
  getTagSelectList().then((res) => {
    tags.value = res.data.sort((a: any, b: any) => {
      // 按 sort 字段降序排序（值越大越靠前）
      const sortA = a.sort || 0;
      const sortB = b.sort || 0;
      // 如果 sort 相同，保持原有顺序不变
      return sortB - sortA;
    });
    console.log('排序后的标签数据：', sortedTags);
  });
});

// 当组件被激活时（从缓存中恢复）清空表单
onActivated(() => {
  resetForm();
});
</script>

<style scoped lang="scss">

.article-create {
  height: calc(100vh - 165px); // 减去header和taglist的高度
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
  .table-card {
    :deep(.ant-card-body) {
      height: 100%;
      display: flex;
      flex-direction: column;
      padding: 0;
      overflow: hidden;
    }
    .table-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 16px;
      flex-shrink: 0;
      .table-title {
        font-size: 16px;
        font-weight: 500;
      }
    }
    .action-buttons {
      display: flex;
      gap: 8px;
    }
    .form-wrapper {
      height: 100%;
      overflow-y: auto;
      overflow-x: hidden;
      -webkit-overflow-scrolling: touch;
      scroll-behavior: smooth;
      padding: 24px;
    }
    
    .article-form {
      padding: 0;
      height: auto;
      min-height: 100%;
    }
    .pagination-wrapper {
      margin-top: 16px;
      display: flex;
      justify-content: flex-end;
      padding-top: 16px;
      border-top: 1px solid #f0f0f0;
    }
  }
  .status-tag {
    &.published {
      color: #52c41a;
    }
    &.draft {
      color: #faad14;
    }
  }
  .top-badge {
    color: #f5222d;
    font-weight: bold;
  }
}
:deep(.ant-card) {
  margin: 0px 0px 15px 0px !important;
}
/* 封面图片样式 */
// 上传区域基础样式
.upload-area {
  border: 2px dashed #d1d5db;
  border-radius: 12px;
  background: linear-gradient(135deg, #f9fafb 0%, #f3f4f6 100%);
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  overflow: hidden;
  
  &:hover {
    border-color: #3b82f6;
    background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(59, 130, 246, 0.15);
    
    .upload-placeholder {
      .upload-icon {
        color: #3b82f6;
        transform: scale(1.1);
      }
      
      .upload-text {
        color: #1e40af;
      }
    }
  }
}

// Logo 上传区域
.logo-area {
  width: 200px;
  height: 120px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 12px;
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

// 全局样式覆盖
:deep(.logo-uploader) {
  .ant-upload {
    border: none !important;
    background: transparent !important;
    padding: 0 !important;
    
    &:hover {
      background: transparent !important;
    }
  }
}

/* 指定 select 下拉框宽度 */
.ant-select {
  &.large-select {
    width: 600px;
  }
}

.md-editor-footer {
  height: 40px;
}
</style>