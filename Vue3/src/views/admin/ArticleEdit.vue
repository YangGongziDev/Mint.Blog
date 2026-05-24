<template>
    <div class="article-edit p-6 h-full flex flex-col">
        <!-- 页面标题 -->
        <a-card class="mb-5">
            <div class="flex justify-between items-center">
                <h2 class="text-xl font-bold">编辑文章</h2>
                <div class="flex gap-3">
                    <a-button @click="goBack">取消</a-button>
                    <a-button type="primary" @click="updateSubmit">
                        <template #icon>
                            <SaveOutlined />
                        </template>
                        保存
                    </a-button>
                </div>
            </div>
        </a-card>

        <!-- 文章表单 -->
        <a-card :loading="loading" class="table-card flex-1 overflow-hidden">
            <div class="form-wrapper">
                <a-form :model="updateArticleForm" ref="updateArticleFormRef" layout="vertical" :rules="rules" class="article-form">
                <a-form-item label="标题" name="title">
                    <a-input v-model:value="updateArticleForm.title" autocomplete="off" :maxlength="50"
                        show-count allow-clear placeholder="请输入文章标题" />
                </a-form-item>
                <a-form-item label="内容" name="content">
                    <!-- Markdown 编辑器 -->
                    <MdEditor v-model="updateArticleForm.content" @onUploadImg="onUploadImg"
                        editorId="updateArticleEditor" />
                </a-form-item>
                <a-form-item label="封面" name="cover">
                    <div class="flex gap-4 items-start">
                        <a-upload class="avatar-uploader" 
                        :show-upload-list="false" 
                        :before-upload="handleUpdateCoverChange"
                        action=""
                        >
                            <img v-if="updateArticleForm.cover" :src="updateArticleForm.cover" class="avatar" />
                            <div v-else class="avatar-uploader-icon">
                                <PlusOutlined />
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
                    <a-textarea v-model:value="updateArticleForm.summary" :rows="3" placeholder="请输入文章摘要" />
                </a-form-item>
                <a-form-item label="分类" name="categoryId">
                    <a-select 
                        v-model:value="updateArticleForm.categoryId" 
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
                        <a-select-option v-for="item in categories" :key="item.value" :value="item.value">
                            {{ item.label }}
                        </a-select-option>
                    </a-select>
                </a-form-item>
                <a-form-item label="标签" name="tags">
                    <div class="w-60">
                        <!-- 标签选择 -->
                        <a-select v-model:value="updateArticleForm.tags" mode="tags" :filter-option="false"
                            placeholder="请输入文章标签" :loading="tagSelectLoading" 
                            :search-value="searchValue"
                            @search="remoteMethod"
                            @focus="handleTagFocus"
                            size="large"
                            allow-clear
                            show-search>
                            <a-select-option v-for="item in tags" :key="item.value" :value="item.value">
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
import { ref, reactive, onMounted, watch, onBeforeUnmount } from 'vue'
import { SaveOutlined, PlusOutlined, PictureOutlined, CheckCircleOutlined } from '@ant-design/icons-vue'
import { getArticleDetail, updateArticle } from '@/api/admin/article'
import { uploadImage,deleteImage,deleteImages } from "@/api/admin/image";
import { getCategorySelectList, searchCategories } from '@/api/admin/category'
import { searchTags, getTagSelectList } from '@/api/admin/tag'
import { showMessage, extractImagesFromMarkdown } from '@/composables/util.ts'
import { MdEditor } from 'md-editor-v3'
import 'md-editor-v3/lib/style.css'
import { useRouter, useRoute } from 'vue-router'
import type { FormInstance } from 'ant-design-vue'
import type { UploadFile } from 'ant-design-vue/es/upload/interface'

const router = useRouter()
const route = useRoute()
const updateArticleFormRef = ref<FormInstance>()
const pendingCoverImage = ref<File | null>(null)

// 页面加载状态
const loading = ref<boolean>(false)

// 图片选择器相关
const imageSelectorVisible = ref(false);
const contentImages = ref<string[]>([]);
const selectedImageIndex = ref<number>(-1);

// 显示图片选择器
const showImageSelector = () => {
  contentImages.value = extractImagesFromMarkdown(updateArticleForm.content);
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
    // 如果选择了正文图片，清除可能存在的待上传文件
    pendingCoverImage.value = null;
    updateArticleForm.cover = selectedUrl;
    imageSelectorVisible.value = false;
    showMessage('已选择封面图', 'success');
  } else {
    showMessage('请选择一张图片', 'warning');
  }
};
// 待上传的内容图片列表
interface PendingImage {
  id: string
  file: File
  previewUrl: string
  finalUrl: string | null
}
const pendingContentImages = ref<PendingImage[]>([])

// 跟踪未使用的图片（用于清理）
const unusedImages = ref<string[]>([])

// 保存老封面 URL，用于获取原始文件名
const oldCoverUrl = ref<string>("")

// 记录文章初始加载时的所有图片（用于检测删除）
const originalContentImages = ref<string[]>([])

// 提取内容中的所有图片URL
const extractImageUrls = (content: string): string[] => {
  const imageRegex = /!\[.*?\]\((.*?)\)/g;
  const urls: string[] = [];
  let match;
  while ((match = imageRegex.exec(content)) !== null) {
    if (match[1]) urls.push(match[1]);
  }
  return urls;
}

// 检测被删除的原有图片
const detectDeletedOriginalImages = (): void => {
  const currentContentImages = extractImageUrls(updateArticleForm.content);
  
  // 找出被删除的原有图片
  const deletedImages = originalContentImages.value.filter(originalUrl => {
    return !currentContentImages.includes(originalUrl);
  });
  
  // 将被删除的图片添加到未使用列表中
  deletedImages.forEach(deletedUrl => {
    const imageName = getOriginalImageName(deletedUrl);
    if (imageName && !unusedImages.value.includes(imageName)) {
      unusedImages.value.push(imageName);
      console.log(`检测到被删除的原有图片: ${imageName}`);
    }
  });
}

// 修改文章表单对象
interface UpdateArticleForm {
  id: number | null
  title: string
  content: string
  cover: string
  categoryId: number | null
  tags: number[]
  summary: string
}

const updateArticleForm = reactive<UpdateArticleForm>({
    id: null,
    title: '',
    content: '请输入内容',
    cover: '',
    categoryId: null,
    tags: [],
    summary: ""
})

// 表单校验规则
const rules = {
    title: [
        { required: true, message: '请输入文章标题', trigger: 'blur' },
        { min: 1, max: 50, message: '文章标题要求大于1个字符，小于50个字符', trigger: 'blur' },
    ],
    content: [{ required: true, message: '请输入文章内容', trigger: 'blur' }],
    cover: [{ required: true, message: '请上传文章封面', trigger: 'change' }],
    categoryId: [{ required: true, message: '请选择文章分类', trigger: 'change' }],
    tags: [{ required: true, message: '请选择文章标签', trigger: 'change' }],
}

// 编辑文章：选择文章封面图片（仅预览，不立即上传）
const handleUpdateCoverChange = (file: UploadFile): boolean => {
    // 保存待上传的文件
    pendingCoverImage.value = file as unknown as File;
    // 预览图片
    const reader = new FileReader();
    reader.onload = (e: ProgressEvent<FileReader>) => {
        if (e.target?.result) {
            updateArticleForm.cover = e.target.result as string; // 显示预览
        }
    };
    reader.readAsDataURL(file as unknown as File);
    
    // 返回 false 阻止自动上传
    return false;
}

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
        
        console.log('==> 图片已添加到待上传列表，预览URL：' + previewUrl);
    });
    
    // 调用 callback 函数，返回预览URL供编辑器显示
    callback(previewUrls);
}

// 文章分类
interface CategoryOption {
  label: string
  value: number
  sort?: number
}
const categories = ref<CategoryOption[]>([])

// 分类搜索相关变量
const categorySearchValue = ref<string>('')
const categorySelectLoading = ref<boolean>(false)

// 标签 select Loading 状态，默认不显示
const tagSelectLoading = ref<boolean>(false)
// 标签搜索相关变量
const searchValue = ref<string>('')
// 文章标签
interface TagOption {
  label: string
  value: number
}
const tags = ref<TagOption[]>([])

// 从原始 Cover URL 中提取原始文件名
const getOriginalImageName = (url: string): string => {
  if (!url) return "";
  const urlParts = url.split("/");
  return urlParts[urlParts.length - 1] || ""; // 获取 URL 最后一部分作为文件名，如果为 undefined 则返回空字符串
};

// 根据用户输入的标签名称，远程模糊查询
const remoteMethod = (query: string): void => {
    console.log('远程搜索：' + query)
    searchValue.value = query
    // 显示 loading
    tagSelectLoading.value = true
    
    // 如果用户的查询关键词不为空，调用搜索接口
    if (query) {
        // 调用标签模糊查询接口
        searchTags(query).then((e: any) => {
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
        }).finally(() => tagSelectLoading.value = false) // 隐藏 loading
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
        }).finally(() => tagSelectLoading.value = false) // 隐藏 loading
    }
}

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
        }).finally(() => tagSelectLoading.value = false);
    }
}

// 根据用户输入的分类名称，远程模糊查询
const remoteCategoryMethod = (query: string): void => {
    console.log('分类远程搜索：' + query)
    // 显示 loading
    categorySelectLoading.value = true
    
    // 如果用户的查询关键词不为空，调用搜索接口
    if (query) {
        // 调用分类模糊查询接口
        searchCategories(query).then((e: any) => {
            if (e.success) {
                // 设置到 categories 变量中，并按 sort 字段降序排序
                categories.value = e.data.sort((a: any, b: any) => {
                    // 按 sort 字段降序排序（值越大越靠前）
                    const sortA = Number(a.sort) || 0;
                    const sortB = Number(b.sort) || 0;
                    // 只按sort字段降序排序，sort相同时保持原有顺序不变
                    return sortB - sortA;
                });
            }
        }).finally(() => categorySelectLoading.value = false) // 隐藏 loading
    } else {
        // 如果搜索框为空，显示全部分类数据
        getCategorySelectList().then((e) => {
            if (e.success) {
                categories.value = e.data.sort((a: any, b: any) => {
                    // 按 sort 字段降序排序（值越大越靠前）
                    const sortA = Number(a.sort) || 0;
                    const sortB = Number(b.sort) || 0;
                    // 只按sort字段降序排序，sort相同时保持原有顺序不变
                    return sortB - sortA;
                });
            }
        }).finally(() => categorySelectLoading.value = false) // 隐藏 loading
    }
}

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
                    // 只按sort字段降序排序，sort相同时保持原有顺序不变
                    return sortB - sortA;
                });
            }
        }).finally(() => categorySelectLoading.value = false);
    }
}

// 保存文章
const updateSubmit = async (): Promise<void> => {
    try {
        // 校验表单
        await updateArticleFormRef.value?.validate();
        
        try {
            // 检测被删除的原有图片
            detectDeletedOriginalImages();
            
            // 先上传内容中的图片
            await uploadContentImages();
            
            // 如果有待上传的封面图片，再上传图片
            if (pendingCoverImage.value) {
                const oldImageName = getOriginalImageName(oldCoverUrl.value);
                const newImageOriginalName = pendingCoverImage.value.name;

                // 检查旧封面是否在正文中被引用
                // 如果旧封面在正文中被引用，则在上传新封面时不请求后端删除旧封面
                let imageToDelete = oldImageName;
                if (oldCoverUrl.value && updateArticleForm.content.includes(oldCoverUrl.value)) {
                    console.log('旧封面在正文中被引用，上传新封面时不删除旧封面:', oldCoverUrl.value);
                    imageToDelete = "";
                }

                const uploadRes = await uploadImage(pendingCoverImage.value, newImageOriginalName, imageToDelete);
                if (!uploadRes.success) {
                    showMessage(uploadRes.message, "error");
                    return;
                }
                // 设置封面URL为上传后的地址
                updateArticleForm.cover = uploadRes.data.url
                // 清空待上传的文件
                pendingCoverImage.value = null
            }
            // 提交文章
            submitUpdateArticle()
        } catch (error) {
            console.error("内容图片上传失败：", error);
            showMessage("图片上传失败，请重试", "error");
        }
    } catch (error) {
        console.error("表单验证失败：", error);
    }
}

// 上传内容中的图片
const uploadContentImages = async () => {
    if (pendingContentImages.value.length === 0) {
        return Promise.resolve();
    }
    
    // 过滤出仍在文章内容中的图片
    const activeImages = pendingContentImages.value.filter((imageInfo: PendingImage) => {
        return updateArticleForm.content.includes(imageInfo.previewUrl);
    });
    
    // 清理不再使用的新增图片的预览URL
    const unusedNewImages = pendingContentImages.value.filter((imageInfo: PendingImage) => {
        return !updateArticleForm.content.includes(imageInfo.previewUrl);
    });
    unusedNewImages.forEach((imageInfo: PendingImage) => {
        URL.revokeObjectURL(imageInfo.previewUrl);
    });
    
    if (activeImages.length === 0) {
        console.log("没有需要上传的新增图片");
        pendingContentImages.value = [];
        return Promise.resolve();
    }
    
    console.log(`开始上传 ${activeImages.length} 张内容图片（已过滤掉 ${unusedNewImages.length} 张未使用的新增图片）...`);
    try {
        // 批量上传仍在使用的图片
        const uploadPromises = activeImages.map(async (imageInfo: PendingImage) => {
            const res = await uploadImage(imageInfo.file, imageInfo.file.name, "");
            if (res.success !== false) {
                imageInfo.finalUrl = res.data.url;
                console.log(`图片上传成功: ${imageInfo.previewUrl} -> ${imageInfo.finalUrl}`);
                return imageInfo;
            } else {
                throw new Error(`图片上传失败: ${res.message}`);
            }
        });
        await Promise.all(uploadPromises);
        // 替换文章内容中的预览URL为真实URL
        let updatedContent = updateArticleForm.content;
        activeImages.forEach((imageInfo: PendingImage) => {
            if (imageInfo.finalUrl) {
                updatedContent = updatedContent.replace(
                    new RegExp(imageInfo.previewUrl.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), 'g'),
                    imageInfo.finalUrl
                );

                // 关键修复：如果封面图也是这个预览URL，也需要同步更新为最终URL
                if (updateArticleForm.cover === imageInfo.previewUrl) {
                    updateArticleForm.cover = imageInfo.finalUrl;
                    console.log(`封面图URL已自动更新: ${imageInfo.previewUrl} -> ${imageInfo.finalUrl}`);
                }
            }
        });
        updateArticleForm.content = updatedContent;
        console.log("文章内容中的图片URL已更新");
        // 清理活跃图片的预览URL和待上传列表
        activeImages.forEach((imageInfo: PendingImage) => {
            URL.revokeObjectURL(imageInfo.previewUrl);
        });
        pendingContentImages.value = [];
    } catch (error) {
        console.error("批量上传图片失败：", error);
        throw error;
    }
};

// 提交更新文章
const submitUpdateArticle = async (): Promise<void> => {
    try {
        const res = await updateArticle(updateArticleForm);
        if (res.success == false) {
            // 获取服务端返回的错误消息
            let message = res.message
            // 提示错误消息
            showMessage(message, 'error')
            return
        }
        showMessage('保存成功')
        
        // 文章保存成功后，清理未使用的图片
        await cleanupUnusedImages()

        // 检查旧封面是否需要删除
        // 如果旧封面存在，且新封面与旧封面不同，且旧封面没有在正文中使用，则删除旧封面
        if (oldCoverUrl.value && updateArticleForm.cover !== oldCoverUrl.value) {
            const isUsedInContent = updateArticleForm.content.includes(oldCoverUrl.value);
            if (!isUsedInContent) {
                console.log('检测到封面已更换且旧封面未被引用，准备删除旧封面:', oldCoverUrl.value);
                const oldCoverName = getOriginalImageName(oldCoverUrl.value);
                if (oldCoverName) {
                    try {
                        await deleteImage(oldCoverName);
                        console.log('旧封面删除成功');
                    } catch (err) {
                        console.error('旧封面删除失败:', err);
                        // 不阻断流程，仅记录错误
                    }
                }
            } else {
                console.log('旧封面虽已更换，但在正文中被引用，跳过删除:', oldCoverUrl.value);
            }
        }
        
        // 清空未使用图片列表
        unusedImages.value = []
        // 跳转回文章列表
        router.push('/admin/article/list')
    } catch (error) {
        console.error('保存文章失败:', error)
        showMessage('保存失败，请重试', 'error')
    }
}

// 返回文章列表
const goBack = (): void => {
    router.push('/admin/article/list')
}

// 加载文章详情
const loadArticleDetail = (): void => {
    const articleId = route.params.id as string
    if (!articleId) {
        showMessage('文章ID不存在', 'error')
        router.push('/admin/article/list')
        return
    }
    loading.value = true
    getArticleDetail(articleId).then((res: any) => {
        if (res.success) {
            // 使用Object.assign确保响应式更新
            Object.assign(updateArticleForm, {
                id: res.data.id,
                title: res.data.title,
                cover: res.data.cover,
                content: res.data.content,
                categoryId: res.data.categoryId,
                tags: res.data.tagIds || [],
                summary: res.data.summary
            })
            oldCoverUrl.value = res.data.cover
            // 记录原始内容中的所有图片
            originalContentImages.value = extractImageUrls(res.data.content)
        } else {
            showMessage('加载文章详情失败', 'error')
            router.push('/admin/article/list')
        }
    }).finally(() => {
        loading.value = false
    })
}

// 监听路由参数变化
watch(() => route.params.id, (newId, oldId) => {
    if (newId && newId !== oldId) {
        // 重置表单数据
        Object.assign(updateArticleForm, {
            id: '',
            title: '',
            cover: '',
            content: '',
            categoryId: '',
            tags: [],
            summary: ''
        })
        oldCoverUrl.value = ''
        // 重置图片追踪数据
        originalContentImages.value = []
        unusedImages.value = []
        pendingContentImages.value = []
        pendingCoverImage.value = null
        // 重新加载文章详情
        loadArticleDetail()
    }
}, { immediate: false })

// 清理未使用的图片
const cleanupUnusedImages = async () => {
    if (unusedImages.value.length > 0) {
        console.log('清理未使用的图片:', unusedImages.value)
        try {
            // 如果仅有一张图片，使用单次删除；如果多于一张，使用批量删除
            if (unusedImages.value.length === 1) {
                await deleteImage(unusedImages.value[0]?.toString() || '')
            } else if (unusedImages.value.length > 1) {
                await deleteImages(unusedImages.value)
            } else {
                console.warn('未使用图片列表为空')
            }
            console.log('未使用图片清理完成')
        } catch (error) {
            console.error('清理图片时发生错误:', error)
        }
    }
}

// 页面初始化
onMounted(() => {
    // 获取分类数据
    getCategorySelectList().then((e) => {
        console.log('getCategorySelectList',e)
        categories.value = e.data.sort((a: any, b: any) => {
            // 按 sort 字段降序排序（值越大越靠前）
            const sortA = a.sort || 0;
            const sortB = b.sort || 0;
            // 只按sort字段降序排序，sort相同时保持原有顺序不变
            return sortB - sortA;
        });
    })
    
    // 渲染标签数据
    getTagSelectList().then(res => {
        console.log('getTagSelectList',res)
        tags.value = res.data.sort((a: any, b: any) => {
            // 按 sort 字段降序排序（值越大越靠前）
            const sortA = a.sort || 0;
            const sortB = b.sort || 0;
            // 如果 sort 相同，保持原有顺序不变
            return sortB - sortA;
        });
    })
    
    // 加载文章详情
    loadArticleDetail()
})

// 组件销毁前清理未使用的图片
onBeforeUnmount(() => {
    cleanupUnusedImages()
})
</script>

<style scoped lang="scss">

.article-edit {
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
.avatar-uploader {
  .avatar {
    width: 200px;
    height: 100px;
    display: block;
    object-fit: cover;
    border-radius: 6px;
  }

  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 200px;
    height: 100px;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    transition: border-color 0.3s;

    &:hover {
      border-color: #1890ff;
    }
  }
}

/* 指定 select 下拉框宽度 */
.ant-select {
  width: 100%;
  max-width: 600px;
}

.md-editor-footer {
  height: 40px;
}
</style>