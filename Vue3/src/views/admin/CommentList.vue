<template>
    <div class="comment-list p-6 h-full flex flex-col">
        <!-- 表头分页查询条件 -->
        <a-card class="mb-5 search-card flex-shrink-0">
            <!-- flex 布局，内容垂直居中 -->
            <div class="flex justify-start items-center search-form">
                <span class="text-sm">路由地址</span>
                <div class="ml-3 w-52 mr-5">
                    <a-input v-model:value="searchRouterUrl" placeholder="请输入（模糊查询）" allow-clear />
                </div>

                <span class="text-sm">创建日期</span>
                <div class="ml-3 w-50 mr-5">
                    <!-- 日期选择组件（区间选择） -->
                    <a-range-picker v-model:value="pickDate" :shortcuts="shortcuts" format="YYYY-MM-DD" :placeholder="['开始时间', '结束时间']" @change="datepickerChange" />
                </div>

                <span class="text-sm">状态</span>
                <div class="ml-3 w-30 mr-5">
                    <a-select v-model:value="status" placeholder="请选择" allow-clear>
                        <a-select-option v-for="item in statusOptions" :key="item.value" :value="item.value">
                            {{ item.label }}
                        </a-select-option>
                    </a-select>
                </div>

                <a-button type="primary" class="ml-3" @click="getTableData">
                    <template #icon><SearchOutlined /></template>
                    查询
                </a-button>
                <a-button class="ml-3" @click="reset">
                    <template #icon><ReloadOutlined /></template>
                    重置
                </a-button>
            </div>
        </a-card>

        <a-card class="table-card flex-1 flex flex-col overflow-hidden">
            <!-- 分页列表 -->
            <div class="table-container flex-1 overflow-hidden">
                <a-table 
                    :data-source="tableData" 
                    :columns="columns" 
                    :loading="tableLoading" 
                    :pagination="false"
                    bordered
                    :scroll="{ x: 1200, y: 'calc(100vh - 550px)' }"
                    :row-key="(record: any) => record.id"
                    :row-class-name="(record: CommentItem) => record.isDeleted === 1 ? 'deleted-row' : ''"
            >
                <template #bodyCell="{ column, record, index }">
                    <template v-if="column.key === 'index'">
                        {{ index + 1 }}
                    </template>
                    <template v-else-if="column.key === 'routerUrl'">
                        <a :href="'#' + record.routerUrl" target="_blank" class="text-blue-500 hover:text-blue-700">
                            {{ record.routerUrl }}
                        </a>
                    </template>
                    <template v-else-if="column.key === 'avatar'">
                        <a-avatar :size="40" :src="record.avatar" />
                    </template>
                    <template v-else-if="column.key === 'status'">
                        <a-tag color="orange" v-if="record.status == 1">待审核</a-tag>
                        <a-tag color="green" v-else-if="record.status == 2">正常</a-tag>
                        <a-tag color="red" v-else-if="record.status == 3">审核不通过</a-tag>
                    </template>
                    <template v-else-if="column.key === 'isDeleted'">
                        <a-tag color="red" v-if="record.isDeleted === 1">已删除</a-tag>
                        <a-tag color="green" v-else>未删除</a-tag>
                    </template>
                    <template v-else-if="column.key === 'action'">
                        <a-space>
                            <a-tooltip title="详情">
                                <a-button size="small" shape="circle" @click="showDetailDialog(record)">
                                    <template #icon><FileTextOutlined /></template>
                                </a-button>
                            </a-tooltip>

                            <a-tooltip title="审核">
                                <a-button size="small" shape="circle" @click="showEditDetailDialog(record)">
                                    <template #icon><EditOutlined /></template>
                                </a-button>
                            </a-tooltip>

                            <a-tooltip title="删除">
                                <a-button danger size="small" shape="circle" @click="deleteCommentSubmit(record)">
                                    <template #icon><DeleteOutlined /></template>
                                </a-button>
                            </a-tooltip>
                        </a-space>
                    </template>
                </template>
                </a-table>
            </div>
            
            <!-- 分页 -->
            <!-- <div class="pagination-wrapper mt-5 flex justify-center flex-shrink-0">
                <a-pagination
                    v-model:current="current" 
                    v-model:page-size="size" 
                    :total="total"
                    show-size-changer
                    show-quick-jumper
                    :show-total="(total: number, range: [number, number]) => `共 ${total} 条记录，当前显示第 ${range[0]}-${range[1]} 条`"
                    :page-size-options="['10', '20', '50', '100', '150', '200', '300', '350', '400', '500', '600', '800', '1000', '1500', '2000']"
                    @change="(page: number) => { current.value = page; getTableData(); }"
                    @show-size-change="(current: number, size: number) => { handleSizeChange(size); }"
                />
            </div> -->
            <div class="pagination-wrapper mt-10 flex justify-center flex-shrink-0">
                <a-pagination 
                    v-model:current="current" 
                    v-model:page-size="size" 
                    :page-size-options="['10', '20', '50', '100', '150', '200', '300', '350', '400', '500', '600', '800', '1000', '1500', '2000']"
                    :total="total"
                    show-size-changer
                    show-quick-jumper
                    :show-total="(total: number, range: [number, number]) => `第 ${range[0]}-${range[1]} 条，共 ${total} 条`"
                    @change="getTableData" 
                    @show-size-change="handleSizeChange"
                />
            </div>
        </a-card>

        <!-- 查看评论详情 -->
        <a-modal v-model:open="detailDialogVisible" title="评论详情" width="700px">
            <a-form :model="commentDetail" :label-col="{ span: 3 }" :wrapper-col="{ span: 20 }">
                <a-form-item label="路由">
                    <a-input v-model:value="commentDetail.routerUrl" disabled />
                </a-form-item>
                <a-form-item label="头像">
                    <a-avatar :size="40" :src="commentDetail.avatar" />
                </a-form-item>
                <a-form-item label="昵称">
                    <a-input v-model:value="commentDetail.nickname" disabled />
                </a-form-item>

                <a-form-item label="评论内容">
                    <a-textarea v-model:value="commentDetail.content" disabled :rows="4" />
                </a-form-item>
                <a-form-item label="网站">
                    <a-input v-model:value="commentDetail.website" disabled />
                </a-form-item>
                <a-form-item label="邮箱">
                    <a-input v-model:value="commentDetail.mail" disabled />
                </a-form-item>
                <a-form-item label="发布时间">
                    <a-input v-model:value="commentDetail.createTime" disabled />
                </a-form-item>
                <a-form-item label="状态">
                    <a-tag color="orange" v-if="commentDetail.status == 1">待审核</a-tag>
                    <a-tag color="green" v-else-if="commentDetail.status == 2">正常</a-tag>
                    <a-tag color="red" v-else-if="commentDetail.status == 3">审核不通过</a-tag>
                </a-form-item>
                <a-form-item label="原因">
                    <a-textarea v-model:value="commentDetail.reason" disabled :rows="4" />
                </a-form-item>
            </a-form>
            <template #footer>
                <div style="display: flex; justify-content: flex-end;">
                    <a-button @click="detailDialogVisible = false">退出</a-button>
                </div>
            </template>
        </a-modal>

        <!-- 评论审核 -->
        <a-modal 
            v-model:open="editDialogVisible" 
            title="审核评论" 
            width="500px"
            :footer="null"
        >
            <a-form ref="formRef" :rules="rules" :model="form" :label-col="{ span: 4 }" :wrapper-col="{ span: 20 }">
                <a-form-item label="状态" name="status">
                    <a-radio-group v-model:value="form.status">
                        <a-radio value="2">通过</a-radio>
                        <a-radio value="3">不通过</a-radio>
                    </a-radio-group>
                </a-form-item>
                <a-form-item label="原因" name="reason" v-if="form.status == '3'">
                    <a-textarea 
                        placeholder="请填写审核不通过的原因" 
                        v-model:value="form.reason" 
                        :rows="6" 
                    />
                </a-form-item>
            </a-form>
            
            <!-- 自定义按钮区域 -->
            <div class="modal-footer flex justify-end gap-3 mt-6 pt-4 border-t border-gray-200">
                <a-button 
                    size="middle" 
                    @click="editDialogVisible = false"
                >
                    取消
                </a-button>
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

        <!-- 删除评论确认对话框 -->
        <a-modal 
            v-model:open="deleteDialogVisible" 
            title="删除评论" 
            width="550px"
            :footer="null"
            wrap-class-name="delete-dialog"
        >
            <div class="delete-content py-4">
                <div class="flex items-center mb-4">
                    <div class="warning-icon w-8 h-8 rounded-full flex items-center justify-center mr-3">
                        <DeleteOutlined />
                    </div>
                    <div>
                        <div class="font-medium text-gray-900">确认删除评论</div>
                        <div class="text-sm text-gray-500 mt-1">请选择删除类型，谨慎操作</div>
                    </div>
                </div>
                <div class="delete-info p-4 rounded-lg mb-4">
                    <p class="text-sm">
                        是否确定要删除该评论，以及其子评论？
                    </p>
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
                                        评论将被标记为已删除，但数据仍保留在数据库中，可以恢复
                                    </div>
                                </div>
                            </a-radio>
                            <a-radio :value="2" class="flex items-start">
                                <div class="ml-2">
                                    <div class="font-medium">物理删除</div>
                                    <div class="text-xs text-gray-500 mt-1">
                                        评论将从数据库中彻底删除，包括所有回复，此操作不可撤销
                                    </div>
                                </div>
                            </a-radio>
                            <a-radio :value="3" class="flex items-start">
                                <div class="ml-2">
                                    <div class="font-medium">取消删除</div>
                                    <div class="text-xs text-gray-500 mt-1">
                                        恢复已删除的评论，使其重新可见
                                    </div>
                                </div>
                            </a-radio>
                        </div>
                    </a-radio-group>
                </div>
            </div>
            
            <!-- 自定义按钮区域 -->
            <div class="modal-footer flex justify-end gap-3 mt-6 pt-4 border-t border-gray-200">
                <a-button 
                    size="middle" 
                    @click="handleDeleteCancel"
                >
                    取消
                </a-button>
                <a-button 
                    type="primary" 
                    :danger="deleteType !== 3"
                    size="middle" 
                    :loading="deleteLoading"
                    :disabled="!deleteType"
                    @click="confirmDelete"
                >
                    {{ deleteType === 1 ? '逻辑删除' : deleteType === 2 ? '物理删除' : deleteType === 3 ? '取消删除' : '确定删除' }}
                </a-button>
            </div>
        </a-modal>
    </div>
</template>

<script setup lang="ts">
import { ref, reactive, type Ref } from 'vue'
import { getCommentPageList, deleteComment, examineComment } from '@/api/admin/comment'
import { 
    SearchOutlined, 
    ReloadOutlined, 
    DeleteOutlined, 
    EditOutlined, 
    FileTextOutlined 
} from '@ant-design/icons-vue'
import moment from 'moment'
import { showMessage, showModel } from '@/composables/util.ts'
import type { FormInstance } from 'ant-design-vue'
import type { TableColumnsType } from 'ant-design-vue'

// 定义接口类型
interface CommentItem {
    id: number
    routerUrl: string
    avatar: string
    nickname: string
    content: string
    website: string
    mail: string
    createTime: string
    status: number
    reason: string
    isDeleted: number // 删除状态：0-未删除，1-已删除
}

interface StatusOption {
    value: number
    label: string
}

interface FormData {
    id: number | null
    status: string
    reason: string
}

// 模糊搜索的路由
const searchRouterUrl: Ref<string> = ref('')
// 日期
const pickDate: Ref<[moment.Moment, moment.Moment] | null> = ref(null)

// 查询条件：开始结束时间
const startDate = reactive({ value: '' })
const endDate = reactive({ value: '' })

// 监听日期组件改变事件，并将开始结束时间设置到变量中
const datepickerChange = (dates: [moment.Moment, moment.Moment] | null) => {
    if (dates) {
        startDate.value = moment(dates[0]).format('YYYY-MM-DD')
        endDate.value = moment(dates[1]).format('YYYY-MM-DD')
        console.log('开始时间：' + startDate.value + ', 结束时间：' + endDate.value)
    } else {
        startDate.value = ''
        endDate.value = ''
    }
}

const shortcuts = [
    {
        text: '最近一周',
        value: (): [Date, Date] => {
            const end = new Date()
            const start = new Date()
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 7)
            return [start, end]
        },
    },
    {
        text: '最近一个月',
        value: (): [Date, Date] => {
            const end = new Date()
            const start = new Date()
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 30)
            return [start, end]
        },
    },
    {
        text: '最近三个月',
        value: (): [Date, Date] => {
            const end = new Date()
            const start = new Date()
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 90)
            return [start, end]
        },
    },
]

// 当前选择的评论状态
const status: Ref<number | null> = ref(null)
// 评论状态 select
const statusOptions: StatusOption[] = [
    {
        value: 1,
        label: '待审核',
    },
    {
        value: 2,
        label: '正常',
    },
    {
        value: 3,
        label: '审核未通过',
    },
]

// 重置查询条件
const reset = (): void => {
    pickDate.value = null;
    startDate.value = '';
    endDate.value = '';
    searchRouterUrl.value = '';
    status.value = null;
    getTableData();
}

// 表格加载 Loading
const tableLoading: Ref<boolean> = ref(false)
// 表格数据
const tableData: Ref<CommentItem[]> = ref([])
// 当前页码
const current = ref<number>(1)
// 总数据量，给了个默认值 0
const total: Ref<number> = ref(0)
// 每页显示的数据量
const size = ref<number>(20)

// 表格列定义
const columns: TableColumnsType = [
    {
        title: '序号',
        key: 'index',
        width: 80,
        align: 'center'
    },
    {
        title: '路由',
        key: 'routerUrl',
        dataIndex: 'routerUrl',
    },
    {
        title: '头像',
        key: 'avatar',
        width: 70,
    },
    {
        title: '昵称',
        key: 'nickname',
        dataIndex: 'nickname',
    },
    {
        title: '评论内容',
        key: 'content',
        dataIndex: 'content',
    },
    {
        title: '发布时间',
        key: 'createTime',
        dataIndex: 'createTime',
        width: 180,
        align: 'center',
    },
    {
        title: '状态',
        key: 'status',
        width: 100,
        align: 'center',
    },
    {
        title: '删除状态',
        key: 'isDeleted',
        width: 100,
        align: 'center',
    },
    {
        title: '操作',
        key: 'action',
        fixed: 'right',
        width: 150,
        align: 'center',
    },
]

// 获取分页数据
function getTableData(): void {
    // 显示表格 loading
    tableLoading.value = true
    // 调用后台分页接口，并传入所需参数
    getCommentPageList({
        current: current.value, 
        size: size.value, 
        startDate: startDate.value,
        endDate: endDate.value, 
        routerUrl: searchRouterUrl.value, 
        status: status.value
    })
        .then((res: any) => {
            if (res.success == true) {
                tableData.value = res.data
                current.value = res.current
                size.value = res.size
                total.value = res.total
            }
        })
        .finally(() => tableLoading.value = false) // 隐藏表格 loading
}
getTableData()

// 每页展示数量变更事件
const handleSizeChange = (current: number, pageSize: number): void => {
    size.value = pageSize
    getTableData()
}

// 删除评论 - 打开确认对话框
const deleteCommentSubmit = (row: CommentItem): void => {
    currentDeleteComment.value = row
    deleteDialogVisible.value = true
}

// 取消删除
const handleDeleteCancel = (): void => {
    deleteDialogVisible.value = false
    currentDeleteComment.value = null
    deleteLoading.value = false
    deleteType.value = null
}

// 确认删除
const confirmDelete = async (): Promise<void> => {
    if (!currentDeleteComment.value || !deleteType.value) return
    
    deleteLoading.value = true
    try {
        console.log('操作类型:', deleteType.value === 1 ? '逻辑删除' : deleteType.value === 2 ? '物理删除' : '取消删除')
        const res: any = await deleteComment(currentDeleteComment.value.id, deleteType.value)
        if (res.success) {
            const deleteTypeText = deleteType.value === 1 ? '逻辑删除' : deleteType.value === 2 ? '物理删除' : '取消删除'
            showMessage(`${deleteTypeText}成功`)
            // 重新请求分页接口，渲染数据
            getTableData()
            handleDeleteCancel()
        } else {
            showMessage(res.message || '操作失败', 'error')
        }
    } catch (error) {
        console.error('操作失败:', error)
        showMessage('操作失败，请重试', 'error')
    } finally {
        deleteLoading.value = false
    }
}

// 删除对话框相关
const deleteDialogVisible: Ref<boolean> = ref(false)
const deleteLoading: Ref<boolean> = ref(false)
const currentDeleteComment: Ref<CommentItem | null> = ref(null)
const deleteType: Ref<number | null> = ref(null)

// 评论详情对话框是否展示
const detailDialogVisible: Ref<boolean> = ref(false)
// 评论数据
const commentDetail: Ref<CommentItem> = ref({} as CommentItem)
// 展示评论详情对话框
const showDetailDialog = (row: CommentItem): void => {
    detailDialogVisible.value = true
    commentDetail.value = row
}

// 表单引用
const formRef: Ref<FormInstance | null> = ref(null)
// 评论审核表单对象
const form: FormData = reactive({
    id: null,
    status: '2',
    reason: ''
})

// 规则校验
const rules = {
    status: [
        {
            required: true,
            message: '状态不能为空',
            trigger: 'blur',
        },
    ],
    reason: [
        {
            required: true,
            message: '原因不能为空',
            trigger: 'blur',
        },
    ]
}

// 评论审核对话框是否展示
const editDialogVisible: Ref<boolean> = ref(false)
// 提交加载状态
const submitLoading: Ref<boolean> = ref(false)
// 展示评论审核对话框
const showEditDetailDialog = (row: CommentItem): void => {
    editDialogVisible.value = true
    // 设置表单对象的评论 ID
    form.id = row.id
}

const onSubmit = (): void => {
    // 先验证 form 表单字段
    formRef.value?.validate().then(() => {
        // 显示提交按钮 loading
        submitLoading.value = true
        examineComment(form).then((res: any) => {
            if (!res.success) {
                // 获取服务端返回的错误消息
                const message = res.message
                // 提示错误消息
                showMessage(message, 'error')
                return
            }

            showMessage('审核完成')
            // 将表单置空
            form.id = null
            form.status = '2'
            form.reason = ''
            // 隐藏对话框
            editDialogVisible.value = false
            // 重新请求分页接口，渲染数据
            getTableData()
        }).finally(() => {
            submitLoading.value = false // 隐藏提交按钮 loading
        })
    }).catch(() => {
        console.log('表单验证不通过')
    })
}
</script>

<style lang="scss" scoped>

.comment-list {
    height: calc(100vh - 165px);
    
    .table-card {
        :deep(.ant-card-body) {
            display: flex;
            flex-direction: column;
            height: 100%;
        }
    }
    
    .table-container {
        :deep(.ant-table) {
            height: calc(100vh - 280px);
        }
        
        :deep(.ant-table-tbody) {
            /* overflow-y: auto; */
        }
    }
    
    .pagination-wrapper {
        border-top: 1px solid #f0f0f0;
        padding-top: 16px;
        margin-top: 16px;
        flex-shrink: 0;
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
  .table-card {
    .table-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 16px;
      .table-title {
        font-size: 16px;
        font-weight: 500;
      }
    }
    .action-buttons {
      display: flex;
      gap: 8px;
    }
    .pagination-wrapper {
      margin-top: 16px;
      display: flex;
      justify-content: flex-end;
    }
  }
  .status-tag {
    &.published {
      color: #52c41a;
    }

    &.draft {
      color: #faad14;
    }
  }
  .top-badge {
    color: #f5222d;
    font-weight: bold;
  }
}


.mb-5 {
    margin-block-end: 20px;
}

.ml-3 {
    margin-inline-start: 12px;
}

.mr-5 {
    margin-inline-end: 20px;
}

.w-52 {
    inline-size: 208px;
}

.w-90 {
    inline-size: 360px;
}

.w-30 {
    inline-size: 120px;
}

.flex {
    display: flex;
}

.items-center {
    align-items: center;
}

.text-sm {
    font-size: 14px;
    line-height: 20px;
}

.text-blue-500 {
    color: oklch(0.6 0.2 240);
    
    &:hover {
        color: oklch(0.5 0.25 240);
    }
}

.mt-10 {
    margin-block-start: 40px;
}

.justify-center {
    justify-content: center;
}

// Tailwind CSS 4 新增的逻辑属性支持
@supports (margin-inline-start: 0) {
    .ml-3 {
        margin-left: unset;
        margin-inline-start: 12px;
    }
    
    .mr-5 {
        margin-right: unset;
        margin-inline-end: 20px;
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
