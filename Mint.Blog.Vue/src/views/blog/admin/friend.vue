<template>
  <div class="category-page flex h-full min-h-0 w-full flex-col overflow-hidden">
    <div class="flex-shrink-0 bg-layout pb-4">
      <ACard :bordered="false" class="card-wrapper">
        <AForm layout="inline" class="responsive-search-form">
          <AFormItem label="友链名称">
            <AInput v-model:value="query.name" allow-clear placeholder="请输入友链名称" class="w-full sm:w-[220px]" />
          </AFormItem>
          <AFormItem label="创建日期">
            <ARangePicker v-model:value="dateRange" class="w-full sm:w-[280px]" @change="handleDateChange" />
          </AFormItem>
          <AFormItem>
            <ASpace wrap>
              <AButton type="primary" @click="loadData">
                <template #icon><SearchOutlined /></template>
                查询
              </AButton>
              <AButton @click="handleReset">
                <template #icon><ReloadOutlined /></template>
                重置
              </AButton>
              <AButton type="primary" class="w-full sm:w-auto" @click="openCreateModal">
                <template #icon><PlusOutlined /></template>
                新增友链
              </AButton>
            </ASpace>
          </AFormItem>
        </AForm>
      </ACard>
    </div>

    <ACard :bordered="false" class="card-wrapper table-card flex-1 min-h-0 overflow-hidden">
      <ATable
        :columns="columns"
        :data-source="tableData"
        :loading="loading"
        :pagination="pagination"
        :row-key="record => record.id"
        :row-class-name="record => isDeleted(record as AdminFriendPageItem) ? 'deleted-row' : ''"
        :scroll="{ x: tableScrollX, y: tableScrollY }"
        bordered
        size="middle"
        @change="handleTableChange"
      >
        <template #bodyCell="{ column, record, index }">
          <template v-if="column.key === 'index'">
            {{ index + 1 }}
          </template>
          <template v-else-if="column.key === 'name'">
            <ATooltip :title="record.name">
              <span class="friend-cell-ellipsis">{{ record.name }}</span>
            </ATooltip>
          </template>
          <template v-else-if="column.key === 'url'">
            <ATooltip :title="record.url">
              <a :href="record.url" target="_blank" rel="noopener noreferrer" class="friend-cell-ellipsis text-primary">
                {{ record.url }}
              </a>
            </ATooltip>
          </template>
          <template v-else-if="column.key === 'category'">
            {{ categoryMap[record.category] || record.category }}
          </template>
          <template v-else-if="column.key === 'avatar'">
            <AImage :width="50" :src="record.avatar" />
          </template>
          <template v-else-if="column.key === 'isTop'">
            <ASwitch v-model:checked="record.isTop" checked-children="置顶" un-checked-children="普通" @change="() => handleTopChange(record as AdminFriendPageItem)" />
          </template>
          <template v-else-if="column.key === 'createTime'">
            {{ getCreateTime(record as AdminFriendPageItem) }}
          </template>
          <template v-else-if="column.key === 'status'">
            <ASelect v-model:value="record.status" size="small" class="w-[100px]" @change="() => handleStatusChange(record as AdminFriendPageItem)">
              <ASelectOption value="active">
                <span class="text-green-600">正常</span>
              </ASelectOption>
              <ASelectOption value="inactive">
                <span class="text-red-600">停用</span>
              </ASelectOption>
              <ASelectOption value="pending">
                <span class="text-orange-500">待审核</span>
              </ASelectOption>
            </ASelect>
          </template>
          <template v-else-if="column.key === 'isDeleted'">
            <ATag :color="isDeleted(record as AdminFriendPageItem) ? 'red' : 'green'">
              {{ isDeleted(record as AdminFriendPageItem) ? '已删除' : '未删除' }}
            </ATag>
          </template>
          <template v-else-if="column.key === 'action'">
            <ASpace>
              <ATooltip title="置顶">
                <AButton size="small" shape="circle" :disabled="index === 0" @click="moveFriendToFirst(record as AdminFriendPageItem, index)">
                  <template #icon><VerticalAlignTopOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="置底">
                <AButton size="small" shape="circle" :disabled="index === tableData.length - 1" @click="moveFriendToLast(record as AdminFriendPageItem, index)">
                  <template #icon><VerticalAlignBottomOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="上移">
                <AButton size="small" shape="circle" :disabled="index === 0" @click="moveFriendUp(index)">
                  <template #icon><UpOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="下移">
                <AButton size="small" shape="circle" :disabled="index === tableData.length - 1" @click="moveFriendDown(index)">
                  <template #icon><DownOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="编辑">
                <AButton size="small" shape="circle" @click="openEditModal(record as AdminFriendPageItem)">
                  <template #icon><EditOutlined /></template>
                </AButton>
              </ATooltip>
              <ATooltip title="删除">
                <AButton danger size="small" shape="circle" @click="openDeleteModal(record as AdminFriendPageItem)">
                  <template #icon><DeleteOutlined /></template>
                </AButton>
              </ATooltip>
            </ASpace>
          </template>
        </template>
      </ATable>
    </ACard>

    <AModal v-model:open="createModalVisible" title="新增友链" class="friend-modal" :width="modalWidth" :footer="null">
      <AForm ref="createFormRef" :model="createForm" :rules="rules" :layout="appStore.isMobile ? 'vertical' : 'horizontal'" :label-col="labelCol">
        <AFormItem label="网站名称" name="name">
          <AInput v-model:value="createForm.name" allow-clear show-count :maxlength="30" placeholder="请输入网站名称" />
        </AFormItem>
        <AFormItem label="网站图标" name="avatar">
          <AInput v-model:value="createForm.avatar" allow-clear placeholder="请输入网站图标链接" />
        </AFormItem>
        <AFormItem label="网站链接" name="url">
          <AInput v-model:value="createForm.url" allow-clear placeholder="请输入网站链接" />
        </AFormItem>
        <AFormItem label="网站分类" name="category">
          <ASelect v-model:value="createForm.category" allow-clear placeholder="请选择网站分类">
            <ASelectOption v-for="option in categoryOptions" :key="option.value" :value="option.value">
              {{ option.label }}
            </ASelectOption>
          </ASelect>
        </AFormItem>
        <AFormItem label="网站描述" name="description">
          <ATextarea v-model:value="createForm.description" :rows="3" allow-clear show-count :maxlength="100" placeholder="请输入网站描述" />
        </AFormItem>
      </AForm>
      <div class="modal-footer mt-6 flex justify-end gap-3 border-t border-gray-200 pt-4 dark:border-gray-600">
        <AButton size="middle" @click="closeCreateModal">取消</AButton>
        <AButton type="primary" size="middle" :loading="createSubmitLoading" @click="handleCreateSubmit">确定</AButton>
      </div>
    </AModal>

    <AModal v-model:open="editModalVisible" title="编辑友链" class="friend-modal" :width="modalWidth" :footer="null">
      <AForm ref="editFormRef" :model="editForm" :rules="rules" :layout="appStore.isMobile ? 'vertical' : 'horizontal'" :label-col="labelCol">
        <AFormItem label="网站名称" name="name">
          <AInput v-model:value="editForm.name" allow-clear show-count :maxlength="30" placeholder="请输入网站名称" />
        </AFormItem>
        <AFormItem label="网站图标" name="avatar">
          <AInput v-model:value="editForm.avatar" allow-clear placeholder="请输入网站图标链接" />
        </AFormItem>
        <AFormItem label="网站链接" name="url">
          <AInput v-model:value="editForm.url" allow-clear placeholder="请输入网站链接" />
        </AFormItem>
        <AFormItem label="网站分类" name="category">
          <ASelect v-model:value="editForm.category" allow-clear placeholder="请选择网站分类">
            <ASelectOption v-for="option in categoryOptions" :key="option.value" :value="option.value">
              {{ option.label }}
            </ASelectOption>
          </ASelect>
        </AFormItem>
        <AFormItem label="网站描述" name="description">
          <ATextarea v-model:value="editForm.description" :rows="3" allow-clear show-count :maxlength="100" placeholder="请输入网站描述" />
        </AFormItem>
      </AForm>
      <div class="modal-footer mt-6 flex justify-end gap-3 border-t border-gray-200 pt-4 dark:border-gray-600">
        <AButton size="middle" @click="closeEditModal">取消</AButton>
        <AButton type="primary" size="middle" :loading="editSubmitLoading" @click="handleEditSubmit">确定</AButton>
      </div>
    </AModal>

    <AModal v-model:open="deleteModalVisible" title="删除友链" :width="modalWidth" :footer="null" wrap-class-name="delete-dialog">
      <div class="delete-content py-4">
        <div class="mb-4 flex items-center">
          <div class="warning-icon mr-3 flex h-8 w-8 items-center justify-center rounded-full">
            <DeleteOutlined />
          </div>
          <div>
            <div class="font-medium text-gray-900">确认删除友链</div>
            <div class="mt-1 text-sm text-gray-500">请选择删除类型，谨慎操作</div>
          </div>
        </div>
        <div class="delete-info mb-4 rounded-lg p-4">
          <p class="text-sm">
            是否确定要删除友链 <span class="font-medium">"{{ currentDeleteFriend?.name }}"</span> ？
          </p>
        </div>
        <div class="delete-type-selection mb-4">
          <div class="mb-3 text-sm font-medium">删除类型：</div>
          <ARadioGroup v-model:value="deleteType" class="w-full">
            <div class="flex flex-col gap-3">
              <ARadio :value="1" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(1)">
                <div class="ml-2">
                  <div class="font-medium">逻辑删除</div>
                  <div class="mt-1 text-xs text-gray-500">友链将被标记为已删除，但数据仍保留在数据库中，可以恢复</div>
                </div>
              </ARadio>
              <ARadio :value="2" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(2)">
                <div class="ml-2">
                  <div class="font-medium">物理删除</div>
                  <div class="mt-1 text-xs text-gray-500">友链将从数据库中彻底删除，此操作不可撤销</div>
                </div>
              </ARadio>
              <ARadio :value="3" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(3)">
                <div class="ml-2">
                  <div class="font-medium">取消删除</div>
                  <div class="mt-1 text-xs text-gray-500">恢复已删除的友链，将其标记为正常状态</div>
                </div>
              </ARadio>
            </div>
          </ARadioGroup>
        </div>
      </div>
      <div class="modal-footer mt-6 flex justify-end gap-3 border-t border-gray-200 pt-4 dark:border-gray-600">
        <AButton size="middle" @click="closeDeleteModal">取消</AButton>
        <AButton type="primary" :danger="deleteType !== 3" size="middle" :loading="deleteLoading" :disabled="!deleteType || isDeleteTypeDisabled(deleteType)" @click="handleDelete">
          {{ deleteType === 1 ? '逻辑删除' : deleteType === 2 ? '物理删除' : deleteType === 3 ? '取消删除' : '确定删除' }}
        </AButton>
      </div>
    </AModal>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, reactive, ref } from 'vue';
import type { FormInstance, FormProps, TableColumnsType, TablePaginationConfig } from 'ant-design-vue';
import { message } from 'ant-design-vue';
import type { Dayjs } from 'dayjs';
import {
  DeleteOutlined,
  DownOutlined,
  EditOutlined,
  PlusOutlined,
  ReloadOutlined,
  SearchOutlined,
  UpOutlined,
  VerticalAlignBottomOutlined,
  VerticalAlignTopOutlined
} from '@ant-design/icons-vue';
import {
  type AdminFriendPageItem,
  createFriend,
  deleteFriend,
  getFriendPageList,
  moveFriendSortFirst,
  moveFriendSortLast,
  setFriendStatus,
  setFriendTop,
  type FriendFormModel,
  updateFriend,
  updateFriendSort
} from '@/service/blog/admin/friend';
import { useAppStore } from '@/store/system/app';

const appStore = useAppStore();
const loading = ref(false);
const tableData = ref<AdminFriendPageItem[]>([]);
const total = ref(0);
const dateRange = ref<[Dayjs, Dayjs] | undefined>();
const createModalVisible = ref(false);
const editModalVisible = ref(false);
const deleteModalVisible = ref(false);
const createSubmitLoading = ref(false);
const editSubmitLoading = ref(false);
const deleteLoading = ref(false);
const editingId = ref<number | null>(null);
const createFormRef = ref<FormInstance>();
const editFormRef = ref<FormInstance>();
const currentDeleteFriend = ref<AdminFriendPageItem | null>(null);
const deleteType = ref<number | null>(null);

const query = reactive({ pageNumber: 1, pageSize: 10, name: '', startDate: '', endDate: '' });
const createForm = reactive<FriendFormModel>({ name: '', avatar: '', category: '', url: '', description: '' });
const editForm = reactive<FriendFormModel>({ name: '', avatar: '', category: '', url: '', description: '' });

const categoryMap: Record<string, string> = {
  tech: '技术类',
  tools: '工具类',
  navigation: '导航类',
  news: '新闻类',
  aggregate: '聚合类',
  life: '生活类',
  rocblog: 'RocBlog优秀站点'
};

const categoryOptions = [
  { value: 'tech', label: '技术类' },
  { value: 'tools', label: '工具类' },
  { value: 'navigation', label: '导航类' },
  { value: 'news', label: '新闻类' },
  { value: 'aggregate', label: '聚合类' },
  { value: 'life', label: '生活类' },
  { value: 'rocblog', label: 'RocBlog优秀站点' }
];

const modalWidth = computed(() => (appStore.isMobile ? '92vw' : 600));
const labelCol = computed(() => (appStore.isMobile ? undefined : { span: 4 }));
const pagination = computed<TablePaginationConfig>(() => ({
  current: query.pageNumber,
  pageSize: query.pageSize,
  total: total.value,
  pageSizeOptions: ['10', '20', '50', '100', '150', '200', '300', '350', '400', '500', '600', '800', '1000', '1500', '2000'],
  showQuickJumper: true,
  showSizeChanger: true,
  showTotal: (value, range) => `第 ${range[0]}-${range[1]} 条，共 ${value} 条`,
  size: appStore.isMobile ? 'small' : 'default'
}));

const columns = computed<TableColumnsType<AdminFriendPageItem>>(() => [
  { title: '序号', key: 'index', width: 70, align: 'center' },
  { title: '网站名称', dataIndex: 'name', key: 'name', width: appStore.isMobile ? 150 : 180, ellipsis: true },
  { title: '网站链接', dataIndex: 'url', key: 'url', width: appStore.isMobile ? 260 : 320, ellipsis: true },
  { title: '分类', dataIndex: 'category', key: 'category', width: 100, align: 'center' },
  { title: '网站图标', key: 'avatar', width: 100, align: 'center' },
  { title: '是否置顶', key: 'isTop', width: 100, align: 'center' },
  { title: '创建时间', dataIndex: 'createTime', key: 'createTime', width: 170, align: 'center', ellipsis: true },
  { title: '审核状态', key: 'status', width: 120, align: 'center' },
  { title: '删除状态', key: 'isDeleted', width: 100, align: 'center' },
  { title: '操作', key: 'action', width: appStore.isMobile ? 220 : 300, align: 'center', className: 'blog-admin-action-column' }
]);
const tableScrollX = computed(() => (appStore.isMobile ? 1240 : 1490));
const tableScrollY = computed(() => (appStore.isMobile ? 'calc(100vh - 360px)' : 'calc(100vh - 400px)'));

const rules: FormProps['rules'] = {
  name: [
    { required: true, message: '请输入网站名称', trigger: 'blur' },
    { min: 1, max: 20, message: '网站名称要求大于1个字符，小于20个字符', trigger: 'blur' }
  ],
  avatar: [{ required: true, message: '请上传网站图标', trigger: 'change' }],
  url: [
    { required: true, message: '请输入网站链接', trigger: 'blur' },
    { pattern: /^https?:\/\/.+/, message: '请输入有效的网站链接', trigger: 'blur' }
  ],
  category: [
    { required: true, message: '请输入网站分类', trigger: 'blur' },
    { min: 1, max: 10, message: '网站分类要求大于1个字符，小于10个字符', trigger: 'blur' }
  ],
  description: [
    { required: true, message: '请输入网站描述', trigger: 'blur' },
    { min: 1, max: 50, message: '网站描述要求大于1个字符，小于50个字符', trigger: 'blur' }
  ]
};

function isDeleted(record: AdminFriendPageItem) {
  return record.isDeleted === true || Number(record.isDeleted) === 1;
}
const currentDeleteFriendDeleted = computed(() =>
  currentDeleteFriend.value ? isDeleted(currentDeleteFriend.value) : false
);
function isDeleteTypeDisabled(type: number) {
  if (type === 1) return currentDeleteFriendDeleted.value;
  if (type === 3) return !currentDeleteFriendDeleted.value;
  return false;
}

function getCreateTime(record: AdminFriendPageItem) {
  return (record as AdminFriendPageItem & { createTime?: string }).createTime || record.createdAt;
}

function normalizeAndSortItems(items: AdminFriendPageItem[]) {
  return items
    .map(item => ({ ...item, status: item.status || 'pending' }))
    .sort((a, b) => {
      if (a.isTop !== b.isTop) return b.isTop ? 1 : -1;
      const sortA = Number(a.sort || 0);
      const sortB = Number(b.sort || 0);
      if (sortA !== sortB) return sortB - sortA;
      return Number(a.id) - Number(b.id);
    });
}

async function loadData() {
  loading.value = true;
  try {
    const res = await getFriendPageList({ ...query });
    if (res.success) {
      const items = res.data.items || res.data.records || [];
      tableData.value = normalizeAndSortItems(items);
      total.value = res.data.totalCount || res.data.total || 0;
    }
  } finally {
    loading.value = false;
  }
}

function handleDateChange(_: unknown, dateStrings: [string, string]) {
  query.startDate = dateStrings[0];
  query.endDate = dateStrings[1];
}

function handleTableChange(page: TablePaginationConfig) {
  query.pageNumber = page.current || 1;
  query.pageSize = page.pageSize || 10;
  loadData();
}

function handleReset() {
  query.pageNumber = 1;
  query.name = '';
  query.startDate = '';
  query.endDate = '';
  dateRange.value = undefined;
  loadData();
}

function resetForm(form: FriendFormModel) {
  Object.assign(form, { name: '', avatar: '', category: '', url: '', description: '', email: undefined });
}

function openCreateModal() {
  resetForm(createForm);
  createModalVisible.value = true;
}

function closeCreateModal() {
  createModalVisible.value = false;
  createSubmitLoading.value = false;
  resetForm(createForm);
}

function openEditModal(record: AdminFriendPageItem) {
  editingId.value = record.id;
  Object.assign(editForm, {
    name: record.name,
    avatar: record.avatar,
    category: record.category,
    url: record.url,
    description: record.description,
    email: record.email || undefined
  });
  editModalVisible.value = true;
}

function closeEditModal() {
  editModalVisible.value = false;
  editSubmitLoading.value = false;
  editingId.value = null;
  resetForm(editForm);
}

async function handleCreateSubmit() {
  await createFormRef.value?.validate();
  createSubmitLoading.value = true;
  try {
    const res = await createFriend({ ...createForm });
    if (res.success) {
      message.success('添加成功');
      closeCreateModal();
      await loadData();
    }
  } finally {
    createSubmitLoading.value = false;
  }
}

async function handleEditSubmit() {
  if (!editingId.value) return;
  await editFormRef.value?.validate();
  editSubmitLoading.value = true;
  try {
    const res = await updateFriend(editingId.value, { ...editForm });
    if (res.success) {
      message.success('更新成功');
      closeEditModal();
      await loadData();
    }
  } finally {
    editSubmitLoading.value = false;
  }
}

async function handleTopChange(record: AdminFriendPageItem) {
  const res = await setFriendTop(record.id, record.isTop);
  if (res.success) message.success(record.isTop ? '置顶成功' : '已取消置顶');
  await loadData();
}

async function handleStatusChange(record: AdminFriendPageItem) {
  const res = await setFriendStatus(record.id, record.status);
  if (res.success) {
    const statusText = { active: '正常', inactive: '停用', pending: '待审核' }[record.status] || record.status;
    message.success(`状态已更新为：${statusText}`);
  }
  await loadData();
}

async function updateFriendSortFunction(id: number, sort: number) {
  const res = await updateFriendSort(id, sort);
  if (!res.success) {
    message.error('更新排序失败');
    await loadData();
    return false;
  }
  message.success('排序更新成功');
  return true;
}

async function moveFriendUp(index: number) {
  if (index === 0) {
    message.warning('已经是第一个了');
    return;
  }

  const currentItem = tableData.value[index];
  const prevItem = tableData.value[index - 1];
  const currentSort = Number(currentItem.sort || 0);
  const prevSort = Number(prevItem.sort || 0);

  currentItem.sort = prevSort;
  prevItem.sort = currentSort;
  tableData.value[index] = prevItem;
  tableData.value[index - 1] = currentItem;

  await Promise.all([updateFriendSortFunction(currentItem.id, currentItem.sort), updateFriendSortFunction(prevItem.id, prevItem.sort)]);
  await loadData();
}

async function moveFriendDown(index: number) {
  if (index === tableData.value.length - 1) {
    message.warning('已经是最后一个了');
    return;
  }

  const currentItem = tableData.value[index];
  const nextItem = tableData.value[index + 1];
  const currentSort = Number(currentItem.sort || 0);
  const nextSort = Number(nextItem.sort || 0);

  currentItem.sort = nextSort;
  nextItem.sort = currentSort;
  tableData.value[index] = nextItem;
  tableData.value[index + 1] = currentItem;

  await Promise.all([updateFriendSortFunction(currentItem.id, currentItem.sort), updateFriendSortFunction(nextItem.id, nextItem.sort)]);
  await loadData();
}

async function moveFriendToFirst(record: AdminFriendPageItem, index: number) {
  if (index === 0) {
    message.warning('已经是第一个了');
    return;
  }

  const res = await moveFriendSortFirst(record.id);
  if (res.success) message.success('已移动到最前面');
  await loadData();
}

async function moveFriendToLast(record: AdminFriendPageItem, index: number) {
  if (index === tableData.value.length - 1) {
    message.warning('已经是最后一个了');
    return;
  }

  const res = await moveFriendSortLast(record.id);
  if (res.success) message.success('已移动到最后面');
  await loadData();
}

function openDeleteModal(record: AdminFriendPageItem) {
  currentDeleteFriend.value = record;
  deleteType.value = isDeleted(record) ? 3 : 1;
  deleteModalVisible.value = true;
}

function closeDeleteModal() {
  deleteModalVisible.value = false;
  currentDeleteFriend.value = null;
  deleteLoading.value = false;
  deleteType.value = null;
}

async function handleDelete() {
  if (!currentDeleteFriend.value || !deleteType.value || isDeleteTypeDisabled(deleteType.value)) return;
  deleteLoading.value = true;
  try {
    const res = await deleteFriend(currentDeleteFriend.value.id, deleteType.value);
    if (res.success) {
      const deleteTypeText = deleteType.value === 1 ? '逻辑删除' : deleteType.value === 2 ? '物理删除' : '取消删除';
      message.success(`${deleteTypeText}成功`);
      closeDeleteModal();
      await loadData();
    }
  } finally {
    deleteLoading.value = false;
  }
}

onMounted(() => {
  loadData();
});
</script>

<style scoped lang="scss">
.category-page {
  height: 100%;
}

.responsive-search-form {
  gap: 12px;

  :deep(.ant-form-item) {
    margin-right: 0;
    margin-bottom: 0;
  }
}

.table-card {
  display: flex;
  flex-direction: column;
}

.table-card :deep(.ant-card-body) {
  display: flex;
  flex: 1;
  min-height: 0;
  overflow: hidden;
  flex-direction: column;
}

.table-card :deep(.ant-spin-nested-loading),
.table-card :deep(.ant-spin-container),
.table-card :deep(.ant-table),
.table-card :deep(.ant-table-container) {
  display: flex;
  flex: 1;
  min-height: 0;
  flex-direction: column;
}

.table-card :deep(.ant-table-body) {
  overflow-y: auto !important;
}

.table-card :deep(.ant-table-thead) {
  position: sticky;
  top: 0;
  z-index: 10;
}

.table-card :deep(.ant-table-thead > tr > th) {
  background: rgb(var(--container-bg-color));
}

.table-card :deep(.deleted-row) {
  opacity: 0.72;
}

.friend-cell-ellipsis {
  display: inline-block;
  max-width: 100%;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  vertical-align: middle;
}

.table-card :deep(.ant-table-cell) {
  word-break: normal;
}

.table-card :deep(.ant-image-img) {
  max-height: 50px;
  object-fit: cover;
}

:global(html:not(.dark)) .warning-icon {
  background: #fff2f0;
  color: #ff4d4f;
}

:global(html.dark) .warning-icon {
  background: rgb(69 35 35);
  color: rgb(248 113 113);
}

:global(html:not(.dark)) .delete-info {
  background: #fafafa;
}

:global(html.dark) .delete-info {
  background: rgb(var(--container-bg-color));
}

@media (max-width: 640px) {
  .responsive-search-form {
    display: flex;
    flex-direction: column;
    align-items: stretch;
  }

  .table-card :deep(.ant-table-cell) {
    height: 58px;
    max-height: 58px;
    padding: 6px 8px !important;
    overflow: hidden;
    white-space: nowrap;
  }

  .table-card :deep(.ant-table-tbody > tr > td) {
    line-height: 22px;
  }

  .table-card :deep(.ant-image),
  .table-card :deep(.ant-image-img) {
    width: 42px !important;
    height: 42px !important;
  }

  .table-card :deep(.ant-switch) {
    min-width: 50px;
  }

  .table-card :deep(.ant-select) {
    width: 86px !important;
  }

  :deep(.blog-admin-action-column) {
    padding-right: 4px !important;
    padding-left: 4px !important;
  }

  :deep(.blog-admin-action-column .ant-space) {
    flex-wrap: nowrap;
    gap: 4px !important;
  }

  :deep(.blog-admin-action-column .ant-btn) {
    width: 24px;
    min-width: 24px;
    height: 24px;
    padding-right: 0;
    padding-left: 0;
  }
}
</style>
