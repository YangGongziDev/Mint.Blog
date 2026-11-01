<template>
  <ASpace direction="vertical" :size="16" class="w-full">
    <AAlert v-if="authStore.isReadonly" type="warning" show-icon message="当前为访客或演示账号，仅支持查看和预览" description="保存草稿、发布和保存文章功能已禁用。" />
    <ACard :bordered="false" :loading="loading" class="card-wrapper">
      <AForm ref="formRef" :model="formModel" :rules="rules" layout="vertical" :disabled="initializing || submitting || draftSaving">
        <AFormItem label="标题" name="title"><AInput v-model:value="formModel.title" allow-clear show-count :maxlength="60" placeholder="请输入文章标题" /></AFormItem>
        <AFormItem label="内容" name="content"><MdEditor v-model="formModel.content" editor-id="adminArticleEditor" @on-upload-img="handleEditorUpload" @on-change="handleContentChange" /></AFormItem>
        <AFormItem label="摘要" name="summary"><ATextarea v-model:value="formModel.summary" :rows="3" allow-clear show-count :maxlength="160" placeholder="请输入文章摘要" /></AFormItem>
        <AFormItem label="仅专栏可见"><div class="flex items-center gap-3"><ASwitch :checked="formModel.visibility === 2" @change="checked => (formModel.visibility = checked ? 2 : 1)" /><span class="text-color-2">开启后，文章仅在所属专栏中展示；当前无需选择专栏。</span></div></AFormItem>
        <AAlert v-if="legacyDraft" type="warning" show-icon class="mb-4" message="旧草稿需要明确选择与确认">
          <template #description><p>全部旧选择（包含原分类与失效 ID）：</p><pre class="whitespace-pre-wrap break-all">{{ JSON.stringify({ tagIds: legacyDraft.form.tagIds, tagVersions: legacyDraft.form.tagVersions, categoryId: legacyDraft.form.categoryId }, null, 2) }}</pre><p>旧未限定不等于新通用。多标签或多版本请明确保留一个，或导出后拆分；原本无标签且无版本的草稿可确认保留未选状态。</p><p v-if="legacyCategoryConflict">旧分类与当前标签分类冲突，请确认采用标签实际分类。</p><AButton :disabled="authStore.isReadonly || submitting || draftSaving" @click="confirmLegacySelection">{{ legacyConfirmed ? '已确认当前选择' : '确认采用当前选择' }}</AButton></template>
        </AAlert>
        <AButton v-if="legacyBackupRaw" class="mb-4" @click="exportLegacyDraft">导出原始草稿备份</AButton>
        <AFormItem label="技术标签" name="tagId"><ASelect :value="formModel.tagId ?? undefined" allow-clear show-search placeholder="请选择一个标签" :disabled="authStore.isReadonly || initializing || submitting || draftSaving" :options="sortedTags.map(item => ({ label: item.name, value: item.id }))" :filter-option="filterTagOption" @change="changeTag" /></AFormItem>
        <AAlert v-if="initializationError" type="error" show-icon class="mb-4" message="文章或标签加载失败，已禁止保存，请刷新重试。" />
        <AFormItem label="技术版本" name="tagVersionId">
          <ASelect :value="formModel.tagVersionId ?? undefined" show-search class="w-full" :options="versionOptions" :filter-option="filterTagOption" :loading="versionStatus === 'loading'" :disabled="authStore.isReadonly || submitting || draftSaving || versionStatus !== 'ready'" placeholder="请选择一个真实版本" @change="value => { formModel.tagVersionId = String(value); legacyConfirmed = false; }" />
          <AAlert v-if="versionStatus === 'error'" class="mt-2" type="error" show-icon :message="versionError || '版本加载失败，已保留原值并禁止提交' "><template #action><AButton @click="loadTagVersionOptions()">重试</AButton></template></AAlert>
          <AAlert v-if="formModel.tagId && versionStatus === 'ready' && !selectionValid" class="mt-2" type="warning" message="标签、分类或原版本失效，或尚未选择版本。请明确选择有效归属，原值不会自动重置。" />
        </AFormItem>
        <AFormItem label="分类（由标签派生）"><AInput :value="derivedCategory?.name ?? (formModel.tagId ? '标签或分类已失效，请修复' : '选择标签后显示')" readonly /></AFormItem>
        <AFormItem label="封面" name="cover">
          <div class="flex flex-col items-start gap-3">
            <label class="upload-preview"><input type="file" accept="image/*" class="upload-input" :disabled="initializing || submitting || draftSaving" @change="handleCoverInputChange" /><img v-if="formModel.cover" :key="formModel.cover" :src="formModel.cover" class="upload-image" alt="cover" /><span v-else class="upload-placeholder"><PlusOutlined class="upload-icon" /><span class="upload-title">上传封面</span></span></label>
            <ASpace wrap><AButton html-type="button" @click="openImageSelector"><template #icon><PictureOutlined /></template>从正文选择</AButton><AButton html-type="button" @click="gallerySelectorVisible = true"><template #icon><PictureOutlined /></template>从 RustFS 图库选择</AButton><AButton html-type="button" :disabled="!selectedTag?.logoUrl" @click="selectedTag?.logoUrl && handleGallerySelect(selectedTag.logoUrl)"><template #icon><PictureOutlined /></template>使用标签 Logo</AButton></ASpace>
          </div>
        </AFormItem>
        <div class="editor-sticky-actions"><div class="flex flex-wrap items-center justify-center gap-3"><AButton html-type="button" class="min-w-[96px]" @click="goBack">取消</AButton><AButton html-type="button" class="min-w-[120px]" :loading="draftSaving" :disabled="authStore.isReadonly || versionSaveBlocked || submitting" @click="handleSaveDraft">保存草稿</AButton><AButton html-type="button" type="primary" class="min-w-[120px]" :loading="submitting" :disabled="authStore.isReadonly || versionSaveBlocked || !selectionValid || draftSaving" @click="handleSubmit">{{ mode === 'create' ? '发布文章' : '保存文章' }}</AButton></div></div>
      </AForm>
    </ACard>
    <AModal v-model:open="imageSelectorVisible" title="从正文选择图片" :width="modalWidth" @ok="handleImageSelectConfirm"><AEmpty v-if="contentImages.length === 0" description="正文中暂无图片" /><div v-else class="grid grid-cols-2 gap-3 sm:grid-cols-3"><button v-for="(img, index) in contentImages" :key="img" type="button" class="image-option" :class="{ active: selectedImageIndex === index }" @click="selectedImageIndex = index"><img :src="img" alt="content image" /></button></div></AModal>
    <RustfsImageSelector v-model:open="gallerySelectorVisible" :selected-url="formModel.cover" @select="handleGallerySelect" />
    <div v-if="processingState.visible" class="processing-mask"><div class="processing-card"><ASpin :spinning="processingState.phase !== 'done'" /><div class="mt-4 text-base font-semibold">{{ processingState.title }}</div><div class="mt-2 text-sm text-base-text/65">{{ processingDescription }}</div><div class="mt-4 w-full space-y-3"><div v-if="processingState.uploadTotal > 0"><div class="mb-1 flex justify-between text-xs text-base-text/60"><span>上传图片</span><span>{{ processingState.uploadDone }}/{{ processingState.uploadTotal }}</span></div><AProgress :percent="uploadPercent" size="small" /></div><div v-if="processingState.deleteTotal > 0"><div class="mb-1 flex justify-between text-xs text-base-text/60"><span>清理图片</span><span>{{ processingState.deleteDone }}/{{ processingState.deleteTotal }}</span></div><AProgress :percent="deletePercent" size="small" status="active" /></div></div></div></div>
  </ASpace>
</template>

<script setup lang="ts">
import { computed, onBeforeUnmount, reactive, ref, watch } from 'vue';
import { onBeforeRouteLeave, onBeforeRouteUpdate, useRoute, useRouter } from 'vue-router';
import type { FormInstance, FormProps, SelectProps } from 'ant-design-vue';
import { Modal, message } from 'ant-design-vue';
import { PictureOutlined, PlusOutlined } from '@ant-design/icons-vue';
import { MdEditor, config as mdEditorConfig } from 'md-editor-v3';
import type { CodeMirrorExtension } from 'md-editor-v3';
import 'md-editor-v3/lib/style.css';
import { type ArticleDraftDetail, type ArticleFormModel, type SaveArticleDraftPayload, createArticle, getArticleDetail, getArticleDraftByArticleId, getArticleDraftDetail, publishArticleDraft, saveArticleDraft, updateArticle } from '@/api/blog/article';
import { type TagVersion, getTagVersions } from '@/api/blog/resource';
import { type CategoryListItem, getCategoryList } from '@/api/blog/category';
import { type TagListItem, getTagList } from '@/api/blog/tag';
import { deleteBlogImages, uploadBlogImage } from '@/api/blog/image';
import { useAppStore } from '@/store/system/app';
import { READONLY_ACTION_MESSAGE, useAuthStore } from '@/store/system/auth';
import { sortOptionsByLabel } from '@/utils/common';
import { resolveServiceErrorMessage } from '@/utils/service-error';
import RustfsImageSelector from './rustfs-image-selector.vue';

mdEditorConfig({ codeMirrorExtensions(extensions: CodeMirrorExtension[]) {
  return extensions.map(extension => extension.type !== 'linkShortener' ? extension : { ...extension, options: { ...extension.options, maxLength: Number.MAX_SAFE_INTEGER } });
} });
const ARTICLE_DRAFT_PREFIX = 'mint-blog-article-draft:';
defineOptions({ name: 'ArticleEditor' });
interface ArticleDraftPayload { storageVersion: 2; form: ArticleFormModel; savedAt: string }
interface LegacyDraftPayload {
  storageVersion?: undefined;
  form: Omit<ArticleFormModel, 'tagId' | 'tagVersionId'> & { tagIds?: string[]; tagVersions?: { tagId: string; versionIds: string[] }[]; categoryId?: string };
  savedAt: string;
}
type ProcessingPhase = 'uploading' | 'deleting' | 'saving' | 'done';
const props = defineProps<{ mode: 'create' | 'edit' }>();
const router = useRouter();
const route = useRoute();
const appStore = useAppStore();
const authStore = useAuthStore();
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
const contentImages = ref<string[]>([]);
const selectedImageIndex = ref(-1);
const serverDraftId = ref<string | null>(null);
const serverArticleDraft = ref<ArticleDraftDetail | null>(null);
const localImageFiles = new Map<string, File>();
let uploadedImagesInCurrentAttempt: string[] = [];
let initialImageUrls = new Set<string>();
const processingState = reactive({ visible: false, phase: 'uploading' as ProcessingPhase, title: '', uploadTotal: 0, uploadDone: 0, deleteTotal: 0, deleteDone: 0 });
const emptyForm = (): ArticleFormModel => ({ title: '', summary: '', content: '', cover: '', tagId: null, tagVersionId: null, visibility: 1 });
const formModel = reactive<ArticleFormModel>(emptyForm());
const initializing = ref(true);
const initializationError = ref(false);
const versions = ref<TagVersion[]>([]);
const versionStatus = ref<'idle' | 'loading' | 'ready' | 'error'>('idle');
const versionError = ref('');
let versionRequest = 0;
let initializationRequest = 0;
let disposed = false;
const legacyDraft = ref<LegacyDraftPayload | null>(null);
const legacyConfirmed = ref(false);
const legacyBackupRaw = ref('');
const selectedTag = computed(() => tags.value.find(tag => tag.id === formModel.tagId));
const derivedCategory = computed(() => categories.value.find(category => category.id === selectedTag.value?.categoryId));
const legacyCategoryConflict = computed(() => Boolean(legacyDraft.value?.form.categoryId && legacyDraft.value.form.categoryId !== selectedTag.value?.categoryId));
const validId = (id: unknown): id is string => typeof id === 'string' && /^[1-9]\d*$/.test(id) && BigInt(id) <= 9223372036854775807n;
const selectionValid = computed(() => validId(formModel.tagId) && validId(formModel.tagVersionId) && Boolean(selectedTag.value && derivedCategory.value && validId(derivedCategory.value.id)) && versionStatus.value === 'ready' && versions.value.some(version => version.id === formModel.tagVersionId && version.tagId === formModel.tagId));
const versionSaveBlocked = computed(() => initializing.value || initializationError.value || Boolean(legacyDraft.value && !legacyConfirmed.value) || (formModel.tagId === null && formModel.tagVersionId === null ? false : !selectionValid.value));
const versionOptions = computed(() => {
  const options = versions.value.map(version => ({ label: `${version.name}${version.isGeneral === true ? '（通用）' : ''}`, value: version.id, disabled: false }));
  if (formModel.tagVersionId && !options.some(option => option.value === formModel.tagVersionId)) options.push({ label: `原版本（${formModel.tagVersionId}，待验证或已失效）`, value: formModel.tagVersionId, disabled: true });
  return sortOptionsByLabel(options, option => option.label);
});
async function loadTagVersionOptions(selectGeneral = false) {
  const tagId = formModel.tagId;
  const request = ++versionRequest;
  versions.value = [];
  versionError.value = '';
  versionStatus.value = tagId ? 'loading' : 'idle';
  if (!tagId) return;
  try {
    if (!validId(tagId)) throw new Error('标签 ID 无效，请明确选择有效标签');
    const res = await getTagVersions(tagId);
    if (request !== versionRequest || tagId !== formModel.tagId || disposed) return;
    if (!res.success) throw new Error(resolveServiceErrorMessage(res));
    if (res.data.some(version => !validId(version.id) || version.tagId !== tagId)) throw new Error('版本归属或 ID 异常，请管理员修复');
    const general = res.data.filter(version => version.isGeneral === true);
    if (general.length !== 1) throw new Error('该标签必须有且仅有一个真实通用版本，请管理员修复');
    versions.value = res.data;
    versionStatus.value = 'ready';
    if (selectGeneral) formModel.tagVersionId = general[0].id;
  } catch (error) {
    if (request !== versionRequest || tagId !== formModel.tagId || disposed) return;
    versionStatus.value = 'error';
    versionError.value = resolveServiceErrorMessage(error);
  }
}
function changeTag(value: unknown) {
  formModel.tagId = typeof value === 'string' ? value : null;
  formModel.tagVersionId = null;
  legacyConfirmed.value = false;
  void loadTagVersionOptions(true);
}
function ensureVersionsReady() {
  if (!versionSaveBlocked.value) return true;
  message.warning('请完成标签、分类和版本校验；旧草稿须明确确认选择后再保存');
  return false;
}
const modalWidth = computed(() => appStore.isMobile ? '92vw' : 680);
const sortedTags = computed(() => sortOptionsByLabel(tags.value, tag => tag.name));
const uploadPercent = computed(() => processingState.uploadTotal ? Math.round(processingState.uploadDone / processingState.uploadTotal * 100) : 0);
const deletePercent = computed(() => processingState.deleteTotal ? Math.round(processingState.deleteDone / processingState.deleteTotal * 100) : 0);
const processingDescription = computed(() => {
  if (processingState.phase === 'uploading') return `还有 ${processingState.uploadTotal - processingState.uploadDone} 张图片上传中`;
  if (processingState.phase === 'deleting') return `还有 ${processingState.deleteTotal - processingState.deleteDone} 张图片等待清理`;
  if (processingState.phase === 'saving') return '图片处理完成，正在保存文章数据';
  return '处理完成，即将返回列表';
});
const rules: FormProps['rules'] = {
  title: [{ required: true, message: '请输入文章标题', trigger: 'blur' }],
  content: [{ required: true, message: '请输入文章内容', trigger: 'change' }],
  cover: [{ required: true, message: '请上传或选择封面', trigger: 'change' }],
  summary: [{ required: true, message: '请输入文章摘要', trigger: 'blur' }, { max: 160, message: '文章摘要不能超过160个字符', trigger: 'blur' }],
  tagId: [{ required: true, message: '请选择标签', trigger: 'change' }],
  tagVersionId: [{ required: true, message: '请选择版本', trigger: 'change' }]
};
function filterTagOption(inputValue: string, option?: NonNullable<SelectProps['options']>[number]) { return String(option?.label || '').toLowerCase().includes(inputValue.trim().toLowerCase()); }
function getDraftStorageKey() { return props.mode === 'edit' ? `blogArticleDraftEdit_${getArticleId()}` : 'blogArticleDraftCreate'; }
function getArticleId() { return route.params.id as string; }
function getDraftId() { const id = route.query.draftId; return validId(id) ? id : null; }
function goBack() { router.push({ name: 'blog_article' }); }
function isLocalImageUrl(url: string) { return url.startsWith('blob:') && localImageFiles.has(url); }
function releaseLocalImages() { for (const url of localImageFiles.keys()) URL.revokeObjectURL(url); localImageFiles.clear(); }
function getCurrentImageSet() { return new Set([...extractImages(formModel.content), formModel.cover].filter(Boolean)); }
function recordInitialImages() { initialImageUrls = getCurrentImageSet(); }
function getRemovedInitialImagesCount() { const current = getCurrentImageSet(); return [...initialImageUrls].filter(url => !current.has(url)).length; }
function showProcessing(title: string) { Object.assign(processingState, { visible: true, phase: 'uploading', title, uploadTotal: 0, uploadDone: 0, deleteTotal: 0, deleteDone: 0 }); }
function setProcessingDone(title = '处理完成') { processingState.phase = 'done'; processingState.title = title; }
function hideProcessing(delay = 600) { const generation = initializationRequest; window.setTimeout(() => { if (!disposed && generation === initializationRequest) processingState.visible = false; }, delay); }
function replaceAllText(value: string, replacements: Map<string, string>) { let result = value; for (const [oldValue, newValue] of replacements) result = result.split(oldValue).join(newValue); return result; }
function getImageFileExtension(file: File) {
  const extension = file.name.match(/\.[^./\\]+$/)?.[0];
  if (extension) return extension.toLowerCase();
  const types: Record<string, string> = { 'image/jpeg': '.jpg', 'image/png': '.png', 'image/gif': '.gif', 'image/webp': '.webp', 'image/svg+xml': '.svg' };
  return types[file.type] || '.png';
}
function createUniqueImageFileName(file: File) {
  const extension = getImageFileExtension(file);
  const base = (file.name.replace(/\.[^./\\]+$/, '').trim() || 'image').replace(/[^\p{L}\p{N}_-]+/gu, '-').replace(/^-+|-+$/g, '') || 'image';
  return `${base}-${crypto.randomUUID?.() || `${Date.now()}-${Math.random().toString(36).slice(2, 10)}`}${extension}`;
}
async function uploadLocalContentImages() {
  const urls = new Set(extractImages(formModel.content).filter(isLocalImageUrl));
  if (isLocalImageUrl(formModel.cover)) urls.add(formModel.cover);
  processingState.phase = 'uploading'; processingState.uploadTotal = urls.size + (pendingCoverImage.value ? 1 : 0); processingState.uploadDone = 0;
  const replacements = new Map<string, string>();
  const entries = [...urls].map(localUrl => ({ localUrl, file: localImageFiles.get(localUrl) })).filter((item): item is { localUrl: string; file: File } => Boolean(item.file));
  const results = await Promise.allSettled(entries.map(async ({ localUrl, file }) => {
    const res = await uploadBlogImage({ newImageFile: file, newImageOriginalName: createUniqueImageFileName(file) });
    if (!res.success) throw new Error('正文图片上传失败');
    uploadedImagesInCurrentAttempt.push(res.data.url);
    replacements.set(localUrl, res.data.url);
    processingState.uploadDone += 1;
  }));
  if (results.some(result => result.status === 'rejected')) { message.error('正文图片上传失败，请重试'); return false; }
  formModel.content = replaceAllText(formModel.content, replacements);
  if (replacements.has(formModel.cover)) formModel.cover = replacements.get(formModel.cover)!;
  return true;
}
async function prepareImagesBeforeSave() {
  uploadedImagesInCurrentAttempt = [];
  if (!await uploadLocalContentImages() || !await uploadPendingCover()) return false;
  processingState.phase = 'deleting'; processingState.deleteTotal = getRemovedInitialImagesCount(); processingState.deleteDone = 0;
  await Promise.resolve(); processingState.deleteDone = processingState.deleteTotal; return true;
}
async function cleanupCurrentAttemptUploads() {
  if (!uploadedImagesInCurrentAttempt.length) return;
  await deleteBlogImages([...uploadedImagesInCurrentAttempt]).catch(() => undefined); uploadedImagesInCurrentAttempt = [];
}
function snapshotForm(): ArticleFormModel {
  return { title: formModel.title, summary: formModel.summary, content: formModel.content, cover: formModel.cover, tagId: formModel.tagId, tagVersionId: formModel.tagVersionId, visibility: formModel.visibility };
}
function buildDraftPayload(): SaveArticleDraftPayload {
  const form = snapshotForm();
  if (form.tagId === null && form.tagVersionId === null) return { ...form, tagId: null, tagVersionId: null, draftId: serverDraftId.value, articleId: props.mode === 'edit' ? getArticleId() : null };
  if (!selectionValid.value || !form.tagId || !form.tagVersionId) throw new Error('标签和版本必须成对且有效');
  return { ...form, tagId: form.tagId, tagVersionId: form.tagVersionId, draftId: serverDraftId.value, articleId: props.mode === 'edit' ? getArticleId() : null };
}
function applyForm(form: ArticleFormModel) {
  releaseLocalImages();
  Object.assign(formModel, { title: form.title, summary: form.summary, content: form.content, cover: form.cover, tagId: form.tagId, tagVersionId: form.tagVersionId, visibility: form.visibility });
  pendingCoverImage.value = null;
  void loadTagVersionOptions();
  recordInitialImages();
}
function applyDraft(draft: ArticleDraftDetail) { applyForm(draft); serverDraftId.value = draft.id; }
function backupRawDraft(raw: string) {
  legacyBackupRaw.value = raw;
  const key = `${ARTICLE_DRAFT_PREFIX}${getDraftStorageKey()}:backup:${Date.now()}:${crypto.randomUUID()}`;
  localStorage.setItem(key, raw);
}
function readDraft(): ArticleDraftPayload | LegacyDraftPayload | null {
  try {
    const raw = localStorage.getItem(`${ARTICLE_DRAFT_PREFIX}${getDraftStorageKey()}`);
    if (!raw) return null;
    legacyBackupRaw.value = raw;
    const payload = JSON.parse(raw);
    if (payload.storageVersion !== 2) backupRawDraft(raw);
    if (!payload.form || (payload.storageVersion !== undefined && payload.storageVersion !== 2)) throw new Error('未知草稿格式');
    if (payload.storageVersion === undefined && ((payload.form.tagIds !== undefined && !Array.isArray(payload.form.tagIds)) || (payload.form.tagVersions !== undefined && (!Array.isArray(payload.form.tagVersions) || payload.form.tagVersions.some((item: { versionIds?: unknown }) => !item || !Array.isArray(item.versionIds)))))) throw new Error('旧草稿选择格式无效');
    return payload;
  } catch { message.warning('本地草稿无法读取、解析或备份，原始内容已保留，可导出后人工修复'); return null; }
}
function writeDraft() {
  const key = `${ARTICLE_DRAFT_PREFIX}${getDraftStorageKey()}`;
  const old = localStorage.getItem(key);
  if (old) backupRawDraft(old);
  const payload: ArticleDraftPayload = { storageVersion: 2, form: snapshotForm(), savedAt: new Date().toISOString() };
  localStorage.setItem(key, JSON.stringify(payload));
}
function clearDraft() {
  try {
    const key = `${ARTICLE_DRAFT_PREFIX}${getDraftStorageKey()}`;
    const old = localStorage.getItem(key);
    if (old) backupRawDraft(old);
    localStorage.removeItem(key);
  } catch { message.warning('服务端已保存；本地草稿未能清理，原始内容仍保留'); }
}
function exportLegacyDraft() {
  const url = URL.createObjectURL(new Blob([legacyBackupRaw.value], { type: 'application/json' }));
  const link = document.createElement('a'); link.href = url; link.download = `article-draft-backup-${Date.now()}.json`; link.click(); URL.revokeObjectURL(url);
}
function legacySelectionValid() {
  const legacy = legacyDraft.value;
  const originallyEmpty = legacy && !(legacy.form.tagIds?.length) && !(legacy.form.tagVersions?.length);
  return selectionValid.value || Boolean(originallyEmpty && formModel.tagId === null && formModel.tagVersionId === null);
}
function confirmLegacySelection() {
  if (!legacySelectionValid()) { message.warning('旧草稿含标签或版本选择，请明确选择一个有效标签和版本，或导出后拆分'); return; }
  const tagId = formModel.tagId; const versionId = formModel.tagVersionId; const generation = initializationRequest;
  Modal.confirm({ title: '确认旧草稿转换', content: `旧“未限定”不等于新通用，通用仅归属真实通用版本。${legacyCategoryConflict.value ? '旧独立分类与当前标签分类冲突，将采用标签的实际分类。' : ''}确认采用当前选择？原始备份将保留。`, onOk: () => {
    if (disposed || generation !== initializationRequest || tagId !== formModel.tagId || versionId !== formModel.tagVersionId || !legacySelectionValid()) return;
    legacyConfirmed.value = true;
  } });
}
function previewImage(file: File) { const generation = initializationRequest; const reader = new FileReader(); reader.onload = event => { if (!disposed && generation === initializationRequest && pendingCoverImage.value === file && event.target?.result) { formModel.cover = event.target.result as string; formRef.value?.validateFields(['cover']).catch(() => undefined); } }; reader.readAsDataURL(file); }
function handleCoverInputChange(event: Event) { const input = event.target as HTMLInputElement; const file = input.files?.[0]; if (file) { pendingCoverImage.value = file; previewImage(file); } input.value = ''; }
function handleContentChange() { formRef.value?.validateFields(['content']).catch(() => undefined); }
async function uploadPendingCover() {
  if (!pendingCoverImage.value) return true;
  const res = await uploadBlogImage({ newImageFile: pendingCoverImage.value, newImageOriginalName: createUniqueImageFileName(pendingCoverImage.value), oldImageName: originalCoverUrl.value });
  if (!res.success) { message.error('封面上传失败，请重试'); return false; }
  formModel.cover = res.data.url; uploadedImagesInCurrentAttempt.push(res.data.url); processingState.uploadDone += 1; return true;
}
async function handleEditorUpload(files: File[], callback: (urls: string[]) => void) { callback(files.map(file => { const url = URL.createObjectURL(file); localImageFiles.set(url, file); return url; })); }
function extractImages(markdown: string) { const urls: string[] = []; const regex = /!\[[^\]]*]\(([^)]+)\)/g; let match: RegExpExecArray | null; while ((match = regex.exec(markdown))) urls.push(match[1]); return urls; }
function openImageSelector() { contentImages.value = extractImages(formModel.content); if (!contentImages.value.length) { message.warning('正文中暂无图片'); return; } selectedImageIndex.value = -1; imageSelectorVisible.value = true; }
function handleImageSelectConfirm() { if (selectedImageIndex.value < 0) { message.warning('请选择一张图片'); return; } formModel.cover = contentImages.value[selectedImageIndex.value]; pendingCoverImage.value = null; imageSelectorVisible.value = false; formRef.value?.validateFields(['cover']).catch(() => undefined); }
function handleGallerySelect(url: string) { formModel.cover = url; pendingCoverImage.value = null; formRef.value?.validateFields(['cover']).catch(() => undefined); }
function restoreDraftIfNeeded(generation: number) {
  const payload = readDraft();
  if (getDraftId()) { if (payload?.form) confirmLocalDraftRestore(payload, generation); return; }
  const draft = serverArticleDraft.value;
  if (draft) {
    Modal.confirm({ title: '恢复未发布草稿', content: '检测到服务端未发布草稿，是否恢复到当前编辑区？', okText: '恢复草稿', cancelText: payload?.form ? '查看本地草稿' : '忽略', onOk: () => { if (!disposed && generation === initializationRequest) applyDraft(draft); }, onCancel: () => { if (!disposed && generation === initializationRequest && payload?.form) confirmLocalDraftRestore(payload, generation); } }); return;
  }
  if (payload?.form) confirmLocalDraftRestore(payload, generation);
}
function confirmLocalDraftRestore(payload: ArticleDraftPayload | LegacyDraftPayload, generation: number) {
  Modal.confirm({ title: '恢复本地草稿', content: payload.storageVersion === 2 ? '是否恢复本地草稿？' : '旧草稿原始内容已备份。恢复后须检查全部旧选择并明确确认单标签单版本，才可保存。', okText: '恢复', cancelText: '忽略', onOk: () => {
    if (disposed || generation !== initializationRequest) return;
    if (payload.storageVersion === 2) { applyForm(payload.form); return; }
    legacyDraft.value = payload; legacyConfirmed.value = false;
    const ids = payload.form.tagIds ?? [];
    const selections = payload.form.tagVersions ?? [];
    const pair = ids.length === 1 && selections.length === 1 && selections[0].tagId === ids[0] && selections[0].versionIds.length === 1;
    applyForm({ title: payload.form.title, summary: payload.form.summary, content: payload.form.content, cover: payload.form.cover, visibility: payload.form.visibility, tagId: ids.length === 1 ? ids[0] : null, tagVersionId: pair ? selections[0].versionIds[0] : null });
  } });
}
async function handleSaveDraft() {
  if (draftSaving.value || submitting.value) return;
  if (authStore.isReadonly) { message.warning(READONLY_ACTION_MESSAGE); return; }
  if (!ensureVersionsReady()) return;
  const before = snapshotForm(); showProcessing('正在保存草稿'); draftSaving.value = true;
  try {
    if (!await prepareImagesBeforeSave()) { await cleanupCurrentAttemptUploads(); Object.assign(formModel, before); hideProcessing(0); return; }
    processingState.phase = 'saving'; processingState.title = '正在保存草稿';
    const res = await saveArticleDraft(buildDraftPayload());
    if (!res.success) throw new Error(resolveServiceErrorMessage(res));
    serverDraftId.value = res.data.id;
    uploadedImagesInCurrentAttempt = []; pendingCoverImage.value = null; releaseLocalImages(); recordInitialImages(); clearDraft();
    if (props.mode === 'create' && !getDraftId()) {
      try {
        const failure = await router.replace({ name: 'blog_article-create', query: { draftId: res.data.id } });
        if (failure) message.warning('草稿已保存，页面地址未更新，可从草稿箱重新打开');
      } catch { message.warning('草稿已保存，页面地址未更新，可从草稿箱重新打开'); }
    }
    setProcessingDone('草稿保存完成'); hideProcessing(); message.success('草稿已保存');
  } catch (error) {
    await cleanupCurrentAttemptUploads(); Object.assign(formModel, before);
    try { writeDraft(); } catch { message.warning('本地存储失败，请导出或复制正文保留'); }
    hideProcessing(0); message.error(resolveServiceErrorMessage(error));
  } finally { draftSaving.value = false; }
}
async function handleSubmit() {
  if (draftSaving.value || submitting.value) return;
  if (authStore.isReadonly) { message.warning(READONLY_ACTION_MESSAGE); return; }
  if (!ensureVersionsReady() || !selectionValid.value) { message.warning('正式文章必须选择一个有效标签和版本'); return; }
  submitting.value = true;
  try { await formRef.value?.validate(); } catch { submitting.value = false; message.warning('请完善必填项后再保存'); return; }
  const before = snapshotForm(); showProcessing(props.mode === 'create' ? '正在发布文章' : '正在保存文章');
  let draftSaved = false;
  try {
    if (!await prepareImagesBeforeSave()) { await cleanupCurrentAttemptUploads(); Object.assign(formModel, before); hideProcessing(0); return; }
    const payload = { ...snapshotForm(), tagId: formModel.tagId!, tagVersionId: formModel.tagVersionId! };
    processingState.phase = 'saving'; processingState.title = serverDraftId.value ? '正在发布草稿' : '正在保存文章';
    let res: { success: boolean; data: { id: string } };
    if (serverDraftId.value) {
      const draftRes = await saveArticleDraft(buildDraftPayload());
      if (!draftRes.success) throw new Error(resolveServiceErrorMessage(draftRes));
      serverDraftId.value = draftRes.data.id; draftSaved = true; uploadedImagesInCurrentAttempt = [];
      res = await publishArticleDraft(serverDraftId.value);
    } else res = props.mode === 'edit' ? await updateArticle(getArticleId(), payload) : await createArticle(payload);
    if (!res.success) throw new Error(resolveServiceErrorMessage(res));
    serverDraftId.value = null; uploadedImagesInCurrentAttempt = []; pendingCoverImage.value = null; releaseLocalImages(); clearDraft();
    setProcessingDone('保存完成'); message.success('保存成功');
    const generation = initializationRequest;
    window.setTimeout(() => { if (!disposed && generation === initializationRequest) { processingState.visible = false; router.push({ name: 'blog_article' }); } }, 650);
  } catch (error) {
    if (!draftSaved) { await cleanupCurrentAttemptUploads(); Object.assign(formModel, before); }
    else { pendingCoverImage.value = null; recordInitialImages(); }
    hideProcessing(0); message.error(resolveServiceErrorMessage(error));
  } finally { submitting.value = false; }
}
async function initialize() {
  const generation = ++initializationRequest;
  const articleId = getArticleId(); const draftId = getDraftId();
  const current = () => !disposed && generation === initializationRequest;
  initializing.value = true; loading.value = true; initializationError.value = false;
  processingState.visible = false; imageSelectorVisible.value = false; gallerySelectorVisible.value = false;
  ++versionRequest; versions.value = []; versionStatus.value = 'idle';
  releaseLocalImages(); Object.assign(formModel, emptyForm()); pendingCoverImage.value = null; originalCoverUrl.value = '';
  serverDraftId.value = null; serverArticleDraft.value = null; legacyDraft.value = null; legacyConfirmed.value = false; legacyBackupRaw.value = '';
  try {
    if (route.query.draftId !== undefined && !draftId) throw new Error('草稿 ID 无效');
    const [categoryRes, tagRes] = await Promise.all([getCategoryList(), getTagList()]);
    if (!current()) return;
    if (!categoryRes.success || !tagRes.success) throw new Error('文章选项加载失败');
    categories.value = categoryRes.data.filter(item => item.isDeleted !== true && item.isDeleted !== 1);
    tags.value = tagRes.data.filter(item => item.isDeleted !== true && item.isDeleted !== 1);
    if (props.mode === 'edit') {
      if (!validId(articleId)) throw new Error('文章 ID 无效');
      const res = await getArticleDetail(articleId);
      if (!current()) return;
      if (!res.success) throw new Error('文章详情加载失败');
      applyForm(res.data); originalCoverUrl.value = res.data.cover;
    }
    if (draftId) {
      const res = await getArticleDraftDetail(draftId);
      if (!current()) return;
      if (!res.success || (props.mode === 'edit' && res.data.articleId !== articleId)) throw new Error('文章草稿加载失败或归属不匹配');
      serverArticleDraft.value = res.data; applyDraft(res.data);
    } else if (props.mode === 'edit') {
      const res = await getArticleDraftByArticleId(articleId);
      if (!current()) return;
      if (!res.success) throw new Error('文章草稿加载失败');
      if (res.data) serverArticleDraft.value = res.data;
    }
    recordInitialImages(); restoreDraftIfNeeded(generation);
  } catch { if (current()) initializationError.value = true; }
  finally { if (current()) { initializing.value = false; loading.value = false; } }
}
watch(() => [props.mode, route.params.id, route.query.draftId], (next, previous) => {
  if (route.name !== (props.mode === 'edit' ? 'blog_article-edit' : 'blog_article-create')) return;
  if (previous && next[0] === previous[0] && next[1] === previous[1] && next[2] === serverDraftId.value && draftSaving.value) return;
  void initialize();
}, { immediate: true, flush: 'sync' });
onBeforeRouteLeave(() => !(submitting.value || draftSaving.value));
onBeforeRouteUpdate(to => {
  if (!submitting.value && !draftSaving.value) return true;
  return draftSaving.value && to.params.id === route.params.id && to.query.draftId === serverDraftId.value;
});
onBeforeUnmount(() => { disposed = true; ++initializationRequest; ++versionRequest; releaseLocalImages(); });
</script>

<style scoped lang="scss">
.upload-preview { position: relative; width: 160px; height: 100px; display: flex; align-items: center; justify-content: center; overflow: hidden; cursor: pointer; border: 1px dashed rgb(var(--base-text-color) / 22%); border-radius: 12px; background: rgb(var(--base-text-color) / 4%); }
.upload-input { position: absolute; inset: 0; z-index: 2; opacity: 0; cursor: pointer; }
.upload-image { width: 100%; height: 100%; display: block; object-fit: cover; }
.upload-placeholder { width: 100%; height: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center; color: rgb(var(--base-text-color) / 55%); text-align: center; }
.upload-icon { font-size: 26px; color: rgb(var(--base-text-color) / 45%); }
.upload-title { margin-top: 8px; font-size: 13px; font-weight: 600; }
.image-option { overflow: hidden; border: 2px solid transparent; border-radius: 10px; aspect-ratio: 16 / 9; background: rgb(var(--base-text-color) / 5%); }
.image-option.active { border-color: rgb(var(--primary-color)); }
.image-option img { width: 100%; height: 100%; object-fit: cover; }
.editor-sticky-actions { position: sticky; bottom: 16px; z-index: 10; display: flex; align-items: center; justify-content: center; margin: 32px auto 16px; padding: 14px 24px; border: 1px solid rgb(var(--base-text-color) / 10%); border-radius: 12px; background: rgb(var(--container-bg-color) / 92%); backdrop-filter: blur(10px); box-shadow: 0 8px 28px rgb(15 23 42 / 10%); }
.processing-mask { position: fixed; inset: 0; z-index: 2000; display: flex; align-items: center; justify-content: center; background: rgb(15 23 42 / 38%); backdrop-filter: blur(5px); }
.processing-card { width: min(420px, calc(100vw - 32px)); padding: 28px; border: 1px solid rgb(var(--base-text-color) / 10%); border-radius: 18px; background: rgb(var(--container-bg-color)); text-align: center; box-shadow: 0 24px 60px rgb(15 23 42 / 22%); }
@media (max-width: 640px) { .editor-sticky-actions { bottom: 12px; margin-top: 28px; margin-bottom: 16px; padding: 12px 16px; } }
</style>
