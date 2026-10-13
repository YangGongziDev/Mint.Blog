<template>
  <div class="page-container">
    <ProTable
      :key="refreshKey"
      :columns="columns"
      :request="loadFileList"
      :toolbar="{
        title: t('file.title'),
        actions: [],
      }"
      :search="{ formItems: searchFormItems }"
    >
      <template #toolbar-actions>
        <a-upload
          :show-upload-list="false"
          :before-upload="handleUpload"
          accept=".png,.jpg,.jpeg,.webp,.gif,.pdf,.txt,.csv,.zip,.docx,.xlsx"
        >
          <a-button type="primary" :loading="uploading">上传文件</a-button>
        </a-upload>
      </template>
      <template #bodyCell="{ column, record }">
        <template v-if="column.key === 'originalName'">
          <div class="file-name">
            <span class="file-icon" :style="{ color: getExtColor(record.ext) }">
              <FileImageOutlined v-if="isImage(record.ext)" />
              <VideoCameraOutlined v-else-if="isVideo(record.ext)" />
              <FilePdfOutlined v-else-if="record.ext === 'pdf'" />
              <FileExcelOutlined v-else-if="['xlsx', 'xls'].includes(record.ext)" />
              <FileWordOutlined v-else-if="['docx', 'doc'].includes(record.ext)" />
              <FilePptOutlined v-else-if="['pptx', 'ppt'].includes(record.ext)" />
              <FileZipOutlined v-else-if="['zip', 'rar', '7z'].includes(record.ext)" />
              <FileTextOutlined v-else />
            </span>
            <span>{{ record.originalName }}</span>
          </div>
        </template>
        <template v-if="column.key === 'size'">
          {{ formatSize(record.size) }}
        </template>
        <template v-if="column.key === 'storage'">
          <a-tag :color="storageColor[record.storage]">{{
            t(`file.storageType.${record.storage}`)
          }}</a-tag>
        </template>
        <template v-if="column.key === 'action'">
          <a-space :size="4">
            <a-button type="link" size="small" danger @click="handleDelete(record)">
              <template #icon><DeleteOutlined /></template>
              {{ t('file.delete') }}
            </a-button>
          </a-space>
        </template>
      </template>
    </ProTable>
  </div>
</template>

<script setup lang="ts">
import type { SysFile } from '@/types/file';
import type { ProFormItem, ProTableColumn } from '@/types/pro';

import {
  DeleteOutlined,
  FileImageOutlined,
  VideoCameraOutlined,
  FilePdfOutlined,
  FileExcelOutlined,
  FileWordOutlined,
  FilePptOutlined,
  FileZipOutlined,
  FileTextOutlined,
} from '@antdv-next/icons';
import { message, Modal } from 'antdv-next';
import { ref, computed } from 'vue';
import { useI18n } from 'vue-i18n';

import ProTable from '@/components/Pro/ProTable/index.vue';

const files: SysFile[] = [
  {
    originalName: '产品封面图.jpg',
    ext: 'jpg',
    size: 256000,
    mimeType: 'image/jpeg',
    storage: 'local',
  },
  { originalName: '系统Logo.png', ext: 'png', size: 48000, mimeType: 'image/png', storage: 'oss' },
  {
    originalName: '用户手册.pdf',
    ext: 'pdf',
    size: 2048000,
    mimeType: 'application/pdf',
    storage: 'cos',
  },
  {
    originalName: '需求文档.docx',
    ext: 'docx',
    size: 128000,
    mimeType: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    storage: 'local',
  },
  {
    originalName: '财务报表.xlsx',
    ext: 'xlsx',
    size: 32000,
    mimeType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    storage: 'oss',
  },
  {
    originalName: '项目源码.zip',
    ext: 'zip',
    size: 10240000,
    mimeType: 'application/zip',
    storage: 'cos',
  },
  {
    originalName: '产品演示.mp4',
    ext: 'mp4',
    size: 25600000,
    mimeType: 'video/mp4',
    storage: 'local',
  },
  { originalName: '配置说明.txt', ext: 'txt', size: 512, mimeType: 'text/plain', storage: 'oss' },
  {
    originalName: '季度汇报.pptx',
    ext: 'pptx',
    size: 3200000,
    mimeType: 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    storage: 'cos',
  },
  {
    originalName: '架构图.svg',
    ext: 'svg',
    size: 16000,
    mimeType: 'image/svg+xml',
    storage: 'local',
  },
  { originalName: '用户头像.jpg', ext: 'jpg', size: 64000, mimeType: 'image/jpeg', storage: 'cos' },
  {
    originalName: '技术文档.pdf',
    ext: 'pdf',
    size: 1024000,
    mimeType: 'application/pdf',
    storage: 'oss',
  },
].map((item, index) => ({
  ...item,
  id: String(index + 1),
  name: `sample-${index + 1}.${item.ext}`,
  path: `/uploads/${item.ext}/sample-${index + 1}.${item.ext}`,
  storage: item.storage as SysFile['storage'],
  uploader: ['admin', 'zhangsan', 'lisi', 'wangwu'][index % 4],
  remark: '',
  createTime: `2026-06-${String(12 - index).padStart(2, '0')} 10:00:00`,
}));
let nextFileId = 13;

const { t } = useI18n();
const refreshKey = ref(0);
const uploading = ref(false);
const handleUpload = async (file: File) => {
  if (file.size === 0 || file.size > 20 * 1024 * 1024) {
    message.error('文件大小须在 1 字节至 20 MB 之间');
    return false;
  }
  uploading.value = true;
  try {
    const id = String(nextFileId++);
    const response = {
      code: 200,
      message: 'success',
      success: true,
      data: {
        id,
        name: file.name,
        originalName: file.name,
        path: '',
        size: file.size,
        mimeType: file.type || 'application/octet-stream',
        ext: file.name.includes('.') ? file.name.split('.').pop()!.toLowerCase() : '',
        storage: 'local' as const,
        uploader: 'admin',
        remark: '',
        createTime: new Date().toISOString().replace('T', ' ').slice(0, 19),
      },
    };
    files.unshift(response.data);
    message.success('上传成功');
    refreshKey.value++;
  } catch {
    message.error('上传失败');
  } finally {
    uploading.value = false;
  }
  return false;
};

const storageColor: Record<string, string> = {
  local: 'default',
  oss: 'blue',
  cos: 'green',
};

const isImage = (ext: string) => ['jpg', 'jpeg', 'png', 'gif', 'svg', 'webp'].includes(ext);
const isVideo = (ext: string) => ['mp4', 'avi', 'mov', 'wmv'].includes(ext);

const getExtColor = (ext: string) => {
  const colors: Record<string, string> = {
    jpg: '#f5222d',
    jpeg: '#f5222d',
    png: '#fa541c',
    gif: '#fa8c16',
    svg: '#a0d911',
    pdf: '#cf1322',
    docx: '#1677ff',
    doc: '#1677ff',
    xlsx: '#52c41a',
    xls: '#52c41a',
    pptx: '#fa541c',
    ppt: '#fa541c',
    zip: '#faad14',
    rar: '#faad14',
    mp4: '#722ed1',
    txt: '#8c8c8c',
  };
  return colors[ext] || '#8c8c8c';
};

const formatSize = (bytes: number) => {
  if (bytes < 1024) return bytes + ' B';
  if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + ' KB';
  if (bytes < 1024 * 1024 * 1024) return (bytes / (1024 * 1024)).toFixed(1) + ' MB';
  return (bytes / (1024 * 1024 * 1024)).toFixed(2) + ' GB';
};

const searchFormItems = computed<ProFormItem[]>(() => [
  { name: 'originalName', label: t('file.fileName'), type: 'input' },
  {
    name: 'ext',
    label: t('file.ext'),
    type: 'select',
    options: [
      { label: t('file.extType.imageJpg'), value: 'jpg' },
      { label: t('file.extType.imagePng'), value: 'png' },
      { label: t('file.extType.pdf'), value: 'pdf' },
      { label: t('file.extType.word'), value: 'docx' },
      { label: t('file.extType.excel'), value: 'xlsx' },
      { label: t('file.extType.zip'), value: 'zip' },
      { label: t('file.extType.video'), value: 'mp4' },
      { label: t('file.extType.text'), value: 'txt' },
      { label: t('file.extType.ppt'), value: 'pptx' },
      { label: t('file.extType.svg'), value: 'svg' },
    ],
  },
  {
    name: 'storage',
    label: t('file.storage'),
    type: 'select',
    options: [
      { label: t('file.storageType.local'), value: 'local' },
      { label: t('file.storageType.oss'), value: 'oss' },
      { label: t('file.storageType.cos'), value: 'cos' },
    ],
  },
]);

const columns = computed<ProTableColumn[]>(() => [
  {
    title: t('file.fileName'),
    dataIndex: 'originalName',
    key: 'originalName',
    ellipsis: true,
  },
  {
    title: t('file.ext'),
    dataIndex: 'ext',
    key: 'ext',
    width: 90,
  },
  { title: t('file.size'), dataIndex: 'size', key: 'size', width: 120 },
  {
    title: t('file.storage'),
    dataIndex: 'storage',
    key: 'storage',
    width: 100,
  },
  {
    title: t('file.uploader'),
    dataIndex: 'uploader',
    key: 'uploader',
    width: 100,
  },
  {
    title: t('file.uploadTime'),
    dataIndex: 'createTime',
    key: 'createTime',
    width: 180,
  },
  {
    title: t('file.action'),
    dataIndex: 'action',
    key: 'action',
    width: 100,
    fixed: 'right',
  },
]);

const loadFileList = async (params: Record<string, unknown>) => {
  try {
    const current = Number(params.current) || 1;
    const pageSize = Number(params.pageSize) || 20;
    const filtered = files.filter(
      (item) =>
        (!params.originalName || item.originalName.includes(String(params.originalName))) &&
        (!params.ext || item.ext === params.ext) &&
        (!params.storage || item.storage === params.storage),
    );
    const start = (current - 1) * pageSize;
    const response = {
      code: 200,
      message: 'success',
      success: true,
      data: {
        list: filtered.slice(start, start + pageSize),
        total: filtered.length,
        current,
        pageSize,
      },
    };
    if (response.code === 200) {
      return {
        data: response.data.list,
        total: response.data.total,
        success: true,
      };
    }
  } catch (error: unknown) {
    console.error(t('file.loadFailed'), (error as Error).message);
  }
  return { data: [], total: 0, success: false };
};

const handleDelete = (record: SysFile) => {
  Modal.confirm({
    title: t('file.confirmDelete'),
    content: t('file.confirmDeleteContent', { name: record.originalName }),
    onOk: async () => {
      try {
        const index = files.findIndex((item) => item.id === record.id);
        if (index !== -1) files.splice(index, 1);
        const response = { code: 200, message: 'success', success: true };
        if (response.code === 200) {
          message.success(t('file.deleteSuccess'));
          refreshKey.value++;
        } else {
          message.error(response.message || t('file.deleteFailed'));
        }
      } catch (_error: unknown) {
        message.error(t('file.deleteFailed'));
      }
    },
  });
};
</script>

<style scoped lang="scss">
.file-name {
  display: flex;
  align-items: center;
  gap: 8px;

  .file-icon {
    font-size: 18px;
    flex-shrink: 0;
  }
}
</style>
