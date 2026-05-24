<template>
    <div class="tag-list p-6 h-full flex flex-col">
        <!-- 表头分页查询条件 -->
        <a-card class="search-card mb-5 flex-shrink-0">
            <!-- flex 布局，内容垂直居中 -->
            <div class="flex justify-start items-center search-form">
                <a-typography-text>标签名称</a-typography-text>
                <div class="ms-3 inline-size-52 me-5"><a-input v-model:value="searchTagName" placeholder="请输入（模糊查询）" /></div>
                <a-typography-text>创建日期</a-typography-text>
                <div class="ms-3 inline-size-90 me-5">
                    <!-- 日期选择组件（区间选择） -->
                    <a-range-picker v-model:value="pickDate" format="YYYY-MM-DD" :placeholder="['开始时间', '结束时间']" @change="datepickerChange" />
                </div>

                <a-button type="primary" class="ms-3" @click="getTableData">
                    <template #icon><SearchOutlined /></template>
                    查询
                </a-button>
                <a-button class="ms-3" @click="reset">
                    <template #icon><ReloadOutlined /></template>
                    重置
                </a-button>
            </div>
        </a-card>

        <a-card class="table-card flex-1 flex flex-col overflow-hidden">
            <!-- 新增按钮 -->
            <div class="table-header mb-5 flex justify-end flex-shrink-0">
                <a-button type="primary" class="add-tag-btn" @click="addCategoryBtnClick">
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
                :row-class-name="(record: TagItem) => record.isDeleted === 1 ? 'deleted-row' : ''"
                >
                    <template #bodyCell="{ column, record, index }">
                        <template v-if="column.key === 'index'">
                            {{ index + 1 }}
                        </template>
                        <template v-else-if="column.key === 'name'">
                            <a-tag class="ms-2" color="success">{{ record.name }}</a-tag>
                        </template>
                        <template v-else-if="column.key === 'isDeleted'">
                            <a-tag :color="record.isDeleted === 1 ? 'error' : 'success'">
                                {{ record.isDeleted === 1 ? '已删除' : '未删除' }}
                            </a-tag>
                        </template>
                        <template v-else-if="column.key === 'action'">
                            <a-space>
                                <a-tooltip title="置顶">
                                    <a-button 
                                        size="small" 
                                        @click="moveTagToFirst(record, index)" 
                                        shape="circle"
                                        :disabled="index === 0"
                                    >
                                        <template #icon><VerticalAlignTopOutlined /></template>
                                    </a-button>
                                </a-tooltip>
                                
                                <a-tooltip title="置底">
                                    <a-button 
                                        size="small" 
                                        @click="moveTagToLast(record, index)" 
                                        shape="circle"
                                        :disabled="index === tableData.length - 1"
                                    >
                                        <template #icon><VerticalAlignBottomOutlined /></template>
                                    </a-button>
                                </a-tooltip>
                                
                                <a-tooltip title="上移">
                                    <a-button 
                                        size="small" 
                                        @click="moveTagUp(record, index)" 
                                        shape="circle"
                                        :disabled="index === 0"
                                    >
                                        <template #icon><UpOutlined /></template>
                                    </a-button>
                                </a-tooltip>
                                
                                <a-tooltip title="下移">
                                    <a-button 
                                        size="small" 
                                        @click="moveTagDown(record, index)" 
                                        shape="circle"
                                        :disabled="index === tableData.length - 1"
                                    >
                                        <template #icon><DownOutlined /></template>
                                    </a-button>
                                </a-tooltip>
                                
                                <a-tooltip title="编辑">
                                    <a-button size="small" @click="showEditTagDialog(record)" shape="circle">
                                        <template #icon><EditOutlined /></template>
                                    </a-button>
                                </a-tooltip>
                                
                                <a-tooltip title="删除">
                                    <a-button danger size="small" @click="deleteTagSubmit(record)" shape="circle">
                                        <template #icon><DeleteOutlined /></template>
                                    </a-button>
                                </a-tooltip>
                            </a-space>
                        </template>
                    </template>
                </a-table>
            </div>

            <!-- 分页 -->
            <div class="pagination-wrapper mbs-10 flex justify-center flex-shrink-0">
                <a-pagination 
                    v-if="total > 0"
                    v-model:current="current" 
                    v-model:page-size="size" 
                    :total="total" 
                    show-size-changer
                    :page-size-options="['10', '20', '50', '100', '150', '200', '300', '350', '400', '500', '600', '800', '1000', '1500', '2000']"
                    show-quick-jumper
                    :show-total="(total: number, range: [number, number]) => `第 ${range[0]}-${range[1]} 条，共 ${total} 条`"
                    @change="getTableData" 
                    @show-size-change="handleSizeChange" 
                />
            </div>

        </a-card>

        <!-- 添加标签对话框 -->
        <a-modal 
            v-model:open="addTagDialogVisible" 
            title="添加文章标签" 
            width="500px"
            :footer="null"
        >
            <a-form 
                ref="formRef" 
                :model="form" 
                layout="vertical"
            >
                <a-form-item label="标签列表">
                    <div class="tag-input-container">
                        <a-tag 
                            v-for="tag in dynamicTags" 
                            :key="tag" 
                            class="mb-2 mr-2" 
                            closable
                            @close="handleClose(tag)"
                        >
                            {{ tag }}
                        </a-tag>
                        <div class="mt-2">
                            <a-input 
                                v-if="inputVisible" 
                                ref="InputRef" 
                                v-model:value="inputValue" 
                                class="w-32" 
                                size="small"
                                placeholder="输入标签名称"
                                @keyup.enter="handleInputConfirm" 
                                @blur="handleInputConfirm" 
                            />
                            <a-button 
                                v-else 
                                class="button-new-tag" 
                                size="small" 
                                @click="showInput"
                            >
                                + 新增标签
                            </a-button>
                        </div>
                    </div>
                </a-form-item>
            </a-form>
            
            <!-- 自定义按钮区域 -->
            <div class="modal-footer flex justify-end gap-3 mt-6 pt-4 border-t border-gray-200">
                <a-button 
                    size="middle" 
                    @click="cancelAddTag"
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

        <!-- 删除标签确认对话框 -->
        <a-modal 
            v-model:open="deleteDialogVisible" 
            title="删除标签" 
            width="600px"
            :footer="null"
            wrap-class-name="delete-dialog"
        >
            <div class="delete-content py-4">
                <div class="flex items-center mb-4">
                    <div class="warning-icon w-8 h-8 rounded-full flex items-center justify-center mr-3">
                        <DeleteOutlined />
                    </div>
                    <div>
                        <div class="font-medium text-gray-900">确认删除标签</div>
                        <div class="text-sm text-gray-500 mt-1">请选择删除方式，不同方式的影响不同</div>
                    </div>
                </div>
                <div class="delete-info p-4 rounded-lg mb-4">
                    <p class="text-sm">
                        是否确定要删除标签 <span class="font-medium">"{{ currentDeleteTag?.name }}"</span> ？
                    </p>
                    <p class="text-xs mt-2">
                        删除后该标签下的所有文章将移除此标签
                    </p>
                </div>
                
                <!-- 删除类型选择 -->
                <div class="delete-type-selection">
                    <div class="text-sm font-medium text-gray-900 mb-3">删除方式：</div>
                    <a-radio-group v-model:value="deleteType" class="w-full">
                        <div class="space-y-3">
                            <a-radio :value="1" class="flex items-start">
                                <div class="ml-2">
                                    <div class="font-medium">逻辑删除</div>
                                    <div class="text-xs text-gray-500 mt-1">
                                        标签将被标记为已删除，但数据仍保留在数据库中，可以恢复
                                    </div>
                                </div>
                            </a-radio>
                            <a-radio :value="2" class="flex items-start">
                                <div class="ml-2">
                                    <div class="font-medium">物理删除</div>
                                    <div class="text-xs text-gray-500 mt-1">
                                        标签将从数据库中彻底删除，此操作不可撤销
                                    </div>
                                </div>
                            </a-radio>
                            <a-radio :value="3" class="flex items-start">
                                <div class="ml-2">
                                    <div class="font-medium">取消删除</div>
                                    <div class="text-xs text-gray-500 mt-1">
                                        恢复已删除的标签，使其重新可用
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

        <!-- 编辑标签对话框 -->
        <a-modal 
            v-model:open="editTagDialogVisible" 
            title="编辑标签" 
            width="480px"
            :footer="null"
        >
            <a-form 
                ref="editFormRef" 
                :model="editForm" 
                layout="vertical"
            >
                <a-form-item 
                    label="标签名称" 
                    name="name"
                    :rules="[{ required: true, message: '请输入标签名称' }]"
                >
                    <a-input 
                        v-model:value="editForm.name" 
                        placeholder="请输入标签名称"
                        :maxlength="20"
                        show-count
                    />
                </a-form-item>
            </a-form>
            
            <!-- 自定义按钮区域 -->
            <div class="modal-footer flex justify-end gap-3 mt-6 pt-4 border-t border-gray-200">
                <a-button 
                    size="middle" 
                    @click="cancelEditTag"
                >
                    取消
                </a-button>
                <a-button 
                    type="primary" 
                    size="middle" 
                    :loading="editSubmitLoading"
                    @click="onEditSubmit"
                >
                    确定
                </a-button>
            </div>
        </a-modal>

    </div>
</template>

<script setup lang="ts">
import type { TableColumnsType } from 'ant-design-vue'
import { SearchOutlined, ReloadOutlined, PlusOutlined, DeleteOutlined, EditOutlined, UpOutlined, DownOutlined, VerticalAlignTopOutlined, VerticalAlignBottomOutlined } from '@ant-design/icons-vue'
import { ref, reactive, nextTick, onMounted, type Ref } from 'vue'
import { message, type FormInstance } from 'ant-design-vue'
import { getTagPageList, addTag, deleteTag, updateTag, updateTagSort, updateTagSortFirst, updateTagSortLast } from '@/api/admin/tag.ts'
import moment from 'moment'
import { showMessage } from '@/composables/util.ts'

// 类型定义
interface TagItem {
    id: number
    name: string
    articlesTotal: number
    createTime: string
    sort: number
    isDeleted: number // 删除状态：0-未删除，1-已删除
}

interface AddTagForm {
    name: string
    tags?: string[]
}

interface ApiResponse<T = any> {
    success: boolean
    message: string
    data: T
    total: number
    current: number
    size: number
}

// 分页查询的标签名称
const searchTagName: Ref<string> = ref('')
// 日期
const pickDate: Ref<string[]> = ref([])

// 查询条件：开始结束时间
const startDate: any = reactive({})
const endDate: any = reactive({})

// 监听日期组件改变事件，并将开始结束时间设置到变量中
const datepickerChange = (e: any) => {
    if (e && e[0] && e[1]) {
        startDate.value = moment(e[0]).format('YYYY-MM-DD')
        endDate.value = moment(e[1]).format('YYYY-MM-DD')
        console.log('开始时间：' + startDate.value + ', 结束时间：' + endDate.value)
    } else {
        startDate.value = null
        endDate.value = null
    }
}

// 表格列定义
const columns: TableColumnsType = [
    {
        title: '序号',
        key: 'index',
        width: 80,
        align: 'center',
    },
    {
        title: '标签名称',
        dataIndex: 'name',
        key: 'name',
        width: 200,
        align: 'center'
    },
    {
        title: '文章数',
        dataIndex: 'articlesTotal',
        key: 'articlesTotal',
        width: 100,
        align: 'center'
    },
    {
        title: '创建时间',
        dataIndex: 'createTime',
        key: 'createTime',
        width: 180,
        align: 'center'
    },
    {
        title: '删除状态',
        dataIndex: 'isDeleted',
        key: 'isDeleted',
        width: 120,
        align: 'center'
    },
    {
        title: '操作',
        dataIndex: 'action',
        key: 'action',
        width: 220,
        align: 'center'
    },
] as const

// const shortcuts = [
//     {
//         text: '最近一周',
//         value: () => {
//             const end = new Date()
//             const start = new Date()
//             start.setTime(start.getTime() - 3600 * 1000 * 24 * 7)
//             return [start, end]
//         },
//     },
//     {
//         text: '最近一个月',
//         value: () => {
//             const end = new Date()
//             const start = new Date()
//             start.setTime(start.getTime() - 3600 * 1000 * 24 * 30)
//             return [start, end]
//         },
//     },
//     {
//         text: '最近三个月',
//         value: () => {
//             const end = new Date()
//             const start = new Date()
//             start.setTime(start.getTime() - 3600 * 1000 * 24 * 90)
//             return [start, end]
//         },
//     },
// ]

// 表格加载 Loading

const tableLoading: Ref<boolean> = ref(false)
// 表格数据
const tableData: Ref<TagItem[]> = ref([])
// 当前页码
const current: Ref<number> = ref(1)
// 总数据量
const total: Ref<number> = ref(0)
// 每页显示的数据量
const size: Ref<number> = ref(20)


// 获取分页数据
const getTableData = async (): Promise<void> => {
    // 显示表格 loading
    tableLoading.value = true
    // 调用后台分页接口，并传入所需参数

    try {
        const res: ApiResponse<TagItem[]> = await getTagPageList({ current: current.value, size: size.value, startDate: startDate.value, endDate: endDate.value, name: searchTagName.value })
        if (res.success === true) {
            // 按sort字段降序排序（数值越大越靠前）
            const sortedData = res.data.sort((a, b) => {
                // 如果sort字段不存在，默认为0
                const sortA = a.sort || 0
                const sortB = b.sort || 0
                // 降序排序：sort值大的在前面
                if (sortB !== sortA) {
                    return sortB - sortA
                }
                // 如果sort值相同，按id升序排序
                return a.id - b.id
            })
            
            tableData.value = sortedData
            current.value = res.current
            size.value = res.size
            total.value = res.total
        }
    } finally {
        tableLoading.value = false // 隐藏表格 loading
    }
}
getTableData()

// 每页展示数量变更事件
const handleSizeChange = (current: number, pageSize: number): void => {
    size.value = pageSize
    getTableData()
}

// 重置查询条件
const reset = (): void => {
    searchTagName.value = '';
    pickDate.value = [];
    startDate.value = null;
    endDate.value = null;
    getTableData();
}

// 添加标签对话框是否显示
const addTagDialogVisible: Ref<boolean> = ref(false)
// 提交加载状态
const submitLoading: Ref<boolean> = ref(false)

// 删除对话框相关
const deleteDialogVisible: Ref<boolean> = ref(false)
const deleteLoading: Ref<boolean> = ref(false)
const currentDeleteTag: Ref<TagItem | null> = ref(null)
const deleteType: Ref<number | null> = ref(null)

// 编辑对话框相关
const editTagDialogVisible: Ref<boolean> = ref(false)
const editSubmitLoading: Ref<boolean> = ref(false)
const currentEditTag: Ref<TagItem | null> = ref(null)

// 新增分类按钮点击事件
const addCategoryBtnClick = (): void => {
    addTagDialogVisible.value = true
}

// 取消添加标签
const cancelAddTag = (): void => {
    addTagDialogVisible.value = false
    dynamicTags.value = []
    form.tags = []
}

// 表单引用
const formRef: Ref<FormInstance | null> = ref(null)
const editFormRef: Ref<FormInstance | null> = ref(null)

// 添加文章分类表单对象
// 表单数据
const form: AddTagForm = reactive({
    name: '',
    tags: []
})

// 编辑标签表单对象
const editForm: { id?: number; name: string } = reactive({
    id: undefined,
    name: ''
})


const onSubmit = async (): Promise<void> => {
    try {
        submitLoading.value = true
        form.tags = dynamicTags.value
        const res: ApiResponse = await addTag(form)
        if (res.success == true) {
            showMessage('添加成功')
            // 将表单中标签数组置空
            form.tags = []
            dynamicTags.value = []
            // 隐藏对话框
            addTagDialogVisible.value = false
            // 重新请求分页接口，渲染数据
            getTableData()
        } else {
            // 获取服务端返回的错误消息
            let message = res.message
            // 提示错误消息
            showMessage(message, 'error')
        }
    } catch (error) {
        console.log('提交失败:', error)
    } finally {
        submitLoading.value = false
    }
}

// 删除标签 - 打开确认对话框
const deleteTagSubmit = (row: TagItem): void => {
    currentDeleteTag.value = row
    deleteDialogVisible.value = true
}

// 取消删除
const handleDeleteCancel = (): void => {
    deleteDialogVisible.value = false
    currentDeleteTag.value = null
    deleteLoading.value = false
    deleteType.value = null
}

// 确认删除
const confirmDelete = async (): Promise<void> => {
    if (!currentDeleteTag.value || !deleteType.value) return
    
    deleteLoading.value = true
    try {
        console.log('操作类型:', deleteType.value === 1 ? '逻辑删除' : deleteType.value === 2 ? '物理删除' : deleteType.value === 3 ? '取消删除' : '未知操作')
        const res: ApiResponse = await deleteTag(currentDeleteTag.value.id, deleteType.value)
        if (res.success) {
            const deleteTypeText = deleteType.value === 1 ? '逻辑删除' : deleteType.value === 2 ? '物理删除' : deleteType.value === 3 ? '取消删除' : '操作'
            message.success(`${deleteTypeText}成功`)
            // 重新请求分页接口，渲染数据
            getTableData()
            handleDeleteCancel()
        } else {
            message.error(res.message || '操作失败')
        }
    } catch (error) {
        console.error('操作标签失败:', error)
        message.error('操作失败，请重试')
    } finally {
        deleteLoading.value = false
    }
}

// 显示编辑标签对话框
const showEditTagDialog = (row: TagItem): void => {
    // console.log('点击编辑按钮，行数据:', row)
    // console.log('设置对话框可见性为 true')
    currentEditTag.value = row
    editForm.id = row.id
    editForm.name = row.name
    editTagDialogVisible.value = true
    // console.log('editTagDialogVisible.value:', editTagDialogVisible.value)
}

// 取消编辑标签
const cancelEditTag = (): void => {
    editTagDialogVisible.value = false
    currentEditTag.value = null
    editForm.id = undefined
    editForm.name = ''
    editSubmitLoading.value = false
    // 清除表单验证
    editFormRef.value?.clearValidate()
}

// 提交编辑标签
const onEditSubmit = async (): Promise<void> => {
    try {
        // 表单验证
        await editFormRef.value?.validate()
        
        editSubmitLoading.value = true
        
        // 调用编辑标签的API
        const res: ApiResponse = await updateTag(editForm)
        if (res.success) {
            showMessage('编辑成功')
            cancelEditTag()
            // 重新请求分页接口，渲染数据
            getTableData()
        } else {
            showMessage(res.message || '编辑失败', 'error')
        }
    } catch (error) {
        console.log('编辑失败:', error)
    } finally {
        editSubmitLoading.value = false
    }
}

// 上移标签
const moveTagUp = async (record: TagItem, index: number): Promise<void> => {
    if (index === 0) return
    
    try {
        // 获取当前项和上一项
        const currentItem = tableData.value[index]
        const prevItem = tableData.value[index - 1]
        
        // 交换sort值
        const tempSort = currentItem.sort
        currentItem.sort = prevItem.sort
        prevItem.sort = tempSort
        
        // 更新两个标签的sort值
        await updateTagSortFunction(currentItem.id, currentItem.sort)
        await updateTagSortFunction(prevItem.id, prevItem.sort)
        
        // 在本地数组中交换位置
        tableData.value[index] = prevItem
        tableData.value[index - 1] = currentItem
        
        showMessage('上移成功')
    } catch (error) {
        console.error('上移失败:', error)
        showMessage('上移失败', 'error')
        // 出错时重新获取数据
        getTableData()
    }
}

// 下移标签
const moveTagDown = async (record: TagItem, index: number): Promise<void> => {
    if (index === tableData.value.length - 1) return
    
    try {
        // 获取当前项和下一项
        const currentItem = tableData.value[index]
        const nextItem = tableData.value[index + 1]
        
        // 交换sort值
        const tempSort = currentItem.sort
        currentItem.sort = nextItem.sort
        nextItem.sort = tempSort
        
        // 更新两个标签的sort值
        await updateTagSortFunction(currentItem.id, currentItem.sort)
        await updateTagSortFunction(nextItem.id, nextItem.sort)
        
        // 在本地数组中交换位置
        tableData.value[index] = nextItem
        tableData.value[index + 1] = currentItem
        
        showMessage('下移成功')
    } catch (error) {
        console.error('下移失败:', error)
        showMessage('下移失败', 'error')
        // 出错时重新获取数据
        getTableData()
    }
}

// 更新标签排序
const updateTagSortFunction = async (id: number, sort: number): Promise<void> => {
    try {
        const res: ApiResponse = await updateTagSort({ id, sort })
        if (!res.success) {
            throw new Error(res.message || '更新排序失败')
        }
    } catch (error) {
        console.error('更新标签排序失败:', error)
        throw error
    }
}

// 移动标签到最前
const moveTagToFirst = async (record: TagItem, index: number): Promise<void> => {
    if (index === 0) {
        showMessage('已经是第一个了', 'warning')
        return
    }
    
    try {
        const res: ApiResponse = await updateTagSortFirst(record.id, record.sort)
        if (res.success) {
            showMessage('置顶成功')
            // 重新获取数据以更新排序
            await getTableData()
        } else {
            showMessage(res.message || '置顶失败', 'error')
        }
    } catch (error) {
        console.error('置顶标签失败:', error)
        showMessage('置顶失败，请重试', 'error')
    }
}

// 移动标签到最后
const moveTagToLast = async (record: TagItem, index: number): Promise<void> => {
    if (index === tableData.value.length - 1) {
        showMessage('已经是最后一个了', 'warning')
        return
    }
    
    try {
        const res: ApiResponse = await updateTagSortLast(record.id, record.sort)
        if (res.success) {
            showMessage('置底成功')
            // 重新获取数据以更新排序
            await getTableData()
        } else {
            showMessage(res.message || '置底失败', 'error')
        }
    } catch (error) {
        console.error('置底标签失败:', error)
        showMessage('置底失败，请重试', 'error')
    }
}

// 标签输入框值
const inputValue: Ref<string> = ref('')
// 已输入的标签数组
const dynamicTags: Ref<string[]> = ref([])
// 标签输入框是否显示
const inputVisible: Ref<boolean> = ref(false)
// 标签输入框的引用
const InputRef: Ref<any> = ref(null)

const handleClose = (tag: string): void => {
  dynamicTags.value.splice(dynamicTags.value.indexOf(tag), 1)
}

const showInput = (): void => {
  inputVisible.value = true
  nextTick(() => {
    if (InputRef.value) {
      InputRef.value.focus()
    }
  })
}

const handleInputConfirm = (): void => {
  if (inputValue.value) {
    dynamicTags.value.push(inputValue.value)
  }
  inputVisible.value = false
  inputValue.value = ''
}

// 组件挂载时初始化数据
onMounted((): void => {
  getTableData()
})

</script>

<style lang="scss" scoped>

.tag-list {
  height: calc(100vh - 165px);
  
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

      .ant-input {
        margin-right: 16px;
      }

      .ant-picker {
        margin-right: 16px;
      }
    }
  }

  .table-card {
    :deep(.ant-card-body) {
      display: flex;
      flex-direction: column;
      height: 100%;
      padding: 24px;
    }
    
    .table-header {
      display: flex;
      align-items: center;
      margin-bottom: 16px;
      flex-shrink: 0;
      .table-title {
        font-size: 16px;
        font-weight: 500;
      }
      /* 新增标签按钮样式 */
      .add-tag-btn {
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
        /* overflow-y: auto; */
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
      border-top: 1px solid #f0f0f0;
      padding-top: 16px;
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

.button-new-tag {
    margin-inline-start: 10px;
    block-size: 32px;
    line-height: 30px;
    padding-block-start: 0;
    padding-block-end: 0;
}

.input-new-tag {
    inline-size: 90px;
    margin-inline-start: 10px;
    vertical-align: bottom;
}

.tag-input-container {
    min-height: 60px;
    padding: 8px;
    border: 1px solid #d9d9d9;
    border-radius: 6px;
    background-color: #fafafa;
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