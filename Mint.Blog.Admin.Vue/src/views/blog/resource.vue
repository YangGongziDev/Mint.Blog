<template>
  <div class="p-4">
    <ACard :bordered="false">
      <ATabs v-model:active-key="activeTab">
        <ATabPane key="resources" tab="资源管理">
      <ASpace wrap>
        <ASelect v-model:value="selectedId" :options="tagOptions" allow-clear show-search option-filter-prop="label" placeholder="全部标签（含停用标签资源）" style="width: 260px" :disabled="busy" />
        <ASelect v-model:value="filters.tagVersionId" :options="versionOptions" allow-clear placeholder="全部版本" style="width: 180px" :disabled="!selectedId || versionsLoading || versionsError" />
        <ASelect v-model:value="filters.deleted" :options="statusOptions" style="width: 120px" :disabled="busy" @change="search" />
        <AInput v-model:value="filters.keyword" placeholder="标题 / URL / 关键词" style="width: 200px" @press-enter="search" />
        <AButton :loading="loading" @click="search">查询</AButton><AButton @click="reset">重置</AButton>
        <AButton type="primary" :disabled="!canWrite || busy || !selectedTag" @click="openResource()">新增资源</AButton>
      </ASpace>
      <AAlert v-if="filters.deleted === 1" message="软删除资源仍占用同标签、同版本的 URL。可编辑原记录后恢复；停用标签或分类须先恢复，或将资源改至有效标签和版本。" type="info" class="my-3" />
      <AAlert v-if="error" :message="error" type="error" class="my-3"><template #action><AButton @click="refresh">重试</AButton></template></AAlert>
      <AAlert v-if="versionsError" message="筛选版本加载失败" type="error" class="my-3"><template #action><AButton @click="loadVersions">重试</AButton></template></AAlert>
      <ATable class="mt-4" :columns="columns" :data-source="resources" row-key="id" :loading="loading" :pagination="pagination" :scroll="{ x: 1200 }" @change="changePage">
        <template #bodyCell="{ column, record }">
          <template v-if="column.key === 'version'"><ATag v-if="record.isGeneral">{{ record.tagVersionName }}</ATag><template v-else>{{ record.tagVersionName }}</template></template>
          <template v-else-if="column.key === 'kind'">{{ kindOptions.find(item => item.value === record.kind)?.label }}</template>
          <template v-else-if="column.key === 'status'"><ATag :color="record.isDeleted ? 'default' : 'success'">{{ record.isDeleted ? '已删除（回收站）' : '正常' }}</ATag></template>
          <template v-else-if="column.key === 'action'"><ASpace><AButton :disabled="!canWrite || busy" @click="openResource(record.id)">查看 / 编辑</AButton><AButton v-if="record.isDeleted" :disabled="!canWrite || busy" @click="restore(record as ResourceItem)">恢复</AButton><AButton v-else danger :disabled="!canWrite || busy" @click="remove(record as ResourceItem)">删除</AButton></ASpace></template>
        </template>
      </ATable>
        </ATabPane>
        <ATabPane key="navigation" tab="导航设置">
          <AAlert v-if="error" :message="error" type="error" class="my-3"><template #action><AButton :disabled="busy" @click="refresh">重试</AButton></template></AAlert>
          <ATable :columns="navigationColumns" :data-source="sortedNavigationTags" row-key="id" :pagination="navigationPagination" :scroll="{ x: 1100 }" @change="changeNavigationPage">
            <template #bodyCell="{ column, record }">
              <template v-if="column.key === 'logo'"><AImage v-if="record.logoUrl" :src="record.logoUrl" :width="48" /><span v-else>暂无 Logo</span></template>
              <template v-else-if="column.key === 'navigationStatus'"><ATag :color="record.showInNavigation ? 'success' : 'default'">{{ record.showInNavigation ? '展示' : '隐藏' }}</ATag></template>
              <template v-else-if="column.key === 'action'"><AButton :disabled="!canWrite || busy" @click="openNavigation(record as NavigationTag)">编辑</AButton></template>
            </template>
          </ATable>
        </ATabPane>
      </ATabs>
    </ACard>
    <AModal :open="resourceVisible" :title="editingId ? (editingDeleted ? '编辑回收站资源' : '编辑资源') : '新增资源'" :confirm-loading="saving" :mask-closable="false" :ok-button-props="{ disabled: !canWrite || busy || !selectionValid }" @cancel="!saving && (resourceVisible = false)" @ok="saveResource">
      <AAlert v-if="editingDeleted" type="info" message="保存只修改原记录，资源仍留在回收站；保存后可点击恢复。" class="mb-3" />
      <AForm ref="formRef" :model="form" layout="vertical" :disabled="saving">
        <AFormItem label="资源状态" extra="状态通过列表中的删除 / 恢复操作变更，保存资源不会改变状态。"><ATag :color="editingDeleted ? 'default' : 'success'">{{ editingDeleted ? '已删除（回收站）' : '正常' }}</ATag></AFormItem>
        <AFormItem label="所属标签" name="tagId" :rules="[{ required: true }]"><ASelect v-model:value="form.tagId" :options="resourceTagOptions" show-search option-filter-prop="label" @change="changeTag" /></AFormItem>
        <AFormItem label="分类（由标签决定）"><AInput :value="resourceTag?.categoryName ?? '标签或分类不可用'" readonly /></AFormItem>
        <AAlert v-if="resourceVersionsError" type="error" message="版本加载失败或通用版本配置异常，原选择已保留"><template #action><AButton @click="loadResourceVersions(false)">重试</AButton></template></AAlert>
        <AFormItem label="版本" name="tagVersionId" :rules="[{ required: true, message: '请选择有效版本' }]"><ASelect v-model:value="form.tagVersionId" :options="resourceVersionOptions" :loading="resourceVersionsLoading" :disabled="resourceVersionsLoading || resourceVersionsError" placeholder="请选择版本" /></AFormItem>
        <AAlert v-if="!resourceVersionsLoading && !selectionValid" type="warning" message="请选择同一有效标签下的有效版本；失效的原选择不会自动改为通用。" class="mb-3" />
        <AFormItem label="资源类型" name="kind"><ASelect v-model:value="form.kind" :options="kindOptions" /></AFormItem>
        <AFormItem label="排序（有符号64位整数）" name="sort" :rules="sortRules"><AInput v-model:value="form.sort" /></AFormItem>
        <AFormItem label="资源地址" name="url" :rules="urlRules" extra="同一标签、同一版本下 URL 唯一；如冲突，请到正常资源或回收站按 URL 查询并编辑、恢复原记录。"><AInput v-model:value="form.url" :maxlength="2048" /></AFormItem>
        <AFormItem label="标题" name="title" :rules="[{ required: true, whitespace: true, max: 200, message: '请输入不超过200字符的标题' }]"><AInput v-model:value="form.title" :maxlength="200" /></AFormItem>
        <AFormItem label="简介"><ATextarea v-model:value="form.description" :rows="3" /></AFormItem>
        <AFormItem label="精选"><ASwitch v-model:checked="form.isFeatured" /></AFormItem>
      </AForm>
    </AModal>
    <AModal :open="navigationVisible" title="导航设置" :confirm-loading="saving" :mask-closable="false" :ok-button-props="{ disabled: !canWrite || busy || !navigationTag }" @cancel="!saving && (navigationVisible = false)" @ok="saveNavigation">
      <AAlert type="info" message="关闭导航展示只会隐藏前台导航，不会删除该标签下的资源或文章。" class="mb-3" />
      <AForm layout="vertical" :disabled="saving || !canWrite">
        <AFormItem label="标签名称"><AInput :value="navigationTag?.name" readonly /></AFormItem>
        <AFormItem label="分类（由标签决定）"><AInput :value="navigationTag?.categoryName" readonly /></AFormItem>
        <AFormItem label="标签 Logo"><AImage v-if="navigationTag?.logoUrl" :src="navigationTag.logoUrl" :width="64" /><span v-else>暂无 Logo</span></AFormItem>
        <AFormItem label="在导航中显示"><ASwitch v-model:checked="navigationForm.showInNavigation" /></AFormItem>
        <AFormItem label="导航简介"><ATextarea v-model:value="navigationForm.navigationDescription" :maxlength="500" /></AFormItem>
      </AForm>
    </AModal>
  </div>
</template>

<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, reactive, ref, watch } from 'vue';
import { message, Modal, type FormInstance, type FormProps, type TableColumnsType } from 'ant-design-vue';
import { configureNavigationTag, createResource, deleteResource, getNavigationTags, getResourceDetail, getResourcePage, getTagVersions, restoreResource, updateResource, type NavigationTag, type NavigationTagForm, type ResourceForm, type ResourceItem, type TagVersion } from '@/api/blog/resource';
import { getCategoryList, type CategoryListItem } from '@/api/blog/category';
import { useAuth } from '@/hooks/auth/use-auth';
import { useAuthStore } from '@/store/system/auth';
import { sortOptionsByLabel } from '@/utils/common';

defineOptions({ name: 'BlogResourceManage' });
const { isReadonly } = useAuth();
const auth = useAuthStore();
const canWrite = computed(() => !isReadonly.value && auth.userInfo.roles.some(role => ['ROLE_ADMIN', 'ROLE_SUPER'].includes(role)));
const activeTab = ref('resources');
const tags = ref<NavigationTag[]>([]);
const sortedNavigationTags = computed(() => sortOptionsByLabel(tags.value, tag => tag.name));
const navigationPagination = reactive({ current: 1, pageSize: 20, showSizeChanger: true, pageSizeOptions: ['10', '20', '50', '100'] });
function changeNavigationPage(page: { current?: number; pageSize?: number }) {
  const size = page.pageSize ?? navigationPagination.pageSize;
  navigationPagination.current = size === navigationPagination.pageSize ? (page.current ?? 1) : 1;
  navigationPagination.pageSize = size;
}
const navigationTagId = ref<string>();
const navigationTag = computed(() => tags.value.find(tag => tag.id === navigationTagId.value));
const categories = ref<CategoryListItem[]>([]);
const selectedId = ref<string>();
const selectedTag = computed(() => tags.value.find(tag => tag.id === selectedId.value));
const tagOptions = computed(() => sortOptionsByLabel(tags.value.map(tag => ({ value: tag.id, label: tag.name })), option => option.label));
const versions = ref<TagVersion[]>([]);
const versionsLoading = ref(false);
const versionsError = ref(false);
const filters = reactive({ tagVersionId: undefined as string | undefined, keyword: '', deleted: 0 });
const resources = ref<ResourceItem[]>([]);
const loading = ref(false);
const detailLoading = ref(false);
const saving = ref(false);
const busy = computed(() => saving.value || detailLoading.value);
const error = ref('');
const current = ref(1);
const pageSize = ref(20);
const total = ref(0);
const pagination = computed(() => ({ current: current.value, pageSize: pageSize.value, total: total.value, showSizeChanger: true }));
const resourceVisible = ref(false);
const navigationVisible = ref(false);
const editingId = ref<string>();
const editingDeleted = ref(false);
const formRef = ref<FormInstance>();
const form = reactive<ResourceForm>({ tagId: '', tagVersionId: '', title: '', description: '', url: '', kind: 1, sort: '0', isFeatured: false });
const navigationForm = reactive<NavigationTagForm>({ showInNavigation: false, navigationDescription: '' });
const resourceVersions = ref<TagVersion[]>([]);
const resourceVersionsLoading = ref(false);
const resourceVersionsError = ref(false);
const resourceTag = computed(() => tags.value.find(tag => tag.id === form.tagId));
const resourceTagOptions = computed(() => {
  const options = tagOptions.value.map(item => ({ ...item, disabled: false }));
  if (form.tagId && !options.some(item => item.value === form.tagId)) options.push({ value: form.tagId, label: `原标签 ${form.tagId}（停用或不可用）`, disabled: true });
  return sortOptionsByLabel(options, option => option.label);
});
const validId = (value: unknown): value is string => typeof value === 'string' && /^[1-9]\d*$/.test(value) && BigInt(value) <= 9223372036854775807n;
const selectionValid = computed(() => validId(form.tagId) && validId(form.tagVersionId) && !!resourceTag.value && validId(resourceTag.value.categoryId) && categories.value.some(category => category.id === resourceTag.value?.categoryId) && !resourceVersionsLoading.value && !resourceVersionsError.value && resourceVersions.value.some(version => version.id === form.tagVersionId && version.tagId === form.tagId));
const option = (version: TagVersion) => ({ value: version.id, label: `${version.name}${version.isGeneral ? '（通用）' : ''}`, disabled: false });
const versionOptions = computed(() => sortOptionsByLabel(versions.value.map(option), item => item.label));
const resourceVersionOptions = computed(() => {
  const options = resourceVersions.value.map(option);
  if (form.tagVersionId && !options.some(item => item.value === form.tagVersionId)) options.push({ value: form.tagVersionId, label: `原版本 ${form.tagVersionId}（待验证或失效）`, disabled: true });
  return sortOptionsByLabel(options, item => item.label);
});
const statusOptions = sortOptionsByLabel([{ value: 0, label: '正常资源' }, { value: 1, label: '回收站' }], item => item.label);
const kindOptions = sortOptionsByLabel([{ value: 1, label: '官网文档' }, { value: 2, label: '文章教程' }, { value: 3, label: 'Git 仓库' }, { value: 4, label: '软件获取' }], item => item.label);
const navigationColumns: TableColumnsType<NavigationTag> = [
  { title: '标签 Logo', key: 'logo', width: 100 }, { title: '名称', dataIndex: 'name' }, { title: '所属分类', dataIndex: 'categoryName' },
  { title: '导航展示状态', key: 'navigationStatus', width: 130 }, { title: '导航简介', dataIndex: 'navigationDescription', ellipsis: true },
  { title: '版本数量', dataIndex: 'versionCount', width: 100 }, { title: '资源数量', dataIndex: 'resourceCount', width: 100 },
  { title: '操作', key: 'action', width: 100 }
];
const columns: TableColumnsType<ResourceItem> = [
  { title: '标题', dataIndex: 'title' }, { title: '分类', dataIndex: 'categoryName' }, { title: '标签', dataIndex: 'tagName' },
  { title: '版本', key: 'version' }, { title: '类型', key: 'kind' }, { title: '地址', dataIndex: 'url', ellipsis: true },
  { title: '排序', dataIndex: 'sort' }, { title: '状态', key: 'status', width: 150 }, { title: '操作', key: 'action', width: 220 }
];
const sortRules: NonNullable<FormProps['rules']>[string] = [{ required: true, validator: async (_rule, value: string) => {
  if (!/^-?\d+$/.test(value) || BigInt(value) < -9223372036854775808n || BigInt(value) > 9223372036854775807n) throw new Error('请输入有符号64位整数');
} }];
const urlRules = [{ required: true, validator: async (_rule: unknown, value: string) => {
  try { const url = new URL(value.trim()); if (!['http:', 'https:'].includes(url.protocol) || value.trim().length > 2048) throw new Error(); }
  catch { throw new Error('请输入不超过2048字符的 HTTP/HTTPS 地址'); }
} }];
let disposed = false;
let tagsRequest = 0;
let versionsRequest = 0;
let listRequest = 0;
let detailRequest = 0;
let formVersionsRequest = 0;
async function loadTags() {
  const request = ++tagsRequest;
  try {
    const [response, categoryResponse] = await Promise.all([getNavigationTags(), getCategoryList()]);
    if (disposed || request !== tagsRequest) return;
    if (!response.success || !categoryResponse.success) throw new Error();
    tags.value = response.data;
    categories.value = categoryResponse.data.filter(category => category.isDeleted !== true && category.isDeleted !== 1);
  } catch { if (!disposed && request === tagsRequest) { tags.value = []; categories.value = []; error.value = '标签或分类加载失败'; } }
}
async function loadVersions() {
  const request = ++versionsRequest;
  const tagId = selectedId.value;
  versions.value = [];
  versionsError.value = false;
  versionsLoading.value = !!tagId;
  if (!tagId) return;
  try {
    const response = await getTagVersions(tagId);
    if (disposed || request !== versionsRequest || tagId !== selectedId.value) return;
    if (!response.success) throw new Error();
    versions.value = response.data;
  } catch { if (!disposed && request === versionsRequest) versionsError.value = true; }
  finally { if (!disposed && request === versionsRequest) versionsLoading.value = false; }
}
async function loadResourceVersions(selectGeneral = false) {
  const request = ++formVersionsRequest;
  const tagId = form.tagId;
  resourceVersions.value = [];
  resourceVersionsError.value = false;
  resourceVersionsLoading.value = true;
  try {
    const response = await getTagVersions(tagId);
    if (disposed || request !== formVersionsRequest || tagId !== form.tagId || !resourceVisible.value) return;
    if (!response.success || response.data.some(version => !validId(version.id) || version.tagId !== tagId)) throw new Error();
    const generals = response.data.filter(version => version.isGeneral === true);
    if (generals.length !== 1) throw new Error();
    resourceVersions.value = response.data;
    if (selectGeneral) form.tagVersionId = generals[0].id;
  } catch { if (!disposed && request === formVersionsRequest) resourceVersionsError.value = true; }
  finally { if (!disposed && request === formVersionsRequest) resourceVersionsLoading.value = false; }
}
function changeTag() { form.tagVersionId = ''; void loadResourceVersions(true); }
async function loadResources() {
  const request = ++listRequest;
  const tagId = selectedId.value;
  resources.value = [];
  total.value = 0;
  loading.value = true;
  error.value = '';
  try {
    const response = await getResourcePage({ tagId, tagVersionId: filters.tagVersionId, isDeleted: filters.deleted === 1, keyword: filters.keyword.trim() || undefined, pageNumber: current.value, pageSize: pageSize.value });
    if (disposed || request !== listRequest || tagId !== selectedId.value) return;
    if (!response.success) throw new Error();
    resources.value = response.data.items;
    total.value = response.data.totalCount;
  } catch { if (!disposed && request === listRequest) error.value = '资源加载失败'; }
  finally { if (!disposed && request === listRequest) loading.value = false; }
}
function search() { current.value = 1; void loadResources(); }
function reset() { selectedId.value = undefined; filters.tagVersionId = undefined; filters.keyword = ''; search(); }
function changePage(page: { current?: number; pageSize?: number }) { current.value = page.current ?? 1; pageSize.value = page.pageSize ?? 20; void loadResources(); }
async function refresh() { await Promise.all([loadTags(), loadVersions(), loadResources()]); }
async function openResource(id?: string) {
  if (!canWrite.value || busy.value || (!id && !selectedId.value)) return;
  const request = ++detailRequest;
  const tagId = selectedId.value;
  editingId.value = id;
  editingDeleted.value = false;
  detailLoading.value = true;
  try {
    if (id) {
      const response = await getResourceDetail(id);
      if (disposed || request !== detailRequest || tagId !== selectedId.value) return;
      if (!response.success) throw new Error();
      const data = response.data;
      editingDeleted.value = data.isDeleted;
      Object.assign(form, { tagId: data.tagId, tagVersionId: data.tagVersionId, title: data.title, description: data.description, url: data.url, kind: data.kind, isFeatured: data.isFeatured, sort: data.sort });
    } else Object.assign(form, { tagId, tagVersionId: '', title: '', description: '', url: '', kind: 1, isFeatured: false, sort: '0' });
    resourceVisible.value = true;
    formRef.value?.clearValidate();
    await loadResourceVersions(!id);
  } catch { if (!disposed && request === detailRequest) error.value = '资源详情加载失败，请重试'; }
  finally { if (!disposed && request === detailRequest) detailLoading.value = false; }
}
async function saveResource() {
  if (!canWrite.value || busy.value || !selectionValid.value) return;
  saving.value = true;
  try {
    await formRef.value?.validate();
    const data: ResourceForm = { tagId: form.tagId, tagVersionId: form.tagVersionId, title: form.title.trim(), description: form.description.trim(), url: form.url.trim(), kind: form.kind, isFeatured: form.isFeatured, sort: form.sort };
    const response = editingId.value ? await updateResource(editingId.value, data) : await createResource(data);
    if (!response.success || disposed) return;
    resourceVisible.value = false;
    message.success(editingDeleted.value ? '原记录已保存，可在回收站恢复' : '资源已保存');
    await loadResources();
  } catch { /* 保留输入，由全局显示请求错误。 */ }
  finally { saving.value = false; }
}
function openNavigation(tag: NavigationTag) {
  if (!canWrite.value || busy.value) return;
  navigationTagId.value = tag.id;
  Object.assign(navigationForm, { showInNavigation: tag.showInNavigation, navigationDescription: tag.navigationDescription });
  navigationVisible.value = true;
}
async function saveNavigation() {
  if (!canWrite.value || busy.value || !navigationTagId.value || !navigationTag.value) return;
  const tagId = navigationTagId.value;
  saving.value = true;
  try {
    const response = await configureNavigationTag(tagId, { showInNavigation: navigationForm.showInNavigation, navigationDescription: navigationForm.navigationDescription.trim() });
    if (!response.success || disposed) return;
    navigationVisible.value = false;
    message.success('导航设置已保存');
    await loadTags();
  } finally { saving.value = false; }
}
function remove(resource: ResourceItem) {
  if (!canWrite.value || busy.value) return;
  Modal.confirm({ title: `删除“${resource.title}”？`, content: '资源将被软删除；同一标签和版本下的 URL 仍被占用，可在回收站恢复。', async onOk() {
    if (disposed || busy.value || !canWrite.value) return;
    saving.value = true;
    try { const response = await deleteResource(resource.id); if (!response.success) throw new Error('删除失败'); if (!disposed) await loadResources(); }
    finally { saving.value = false; }
  } });
}
function restore(resource: ResourceItem) {
  if (!canWrite.value || busy.value) return;
  Modal.confirm({ title: `恢复“${resource.title}”？`, content: `恢复到 ${resource.tagName} / ${resource.tagVersionName}。标签、分类和版本必须有效。`, async onOk() {
    if (disposed || busy.value || !canWrite.value) return;
    saving.value = true;
    try {
      const response = await restoreResource(resource.id);
      if (!response.success) throw new Error('恢复失败');
      if (!disposed) { message.success('资源已恢复'); await loadResources(); }
    } finally { saving.value = false; }
  } });
}
watch(resourceVisible, visible => { if (!visible) { ++formVersionsRequest; resourceVersionsLoading.value = false; } }, { flush: 'sync' });
watch(selectedId, () => { ++detailRequest; detailLoading.value = false; resourceVisible.value = false; filters.tagVersionId = undefined; current.value = 1; void loadVersions(); void loadResources(); }, { flush: 'sync' });
onMounted(refresh);
onBeforeUnmount(() => { disposed = true; ++tagsRequest; ++versionsRequest; ++listRequest; ++detailRequest; ++formVersionsRequest; });
</script>
