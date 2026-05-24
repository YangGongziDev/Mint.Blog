<template>
    <div class="fixed overflow-y-auto bg-gradient-to-b from-slate-800 to-slate-900 h-screen text-white menu-container transition-all
        duration-300 shadow-2xl border-r border-slate-700/50" :style="{ width: menuStore.menuWidth }">
        <!-- 顶部 Logo, 指定高度为 64px, 和右边的 Header 头保持一样高 -->
        <div class="flex items-center justify-center h-[64px] border-b border-slate-700/30 hover:bg-slate-700/20 transition-colors duration-200 cursor-pointer" 
             @click="router.push('/admin/home')">
            <img v-if="menuStore.menuWidth === '250px'" src="@/assets/MintBlogLogo.svg" class="h-[50px] transition-all duration-300 hover:scale-105" alt="">
            <img v-else src="@/assets/MintBlogLogo.svg" class="h-[50px] transition-all duration-300 hover:scale-105" alt="">
        </div>
        <!-- 下方菜单 -->
        <div class="px-2 py-4">
            <a-menu 
                :selected-keys="[defaultActive]" 
                @click="handleMenuClick" 
                :inline-collapsed="isCollapse"
                theme="dark"
                mode="inline"
                class="custom-menu"
            >
                <template v-for="item in menus" :key="item.path">
                    <a-menu-item class="menu-item-custom">
                        <template #icon>
                            <a-tooltip 
                                :title="item.name" 
                                placement="right" 
                                :open="isCollapse ? undefined : false"
                                :mouse-enter-delay="0.3"
                                :mouse-leave-delay="0.1"
                            >
                                <component :is="item.icon" class="menu-icon"></component>
                            </a-tooltip>
                        </template>
                        <a-tooltip 
                            :title="item.name" 
                            placement="right" 
                            :open="isCollapse ? undefined : false"
                            :mouse-enter-delay="0.3"
                            :mouse-leave-delay="0.1"
                        >
                            <span class="menu-text">{{ item.name }}</span>
                        </a-tooltip>
                    </a-menu-item>
                </template>
            </a-menu>
        </div>
    </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useMenuStore } from '@/stores/menu'
import {
  MonitorOutlined,
  FileTextOutlined,
  FolderOpenOutlined,
  TagOutlined,
  BookOutlined,
  MessageOutlined,
  SettingOutlined,
  LinkOutlined
} from '@ant-design/icons-vue'

const menuStore = useMenuStore()

const route = useRoute()
const router = useRouter()

// 是否折叠
const isCollapse = computed(() => !(menuStore.menuWidth === '250px'))

// 根据路由地址判断哪个菜单被选中
const defaultActive = computed(() => route.path)

// 菜单选择事件
const handleMenuClick = ({ key }: { key: string }) => {
    router.push(key)
}

// 菜单项接口
interface MenuItem {
    name: string
    icon: any
    path: string
}

const menus: MenuItem[] = [
    {
        name: '仪表盘',
        icon: MonitorOutlined,
        path: '/admin/home'
    },
    {
        name: '文章管理',
        icon: FileTextOutlined,
        path: '/admin/article/list',
    },
    {
        name: '分类管理',
        icon: FolderOpenOutlined,
        path: '/admin/category/list',
    },
    {
        name: '标签管理',
        icon: TagOutlined,
        path: '/admin/tag/list',
    },
    {
        name: '知识库管理',
        icon: BookOutlined,
        path: '/admin/wiki/list',
    },
    {
        name: '友链管理',
        icon: LinkOutlined,
        path: '/admin/friend/list',
    },
    {
        name: '评论管理',
        icon: MessageOutlined,
        path: '/admin/comment/list',
    },
    {
        name: '博客设置',
        icon: SettingOutlined,
        path: '/admin/blog/settings',
    },
]
</script>

<style scoped lang="scss">
.menu-container {
    // Ant Design Vue 菜单样式覆盖
    :deep(.ant-menu) {
        background: transparent;
        border-right: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        .ant-menu-item {
            color: #e2e8f0;
            margin: 4px 0;
            border-radius: 8px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            &::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: linear-gradient(135deg, rgba(59, 130, 246, 0.1), rgba(147, 51, 234, 0.1));
                opacity: 0;
                transition: opacity 0.3s ease;
                z-index: 0;
            }
            
            &:hover {
                background: linear-gradient(135deg, rgba(59, 130, 246, 0.15), rgba(147, 51, 234, 0.15));
                color: #ffffff;
                transform: translateX(4px);
                box-shadow: 0 4px 12px rgba(59, 130, 246, 0.2);
                
                &::before {
                    opacity: 1;
                }
                
                .menu-icon {
                    transform: scale(1.1);
                    color: #60a5fa;
                }
            }
            
            &.ant-menu-item-selected {
                background: linear-gradient(135deg, #3b82f6, #8b5cf6);
                color: #ffffff;
                box-shadow: 0 4px 16px rgba(59, 130, 246, 0.3);
                
                &::before {
                    opacity: 1;
                }
                
                &:hover {
                    background: linear-gradient(135deg, #2563eb, #7c3aed);
                    transform: translateX(4px);
                }
                
                .menu-icon {
                    color: #ffffff;
                    transform: scale(1.05);
                }
                
                .menu-text {
                    font-weight: 600;
                }
            }
        }
        
        .ant-menu-item-icon {
            color: inherit;
            transition: all 0.3s ease;
        }
        
        // 折叠状态下的样式
        &.ant-menu-inline-collapsed {
            .ant-menu-item {
                padding: 0 20px;
                
                &:hover {
                    transform: scale(1.05);
                }
            }
        }
    }
    
    // 自定义菜单图标样式
    .menu-icon {
        font-size: 16px;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }
    
    // 自定义菜单文本样式
    .menu-text {
        font-size: 14px;
        font-weight: 500;
        transition: all 0.3s ease;
    }
    
    // 滚动条样式
    &::-webkit-scrollbar {
        width: 6px;
    }
    
    &::-webkit-scrollbar-track {
        background: rgba(30, 41, 59, 0.3);
    }
    
    &::-webkit-scrollbar-thumb {
        background: rgba(148, 163, 184, 0.3);
        border-radius: 3px;
        
        &:hover {
            background: rgba(148, 163, 184, 0.5);
        }
    }
}
</style>