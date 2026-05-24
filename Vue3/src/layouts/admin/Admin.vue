<template>
  <div  class="admin-layout">
    <!-- 外层容器 -->
    <a-layout>
    
        <!-- 左边侧边栏 -->
        <a-layout-sider :width="menuStore.menuWidth" class="transition-all duration-300">
            <Menu></Menu>
        </a-layout-sider>
        
        <!-- 右边主内容区域 -->
        <a-layout class="right-main-layout">
            <!-- 顶栏容器 -->
            <a-layout-header class="fixed-header">
                <Header></Header>
            </a-layout-header>
            
            <!-- 标签导航栏 -->
            <div class="tag-nav-wrapper">
                <TagList></TagList>
            </div>
            
            <!-- 主内容区域 -->
            <div class="main-content-wrapper">
                <router-view v-slot="{ Component }">
                    <Transition name="fade">
                        <!-- max 指定最多缓存 10 个组件 -->
                        <KeepAlive :max="10">
                            <component :is="Component"></component>
                        </KeepAlive>
                    </Transition>
                </router-view>
            </div>

            <!-- 底栏容器 -->
            <a-layout-footer class="fixed-footer">
                <Footer></Footer>
            </a-layout-footer>
        </a-layout>
    </a-layout>
  </div>
</template>

<script setup lang="ts">
// Vue 相关导入
import { onMounted } from 'vue';

// 组件导入
import Footer from '@/layouts/admin/components/Footer.vue';
import Header from '@/layouts/admin/components/Header.vue';
import Menu from '@/layouts/admin/components/Menu.vue';
import TagList from '@/layouts/admin/components/TagList.vue';

// Store 导入
import { useMenuStore } from '@/stores/menu.ts';

// Store 实例
const menuStore = useMenuStore();

</script>

<style lang="scss" scoped>
// 外层容器样式
.admin-layout {
    width: 100vw;
    height: 100vh;
    overflow: hidden;
}

// 主布局容器
.ant-layout {
    height: 100%;
    display: flex;
    flex-direction: row;
}

// 右边主内容区域
.right-main-layout {
    height: 100vh;
    display: flex;
    flex-direction: column;
    overflow: hidden;
}

// 固定顶栏
.fixed-header {
    padding: 0 !important;
    height: 64px;
    flex-shrink: 0;
    z-index: 100;
}

// 标签导航栏
.tag-nav-wrapper {
    height: 40px;
    flex-shrink: 0;
    overflow: hidden;
}

// 主内容区域
.main-content-wrapper {
    flex: 1;
    overflow-y: auto;
    overflow-x: hidden;
    height: 0;
}

// 固定底栏
.fixed-footer {
    padding: 0 !important;
    height: 60px;
    flex-shrink: 0;
}

// 内容区域过渡动画：淡入淡出效果
.fade {
    // 进入动画
    &-enter {
        &-from {
            opacity: 0;
        }
        
        &-to {
            opacity: 1;
        }
        
        &-active {
            transition: all 0.3s;
            transition-delay: 0.3s;
        }
    }
    
    // 离开动画
    &-leave {
        &-from {
            opacity: 1;
        }
        
        &-to {
            opacity: 0;
        }
        
        &-active {
            transition: all 0.3s;
        }
    }
}
</style>