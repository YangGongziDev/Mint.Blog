<template>
  <div>
    <div class="hide-scrollbar">
      <a-modal
        v-model:open="dialogVisible"
        :title="title"
        :width="width"
        height="1280px"
        :destroy-on-close="destroyOnClose"
        :mask-closable="true"
        :keyboard="true"
        :footer="null"
        :mask="true"
        :getContainer="false"
        :centered="false"
        class="wiki-catalog-edit-modal"
        :bodyStyle="{ 
          maxHeight: '70vh', 
          overflowY: 'auto', 
          overflowX: 'hidden',
        }"
      >
        <!-- 添加一级目录按钮 -->
        <div class="add-catalog-section">
          <a-button
            type="primary"
            @click="addCatalogDialogRef?.open"
            class="add-catalog-btn"
            style="margin-bottom: 12px;"
          >
            <template #icon>
              <PlusOutlined />
            </template>
            添加目录
          </a-button>
        </div>
        <!-- 目录内容 -->
        <div class="catalog-tree">
          <div v-for="(catalog, index) in catalogs" :key="catalog.id || index" class="catalog-item level-1">
            <!-- 一级目录 -->
            <div class="catalogue-one">
              
              <!-- 文件夹图标（无子目录时灰色且不可点击） -->
              <a-tooltip :title="(catalog.children && catalog.children.length > 0) 
                  ? (catalog.expanded ? '点击折叠' : '点击展开')
                  : '无子目录，不可展开'"
              >
                <div class="catalog-icon"
                  :class="{ disabled: !(catalog.children && catalog.children.length > 0) }"
                  @click="(catalog.children && catalog.children.length > 0) && toggleExpand(catalog)"
                >
                  <FolderOpenOutlined v-if="catalog.expanded"
                    :class="['folder-icon', 'open', { empty: !(catalog.children && catalog.children.length > 0) }]"
                  />
                  <FolderOutlined v-else
                    :class="['folder-icon', { empty: !(catalog.children && catalog.children.length > 0) }]"
                  />
                </div>
              </a-tooltip>

              <!-- <div class="catalog-expand-icon">
                <RightOutlined v-if="catalog.children && catalog.children.length > 0" :class="['expand-icon', { expanded: catalog.expanded }]"/>
                <div class="expand-placeholder"></div>
              </div> -->
              
              <!-- 一级目录标题 -->
              <div v-if="!catalog.editing" class="catalog-title primary-title" @dblclick="editTitle(catalog.id)">
                {{ catalog.title }}
              </div>

              <!-- 标题输入框 -->
              <div v-else class="catalog-title editing">
                <a-input v-model:value="catalog.title"
                  @blur="onEditTitleInputBlur(catalog.id)"
                  @pressEnter="onEditTitleInputBlur(catalog.id)"
                  placeholder="请输入目录标题"
                  allow-clear
                  class="catalog-title-input"
                />
              </div>

              <!-- 操作按钮 -->
              <div class="catalog-actions">
                <a-dropdown @click="handleCommand" trigger="click">
                  <a-button type="text" class="action-btn">
                    <MoreOutlined />
                  </a-button>
                  <template #overlay>
                    <a-menu @click="handleMenuClick">
                      <a-menu-item :key="`rename-${catalog.id}-${catalog.sort}`">
                        <EditOutlined />
                        重命名
                      </a-menu-item>
                      <a-menu-item
                        :key="`addArticle-${catalog.id}-${catalog.sort}`"
                      >
                        <PlusOutlined />
                        添加文章
                      </a-menu-item>
                      <a-menu-divider v-if="index + 1 > 1" />
                      <a-menu-item
                        v-if="index + 1 > 1"
                        :key="`moveUp-${catalog.id}-${catalog.sort}`"
                      >
                        <UpOutlined />
                        上移
                      </a-menu-item>
                      <a-menu-item
                        v-if="index + 1 < catalogs.length"
                        :key="`moveDown-${catalog.id}-${catalog.sort}`"
                      >
                        <DownOutlined />
                        下移
                      </a-menu-item>
                      <a-menu-divider />
                      <a-menu-item :key="`removeFromCatalog-${catalog.id}-${catalog.sort}`">
                        <DeleteOutlined />
                        移出目录
                      </a-menu-item>
                    </a-menu>
                  </template>
                </a-dropdown>
              </div>

            </div>

            <!-- 子目录 -->
            <div v-if="catalog.children && catalog.children.length > 0 && catalog.expanded" class="catalog-children">
              <VueDraggable ref="el" v-model="catalog.children" @end="onDragEnd">
                <div v-for="(childCatalog, childIndex) in catalog.children"
                  :key="childCatalog.id || childIndex" class="catalog-item child-catalog level-2"
                >
                  <!-- 文章图标 -->
                  <div class="catalog-icon">
                    <FileTextOutlined class="file-icon"/>
                  </div>
                  
                  <!-- 子目录标题 -->
                  <div v-if="!childCatalog.editing" class="catalog-title secondary-title"  @dblclick="editTitle(childCatalog.id)">
                    {{ childCatalog.title }}
                  </div>
                  <!-- 子目录标题输入框 -->
                  <div v-else class="catalog-title editing">
                    <a-input v-model:value="childCatalog.title"
                      @blur="onEditTitleInputBlur(childCatalog.id)"
                      @pressEnter="onEditTitleInputBlur(childCatalog.id)"
                      placeholder="请输入目录标题"
                      allow-clear
                      class="catalog-title-input"
                    />
                  </div>

                  <!-- 子目录操作按钮 -->
                  <div class="catalog-actions">
                    <a-tooltip title="重命名">
                      <a-button type="text" size="small"
                        @click="editTitle(childCatalog.id)"
                      >
                        <EditOutlined />
                      </a-button>
                    </a-tooltip>

                    <a-tooltip v-if="childIndex + 1 > 1" title="上移">
                      <a-button type="text" size="small"
                        @click="moveChildCatalog(catalog.id, childCatalog.id, 'up')"
                      >
                        <UpOutlined />
                      </a-button>
                    </a-tooltip>

                    <a-tooltip v-if="childIndex + 1 < (catalog.children?.length || 0)" title="下移">
                      <a-button type="text" size="small"
                        @click="moveChildCatalog(catalog.id, childCatalog.id, 'down')"
                      >
                        <DownOutlined />
                      </a-button>
                    </a-tooltip>

                    <a-tooltip title="移出目录">
                      <a-button type="text" size="small"
                        @click="removeArticleFromCatalog(childCatalog.id)"
                        class="remove-btn"
                      >
                        <DeleteOutlined />
                      </a-button>
                    </a-tooltip>
                  </div>
                </div>
              </VueDraggable>
            </div>
          </div>
        </div>
        
      </a-modal>
      <!-- 添加目录 -->
      <FormDialog ref="addCatalogDialogRef"
        title="添加目录"
        destroyOnClose
        @submit="onAddCatalogSubmit"
      >
        <a-form ref="addCatalogFormRef"
          :rules="rules"
          :model="addCatalogForm"
          :label-col="{ span: 4 }"
          :wrapper-col="{ span: 20 }"
        >
          <a-form-item label="标题" name="title">
            <a-input v-model:value="addCatalogForm.title"
              placeholder="请输入目录标题"
              allow-clear
            />
          </a-form-item>
        </a-form>
      </FormDialog>
    </div>
    <!-- 添加文章到目录 -->
    <FormDialog
      ref="addArticle2CatalogDialogRef"
      title="添加文章"
      width="80%"
      confirmText="添加"
      destroyOnClose
      @submit="onAddArticle2CatalogSubmit"
    >
      <div>
        <!-- 表头分页查询条件 -->
        <a-card class="search-card">
          <!-- flex 布局，内容垂直居中 -->
          <div class="search-form">
            <span class="search-label">文章标题</span>
            <div class="search-input">
              <a-input
                v-model:value="searchArticleTitle"
                placeholder="请输入（模糊查询）"
                allow-clear
              />
            </div>

            <span class="search-label">创建日期</span>
            <div class="search-date">
              <!-- 日期选择组件（区间选择） -->
              <a-range-picker
                v-model:value="pickDate"
                :presets="shortcuts"
                @change="datepickerChange"
                format="YYYY-MM-DD"
              />
            </div>

            <div style="display: flex; justify-content: right; gap: 4px;">
              <a-button type="primary" class="search-btn" @click="getTableData">
                <SearchOutlined />
                查询
              </a-button>
              <a-button class="reset-btn" @click="reset">
                <ReloadOutlined />
                重置
              </a-button>
            </div>

          </div>
        </a-card>

        <a-card class="table-card">
          <!-- 分页列表 -->
          <a-table
            :data-source="tableData"
            :loading="tableLoading"
            :row-selection="rowSelection" 
            :row-key="(record: Article) => record.id"
            :pagination="false"
            bordered
            size="middle"
          >
            <a-table-column key="id" title="ID" data-index="id" width="50" />
            <a-table-column
              key="title"
              title="标题"
              data-index="title"
              width="380"
            />
            <a-table-column
              key="cover"
              title="封面"
              data-index="cover"
              width="180"
            >
              <template #default="{ record }">
                <a-image :width="100" :src="record.cover" :preview="false" />
              </template>
            </a-table-column>

            <a-table-column
              key="isPublish"
              title="是否发布"
              data-index="isPublish"
              width="100"
            >
              <template #default="{ record }">
                <a-switch
                  v-model:checked="record.isPublish"
                  :checked-children="'已发布'"
                  :un-checked-children="'未发布'"
                  disabled
                />
              </template>
            </a-table-column>
            <a-table-column
              key="createTime"
              title="发布时间"
              data-index="createTime"
            />
          </a-table>

          <!-- 分页 -->
          <div class="pagination-wrapper">
            <a-pagination
              v-model:current="current"
              v-model:page-size="size"
              :page-size-options="['10', '20', '50']"
              :total="total"
              show-size-changer
              show-quick-jumper
              show-total
              @change="getTableData"
              @show-size-change="handleSizeChange"
            />
          </div>
        </a-card>
      </div>
    </FormDialog>
  </div>

</template>

<script setup lang="ts">
import { ref, reactive } from "vue";
import { showModel, showMessage } from "@/composables/util.js";
import { VueDraggable } from "vue-draggable-plus";
import FormDialog from "@/components/admin/FormDialog.vue";
import { getArticlePageList } from "@/api/admin/article.js";
import {
  SearchOutlined,
  ReloadOutlined,
  EditOutlined,
  PlusOutlined,
  MoreOutlined,
  UpOutlined,
  DownOutlined,
  DeleteOutlined,
  RightOutlined,
  FolderOutlined,
  FolderOpenOutlined,
  FileTextOutlined,
} from "@ant-design/icons-vue";
import { getWikiCatalogs, updateWikiCatalogs } from "@/api/admin/wiki.js";

// 类型定义
interface Catalog {
  id: number | string;
  title: string;
  sort: number;
  editing?: boolean;
  expanded?: boolean;
  children?: Catalog[];
  articleId?: number | string;
}

interface Article {
  id: number | string;
  title: string;
  cover: string;
  isPublish: boolean;
  createTime: string;
}

interface AddCatalogForm {
  title: string;
}

interface MenuClickEvent {
  key: string;
}

interface DateRange {
  label: string;
  value: [string, string];
}

// 目录数据
const catalogs = ref<Catalog[]>([]);

// 处理菜单点击事件
const handleMenuClick = (event: MenuClickEvent) => {
  const parts = event.key.split("-");
  if (parts.length < 3) return;

  const [action, id, sort] = parts;
  if (!action || !id || !sort) return;

  const catalogId = parseInt(id, 10);
  const catalogSort = parseInt(sort, 10);

  if (isNaN(catalogId) || isNaN(catalogSort)) return;

  if (action === "rename") {
    // 重命名
    editTitle(catalogId);
  } else if (action === "moveUp") {
    // 上移
    catalogMove(catalogId, catalogSort, "up");
  } else if (action === "moveDown") {
    // 下移
    catalogMove(catalogId, catalogSort, "down");
  } else if (action === "removeFromCatalog") {
    // 移除出目录
    removeCatalog(catalogId);
  } else if (action === "addArticle") {
    // 记录当前被编辑的目录 ID
    currCatalogId.value = catalogId;
    getTableData();
    addArticle2CatalogDialogRef.value?.open();
  }
};

// 兼容旧的handleCommand方法
const handleCommand = (command: any) => {
  if (!command || typeof command !== "object") return;

  if (command.action === "rename") {
    // 重命名
    editTitle(command.id);
  } else if (command.action === "moveUp") {
    // 上移
    catalogMove(command.id, command.sort, "up");
  } else if (command.action === "moveDown") {
    // 下移
    catalogMove(command.id, command.sort, "down");
  } else if (command.action === "removeFromCatalog") {
    // 移除出目录
    removeCatalog(command.id);
  } else if (command.action === "addArticle") {
    // 记录当前被编辑的目录 ID
    currCatalogId.value = command.id;
    getTableData();
    addArticle2CatalogDialogRef.value?.open();
  }
};

// 编辑标题
const editTitle = (catalogId: number | string): void => {
  console.log("目录id" + catalogId);
  // 根据目录 ID 查找对应的目录
  const targetCatalog = findCatalogById(catalogs.value, catalogId);
  if (targetCatalog) {
    // 将编辑状态置为 true
    targetCatalog.editing = true;
  }
};

// 切换展开/折叠状态
const toggleExpand = (catalog: Catalog): void => {
  if (catalog.children && catalog.children.length > 0) {
    catalog.expanded = !catalog.expanded;
  }
};

// 查找对应的目录
function findCatalogById(
  catalogs: Catalog[],
  targetId: number | string
): Catalog | null {
  for (const catalog of catalogs) {
    if (catalog.id === targetId) {
      return catalog; // 找到目标目录，返回它
    }

    if (catalog.children && catalog.children.length > 0) {
      // 递归
      const foundInChildren = findCatalogById(catalog.children, targetId);
      if (foundInChildren) {
        return foundInChildren; // 在子目录中找到目标目录，返回它
      }
    }
  }

  return null; // 没有找到目标目录
}

// 标题输入框 blur 事件
const onEditTitleInputBlur = (catalogId: number | string): void => {
  const targetCatalog = findCatalogById(catalogs.value, catalogId);
  if (targetCatalog) {
    // 将目标目录的 editing 字段置为 false
    targetCatalog.editing = false;
    // 若标题被更新成了空字符串，则给个默认的标题, 提示用户需要输入标题
    targetCatalog.title =
      targetCatalog.title !== "" ? targetCatalog.title : "请输入标题";
    updateWikiCatalogsData();
  }
};

// 移出目录
const removeCatalog = (catalogId: number | string): void => {
  showModel("是否确定移除该目录？")
    .then(() => {
      deleteCatalog(catalogs.value, catalogId);
      console.log(catalogs.value);
      updateWikiCatalogsData();
    })
    .catch((e) => {
      if (e) {
      }
      console.log("取消了");
    });
};

// 移出二级目录中的文章
const removeArticleFromCatalog = (catalogId: number | string): void => {
  showModel("是否确定移除该篇文章？")
    .then(() => {
      deleteCatalog(catalogs.value, catalogId);
      console.log(catalogs.value);
      updateWikiCatalogsData();
    })
    .catch((e) => {
      if (e) {
      }
      console.log("取消了");
    });
};

// 删除 catalogs 数组中对应的目录对象
function deleteCatalog(
  catalogs: Catalog[],
  targetId: number | string
): Catalog[] {
  for (let i = 0; i < catalogs.length; i++) {
    const catalog = catalogs[i];

    // 一级目录删除
    if (catalog && catalog.id === targetId) {
      catalogs.splice(i, 1);
      return catalogs;
    }

    // 二级目录删除
    if (catalog && catalog.children) {
      // 递归
      catalog.children = deleteCatalog(catalog.children, targetId);
    }
  }

  return catalogs;
}

// 菜单上移
function catalogMove(
  catalogId: number | string,
  sort: number,
  action: string
): void {
  // 被移动的目录
  const sourceCatalog = findCatalogById(catalogs.value, catalogId);
  // 目标目录
  const targetCatalog = getCatalogBySort(sort, action);

  // 若没有找到替换的目标目录，则 return
  if (targetCatalog === null || !sourceCatalog) return;

  // 各自的排序号
  const sourceSort = sourceCatalog.sort;
  const targetSort = targetCatalog.sort;
  // 互换排序号
  sourceCatalog.sort = targetSort;
  targetCatalog.sort = sourceSort;
  // 重新排序
  sortCatalogs();
  console.log(catalogs.value);
  updateWikiCatalogsData();
}

// 根据排序规则，得到其需要互换位置的目录
function getCatalogBySort(sort: number, action: string): Catalog | null {
  if (action == "up") {
    // 上移：在降序排序中，上移意味着找到sort值更大的目录
    for (const catalog of catalogs.value) {
      if (catalog.sort > sort) {
        return catalog; // 找到目标目录，返回它
      }
    }
  } else if (action == "down") {
    // 下移：在降序排序中，下移意味着找到sort值更小的目录
    // 复制一份临时数组，从后往前查找
    const tmpCatalogs = [...catalogs.value];
    for (const catalog of tmpCatalogs.reverse()) {
      if (catalog.sort < sort) {
        return catalog; // 找到目标目录，返回它
      }
    }
  }

  return null; // 没有找到目标目录
}

// 重新排序目录
function sortCatalogs(): void {
  // 使用 sort 方法对 sort 字段降序排序，数值越大排序越靠前
  catalogs.value = catalogs.value.sort((a, b) => b.sort - a.sort);
}

// 添加目录对话框引用
const addCatalogDialogRef = ref<InstanceType<typeof FormDialog> | null>(null);
// 添加目录表单引用
const addCatalogFormRef = ref<any>(null);

// 添加目录表单对象
const addCatalogForm = reactive<AddCatalogForm>({
  title: "",
});

// Ant Design Vue 4 表单验证规则
interface FormRules {
  title: Array<{
    required?: boolean;
    message: string;
    trigger?: string;
    validator?: (rule: any, value: any) => Promise<void>;
  }>;
}

// 规则校验
const rules: FormRules = {
  title: [
    {
      required: true,
      message: "目录标题不能为空",
      trigger: "blur",
    },
    {
      message: "目录标题不能超过50个字符",
      validator: async (rule: any, value: string) => {
        if(rule){}
        if (value && value.length > 50) {
          throw new Error("目录标题不能超过50个字符");
        }
      },
      trigger: "blur",
    },
  ],
};

// 临时 ID
const tmpId = ref<number>(-1);
// 添加一级目录提交事件
const onAddCatalogSubmit = (): void => {
  // 先验证 form 表单字段 - Ant Design Vue 4 方式
  addCatalogFormRef.value
    ?.validate()
    .then(() => {
      // 验证通过，执行添加逻辑
      console.log("表单验证通过");

      // 获取当前最大的sort值，新目录排在最前面
      const maxSort = catalogs.value.length > 0 
        ? Math.max(...catalogs.value.map(c => c.sort)) 
        : 0;

      // 构造新的目录对象
      const newCatalog: Catalog = {
        id: tmpId.value, // 新的目录由于没有 ID, 这里给个临时 ID, 负数表示, 标识是一个新添加的目录
        title: addCatalogForm.title,
        editing: false,
        sort: maxSort + 1, // 比当前最大sort值大1，确保排在最前面
        children: [],
      };

      // 添加到目录数组
      catalogs.value.push(newCatalog);

      // 临时 ID 递减
      tmpId.value -= 1;

      // 重置表单
      addCatalogFormRef.value?.resetFields();

      // 关闭对话框
      addCatalogDialogRef.value?.close();

      // 更新数据
      updateWikiCatalogsData();
    })
    .catch((error: any) => {
      console.log("表单验证失败:", error);
    });
};

// 添加文章到目录对话框引用
const addArticle2CatalogDialogRef = ref<InstanceType<typeof FormDialog> | null>(
  null
);

// 模糊搜索的文章标题
const searchArticleTitle = ref<string>("");
// 日期
const pickDate = ref<any>("");

// 查询条件：开始结束时间
const startDate = reactive<{ value: string | null }>({ value: null });
const endDate = reactive<{ value: string | null }>({ value: null });

// 监听日期组件改变事件，并将开始结束时间设置到变量中
const datepickerChange = (e: any): void => {
  if (e && Array.isArray(e) && e.length >= 2) {
    startDate.value = e[0]
      ? new Date(e[0]).toISOString().split("T")[0] || null
      : null;
    endDate.value = e[1]
      ? new Date(e[1]).toISOString().split("T")[0] || null
      : null;
    console.log(
      "开始时间：" +
        (startDate.value || "null") +
        ", 结束时间：" +
        (endDate.value || "null")
    );
  } else {
    startDate.value = null;
    endDate.value = null;
  }
};

const shortcuts: DateRange[] = [
  {
    label: "最近一周",
    value: (() => {
      const end = new Date();
      const start = new Date();
      start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
      return [
        start.toISOString().split("T")[0] as string,
        end.toISOString().split("T")[0] as string,
      ];
    })(),
  },
  {
    label: "最近一个月",
    value: (() => {
      const end = new Date();
      const start = new Date();
      start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
      return [
        start.toISOString().split("T")[0] as string,
        end.toISOString().split("T")[0] as string,
      ];
    })(),
  },
  {
    label: "最近三个月",
    value: (() => {
      const end = new Date();
      const start = new Date();
      start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
      return [
        start.toISOString().split("T")[0] as string,
        end.toISOString().split("T")[0] as string,
      ];
    })(),
  },
];

// 重置
const reset = (): void => {
  pickDate.value = "";
  startDate.value = null;
  endDate.value = null;
  searchArticleTitle.value = "";
};

// 表格加载 Loading
const tableLoading = ref<boolean>(false);
// 表格数据
const tableData = ref<Article[]>([]);
// 当前页码，给了一个默认值 1
const current = ref<number>(1);
// 总数据量，给了个默认值 0
const total = ref<number>(0);
// 每页显示的数据量，给了个默认值 10
const size = ref<number>(10);

// 表格行选择配置
const rowSelection = {
  onChange: (selectedRowKeys: any[], selectedRows: Article[]) => {
    if(selectedRowKeys){}
    selectionArticles.value = selectedRows;
  },
};

// 获取分页数据
function getTableData(): void {
  // 显示表格 loading
  tableLoading.value = true;
  // 调用后台分页接口，并传入所需参数
  getArticlePageList({
    current: current.value,
    size: size.value,
    startDate: startDate.value,
    endDate: endDate.value,
    title: searchArticleTitle.value,
    type: 1,
  })
    .then((res: any) => {
      if (res && res.success === true) {
        tableData.value = res.data || [];
        current.value = res.current || 1;
        size.value = res.size || 10;
        total.value = res.total || 0;
      }
    })
    .catch((error: any) => {
      console.error("获取文章列表失败:", error);
      showMessage("获取文章列表失败", "error");
    })
    .finally(() => (tableLoading.value = false)); // 隐藏表格 loading
}

// 每页展示数量变更事件
const handleSizeChange = (chooseSize: number): void => {
  console.log("选择的页码" + chooseSize);
  size.value = chooseSize;
  getTableData();
};

// 被选择的文章
const selectionArticles = ref<Article[]>([]);
// 表格选择事件
const handleSelectionChange = (articles: Article[]): void => {
  console.log(articles);
  selectionArticles.value = articles;
};

// 当前被编辑的目录 ID
const currCatalogId = ref<number | null>(null);
// 添加文章到目录下
const onAddArticle2CatalogSubmit = (): void => {
  // 校验是否选中文章
  if (!selectionArticles.value || selectionArticles.value.length === 0) {
    showMessage("请勾选需要添加的文章", "warning");
    return;
  }

  for (const catalog of catalogs.value) {
    // 找到当前被编辑的目录
    if (catalog.id === currCatalogId.value) {
      // 循环添加被选中的文章
      for (const selectionArticle of selectionArticles.value) {
        // 文章标题
        const articleTitle: string = selectionArticle.title;
        
        // 获取当前目录下子项的最大sort值
        const maxChildSort = catalog.children && catalog.children.length > 0
          ? Math.max(...catalog.children.map(c => c.sort))
          : 0;
        
        // 构建新的二级目录
        const newCatalog: Catalog = {
          id: tmpId.value,
          articleId: selectionArticle.id,
          title: articleTitle || "未命名文章",
          editing: false,
          children: [],
          sort: maxChildSort + 1, // 比当前最大sort值大1，确保排在最前面
        };
        // 添加到目录数组中
        if (!catalog.children) {
          catalog.children = [];
        }
        catalog.children.push(newCatalog);
        tmpId.value -= 1;
      }
    }
  }
  // 关闭对话框
  addArticle2CatalogDialogRef.value?.close();
  // 置空被选择的文章
  selectionArticles.value = [];
  updateWikiCatalogsData();
};

// 当前知识库 ID
const currWikiId = ref<number | null>(null);
// 获取当前知识库的目录数据
function getCatalogs(): void {
  if (currWikiId.value) {
    getWikiCatalogs(currWikiId.value)
      .then((res: any) => {
        if (res && res.success) {
          catalogs.value = res.data || [];
          // 初始化展开状态
          initExpandState(catalogs.value);
        }
      })
      .catch((error: any) => {
        console.error("获取目录数据失败:", error);
        showMessage("获取目录数据失败", "error");
      });
  }
}

// 初始化展开状态
function initExpandState(catalogList: Catalog[]): void {
  catalogList.forEach(catalog => {
    // 默认展开有子目录的项
    catalog.expanded = catalog.children && catalog.children.length > 0;
  });
}

// 查找某个子目录的父目录
function findParentCatalog(
  catalogList: Catalog[],
  childId: number | string
): Catalog | null {
  for (const catalog of catalogList) {
    if (catalog.children && catalog.children.length > 0) {
      const index = catalog.children.findIndex((c) => c.id === childId);
      if (index !== -1) {
        return catalog; // 找到父目录
      }
      const found = findParentCatalog(catalog.children, childId);
      if (found) return found;
    }
  }
  return null;
}

// 规范化某个父目录下子目录的排序（按降序规则，sort值越大越靠前）
function normalizeChildSort(parent: Catalog): void {
  if (!parent.children) return;
  const length = parent.children.length;
  parent.children.forEach((c, idx) => (c.sort = length - idx));
}

// 上移/下移某个父目录下的子目录
function moveChildCatalog(
  parentId: number | string,
  childId: number | string,
  action: "up" | "down"
): void {
  const parent = findCatalogById(catalogs.value, parentId);
  if (!parent || !parent.children || parent.children.length === 0) return;

  // 确保排序号与当前数组位置一致
  normalizeChildSort(parent);

  const index = parent.children.findIndex((c) => c.id === childId);
  if (index === -1) return;

  // 边界控制
  if (action === "up" && index === 0) return;
  if (action === "down" && index === parent.children.length - 1) return;

  // 交换数组位置
  const swapWith = action === "up" ? index - 1 : index + 1;
  const temp = parent.children[index];
  if (temp && parent.children[swapWith]) {
    parent.children[index] = parent.children[swapWith];
    parent.children[swapWith] = temp;
  }

  // 更新排序号
  normalizeChildSort(parent);

  updateWikiCatalogsData();
}

// 更新知识库目录数据
function updateWikiCatalogsData(): void {
  if (currWikiId.value) {
    updateWikiCatalogs({ id: currWikiId.value, catalogs: catalogs.value })
      .then((res: any) => {
        // 响应失败，提示错误消息
        if (res && res.success === false) {
          const message: string = res.message || "更新失败";
          showMessage(message, "error");
        }

        // 重新渲染目录数据
        getCatalogs();
      })
      .catch((error: any) => {
        console.error("更新目录数据失败:", error);
        showMessage("更新目录数据失败", "error");
      });
  }
}

// 拖拽结束事件
const onDragEnd = (event: any): void => {
  if(event){}
  console.log("拖拽结束");
  updateWikiCatalogsData();
};

// 对话框是否显示
const dialogVisible = ref<boolean>(false);

// 确认按钮加载 loading
const btnLoading = ref<boolean>(false);
// 显示 loading
const showBtnLoading = (): void => {
  btnLoading.value = true;
};
// 隐藏 loading
const closeBtnLoading = (): void => {
  btnLoading.value = false;
};

// 组件属性接口
interface Props {
  title?: string;
  width?: string;
  destroyOnClose?: boolean;
  confirmText?: string;
}

// 对外暴露属性
const props = withDefaults(defineProps<Props>(), {
  width: "40%",
  destroyOnClose: false,
  confirmText: "提交",
});
if(props){}
// 打开
const open = (wikiId: number): void => {
  dialogVisible.value = true;
  console.log("知识库 ID: " + wikiId);
  currWikiId.value = wikiId;
  getCatalogs();
};
// 关闭
const close = (): void => {
  dialogVisible.value = false;
};

// 暴露方法接口
interface ExposedMethods {
  open: (wikiId: number) => void;
  close: () => void;
  showBtnLoading: () => void;
  closeBtnLoading: () => void;
}

// 对外暴露方法
defineExpose<ExposedMethods>({
  open,
  close,
  showBtnLoading,
  closeBtnLoading,
});
</script>

<style lang="scss" scoped>
// 隐藏滚动条的样式类
.hide-scrollbar {
  /* 隐藏滚动条但保持滚动功能 */
  scrollbar-width: none; /* Firefox */
  -ms-overflow-style: none; /* IE 和 Edge */
  
  &::-webkit-scrollbar {
    display: none; /* Chrome, Safari 和 Opera */
  }
}

// 防止模态框影响全局滚动
:deep(.ant-modal-root) {
  overflow: hidden !important;
}

:deep(.ant-modal-mask) {
  overflow: hidden !important;
}

// 确保body在模态框打开时不出现滚动条
:global(body.ant-scrolling-effect) {
  overflow: hidden !important;
}

// 防止模态框容器产生滚动条
:deep(.ant-modal-wrap) {
  overflow: hidden !important;
}

// 确保模态框本身不产生外部滚动
.wiki-catalog-edit-modal {
  :deep(.ant-modal) {
    overflow: hidden !important;
    
    .ant-modal-content {
      overflow: hidden !important;
    }
  }
}
:deep(.ant-modal-body) {
  padding-top: 0 !important;
  max-height: 70vh;
  overflow-y: auto;
}
:deep(.wiki-catalog-edit-modal) {
  .catalog-tree {
    .level-1{
      .catalogue-one{
        display:flex;
        justify-content: center;
        align-items: center;
      }
    }
    .catalog-item {
      display: flex;
      align-items: center;
      padding: 0;
      border-radius: 6px;
      margin-bottom: 4px;
      transition: all 0.2s ease;

      &.level-1 {
        padding: 12px 16px;
        background: linear-gradient(135deg, #fafbfc 0%, #f8f9fa 100%);
        border: 1px solid #e9ecef;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.04);

        &:hover {
          background: linear-gradient(135deg, #f1f3f4 0%, #e8eaed 100%);
          border-color: #d2d7db;
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.08);
          transform: translateY(-1px);
        }

        .catalog-header {
          width: 100%;
          gap: 12px;
        }

        .catalog-expand-icon {
          width: 20px;
          height: 20px;
          display: flex;
          align-items: center;
          justify-content: center;
          cursor: pointer;
          border-radius: 4px;
          transition: all 0.2s ease;

          &:hover {
            background-color: rgba(24, 144, 255, 0.1);
          }

          .expand-icon {
            font-size: 12px;
            color: #666;
            transition: transform 0.2s ease;
          }

          .expand-icon.expanded {
            transform: rotate(90deg);
          }

          .expand-placeholder {
            width: 12px;
            height: 12px;
          }
        }

        .catalog-icon {
          display: flex;
          align-items: center;
          justify-content: center;
          cursor: pointer;
          &.disabled {
            cursor: not-allowed;
          }

          .folder-icon {
            font-size: 24px;
            color: #1890ff;
            transition: color 0.2s ease;
            margin-right: 8px;
            cursor: inherit;
            &.open {
              color: #52c41a;
            }
            &.empty {
              color: #bfbfbf !important;
            }
          }
        }

        .primary-title {
          font-size: 16px;
          font-weight: 600;
          color: #262626;
          line-height: 1.4;
        }
      }

      &.level-2 {
        padding: 8px 12px;
        background: #ffffff;
        border: 1px solid #f0f0f0;
        margin-left: 0;

        &:hover {
          background-color: #f8f9fa;
          border-color: #d9d9d9;
        }

        .catalog-icon {
          display: flex;
          align-items: center;
          justify-content: center;
          margin-right: 8px;

          .file-icon {
            font-size: 14px;
            color: #8c8c8c;
          }
        }

        .secondary-title {
          font-size: 14px;
          font-weight: 400;
          color: #595959;
          line-height: 1.4;
        }
      }

      .catalog-title {
        flex: 1;
        margin-right: 12px;

        &.editing {
          .ant-input {
            border-color: #1890ff;
            box-shadow: 0 0 0 2px rgba(24, 144, 255, 0.2);
          }
        }
      }

      .catalog-actions {
        display: flex;
        gap: 4px;
        opacity: 0.7;
        transition: opacity 0.2s ease;
        .ant-btn {
          padding: 4px 8px;
          height: auto;
          font-size: 12px;
          border-radius: 4px;
          transition: all 0.2s ease;
          &:hover {
            background-color: rgba(24, 144, 255, 0.1);
            border-color: #1890ff;
          }
        }
        .action-btn {
          font-size: 16px !important;
          &:hover {
            background-color: rgba(0, 0, 0, 0.04);
          }
        }

        .remove-btn {
          &:hover {
            background-color: rgba(255, 77, 79, 0.1);
            border-color: #ff4d4f;
            color: #ff4d4f;
          }
        }
      }

      &:hover .catalog-actions {
        opacity: 1;
      }
    }

    .catalog-children {
      margin-left: 52px;
      margin-top: 8px;
      padding-left: 20px;
      border-left: 2px solid #e6f7ff;
      position: relative;
      overflow: hidden;
      animation: slideDown 0.3s ease-out;

      &::before {
        content: '';
        position: absolute;
        left: -1px;
        top: 0;
        bottom: 0;
        width: 2px;
        background: linear-gradient(to bottom, #1890ff 0%, #e6f7ff 100%);
        border-radius: 1px;
      }

      .catalog-item {
        position: relative;
        animation: fadeInUp 0.3s ease-out;

        &::before {
          content: '';
          position: absolute;
          left: -21px;
          top: 50%;
          width: 12px;
          height: 1px;
          background-color: #d9d9d9;
        }
      }
    }

    // 动画定义
    @keyframes slideDown {
      from {
        max-height: 0;
        opacity: 0;
      }
      to {
        max-height: 500px;
        opacity: 1;
      }
    }

    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(-10px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }
  }

  .search-form {
    display: flex;
    align-items: center;
    gap: 12px;
    flex-wrap: wrap;

    .ant-form-item {
      margin-bottom: 16px;
    }

    .search-label {
      display: inline-flex;
      align-items: center;
    }

    .search-input,
    .search-date {
      display: inline-flex;
      align-items: center;
    }

    .search-actions {
      display: flex;
      gap: 12px;
      justify-content: flex-end;

      .ant-btn {
        min-width: 80px;
      }
    }
  }

  .article-table {
    .ant-table {
      .ant-table-thead > tr > th {
        background-color: #fafafa;
        font-weight: 600;
      }

      .ant-table-tbody > tr {
        &:hover {
          background-color: #f5f5f5;
        }
      }
    }

    .table-pagination {
      margin-top: 16px;
      text-align: right;
    }
  }

  .dialog-footer {
    display: flex;
    justify-content: flex-end;
    gap: 12px;
    padding: 16px 0 0;
    border-top: 1px solid #f0f0f0;

    .ant-btn {
      min-width: 80px;
    }
  }

  // Ant Design Vue 4 样式优化
  .ant-modal {
    .ant-modal-header {
      border-bottom: 1px solid #f0f0f0;
      padding: 16px 24px;
    }



    .ant-modal-footer {
      border-top: 1px solid #f0f0f0;
      padding: 16px 24px;
    }
  }

  // 全局覆盖：确认弹框按钮水平且靠右
  :global(.wiki-confirm-modal .ant-modal-confirm-btns) {
    display: flex !important;
    flex-direction: row !important;
    justify-content: flex-end !important;
    gap: 12px;
    width: 100%;
  }

  .ant-card {
    margin-bottom: 16px;

    .ant-card-head {
      border-bottom: 1px solid #f0f0f0;

      .ant-card-head-title {
        font-weight: 600;
      }
    }

    .ant-card-body {
      padding: 16px;
    }
  }

  .ant-form {
    .ant-form-item-label {
      font-weight: 500;
    }

    .ant-input,
    .ant-select,
    .ant-date-picker {
      border-radius: 6px;

      &:focus,
      &:hover {
        border-color: #1890ff;
        box-shadow: 0 0 0 2px rgba(24, 144, 255, 0.2);
      }
    }
  }

  // 响应式设计
  @media (max-width: 768px) {
    .ant-modal {
      margin: 0;
      max-width: 100vw;

      .ant-modal-content {
        border-radius: 0;
      }
    }

    .catalog-tree {
      .catalog-item {
        /* 保持小屏也水平布局 */
        flex-direction: row;
        align-items: center;

        .catalog-actions {
          margin-top: 0;
          width: auto;
          justify-content: flex-end;
        }
      }
    }

    .search-form {
      .search-actions {
        flex-direction: column;
        .ant-btn {
          width: 100%;
        }
      }
    }
  }
}
</style>
