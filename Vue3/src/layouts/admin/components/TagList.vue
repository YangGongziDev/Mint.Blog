<template>
  <!-- 左边：标签导航栏 -->
  <div
    class="fixed top-[64px] h-[44px] px-2 right-0 flex items-center bg-white transition-all duration-300 shadow z-50"
    :style="{ left: menuStore.menuWidth }"
  >
    <a-tabs
      v-model:activeKey="activeTab"
      type="editable-card"
      class="demo-tabs" 
      hide-add
      @change="tabChange"
      @edit="removeTab"
      style="min-width: 10px"
    >
      <a-tab-pane
        v-for="item in tabList"
        :key="item.path"
        :tab="item.title"
        :closable="item.path !== '/admin/home'"
      ></a-tab-pane>
    </a-tabs>
    <!-- 右侧下拉菜单 -->
    <span class="ml-auto flex items-center justify-center h-[32px] w-[32px]">
      <a-dropdown>
        <span class="ant-dropdown-link dropdown-trigger">
          <MoreOutlined />
        </span>
        <template #overlay>
          <a-menu @click="handleMenuClick">
            <a-menu-item key="closeOthers">关闭其他</a-menu-item>
            <a-menu-item key="closeAll">关闭全部</a-menu-item>
          </a-menu>
        </template>
      </a-dropdown>
    </span>
  </div>
  <div class="h-[44px]"></div>
</template>

<script setup lang="ts">
import { useTabList } from "@/composables/useTagList.ts";
import { MoreOutlined } from "@ant-design/icons-vue";

const { menuStore, activeTab, tabList, tabChange, removeTab, handleCloseTab } =
  useTabList();

// 处理菜单点击事件
const handleMenuClick = (e: any) => {
  handleCloseTab(e.key);
};
</script>

<style scoped lang="scss">
// Ant Design Vue 标签页样式覆盖
:deep(.ant-tabs) {
  height: 32px;

  .ant-tabs-nav {
    margin-bottom: 0;

    .ant-tabs-tab {
      font-size: 12px;
      height: 32px;
      line-height: 32px;
      border: 1px solid #d8dce5;
      border-radius: 3px;
      margin: 0 1.6px;
      background: #fff;
      &.ant-tabs-tab-active {
        .ant-tabs-tab-btn {
          color: #ffffff !important;
        }
        .ant-tabs-tab-remove {
          color: #ffffff;
          display: flex;
          align-items: center;
          justify-content: center;
          margin-left: 4px;
          &:hover {
            background-color: #ff4d4f !important;
            border-radius: 2px;
          }
        }
        background-color: #1890ff !important;
        color: #ffffff !important;
        border-color: #1890ff;
        font-weight: 600;
        text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        letter-spacing: 0.02em;
        position: relative;
        z-index: 10;
        &::before {
          content: "";
          background-color: rgba(255, 255, 255, 0.9);
          display: inline-block;
          width: 8px;
          height: 8px;
          border-radius: 50%;
          position: relative;
          margin-right: 4px;
          border: 1px solid rgba(255, 255, 255, 0.3);
          box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
        }
      }
    }

    .ant-tabs-nav-operations {
      line-height: 35px;
    }

    .ant-tabs-tab-remove {
      /* color: #ffffff; */
      display: flex;
      align-items: center;
      justify-content: center;
      margin-left: 4px;
      &:hover {
        background-color: #ff4d4f !important;
        border-radius: 2px;
        color: #1890ff;
      }
    }
  }
}

// 下拉菜单触发器样式
.dropdown-trigger {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 24px;
  height: 24px;
  border-radius: 4px;
  color: #666;
  cursor: pointer;
  transition: all 0.2s ease;
  
  &:hover {
    background-color: #f5f5f5;
    color: #1890ff;
  }
  
  .anticon {
    font-size: 16px;
  }
}

.ant-dropdown-link {
  cursor: pointer;
  color: #666;

  &:hover {
    color: #1890ff;
  }
}

.is-disabled {
  cursor: not-allowed;
  color: #d1d5db;
}
</style>