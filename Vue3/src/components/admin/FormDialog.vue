<template>
  <a-modal
    v-model:open="dialogVisible"
    :title="title"
    :width="width"
    :destroy-on-close="destroyOnClose"
    :mask-closable="false"
    :keyboard="false"
    :class="'form-dialog-modal'"
  >
    <!-- 插槽 -->
    <slot></slot>
    
    <template #footer>
      <div class="dialog-footer">
        <a-button @click="dialogVisible = false" class="cancel-btn">
          取消
        </a-button>
        <a-button 
          type="primary" 
          @click="submit" 
          :loading="btnLoading"
          class="confirm-btn"
        >
          {{ confirmText }}
        </a-button>
      </div>
    </template>
  </a-modal>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import type { Ref } from 'vue'

// 定义接口类型
interface Props {
  title?: string
  width?: string | number
  destroyOnClose?: boolean
  confirmText?: string
}

interface Emits {
  submit: []
}

// 对话框是否显示
const dialogVisible: Ref<boolean> = ref(false)

// 确认按钮加载 loading
const btnLoading: Ref<boolean> = ref(false)

// 显示 loading
const showBtnLoading = (): void => {
  btnLoading.value = true
}

// 隐藏 loading
const closeBtnLoading = (): void => {
  btnLoading.value = false
}

// 对外暴露属性
const props = withDefaults(defineProps<Props>(), {
  title: '',
  width: '40%',
  destroyOnClose: false,
  confirmText: '提交'
})
if(props.title){}

// 打开对话框
const open = (): void => {
  dialogVisible.value = true
}

// 关闭对话框
const close = (): void => {
  dialogVisible.value = false
}

// 对外暴露一个 submit 方法
const emit = defineEmits<Emits>()
const submit = (): void => {
  emit('submit')
}

// 对外暴露方法
defineExpose({
  open,
  close,
  showBtnLoading,
  closeBtnLoading,
})
</script>

<style lang="scss" scoped>
.form-dialog-modal {
  // 自定义对话框样式
  :deep(.ant-modal-header) {
    border-bottom: 1px solid #f0f0f0;
    padding: 16px 24px;
    
    .ant-modal-title {
      font-size: 16px;
      font-weight: 600;
      color: #262626;
    }
  }
  
  :deep(.ant-modal-body) {
    padding: 24px;
    max-height: 60vh;
    overflow-y: auto;
  }
  
  :deep(.ant-modal-footer) {
    border-top: 1px solid #f0f0f0;
    padding: 12px 24px;
  }
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  
  .cancel-btn {
    min-width: 80px;
    height: 32px;
    border-radius: 6px;
    font-weight: 400;
    
    &:hover {
      border-color: #d9d9d9;
      color: #262626;
    }
  }
  
  .confirm-btn {
    min-width: 80px;
    height: 32px;
    border-radius: 6px;
    font-weight: 500;
    
    &:hover {
      background-color: #4096ff;
      border-color: #4096ff;
    }
    
    &:focus {
      background-color: #1677ff;
      border-color: #1677ff;
    }
  }
  
  // 响应式设计
  @media (max-width: 768px) {
    flex-direction: column-reverse;
    gap: 8px;
    
    .cancel-btn,
    .confirm-btn {
      width: 100%;
      height: 40px;
    }
  }
}
</style>