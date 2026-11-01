<template>
  <AModal v-model:open="visible" title="预览" :footer="null" width="1000px" @cancel="close">
    <p>仅后台授权可见，不代表内容已公开发布。</p>
    <section v-for="group in groups" :key="group.id">
      <h3>{{ group.title }}</h3>
      <ASpace wrap>
        <AButton v-for="item in group.children" :key="item.id" @click="loadArticle(item.articleId)">{{ item.title }}</AButton>
      </ASpace>
    </section>
    <ASpin :spinning="loading">
      <p v-if="failed" role="alert">预览加载失败，请稍后重新打开或选择其他目录文章。</p>
      <ContentPreview v-else-if="title || content" :title="title" :content="content" />
      <p v-else-if="!loading">请选择目录文章，或暂无可预览内容。</p>
    </ASpin>
  </AModal>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { getArticleDetail, getArticleDraftDetail } from '@/api/blog/article';
import { getColumnCatalog, type AdminColumnCatalogItem } from '@/api/blog/column';
import ContentPreview from './content-preview.vue';
const visible = ref(false);
const loading = ref(false);
const failed = ref(false);
const title = ref('');
const content = ref('');
const groups = ref<AdminColumnCatalogItem[]>([]);
let requestId = 0;
async function loadArticle(id: string, draft = false) {
  const current = ++requestId;
  loading.value = true;
  failed.value = false;
  title.value = '';
  content.value = '';
  try {
    const result = await (draft ? getArticleDraftDetail(id) : getArticleDetail(id));
    if (current === requestId) {
      failed.value = !result.success;
      if (result.success) {
        title.value = result.data.title;
        content.value = result.data.content;
      }
    }
  } catch {
    if (current === requestId) failed.value = true;
  } finally { if (current === requestId) loading.value = false; }
}
async function openArticle(id: string, draft = false) {
  groups.value = [];
  visible.value = true;
  await loadArticle(id, draft);
}
async function openColumn(id: string) {
  const current = ++requestId;
  groups.value = [];
  title.value = '';
  content.value = '';
  visible.value = true;
  loading.value = true;
  failed.value = false;
  try {
    const result = await getColumnCatalog(id);
    if (current === requestId) {
      failed.value = !result.success;
      if (result.success) groups.value = result.data;
    }
  } catch {
    if (current === requestId) failed.value = true;
  } finally { if (current === requestId) loading.value = false; }
}
function close() { requestId++; groups.value = []; title.value = ''; content.value = ''; failed.value = false; loading.value = false; }
defineExpose({ openArticle, openColumn });
</script>
