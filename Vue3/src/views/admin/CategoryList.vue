<template>
  <div class="category-list p-6 h-full flex flex-col">
    <!-- 表头分页查询条件 -->
    <a-card :bordered="false" class="mb-15 search-card flex-shrink-0">
      <!-- flex 布局，内容垂直居中 -->
      <div class="flex justify-start items-center search-form">
        <span class="text-sm font-medium">分类名称</span>
        <a-input
          v-model:value="searchCategoryName"
          placeholder="请输入（模糊查询）"
          class="!w-70"
          allow-clear
        />

        <span class="text-sm font-medium">创建日期</span>
        <a-range-picker
          v-model:value="pickDate"
          :placeholder="['开始时间', '结束时间']"
          class="w-80"
          @change="datepickerChange"
        />

        <a-button type="primary" @click="getTableData">
          <template #icon>
            <SearchOutlined />
          </template>
          查询
        </a-button>
        <a-button @click="reset">
          <template #icon>
            <ReloadOutlined />
          </template>
          重置
        </a-button>
      </div>
    </a-card>

    <a-card :bordered="false" class="table-card flex-1 flex flex-col overflow-hidden">
      <!-- 新增按钮 -->
      <div class="table-header mb-5 flex justify-end flex-shrink-0">
        <a-button type="primary" class="add-category-btn" @click="addCategoryBtnClick">
          <template #icon>
            <PlusOutlined />
          </template>
          新增
        </a-button>
      </div>
      <!-- 分页列表 -->
      <div class="table-container flex-1 overflow-hidden">
        <a-table
          :dataSource="tableData"
          :columns="columns"
          :loading="tableLoading"
          :pagination="false"
          bordered
          :scroll="{ x: 1200, y: 'calc(100vh - 550px)' }" 
          :row-key="(record: any) => record.id"
          :row-class-name="(record: CategoryItem) => record.isDeleted === 1 ? 'deleted-row' : ''"
        >
          <template #bodyCell="{ column, record, index}">
            <template v-if="column.key === 'index'">
                {{ index + 1 }}
            </template>
            <template v-else-if="column.key === 'isDeleted'">
                <a-tag color="red" v-if="record.isDeleted === 1">已删除</a-tag>
                <a-tag color="green" v-else>未删除</a-tag>
            </template>
            <template v-else-if="column.key === 'action'">
               <a-space>
                <a-tooltip title="置顶">
                  <a-button
                    size="small"
                    shape="circle"
                    :disabled="index === 0"
                    @click="moveCategoryToFirst(record, index)"
                  >
                    <template #icon>
                      <VerticalAlignTopOutlined />
                    </template>
                  </a-button>
                </a-tooltip>
                <a-tooltip title="置底">
                  <a-button
                    size="small"
                    shape="circle"
                    :disabled="index === tableData.length - 1"
                    @click="moveCategoryToLast(record, index)"
                  >
                    <template #icon>
                      <VerticalAlignBottomOutlined />
                    </template>
                  </a-button>
                </a-tooltip>
                <a-tooltip title="上移">
                  <a-button
                    size="small"
                    shape="circle"
                    :disabled="index === 0"
                    @click="moveCategoryUp(index)"
                  >
                    <template #icon>
                      <UpOutlined />
                    </template>
                  </a-button>
                </a-tooltip>
                <a-tooltip title="下移">
                  <a-button
                    size="small"
                    shape="circle"
                    :disabled="index === tableData.length - 1"
                    @click="moveCategoryDown(index)"
                  >
                    <template #icon>
                      <DownOutlined />
                    </template>
                  </a-button>
                </a-tooltip>
                <a-tooltip title="编辑">
                  <a-button
                    type="primary"
                    size="small"
                    shape="circle"
                    @click="showEditCategoryDialog(record)"
                  >
                    <template #icon>
                      <EditOutlined />
                    </template>
                  </a-button>
                </a-tooltip>
                <a-tooltip title="删除">
                  <a-button
                    danger
                    size="small"
                    shape="circle"
                    @click="deleteCategorySubmit(record)"
                  >
                    <template #icon>
                      <DeleteOutlined />
                    </template>
                  </a-button>
                </a-tooltip>
               </a-space>
            </template>
          </template>
        </a-table>
      </div>

      <!-- 分页 -->
      <div class="pagination-wrapper flex-shrink-0">
      <!-- <div class="pagination-wrapper mt-6 flex justify-center flex-shrink-0"> -->
        <a-pagination
          v-model:current="current"
          v-model:page-size="size"
          :total="total"
          :page-size-options="['10', '20', '50', '100', '150', '200', '300', '350', '400', '500', '600', '800', '1000', '1500', '2000']"
          show-size-changer
          show-quick-jumper
          :show-total="(total: number, range: [number, number]) => `第 ${range[0]}-${range[1]} 条，共 ${total} 条`"
          @change="getTableData"
          @show-size-change="handleSizeChange"
        />
      </div>
    </a-card>

    <!-- 添加分类对话框 -->
    <a-modal
      v-model:open="dialogVisible"
      title="添加文章分类"
      width="480px"
      :footer="null"
    >
      <a-form ref="formRef" :model="form" :rules="rules" layout="vertical">
        <a-form-item label="分类名称" name="name">
          <a-input
            v-model:value="form.name"
            placeholder="请输入分类名称"
            :maxlength="20"
            show-count
            allow-clear
          />
        </a-form-item>
      </a-form>
      <!-- 自定义按钮区域 -->
      <div
        class="modal-footer flex justify-end gap-3 mt-6 pt-4 border-t border-gray-200"
      >
        <a-button size="middle" @click="handleCancel"> 取消 </a-button>
        <a-button
          type="primary"
          size="middle"
          :loading="submitLoading"
          @click="onSubmit"
        >
          确定
        </a-button>
      </div>
    </a-modal>

    <!-- 删除分类确认对话框 -->
    <a-modal
      v-model:open="deleteDialogVisible"
      title="删除分类"
      width="600px"
      :footer="null"
      wrap-class-name="delete-dialog"
    >
      <div class="delete-content py-4">
        <div class="flex items-center mb-4">
          <div
            class="warning-icon w-8 h-8 rounded-full flex items-center justify-center mr-3"
          >
            <DeleteOutlined />
          </div>
          <div>
            <div class="font-medium text-gray-900">确认删除分类</div>
            <div class="text-sm text-gray-500 mt-1">
              请选择删除类型，谨慎操作
            </div>
          </div>
        </div>
        <div class="delete-info p-4 rounded-lg mb-4">
          <p class="text-sm">
            是否确定要删除分类
            <span class="font-medium">"{{ currentDeleteCategory?.name }}"</span>
            ？
          </p>
          <p class="text-xs mt-2">删除后该分类下的所有文章将变为未分类状态</p>
        </div>
        
        <!-- 删除类型选择 -->
        <div class="delete-type-selection mb-4">
          <div class="text-sm font-medium mb-3">删除类型：</div>
          <a-radio-group v-model:value="deleteType" class="w-full">
            <div class="space-y-3">
              <a-radio :value="1" class="flex items-start">
                <div class="ml-2">
                  <div class="font-medium">逻辑删除</div>
                  <div class="text-xs text-gray-500 mt-1">
                    分类将被标记为已删除，但数据仍保留在数据库中，可以恢复
                  </div>
                </div>
              </a-radio>
              <a-radio :value="2" class="flex items-start">
                <div class="ml-2">
                  <div class="font-medium">物理删除</div>
                  <div class="text-xs text-gray-500 mt-1">
                    分类将从数据库中永久删除，此操作不可恢复
                  </div>
                </div>
              </a-radio>
              <a-radio :value="3" class="flex items-start">
                <div class="ml-2">
                  <div class="font-medium">取消删除</div>
                  <div class="text-xs text-gray-500 mt-1">
                    恢复已删除的分类，使其重新可见
                  </div>
                </div>
              </a-radio>
            </div>
          </a-radio-group>
        </div>
      </div>

      <!-- 自定义按钮区域 -->
      <div
        class="modal-footer flex justify-end gap-3 mt-6 pt-4 border-t border-gray-200"
      >
        <a-button size="middle" @click="handleDeleteCancel"> 取消 </a-button>
        <a-button
          type="primary"
          :danger="deleteType !== 3"
          size="middle"
          :loading="deleteLoading"
          :disabled="!deleteType"
          @click="confirmDelete"
        >
          {{ deleteType === 1 ? '确定逻辑删除' : deleteType === 2 ? '确定物理删除' : deleteType === 3 ? '取消删除' : '确定删除' }}
        </a-button>
      </div>
    </a-modal>

    <!-- 编辑分类 -->
    <a-modal
      v-model:open="editCategoryDialogVisible"
      title="编辑分类"
      width="480px"
      :footer="null"
    >
      <a-form
        ref="editFormRef"
        :model="editForm"
        layout="vertical"
        :rules="editRules"
      >
        <a-form-item label="分类名称" name="name">
          <a-input
            v-model:value="editForm.name"
            placeholder="请输入分类名称"
            :maxlength="20"
            show-count
          />
        </a-form-item>
      </a-form>
      <div style="text-align: center; margin-top: 20px">
        <a-space>
          <a-button @click="handleEditCancel">取消</a-button>
          <a-button type="primary" :loading="editLoading" @click="onEditSubmit">确定</a-button>
        </a-space>
      </div>
    </a-modal>
  </div>
</template>

<script setup lang="ts">
import {
  SearchOutlined,
  ReloadOutlined,
  PlusOutlined,
  DeleteOutlined,
  EditOutlined,
  UpOutlined,
  DownOutlined,
  VerticalAlignTopOutlined,
  VerticalAlignBottomOutlined,
} from "@ant-design/icons-vue";
import { ref, reactive, type Ref } from "vue";
import {
    getCategoryPageList,
    addCategory,
    deleteCategory,
    updateCategory,
    updateCategorySort,
    updateCategorySortFirst,
    updateCategorySortLast,
  } from "@/api/admin/category";
import dayjs, { type Dayjs } from "dayjs";
import { message } from "ant-design-vue";
import type { TableColumnsType, FormInstance } from "ant-design-vue";

// 类型定义
interface CategoryItem {
  id: number;
  name: string;
  articlesTotal: number;
  createTime: string;
  sort: number;
  isDeleted: number; // 删除状态：0-未删除，1-已删除
}

interface CategoryForm {
  name: string;
}

interface ApiResponse<T = any> {
  success: boolean;
  data: T;
  message: string;
  current: number;
  size: number;
  total: number;
}

// 分页查询的分类名称
const searchCategoryName: Ref<string> = ref("");
// 日期
const pickDate: Ref<[Dayjs, Dayjs] | null> = ref(null);

// 查询条件：开始结束时间
const startDate: Ref<string | null> = ref(null);
const endDate: Ref<string | null> = ref(null);

// 监听日期组件改变事件，并将开始结束时间设置到变量中
const datepickerChange = (dates: [Dayjs, Dayjs] | null) => {
  if (dates) {
    startDate.value = dayjs(dates[0]).format("YYYY-MM-DD");
    endDate.value = dayjs(dates[1]).format("YYYY-MM-DD");
    console.log(
      "开始时间：" + startDate.value + ", 结束时间：" + endDate.value
    );
  } else {
    startDate.value = null;
    endDate.value = null;
  }
};

// 表格列配置
const columns: TableColumnsType = [
  {
      title: '序号',
      key: 'index',
      width: 80,
      align: 'center',
  },
  {
    title: "分类名称",
    dataIndex: "name",
    key: "name",
    width: 180,
    align: 'center',
  },
  {
    title: "文章数",
    dataIndex: "articlesTotal",
    key: "articlesTotal",
    width: 100,
    align: 'center',
  },
  {
    title: "创建时间",
    dataIndex: "createTime",
    key: "createTime",
    width: 180,
    align: 'center',
  },
  {
    title: "删除状态",
    key: "isDeleted",
    width: 100,
    align: 'center',
  },
  {
    title: "操作",
    key: "action",
    width: 220,
    align: 'center',
  },
];

// 表格加载 Loading
const tableLoading: Ref<boolean> = ref(false);
// 表格数据
const tableData: Ref<CategoryItem[]> = ref([]);
// 当前页码
const current: Ref<number> = ref(1);
// 总数据量
const total: Ref<number> = ref(0);
// 每页显示的数据量
const size: Ref<number> = ref(20);

// 对话框相关
const dialogVisible: Ref<boolean> = ref(false);
const submitLoading: Ref<boolean> = ref(false);

// 删除对话框相关
const deleteDialogVisible: Ref<boolean> = ref(false);
const deleteLoading: Ref<boolean> = ref(false);
const currentDeleteCategory: Ref<CategoryItem | null> = ref(null);
const deleteType: Ref<number | null> = ref(null);

// 编辑分类相关
const editCategoryDialogVisible = ref(false);
const currentEditCategory: Ref<CategoryItem | null> = ref(null);
const editFormRef = ref();
const editLoading = ref(false);
const editForm = reactive({
  id: "",
  name: "",
});
const editRules = {
  name: [
    { required: true, message: "请输入分类名称", trigger: "blur" },
    { max: 20, message: "分类名称不能超过20个字符", trigger: "blur" },
  ],
};

// 获取分页数据
const getTableData = async (): Promise<void> => {
  try {
    // 显示表格 loading
    tableLoading.value = true;
    // 调用后台分页接口，并传入所需参数
    const res: ApiResponse<CategoryItem[]> = await getCategoryPageList({
      current: current.value,
      size: size.value,
      startDate: startDate.value,
      endDate: endDate.value,
      name: searchCategoryName.value,
    });

    if (res.success) {
      // 对数据按sort字段降序排序，sort相同时按id升序排序
      const sortedData = res.data.sort((a, b) => {
        if (a.sort !== b.sort) {
          return b.sort - a.sort; // sort降序
        }
        return a.id - b.id; // id升序
      });
      
      tableData.value = sortedData;
      current.value = res.current;
      size.value = res.size;
      total.value = res.total;
    }
  } catch (error) {
    console.error("获取分类列表失败:", error);
    message.error("获取分类列表失败");
  } finally {
    tableLoading.value = false; // 隐藏表格 loading
  }
};

// 初始化数据
getTableData();

// 每页展示数量变更事件
const handleSizeChange = (current: number, pageSize: number): void => {
  size.value = pageSize;
  getTableData();
};

// 重置查询条件
const reset = (): void => {
  searchCategoryName.value = "";
  pickDate.value = null;
  startDate.value = null;
  endDate.value = null;
  getTableData();
};

// 表单引用
const formRef = ref<FormInstance>();

// 添加文章分类表单对象
const form: CategoryForm = reactive({
  name: "",
});

// 规则校验
const rules = {
  name: [
    {
      required: true,
      message: "分类名称不能为空",
      trigger: "blur",
    },
    {
      min: 1,
      max: 20,
      message: "分类名称字数要求大于 1 个字符，小于 20 个字符",
      trigger: "blur",
    },
  ],
};

// 新增分类按钮点击事件
const addCategoryBtnClick = (): void => {
  dialogVisible.value = true;
};

// 提交表单
const onSubmit = async (): Promise<void> => {
  try {
    await formRef.value?.validate();
    submitLoading.value = true;

    const res: ApiResponse<any> = await addCategory(form);
    if (res.success) {
      message.success("添加成功");
      // 将表单中分类名称置空
      form.name = "";
      // 隐藏对话框
      dialogVisible.value = false;
      // 重新请求分页接口，渲染数据
      getTableData();
    } else {
      message.error(res.message || "添加失败");
    }
  } catch (error) {
    console.error("表单验证失败:", error);
  } finally {
    submitLoading.value = false;
  }
};

// 取消对话框
const handleCancel = (): void => {
  dialogVisible.value = false;
  // 重置表单
  formRef.value?.resetFields();
};

// 删除分类 - 打开确认对话框
const deleteCategorySubmit = (row: CategoryItem): void => {
  currentDeleteCategory.value = row;
  deleteDialogVisible.value = true;
};

// 取消删除
const handleDeleteCancel = (): void => {
  deleteDialogVisible.value = false;
  currentDeleteCategory.value = null;
  deleteLoading.value = false;
  deleteType.value = null;
};

// 确认删除
const confirmDelete = async (): Promise<void> => {
  if (!currentDeleteCategory.value || !deleteType.value) return;

  deleteLoading.value = true;
  try {
    console.log('操作类型:', deleteType.value === 1 ? '逻辑删除' : deleteType.value === 2 ? '物理删除' : '取消删除');
    const res: ApiResponse<any> = await deleteCategory(
      currentDeleteCategory.value.id,
      deleteType.value
    );
    if (res.success) {
      const deleteTypeText = deleteType.value === 1 ? '逻辑删除' : deleteType.value === 2 ? '物理删除' : '取消删除';
      message.success(`${deleteTypeText}成功`);
      // 重新请求分页接口，渲染数据
      getTableData();
      handleDeleteCancel();
    } else {
      message.error(res.message || "操作失败");
    }
  } catch (error) {
    console.error("操作失败:", error);
    message.error("操作失败，请重试");
  } finally {
    deleteLoading.value = false;
  }
};

// 显示编辑分类对话框
const showEditCategoryDialog = (category: CategoryItem): void => {
  currentEditCategory.value = category;
  editForm.id = category.id;
  editForm.name = category.name;
  editCategoryDialogVisible.value = true;
};

// 取消编辑
const handleEditCancel = (): void => {
  editCategoryDialogVisible.value = false;
  currentEditCategory.value = null;
  editForm.id = "";
  editForm.name = "";
  editFormRef.value?.resetFields();
};

// 提交编辑
const onEditSubmit = async (): Promise<void> => {
  try {
    await editFormRef.value?.validate();
    editLoading.value = true;
    
    const res: ApiResponse<any> = await updateCategory({
      id: editForm.id,
      name: editForm.name,
    });
    
    if (res.success) {
      message.success("编辑成功");
      editCategoryDialogVisible.value = false;
      currentEditCategory.value = null;
      editForm.id = "";
      editForm.name = "";
      editFormRef.value?.resetFields();
      await getTableData();
    } else {
      message.error(res.message || "编辑失败");
    }
  } catch (error) {
    console.error("编辑分类失败:", error);
    message.error("编辑失败，请重试");
  } finally {
    editLoading.value = false;
  }
};

// 上移分类
const moveCategoryUp = async (index: number): Promise<void> => {
  if (index === 0) return;
  
  // 在本地数组中交换位置
  const currentItem = tableData.value[index];
  const prevItem = tableData.value[index - 1];
  
  // 交换sort值
  const tempSort = currentItem.sort;
  currentItem.sort = prevItem.sort;
  prevItem.sort = tempSort;
  
  // 更新两个项目的排序
  await updateCategorySortFunction(currentItem.id, currentItem.sort);
  await updateCategorySortFunction(prevItem.id, prevItem.sort);
  
  // 交换数组中的位置
  [tableData.value[index], tableData.value[index - 1]] = [tableData.value[index - 1], tableData.value[index]];
};

// 下移分类
const moveCategoryDown = async (index: number): Promise<void> => {
  if (index === tableData.value.length - 1) return;
  
  // 在本地数组中交换位置
  const currentItem = tableData.value[index];
  const nextItem = tableData.value[index + 1];
  
  // 交换sort值
  const tempSort = currentItem.sort;
  currentItem.sort = nextItem.sort;
  nextItem.sort = tempSort;
  
  // 更新两个项目的排序
  await updateCategorySortFunction(currentItem.id, currentItem.sort);
  await updateCategorySortFunction(nextItem.id, nextItem.sort);
  
  // 交换数组中的位置
  [tableData.value[index], tableData.value[index + 1]] = [tableData.value[index + 1], tableData.value[index]];
};

// 更新分类排序
const updateCategorySortFunction = async (id: number, sort: number): Promise<void> => {
  try {
    const res: ApiResponse<any> = await updateCategorySort(id, sort);
    if (res.success) {
      message.success('排序更新成功');
    } else {
      message.error(res.message || '排序更新失败');
      // 如果更新失败，重新获取数据
      await getTableData();
    }
  } catch (error) {
    console.error('更新分类排序失败:', error);
    message.error('排序更新失败，请重试');
    // 如果更新失败，重新获取数据
    await getTableData();
  }
};

// 移动分类到最前
const moveCategoryToFirst = async (record: CategoryItem, index: number): Promise<void> => {
  if (index === 0) {
    message.warning('已经是第一个了');
    return;
  }
  
  try {
    const res: ApiResponse<any> = await updateCategorySortFirst(record.id, record.sort);
    if (res.success) {
      message.success('置顶成功');
      // 重新获取数据以更新排序
      await getTableData();
    } else {
      message.error(res.message || '置顶失败');
    }
  } catch (error) {
    console.error('置顶分类失败:', error);
    message.error('置顶失败，请重试');
  }
};

// 移动分类到最后
const moveCategoryToLast = async (record: CategoryItem, index: number): Promise<void> => {
  if (index === tableData.value.length - 1) {
    message.warning('已经是最后一个了');
    return;
  }
  
  try {
    const res: ApiResponse<any> = await updateCategorySortLast(record.id, record.sort);
    if (res.success) {
      message.success('置底成功');
      // 重新获取数据以更新排序
      await getTableData();
    } else {
      message.error(res.message || '置底失败');
    }
  } catch (error) {
    console.error('置底分类失败:', error);
    message.error('置底失败，请重试');
  }
};
</script>

<style scoped lang="scss">
// 自定义样式可以在这里添加
.category-list {
  height: calc(100vh - 165px);

  .search-form {
    margin-bottom: 16px;
    gap: 16px;

    .ant-input {
      margin-right: 16px;
    }

    .ant-picker {
      margin-right: 16px;
    }
  }
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
      }
    }
  }

  .action-buttons {
    gap: 8px;
  }

  .table-card {
    :deep(.ant-card-body) {
      display: flex;
      flex-direction: column;
      height: 100%;
      padding: 24px;
    }
  }

  .table-header {
    flex-shrink: 0;
    /* 新增分类按钮样式 */
    .add-category-btn {
      background: linear-gradient(135deg, #667eea 0%, #3bb4e4 100%) !important;
      border: none !important;
      box-shadow: 0 4px 15px 0 rgba(102, 126, 234, 0.3) !important;
      font-weight: 500 !important;
      padding: 8px 15px !important;
      height: auto !important;
      border-radius: 8px !important;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
      &:hover {
          transform: translateY(-2px) !important;
          box-shadow: 0 8px 25px 0 rgba(102, 126, 234, 0.4) !important;
          background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%) !important;
      }
      &:active {
          transform: translateY(0) !important;
          box-shadow: 0 4px 15px 0 rgba(102, 126, 234, 0.3) !important;
      }
      &:focus {
          box-shadow: 0 4px 15px 0 rgba(102, 126, 234, 0.3), 0 0 0 3px rgba(102, 126, 234, 0.1) !important;
      }
      // 移除按钮hover过渡效果，使变化立即生效
      .add-wiki-btn {
          transition: none !important;
      }
      .add-wiki-btn:hover {
          transition: none !important;
      }
    }
  }

  .table-container {
    .ant-table {
      border-radius: 8px;
    }

    :deep(.ant-table) {
      height: 100%;
    }

    :deep(.ant-table-body) {
      // 移除强制滚动设置，让表格的scroll属性控制滚动
    }
  }

  .pagination-container {
    margin-top: 16px;
    text-align: right;
  }


  .pagination-wrapper {
    margin-top: 16px;
    display: flex;
    justify-content: flex-end;
    padding-top: 16px;
    border-top: 1px solid #f0f0f0;
  }
}

// 模态框样式优化
:deep(.ant-modal) {
  .ant-modal-content {
    border-radius: 8px;
  }

  .ant-modal-header {
    border-bottom: 1px solid #f0f0f0;
    padding: 16px 24px;

    .ant-modal-title {
      font-size: 16px;
      font-weight: 600;
    }
  }

  .ant-modal-body {
    padding: 24px;
  }

  .ant-form-item {
    margin-bottom: 20px;

    .ant-form-item-label {
      font-weight: 500;
    }
  }
}

// 自定义按钮区域样式
.modal-footer {
  .ant-btn {
    height: 36px;
    padding: 0 20px;
    font-size: 14px;
    border-radius: 6px;

    &.ant-btn-primary {
      background: #1890ff;
      border-color: #1890ff;

      &:hover {
        background: #40a9ff;
        border-color: #40a9ff;
      }
    }
  }
}

.delete-info {
    background-color: #fff2f0;
    border: 1px solid #ffccc7;
}

.warning-icon {
    background-color: #ff4d4f;
    color: white;
}

// 模态框样式优化
:deep(.ant-modal) {
    .ant-modal-content {
        border-radius: 8px;
    }
    
    .ant-modal-header {
        border-bottom: 1px solid #f0f0f0;
        padding: 16px 24px;
    }
    
    .ant-modal-body {
        padding: 24px;
    }
}

:deep(.delete-dialog) {
    .ant-modal-header {
        .ant-modal-title {
            color: #ff4d4f;
            font-weight: 600;
        }
    }

  // 删除对话框按钮样式
  .modal-footer {
    .ant-btn {
      height: 36px;
      padding: 0 20px;
      font-size: 14px;
      border-radius: 6px;

      &.ant-btn-primary.ant-btn-dangerous {
        background: #ff4d4f;
        border-color: #ff4d4f;
        color: #fff;

        &:hover {
          background: #ff7875;
          border-color: #ff7875;
        }

        &:focus {
          background: #ff4d4f;
          border-color: #ff4d4f;
        }

        &:active {
          background: #d9363e;
          border-color: #d9363e;
        }
      }

      &.ant-btn-default {
        &:hover {
          color: #40a9ff;
          border-color: #40a9ff;
        }
      }
    }
  }
}

// 已删除行的样式
:deep(.deleted-row) {
  background-color: #f5f5f5 !important;
  color: #999 !important;
  
  &:hover {
    background-color: #f5f5f5 !important;
  }
}
</style>