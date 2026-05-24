<template>
    <div class="article-list p-6 h-full flex flex-col">
        <!-- 表头分页查询条件 -->
        <a-card :bordered="false" class="mb-15 search-card flex-shrink-0">
            <!-- flex 布局，内容垂直居中 -->
            <div class="flex justify-start items-center search-form">
              <div class="search-item">
                <span>文章标题</span>
                <div class="ml-3 w-52 mr-5">
                  <a-input v-model:value="searchArticleTitle" placeholder="请输入（模糊查询）" allow-clear />
                </div>
              </div>
              <div class="search-item">
                <span>创建日期</span>
                <div class="ml-3 w-90 mr-5">
                  <!-- 日期选择组件（区间选择） -->
                  <a-range-picker 
                    v-model:value="pickDate" 
                    :placeholder="['开始时间', '结束时间']"
                    @change="datepickerChange" 
                  />
                </div>
              </div>
              <div class=""></div>
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

        <a-card :bordered="false" class="table-card flex-1 flex flex-col overflow-hidden">
            <!-- 写文章按钮 -->
            <div class="table-header">
              <span class="table-title">文章列表</span>
              <div class="action-buttons mb-5">
                  <a-button type="primary" class="add-article-btn" @click="goToCreateArticle">
                      <template #icon><EditOutlined /></template>
                      写文章
                  </a-button>
              </div>
            </div>

            <!-- 分页列表 -->
            <div class="table-container flex-1 overflow-hidden">
              <!-- :scroll="{ x: 1200, y: 'calc(100vh - 320px)' }"   :scroll="{ x: 1200, y: 580 }"  -->
                <a-table 
                    :dataSource="tableData" 
                    :columns="columns" 
                    :loading="tableLoading"
                    :pagination="false"
                    bordered
                    :scroll="{ x: 1200, y: 'calc(100vh - 550px)' }"
                    :row-key="(record: any) => record.id"
                    :row-class-name="(record: ArticleItem) => record.isDeleted === 1 ? 'deleted-row' : ''"
                >
                <template #bodyCell="{ column, record, index }">
                    <template v-if="column.key === 'index'">
                        {{ index + 1 }}
                    </template>
                    <template v-else-if="column.key === 'cover'">
                        <a-image :width="100" :src="record.cover" />
                    </template>
                    <template v-else-if="column.key === 'isTop'">
                        <a-switch @change="handleIsTopChange(record)"
                            v-model:checked="record.isTop"
                            checked-children="置顶" 
                            un-checked-children="普通"
                            class="top-switch"
                        />
                    </template>
                    <template v-else-if="column.key === 'status'">
                        <a-tag v-if="record.status === 1" color="success" class="status-tag published">已发布</a-tag>
                        <a-tag v-else color="warning" class="status-tag draft">草稿</a-tag>
                    </template>
                    <template v-else-if="column.key === 'isDeleted'">
                        <a-tag v-if="record.isDeleted === 0" color="success" class="status-tag normal">未删除</a-tag>
                        <a-tag v-else color="error" class="status-tag deleted">已删除</a-tag>
                    </template>
                    <template v-else-if="column.key === 'action'">
                        <a-space>
                            <a-tooltip title="编辑">
                                <a-button size="small" @click="goToEditArticle(record.id)" shape="circle">
                                    <template #icon><EditOutlined /></template>
                                </a-button>
                            </a-tooltip>
                            <a-tooltip title="预览">
                                <a-button size="small" @click="goArticleDetailPage(record.id)" shape="circle">
                                    <template #icon><EyeOutlined /></template>
                                </a-button>
                            </a-tooltip>
                            <a-tooltip title="删除">
                                <a-button danger size="small" @click="deleteArticleSubmit(record)" shape="circle">
                                    <template #icon><DeleteOutlined /></template>
                                </a-button>
                            </a-tooltip>
                        </a-space>
                    </template>
                </template>
                </a-table>
            </div>

            <!-- 分页 -->
            <div class="pagination-wrapper flex-shrink-0">
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

        <!-- 删除文章确认对话框 -->
        <a-modal 
            v-model:open="deleteDialogVisible" 
            title="删除文章" 
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
                        <div class="font-medium text-gray-900">确认删除文章</div>
                        <div class="text-sm text-gray-500 mt-1">请选择删除类型，谨慎操作</div>
                    </div>
                </div>
                <div class="delete-info p-4 rounded-lg mb-4">
                    <p class="text-sm">
                        是否确定要删除文章 <span class="font-medium">"{{ currentDeleteArticle?.title }}"</span> ？
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
                                        文章将被标记为已删除，但数据仍保留在数据库中，可以恢复
                                    </div>
                                </div>
                            </a-radio>
                            <a-radio :value="2" class="flex items-start">
                                <div class="ml-2">
                                    <div class="font-medium">物理删除</div>
                                    <div class="text-xs text-gray-500 mt-1">
                                        文章将从数据库中彻底删除，包括相关图片，此操作不可撤销
                                    </div>
                                </div>
                            </a-radio>
                            <a-radio :value="3" class="flex items-start">
                                <div class="ml-2">
                                    <div class="font-medium">取消删除</div>
                                    <div class="text-xs text-gray-500 mt-1">
                                        恢复已删除的文章，将删除状态重置为未删除
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
import { ref, onActivated } from 'vue'
import { 
  SearchOutlined, 
  ReloadOutlined, 
  EditOutlined, 
  EyeOutlined, 
  DeleteOutlined 
} from '@ant-design/icons-vue'
import { getArticlePageList, deleteArticle, updateArticleIsTop, getArticleDetail } from '@/api/admin/article'
import { deleteImages } from '@/api/admin/image'
import moment from 'moment'
import { showMessage, showModel } from '@/composables/util.ts'
import { useRouter } from 'vue-router'
import type { TableColumnsType } from 'ant-design-vue'

const router = useRouter()

// 文章数据接口定义
interface ArticleItem {
  id: number
  title: string
  cover: string
  content: string
  summary: string
  isTop: boolean
  isDeleted: number // 0: 未删除, 1: 已删除
  createTime: string
}

// 模糊搜索的文章标题
const searchArticleTitle = ref<string>('')
// 日期
const pickDate = ref<[string, string] | null>(null)

// 查询条件：开始结束时间
const startDate = ref<string | null>(null)
const endDate = ref<string | null>(null)

// 表格列配置
const columns: TableColumnsType = [
  {
      title: '序号',
      key: 'index',
      width: 80,
      align: 'center',
  },
  {
    title: '标题',
    dataIndex: 'title',
    key: 'title',
    width: 220,
    align: 'center',
  },
    {
    title: '摘要',
    dataIndex: 'summary',
    key: 'summary',
    width: 380,
    align: 'center',
  },
  {
    title: '封面',
    dataIndex: 'cover',
    key: 'cover',
    width: 180,
    align: 'center',
  },
  {
    title: '是否置顶',
    dataIndex: 'isTop',
    key: 'isTop',
    width: 100,
    align: 'center',
  },
  {
    title: '删除状态',
    dataIndex: 'isDeleted',
    key: 'isDeleted',
    width: 100,
    align: 'center',
  },
  {
    title: '发布时间',
    dataIndex: 'createTime',
    key: 'createTime',
    width: 180,
    align: 'center',
  },
  {
    title: '操作',
    key: 'action',
    width: 150,
    align: 'center',
  },
]

// 监听日期组件改变事件，并将开始结束时间设置到变量中
const datepickerChange = (dates: [string, string] | null): void => {
    if (dates && dates.length === 2) {
        startDate.value = moment(dates[0]).format('YYYY-MM-DD')
        endDate.value = moment(dates[1]).format('YYYY-MM-DD')
        console.log('开始时间：' + startDate.value + ', 结束时间：' + endDate.value)
    } else {
        startDate.value = null
        endDate.value = null
    }
}

// 重置查询条件
const reset = (): void => {
    pickDate.value = null;
    startDate.value = null;
    endDate.value = null;
    searchArticleTitle.value = '';
    getTableData();
}

// 表格加载 Loading
const tableLoading = ref<boolean>(false)
// 表格数据
const tableData = ref<ArticleItem[]>([])
// 当前页码
const current = ref<number>(1)
// 总数据量
const total = ref<number>(0)
// 每页显示的数据量
const size = ref<number>(20)

// 删除对话框相关
const deleteDialogVisible = ref<boolean>(false)
const deleteLoading = ref<boolean>(false)
const currentDeleteArticle = ref<ArticleItem | null>(null)
const deleteType = ref<number | null>(null) // 1: 逻辑删除, 2: 物理删除

// 提取文章中的所有图片引用
const extractImageReferences = (article: ArticleItem): string[] => {
    const imageRefs: string[] = []
    
    // 提取封面图片
    if (article.cover && article.cover.trim()) {
        // 从完整URL中提取文件名
        const coverFileName = article.cover.split('/').pop()
        if (coverFileName) {
            imageRefs.push(coverFileName)
        }
    }
    
    // 提取内容中的图片
    if (article.content) {
        // 匹配Markdown格式的图片: ![alt](url)
        const imageRegex = /!\[.*?\]\((.*?)\)/g
        let match
        while ((match = imageRegex.exec(article.content)) !== null) {
            const imageUrl = match[1]
            if (imageUrl && imageUrl.trim()) {
                // 从完整URL中提取文件名
                const fileName = imageUrl.split('/').pop()
                if (fileName && !imageRefs.includes(fileName)) {
                    imageRefs.push(fileName)
                }
            }
        }
        
        // 匹配HTML格式的图片: <img src="url">
        const htmlImageRegex = /<img[^>]+src=["']([^"']+)["'][^>]*>/g
        while ((match = htmlImageRegex.exec(article.content)) !== null) {
            const imageUrl = match[1]
            if (imageUrl && imageUrl.trim()) {
                // 从完整URL中提取文件名
                const fileName = imageUrl.split('/').pop()
                if (fileName && !imageRefs.includes(fileName)) {
                    imageRefs.push(fileName)
                }
            }
        }
    }
    
    return imageRefs
}

// 获取分页数据
function getTableData(): void {
    // 显示表格 loading
    tableLoading.value = true
    // 调用后台分页接口，并传入所需参数
    getArticlePageList({ 
        current: current.value, 
        size: size.value, 
        startDate: startDate.value, 
        endDate: endDate.value, 
        title: searchArticleTitle.value 
    })
        .then((res: any) => {
            if (res.success === true) {
                tableData.value = res.data
                current.value = res.current
                size.value = res.size
                total.value = res.total
            }
        })
        .finally(() => tableLoading.value = false) // 隐藏表格 loading
}
getTableData()

// 当组件被激活时（从缓存中恢复）重新获取数据
onActivated(() => {
    getTableData()
})

// 每页展示数量变更事件
const handleSizeChange = (current: number, pageSize: number): void => {
    size.value = pageSize
    getTableData()
}

// 删除文章 - 打开确认对话框
const deleteArticleSubmit = (row: ArticleItem): void => {
    currentDeleteArticle.value = row
    deleteDialogVisible.value = true
}

// 取消删除
const handleDeleteCancel = (): void => {
    deleteDialogVisible.value = false
    currentDeleteArticle.value = null
    deleteLoading.value = false
    deleteType.value = null
}

// 确认删除
const confirmDelete = async (): Promise<void> => {
    if (!currentDeleteArticle.value || !deleteType.value) return
    
    deleteLoading.value = true
    try {
        const articleId = currentDeleteArticle.value.id
        const selectedDeleteType = deleteType.value
        
        console.log('准备删除文章ID:', articleId, '删除类型:', selectedDeleteType === 1 ? '逻辑删除' : selectedDeleteType === 2 ? '物理删除' : '取消删除')
        
        // 如果是物理删除，需要先获取文章详情以删除相关图片
        if (selectedDeleteType === 2) {
            // 先获取文章详情以获取完整的content字段
            const detailRes: any = await getArticleDetail(articleId)
            if (!detailRes.success) {
                showMessage('获取文章详情失败', 'error')
                return
            }
            
            // 构造完整的文章对象
            const fullArticle: ArticleItem = {
                ...currentDeleteArticle.value,
                content: detailRes.data.content || '',
                summary: detailRes.data.summary || ''
            }
            
            // 提取文章中的所有图片引用
            const imgRef = extractImageReferences(fullArticle)
            console.log('提取到的图片引用:', imgRef)
            
            // 先删除文章
            const res: any = await deleteArticle(articleId, selectedDeleteType)
            if (res.success) {
                // 文章删除成功后，如果有图片引用，则删除图片
                if (imgRef.length > 0) {
                    try {
                        const imageRes: any = await deleteImages(imgRef)
                        if (imageRes.success) {
                            console.log('图片删除成功')
                        } else {
                            console.warn('图片删除失败:', imageRes.message)
                            // 图片删除失败不影响整体操作，只记录警告
                        }
                    } catch (imageError) {
                        console.warn('图片删除异常:', imageError)
                        // 图片删除异常不影响整体操作，只记录警告
                    }
                }
                
                showMessage('物理删除成功')
                // 重新请求分页接口，渲染数据
                getTableData()
                handleDeleteCancel()
            } else {
                showMessage(res.message || '删除失败', 'error')
            }
        } else if (selectedDeleteType === 1) {
            // 逻辑删除，不需要删除图片
            const res: any = await deleteArticle(articleId, selectedDeleteType)
            if (res.success) {
                showMessage('逻辑删除成功')
                // 重新请求分页接口，渲染数据
                getTableData()
                handleDeleteCancel()
            } else {
                showMessage(res.message || '删除失败', 'error')
            }
        } else if (selectedDeleteType === 3) {
            // 取消删除，恢复文章
            const res: any = await deleteArticle(articleId, selectedDeleteType)
            if (res.success) {
                showMessage('取消删除成功，文章已恢复')
                // 重新请求分页接口，渲染数据
                getTableData()
                handleDeleteCancel()
            } else {
                showMessage(res.message || '取消删除失败', 'error')
            }
        }
    } catch (error) {
        console.error('删除文章失败:', error)
        showMessage('删除失败，请重试', 'error')
    } finally {
        deleteLoading.value = false
    }
}

// 跳转到新建文章页面
const goToCreateArticle = (): void => {
    router.push('/admin/article/create')
}

// 跳转到编辑文章页面
const goToEditArticle = (articleId: number): void => {
    router.push(`/admin/article/edit/${articleId}`)
}

// 跳转文章详情页（在新标签页中打开）
const goArticleDetailPage = (articleId: number): void => {
    const url = router.resolve('/surfer/article/' + articleId).href
    window.open(url, '_blank')
}

// 点击置顶
const handleIsTopChange = (row: ArticleItem): void => {
    updateArticleIsTop({ id: row.id, isTop: row.isTop }).then((res: any) => {
        // 重新请求分页接口，渲染列表数据
        getTableData()

        if (res.success === false) {
            // 获取服务端返回的错误消息
            const message = res.message
            // 提示错误消息
            showMessage(message, 'error')
            return
        }

        showMessage(row.isTop ? '置顶成功' : '已取消置顶')
    })
}
</script>

<style scoped lang="scss">
.article-list {
  height: calc(100vh - 165px); // 减去header和taglist的高度
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
        margin-bottom: 0;
        
        span {
          white-space: nowrap;
          font-weight: 500;
        }
      }
    }
  }

  .table-card {
    :deep(.ant-card-body) {
      height: 100%;
      display: flex;
      flex-direction: column;
      padding: 24px;
    }
    
    .table-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 16px;
      flex-shrink: 0;

      .table-title {
        font-size: 16px;
        font-weight: 500;
      }
    }

    .action-buttons {
      display: flex;
      gap: 8px;
      /* 新增文章按钮样式 */
      .add-article-btn {
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
      :deep(.ant-table-wrapper) {
        height: 100%;
        
        .ant-table {
          height: 100%;
        }
        
        .ant-table-container {
          height: 100%;
        }
        
        .ant-table-body {
          // 移除强制高度设置，让表格的scroll属性控制滚动
        }
      }
    }

    .pagination-wrapper {
      margin-top: 16px;
      display: flex;
      justify-content: flex-end;
      padding-top: 16px;
      border-top: 1px solid #f0f0f0;
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

  // 已删除行的样式
  :deep(.deleted-row) {
    background-color: #f5f5f5 !important;
    color: #999 !important;
    opacity: 0.7;
    
    td {
      background-color: #f5f5f5 !important;
      color: #999 !important;
    }
    
    &:hover {
      background-color: #eeeeee !important;
      
      td {
        background-color: #eeeeee !important;
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
</style>