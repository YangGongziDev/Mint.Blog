<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, reactive, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import type { FormInstance, FormProps, TablePaginationConfig } from 'ant-design-vue';
import { Modal, message } from 'ant-design-vue';
import { PictureOutlined, PlusOutlined } from '@ant-design/icons-vue';
import { MdEditor } from 'md-editor-v3';
import 'md-editor-v3/lib/style.css';
import {
  type ArticleDraftDetail,
  type ArticleFormModel,
  type SaveArticleDraftPayload,
  createArticle,
  getArticleDetail,
  getArticleDraftByArticleId,
  getArticleDraftDetail,
  publishArticleDraft,
  saveArticleDraft,
  updateArticle
} from '@/service/blog/admin/article';
import { type CategoryListItem, getCategoryList } from '@/service/blog/admin/category';
import { type TagListItem, getTagList } from '@/service/blog/admin/tag';
import { deleteBlogImages, getManagedImagePageList, getMinioBuckets, type ManagedImageListItem, type MinioBucketItem, uploadBlogImage } from '@/service/blog/admin/image';
import { useAppStore } from '@/store/system/app';
import { resolveServiceErrorMessage } from '@/utils/service-error';

const ARTICLE_DRAFT_PREFIX = 'mint-blog-article-draft:';

defineOptions({
  name: 'ArticleEditor'
});

interface ArticleDraftPayload {
  form: ArticleFormModel;
  savedAt: string;
}

type ProcessingPhase = 'uploading' | 'deleting' | 'saving' | 'done';

const props = defineProps<{ mode: 'create' | 'edit' }>();

const router = useRouter();
const route = useRoute();
const appStore = useAppStore();

const loading = ref(false);
const submitting = ref(false);
const draftSaving = ref(false);
const formRef = ref<FormInstance>();
const categories = ref<CategoryListItem[]>([]);
const tags = ref<TagListItem[]>([]);
const pendingCoverImage = ref<File | null>(null);
const originalCoverUrl = ref('');
const imageSelectorVisible = ref(false);
const gallerySelectorVisible = ref(false);
const galleryLoading = ref(false);
const galleryBuckets = ref<MinioBucketItem[]>([]);
const galleryImages = ref<ManagedImageListItem[]>([]);
const galleryTotal = ref(0);
const selectedGalleryImageUrl = ref('');
const galleryQuery = reactive({
  pageNumber: 1,
  pageSize: 12,
  bucketName: '',
  fileName: '',
  sortOrder: 'lastModifiedDesc' as 'lastModifiedDesc' | 'lastModifiedAsc' | 'nameAsc' | 'nameDesc'
});
const contentImages = ref<string[]>([]);
const selectedImageIndex = ref(-1);
const serverDraftId = ref<string | null>(null);
const serverArticleDraft = ref<ArticleDraftDetail | null>(null);
const localImageFiles = new Map<string, File>();
let uploadedImagesInCurrentAttempt: string[] = [];
let initialImageUrls = new Set<string>();
const processingState = reactive({
  visible: false,
  phase: 'uploading' as ProcessingPhase,
  title: '',
  uploadTotal: 0,
  uploadDone: 0,
  deleteTotal: 0,
  deleteDone: 0
});

const formModel = reactive<ArticleFormModel>({
  title: '',
  summary: '',
  content: '',
  cover: '',
  categoryId: undefined,
  tagIds: []
});

const modalWidth = computed(() => (appStore.isMobile ? '92vw' : 680));
const galleryModalWidth = computed(() => (appStore.isMobile ? '96vw' : 920));
const galleryPagination = computed<TablePaginationConfig>(() => ({
  current: galleryQuery.pageNumber,
  pageSize: galleryQuery.pageSize,
  total: galleryTotal.value,
  showSizeChanger: true,
  pageSizeOptions: ['12', '24', '48'],
  showTotal: total => `共 ${total} 张图片`,
  size: appStore.isMobile ? 'small' : 'default'
}));
const uploadPercent = computed(() =>
  processingState.uploadTotal ? Math.round((processingState.uploadDone / processingState.uploadTotal) * 100) : 0
);
const deletePercent = computed(() =>
  processingState.deleteTotal ? Math.round((processingState.deleteDone / processingState.deleteTotal) * 100) : 0
);
const processingDescription = computed(() => {
  if (processingState.phase === 'uploading')
    return `还有 ${processingState.uploadTotal - processingState.uploadDone} 张图片上传中`;
  if (processingState.phase === 'deleting')
    return `还有 ${processingState.deleteTotal - processingState.deleteDone} 张图片等待清理`;
  if (processingState.phase === 'saving') return '图片处理完成，正在保存文章数据';
  return '处理完成，即将返回列表';
});

const rules: FormProps['rules'] = {
  title: [{ required: true, message: '请输入文章标题', trigger: 'blur' }],
  content: [{ required: true, message: '请输入文章内容', trigger: 'change' }],
  cover: [{ required: true, message: '请上传或选择封面', trigger: 'change' }],
  summary: [{ required: true, message: '请输入文章摘要', trigger: 'blur' }],
  categoryId: [{ required: true, message: '请选择分类', trigger: 'change' }],
  tagIds: [{ required: true, type: 'array', min: 1, message: '请选择标签', trigger: 'change' }]
};

function getDraftStorageKey() {
  return props.mode === 'edit' ? `blogArticleDraftEdit_${getArticleId()}` : 'blogArticleDraftCreate';
}

function getArticleId() {
  return route.params.id as string;
}

function getDraftId() {
  const draftId = route.query.draftId;
  return typeof draftId === 'string' && /^\d+$/.test(draftId) ? draftId : null;
}

function goBack() {
  releaseLocalImages();
  router.push({ name: 'blog-admin_article' });
}

function isLocalImageUrl(url: string) {
  return url.startsWith('blob:') && localImageFiles.has(url);
}

function releaseLocalImages() {
  for (const url of localImageFiles.keys()) URL.revokeObjectURL(url);
  localImageFiles.clear();
}

function getCurrentImageSet() {
  return new Set([...extractImages(formModel.content), formModel.cover].filter(Boolean));
}

function recordInitialImages() {
  initialImageUrls = getCurrentImageSet();
}

function getRemovedInitialImagesCount() {
  const currentImages = getCurrentImageSet();
  return [...initialImageUrls].filter(url => !currentImages.has(url)).length;
}

function showProcessing(title: string) {
  Object.assign(processingState, {
    visible: true,
    phase: 'uploading' as ProcessingPhase,
    title,
    uploadTotal: 0,
    uploadDone: 0,
    deleteTotal: 0,
    deleteDone: 0
  });
}

function setProcessingDone(title = '处理完成') {
  processingState.phase = 'done';
  processingState.title = title;
}

function hideProcessing(delay = 600) {
  window.setTimeout(() => {
    processingState.visible = false;
  }, delay);
}

function replaceAllText(value: string, replacements: Map<string, string>) {
  let result = value;
  for (const [oldValue, newValue] of replacements) result = result.split(oldValue).join(newValue);
  return result;
}

async function uploadLocalContentImages() {
  const localUrls = new Set(extractImages(formModel.content).filter(isLocalImageUrl));
  if (isLocalImageUrl(formModel.cover)) localUrls.add(formModel.cover);
  processingState.phase = 'uploading';
  processingState.uploadTotal = localUrls.size + (pendingCoverImage.value ? 1 : 0);
  processingState.uploadDone = 0;
  if (localUrls.size === 0) return true;

  const replacements = new Map<string, string>();
  const uploadEntries = [...localUrls]
    .map(localUrl => ({ localUrl, file: localImageFiles.get(localUrl) }))
    .filter((item): item is { localUrl: string; file: File } => Boolean(item.file));

  const uploadResults = await Promise.all(
    uploadEntries.map(async ({ localUrl, file }) => {
      const res = await uploadBlogImage({
        newImageFile: file,
        newImageOriginalName: file.name
      });
      processingState.uploadDone += 1;
      return { localUrl, res };
    })
  );

  for (const { localUrl, res } of uploadResults) {
    if (!res.success) {
      message.error('正文图片上传失败，请重试');
      return false;
    }

    replacements.set(localUrl, res.data.url);
    uploadedImagesInCurrentAttempt.push(res.data.url);
  }

  formModel.content = replaceAllText(formModel.content, replacements);
  if (replacements.has(formModel.cover)) formModel.cover = replacements.get(formModel.cover)!;

  return true;
}

async function prepareImagesBeforeSave() {
  uploadedImagesInCurrentAttempt = [];
  const contentImagesUploaded = await uploadLocalContentImages();
  if (!contentImagesUploaded) return false;
  const coverUploaded = await uploadPendingCover();
  if (!coverUploaded) return false;
  processingState.phase = 'deleting';
  processingState.deleteTotal = getRemovedInitialImagesCount();
  processingState.deleteDone = 0;
  await Promise.resolve();
  processingState.deleteDone = processingState.deleteTotal;
  return true;
}

async function cleanupCurrentAttemptUploads() {
  if (uploadedImagesInCurrentAttempt.length === 0) return;

  await deleteBlogImages([...uploadedImagesInCurrentAttempt]).catch(() => undefined);
  uploadedImagesInCurrentAttempt = [];
}

function snapshotForm(): ArticleFormModel {
  return {
    title: formModel.title,
    summary: formModel.summary,
    content: formModel.content,
    cover: formModel.cover,
    categoryId: formModel.categoryId,
    tagIds: [...formModel.tagIds]
  };
}

function buildDraftPayload(): SaveArticleDraftPayload {
  return {
    ...snapshotForm(),
    draftId: serverDraftId.value,
    articleId: props.mode === 'edit' ? getArticleId() : null,
    categoryId: formModel.categoryId ?? null
  };
}

function applyDraft(draft: ArticleDraftDetail) {
  releaseLocalImages();
  Object.assign(formModel, {
    title: draft.title,
    summary: draft.summary,
    content: draft.content,
    cover: draft.cover,
    categoryId: draft.categoryId ?? undefined,
    tagIds: draft.tagIds
  });
  serverDraftId.value = draft.id;
  pendingCoverImage.value = null;
  recordInitialImages();
}

function readDraft(): ArticleDraftPayload | null {
  const raw = localStorage.getItem(`${ARTICLE_DRAFT_PREFIX}${getDraftStorageKey()}`);
  if (!raw) return null;

  try {
    return JSON.parse(raw) as ArticleDraftPayload;
  } catch {
    localStorage.removeItem(`${ARTICLE_DRAFT_PREFIX}${getDraftStorageKey()}`);
    return null;
  }
}

function writeDraft(payload: ArticleDraftPayload) {
  localStorage.setItem(`${ARTICLE_DRAFT_PREFIX}${getDraftStorageKey()}`, JSON.stringify(payload));
}

function clearDraft() {
  localStorage.removeItem(`${ARTICLE_DRAFT_PREFIX}${getDraftStorageKey()}`);
}

function previewImage(file: File) {
  const reader = new FileReader();
  reader.onload = event => {
    if (event.target?.result) {
      formModel.cover = event.target.result as string;
      formRef.value?.validateFields(['cover']).catch(() => undefined);
    }
  };
  reader.readAsDataURL(file);
}

function handleCoverInputChange(event: Event) {
  const file = (event.target as HTMLInputElement).files?.[0];
  if (file) {
    pendingCoverImage.value = file;
    previewImage(file);
  }
  (event.target as HTMLInputElement).value = '';
}

function handleContentChange() {
  formRef.value?.validateFields(['content']).catch(() => undefined);
}

function getSubmitProcessingTitle() {
  return props.mode === 'create' ? '正在发布文章' : '正在保存文章';
}

async function uploadPendingCover() {
  if (!pendingCoverImage.value) return true;

  const res = await uploadBlogImage({
    newImageFile: pendingCoverImage.value,
    newImageOriginalName: pendingCoverImage.value.name,
    oldImageName: originalCoverUrl.value
  });

  if (!res.success) {
    message.error('封面上传失败，请重试');
    return false;
  }

  formModel.cover = res.data.url;
  uploadedImagesInCurrentAttempt.push(res.data.url);
  processingState.uploadDone += 1;
  return true;
}

async function handleEditorUpload(files: File[], callback: (urls: string[]) => void) {
  const urls = files.map(file => {
    const localUrl = URL.createObjectURL(file);
    localImageFiles.set(localUrl, file);
    return localUrl;
  });
  callback(urls);
}

function extractImages(markdown: string) {
  const urls: string[] = [];
  const regex = /!\[[^\]]*]\(([^)]+)\)/g;
  let match: RegExpExecArray | null;
  while ((match = regex.exec(markdown))) urls.push(match[1]);
  return urls;
}

function openImageSelector() {
  contentImages.value = extractImages(formModel.content);
  if (!contentImages.value.length) {
    message.warning('正文中暂无图片');
    return;
  }
  selectedImageIndex.value = -1;
  imageSelectorVisible.value = true;
}

function handleImageSelectConfirm() {
  if (selectedImageIndex.value < 0) {
    message.warning('请选择一张图片');
    return;
  }
  formModel.cover = contentImages.value[selectedImageIndex.value];
  pendingCoverImage.value = null;
  imageSelectorVisible.value = false;
  formRef.value?.validateFields(['cover']).catch(() => undefined);
}

async function loadGalleryBuckets() {
  const res = await getMinioBuckets();
  if (!res.success) return false;
  galleryBuckets.value = res.data;
  if (!galleryQuery.bucketName && res.data.length) galleryQuery.bucketName = res.data[0].name;
  return true;
}

async function loadGalleryImages() {
  if (!galleryQuery.bucketName) {
    galleryImages.value = [];
    galleryTotal.value = 0;
    return;
  }

  galleryLoading.value = true;
  try {
    const res = await getManagedImagePageList({
      pageNumber: galleryQuery.pageNumber,
      pageSize: galleryQuery.pageSize,
      bucketName: galleryQuery.bucketName,
      fileName: galleryQuery.fileName || undefined,
      sortOrder: galleryQuery.sortOrder
    });
    if (res.success) {
      galleryImages.value = res.data.items || res.data.records || [];
      galleryTotal.value = res.data.totalCount || res.data.total || 0;
    }
  } finally {
    galleryLoading.value = false;
  }
}

async function openGallerySelector() {
  gallerySelectorVisible.value = true;
  selectedGalleryImageUrl.value = formModel.cover || '';
  try {
    if (!galleryBuckets.value.length) {
      const loaded = await loadGalleryBuckets();
      if (!loaded) return;
    }
    galleryQuery.pageNumber = 1;
    await loadGalleryImages();
  } catch (error) {
    message.error(resolveServiceErrorMessage(error));
  }
}

async function handleGalleryBucketChange() {
  galleryQuery.pageNumber = 1;
  selectedGalleryImageUrl.value = '';
  await loadGalleryImages();
}

async function handleGallerySearch() {
  galleryQuery.pageNumber = 1;
  await loadGalleryImages();
}

async function handleGalleryReset() {
  galleryQuery.fileName = '';
  galleryQuery.sortOrder = 'lastModifiedDesc';
  galleryQuery.pageNumber = 1;
  await loadGalleryImages();
}

async function handleGalleryPageChange(page: TablePaginationConfig) {
  galleryQuery.pageNumber = page.current || 1;
  galleryQuery.pageSize = page.pageSize || 12;
  await loadGalleryImages();
}

function handleGallerySelectConfirm() {
  if (!selectedGalleryImageUrl.value) {
    message.warning('请选择一张图库图片');
    return;
  }
  formModel.cover = selectedGalleryImageUrl.value;
  pendingCoverImage.value = null;
  gallerySelectorVisible.value = false;
  formRef.value?.validateFields(['cover']).catch(() => undefined);
}

function formatImageSize(size: number) {
  if (size < 1024) return `${size} B`;
  if (size < 1024 * 1024) return `${(size / 1024).toFixed(1)} KiB`;
  return `${(size / 1024 / 1024).toFixed(2)} MiB`;
}

async function loadOptions() {
  const [categoryRes, tagRes] = await Promise.all([getCategoryList(), getTagList()]);
  if (categoryRes.success) categories.value = categoryRes.data;
  if (tagRes.success) tags.value = tagRes.data;
}

async function loadDetail() {
  if (props.mode !== 'edit') return;

  loading.value = true;
  try {
    const res = await getArticleDetail(getArticleId());
    if (res.success) {
      Object.assign(formModel, {
        title: res.data.title,
        summary: res.data.summary,
        content: res.data.content,
        cover: res.data.cover,
        categoryId: res.data.categoryId,
        tagIds: res.data.tags.map(tag => tag.id)
      });
      originalCoverUrl.value = res.data.cover;
    }
  } finally {
    loading.value = false;
  }
}

async function loadServerDraft() {
  const draftId = getDraftId();
  if (draftId) {
    const res = await getArticleDraftDetail(draftId);
    if (res.success) {
      serverArticleDraft.value = res.data;
      applyDraft(res.data);
    }
    return;
  }

  if (props.mode !== 'edit') return;

  const res = await getArticleDraftByArticleId(getArticleId());
  if (res.success && res.data) serverArticleDraft.value = res.data;
}

function restoreDraftIfNeeded() {
  const payload = readDraft();

  if (getDraftId()) {
    if (payload?.form) confirmLocalDraftRestore(payload);
    return;
  }

  if (serverArticleDraft.value) {
    Modal.confirm({
      title: '恢复未发布草稿',
      content: '检测到该文章存在服务端未发布草稿，是否恢复到当前编辑区？',
      okText: '恢复草稿',
      cancelText: payload?.form ? '查看本地草稿' : '忽略',
      onOk: () => applyDraft(serverArticleDraft.value!),
      onCancel: () => {
        if (payload?.form) confirmLocalDraftRestore(payload);
      }
    });
    return;
  }

  if (payload?.form) confirmLocalDraftRestore(payload);
}

function confirmLocalDraftRestore(payload: ArticleDraftPayload) {
  Modal.confirm({
    title: '恢复本地草稿',
    content: '检测到本地保存的草稿，是否恢复到当前编辑区？',
    okText: '恢复',
    cancelText: '忽略',
    onOk: () => {
      releaseLocalImages();
      Object.assign(formModel, payload.form);
      pendingCoverImage.value = null;
      recordInitialImages();
    }
  });
}

async function handleSaveDraft() {
  const beforePrepareForm = snapshotForm();
  showProcessing('正在保存草稿');
  draftSaving.value = true;
  try {
    const imagesReady = await prepareImagesBeforeSave();
    if (!imagesReady) {
      await cleanupCurrentAttemptUploads();
      Object.assign(formModel, beforePrepareForm);
      hideProcessing(0);
      return;
    }

    processingState.phase = 'saving';
    processingState.title = '正在保存草稿';
    const res = await saveArticleDraft(buildDraftPayload());
    if (res.success) {
      serverDraftId.value = res.data.id;
      if (props.mode === 'create' && !getDraftId()) {
        router.replace({ name: 'blog-admin_article-create', query: { draftId: res.data.id } });
      }
      clearDraft();
      uploadedImagesInCurrentAttempt = [];
      pendingCoverImage.value = null;
      releaseLocalImages();
      recordInitialImages();
      setProcessingDone('草稿保存完成');
      hideProcessing();
      message.success('草稿已保存');
      return;
    }

    await cleanupCurrentAttemptUploads();
    Object.assign(formModel, beforePrepareForm);
    writeDraft({
      form: snapshotForm(),
      savedAt: new Date().toISOString()
    });
    hideProcessing(0);
    message.warning(`${resolveServiceErrorMessage(res)}，已临时保存到本地`);
  } catch (error) {
    await cleanupCurrentAttemptUploads();
    Object.assign(formModel, beforePrepareForm);
    writeDraft({
      form: snapshotForm(),
      savedAt: new Date().toISOString()
    });
    hideProcessing(0);
    message.error(resolveServiceErrorMessage(error));
  } finally {
    draftSaving.value = false;
  }
}

async function handleSubmit() {
  try {
    await formRef.value?.validate();
  } catch {
    message.warning('请完善必填项后再保存');
    return;
  }

  const beforePrepareForm = snapshotForm();
  showProcessing(props.mode === 'create' ? '正在发布文章' : '正在保存文章');
  submitting.value = true;
  try {
    const imagesReady = await prepareImagesBeforeSave();
    if (!imagesReady) {
      await cleanupCurrentAttemptUploads();
      Object.assign(formModel, beforePrepareForm);
      hideProcessing(0);
      return;
    }

    const payload = snapshotForm();
    processingState.phase = 'saving';
    processingState.title = serverDraftId.value ? '正在发布草稿' : getSubmitProcessingTitle();
    let res: { success: boolean; data: { id: string } };
    if (serverDraftId.value) {
      const draftRes = await saveArticleDraft(buildDraftPayload());
      if (!draftRes.success) {
        await cleanupCurrentAttemptUploads();
        Object.assign(formModel, beforePrepareForm);
        hideProcessing(0);
        message.error(resolveServiceErrorMessage(draftRes));
        return;
      }
      serverDraftId.value = draftRes.data.id;
      res = await publishArticleDraft(serverDraftId.value);
    } else {
      res =
        props.mode === 'edit'
          ? await updateArticle(getArticleId(), payload as Required<ArticleFormModel>)
          : await createArticle(payload as Required<ArticleFormModel>);
    }

    if (res.success) {
      serverDraftId.value = null;
      clearDraft();
      uploadedImagesInCurrentAttempt = [];
      pendingCoverImage.value = null;
      releaseLocalImages();
      setProcessingDone('保存完成');
      message.success('保存成功');
      window.setTimeout(() => {
        processingState.visible = false;
        router.push({ name: 'blog-admin_article' });
      }, 650);
      return;
    }

    await cleanupCurrentAttemptUploads();
    Object.assign(formModel, beforePrepareForm);
    hideProcessing(0);
    message.error(resolveServiceErrorMessage(res));
  } catch (error) {
    await cleanupCurrentAttemptUploads();
    Object.assign(formModel, beforePrepareForm);
    hideProcessing(0);
    message.error(resolveServiceErrorMessage(error));
  } finally {
    submitting.value = false;
  }
}

onMounted(async () => {
  await loadOptions();
  await loadDetail();
  await loadServerDraft();
  recordInitialImages();
  restoreDraftIfNeeded();
});

onBeforeUnmount(() => {
  releaseLocalImages();
});
</script>

<template>
  <ASpace direction="vertical" :size="16" class="w-full">
    <ACard :bordered="false" :loading="loading" class="card-wrapper">
      <AForm ref="formRef" :model="formModel" :rules="rules" layout="vertical">
        <AFormItem label="标题" name="title">
          <AInput v-model:value="formModel.title" allow-clear show-count :maxlength="60" placeholder="请输入文章标题" />
        </AFormItem>
        <AFormItem label="内容" name="content">
          <MdEditor
            v-model="formModel.content"
            editor-id="adminArticleEditor"
            @on-upload-img="handleEditorUpload"
            @on-change="handleContentChange"
          />
        </AFormItem>
        <AFormItem label="封面" name="cover">
          <div class="flex flex-col items-start gap-3">
            <label class="upload-preview">
              <input type="file" accept="image/*" class="upload-input" @change="handleCoverInputChange" />
              <img
                v-if="formModel.cover"
                :key="formModel.cover"
                :src="formModel.cover"
                class="upload-image"
                alt="cover"
              />
              <span v-else class="upload-placeholder">
                <PlusOutlined class="upload-icon" />
                <span class="upload-title">上传封面</span>
              </span>
            </label>
            <ASpace wrap>
              <AButton html-type="button" @click="openImageSelector">
                <template #icon><PictureOutlined /></template>
                从正文选择
              </AButton>
              <AButton html-type="button" @click="openGallerySelector">
                <template #icon><PictureOutlined /></template>
                从 RustFS 图库选择
              </AButton>
            </ASpace>
          </div>
        </AFormItem>
        <AFormItem label="摘要" name="summary">
          <ATextarea
            v-model:value="formModel.summary"
            :rows="3"
            allow-clear
            show-count
            :maxlength="200"
            placeholder="请输入文章摘要"
          />
        </AFormItem>
        <AFormItem label="分类" name="categoryId">
          <ASelect v-model:value="formModel.categoryId" allow-clear show-search placeholder="请选择分类">
            <ASelectOption v-for="item in categories" :key="item.id" :value="item.id">{{ item.name }}</ASelectOption>
          </ASelect>
        </AFormItem>
        <AFormItem label="标签" name="tagIds">
          <ASelect v-model:value="formModel.tagIds" mode="multiple" allow-clear show-search placeholder="请选择标签">
            <ASelectOption v-for="item in tags" :key="item.id" :value="item.id">{{ item.name }}</ASelectOption>
          </ASelect>
        </AFormItem>

        <div class="editor-sticky-actions">
          <ASpace :size="12">
            <AButton html-type="button" class="min-w-[96px]" @click="goBack">取消</AButton>
            <AButton html-type="button" class="min-w-[120px]" :loading="draftSaving" @click="handleSaveDraft">
              保存草稿
            </AButton>
            <AButton
              html-type="button"
              type="primary"
              class="min-w-[120px]"
              :loading="submitting"
              @click="handleSubmit"
            >
              {{ mode === 'create' ? '发布文章' : '保存文章' }}
            </AButton>
          </ASpace>
        </div>
      </AForm>
    </ACard>

    <AModal
      v-model:open="imageSelectorVisible"
      title="从正文选择图片"
      :width="modalWidth"
      @ok="handleImageSelectConfirm"
    >
      <AEmpty v-if="contentImages.length === 0" description="正文中暂无图片" />
      <div v-else class="grid grid-cols-2 gap-3 sm:grid-cols-3">
        <button
          v-for="(img, index) in contentImages"
          :key="img"
          type="button"
          class="image-option"
          :class="{ active: selectedImageIndex === index }"
          @click="selectedImageIndex = index"
        >
          <img :src="img" alt="content image" />
        </button>
      </div>
    </AModal>

    <AModal
      v-model:open="gallerySelectorVisible"
      title="从 RustFS 图库选择封面"
      :width="galleryModalWidth"
      :confirm-loading="galleryLoading"
      @ok="handleGallerySelectConfirm"
    >
      <ASpace direction="vertical" :size="16" class="w-full">
        <AForm layout="inline" class="gallery-filter-form">
          <AFormItem label="桶">
            <ASelect
              v-model:value="galleryQuery.bucketName"
              class="gallery-bucket-select"
              placeholder="请选择桶"
              :options="galleryBuckets.map(item => ({ label: item.name, value: item.name }))"
              @change="handleGalleryBucketChange"
            />
          </AFormItem>
          <AFormItem label="名称">
            <AInput
              v-model:value="galleryQuery.fileName"
              allow-clear
              placeholder="搜索图片名称"
              @press-enter="handleGallerySearch"
            />
          </AFormItem>
          <AFormItem label="排序">
            <ASelect v-model:value="galleryQuery.sortOrder" class="gallery-sort-select" @change="handleGallerySearch">
              <ASelectOption value="lastModifiedDesc">时间倒序</ASelectOption>
              <ASelectOption value="lastModifiedAsc">时间正序</ASelectOption>
              <ASelectOption value="nameAsc">名称 A-Z</ASelectOption>
              <ASelectOption value="nameDesc">名称 Z-A</ASelectOption>
            </ASelect>
          </AFormItem>
          <AFormItem>
            <ASpace>
              <AButton type="primary" :loading="galleryLoading" @click="handleGallerySearch">搜索</AButton>
              <AButton @click="handleGalleryReset">重置</AButton>
            </ASpace>
          </AFormItem>
        </AForm>

        <ASpin :spinning="galleryLoading">
          <AEmpty v-if="!galleryImages.length" description="暂无图片" />
          <div v-else class="gallery-grid">
            <button
              v-for="image in galleryImages"
              :key="image.url"
              type="button"
              class="gallery-image-card"
              :class="{ active: selectedGalleryImageUrl === image.url }"
              @click="selectedGalleryImageUrl = image.url"
            >
              <img :src="image.url" :alt="image.fileName" />
              <span class="gallery-image-mask">
                <span class="gallery-image-name" :title="image.fileName">{{ image.fileName }}</span>
                <span class="gallery-image-meta">{{ formatImageSize(image.size) }}</span>
                <span class="gallery-image-meta">{{ image.lastModified || '-' }}</span>
              </span>
            </button>
          </div>
        </ASpin>

        <div class="flex justify-end">
          <APagination
            v-bind="galleryPagination"
            @change="(page, pageSize) => handleGalleryPageChange({ current: page, pageSize })"
            @show-size-change="(page, pageSize) => handleGalleryPageChange({ current: page, pageSize })"
          />
        </div>
      </ASpace>
    </AModal>

    <div v-if="processingState.visible" class="processing-mask">
      <div class="processing-card">
        <ASpin :spinning="processingState.phase !== 'done'" />
        <div class="mt-4 text-base font-semibold">{{ processingState.title }}</div>
        <div class="mt-2 text-sm text-base-text/65">{{ processingDescription }}</div>
        <div class="mt-4 w-full space-y-3">
          <div v-if="processingState.uploadTotal > 0">
            <div class="mb-1 flex justify-between text-xs text-base-text/60">
              <span>上传图片</span>
              <span>{{ processingState.uploadDone }}/{{ processingState.uploadTotal }}</span>
            </div>
            <AProgress :percent="uploadPercent" size="small" />
          </div>
          <div v-if="processingState.deleteTotal > 0">
            <div class="mb-1 flex justify-between text-xs text-base-text/60">
              <span>清理图片</span>
              <span>{{ processingState.deleteDone }}/{{ processingState.deleteTotal }}</span>
            </div>
            <AProgress :percent="deletePercent" size="small" status="active" />
          </div>
        </div>
      </div>
    </div>
  </ASpace>
</template>

<style scoped lang="scss">
.upload-preview {
  position: relative;
  width: 160px;
  height: 100px;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  cursor: pointer;
  border: 1px dashed rgb(var(--base-text-color) / 22%);
  border-radius: 12px;
  background: rgb(var(--base-text-color) / 4%);
}

.upload-input {
  position: absolute;
  inset: 0;
  z-index: 2;
  opacity: 0;
  cursor: pointer;
}

.upload-image {
  width: 100%;
  height: 100%;
  display: block;
  object-fit: cover;
}

.upload-placeholder {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: rgb(var(--base-text-color) / 55%);
  text-align: center;
}

.upload-icon {
  font-size: 26px;
  color: rgb(var(--base-text-color) / 45%);
}

.upload-title {
  margin-top: 8px;
  font-size: 13px;
  font-weight: 600;
}

.image-option {
  overflow: hidden;
  border: 2px solid transparent;
  border-radius: 10px;
  aspect-ratio: 16 / 9;
  background: rgb(var(--base-text-color) / 5%);
}

.image-option.active {
  border-color: rgb(var(--primary-color));
}

.image-option img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.gallery-filter-form {
  row-gap: 12px;
}

.gallery-bucket-select {
  min-width: 180px;
}

.gallery-sort-select {
  min-width: 140px;
}

.gallery-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  gap: 12px;
  max-height: min(56vh, 520px);
  overflow-y: auto;
  padding: 2px 4px 4px 2px;
}

.gallery-image-card {
  position: relative;
  overflow: hidden;
  border: 2px solid transparent;
  border-radius: 12px;
  aspect-ratio: 16 / 10;
  background: rgb(var(--base-text-color) / 5%);
  text-align: left;
  transition:
    border-color 0.2s ease,
    transform 0.2s ease,
    box-shadow 0.2s ease;
}

.gallery-image-card.active {
  border-color: rgb(var(--primary-color));
  box-shadow: 0 8px 22px rgb(var(--primary-color) / 20%);
}

.gallery-image-card:hover {
  transform: translateY(-1px);
}

.gallery-image-card img {
  width: 100%;
  height: 100%;
  display: block;
  object-fit: cover;
}

.gallery-image-mask {
  position: absolute;
  right: 0;
  bottom: 0;
  left: 0;
  display: flex;
  flex-direction: column;
  gap: 2px;
  padding: 18px 10px 8px;
  color: #fff;
  background: linear-gradient(180deg, transparent, rgb(15 23 42 / 82%));
}

.gallery-image-name {
  overflow: hidden;
  font-size: 12px;
  font-weight: 600;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.gallery-image-meta {
  overflow: hidden;
  font-size: 11px;
  opacity: 0.82;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.editor-sticky-actions {
  position: sticky;
  bottom: 16px;
  z-index: 10;
  display: flex;
  justify-content: center;
  margin: 32px auto 16px;
  padding: 14px 24px;
  border: 1px solid rgb(var(--base-text-color) / 10%);
  border-radius: 12px;
  background: rgb(var(--container-bg-color) / 92%);
  backdrop-filter: blur(10px);
  box-shadow: 0 8px 28px rgb(15 23 42 / 10%);
}

.processing-mask {
  position: fixed;
  inset: 0;
  z-index: 2000;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgb(15 23 42 / 38%);
  backdrop-filter: blur(5px);
}

.processing-card {
  width: min(420px, calc(100vw - 32px));
  padding: 28px;
  border: 1px solid rgb(var(--base-text-color) / 10%);
  border-radius: 18px;
  background: rgb(var(--container-bg-color));
  text-align: center;
  box-shadow: 0 24px 60px rgb(15 23 42 / 22%);
}

@media (max-width: 640px) {
  .editor-sticky-actions {
    bottom: 12px;
    margin-top: 28px;
    margin-bottom: 16px;
    padding: 12px 16px;
  }
}
</style>
