<template>
    <div class="friend-list p-6 h-full flex flex-col">
        <!-- 表头分页查询条件 -->
        <a-card class="mb-5 search-card flex-shrink-0">
            <!-- flex 布局，内容垂直居中 -->
            <div class="flex justify-start items-center search-form">
                <span>友链名称</span>
                <div class="ml-3 w-52 me-5">
                    <a-input v-model:value="searchFriendName" placeholder="请输入（模糊查询）" allow-clear />
                </div>

                <span>创建日期</span>
                <div class="ml-3 w-90 me-5">
                    <!-- 日期选择组件（区间选择） -->
                    <a-range-picker v-model:value="pickDate" :presets="shortcuts" format="YYYY-MM-DD" :placeholder="['开始时间', '结束时间']" @change="datepickerChange" />
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
        
        <!-- 友链列表 -->
        <a-card class="table-card flex-1 flex flex-col overflow-hidden">
            <!-- 新增友链按钮 -->
            <div class="table-header mb-5 flex justify-end flex-shrink-0">
                <a-button type="primary" class="add-friend-btn" @click="addFriendBtnClick">
                    <template #icon><PlusOutlined /></template>
                    新增友链
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
                    :row-key="(record: FriendItem) => record.id"
                    :row-class-name="(record: FriendItem) => record.isDeleted === 1 ? 'deleted-row' : ''"
                >
                <template #bodyCell="{ column, record, index }">
                    <template v-if="column.key === 'index'">
                        {{ index + 1 }}
                    </template>
                    <template v-else-if="column.key === 'category'">
                        {{ categoryMap[record.category] || record.category }}
                    </template>
                    <template v-else-if="column.key === 'avatar'">
                        <a-image :width="50" :src="record.avatar" />
                    </template>
                    <template v-else-if="column.key === 'isTop'">
                        <a-switch
                            v-model:checked="record.isTop"
                            @change="handleIsTopChange(record)"
                            checked-children="置顶"
                            un-checked-children="普通"
                        />
                    </template>
                    <template v-else-if="column.key === 'status'">
                        <a-select
                            v-model:value="record.status"
                            @change="handleStatusChange(record)"
                            style="width: 100px"
                            size="small"
                        >
                            <a-select-option value="active">
                                <span style="color: green;">正常</span>
                            </a-select-option>
                            <a-select-option value="inactive">
                                <span style="color: red;">停用</span>
                            </a-select-option>
                            <a-select-option value="pending">
                                <span style="color: orange;">待审核</span>
                            </a-select-option>
                        </a-select>
                    </template>
                    <template v-else-if="column.key === 'isDeleted'">
                        <a-tag :color="record.isDeleted === 1 ? 'red' : 'green'">
                            {{ record.isDeleted === 1 ? '已删除' : '未删除' }}
                        </a-tag>
                    </template>
                    <template v-else-if="column.key === 'action'">
                        <a-space>
                            <a-tooltip title="置顶">
                                <a-button 
                                    size="small" 
                                    @click="moveFriendToFirst(record, index)" 
                                    shape="circle"
                                    :disabled="index === 0"
                                >
                                    <template #icon><VerticalAlignTopOutlined /></template>
                                </a-button>
                            </a-tooltip>
                            
                            <a-tooltip title="置底">
                                <a-button 
                                    size="small" 
                                    @click="moveFriendToLast(record, index)" 
                                    shape="circle"
                                    :disabled="index === tableData.length - 1"
                                >
                                    <template #icon><VerticalAlignBottomOutlined /></template>
                                </a-button>
                            </a-tooltip>
                            
                            <a-tooltip title="上移">
                                <a-button 
                                    size="small" 
                                    @click="moveFriendUp(record, index)" 
                                    shape="circle"
                                    :disabled="index === 0"
                                >
                                    <template #icon><UpOutlined /></template>
                                </a-button>
                            </a-tooltip>
                            
                            <a-tooltip title="下移">
                                <a-button 
                                    size="small" 
                                    @click="moveFriendDown(record, index)" 
                                    shape="circle"
                                    :disabled="index === tableData.length - 1"
                                >
                                    <template #icon><DownOutlined /></template>
                                </a-button>
                            </a-tooltip>
                            
                            <a-tooltip title="编辑">
                                <a-button size="small" @click="showEditFriendDialog(record)" shape="circle">
                                    <template #icon><EditOutlined /></template>
                                </a-button>
                            </a-tooltip>
                            

                            <a-tooltip title="删除">
                                <a-button danger size="small" @click="deleteFriendSubmit(record)" shape="circle">
                                    <template #icon><DeleteOutlined /></template>
                                </a-button>
                            </a-tooltip>
                        </a-space>
                    </template>
                </template>
            </a-table>
            </div>

            <!-- 分页 -->
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

        <!-- 新增友链 -->
        <a-modal 
            v-model:open="formDialogVisible" 
            title="新增友链" 
            class="friend-modal"
            :width="600"
            :footer="null"
        >
            <a-form ref="formRef" :rules="rules" :model="form" :label-col="{ span: 4 }">
                <a-form-item label="网站名称" name="name">
                    <a-input v-model:value="form.name" placeholder="请输入网站名称" :maxlength="30" show-count allow-clear />
                </a-form-item>
                <a-form-item label="网站图标" name="avatar">
                    <a-input v-model:value="form.avatar" placeholder="请输入网站图标链接" allow-clear />
                </a-form-item>
                <a-form-item label="网站链接" name="url">
                    <a-input v-model:value="form.url" placeholder="请输入网站链接" allow-clear />
                </a-form-item>
                <a-form-item label="网站分类" name="category">
                    <a-select v-model:value="form.category" placeholder="请选择网站分类" allow-clear>
                        <a-select-option 
                            v-for="option in categoryOptions" 
                            :key="option.value" 
                            :value="option.value"
                        >
                            {{ option.label }}
                        </a-select-option>
                    </a-select>
                </a-form-item>
                <a-form-item label="网站描述" name="description">
                    <a-textarea 
                        v-model:value="form.description" 
                        :rows="3" 
                        :maxlength="100" 
                        show-count 
                        placeholder="请输入网站描述" 
                        allow-clear 
                    />
                </a-form-item>
            </a-form>
            <!-- 自定义按钮区域 -->
            <div class="modal-footer flex justify-end gap-3 mt-6 pt-4 border-t border-gray-200">
                <a-button size="middle" @click="closeFormDialog">取消</a-button>
                <a-button type="primary" size="middle" :loading="formSubmitLoading" @click="onSubmit">确定</a-button>
            </div>
        </a-modal>

        <!-- 编辑友链 -->
        <a-modal v-model:open="editFormDialogVisible" 
            title="编辑友链" 
            class="friend-modal"
            :width="600"
            :footer="null"
        >
            <a-form ref="editFormRef" :rules="rules" :model="editForm" :label-col="{ span: 4 }">
                <a-form-item label="网站名称" name="name">
                    <a-input v-model:value="editForm.name" placeholder="请输入网站名称" :maxlength="30" show-count allow-clear />
                </a-form-item>
                <a-form-item label="网站图标" name="avatar">
                    <a-input v-model:value="editForm.avatar" placeholder="请输入网站图标链接" allow-clear />
                </a-form-item>
                <a-form-item label="网站链接" name="url">
                    <a-input v-model:value="editForm.url" placeholder="请输入网站链接" allow-clear />
                </a-form-item>
                <a-form-item label="网站分类" name="category">
                    <a-select v-model:value="editForm.category" placeholder="请选择网站分类" allow-clear>
                        <a-select-option 
                            v-for="option in categoryOptions" 
                            :key="option.value" 
                            :value="option.value"
                        >
                            {{ option.label }}
                        </a-select-option>
                    </a-select>
                </a-form-item>
                <a-form-item label="网站描述" name="description">
                    <a-textarea 
                        v-model:value="editForm.description" 
                        :rows="3" 
                        :maxlength="100" 
                        show-count 
                        placeholder="请输入网站描述" 
                        allow-clear 
                    />
                </a-form-item>
            </a-form>
            
            <!-- 自定义按钮区域 -->
            <div class="modal-footer flex justify-end gap-3 mt-6 pt-4 border-t border-gray-200">
                <a-button size="middle" @click="closeEditFormDialog">取消</a-button>
                <a-button type="primary" size="middle" :loading="editFormSubmitLoading" @click="onEditFriendSubmit">确定</a-button>
            </div>
        </a-modal>

        <!-- 删除友链确认对话框 -->
        <a-modal 
            v-model:open="deleteDialogVisible" 
            title="删除友链" 
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
                        <div class="font-medium text-gray-900">确认删除友链</div>
                        <div class="text-sm text-gray-500 mt-1">请选择删除类型，谨慎操作</div>
                    </div>
                </div>
                <div class="delete-info p-4 rounded-lg mb-4">
                    <p class="text-sm">
                        是否确定要删除友链 <span class="font-medium">"{{ currentDeleteFriend?.name }}"</span> ？
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
                                        友链将被标记为已删除，但数据仍保留在数据库中，可以恢复
                                    </div>
                                </div>
                            </a-radio>
                            <a-radio :value="2" class="flex items-start">
                                <div class="ml-2">
                                    <div class="font-medium">物理删除</div>
                                    <div class="text-xs text-gray-500 mt-1">
                                        友链将从数据库中彻底删除，此操作不可撤销
                                    </div>
                                </div>
                            </a-radio>
                            <a-radio :value="3" class="flex items-start">
                                <div class="ml-2">
                                    <div class="font-medium">取消删除</div>
                                    <div class="text-xs text-gray-500 mt-1">
                                        恢复已删除的友链，将其标记为正常状态
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
import { ref, reactive } from 'vue'
import { 
    SearchOutlined, 
    ReloadOutlined, 
    PlusOutlined, 
    EditOutlined, 
    DeleteOutlined, 
    UpOutlined,
    DownOutlined,
    VerticalAlignTopOutlined,
    VerticalAlignBottomOutlined
} from '@ant-design/icons-vue'
import type { TableColumnsType } from 'ant-design-vue'
import moment, { type Moment } from 'moment'
import { getFriendPageList, addFriend, updateFriendIsTop, updateFriendStatus, deleteFriend, updateFriend, updateFriendSort, updateFriendSortFirst, updateFriendSortLast } from '@/api/admin/friend'
import { showMessage, } from '@/composables/util.ts'

// 类型定义
type FriendStatus = 'active' | 'inactive' | 'pending'

interface FriendItem {
    id: number
    name: string
    avatar: string
    url: string
    category: string
    description: string
    isTop: boolean
    status: FriendStatus
    createTime: string
    sort?: number    // 排序字段
    isDeleted?: number  // 删除状态：0-未删除，1-已删除
}

interface FriendForm {
    name: string
    avatar: string
    url: string
    category: string
    description: string
}

interface EditFriendForm extends FriendForm {
    id: number | null
}

interface DatePreset {
    label: string
    value: [Moment, Moment]
}

// 分类映射对象 - 英文代码到中文名称的映射
const categoryMap: Record<string, string> = {
    'tech': '技术类',
    'tools': '工具类', 
    'navigation': '导航类',
    'news': '新闻类',
    'aggregate': '聚合类',
    'life': '生活类',
    'mintblog': 'MintBlog优秀站点'
}

// 分类选项数组 - 用于下拉选择
const categoryOptions = [
    { value: 'tech', label: '技术类' },
    { value: 'tools', label: '工具类' },
    { value: 'navigation', label: '导航类' },
    { value: 'news', label: '新闻类' },
    { value: 'aggregate', label: '聚合类' },
    { value: 'life', label: '生活类' },
    { value: 'mintblog', label: 'MintBlog优秀站点' }
]

// 模糊搜索的友链名称
const searchFriendName = ref<string>('')
// 日期
const pickDate = ref<[Moment, Moment] | null>(null)

// 查询条件：开始结束时间
const startDate = ref<string | null>(null)
const endDate = ref<string | null>(null)

// 监听日期组件改变事件，并将开始结束时间设置到变量中
const datepickerChange = (dates: [moment.Moment, moment.Moment] | null) => {
    if (dates && dates.length === 2) {
        startDate.value = moment(dates[0]).format('YYYY-MM-DD')
        endDate.value = moment(dates[1]).format('YYYY-MM-DD')
        console.log('开始时间：' + startDate.value + ', 结束时间：' + endDate.value)
    } else {
        startDate.value = null
        endDate.value = null
    }
}

const shortcuts: DatePreset[] = [
    {
        label: '最近一周',
        value: [moment().subtract(7, 'days'), moment()]
    },
    {
        label: '最近一个月',
        value: [moment().subtract(30, 'days'), moment()]
    },
    {
        label: '最近三个月',
        value: [moment().subtract(90, 'days'), moment()]
    }
]

// 重置查询条件
const reset = (): void => {
    pickDate.value = null
    startDate.value = null
    endDate.value = null
    searchFriendName.value = '';
    getTableData();
}

// 表格加载 Loading
const tableLoading = ref<boolean>(false)
// 表格数据
const tableData = ref<FriendItem[]>([])
// 当前页码
const current = ref<number>(1)
// 总数据量
const total = ref<number>(0)
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
        title: '网站名称',
        dataIndex: 'name',
        key: 'name'
    },
    {
        title: '网站链接',
        dataIndex: 'url',
        key: 'url'
    },
    {
        title: '分类',
        dataIndex: 'category',
        key: 'category',
        width: 100,
        align: 'center'
    },
    {
        title: '网站图标',
        key: 'avatar',
        width: 140,
        align: 'center'
    },
    {
        title: '是否置顶',
        key: 'isTop',
        width: 100,
        align: 'center'
    },
    {
        title: '创建时间',
        dataIndex: 'createTime',
        key: 'createTime',
        width: 180,
        align: 'center',
    },
    {
        title: '审核状态',
        key: 'status',
        width: 120,
        align: 'center'
    },
    {
        title: '删除状态',
        key: 'isDeleted',
        width: 100,
        align: 'center'
    },
    {
        title: '操作',
        key: 'action',
        // fixed: 'right',
        width: 300,
        align: 'center'
    }
]

// 获取分页数据
const getTableData = (): void => {
    // 显示表格 loading
    tableLoading.value = true
    // 调用后台分页接口，并传入所需参数
    getFriendPageList({ 
        current: current.value, 
        size: size.value, 
        startDate: startDate.value, 
        endDate: endDate.value, 
        name: searchFriendName.value 
    })
        .then((res: any) => {
            if (res.success === true) {
                let friendList = res.data || [];
                
                // 处理状态字段，确保每个友链都有正确的status值
                friendList = friendList.map((item: any) => {
                    // 只有在真正没有status字段时才设置默认值（与数据库默认值保持一致）
                    if (!item.hasOwnProperty('status') || item.status === null || item.status === undefined) {
                        item.status = 'pending'; // 默认为待审核状态，与数据库默认值一致
                    }
                    
                    return item;
                });
                
                // 优先按isTop字段排序，然后按sort字段排序
                friendList.sort((a, b) => {
                    // 第一优先级：isTop字段，true的排在前面
                    const isTopA = a.isTop || false;
                    const isTopB = b.isTop || false;
                    if (isTopA !== isTopB) {
                        return isTopB ? 1 : -1; // isTop为true的排在前面
                    }
                    
                    // 第二优先级：sort字段降序，数字越大排序越靠前
                    const sortA = a.sort || 0;
                    const sortB = b.sort || 0;
                    if (sortA !== sortB) {
                        return sortB - sortA; // sort降序
                    }
                    
                    // 第三优先级：id升序排序
                    return Number(a.id) - Number(b.id);
                });
                
                tableData.value = friendList
                console.log("tableData",tableData.value)
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

// 对话框是否显示
const formDialogVisible = ref<boolean>(false)
const formSubmitLoading = ref<boolean>(false)

// 新增友链按钮点击事件
const addFriendBtnClick = (): void => {
    formDialogVisible.value = true
}

// 关闭新增对话框
const closeFormDialog = (): void => {
    formDialogVisible.value = false
    formSubmitLoading.value = false
    // 重置表单
    form.name = ''
    form.avatar = ''
    form.url = ''
    form.category = ''
    form.description = ''
}

// 表单引用
const formRef = ref(null)
// 表单对象
const form = reactive<FriendForm>({
    name: '',
    avatar: '',
    url: '',
    category: '',
    description: ''
})



// 表单校验规则
const rules = {
    name: [
        { required: true, message: '请输入网站名称', trigger: 'blur' },
        { min: 1, max: 20, message: '网站名称要求大于1个字符，小于20个字符', trigger: 'blur' },
    ],
    url: [
        { required: true, message: '请输入网站链接', trigger: 'blur' },
        { pattern: /^https?:\/\/.+/, message: '请输入有效的网站链接', trigger: 'blur' },
    ],
    category: [
        { required: true, message: '请输入网站分类', trigger: 'blur' },
        { min: 1, max: 10, message: '网站分类要求大于1个字符，小于10个字符', trigger: 'blur' },
    ],
    description: [
        { required: true, message: '请输入网站描述', trigger: 'blur' },
        { min: 1, max: 50, message: '网站描述要求大于1个字符，小于50个字符', trigger: 'blur' },
    ],
    avatar: [{ required: true, message: '请上传网站图标', trigger: 'change' }],
}



const onSubmit = (): void => {
    // 先验证 form 表单字段
    (formRef.value as any)?.validate().then(() => {
        // 显示提交按钮 loading
        formSubmitLoading.value = true
        // 直接提交表单
        submitFriendForm()
    }).catch(() => {
        console.log('表单验证不通过')
    })
}

// 提交友链表单
const submitFriendForm = (): void => {
    addFriend(form).then((res: any) => {
        if (!res.success) {
            // 获取服务端返回的错误消息
            const message = res.message
            // 提示错误消息
            showMessage(message, 'error')
            formSubmitLoading.value = false
            return
        }

        showMessage('添加成功')
        // 关闭对话框并重置表单
        closeFormDialog()
        // 重新请求分页接口，渲染数据
        getTableData()
    }).finally(() => {
        formSubmitLoading.value = false
    })
}

// 更新置顶
const handleIsTopChange = (row: FriendItem): void => {
    updateFriendIsTop({id: row.id, isTop: row.isTop}).then((res: any) => {
        if (res.success === false) {
            // 获取服务端返回的错误消息
            const message = res.message
            // 提示错误消息
            showMessage(message, 'error')
            // 重新请求分页接口，渲染列表数据
            getTableData()
            return
        }

        showMessage(row.isTop ? '置顶成功' : '已取消置顶')
        // 重新请求分页接口，渲染列表数据
        getTableData()
    })
}

// 更新审核状态
const handleStatusChange = (row: FriendItem): void => {
    updateFriendStatus({id: row.id, status: row.status}).then((res: any) => {
        if (res.success === false) {
            // 获取服务端返回的错误消息
            const message = res.message
            // 提示错误消息
            showMessage(message, 'error')
            // 重新请求分页接口，渲染列表数据
            getTableData()
            return
        }

        const statusText = {
            'active': '正常',
            'inactive': '停用',
            'pending': '待审核'
        }[row.status] || row.status
        
        showMessage(`状态已更新为：${statusText}`)
        // 重新请求分页接口，渲染列表数据
        getTableData()
    })
}

// 删除友链 - 打开确认对话框
const deleteFriendSubmit = (row: FriendItem): void => {
    currentDeleteFriend.value = row
    deleteDialogVisible.value = true
}

// 取消删除
const handleDeleteCancel = (): void => {
    deleteDialogVisible.value = false
    currentDeleteFriend.value = null
    deleteLoading.value = false
    deleteType.value = null
}

// 确认删除
const confirmDelete = async (): Promise<void> => {
    if (!currentDeleteFriend.value || !deleteType.value) return
    
    console.log(`执行${deleteType.value === 1 ? '逻辑删除' : deleteType.value === 2 ? '物理删除' : '取消删除'}操作`)
    
    deleteLoading.value = true
    try {
        const res: any = await deleteFriend(currentDeleteFriend.value.id, deleteType.value)
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
        console.error('操作友链失败:', error)
        showMessage('操作失败，请重试', 'error')
    } finally {
        deleteLoading.value = false
    }
}

// 上移友链
const moveFriendUp = (record: FriendItem, index: number): void => {
    if (index === 0) {
        showMessage('已经是第一个了', 'warning')
        return
    }
    
    // 获取当前项和上一项
    const currentItem = tableData.value[index]
    const prevItem = tableData.value[index - 1]
    
    // 交换sort值
    const tempSort = currentItem.sort || 0
    currentItem.sort = prevItem.sort || 0
    prevItem.sort = tempSort
    
    // 在本地数组中交换位置
    tableData.value[index] = prevItem
    tableData.value[index - 1] = currentItem
    
    // 调用API更新排序
    updateFriendSortFunction(currentItem.id, currentItem.sort)
    updateFriendSortFunction(prevItem.id, prevItem.sort)

    // 获取列表数据
    getTableData();
}

// 下移友链
const moveFriendDown = (record: FriendItem, index: number): void => {
    if (index === tableData.value.length - 1) {
        showMessage('已经是最后一个了', 'warning')
        return
    }
    
    // 获取当前项和下一项
    const currentItem = tableData.value[index]
    const nextItem = tableData.value[index + 1]
    
    // 交换sort值
    const tempSort = currentItem.sort || 0
    currentItem.sort = nextItem.sort || 0
    nextItem.sort = tempSort
    
    // 在本地数组中交换位置
    tableData.value[index] = nextItem
    tableData.value[index + 1] = currentItem
    
    // 调用API更新排序
    updateFriendSortFunction(currentItem.id, currentItem.sort)
    updateFriendSortFunction(nextItem.id, nextItem.sort)

    // 获取列表数据
    getTableData();
}

// 更新友链排序
const updateFriendSortFunction = async (id: number, sort: number): Promise<void> => {
    try {
        const res: any = await updateFriendSort(id, sort)
        if (!res.success) {
            showMessage(res.message || '更新排序失败', 'error')
            // 如果更新失败，重新获取数据
            getTableData()
        } else {
            showMessage('排序更新成功')
        }
    } catch (error) {
        console.error('更新友链排序失败:', error)
        showMessage('更新排序失败，请重试', 'error')
        // 如果更新失败，重新获取数据
        getTableData()
    }
}

// 移动友链到最前面
const moveFriendToFirst = async (record: FriendItem, index: number): Promise<void> => {
    if (index === 0) {
        showMessage('已经是第一个了', 'warning')
        return
    }
    
    try {
        const res: any = await updateFriendSortFirst(record.id, record.sort || 0)
        if (!res.success) {
            showMessage(res.message || '移动到最前面失败', 'error')
            getTableData()
        } else {
            showMessage('已移动到最前面')
            getTableData() // 重新获取数据以更新排序
        }
    } catch (error) {
        console.error('移动友链到最前面失败:', error)
        showMessage('移动到最前面失败，请重试', 'error')
        getTableData()
    }
}

// 移动友链到最后面
const moveFriendToLast = async (record: FriendItem, index: number): Promise<void> => {
    if (index === tableData.value.length - 1) {
        showMessage('已经是最后一个了', 'warning')
        return
    }
    
    try {
        const res: any = await updateFriendSortLast(record.id, record.sort || 0)
        if (!res.success) {
            showMessage(res.message || '移动到最后面失败', 'error')
            getTableData()
        } else {
            showMessage('已移动到最后面')
            getTableData() // 重新获取数据以更新排序
        }
    } catch (error) {
        console.error('移动友链到最后面失败:', error)
        showMessage('移动到最后面失败，请重试', 'error')
        getTableData()
    }
}

// 从原始 logo URL 中提取原始文件名


// 编辑表单对话框是否可见
const editFormDialogVisible = ref<boolean>(false)
// 编辑表单提交 loading
const editFormSubmitLoading = ref<boolean>(false)

// 删除对话框相关
const deleteDialogVisible = ref<boolean>(false)
const deleteLoading = ref<boolean>(false)
const currentDeleteFriend = ref<FriendItem | null>(null)
const deleteType = ref<number | null>(null)

// 关闭编辑对话框
const closeEditFormDialog = (): void => {
    editFormDialogVisible.value = false
    editFormSubmitLoading.value = false
    // 重置表单
    editForm.id = null
    editForm.name = ''
    editForm.avatar = ''
    editForm.url = ''
    editForm.category = ''
    editForm.description = ''
}

// 弹出友链编辑对话框
const showEditFriendDialog = (row: FriendItem): void => {
    editFormDialogVisible.value = true
    editForm.id = row.id
    editForm.name = row.name
    editForm.avatar = row.avatar
    editForm.url = row.url
    editForm.category = row.category
    editForm.description = row.description
}

// 表单引用
const editFormRef = ref(null)
// 表单对象
const editForm = reactive<EditFriendForm>({
    id: null,
    name: '',
    avatar: '',
    url: '',
    category: '',
    description: ''
})



// 编辑友链提交事件
const onEditFriendSubmit = (): void => {
    // 先验证 form 表单字段
    (editFormRef.value as any)?.validate().then(() => {
        // 显示提交按钮 loading
        editFormSubmitLoading.value = true
        // 直接提交表单
        submitEditFriendForm()
    }).catch(() => {
        console.log('表单验证不通过')
    })
}

// 提交编辑友链表单
const submitEditFriendForm = (): void => {
    updateFriend(editForm).then((res: any) => {
        if (!res.success) {
            // 获取服务端返回的错误消息
            const message = res.message
            // 提示错误消息
            showMessage(message, 'error')
            editFormSubmitLoading.value = false
            return
        }
        
        showMessage('更新成功')
        // 关闭对话框并重置表单
        closeEditFormDialog()
        // 重新请求分页接口，渲染数据
        getTableData()
    }).finally(() => {
        editFormSubmitLoading.value = false
    })
}

// 编辑分类对话框引用
const editCatalogFormDialogRef = ref<any>(null)
// 编辑分类按钮点击事件
const showEditFriendCatalogDialog = (row: FriendItem): void => {
    // 显示编辑分类对话框, 并传入友链 ID
    editCatalogFormDialogRef.value?.open(row.id)
}


</script>

<style lang="scss" scoped>

.wiki-list {
    min-height: calc(100vh - 165px);
    .table-card {
        .table-header {
            display: flex;
            align-items: center;
            margin-bottom: 16px;
            flex-shrink: 0;
            .table-title {
            font-size: 16px;
            font-weight: 500;
            }
            .ant-card-body {
                display: flex;
                flex-direction: column;
                height: 100%;
            }
            /* 新增知识库按钮样式 */
            .add-wiki-btn {
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

    
    .table-container {
        :deep(.ant-table) {
            max-height: calc(100vh - 320px);
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

/* 上传组件样式 */
.upload-container {
  display: flex;
  justify-content: flex-start;
  align-items: center;
}

// 上传区域基础样式
.upload-area {
  border: 2px dashed #d1d5db;
  border-radius: 12px;
  background: linear-gradient(135deg, #f9fafb 0%, #f3f4f6 100%);
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  overflow: hidden;
  
  &:hover {
    border-color: #3b82f6;
    background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(59, 130, 246, 0.15);
    
    .upload-placeholder {
      .upload-icon {
        color: #3b82f6;
        transform: scale(1.1);
      }
      
      .upload-text {
        color: #1e40af;
      }
    }
  }
}
// Logo 上传区域
.logo-area {
  width: 200px;
  height: 120px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 12px;
  position: relative;
  overflow: hidden;
}
// 上传的图片样式
.uploaded-image {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  transition: transform 0.3s ease;
  &:hover {
    transform: translate(-50%, -50%) scale(1.05);
  }
}
.logo-image {
  border-radius: 12px;
  max-width: 90%;
  max-height: 90%;
  width: auto;
  height: auto;
  object-fit: contain;
}
// 上传占位符样式
.upload-placeholder {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 16px;
}
.upload-icon {
  font-size: 32px;
  color: #9ca3af;
  margin-bottom: 8px;
  transition: color 0.3s ease;
}
.upload-text {
  font-size: 14px;
  font-weight: 600;
  color: #374151;
  margin-bottom: 4px;
}
.upload-hint {
  font-size: 12px;
  color: #9ca3af;
}

// 全局样式覆盖
:deep(.logo-uploader) {
  .ant-upload {
    border: none !important;
    background: transparent !important;
    padding: 0 !important;
    &:hover {
      background: transparent !important;
    }
  }
}

/* 表格自定义样式 */
.ant-table {
    .ant-table-tbody {
        .ant-table-row {
            &:hover {
                background-color: #f5f5f5;
            }
        }
    }
}

/* 对话框样式优化 */
:deep(.wiki-modal) {
    .ant-modal-header {
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        border-bottom: 1px solid #e8e8e8;
        border-radius: 8px 8px 0 0;
        padding: 20px 24px;
        
        .ant-modal-title {
            font-size: 18px;
            font-weight: 600;
            color: #2c3e50;
            text-align: center;
        }
    }
    
    .ant-modal-content {
        border-radius: 8px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }
    
    .ant-modal-body {
        padding: 32px 24px;
        background: #fafbfc;
        
        .ant-form {
            .ant-form-item {
                margin-bottom: 24px;
                
                .ant-form-item-label {
                    padding-bottom: 8px;
                    
                    label {
                        font-weight: 500;
                        color: #2c3e50;
                        font-size: 14px;
                    }
                }
                
                .ant-input {
                    border-radius: 6px;
                    border: 1px solid #e1e5e9;
                    padding: 12px 16px;
                    font-size: 14px;
                    transition: all 0.3s ease;
                    background: #fff;
                    
                    &:hover {
                        border-color: #667eea;
                        box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.1);
                    }
                    
                    &:focus {
                        border-color: #667eea;
                        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
                        outline: none;
                    }
                }
                
                .ant-input-affix-wrapper {
                    border-radius: 6px;
                    border: 1px solid #e1e5e9;
                    padding: 12px 16px;
                    transition: all 0.3s ease;
                    background: #fff;
                    
                    &:hover {
                        border-color: #667eea;
                        box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.1);
                    }
                    
                    &.ant-input-affix-wrapper-focused {
                        border-color: #667eea;
                        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
                    }
                    
                    .ant-input {
                        border: none;
                        padding: 0;
                        box-shadow: none;
                        
                        &:focus {
                            box-shadow: none;
                        }
                    }
                }
                
                .ant-input-number {
                    border-radius: 6px;
                    border: 1px solid #e1e5e9;
                    width: 100%;
                    
                    &:hover {
                        border-color: #667eea;
                    }
                    
                    &.ant-input-number-focused {
                        border-color: #667eea;
                        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
                    }
                }
                
                .ant-input-data-count {
                    color: #8c8c8c;
                    font-size: 12px;
                }
            }
        }
    }
    
    .ant-modal-footer {
        background: #f8f9fa;
        border-top: 1px solid #e8e8e8;
        padding: 16px 24px;
        text-align: right;
        display: flex;
        justify-content: flex-end;
        align-items: center;
        gap: 12px;
        
        .ant-btn {
            margin: 0;
            border-radius: 6px;
            font-weight: 500;
            padding: 8px 24px;
            height: auto;
            
            &.ant-btn-default {
                border-color: #d9d9d9;
                color: #666;
                
                &:hover {
                    border-color: #40a9ff;
                    color: #40a9ff;
                }
            }
            
            &.ant-btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
                
                &:hover {
                    background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
                    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
                    transform: translateY(-1px);
                }
            }
        }
    }
}

/* 操作按钮样式 */
.action-buttons {
    display: flex;
    gap: 8px;
    .ant-btn {
        &.ant-btn-sm {
            padding: 0 8px;
            height: 24px;
            font-size: 12px;
        }
    }
}

/* 表格操作按钮优化 */
:deep(.ant-table) {
    .ant-btn {
        &.ant-btn-circle {
            border-radius: 50%;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid #e1e5e9;
            background: #fff;
            
            &:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            }
            
            &:active {
                transform: translateY(0);
            }
            
            .anticon {
                font-size: 14px;
            }
            
            // 编辑按钮
            &:has(.anticon-edit) {
                border-color: #52c41a;
                color: #52c41a;
                
                &:hover {
                    background: #52c41a;
                    color: #fff;
                    border-color: #52c41a;
                    box-shadow: 0 4px 12px rgba(82, 196, 26, 0.3);
                }
            }
            
            // 目录编辑按钮
            &:has(.anticon-unordered-list) {
                border-color: #1890ff;
                color: #1890ff;
                
                &:hover {
                    background: #1890ff;
                    color: #fff;
                    border-color: #1890ff;
                    box-shadow: 0 4px 12px rgba(24, 144, 255, 0.3);
                }
            }
            
            // 预览按钮
            &:has(.anticon-eye) {
                border-color: #722ed1;
                color: #722ed1;
                
                &:hover {
                    background: #722ed1;
                    color: #fff;
                    border-color: #722ed1;
                    box-shadow: 0 4px 12px rgba(114, 46, 209, 0.3);
                }
            }
            
            // 删除按钮
            &.ant-btn-dangerous {
                border-color: #ff4d4f;
                color: #ff4d4f;
                
                &:hover {
                    background: #ff4d4f;
                    color: #fff;
                    border-color: #ff4d4f;
                    box-shadow: 0 4px 12px rgba(255, 77, 79, 0.3);
                }
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
}

// 已删除行的样式
:deep(.deleted-row) {
    background-color: #f5f5f5 !important;
    color: #999 !important;
    
    td {
        background-color: #f5f5f5 !important;
        color: #999 !important;
    }
    
    &:hover {
        background-color: #e8e8e8 !important;
        
        td {
            background-color: #e8e8e8 !important;
        }
    }
}

</style>