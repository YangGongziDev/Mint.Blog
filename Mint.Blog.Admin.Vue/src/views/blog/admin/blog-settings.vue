<template>
  <ASpace direction="vertical" :size="16" class="w-full">

    <ACard :bordered="false" class="card-wrapper">
      <AForm
        ref="formRef"
        :model="formModel"
        :rules="rules"
        :label-col="formLabelCol"
        :wrapper-col="formWrapperCol"
        :layout="appStore.isMobile ? 'vertical' : 'horizontal'"
        class="mx-auto max-w-[960px]"
      >

        <AFormItem label="博客名称" name="name">
          <AInput v-model:value="formModel.name" allow-clear placeholder="请输入博客名称" />
        </AFormItem>
        <AFormItem label="作者名" name="author">
          <AInput v-model:value="formModel.author" allow-clear placeholder="请输入作者名" />
        </AFormItem>
        <AFormItem label="博客 LOGO" name="logo">
          <UploadPreview
            title="上传 LOGO"
            hint="建议尺寸 200x200px"
            :src="formModel.logo"
            shape="square"
            @select="handleLogoChange"
          />
        </AFormItem>
        <AFormItem label="作者头像" name="avatar">
          <UploadPreview
            title="上传头像"
            hint="建议尺寸 200x200px"
            :src="formModel.avatar"
            shape="circle"
            @select="handleAvatarChange"
          />
        </AFormItem>
        <AFormItem label="介绍语" name="introduction">
          <ATextarea v-model:value="formModel.introduction" :rows="3" allow-clear placeholder="请输入博客介绍语" />
        </AFormItem>
        <AFormItem label="版权声明" name="copyrightDeclaration">
          <div class="no-scrollbar-textarea">
            <ATextarea
              v-model:value="formModel.copyrightDeclaration"
              :auto-size="{ minRows: 3 }"
              :maxlength="300"
              show-count
              allow-clear
              placeholder="请输入版权声明内容"
            />
          </div>
        </AFormItem>
        <AFormItem label="自动切换主题" name="isAutoTheme">
          <ASpace direction="vertical" :size="4">
            <ASwitch v-model:checked="formModel.isAutoTheme" checked-children="开启" un-checked-children="关闭" />
            <ATypographyText type="secondary">开启后将根据系统时间自动切换白天/黑夜主题。</ATypographyText>
          </ASpace>
        </AFormItem>

        <AFormItem label="GitHub 主页">
          <AInput v-model:value="formModel.githubHomepage" allow-clear placeholder="请输入 GitHub 主页 URL" />
        </AFormItem>
        <AFormItem label="Gitee 主页">
          <AInput v-model:value="formModel.giteeHomepage" allow-clear placeholder="请输入 Gitee 主页 URL" />
        </AFormItem>
        <AFormItem label="知乎主页">
          <AInput v-model:value="formModel.zhihuHomepage" allow-clear placeholder="请输入知乎主页 URL" />
        </AFormItem>
        <AFormItem label="CSDN 主页">
          <AInput v-model:value="formModel.csdnHomepage" allow-clear placeholder="请输入 CSDN 主页 URL" />
        </AFormItem>
        <AFormItem label="抖音主页">
          <AInput v-model:value="formModel.douyinHomepage" allow-clear placeholder="请输入抖音主页 URL" />
        </AFormItem>

        <AFormItem label="评论过滤" name="isCommentSensitiveWordOpen">
          <ASpace direction="vertical" :size="4">
            <ASwitch
              v-model:checked="formModel.isCommentSensitiveWordOpen"
              checked-children="开启"
              un-checked-children="关闭"
            />
            <ATypographyText type="secondary">开启后系统会对发表的评论进行敏感词过滤。</ATypographyText>
          </ASpace>
        </AFormItem>
        <AFormItem label="评论审核" name="isCommentExamineOpen">
          <ASpace direction="vertical" :size="4">
            <ASwitch
              v-model:checked="formModel.isCommentExamineOpen"
              checked-children="开启"
              un-checked-children="关闭"
            />
            <ATypographyText type="secondary">开启后评论需要后台审核通过后才会展示。</ATypographyText>
          </ASpace>
        </AFormItem>
        <AFormItem label="博主邮箱" name="mail">
          <AInput v-model:value="formModel.mail" allow-clear placeholder="请输入博主邮箱地址" />
        </AFormItem>

        <div class="settings-sticky-actions">
          <AButton type="primary" class="min-w-[120px]" :loading="submitLoading" @click="handleSubmit">
            保存设置
          </AButton>
        </div>
      </AForm>
    </ACard>
  </ASpace>
</template>

<script setup lang="ts">
import { computed, defineComponent, h, onMounted, reactive, ref } from 'vue';
import type { FormInstance, FormProps } from 'ant-design-vue';
import { message } from 'ant-design-vue';
import { PlusOutlined } from '@ant-design/icons-vue';
import { type BlogSettingsDetail, getBlogSettingsDetail, updateBlogSettings } from '@/service/blog/admin/setting';
import { uploadBlogImage } from '@/service/blog/admin/image';
import { useAppStore } from '@/store/system/app';

const appStore = useAppStore();
const formRef = ref<FormInstance>();
const submitLoading = ref(false);
const pendingLogoImage = ref<File | null>(null);
const pendingAvatarImage = ref<File | null>(null);
const originalLogoUrl = ref('');
const originalAvatarUrl = ref('');

const formModel = reactive<BlogSettingsDetail>({
  logo: '',
  name: '',
  author: '',
  introduction: '',
  copyrightDeclaration: '',
  avatar: '',
  githubHomepage: '',
  csdnHomepage: '',
  giteeHomepage: '',
  zhihuHomepage: '',
  douyinHomepage: '',
  mail: '',
  isCommentSensitiveWordOpen: true,
  isCommentExamineOpen: false,
  isAutoTheme: false
});

const formLabelCol = computed(() => (appStore.isMobile ? undefined : { span: 5 }));
const formWrapperCol = computed(() => (appStore.isMobile ? undefined : { span: 17 }));

const rules: FormProps['rules'] = {
  name: [{ required: true, message: '请输入博客名称', trigger: 'blur' }],
  author: [{ required: true, message: '请输入作者名', trigger: 'blur' }],
  logo: [{ required: true, message: '请上传博客 LOGO', trigger: 'change' }],
  avatar: [{ required: true, message: '请上传作者头像', trigger: 'change' }],
  introduction: [{ required: true, message: '请输入介绍语', trigger: 'blur' }]
};

const SettingSection = defineComponent({
  props: {
    title: { type: String, required: true },
    color: { type: String, default: 'blue' }
  },
  setup(props) {
    return () =>
      h('div', { class: 'setting-section' }, [
        h('div', { class: ['section-line', `section-line-${props.color}`] }),
        h('h3', { class: 'section-title' }, props.title)
      ]);
  }
});

const UploadPreview = defineComponent({
  props: {
    src: { type: String, default: '' },
    title: { type: String, required: true },
    hint: { type: String, required: true },
    shape: { type: String as () => 'square' | 'circle', default: 'square' }
  },
  emits: ['select'],
  setup(props, { emit }) {
    return () =>
      h('label', { class: ['upload-preview', props.shape === 'circle' ? 'upload-preview-circle' : ''] }, [
        h('input', {
          type: 'file',
          accept: 'image/*',
          style: { display: 'none' },
          onChange: (event: Event) => {
            const file = (event.target as HTMLInputElement).files?.[0];
            if (file) emit('select', file);
            (event.target as HTMLInputElement).value = '';
          }
        }),
        props.src
          ? h('img', { src: props.src, class: 'upload-image', alt: props.title, loading: 'lazy' })
          : h('div', { class: 'upload-placeholder' }, [
              h(PlusOutlined, { class: 'upload-icon' }),
              h('div', { class: 'upload-title' }, props.title),
              h('div', { class: 'upload-hint' }, props.hint)
            ])
      ]);
  }
});

function assignSettings(data: BlogSettingsDetail) {
  Object.assign(formModel, data);
  originalLogoUrl.value = data.logo;
  originalAvatarUrl.value = data.avatar;
}

async function loadSettings() {
  const res = await getBlogSettingsDetail();
  if (res.success) assignSettings(res.data);
}

function previewImage(file: File, callback: (dataUrl: string) => void) {
  const reader = new FileReader();
  reader.onload = event => {
    if (event.target?.result) callback(event.target.result as string);
  };
  reader.readAsDataURL(file);
}

function handleLogoChange(file: File) {
  pendingLogoImage.value = file;
  previewImage(file, dataUrl => {
    formModel.logo = dataUrl;
  });
}

function handleAvatarChange(file: File) {
  pendingAvatarImage.value = file;
  previewImage(file, dataUrl => {
    formModel.avatar = dataUrl;
  });
}

function getOriginalImageName(url: string) {
  if (!url) return '';
  return url.split('/').pop() || '';
}

async function uploadPendingImages() {
  if (pendingLogoImage.value) {
    const res = await uploadBlogImage({
      newImageFile: pendingLogoImage.value,
      newImageOriginalName: `logo_${Date.now()}_${pendingLogoImage.value.name}`,
      oldImageName: getOriginalImageName(originalLogoUrl.value)
    });
    if (res.success) {
      formModel.logo = res.data.url;
      pendingLogoImage.value = null;
    }
  }

  if (pendingAvatarImage.value) {
    const res = await uploadBlogImage({
      newImageFile: pendingAvatarImage.value,
      newImageOriginalName: `avatar_${Date.now()}_${pendingAvatarImage.value.name}`,
      oldImageName: getOriginalImageName(originalAvatarUrl.value)
    });
    if (res.success) {
      formModel.avatar = res.data.url;
      pendingAvatarImage.value = null;
    }
  }
}

async function handleSubmit() {
  await formRef.value?.validate();
  submitLoading.value = true;

  try {
    await uploadPendingImages();
    const res = await updateBlogSettings({ ...formModel });
    if (res.success) {
      message.success('保存成功');
      await loadSettings();
    }
  } finally {
    submitLoading.value = false;
  }
}

onMounted(() => {
  loadSettings();
});
</script>

<style scoped lang="scss">
.no-scrollbar-textarea {
  :deep(textarea) {
    overflow-y: hidden;
    scrollbar-width: none;
    resize: none;
  }

  :deep(textarea::-webkit-scrollbar) {
    display: none;
  }
}

.setting-section {
  display: flex;
  align-items: center;
  margin: 8px 0 24px;
}

.section-line {
  width: 4px;
  height: 28px;
  border-radius: 999px;
  margin-right: 12px;
}

.section-line-blue {
  background: linear-gradient(to bottom, #3b82f6, #8b5cf6);
}

.section-line-green {
  background: linear-gradient(to bottom, #22c55e, #14b8a6);
}

.section-line-orange {
  background: linear-gradient(to bottom, #f97316, #ef4444);
}

.section-title {
  color: rgb(var(--base-text-color));
  font-size: 18px;
  font-weight: 600;
  margin: 0;
}

.upload-preview {
  position: relative;
  width: 120px;
  height: 120px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  cursor: pointer;
  border: 1px dashed rgb(var(--base-text-color) / 22%);
  border-radius: 16px;
  background: rgb(var(--base-text-color) / 4%);
  transition:
    border-color 0.2s ease,
    background-color 0.2s ease,
    transform 0.2s ease;

  &:hover {
    border-color: rgb(var(--primary-color));
    background: rgb(var(--primary-color) / 8%);
    transform: translateY(-1px);
  }
}

.upload-preview-circle {
  border-radius: 50%;
}

.upload-image {
  display: block;
  width: calc(100% - 12px);
  height: calc(100% - 12px);
  border-radius: 12px;
  object-fit: contain;
  background: rgb(var(--container-bg-color));
}

.upload-preview-circle .upload-image {
  border-radius: 50%;
  object-fit: cover;
}

.upload-placeholder {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  padding: 12px;
  color: rgb(var(--base-text-color) / 55%);
}

.upload-icon {
  font-size: 28px;
  color: rgb(var(--base-text-color) / 45%);
}

.upload-title {
  margin-top: 8px;
  font-size: 13px;
  font-weight: 600;
  color: rgb(var(--base-text-color) / 78%);
}

.upload-hint {
  margin-top: 4px;
  font-size: 12px;
  color: rgb(var(--base-text-color) / 45%);
}

.settings-sticky-actions {
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

@media (max-width: 640px) {
  .upload-preview {
    width: 104px;
    height: 104px;
  }

  .setting-section {
    margin-bottom: 18px;
  }

  .settings-sticky-actions {
    bottom: 12px;
    margin-top: 28px;
    margin-bottom: 16px;
    padding: 12px 16px;
  }
}
</style>
