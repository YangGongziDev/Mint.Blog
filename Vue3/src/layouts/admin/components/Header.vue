<template>
    <!-- 固钉组件，通过设置 offset 属性来改变吸顶距离，默认值为 0。 -->
    <a-affix :offset-top="0">
        <!-- 设置背景色为白色、高度为 64px，padding-right 为 4， border-bottom 为 slate 100 -->
        <div class="bg-white h-[64px] flex pr-4 border-b border-slate-100">
            <!-- 左边栏收缩、展开 -->
            <div class="w-[42px] h-[64px] cursor-pointer flex items-center justify-center text-gray-700 hover:bg-gray-200"
                @click="handleMenuWidth">
                <MenuFoldOutlined v-if="menuStore.menuWidth === '250px'" />
                <MenuUnfoldOutlined v-else />
            </div>
            <!-- 右边容器 -->
            <div class="ml-auto flex">
                <!-- 点击刷新页面 -->
                <a-tooltip title="刷新" placement="bottom">
                    <div class="w-[42px] h-[64px] cursor-pointer flex items-center justify-center text-gray-700"
                        @click="handleRefresh">
                        <img :src="refreshIcon" alt="刷新" class="w-8.5 h-8.5" />
                    </div>
                </a-tooltip>
                <!-- 点击跳转前台首页 -->
                <a-tooltip title="跳转前台" placement="bottom">
                    <div class="w-[42px] h-[64px] cursor-pointer flex items-center justify-center text-gray-700"
                        @click="router.push('/surfer')">
                        <img :src="surferIcon" alt="刷新" class="w-6 h-6" />
                    </div>
                </a-tooltip>
                <!-- 点击全屏展示 -->
                <a-tooltip title="全屏" placement="bottom">
                    <div class="w-[42px] h-[64px] cursor-pointer flex items-center justify-center text-gray-700 mr-2"
                        @click="toggle">
                        <img v-if="!isFullscreen" :src="fullScreenIcon" alt="刷新" class="w-8 h-8" />
                        <img v-else :src="smallScreenIcon" alt="刷新" class="w-8 h-8" />
                    </div>
                </a-tooltip>
                <!-- 白天黑夜切换 -->
                <a-tooltip title="黑白" placement="bottom">
                    <label class="switch ml-auto mt-4 mr-4">
                        <input type="checkbox" v-model="darkSwitch" @click="toggleDark()">
                        <span class="slider"></span>
                    </label>
                </a-tooltip>
                <!-- 登录用户头像 -->
                <a-dropdown class="flex items-center justify-center mr-2" @click="handleCommand">
                    <span class="flex items-center justify-center text-gray-700 text-xs cursor-pointer mr-2">
                        <!-- 头像 Avatar -->
                        <a-avatar class="mr-2" :size="40" style="border: 2px solid #667eea;margin-right: 8px;"
                            :src="blogSettingsStore.blogSettings?.avatar || '/Profile.jpg'" alt="" />
                        {{ userStore.userInfo.username || '用户' }}
                        <DownOutlined class="ml-2" />
                    </span>
                    <template #overlay>
                        <a-menu @click="handleMenuClick">
                            <a-menu-item key="updatePassword">修改密码</a-menu-item>
                            <a-menu-item key="logout">退出登录</a-menu-item>
                        </a-menu>
                    </template>
                </a-dropdown>
            </div>
        </div>

        <!-- 修改密码 -->
        <a-modal v-model:open="modalVisible" title="修改密码" width="500px" :footer="null">
            <a-form ref="formRef" :rules="rules" :model="form" :label-col="{ span: 6 }" :wrapper-col="{ span: 18 }">
                <a-form-item label="用户名" name="username">
                    <!-- 输入框组件 -->
                    <a-input v-model:value="form.username" placeholder="请输入用户名" disabled />
                </a-form-item>
                <a-form-item label="新密码" name="password">
                    <a-input-password v-model:value="form.password" placeholder="请输入新密码" />
                </a-form-item>
                <a-form-item label="确认新密码" name="rePassword">
                    <a-input-password v-model:value="form.rePassword" placeholder="请确认新密码" />
                </a-form-item>
            </a-form>
            <!-- 自定义按钮区域 -->
            <div class="modal-footer flex justify-end gap-3 mt-6 pt-4 border-t border-gray-200">
                <a-button size="middle" @click="handleCancel">取消</a-button>
                <a-button type="primary" size="middle" :loading="confirmLoading" @click="onSubmit">确定</a-button>
            </div>
        </a-modal>

        <!-- 退出登录确认对话框 -->
        <a-modal v-model:open="logoutModalVisible" title="退出登录" width="500px" :footer="null">
            <div class="logout-content py-4">
                <div class="flex items-center mb-4">
                    <div
                        class="warning-icon w-8 h-8 rounded-full flex items-center justify-center mr-3 bg-orange-100 text-orange-500">
                        <ExclamationCircleOutlined />
                    </div>
                    <div>
                        <div class="font-medium text-gray-900">确认退出登录</div>
                        <div class="text-sm text-gray-500 mt-1">退出后您需要重新登录才能访问管理功能</div>
                    </div>
                </div>
                <div class="logout-info p-4 bg-gray-50 rounded-lg">
                    <p class="text-sm text-gray-700">是否确定要退出当前账户？</p>
                    <p class="text-xs text-gray-500 mt-2">退出后需要重新登录才能访问。</p>
                </div>
            </div>
            <!-- 自定义按钮区域 -->
            <div class="modal-footer flex justify-end gap-3 mt-6 pt-4 border-t border-gray-200">
                <a-button size="middle" @click="handleLogoutCancel">取消</a-button>
                <a-button type="primary" danger size="middle" :loading="logoutLoading"
                    @click="confirmLogout">确定退出</a-button>
            </div>
        </a-modal>
    </a-affix>
</template>

<script setup lang="ts">
import { ref, reactive, watch } from 'vue'
import { useMenuStore } from '@/stores/menu'
import { useUserStore } from '@/stores/user'
import { useBlogSettingsStore } from '@/stores/blogsettings'
import { useFullscreen } from '@vueuse/core'
import { updateAdminPassword } from '@/api/admin/user'
import { showMessage } from '@/composables/util'
import { useRouter } from 'vue-router'
import {
    MenuFoldOutlined,
    MenuUnfoldOutlined,
    DownOutlined,
    ExclamationCircleOutlined
} from '@ant-design/icons-vue'
import type { FormInstance } from 'ant-design-vue'
import { useTheme } from '@/composables/useTheme.ts'
import refreshIcon from '@/assets/admin/header/Refresh.svg'
import surferIcon from '@/assets/admin/header/Surfer.svg'
import fullScreenIcon from '@/assets/admin/header/FullScreen.svg'
import smallScreenIcon from '@/assets/admin/header/SmallScreen.svg'

const router = useRouter();

// isFullscreen 表示当前是否处于全屏；toggle 用于动态切换全屏、非全屏
const { isFullscreen, toggle } = useFullscreen();

// 引入了菜单 Store
const menuStore = useMenuStore()
// 引入了用户 Store
const userStore = useUserStore()
// 引入博客设置 Store
const blogSettingsStore = useBlogSettingsStore()

// icon 点击事件
const handleMenuWidth = () => {
    menuStore.handleMenuWidth()
}

// 刷新页面
const handleRefresh = () => location.reload();

// 对话框是否显示
const modalVisible = ref(false)
const confirmLoading = ref(false)

// 使用统一的主题管理
const { isDark, darkSwitch, toggleDark } = useTheme();

// 下拉菜单事件处理
const handleCommand = () => {
    // 这个函数现在由 handleMenuClick 处理
}

// 菜单点击事件处理
const handleMenuClick = ({ key }: { key: string }) => {
    // 更新密码
    if (key === 'updatePassword') {
        // 显示修改密码对话框
        modalVisible.value = true
    } else if (key === 'logout') { // 退出登录
        logout()
    }
}

// 取消对话框
const handleCancel = () => {
    modalVisible.value = false
    // 重置表单
    form.password = ''
    form.rePassword = ''
}

// 退出登录对话框显示状态
const logoutModalVisible = ref(false)
const logoutLoading = ref(false)

// 退出登录
function logout() {
    logoutModalVisible.value = true
}

// 确认退出登录
const confirmLogout = async () => {
    userStore.logout()
    showMessage('退出登录成功！');
    logoutModalVisible.value = false
    // 跳转登录页
    router.push('/login');
}

// 取消退出登录
const handleLogoutCancel = () => {
    logoutModalVisible.value = false
}

// 表单引用
const formRef = ref<FormInstance>()

// 修改用户密码表单对象
interface PasswordForm {
    username: string
    password: string
    rePassword: string
}

const form = reactive<PasswordForm>({
    username: userStore.userInfo.username || '',
    password: '',
    rePassword: ''
})

// 监听Pinia store中的某个值的变化
watch(() => userStore.userInfo.username, (newValue, oldValue) => {
    // 在这里处理变化后的值
    console.log('新值:', newValue);
    console.log('旧值:', oldValue);

    // 可以在这里执行任何你需要的逻辑
    // 重新将新的值，设置会 form 对象中
    form.username = newValue || ''
});

// 规则校验
const rules = {
    username: [
        {
            required: true,
            message: '用户名不能为空',
            trigger: 'blur'
        }
    ],
    password: [
        {
            required: true,
            message: '密码不能为空',
            trigger: 'blur',
        },
    ],
    rePassword: [
        {
            required: true,
            message: '确认密码不能为空',
            trigger: 'blur',
        },
    ]
}

const onSubmit = async () => {
    try {
        // 先验证 form 表单字段
        await formRef.value?.validate()

        if (form.password !== form.rePassword) {
            showMessage('两次密码输入不一致，请检查！', 'warning')
            return
        }

        confirmLoading.value = true
        // 调用修改用户密码接口
        const res = await updateAdminPassword(form)
        console.log(res)
        // 判断是否成功
        if (res.success === true) {
            showMessage('密码重置成功，请重新登录！')
            // 退出登录
            userStore.logout()

            // 隐藏对话框
            modalVisible.value = false

            // 跳转登录页
            router.push('/login')
        } else {
            // 获取服务端返回的错误消息
            const message = res.message
            // 提示消息
            showMessage(message, 'error')
        }
    } catch (error) {
        console.log('表单验证不通过', error)
    } finally {
        confirmLoading.value = false
    }
}

</script>

<style lang="scss" scoped>
// ===========================
// 主题切换开关样式
// ===========================
.switch {
    position: relative;
    display: inline-block;
    width: 60px;
    height: 32px;

    input {
        opacity: 0;
        width: 0;
        height: 0;

        &:checked+.slider {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

            &:before {
                transform: translateX(28px);
                content: "🌙";
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 14px;
            }
        }
    }
}

.slider {
    position: absolute;
    cursor: pointer;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, #ffeaa7 0%, #fab1a0 100%);
    transition: all 0.3s ease;
    border-radius: 32px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);

    &:before {
        position: absolute;
        content: "☀️";
        height: 24px;
        width: 24px;
        left: 4px;
        bottom: 4px;
        background-color: white;
        transition: all 0.3s ease;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 14px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
    }

    &:hover {
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
    }
}
</style>