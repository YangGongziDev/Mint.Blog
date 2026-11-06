<template>
  <div class="tag-page flex flex-col gap-4 p-4">
    <ACard :bordered="false" class="card-wrapper search-card">
      <ASpace wrap><AInput v-model:value="query.name" placeholder="标签名称" allow-clear @press-enter="search" /><ARangePicker v-model:value="dateRange" @change="changeDates" /><AButton @click="search">查询</AButton><AButton @click="reset">重置</AButton><AButton type="primary" :disabled="!canWrite || busy" @click="openCreate">新增</AButton></ASpace>
    </ACard>
    <ACard :bordered="false" class="card-wrapper table-card">
      <AAlert v-if="error" :message="error" type="error" class="my-3"><template #action><AButton @click="refresh">重试</AButton></template></AAlert>
      <ATable :columns="columns" :data-source="items" :loading="loading" row-key="id" :pagination="pagination" :scroll="{ x: 1500, y: '100%' }" @change="changePage">
        <template #bodyCell="{ column, record }">
          <template v-if="column.key === 'logo'"><AImage v-if="record.logoUrl" :src="record.logoUrl" :width="40" /></template>
          <template v-else-if="column.key === 'navigation'">{{ record.showInNavigation ? '显示' : '隐藏' }}</template>
          <template v-else-if="column.key === 'deleted'">{{ isDeleted(record as TagListItem) ? '已删除' : '正常' }}</template>
          <template v-else-if="column.key === 'time'">{{ formatDateTime(record.createTime || record.createdAt || '') }}</template>
          <template v-else-if="column.key === 'action'"><ASpace wrap class="table-actions" :size="[8, 4]">
            <AButton type="link" size="small" :disabled="!canWrite || busy || sorting || loading" @click="moveTag(record as TagListItem, 'first')"><VerticalAlignTopOutlined />移至首位</AButton><AButton type="link" size="small" :disabled="!canWrite || busy || sorting || loading" @click="moveTag(record as TagListItem, 'last')"><VerticalAlignBottomOutlined />移至末位</AButton>
            <AButton type="link" size="small" :disabled="!canWrite || busy || sorting || loading" @click="moveTag(record as TagListItem, 'up')"><UpOutlined />上移</AButton><AButton type="link" size="small" :disabled="!canWrite || busy || sorting || loading" @click="moveTag(record as TagListItem, 'down')"><DownOutlined />下移</AButton>
            <AButton type="link" size="small" :disabled="!canWrite || busy || isDeleted(record as TagListItem)" @click="openEdit(record as TagListItem)"><EditOutlined />编辑</AButton><AButton type="link" size="small" danger :disabled="!canWrite || busy" @click="changeDeleted(record as TagListItem)"><UndoOutlined v-if="isDeleted(record as TagListItem)" /><DeleteOutlined v-else />{{ isDeleted(record as TagListItem) ? '恢复' : '删除' }}</AButton>
          </ASpace></template>
        </template>
      </ATable>
    </ACard>
    <AModal :open="visible" :title="editing ? '编辑标签' : '批量创建标签'" :mask-closable="false" :confirm-loading="busy" :ok-button-props="{ disabled: !canWrite || busy || categoriesLoading || categoriesError }" @cancel="!busy && (visible = false)" @ok="save">
      <AForm ref="formRef" :model="form" layout="vertical" :disabled="busy">
        <AFormItem label="分类" name="categoryId" :rules="[{ required: true, message: '请选择有效分类' }]"><ASelect v-model:value="form.categoryId" :options="categoryOptions" show-search option-filter-prop="label" :loading="categoriesLoading" /></AFormItem>
        <AAlert v-if="categoriesError" type="error" message="分类加载失败"><template #action><AButton @click="loadCategories">重试</AButton></template></AAlert>
        <AFormItem v-if="editing" label="名称" name="name" :rules="[{ required: true, whitespace: true, max: 20, message: '请输入不超过20字符的名称' }]"><AInput v-model:value="form.name" :maxlength="20" /></AFormItem>
        <AFormItem v-else label="标签列表" extra="输入名称后按回车，可批量创建；所有新标签使用上述分类。"><ASelect v-model:value="names" mode="tags" :token-separators="[',', '，']" /></AFormItem>
        <AFormItem label="Logo 图片链接" name="logoUrl" :rules="logoRules" extra="可留空，编辑时清空将移除 Logo。"><AInput v-model:value="form.logoUrl" /></AFormItem>
        <AAlert v-if="editing" message="修改分类会改变该标签下文章和资源的派生分类。导航显示和简介可在资源管理的导航设置中修改。" />
      </AForm>
    </AModal>
  </div>
</template>

<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, reactive, ref } from 'vue';
import { message, Modal, type FormInstance, type TableColumnsType } from 'ant-design-vue';
import type { Dayjs } from 'dayjs';
import { DeleteOutlined, DownOutlined, EditOutlined, UndoOutlined, UpOutlined, VerticalAlignBottomOutlined, VerticalAlignTopOutlined } from '@ant-design/icons-vue';
import { createTag, deleteTag, getTagPageList, updateTag, updateTagSort, type TagListItem } from '@/api/blog/tag';
import { getCategoryList, type CategoryListItem } from '@/api/blog/category';
import { useAuth } from '@/hooks/auth/use-auth';
import { useAuthStore } from '@/store/system/auth';
import { sortOptionsByLabel } from '@/utils/common';
import { formatDateTime, getAntdTimeSortOrder, getTableSortOrder, resolveTimeSortOrder, type TimeSortOrder } from '@/utils/date-time';

defineOptions({ name: 'BlogTagList' });
const { isReadonly } = useAuth();
const auth = useAuthStore();
const canWrite = computed(() => !isReadonly.value && auth.userInfo.roles.some(role => ['ROLE_ADMIN', 'ROLE_SUPER'].includes(role)));
const query = reactive({ name: '', startDate: '', endDate: '', sortOrder: undefined as TimeSortOrder | undefined });
const dateRange = ref<[Dayjs, Dayjs]>();
const items = ref<TagListItem[]>([]);
const categories = ref<CategoryListItem[]>([]);
const categoriesLoading = ref(false);
const categoriesError = ref(false);
const categoryOptions = computed(() => sortOptionsByLabel(categories.value.map(category => ({ value: category.id, label: category.name })), option => option.label));
const current = ref(1);
const pageSize = ref(20);
const total = ref(0);
const pagination = computed(() => ({ current: current.value, pageSize: pageSize.value, total: total.value, showSizeChanger: true }));
const loading = ref(false);
const busy = ref(false);
const sorting = ref(false);
const error = ref('');
const visible = ref(false);
const editing = ref<TagListItem>();
const formRef = ref<FormInstance>();
const form = reactive({ name: '', categoryId: '', logoUrl: '' });
const names = ref<string[]>([]);
let request = 0;
let categoryRequest = 0;
let disposed = false;
const isDeleted = (tag: TagListItem) => tag.isDeleted === true || tag.isDeleted === 1;
const columns = computed<TableColumnsType<TagListItem>>(() => [
  { title: 'Logo', key: 'logo', width: 80 }, { title: '名称', dataIndex: 'name', width: 160 }, { title: '分类', dataIndex: 'categoryName', width: 140 },
  { title: '导航', key: 'navigation', width: 80 }, { title: '导航简介', dataIndex: 'navigationDescription', width: 180, ellipsis: true },
  { title: '版本数', dataIndex: 'versionCount', width: 90 }, { title: '文章数', dataIndex: 'articlesTotal', width: 90 },
  { title: '排序号', dataIndex: 'sort', key: 'sort', width: 100, customRender: ({ text }) => text ?? '0' },
  { title: '创建时间', key: 'time', width: 180, sorter: true, sortOrder: query.sortOrder ? getAntdTimeSortOrder(query.sortOrder) : undefined, sortDirections: ['descend', 'ascend'] }, { title: '状态', key: 'deleted', width: 90 }, { title: '操作', key: 'action', width: 340, align: 'center', fixed: 'right' }
]);
const logoRules = [{ validator: async (_rule: unknown, value: string) => {
  if (!value.trim()) return;
  try { const url = new URL(value.trim()); if (!['http:', 'https:'].includes(url.protocol) || value.trim().length > 2000) throw new Error(); }
  catch { throw new Error('请输入不超过2000字符的 HTTP/HTTPS 图片链接'); }
} }];
async function loadData() {
  const generation = ++request;
  loading.value = true;
  error.value = '';
  try {
    const response = await getTagPageList({ pageNumber: current.value, pageSize: pageSize.value, name: query.name || undefined, startDate: query.startDate || undefined, endDate: query.endDate || undefined, sortOrder: query.sortOrder });
    if (disposed || generation !== request) return;
    if (!response.success) throw new Error();
    items.value = response.data.items ?? response.data.records ?? [];
    total.value = response.data.totalCount ?? response.data.total ?? 0;
  } catch { if (!disposed && generation === request) error.value = '标签列表加载失败'; }
  finally { if (!disposed && generation === request) loading.value = false; }
}
async function loadCategories() {
  const generation = ++categoryRequest;
  categoriesLoading.value = true;
  categoriesError.value = false;
  try {
    const response = await getCategoryList();
    if (disposed || generation !== categoryRequest) return;
    if (!response.success) throw new Error();
    categories.value = response.data.filter(category => category.isDeleted !== true && category.isDeleted !== 1);
  } catch { if (!disposed && generation === categoryRequest) categoriesError.value = true; }
  finally { if (!disposed && generation === categoryRequest) categoriesLoading.value = false; }
}
function search() { current.value = 1; void loadData(); }
function reset() { Object.assign(query, { name: '', startDate: '', endDate: '', sortOrder: undefined }); dateRange.value = undefined; search(); }
function changeDates(_value: unknown, dates: [string, string]) { query.startDate = dates[0]; query.endDate = dates[1]; }
function changePage(page: { current?: number; pageSize?: number }, _filters: unknown, sorter: unknown, extra: { action?: string }) { current.value = page.current ?? 1; pageSize.value = page.pageSize ?? 20; if (extra.action === 'sort') query.sortOrder = resolveTimeSortOrder(getTableSortOrder(sorter), query.sortOrder); void loadData(); }
function openCreate() { if (!canWrite.value || busy.value) return; editing.value = undefined; names.value = []; Object.assign(form, { name: '', categoryId: '', logoUrl: '' }); visible.value = true; void loadCategories(); }
function openEdit(tag: TagListItem) { if (!canWrite.value || busy.value || isDeleted(tag)) return; editing.value = tag; Object.assign(form, { name: tag.name, categoryId: tag.categoryId, logoUrl: tag.logoUrl ?? '' }); visible.value = true; void loadCategories(); }
async function save() {
  if (!canWrite.value || busy.value || categoriesLoading.value || categoriesError.value) return;
  busy.value = true;
  try {
    await formRef.value?.validate();
    if (!categories.value.some(category => category.id === form.categoryId)) { message.warning('请选择有效分类'); return; }
    const data = { name: form.name.trim(), categoryId: form.categoryId, logoUrl: form.logoUrl.trim() };
    if (editing.value) { if (!(await updateTag(editing.value.id, data)).success) return; }
    else {
      const pending = names.value.map(name => name.trim()).filter(Boolean);
      if (!pending.length || pending.some(name => name.length > 20) || new Set(pending.map(name => name.toLowerCase())).size !== pending.length) { message.warning('请输入不重复且不超过20字符的标签名称'); return; }
      for (const name of pending) {
        const response = await createTag({ ...data, name });
        if (!response.success) return;
        names.value = names.value.filter(item => item.trim() !== name);
      }
    }
    if (disposed) return;
    visible.value = false;
    message.success('保存成功');
    await loadData();
  } catch { /* 校验失败保留输入。 */ }
  finally { busy.value = false; }
}
function changeDeleted(tag: TagListItem) {
  if (!canWrite.value || busy.value) return;
  const restore = isDeleted(tag);
  Modal.confirm({ title: `${restore ? '恢复' : '删除'}标签“${tag.name}”？`, content: restore ? '恢复需满足有效分类等约束。' : '标签仅支持软删除，通用版本、普通版本及关联文章、草稿和资源均会保留。禁止物理删除标签。', async onOk() {
    if (disposed || !canWrite.value || busy.value) return;
    busy.value = true;
    try { const response = await deleteTag(tag.id, restore ? 3 : 1); if (!response.success) throw new Error('操作失败'); if (!disposed) await loadData(); }
    finally { busy.value = false; }
  } });
}
async function moveTag(tag: TagListItem, move: 'up' | 'down' | 'first' | 'last') {
  if (!canWrite.value || busy.value || sorting.value || loading.value) return;
  sorting.value = true;
  try {
    const response = await updateTagSort(tag.id, '0', move);
    if (response.success && !disposed) {
      query.sortOrder = undefined;
      message.success('排序更新成功');
      await loadData();
    }
  } finally { sorting.value = false; }
}
async function refresh() { await Promise.all([loadData(), loadCategories()]); }
onMounted(refresh);
onBeforeUnmount(() => { disposed = true; ++request; ++categoryRequest; });
</script>

<style scoped lang="scss">
.tag-page {
  height: 100%;
  min-height: 0;
  min-width: 0;
  overflow: hidden;
}
.search-card {
  flex-shrink: 0;
}
.table-card {
  display: flex;
  flex: 1;
  min-height: 0;
  overflow: hidden;
  flex-direction: column;
}
.table-card :deep(.ant-card-body),
.table-card :deep(.ant-table-wrapper),
.table-card :deep(.ant-spin-nested-loading),
.table-card :deep(.ant-spin-container),
.table-card :deep(.ant-table),
.table-card :deep(.ant-table-container) {
  display: flex;
  flex: 1;
  min-height: 0;
  flex-direction: column;
}
.table-card :deep(.ant-card-body) {
  overflow: hidden;
}
.table-card :deep(.ant-table-body) {
  flex: 1;
  min-height: 0;
  overflow-y: auto !important;
}
.table-card :deep(.ant-alert),
.table-card :deep(.ant-table-header),
.table-card :deep(.ant-table-pagination) {
  flex-shrink: 0;
}
.table-actions {
  display: grid;
  grid-template-columns: repeat(3, max-content);
  grid-template-rows: repeat(2, auto);
  justify-content: center;
  gap: 4px 8px !important;
}
.table-actions :deep(.ant-btn) { white-space: nowrap; }
</style>
