<template>
    <div class="wiki-list p-6 h-full flex flex-col">
        <!-- 表头分页查询条件 -->
        <a-card class="mb-5 search-card flex-shrink-0">
            <!-- flex 布局，内容垂直居中 -->
            <div class="flex justify-start items-center search-form">
                <span>知识库标题</span>
                <div class="ml-3 w-52 me-5">
                    <a-input v-model:value="searchWikiTitle" placeholder="请输入（模糊查询）" allow-clear />
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
        
        <!-- 知识库列表 -->
        <a-card class="table-card flex-1 flex flex-col overflow-hidden">
            <!-- 新增知识库按钮 -->
            <div class="table-header mb-5 flex justify-end flex-shrink-0">
                <a-button type="primary" class="add-wiki-btn" @click="addWikiBtnClick">
                    <template #icon><PlusOutlined /></template>
                    新增知识库
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
                    :row-key="(record: WikiItem) => record.id"
                    :row-class-name="(record: WikiItem) => record.isDeleted === 1 ? 'deleted-row' : ''"
                >
                <template #bodyCell="{ column, record, index }">
                    <template v-if="column.key === 'index'">
                        {{ index + 1 }}
                    </template>
                    <template v-else-if="column.key === 'cover'">
                        <a-image :width="100" :src="record.cover" />
                    </template>
                    <template v-else-if="column.key === 'isTop'">
                        <a-switch
                            v-model:checked="record.isTop"
                            @change="handleIsTopChange(record)"
                            checked-children="置顶"
                            un-checked-children="普通"
                        />
                    </template>
                    <template v-else-if="column.key === 'isPublish'">
                        <a-switch
                            v-model:checked="record.isPublish"
                            @change="handleIsPublishChange(record)"
                            checked-children="发布"
                            un-checked-children="草稿"
                        />
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
                                    @click="moveWikiToFirst(record, index)" 
                                    shape="circle"
                                    :disabled="index === 0"
                                >
                                    <template #icon><VerticalAlignTopOutlined /></template>
                                </a-button>
                            </a-tooltip>
                            
                            <a-tooltip title="置底">
                                <a-button 
                                    size="small" 
                                    @click="moveWikiToLast(record, index)" 
                                    shape="circle"
                                    :disabled="index === tableData.length - 1"
                                >
                                    <template #icon><VerticalAlignBottomOutlined /></template>
                                </a-button>
                            </a-tooltip>
                            
                            <a-tooltip title="上移">
                                <a-button 
                                    size="small" 
                                    @click="moveWikiUp(record, index)" 
                                    shape="circle"
                                    :disabled="index === 0"
                                >
                                    <template #icon><UpOutlined /></template>
                                </a-button>
                            </a-tooltip>
                            
                            <a-tooltip title="下移">
                                <a-button 
                                    size="small" 
                                    @click="moveWikiDown(record, index)" 
                                    shape="circle"
                                    :disabled="index === tableData.length - 1"
                                >
                                    <template #icon><DownOutlined /></template>
                                </a-button>
                            </a-tooltip>
                            
                            <a-tooltip title="编辑">
                                <a-button size="small" @click="showEditWikiDialog(record)" shape="circle">
                                    <template #icon><EditOutlined /></template>
                                </a-button>
                            </a-tooltip>
                            
                            <a-tooltip title="编辑目录">
                                <a-button size="small" @click="showEditWikiCatalogDialog(record)" shape="circle">
                                    <template #icon><UnorderedListOutlined /></template>
                                </a-button>
                            </a-tooltip>
                            
                            <a-tooltip title="预览">
                                <a-button size="small" shape="circle">
                                    <template #icon><EyeOutlined /></template>
                                </a-button>
                            </a-tooltip>
                                
                            <a-tooltip title="删除">
                                <a-button danger size="small" @click="deleteWikiSubmit(record)" shape="circle">
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

        <!-- 新增知识库 -->
        <a-modal 
            v-model:open="formDialogVisible" 
            title="新增知识库" 
            class="wiki-modal"
            :width="600"
            :footer="null"
        >
            <a-form ref="formRef" :rules="rules" :model="form" :label-col="{ span: 4 }">
                <a-form-item label="标题" name="title">
                    <a-input v-model:value="form.title" placeholder="请输入知识库标题" :maxlength="20" show-count allow-clear />
                </a-form-item>
                <a-form-item label="封面" name="cover">
                    <div class="upload-container">
                        <a-upload 
                            class="logo-uploader" 
                            action=""
                            :show-upload-list="false"
                            :before-upload="handleCoverChange"
                            accept="image/*"
                        >
                            <div class="upload-area logo-area">
                                <img v-if="form.cover" :src="form.cover" class="uploaded-image logo-image" alt="封面" />
                                <div v-else class="upload-placeholder">
                                    <PlusOutlined class="upload-icon" />
                                    <div class="upload-text">上传封面</div>
                                    <div class="upload-hint">建议尺寸: 200x120px</div>
                                </div>
                            </div>
                        </a-upload>
                    </div>
                </a-form-item>
                <a-form-item label="摘要" name="summary">
                    <a-textarea 
                        v-model:value="form.summary" 
                        :rows="3" 
                        :maxlength="30" 
                        show-count 
                        placeholder="请输入知识库摘要" 
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

        <!-- 编辑知识库 -->
        <a-modal v-model:open="editFormDialogVisible" 
            title="编辑知识库" 
            class="wiki-modal"
            :width="600"
            :footer="null"
        >
            <a-form ref="editFormRef" :rules="rules" :model="editForm" :label-col="{ span: 4 }">
                <a-form-item label="标题" name="title">
                    <a-input v-model:value="editForm.title" placeholder="请输入知识库标题" :maxlength="20" show-count allow-clear />
                </a-form-item>
                <a-form-item label="封面" name="cover">
                    <div class="upload-container">
                        <a-upload 
                            class="logo-uploader" 
                            action=""
                            :show-upload-list="false"
                            :before-upload="handleUpdateCoverChange"
                            accept="image/*"
                        >
                            <div class="upload-area logo-area">
                                <img v-if="editForm.cover" :src="editForm.cover" class="uploaded-image logo-image" alt="" />
                                <div v-else class="upload-placeholder">
                                    <PlusOutlined class="upload-icon" />
                                    <div class="upload-text">上传封面</div>
                                    <div class="upload-hint">建议尺寸: 200x120px</div>
                                </div>
                            </div>
                        </a-upload>
                    </div>
                </a-form-item>
                <a-form-item label="摘要" name="summary">
                    <a-textarea 
                        v-model:value="editForm.summary" 
                        :rows="3" 
                        :maxlength="30" 
                        show-count 
                        placeholder="请输入知识库摘要" 
                        allow-clear 
                    />
                </a-form-item>
            </a-form>
            
            <!-- 自定义按钮区域 -->
            <div class="modal-footer flex justify-end gap-3 mt-6 pt-4 border-t border-gray-200">
                <a-button size="middle" @click="closeEditFormDialog">取消</a-button>
                <a-button type="primary" size="middle" :loading="editFormSubmitLoading" @click="onEditWikiSubmit">确定</a-button>
            </div>
        </a-modal>

        <!-- 删除知识库确认对话框 -->
        <a-modal 
            v-model:open="deleteDialogVisible" 
            title="删除知识库" 
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
                        <div class="font-medium text-gray-900">确认删除知识库</div>
                        <div class="text-sm text-gray-500 mt-1">请选择删除方式，不同方式的影响不同</div>
                    </div>
                </div>
                <div class="delete-info p-4 rounded-lg mb-4">
                    <p class="text-sm">
                        是否确定要删除知识库 <span class="font-medium">"{{ currentDeleteWiki?.title }}"</span> ？
                    </p>
                    <p class="text-xs mt-2">
                        删除后该知识库下的所有文章将一并删除
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
                                        知识库将被标记为已删除，但数据仍保留在数据库中，可以恢复
                                    </div>
                                </div>
                            </a-radio>
                            <a-radio :value="2" class="flex items-start">
                                <div class="ml-2">
                                    <div class="font-medium">物理删除</div>
                                    <div class="text-xs text-gray-500 mt-1">
                                        知识库将从数据库中彻底删除，包括所有文章，此操作不可撤销
                                    </div>
                                </div>
                            </a-radio>
                            <a-radio :value="3" class="flex items-start">
                                <div class="ml-2">
                                    <div class="font-medium">取消删除</div>
                                    <div class="text-xs text-gray-500 mt-1">
                                        恢复已删除的知识库，使其重新可用
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
        <!-- 目录编辑 -->
        <WikiCatalogEditDialog ref="editCatalogFormDialogRef" title="编辑目录" width="70%" destroyOnClose></WikiCatalogEditDialog>
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
    EyeOutlined, 
    UnorderedListOutlined,
    UpOutlined,
    DownOutlined,
    VerticalAlignTopOutlined,
    VerticalAlignBottomOutlined
} from '@ant-design/icons-vue'
import type { TableColumnsType, UploadFile } from 'ant-design-vue'
import moment, { type Moment } from 'moment'
import { getWikiPageList, addWiki, updateWikiIsTop, updateWikiIsPublish, deleteWiki, updateWiki, updateWikiSort, updateWikiSortFirst, updateWikiSortLast } from '@/api/admin/wiki'
import WikiCatalogEditDialog from '@/components/admin/WikiCatalogEditDialog.vue'
import { uploadImage } from '@/api/admin/image'
import { showMessage, showModel } from '@/composables/util.ts'

// 类型定义
interface WikiItem {
    id: number
    title: string
    cover: string
    summary: string
    isTop: boolean
    isPublish: boolean
    createTime: string
    weight?: number  // 权重字段（优先级最高）
    sort?: number    // 排序字段
    isDeleted: number // 删除状态：0-未删除，1-已删除
}

interface WikiForm {
    title: string
    cover: string
    summary: string
}

interface EditWikiForm extends WikiForm {
    id: number | null
}

interface DatePreset {
    label: string
    value: [Moment, Moment]
}

// 模糊搜索的知识库标题
const searchWikiTitle = ref<string>('')
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
    searchWikiTitle.value = '';
    getTableData();
}

// 表格加载 Loading
const tableLoading = ref<boolean>(false)
// 表格数据
const tableData = ref<WikiItem[]>([])
// 当前页码
const current = ref<number>(1)
// 总数据量
const total = ref<number>(0)
// 每页显示的数据量
const size = ref<number>(20)

// 保存老封面 URL，用于获取原始文件名
const oldCoverUrl = ref<string>('')

// 表格列定义
const columns: TableColumnsType = [
    {
        title: '序号',
        key: 'index',
        width: 80,
        align: 'center'
    },
    {
        title: '标题',
        dataIndex: 'title',
        key: 'title'
    },
    {
        title: '摘要',
        dataIndex: 'summary',
        key: 'summary'
    },
    {
        title: '封面',
        key: 'cover',
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
        title: '发布时间',
        dataIndex: 'createTime',
        key: 'createTime',
        width: 180,
        align: 'center',
    },
    {
        title: '是否发布',
        key: 'isPublish',
        width: 100,
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
        key: 'action',
        // fixed: 'right',
        width: 250,
        align: 'center'
    }
]

// 获取分页数据
const getTableData = (): void => {
    // 显示表格 loading
    tableLoading.value = true
    // 调用后台分页接口，并传入所需参数
    getWikiPageList({ 
        current: current.value, 
        size: size.value, 
        startDate: startDate.value, 
        endDate: endDate.value, 
        title: searchWikiTitle.value 
    })
        .then((res: any) => {
            if (res.success === true) {
                let wikiList = res.data || [];
                
                // 分两步排序：第一步处理weight>0的数据，第二步处理其他数据
                // 第一步：筛选出weight > 0的数据并排序
                const weightItems = wikiList.filter(item => 
                    item.hasOwnProperty('weight') && 
                    item.weight !== null && 
                    item.weight !== undefined && 
                    item.weight > 0
                );
                
                // 对weight > 0的数据按weight降序排序
                weightItems.sort((a, b) => {
                    const weightA = a.weight || 0;
                    const weightB = b.weight || 0;
                    if (weightA !== weightB) {
                        return weightB - weightA; // weight降序
                    }
                    // weight相同时，按sort降序排序
                    const sortA = a.sort || 0;
                    const sortB = b.sort || 0;
                    if (sortA !== sortB) {
                        return sortB - sortA;
                    }
                    // weight和sort都相同时，按id升序排序
                    return Number(a.id) - Number(b.id);
                });
                
                // 第二步：筛选出weight <= 0或没有weight字段的数据
                const sortItems = wikiList.filter(item => 
                    !item.hasOwnProperty('weight') || 
                    item.weight === null || 
                    item.weight === undefined || 
                    item.weight <= 0
                );
                
                // 对这些数据按sort降序排序
                sortItems.sort((a, b) => {
                    const sortA = a.sort || 0;
                    const sortB = b.sort || 0;
                    if (sortA !== sortB) {
                        return sortB - sortA; // sort降序
                    }
                    // sort相同时，按id升序排序
                    return Number(a.id) - Number(b.id);
                });
                
                // 合并两个数组：weight > 0的在前，其他的在后
                wikiList = [...weightItems, ...sortItems];
                
                tableData.value = wikiList
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

// 新增知识库按钮点击事件
const addWikiBtnClick = (): void => {
    formDialogVisible.value = true
    // 清空待上传的文件
    pendingCoverImage.value = null
}

// 关闭新增对话框
const closeFormDialog = (): void => {
    formDialogVisible.value = false
    formSubmitLoading.value = false
    // 重置表单
    form.title = ''
    form.cover = ''
    form.summary = ''
    pendingCoverImage.value = null
}

// 表单引用
const formRef = ref(null)
// 表单对象
const form = reactive<WikiForm>({
    title: '',
    cover: '',
    summary: ''
})

// 待上传的封面图片文件
const pendingCoverImage = ref<File | null>(null)

// 表单校验规则
const rules = {
    title: [
        { required: true, message: '请输入标题', trigger: 'blur' },
        { min: 1, max: 20, message: '标题要求大于1个字符，小于20个字符', trigger: 'blur' },
    ],
    summary: [
        { required: true, message: '请输入摘要', trigger: 'blur' },
        { min: 1, max: 30, message: '摘要要求大于1个字符，小于30个字符', trigger: 'blur' },
    ],
    cover: [{ required: true, message: '请上传封面', trigger: 'change' }],
}

// 上传封面图片
const handleCoverChange = (file: UploadFile): boolean => {
    console.log('handleCoverChange called with file:', file)
    
    // 检查文件是否存在
    const fileObj = file.originFileObj || file as any
    if (!fileObj) {
        console.error('No file object found')
        return false
    }
    
    // 暂存文件，不立即上传
    pendingCoverImage.value = fileObj
    
    // 预览图片
    const reader = new FileReader()
    reader.onload = (e: ProgressEvent<FileReader>) => {
        console.log('FileReader onload triggered')
        if (e.target?.result) {
            form.cover = e.target.result as string // 显示预览
            console.log('Image preview set:', form.cover.substring(0, 50) + '...')
        }
    }
    
    reader.onerror = (e) => {
        console.error('FileReader error:', e)
    }
    
    reader.readAsDataURL(fileObj)
    return false // 阻止自动上传
}

const onSubmit = (): void => {
    // 先验证 form 表单字段
    (formRef.value as any)?.validate().then(() => {
        // 显示提交按钮 loading
        formSubmitLoading.value = true
        
        // 如果有待上传的封面图片，先上传
        if (pendingCoverImage.value) {
            uploadImage(pendingCoverImage.value, pendingCoverImage.value.name, "").then((e: any) => {
                // 上传失败，提示错误消息
                if (e.success === false) {
                    const message = e.message
                    showMessage(message, 'error')
                    formSubmitLoading.value = false
                    return
                }
                
                // 上传成功，设置封面链接并提交表单
                form.cover = e.data.url
                submitWikiForm()
            })
        } else {
            // 没有新的封面图片，直接提交
            submitWikiForm()
        }
    }).catch(() => {
        console.log('表单验证不通过')
    })
}

// 提交知识库表单
const submitWikiForm = (): void => {
    addWiki(form).then((res: any) => {
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
const handleIsTopChange = (row: WikiItem): void => {
    updateWikiIsTop({id: row.id, isTop: row.isTop}).then((res: any) => {
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

// 更新发布状态
const handleIsPublishChange = (row: WikiItem): void => {
    updateWikiIsPublish({id: row.id, isPublish: row.isPublish}).then((res: any) => {
        if (res.success === false) {
            // 获取服务端返回的错误消息
            const message = res.message
            // 提示错误消息
            showMessage(message, 'error')
            // 重新请求分页接口，渲染列表数据
            getTableData()
            return
        }

        showMessage(row.isPublish ? '发布成功' : '已取消发布')
        // 重新请求分页接口，渲染列表数据
        getTableData()
    })
}

// 删除知识库 - 打开确认对话框
const deleteWikiSubmit = (row: WikiItem): void => {
    currentDeleteWiki.value = row
    deleteDialogVisible.value = true
}

// 取消删除
const handleDeleteCancel = (): void => {
    deleteDialogVisible.value = false
    currentDeleteWiki.value = null
    deleteLoading.value = false
    deleteType.value = null
}

// 确认删除
const confirmDelete = async (): Promise<void> => {
    if (!currentDeleteWiki.value || deleteType.value === null) return
    
    deleteLoading.value = true
    try {
        console.log('删除操作类型:', deleteType.value === 1 ? '逻辑删除' : deleteType.value === 2 ? '物理删除' : deleteType.value === 3 ? '取消删除' : '未知操作')
        const res: any = await deleteWiki(currentDeleteWiki.value.id, deleteType.value)
        if (res.success) {
            const successMessage = deleteType.value === 1 ? '逻辑删除成功' : deleteType.value === 2 ? '物理删除成功' : deleteType.value === 3 ? '取消删除成功' : '操作成功'
            showMessage(successMessage)
            // 重新请求分页接口，渲染数据
            getTableData()
            handleDeleteCancel()
        } else {
            showMessage(res.message || '操作失败', 'error')
        }
    } catch (error) {
        console.error('操作知识库失败:', error)
        showMessage('操作失败，请重试', 'error')
    } finally {
        deleteLoading.value = false
    }
}

// 上移知识库
const moveWikiUp = (record: WikiItem, index: number): void => {
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
    updateWikiSortFunction(currentItem.id, currentItem.sort)
    updateWikiSortFunction(prevItem.id, prevItem.sort)
}

// 下移知识库
const moveWikiDown = (record: WikiItem, index: number): void => {
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
    updateWikiSortFunction(currentItem.id, currentItem.sort)
    updateWikiSortFunction(nextItem.id, nextItem.sort)
}

// 更新知识库排序
const updateWikiSortFunction = async (id: number, sort: number): Promise<void> => {
    try {
        const res: any = await updateWikiSort(id, sort)
        if (!res.success) {
            showMessage(res.message || '更新排序失败', 'error')
            // 如果更新失败，重新获取数据
            getTableData()
        } else {
            showMessage('排序更新成功')
        }
    } catch (error) {
        console.error('更新知识库排序失败:', error)
        showMessage('更新排序失败，请重试', 'error')
        // 如果更新失败，重新获取数据
        getTableData()
    }
}

// 移动知识库到最前面
const moveWikiToFirst = async (record: WikiItem, index: number): Promise<void> => {
    if (index === 0) {
        showMessage('已经是第一个了', 'warning')
        return
    }
    
    try {
        const res: any = await updateWikiSortFirst(record.id, record.sort || 0)
        if (!res.success) {
            showMessage(res.message || '移动到最前面失败', 'error')
            getTableData()
        } else {
            showMessage('已移动到最前面')
            getTableData() // 重新获取数据以更新排序
        }
    } catch (error) {
        console.error('移动知识库到最前面失败:', error)
        showMessage('移动到最前面失败，请重试', 'error')
        getTableData()
    }
}

// 移动知识库到最后面
const moveWikiToLast = async (record: WikiItem, index: number): Promise<void> => {
    if (index === tableData.value.length - 1) {
        showMessage('已经是最后一个了', 'warning')
        return
    }
    
    try {
        const res: any = await updateWikiSortLast(record.id, record.sort || 0)
        if (!res.success) {
            showMessage(res.message || '移动到最后面失败', 'error')
            getTableData()
        } else {
            showMessage('已移动到最后面')
            getTableData() // 重新获取数据以更新排序
        }
    } catch (error) {
        console.error('移动知识库到最后面失败:', error)
        showMessage('移动到最后面失败，请重试', 'error')
        getTableData()
    }
}

// 从原始 logo URL 中提取原始文件名
const getOriginalImageName = (url: string): string => {
    if (!url) return ''
    const urlParts = url.split('/')
    return urlParts[urlParts.length - 1] || '' // 获取 URL 最后一部分作为文件名，如果为 undefined 则返回空字符串
}

// 编辑表单对话框是否可见
const editFormDialogVisible = ref<boolean>(false)
// 编辑表单提交 loading
const editFormSubmitLoading = ref<boolean>(false)

// 删除对话框相关
const deleteDialogVisible = ref<boolean>(false)
const deleteLoading = ref<boolean>(false)
const currentDeleteWiki = ref<WikiItem | null>(null)
const deleteType = ref<number | null>(null)

// 关闭编辑对话框
const closeEditFormDialog = (): void => {
    editFormDialogVisible.value = false
    editFormSubmitLoading.value = false
    // 重置表单
    editForm.id = null
    editForm.title = ''
    editForm.cover = ''
    editForm.summary = ''
    pendingEditCoverImage.value = null
    oldCoverUrl.value = ''
}

// 弹出知识库编辑对话框
const showEditWikiDialog = (row: WikiItem): void => {
    editFormDialogVisible.value = true
    editForm.id = row.id
    editForm.title = row.title
    editForm.cover = row.cover
    editForm.summary = row.summary
    // 保存原始封面URL，用于获取原始文件名
    oldCoverUrl.value = row.cover
    // 清空待上传的文件
    pendingEditCoverImage.value = null
}

// 表单引用
const editFormRef = ref(null)
// 表单对象
const editForm = reactive<EditWikiForm>({
    id: null,
    title: '',
    cover: '',
    summary: ''
})

// 编辑时待上传的封面图片文件
const pendingEditCoverImage = ref<File | null>(null)

// 知识库编辑：上传封面图片
const handleUpdateCoverChange = (file: UploadFile): boolean => {
    console.log('handleUpdateCoverChange called with file:', file)
    
    // 检查文件是否存在
    const fileObj = file.originFileObj || file as any
    if (!fileObj) {
        console.error('No file object found in edit mode')
        return false
    }
    
    // 暂存文件，不立即上传
    pendingEditCoverImage.value = fileObj
    
    // 预览图片
    const reader = new FileReader()
    reader.onload = (e: ProgressEvent<FileReader>) => {
        console.log('FileReader onload triggered in edit mode')
        if (e.target?.result) {
            editForm.cover = e.target.result as string // 显示预览
            console.log('Edit image preview set:', editForm.cover.substring(0, 50) + '...')
        }
    }
    
    reader.onerror = (e) => {
        console.error('FileReader error in edit mode:', e)
    }
    
    reader.readAsDataURL(fileObj)
    return false // 阻止自动上传
}

// 编辑知识库提交事件
const onEditWikiSubmit = (): void => {
    // 先验证 form 表单字段
    (editFormRef.value as any)?.validate().then(() => {
        // 显示提交按钮 loading
        editFormSubmitLoading.value = true
        
        // 如果有待上传的封面图片，先上传
        if (pendingEditCoverImage.value) {
            const oldImageName = getOriginalImageName(oldCoverUrl.value)
            const newImageOriginalName = pendingEditCoverImage.value.name
            uploadImage(pendingEditCoverImage.value, newImageOriginalName, oldImageName).then((e: any) => {
                // 上传失败，提示错误消息
                if (e.success === false) {
                    const message = e.message
                    showMessage(message, 'error')
                    editFormSubmitLoading.value = false
                    return
                }
                // 上传成功，设置封面链接并提交表单
                editForm.cover = e.data.url
                submitEditWikiForm()
            })
        } else {
            // 没有新的封面图片，直接提交
            submitEditWikiForm()
        }
    }).catch(() => {
        console.log('表单验证不通过')
    })
}

// 提交编辑知识库表单
const submitEditWikiForm = (): void => {
    updateWiki(editForm).then((res: any) => {
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

// 编辑目录对话框引用
const editCatalogFormDialogRef = ref<any>(null)
// 编辑目录按钮点击事件
const showEditWikiCatalogDialog = (row: WikiItem): void => {
    // 显示编辑目录对话框, 并传入知识库 ID
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
}

</style>