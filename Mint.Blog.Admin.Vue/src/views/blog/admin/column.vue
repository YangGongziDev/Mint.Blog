<template>
  <div class="category-page flex h-full min-h-0 w-full flex-col overflow-hidden">
    <div class="flex-shrink-0 bg-layout pb-4">
      <ACard :bordered="false" class="card-wrapper">
        <AForm layout="inline" class="responsive-search-form">
          <AFormItem label="专栏标题">
            <AInput v-model:value="query.title" allow-clear placeholder="请输入专栏标题" class="w-full sm:w-[220px]" />
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
              <AButton type="primary" @click="openCreateModal">
                <template #icon><PlusOutlined /></template>
                新增
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
        :row-class-name="record => (isColumnDeleted(record as AdminColumnPageItem) ? 'deleted-row' : '')"
        :scroll="{ x: tableScrollX, y: tableScrollY }"
        size="middle"
        @change="handleTableChange"
      >
        <template #bodyCell="{ column, record, index }">
          <template v-if="column.key === 'index'">{{ index + 1 }}</template>
          <template v-else-if="column.key === 'title'">
            <ATypographyParagraph :content="record.title" :ellipsis="{ rows: 2 }" class="column-text-cell !mb-0" />
          </template>
          <template v-else-if="column.key === 'cover'">
            <AImage :width="100" :src="record.cover" />
          </template>
          <template v-else-if="column.key === 'summary'">
            <ATypographyParagraph :content="record.summary" :ellipsis="{ rows: 2 }" class="column-text-cell !mb-0" />
          </template>
          <template v-else-if="column.key === 'articlesTotal'">{{ record.articlesTotal }}</template>
          <template v-else-if="column.key === 'isTop'">
            <ASwitch
              v-model:checked="record.isTop"
              checked-children="置顶"
              un-checked-children="普通"
              @change="() => handleTopChange(record as AdminColumnPageItem)"
            />
          </template>
          <template v-else-if="column.key === 'createdAt'">
            {{ formatDateTime(record.createdAt) }}
          </template>
          <template v-else-if="column.key === 'isPublish'">
            <ASwitch
              v-model:checked="record.isPublish"
              checked-children="发布"
              un-checked-children="草稿"
              @change="() => handlePublishChange(record as AdminColumnPageItem)"
            />
          </template>
          <template v-else-if="column.key === 'isDeleted'">
            <ATag :color="isColumnDeleted(record as AdminColumnPageItem) ? 'error' : 'success'">
              {{ isColumnDeleted(record as AdminColumnPageItem) ? '已删除' : '未删除' }}
            </ATag>
          </template>
          <template v-else-if="column.key === 'action'">
            <ASpace>
              <ATooltip title="置顶">
                <AButton size="small" shape="circle" :disabled="index === 0" @click="moveColumnToFirst(record as AdminColumnPageItem, index)">
                  <template #icon><VerticalAlignTopOutlined /></template>
                </AButton>
              </ATooltip>

              <ATooltip title="置底">
                <AButton
                  size="small"
                  shape="circle"
                  :disabled="index === tableData.length - 1"
                  @click="moveColumnToLast(record as AdminColumnPageItem, index)"
                >
                  <template #icon><VerticalAlignBottomOutlined /></template>
                </AButton>
              </ATooltip>

              <ATooltip title="上移">
                <AButton size="small" shape="circle" :disabled="index === 0" @click="moveColumnUp(record as AdminColumnPageItem, index)">
                  <template #icon><UpOutlined /></template>
                </AButton>
              </ATooltip>

              <ATooltip title="下移">
                <AButton
                  size="small"
                  shape="circle"
                  :disabled="index === tableData.length - 1"
                  @click="moveColumnDown(record as AdminColumnPageItem, index)"
                >
                  <template #icon><DownOutlined /></template>
                </AButton>
              </ATooltip>

              <ATooltip title="编辑">
                <AButton size="small" shape="circle" @click="openEditModal(record as AdminColumnPageItem)">
                  <template #icon><EditOutlined /></template>
                </AButton>
              </ATooltip>

              <ATooltip title="编辑目录">
                <AButton size="small" shape="circle" @click="openCatalogModal(record as AdminColumnPageItem)">
                  <template #icon><UnorderedListOutlined /></template>
                </AButton>
              </ATooltip>

              <ATooltip title="预览">
                <AButton size="small" shape="circle" @click="previewColumn(record as AdminColumnPageItem)">
                  <template #icon><EyeOutlined /></template>
                </AButton>
              </ATooltip>

              <ATooltip title="删除">
                <AButton danger size="small" shape="circle" @click="openDeleteModal(record as AdminColumnPageItem)">
                  <template #icon><DeleteOutlined /></template>
                </AButton>
              </ATooltip>
            </ASpace>
          </template>
        </template>
      </ATable>
    </ACard>

    <AModal v-model:open="formModalVisible" title="新增专栏" class="column-modal" :width="modalWidth" :footer="null">
      <AForm ref="formRef" :model="formModel" :rules="rules" :label-col="{ span: 4 }">
        <AFormItem label="标题" name="title">
          <AInput v-model:value="formModel.title" allow-clear show-count :maxlength="20" placeholder="请输入专栏标题" />
        </AFormItem>
        <AFormItem label="封面" name="cover">
          <div class="cover-picker">
            <label class="upload-preview">
              <input type="file" accept="image/*" style="display:none" @change="handleCoverInputChange" />
              <img v-if="formModel.cover" :src="formModel.cover" class="upload-image" alt="cover" />
              <div v-else class="upload-placeholder">
                <PlusOutlined class="upload-icon" />
                <div class="upload-title">上传封面</div>
                <div class="upload-hint">建议尺寸 200x120px</div>
              </div>
            </label>
            <AButton html-type="button" @click="openGallerySelector('create')">从 RustFS 图库选择</AButton>
          </div>
        </AFormItem>
        <AFormItem label="摘要" name="summary">
          <ATextarea v-model:value="formModel.summary" :rows="3" allow-clear show-count :maxlength="30" placeholder="请输入专栏摘要" />
        </AFormItem>
      </AForm>
      <div class="modal-footer mt-6 flex justify-end gap-3 border-t border-gray-200 pt-4 dark:border-gray-600">
        <AButton size="middle" @click="closeCreateModal">取消</AButton>
        <AButton type="primary" size="middle" :loading="formSubmitLoading" @click="handleSubmit">确定</AButton>
      </div>
    </AModal>

    <AModal v-model:open="editFormModalVisible" title="编辑专栏" class="column-modal" :width="modalWidth" :footer="null">
      <AForm ref="editFormRef" :model="editFormModel" :rules="rules" :label-col="{ span: 4 }">
        <AFormItem label="标题" name="title">
          <AInput v-model:value="editFormModel.title" allow-clear show-count :maxlength="20" placeholder="请输入专栏标题" />
        </AFormItem>
        <AFormItem label="封面" name="cover">
          <div class="cover-picker">
            <label class="upload-preview">
              <input type="file" accept="image/*" style="display:none" @change="handleEditCoverInputChange" />
              <img v-if="editFormModel.cover" :src="editFormModel.cover" class="upload-image" alt="cover" />
              <div v-else class="upload-placeholder">
                <PlusOutlined class="upload-icon" />
                <div class="upload-title">上传封面</div>
                <div class="upload-hint">建议尺寸 200x120px</div>
              </div>
            </label>
            <AButton html-type="button" @click="openGallerySelector('edit')">从 RustFS 图库选择</AButton>
          </div>
        </AFormItem>
        <AFormItem label="摘要" name="summary">
          <ATextarea v-model:value="editFormModel.summary" :rows="3" allow-clear show-count :maxlength="30" placeholder="请输入专栏摘要" />
        </AFormItem>
      </AForm>
      <div class="modal-footer mt-6 flex justify-end gap-3 border-t border-gray-200 pt-4 dark:border-gray-600">
        <AButton size="middle" @click="closeEditModal">取消</AButton>
        <AButton type="primary" size="middle" :loading="editFormSubmitLoading" @click="handleEditSubmit">确定</AButton>
      </div>
    </AModal>

    <AModal v-model:open="deleteModalVisible" title="删除专栏" :width="deleteModalWidth" :footer="null" wrap-class-name="delete-dialog">
      <div class="delete-content py-4">
        <div class="mb-4 flex items-center">
          <div class="warning-icon mr-3 flex h-8 w-8 items-center justify-center rounded-full">
            <DeleteOutlined />
          </div>
          <div>
            <div class="font-medium text-gray-900 dark:text-white">确认删除专栏</div>
            <div class="mt-1 text-sm text-gray-500 dark:text-gray-400">请选择删除方式，不同方式的影响不同</div>
          </div>
        </div>
        <div class="delete-info mb-4 rounded-lg p-4">
          <p class="text-sm">
            是否确定要删除专栏 <span class="font-medium">"{{ currentDeleteColumn?.title }}"</span> ？
          </p>
          <p class="mt-2 text-xs">删除后该专栏下的所有文章将一并删除</p>
        </div>

        <div class="delete-type-selection">
          <div class="mb-3 text-sm font-medium text-gray-900 dark:text-white">删除方式：</div>
          <ARadioGroup v-model:value="deleteType" class="w-full">
            <div class="flex flex-col gap-3">
              <ARadio :value="1" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(1)">
                <div class="ml-2">
                  <div class="font-medium">逻辑删除</div>
                  <div class="mt-1 text-xs text-gray-500">专栏将被标记为已删除，但数据仍保留在数据库中，可以恢复</div>
                </div>
              </ARadio>
              <ARadio :value="2" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(2)">
                <div class="ml-2">
                  <div class="font-medium">物理删除</div>
                  <div class="mt-1 text-xs text-gray-500">专栏将从数据库中彻底删除，包括所有文章，此操作不可撤销</div>
                  <div v-if="(currentDeleteColumn?.articlesTotal ?? 0) > 0" class="mt-1 text-xs text-red-500">
                    当前专栏下还有 {{ currentDeleteColumn?.articlesTotal }} 篇文章，不能物理删除
                  </div>
                </div>
              </ARadio>
              <ARadio :value="3" class="flex w-full items-start" :disabled="isDeleteTypeDisabled(3)">
                <div class="ml-2">
                  <div class="font-medium">取消删除</div>
                  <div class="mt-1 text-xs text-gray-500">恢复已删除的专栏，使其重新可用</div>
                </div>
              </ARadio>
            </div>
          </ARadioGroup>
        </div>
      </div>

      <div class="modal-footer mt-6 flex justify-end gap-3 border-t border-gray-200 pt-4 dark:border-gray-600">
        <AButton size="middle" @click="handleDeleteCancel">取消</AButton>
        <AButton
          type="primary"
          :danger="deleteType !== 3"
          size="middle"
          :loading="deleteLoading"
          :disabled="!deleteType || isDeleteTypeDisabled(deleteType)"
          @click="handleDelete"
        >
          {{ getDeleteButtonText() }}
        </AButton>
      </div>
    </AModal>

    <RustfsImageSelector
      v-model:open="gallerySelectorVisible"
      :selected-url="getGallerySelectedUrl()"
      @select="handleGallerySelect"
    />

    <AModal v-model:open="catalogModalVisible" title="编辑目录" :width="wideModalWidth" @ok="handleCatalogSubmit">
      <div class="catalog-editor">
        <div class="mb-3 mt-3 flex flex-col sm:flex-row sm:justify-between sm:items-center gap-3">
          <AAlert class="sm:mb-0" type="info" show-icon message="一级目录用于分组，二级目录关联文章；保存后会按当前顺序重建目录。" />
          <AButton type="primary" @click="addCatalogParent">
            <template #icon><PlusOutlined /></template>
            新增一级目录
          </AButton>
        </div>
        <AEmpty v-if="catalogItems.length === 0" description="暂无目录，请先新增一级目录" />
        <div v-else class="space-y-4">
          <ACard v-for="(parent, parentIndex) in catalogItems" :key="parent.id" size="small" class="catalog-parent-card">
            <template #title>
              <div class="flex flex-wrap items-center gap-2">
                <span class="text-sm font-medium">一级目录</span>
                <AInput v-model:value="parent.title" placeholder="请输入一级目录标题" class="min-w-[220px] flex-1" />
                <ATag :color="parent.isDeleted ? 'error' : 'success'">{{ parent.isDeleted ? '已删除' : '正常' }}</ATag>
              </div>
            </template>
            <template #extra>
              <ASpace>
                <AButton size="small" :disabled="parentIndex === 0" @click="moveCatalogItem(catalogItems, parentIndex, -1)">上移</AButton>
                <AButton size="small" :disabled="parentIndex === catalogItems.length - 1" @click="moveCatalogItem(catalogItems, parentIndex, 1)">下移</AButton>
                <AButton size="small" @click="parent.isDeleted = !parent.isDeleted">{{ parent.isDeleted ? '恢复' : '逻辑删除' }}</AButton>
                <AButton size="small" danger @click="removeCatalogParent(parentIndex)">移除</AButton>
              </ASpace>
            </template>

            <div class="space-y-2">
              <div v-for="(child, childIndex) in parent.children" :key="child.id" class="catalog-child-row">
                <AInput v-model:value="child.title" placeholder="文章目录标题" class="min-w-[180px] flex-1" />
                <ASelect
                  v-model:value="child.articleId"
                  :options="articleSearchOptions"
                  :loading="articleSearchLoading"
                  show-search
                  :filter-option="false"
                  placeholder="选择文章"
                  class="w-[220px]"
                  @focus="handleArticleSearch('')"
                  @search="handleArticleSearch"
                  @change="(val: any) => handleArticleSelect(val, child)"
                />
                <ATag :color="child.isDeleted ? 'error' : 'success'">{{ child.isDeleted ? '已删除' : '正常' }}</ATag>
                <ASpace>
                  <AButton size="small" :disabled="childIndex === 0" @click="moveCatalogItem(parent.children, childIndex, -1)">上移</AButton>
                  <AButton size="small" :disabled="childIndex === parent.children.length - 1" @click="moveCatalogItem(parent.children, childIndex, 1)">下移</AButton>
                  <AButton size="small" @click="child.isDeleted = !child.isDeleted">{{ child.isDeleted ? '恢复' : '逻辑删除' }}</AButton>
                  <AButton size="small" danger @click="removeCatalogChild(parent, childIndex)">移除</AButton>
                </ASpace>
              </div>
              <AButton type="dashed" block @click="addCatalogChild(parent)">
                <template #icon><PlusOutlined /></template>
                新增文章目录
              </AButton>
            </div>
          </ACard>
        </div>
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
  EyeOutlined,
  PlusOutlined,
  ReloadOutlined,
  SearchOutlined,
  UnorderedListOutlined,
  UpOutlined,
  VerticalAlignBottomOutlined,
  VerticalAlignTopOutlined
} from '@ant-design/icons-vue';
import {
  type AdminColumnCatalogItem,
  type AdminColumnPageItem,
  type ColumnFormModel,
  createColumn,
  deleteColumn,
  getColumnCatalog,
  getColumnPageList,
  setColumnPublish,
  setColumnTop,
  updateColumn,
  updateColumnCatalog,
  updateColumnSort
} from '@/service/blog/admin/column';
import { uploadBlogImage } from '@/service/blog/admin/image';
import { getArticlePageList } from '@/service/blog/admin/article';
import { useAppStore } from '@/store/system/app';
import type { TimeSortOrder } from '@/utils/date-time';
import { compareDateTime, formatDateTime, getAntdTimeSortOrder, getTableSortOrder, resolveTimeSortOrder } from '@/utils/date-time';
import RustfsImageSelector from '@/components/blog/admin/rustfs-image-selector.vue';

const appStore = useAppStore();
const loading = ref(false);
const tableData = ref<AdminColumnPageItem[]>([]);
const total = ref(0);
const dateRange = ref<[Dayjs, Dayjs] | undefined>();
const formModalVisible = ref(false);
const editFormModalVisible = ref(false);
const deleteModalVisible = ref(false);
const catalogModalVisible = ref(false);
const editingId = ref<string | null>(null);
const currentDeleteColumn = ref<AdminColumnPageItem | null>(null);
const currentCatalogColumnId = ref<string | null>(null);
const formRef = ref<FormInstance>();
const editFormRef = ref<FormInstance>();
const formSubmitLoading = ref(false);
const editFormSubmitLoading = ref(false);
const deleteLoading = ref(false);
const deleteType = ref<number | null>(null);
const pendingCoverImage = ref<File | null>(null);
const pendingEditCoverImage = ref<File | null>(null);
const originalCoverUrl = ref('');
const gallerySelectorVisible = ref(false);
const galleryTarget = ref<'create' | 'edit'>('create');
const catalogItems = ref<AdminColumnCatalogItem[]>([]);
const articleSearchLoading = ref(false);
const articleSearchOptions = ref<{ label: string; value: string; title: string }[]>([]);
const query = reactive({
  pageNumber: 1,
  pageSize: 10,
  title: '',
  startDate: '',
  endDate: '',
  sortOrder: undefined as TimeSortOrder | undefined
});
const formModel = reactive<ColumnFormModel>({ title: '', summary: '', cover: '' });
const editFormModel = reactive<ColumnFormModel>({ title: '', summary: '', cover: '' });
const modalWidth = computed(() => (appStore.isMobile ? '92vw' : 600));
const deleteModalWidth = computed(() => (appStore.isMobile ? '92vw' : 600));
const wideModalWidth = computed(() => (appStore.isMobile ? '92vw' : '72vw'));
const pagination = computed<TablePaginationConfig>(() => ({
  current: query.pageNumber,
  pageSize: query.pageSize,
  total: total.value,
  showSizeChanger: true,
  showTotal: value => `共 ${value} 条`,
  size: appStore.isMobile ? 'small' : 'default'
}));

const columns = computed<TableColumnsType<AdminColumnPageItem>>(() => [
  { title: '序号', key: 'index', width: 80, align: 'center' },
  { title: '标题', dataIndex: 'title', key: 'title', width: 220, ellipsis: true },
  { title: '摘要', dataIndex: 'summary', key: 'summary', width: 280, ellipsis: true },
  { title: '封面', key: 'cover', width: 140, align: 'center' },
  { title: '是否置顶', key: 'isTop', width: 100, align: 'center' },
  { title: '文章数', dataIndex: 'articlesTotal', key: 'articlesTotal', width: 100, align: 'center' },
  {
    title: '发布时间',
    dataIndex: 'createdAt',
    key: 'createdAt',
    width: 180,
    align: 'center',
    sorter: (a, b) => compareDateTime(a.createdAt, b.createdAt),
    sortOrder: query.sortOrder ? getAntdTimeSortOrder(query.sortOrder) : undefined,
    sortDirections: ['descend', 'ascend']
  },
  { title: '是否发布', key: 'isPublish', width: 100, align: 'center' },
  { title: '删除状态', dataIndex: 'isDeleted', key: 'isDeleted', width: 120, align: 'center' },
  { title: '操作', key: 'action', width: 250, align: 'center', className: 'blog-admin-action-column' }
]);
const tableScrollX = 1300;
const tableScrollY = computed(() => (appStore.isMobile ? 'calc(100vh - 360px)' : 'calc(100vh - 400px)'));
const rules: FormProps['rules'] = {
  title: [
    { required: true, message: '请输入标题', trigger: 'blur' },
    { min: 1, max: 20, message: '标题要求大于1个字符，小于20个字符', trigger: 'blur' }
  ],
  summary: [
    { required: true, message: '请输入摘要', trigger: 'blur' },
    { min: 1, max: 30, message: '摘要要求大于1个字符，小于30个字符', trigger: 'blur' }
  ],
  cover: [{ required: true, message: '请上传封面', trigger: 'change' }]
};
function isColumnDeleted(record: AdminColumnPageItem) {
  return Boolean((record as AdminColumnPageItem & { isDeleted?: boolean | number }).isDeleted);
}
const currentDeleteColumnDeleted = computed(() =>
  currentDeleteColumn.value ? isColumnDeleted(currentDeleteColumn.value) : false
);
function isDeleteTypeDisabled(type: number) {
  if (type === 1) return currentDeleteColumnDeleted.value;
  if (type === 2) return (currentDeleteColumn.value?.articlesTotal ?? 0) > 0;
  if (type === 3) return !currentDeleteColumnDeleted.value;
  return false;
}

async function loadData() {
  loading.value = true;
  try {
    const res = await getColumnPageList({ ...query });
    if (res.success) {
      const list = res.data.items || res.data.records || [];
      tableData.value = list;
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
function handleTableChange(page: TablePaginationConfig, ...changeArgs: [unknown?, unknown?, { action?: string }?]) {
  query.pageNumber = page.current || 1;
  query.pageSize = page.pageSize || 10;
  if (changeArgs[2]?.action === 'sort') query.sortOrder = resolveTimeSortOrder(getTableSortOrder(changeArgs[1]), query.sortOrder);
  loadData();
}
function handleReset() {
  Object.assign(query, { pageNumber: 1, title: '', startDate: '', endDate: '', sortOrder: undefined });
  dateRange.value = undefined;
  loadData();
}
function resetForm() {
  Object.assign(formModel, { title: '', summary: '', cover: '' });
  pendingCoverImage.value = null;
}
function resetEditForm() {
  Object.assign(editFormModel, { title: '', summary: '', cover: '' });
  pendingEditCoverImage.value = null;
  originalCoverUrl.value = '';
}
function openCreateModal() {
  resetForm();
  formModalVisible.value = true;
}
function closeCreateModal() {
  formModalVisible.value = false;
  formSubmitLoading.value = false;
  resetForm();
}
function openEditModal(record: AdminColumnPageItem) {
  editingId.value = record.id;
  Object.assign(editFormModel, { title: record.title, summary: record.summary, cover: record.cover });
  originalCoverUrl.value = record.cover;
  pendingEditCoverImage.value = null;
  editFormModalVisible.value = true;
}
function closeEditModal() {
  editFormModalVisible.value = false;
  editFormSubmitLoading.value = false;
  editingId.value = null;
  resetEditForm();
}
function previewImage(file: File, target: ColumnFormModel) {
  const reader = new FileReader();
  reader.onload = event => {
    if (event.target?.result) target.cover = event.target.result as string;
  };
  reader.readAsDataURL(file);
}
function handleCoverInputChange(event: Event) {
  const file = (event.target as HTMLInputElement).files?.[0];
  if (file) {
    pendingCoverImage.value = file;
    previewImage(file, formModel);
  }
  (event.target as HTMLInputElement).value = '';
}
function handleEditCoverInputChange(event: Event) {
  const file = (event.target as HTMLInputElement).files?.[0];
  if (file) {
    pendingEditCoverImage.value = file;
    previewImage(file, editFormModel);
  }
  (event.target as HTMLInputElement).value = '';
}
function buildColumnCoverImageName(file: File) {
  const extension = file.name.includes('.') ? `.${file.name.split('.').pop()}` : '';
  return `column_${Date.now()}${extension}`;
}
function getOriginalImageName(url: string) {
  return url ? url.split('/').pop() || '' : '';
}
async function uploadPendingCover(target: ColumnFormModel, file: File | null, oldCoverUrl = '') {
  if (!file) return;
  const res = await uploadBlogImage({
    newImageFile: file,
    newImageOriginalName: buildColumnCoverImageName(file),
    oldImageName: getOriginalImageName(oldCoverUrl)
  });
  if (res.success) target.cover = res.data.url;
}

function openGallerySelector(target: 'create' | 'edit') {
  galleryTarget.value = target;
  gallerySelectorVisible.value = true;
}

function getGallerySelectedUrl() {
  return galleryTarget.value === 'create' ? formModel.cover : editFormModel.cover;
}

function handleGallerySelect(url: string) {
  if (galleryTarget.value === 'create') {
    formModel.cover = url;
    pendingCoverImage.value = null;
    formRef.value?.validateFields(['cover']).catch(() => undefined);
  } else {
    editFormModel.cover = url;
    pendingEditCoverImage.value = null;
    editFormRef.value?.validateFields(['cover']).catch(() => undefined);
  }
}
async function handleSubmit() {
  await formRef.value?.validate();
  formSubmitLoading.value = true;
  try {
    await uploadPendingCover(formModel, pendingCoverImage.value);
    const res = await createColumn({ ...formModel });
    if (res.success) {
      message.success('添加成功');
      closeCreateModal();
      await loadData();
    }
  } finally {
    formSubmitLoading.value = false;
  }
}
async function handleEditSubmit() {
  if (!editingId.value) return;
  await editFormRef.value?.validate();
  editFormSubmitLoading.value = true;
  try {
    await uploadPendingCover(editFormModel, pendingEditCoverImage.value, originalCoverUrl.value);
    const res = await updateColumn(editingId.value, { ...editFormModel });
    if (res.success) {
      message.success('更新成功');
      closeEditModal();
      await loadData();
    }
  } finally {
    editFormSubmitLoading.value = false;
  }
}
async function handleTopChange(record: AdminColumnPageItem) {
  query.sortOrder = undefined;
  const res = await setColumnTop(record.id, record.isTop);
  if (res.success) message.success(record.isTop ? '置顶成功' : '已取消置顶');
  await loadData();
}
async function handlePublishChange(record: AdminColumnPageItem) {
  const res = await setColumnPublish(record.id, record.isPublish);
  if (res.success) message.success(record.isPublish ? '发布成功' : '已取消发布');
  await loadData();
}
async function updateColumnSortValue(id: string, sort: number) {
  const res = await updateColumnSort(id, sort || 0);
  if (!res.success) {
    await loadData();
    return;
  }
  message.success('排序更新成功');
}
async function moveColumnUp(_record: AdminColumnPageItem, index: number) {
  query.sortOrder = undefined;
  if (index === 0) {
    message.warning('已经是第一个了');
    return;
  }

  const current = tableData.value[index];
  const previous = tableData.value[index - 1];
  const currentSort = current.sort || 0;
  current.sort = previous.sort || 0;
  previous.sort = currentSort;
  tableData.value[index] = previous;
  tableData.value[index - 1] = current;
  await updateColumnSortValue(current.id, current.sort);
  await updateColumnSortValue(previous.id, previous.sort);
}
async function moveColumnDown(_record: AdminColumnPageItem, index: number) {
  query.sortOrder = undefined;
  if (index === tableData.value.length - 1) {
    message.warning('已经是最后一个了');
    return;
  }

  const current = tableData.value[index];
  const next = tableData.value[index + 1];
  const currentSort = current.sort || 0;
  current.sort = next.sort || 0;
  next.sort = currentSort;
  tableData.value[index] = next;
  tableData.value[index + 1] = current;
  await updateColumnSortValue(current.id, current.sort);
  await updateColumnSortValue(next.id, next.sort);
}
async function moveColumnToFirst(record: AdminColumnPageItem, index: number) {
  query.sortOrder = undefined;
  if (index === 0) {
    message.warning('已经是第一个了');
    return;
  }

  const maxSort = Math.max(...tableData.value.map(item => item.sort || 0), 0);
  record.sort = maxSort + 1;
  await updateColumnSortValue(record.id, record.sort);
  await loadData();
}
async function moveColumnToLast(record: AdminColumnPageItem, index: number) {
  query.sortOrder = undefined;
  if (index === tableData.value.length - 1) {
    message.warning('已经是最后一个了');
    return;
  }

  const minSort = Math.min(...tableData.value.map(item => item.sort || 0), 0);
  record.sort = minSort - 1;
  await updateColumnSortValue(record.id, record.sort);
  await loadData();
}
function createCatalogItem(level: 1 | 2, sort: number): AdminColumnCatalogItem {
  return {
    id: `temp_${Date.now()}_${Math.random().toString(36).slice(2)}`,
    articleId: '',
    title: '',
    sort,
    level,
    isDeleted: false,
    editing: true,
    children: []
  };
}
function addCatalogParent() {
  catalogItems.value.push(createCatalogItem(1, catalogItems.value.length + 1));
}
function addCatalogChild(parent: AdminColumnCatalogItem) {
  parent.children.push(createCatalogItem(2, parent.children.length + 1));
}
function removeCatalogParent(index: number) {
  catalogItems.value.splice(index, 1);
}
function removeCatalogChild(parent: AdminColumnCatalogItem, index: number) {
  parent.children.splice(index, 1);
}
function handleArticleSearch(searchText: string) {
  articleSearchLoading.value = true;
  getArticlePageList({ pageNumber: 1, pageSize: 20, title: searchText || undefined })
    .then(res => {
      const items = res.data?.records || res.data?.items || [];
      articleSearchOptions.value = items.map(item => ({ label: `${item.title} (${item.id})`, value: item.id, title: item.title }));
    })
    .finally(() => {
      articleSearchLoading.value = false;
    });
}
function handleArticleSelect(articleId: string, child: AdminColumnCatalogItem) {
  const option = articleSearchOptions.value.find(o => o.value === articleId);
  if (option) {
    child.title = option.title;
  }
}
function moveCatalogItem(list: AdminColumnCatalogItem[], index: number, direction: -1 | 1) {
  const targetIndex = index + direction;
  if (targetIndex < 0 || targetIndex >= list.length) return;
  const [item] = list.splice(index, 1);
  list.splice(targetIndex, 0, item);
}
function normalizeCatalogId(id: string) {
  return /^\d+$/.test(id) ? id : '0';
}
function normalizeCatalogForSubmit() {
  return catalogItems.value.map((parent, parentIndex) => ({
    ...parent,
    id: normalizeCatalogId(parent.id),
    title: parent.title.trim(),
    articleId: '0',
    level: 1,
    sort: parentIndex + 1,
    children: parent.children.map((child, childIndex) => ({
      ...child,
      id: normalizeCatalogId(child.id),
      title: child.title.trim(),
      articleId: child.articleId || '0',
      level: 2,
      sort: childIndex + 1,
      children: []
    }))
  }));
}
function validateCatalogItems(catalogs: AdminColumnCatalogItem[]) {
  for (const parent of catalogs) {
    if (!parent.title) return '一级目录标题不能为空';
    for (const child of parent.children) {
      if (!child.title) return '文章目录标题不能为空';
      if (!child.articleId) return '请选择文章';
    }
  }
  return '';
}
async function openCatalogModal(record: AdminColumnPageItem) {
  currentCatalogColumnId.value = record.id;
  const res = await getColumnCatalog(record.id);
  if (res.success) {
    catalogItems.value = res.data || [];
    catalogModalVisible.value = true;
  }
}
async function handleCatalogSubmit() {
  if (!currentCatalogColumnId.value) return;
  const catalogs = normalizeCatalogForSubmit();
  const errorMessage = validateCatalogItems(catalogs);
  if (errorMessage) {
    message.error(errorMessage);
    return;
  }
  const res = await updateColumnCatalog(currentCatalogColumnId.value, { catalogs });
  if (res.success) {
    message.success('目录已保存');
    catalogModalVisible.value = false;
  }
}
function openDeleteModal(record: AdminColumnPageItem) {
  currentDeleteColumn.value = record;
  deleteType.value = isColumnDeleted(record) ? 3 : 1;
  deleteModalVisible.value = true;
}
function previewColumn(record: AdminColumnPageItem) {
  window.open(`/blog/surfer/column/${record.id}`, '_blank');
}
function handleDeleteCancel() {
  deleteModalVisible.value = false;
  currentDeleteColumn.value = null;
  deleteLoading.value = false;
  deleteType.value = null;
}
function getDeleteButtonText() {
  if (deleteType.value === 1) return '逻辑删除';
  if (deleteType.value === 2) return '物理删除';
  if (deleteType.value === 3) return '取消删除';
  return '确定删除';
}
async function handleDelete() {
  if (!currentDeleteColumn.value || !deleteType.value || isDeleteTypeDisabled(deleteType.value)) return;
  deleteLoading.value = true;
  try {
    const res = await deleteColumn(currentDeleteColumn.value.id, deleteType.value);
    if (res.success) {
      message.success(`${getDeleteButtonText()}成功`);
      await loadData();
      handleDeleteCancel();
    }
  } finally {
    deleteLoading.value = false;
  }
}
onMounted(() => loadData());
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

.column-text-cell {
  max-width: 100%;
  overflow-wrap: anywhere;
  word-break: break-word;
}

.catalog-editor {
  max-height: 70vh;
  overflow-y: auto;
  padding-right: 4px;
}

.catalog-parent-card :deep(.ant-card-head) {
  align-items: flex-start;
  padding-block: 10px;
}

.catalog-parent-card :deep(.ant-card-head-title) {
  min-width: 0;
}

.catalog-child-row {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 8px;
  padding: 8px;
  border: 1px solid rgb(var(--base-text-color) / 10%);
  border-radius: 8px;
  background: rgb(var(--base-text-color) / 3%);
}
.cover-picker {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 12px;
}
.upload-preview {
  position: relative;
  width: 220px;
  height: 132px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  cursor: pointer;
  border: 1px dashed rgb(var(--base-text-color) / 22%);
  border-radius: 12px;
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
.upload-image {
  display: block;
  width: calc(100% - 12px);
  height: calc(100% - 12px);
  border-radius: 10px;
  object-fit: contain;
  background: rgb(var(--container-bg-color));
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
  font-size: 26px;
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
:global(html:not(.dark)) .delete-info {
  border: 1px solid #ffccc7;
  background-color: #fff2f0;
}

:global(html.dark) .delete-info {
  border: 1px solid rgb(127 55 55);
  background-color: rgb(69 35 35);
}

:global(html:not(.dark)) .warning-icon {
  background-color: #ff4d4f;
  color: white;
}

:global(html.dark) .warning-icon {
  background-color: rgb(248 113 113);
  color: white;
}

:deep(.delete-dialog) {
  .ant-modal-header {
    .ant-modal-title {
      color: #ff4d4f;
      font-weight: 600;
    }
  }
}

:global(html:not(.dark)) :deep(.deleted-row) {
  background-color: #f5f5f5 !important;
  color: #999 !important;

  td {
    background-color: #f5f5f5 !important;
    color: #999 !important;
  }
}

:global(html.dark) .table-card :deep(.deleted-row) {
  background-color: rgb(45 52 63) !important;
  color: rgb(148 163 184) !important;

  td {
    background-color: rgb(45 52 63) !important;
    color: rgb(148 163 184) !important;
  }
}

@media (max-width: 640px) {
  .responsive-search-form {
    display: flex;
    flex-direction: column;
    align-items: stretch;
  }
  .responsive-search-form :deep(.ant-form-item-control),
  .responsive-search-form :deep(.ant-form-item-control-input-content) {
    width: 100%;
  }
  :deep(.blog-admin-action-column) {
    padding-right: 4px !important;
    padding-left: 4px !important;
  }
  :deep(.blog-admin-action-column .ant-btn) {
    padding-right: 0;
    padding-left: 0;
  }
  .upload-preview {
    width: 136px;
    height: 86px;
  }
}
</style>
