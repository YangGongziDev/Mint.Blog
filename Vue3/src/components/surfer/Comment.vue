<template>
    <div class="mt-14">
        <h2 class="flex justify-center items-center mb-7 text-gray-500">全部评论<span>({{ total }})</span></h2>
        <!-- 卡片 -->
        <div class="theme-bg-secondary theme-text-primary" :class="props.customeCss">
            <!-- 评论发布表单 -->
            <form>
                <div class="theme-bg-secondary theme-text-primary flex gap-3">
                    <!-- 头像 -->
                    <div>
                        <img v-if="commentStore.userInfo.avatar && commentStore.userInfo.avatar.length > 0"
                            :src="commentStore.userInfo.avatar" class="w-10 h-10 rounded-full">
                        <UserOutlined v-else class="w-10 h-10 text-gray-400 dark:text-gray-400" />
                    </div>
                    <!-- 昵称、邮箱、网址、评论内容 -->
                    <div class="grow">
                        <div class="flex items-center gap-5 flex-row">
                            <div class="flex basis-1/3">
                                <span class="inline-flex border-r-0 items-center px-3 text-xs text-gray-900 bg-gray-100 border rounded-r-0 border-gray-300 rounded-l-md dark:bg-gray-600 dark:text-gray-400 dark:border-gray-600">
                                    昵称
                                </span>
                                <a-tooltip title="输入 QQ 号会自动获取昵称和头像" trigger="click">
                                    <input @blur="onNicknameInputBlur" v-model="commentStore.userInfo.nickname"
                                        type="text" id="website-admin"
                                        class="rounded-none rounded-r-lg  border text-gray-900 focus:ring-sky-500 
focus:border-sky-500 focus:outline-none block flex-1 min-w-0 w-full text-xs border-gray-300 p-2.5  dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-sky-500 dark:focus:border-sky-500"
                                        placeholder="必填">
                                </a-tooltip>
                            </div>
                            <div class="flex basis-1/3">
                                <span
                                    class="inline-flex border-r-0 items-center px-3 text-xs text-gray-900 bg-gray-100 border rounded-r-0 border-gray-300 rounded-l-md dark:bg-gray-600 dark:text-gray-400 dark:border-gray-600">
                                    邮箱
                                </span>
                                <a-tooltip title="收到回复将会发送到您的邮箱" trigger="click">
                                    <input v-model="commentStore.userInfo.mail" type="text" id="website-admin" class="rounded-none rounded-r-lg  border text-gray-900 focus:ring-sky-500 
focus:border-sky-500 focus:outline-none block flex-1 min-w-0 w-full text-xs border-gray-300 p-2.5  dark:bg-gray-700 dark:border-gray-600 
dark:placeholder-gray-400 dark:text-white dark:focus:ring-sky-500 dark:focus:border-sky-500" placeholder="必填">
                                </a-tooltip>
                            </div>
                            <div class="flex basis-1/3">
                                <span
                                    class="inline-flex border-r-0 items-center px-3 text-xs text-gray-900 bg-gray-100 border rounded-r-0 border-gray-300 rounded-l-md dark:bg-gray-600 dark:text-gray-400 dark:border-gray-600">
                                    网址
                                </span>
                                <a-tooltip title="可通过点击头像访问你的网站 (非必填)" trigger="click">
                                    <input v-model="commentStore.userInfo.website"
                                        type="text"
                                        id="website-admin" class="rounded-none rounded-r-lg  border text-gray-900 
focus:ring-sky-500 focus:border-sky-500 focus:outline-none block flex-1 min-w-0 w-full text-xs border-gray-300 p-2.5  dark:bg-gray-700
dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-sky-500 dark:focus:border-sky-500"
                                        placeholder="选填">
                                </a-tooltip>

                            </div>
                        </div>
                        <div class="theme-bg-secondary theme-text-primary w-full mb-4 mt-4 border border-gray-200 rounded-lg bg-gray-50 dark:bg-gray-700 dark:border-gray-600">
                            <div class="theme-bg-secondary theme-text-primary px-4 py-2 bg-white rounded-t-lg dark:bg-gray-800">
                                <label for="comment" class="sr-only">Your comment</label>
                                <textarea id="comment" rows="4" v-model="commentForm.content"
                                    class="theme-bg-secondary theme-text-primary w-full px-0 text-sm text-gray-900 bg-white border-0 dark:bg-gray-800 focus:ring-0 focus:outline-none dark:text-white dark:placeholder-gray-400"
                                    placeholder="发表一个友善的评论吧..." required></textarea>
                            </div>
                            <div class="flex items-center justify-between px-3 py-2 border-t dark:border-gray-600">
                                <div @click="onPublishCommentClick" class="inline-flex items-center py-2.5 px-4 text-xs font-medium text-center text-white 
bg-sky-600 rounded-lg focus:ring-4 focus:ring-sky-200 dark:focus:ring-sky-900 hover:bg-sky-700">
                                    发送
                                </div>
                                <div class="flex pl-0 space-x-1 rtl:space-x-reverse sm:pl-2">
                                    <!-- Emoji -->
                                    <a-popover trigger="click" placement="top">
                                        <template #content>
                                            <div class="p-2">
                                                <div class="grid grid-cols-6 gap-2">
                                                    <div v-for="(emoji, index) in emojis" :key="index"
                                                        class="text-2xl hover:cursor-pointer" @click="addEmoji(emoji)">{{ emoji }}
                                                    </div>
                                                </div>
                                            </div>
                                        </template>
                                        <div class="inline-flex justify-center items-center p-2 text-gray-500 rounded cursor-pointer hover:text-gray-900 hover:bg-gray-100 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600">
                                            <SmileOutlined class="w-4 h-4" />
                                        </div>
                                    </a-popover>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>

            <!-- 评论列表 -->
            <div v-if="comments && comments.length > 0" v-for="(comment, index) in comments" :key="index">

                <!-- 边界线 -->
                <div v-if="index > 0" class="border-t ml-12 mt-5  border-gray-100 dark:border-gray-700"></div>

                <!-- 一级评论 -->
                <div class="flex gap-3 mt-5">
                    <!-- 左边头像栏 -->
                    <div>
                        <a v-if="comment.website && comment.website.length > 0" @click="jumpToWebsite(comment.website)"
                            class="cursor-pointer">
                            <img v-if="comment.avatar && comment.avatar.length > 0" :src="comment.avatar"
                                class="w-10 h-10 rounded-full">
                            <UserOutlined v-else class="w-10 h-10 text-gray-400 rounded-full dark:text-gray-400" />
                        </a>
                        <div v-else>
                            <img v-if="comment.avatar && comment.avatar.length > 0" :src="comment.avatar"
                                class="w-10 h-10 rounded-full">
                            <UserOutlined v-else class="w-10 h-10 text-gray-400 rounded-full dark:text-gray-400" />
                        </div>
                    </div>
                    <!-- 右边评论信息 -->
                    <div class="flex flex-col gap-2 grow">
                        <!-- 昵称 -->
                        <div class="text-xs text-[#FB7299] font-bold">{{ comment.nickname }}</div>
                        <!-- 评论内容 -->
                        <div class="text-sm dark:text-gray-400">{{ comment.content }}</div>
                        <!-- Meta 信息 -->
                        <div class="flex items-center text-xs text-gray-400">
                            <!-- 发布时间 -->
                            <div>{{ comment.createTime }}</div>
                            <div class="text-gray-400 cursor-pointer ml-4 hover:text-sky-600"
                                @click="showReplyForm(index, comment.nickname, comment.id, comment.id)">
                                回复
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 二级评论 -->
                <div class="ml-12" v-if="comment.childComments && comment.childComments.length > 0">
                    <div v-for="(childComment, index2) in comment.childComments" :key="index2">
                        <!-- 头像、昵称、评论内容 -->
                        <div class="flex items-center gap-3 mt-5">
                            <!-- 左边头像栏 -->
                            <div>
                                <a v-if="childComment.website && childComment.website.length > 0"
                                    @click="jumpToWebsite(childComment.website)" class="cursor-pointer">
                                    <img v-if="childComment.avatar && childComment.avatar.length > 0"
                                        :src="childComment.avatar" class="w-6 h-6 rounded-full">
                                    <UserOutlined v-else class="w-6 h-6 text-gray-400 rounded-full dark:text-gray-400" />
                                </a>
                                <div v-else>
                                    <img v-if="childComment.avatar && childComment.avatar.length > 0"
                                        :src="childComment.avatar" class="w-6 h-6 rounded-full">
                                    <UserOutlined v-else class="w-6 h-6 text-gray-400 rounded-full dark:text-gray-400" />
                                </div>
                            </div>
                            <!-- 昵称 -->
                            <div class="text-xs text-[#FB7299] font-bold">
                                {{ childComment.nickname }}
                                <!-- 【回复 @xxx】 -->
                                <span v-if="childComment.replyNickname" class="text-gray-400 font-normal ml-1 mr-1">回复
                                    <span class="text-sky-600 font-normal text-sm">@{{ childComment.replyNickname
                                        }}</span>
                                    <span class="text-gray-400"> :</span>
                                </span>
                            </div>
                            <!-- 评论内容 -->
                            <div class="text-sm dark:text-gray-400">{{ childComment.content }}</div>
                        </div>
                        <!-- Meta 信息 -->
                        <div class="ml-9 mt-1 flex items-center text-xs text-gray-400">
                            <!-- 发布时间 -->
                            <div>{{ childComment.createTime }}</div>
                            <div class="text-gray-400 cursor-pointer ml-4 hover:text-sky-600"
                                @click="showReplyForm(index, childComment.nickname, childComment.id, comment.id)">
                                回复
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 二级评论回复表单 -->
                <form class="ml-12 mt-5" v-if="comment.isShowReplyForm">
                    <div class="flex gap-3">
                        <!-- 头像 -->
                        <div>
                            <img v-if="commentStore.userInfo.avatar && commentStore.userInfo.avatar.length > 0"
                                :src="commentStore.userInfo.avatar" class="w-10 h-10 rounded-full">
                            <UserOutlined v-else class="w-10 h-10 text-gray-400 dark:text-gray-400" />
                        </div>
                        <!-- 昵称、邮箱、网址、评论内容 -->
                        <div class="grow">
                            <div class="flex items-center gap-5 flex-row">
                                <div class="flex basis-1/3">
                                    <span
                                        class="inline-flex border-r-0 items-center px-3 text-xs text-gray-900 bg-gray-100 border rounded-r-0 border-gray-300 rounded-l-md dark:bg-gray-600 dark:text-gray-400 dark:border-gray-600">
                                        昵称
                                    </span>
                                    <a-tooltip title="输入 QQ 号会自动获取昵称和头像" trigger="click">
                                        <input @blur="onNicknameInputBlur" v-model="commentStore.userInfo.nickname"
                                            type="text" id="website-admin"
                                            class="rounded-none rounded-r-lg  border text-gray-900 focus:ring-sky-500 
focus:border-sky-500 block flex-1 min-w-0 w-full text-xs border-gray-300 p-2.5  dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-sky-500 dark:focus:border-sky-500"
                                            placeholder="必填">
                                    </a-tooltip>
                                </div>
                                <div class="flex basis-1/3">
                                    <span
                                        class="inline-flex border-r-0 items-center px-3 text-xs text-gray-900 bg-gray-100 border rounded-r-0 border-gray-300 rounded-l-md dark:bg-gray-600 dark:text-gray-400 dark:border-gray-600">
                                        邮箱
                                    </span>
                                    <a-tooltip title="收到回复将会发送到您的邮箱" trigger="click">
                                        <input v-model="commentStore.userInfo.mail"
                                            type="text" id="website-admin" class="rounded-none rounded-r-lg  border text-gray-900 focus:ring-sky-500 
focus:border-sky-500 block flex-1 min-w-0 w-full text-xs border-gray-300 p-2.5  dark:bg-gray-700 dark:border-gray-600 
dark:placeholder-gray-400 dark:text-white dark:focus:ring-sky-500 dark:focus:border-sky-500" placeholder="必填">
                                    </a-tooltip>
                                </div>
                                <div class="flex basis-1/3">
                                    <span
                                        class="inline-flex border-r-0 items-center px-3 text-xs text-gray-900 bg-gray-100 border rounded-r-0 border-gray-300 rounded-l-md dark:bg-gray-600 dark:text-gray-400 dark:border-gray-600">
                                        网址
                                    </span>
                                    <a-tooltip title="可通过点击头像访问你的网站 (非必填)" trigger="click">
                                        <input v-model="commentStore.userInfo.website"
                                            type="text" id="website-admin" class="rounded-none rounded-r-lg  border text-gray-900 
focus:ring-sky-500 focus:border-sky-500 block flex-1 min-w-0 w-full text-xs border-gray-300 p-2.5  dark:bg-gray-700
dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-sky-500 dark:focus:border-sky-500"
                                            placeholder="选填">
                                    </a-tooltip>

                                </div>
                            </div>
                            <div
                                class="w-full mb-4 mt-4 border border-gray-200 rounded-lg bg-gray-50 dark:bg-gray-700 dark:border-gray-600">
                                <div class="px-4 py-2 bg-white rounded-t-lg dark:bg-gray-800">
                                    <label for="comment" class="sr-only">Your comment</label>
                                    <textarea id="comment" rows="4" v-model="replyContent"
                                        class="w-full px-0 text-sm text-gray-900 bg-white border-0 dark:bg-gray-800 focus:ring-0 dark:text-white dark:placeholder-gray-400"
                                        :placeholder="replyPlaceholderText" required></textarea>
                                </div>
                                <div class="flex items-center justify-between px-3 py-2 border-t dark:border-gray-600">
                                    <div @click="onReplyContentSubmit" class="inline-flex items-center py-2.5 px-4 text-xs font-medium text-center text-white 
bg-sky-600 rounded-lg focus:ring-4 focus:ring-sky-200 dark:focus:ring-sky-900 hover:bg-sky-700">
                                        发送
                                    </div>
                                    <div class="flex pl-0 space-x-1 rtl:space-x-reverse sm:pl-2">
                                        <!-- Emoji -->
                                        <a-popover trigger="click" placement="top">
                                            <template #content>
                                                <div class="p-2">
                                                    <div class="grid grid-cols-6 gap-2">
                                                        <div v-for="(emoji, index) in emojis" :key="index"
                                                            class="text-2xl hover:cursor-pointer"
                                                            @click="addReplyEmoji(emoji)">
                                                            {{
                                                            emoji }}
                                                        </div>
                                                    </div>
                                                </div>
                                            </template>
                                            <div class="inline-flex justify-center items-center p-2 text-gray-500 rounded cursor-pointer hover:text-gray-900 hover:bg-gray-100 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600">
                                                <SmileOutlined class="w-4 h-4" />
                                            </div>
                                        </a-popover>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>


            </div>
            <!-- 没有评论的提示文字 -->
            <div v-else class="flex items-center mt-10 mb-10 justify-center text-gray-400">还没有任何评论哟~</div>


        </div>
    </div>
</template>

<script setup lang="ts">
// Vue imports
import { ref, reactive, onMounted, nextTick, withDefaults, type Ref } from 'vue'

// Third-party imports
import { useRoute } from 'vue-router'
import { UserOutlined, SmileOutlined } from '@ant-design/icons-vue'

// Local imports
import { useCommentStore } from '@/stores/comment.js'
import { getUserInfoByQQ, publishComment, getComments } from '@/api/surfer/comment.js'
import { showMessage } from '@/composables/util.js'

// ==================== 类型定义 ====================

/** 用户信息接口 */
// interface UserInfo {
//     avatar: string
//     nickname: string
//     mail: string
//     website: string
// }

/** 评论表单接口 */
interface CommentForm {
    avatar: string
    content: string
    mail: string
    nickname: string
    routerUrl: string
    website: string
    replyCommentId: number | null
    parentCommentId: number | null
}

/** 子评论接口 */
interface ChildComment {
    id: number
    nickname: string
    avatar: string
    content: string
    createTime: string
    website?: string
    replyNickname?: string
}

/** 评论接口 */
interface Comment {
    id: number
    nickname: string
    avatar: string
    content: string
    createTime: string
    website?: string
    childComments?: ChildComment[]
    isShowReplyForm?: boolean
}

/** 组件属性接口 */
interface Props {
    customeCss?: string
}

// ==================== 组件初始化 ====================

/** 路由实例 */
const route = useRoute()

/** 评论状态管理 */
const commentStore = useCommentStore()

/** 组件属性定义 */
const props = withDefaults(defineProps<Props>(), {
    customeCss: 'w-full px-5 py-10 mb-3 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700'
})

/** 组件挂载后初始化 */
onMounted(() => {
})

// ==================== 数据定义 ====================

/** 表情符号列表 */
const emojis: Ref<string[]> = ref([
    '😃', '😁', '😅', '😂', '😍', '😜', '😝', '🤑', 
    '🥵', '🥰', '😙', '😎', '😵', '😭', '😱', '😖', 
    '🥳', '👽', '🙈', '🤡', '😤', '💣', '💯', '💢', 
    '❤️', '👍', '👏', '👋', '👌', '🤏', '🙏'
])

/** 表情符号列表别名（用于回复） */
const emojiList: Ref<string[]> = emojis

/** 评论表单数据 */
const commentForm: CommentForm = reactive({
    avatar: '',
    content: '',
    mail: '',
    nickname: '',
    routerUrl: route.path,
    website: '',
    replyCommentId: null,
    parentCommentId: null
})

/**
 * 初始化评论表单中的用户信息
 * 从状态管理中获取用户信息并填充到表单
 */
function initFormCommentUserInfo(): void {
    commentForm.avatar = commentStore.userInfo.avatar
    commentForm.mail = commentStore.userInfo.mail
    commentForm.nickname = commentStore.userInfo.nickname
    commentForm.website = commentStore.userInfo.website
}

// 初始化表单用户信息
initFormCommentUserInfo()

// ==================== 工具函数和常量 ====================

/** 邮箱格式验证正则表达式 */
const emailRegex: RegExp = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

// ==================== 事件处理函数 ====================

/**
 * 发布一级评论点击事件处理
 * 验证表单数据并提交评论
 */
const onPublishCommentClick = (): void => {
    initFormCommentUserInfo()
    // 校验
    if (commentForm.nickname.length === 0) {
        showMessage('请填写 QQ 号或昵称', 'warning')
        return
    }
    if (commentForm.mail.length === 0 || !emailRegex.test(commentForm.mail)) {
        showMessage('邮箱格式不正确', 'warning')
        return
    }
    if (commentForm.content.length === 0) {
        showMessage('请填写评论内容', 'warning')
        return
    }

    publishComment(commentForm).then(res => {
        if (!res.success) {
            // 获取服务端返回的错误消息
            let message = res.message
            // 提示错误消息
            showMessage(message, 'error')
            return
        }

        showMessage('评论发布成功')
        // 将表单对象中的 content 评论内容置空
        commentForm.content = ''
        // 重新渲染表单列表
        initComments()
    })
}

/**
 * 添加表情符号到评论内容
 * @param emoji 要添加的表情符号
 */
const addEmoji = (emoji: string): void => {
    commentForm.content = commentForm.content + emoji
}

/**
 * 昵称输入框失焦事件处理
 * 如果输入的是QQ号，自动获取QQ信息
 */
const onNicknameInputBlur = (): void => {
    let nickname: string = commentStore.userInfo.nickname
    // 校验昵称是否是纯数字
    if (!checkIfPureNumber(nickname)) {
        return
    }

    // 若是，请求后端接口，根据 QQ 号获取用户信息
    getUserInfoByQQ(nickname).then((res: any) => {
        if (!res.success) {
            // 提示错误消息
            showMessage('获取 QQ 信息失败', 'error')
            return
        }

        commentStore.userInfo.avatar = res.data.avatar
        commentStore.userInfo.nickname = res.data.nickname
        commentStore.userInfo.mail = res.data.mail
    })
}

/**
 * 检查文本是否为纯数字（用于QQ号验证）
 * @param text 要检查的文本
 * @returns 是否为纯数字
 */
function checkIfPureNumber(text: string): boolean {
    const trimmedValue: string = text.trim();
    return /^\d+$/.test(trimmedValue);
}

/**
 * 格式化时间显示
 * @param time 时间字符串
 * @returns 格式化后的时间
 */
function formatTime(time: string): string {
    return time;
}

// ==================== 评论数据管理 ====================

/** 评论列表 */
const comments: Ref<Comment[]> = ref([])

/** 评论总数 */
const total: Ref<number> = ref(0)

/**
 * 初始化评论列表
 * 获取当前路由下的所有评论数据
 */
function initComments(): void {
    getComments(route.path).then((res: any) => {
        if (res.success) {
            total.value = res.data.total
            comments.value = res.data.comments
        }
    })
}

// 初始化评论数据
initComments()

// ==================== 回复功能相关 ====================

/** 回复输入框的占位符文本 */
const replyPlaceholderText: Ref<string> = ref('发表一个友善的评论吧...')

/** 回复内容 */
const replyContent: Ref<string> = ref('')

/** 当前回复的评论ID */
const currReplyCommentId: Ref<number | null> = ref(null)

/** 当前回复的父级评论ID */
const currParentCommentId: Ref<number | null> = ref(null)

/**
 * 显示回复表单
 * @param index 评论在列表中的索引
 * @param nickname 被回复用户的昵称
 * @param replyCommentId 被回复的评论ID
 * @param parentCommentId 父级评论ID
 */
const showReplyForm = (index: number, nickname: string, replyCommentId: number, parentCommentId: number): void => {
    currReplyCommentId.value = replyCommentId
    currParentCommentId.value = parentCommentId
    // 先将评论数组中一级评论的所有 isShowReplyForm 字段设置为 false
    comments.value.forEach((comment: Comment) => comment.isShowReplyForm = false)
    // 拿到当前下标的评论
    const comment: Comment | undefined = comments.value[index]
    if (!comment) return
    // isShowReplyForm 置为 true
    comment.isShowReplyForm = true
    // 动态设置评论回复表单中的 textarea 的 placeholder 提示文字
    replyPlaceholderText.value = '回复 @' + nickname + ':'

    nextTick(() => {
    })
}

/**
 * 在回复内容中添加表情符号
 * @param emoji 要添加的表情符号
 */
const addReplyEmoji = (emoji: string): void => {
    replyContent.value = replyContent.value + emoji
}

/**
 * 提交回复评论
 * 验证回复数据并发送到服务器
 */
const onReplyContentSubmit = (): void => {
    initFormCommentUserInfo()
    // 校验
    if (commentForm.nickname.length === 0) {
        showMessage('请填写 QQ 号或昵称', 'warning')
        return
    }
    if (commentForm.mail.length === 0 || !emailRegex.test(commentForm.mail)) {
        showMessage('邮箱格式不正确', 'warning')
        return
    }
    if (replyContent.value.length === 0) {
        showMessage('请填写回复内容', 'warning')
        return
    }
    // 评论回复内容
    commentForm.content = replyContent.value
    commentForm.replyCommentId = currReplyCommentId.value
    commentForm.parentCommentId = currParentCommentId.value

    // 请求接口
    publishComment(commentForm).then((res: any) => {
        if (!res.success) {
            // 获取服务端返回的错误消息
            let message: string = res.message
            // 提示错误消息
            showMessage(message, 'error')
            return
        }

        showMessage('回复评论成功')
        // 将评论回复的内容置空
        replyContent.value = ''
        commentForm.content = ''
        // 重新渲染评论列表
        initComments()
    })
}

/**
 * 跳转到用户网站
 * @param url 用户网站地址
 */
const jumpToWebsite = (url: string): void => {
    // 确保URL包含协议，然后在新窗口打开
    window.open(url.startsWith('http') ? url : 'http://' + url, '_blank');
}

</script>

<style lang="scss" scoped>
// Comment component styles
.comment-container {
  .comment-form {
    .form-group {
      .input-group {
        .input-label {
          display: inline-flex;
          border-right: 0;
          align-items: center;
          padding: 0 12px;
          font-size: 12px;
          color: #111827;
          background-color: #f3f4f6;
          border: 1px solid #d1d5db;
          border-top-left-radius: 6px;
          border-bottom-left-radius: 6px;
          border-top-right-radius: 0;
          border-bottom-right-radius: 0;
          
          @media (prefers-color-scheme: dark) {
            background-color: #4b5563;
            color: #9ca3af;
            border-color: #4b5563;
          }
        }
        
        .form-input {
          border-radius: 0;
          border-top-right-radius: 8px;
          border-bottom-right-radius: 8px;
          border: 1px solid #d1d5db;
          color: #111827;
          display: block;
          flex: 1;
          min-width: 0;
          width: 100%;
          font-size: 12px;
          padding: 10px;
          
          &:focus {
            outline: none;
            border-color: #0ea5e9;
            box-shadow: 0 0 0 1px #0ea5e9;
          }
          
          @media (prefers-color-scheme: dark) {
            background-color: #374151;
            border-color: #4b5563;
            color: #ffffff;
            
            &::placeholder {
              color: #9ca3af;
            }
            
            &:focus {
              border-color: #0ea5e9;
              box-shadow: 0 0 0 1px #0ea5e9;
            }
          }
        }
      }
    }
    
    .comment-textarea {
      display: block;
      padding: 10px;
      width: 100%;
      font-size: 12px;
      color: #111827;
      background-color: #f9fafb;
      border-radius: 8px;
      border: 1px solid #d1d5db;
      
      &:focus {
        outline: none;
        border-color: #0ea5e9;
        box-shadow: 0 0 0 1px #0ea5e9;
      }
      
      @media (prefers-color-scheme: dark) {
        background-color: #374151;
        border-color: #4b5563;
        color: #ffffff;
        
        &::placeholder {
          color: #9ca3af;
        }
        
        &:focus {
          border-color: #0ea5e9;
          box-shadow: 0 0 0 1px #0ea5e9;
        }
      }
    }
    
    .submit-button {
      color: #ffffff;
      background-color: #0369a1;
      font-weight: 500;
      border-radius: 8px;
      font-size: 12px;
      padding: 8px 16px;
      text-align: center;
      border: none;
      cursor: pointer;
      
      &:hover {
        background-color: #075985;
      }
      
      &:focus {
        outline: none;
        box-shadow: 0 0 0 4px rgba(3, 105, 161, 0.3);
      }
      
      @media (prefers-color-scheme: dark) {
        background-color: #0284c7;
        
        &:hover {
          background-color: #0369a1;
        }
        
        &:focus {
          box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.3);
        }
      }
    }
  }
  
  .comment-item {
    .comment-avatar {
      width: 32px;
      height: 32px;
      border-radius: 50%;
    }
    
    .comment-content {
      .comment-header {
        .comment-author {
          font-weight: 600;
          color: #111827;
          
          @media (prefers-color-scheme: dark) {
            color: #ffffff;
          }
        }
        
        .comment-time {
          font-size: 12px;
          color: #4b5563;
          
          @media (prefers-color-scheme: dark) {
            color: #9ca3af;
          }
        }
      }
      
      .comment-text {
        color: #6b7280;
        
        @media (prefers-color-scheme: dark) {
          color: #9ca3af;
        }
      }
      
      .comment-actions {
        .reply-button {
          font-size: 12px;
          color: #6b7280;
          cursor: pointer;
          
          &:hover {
            text-decoration: underline;
          }
          
          @media (prefers-color-scheme: dark) {
            color: #9ca3af;
          }
        }
      }
    }
  }
  
  .emoji-picker {
    .emoji-button {
      padding: 4px;
      border-radius: 4px;
      cursor: pointer;
      
      &:hover {
        background-color: #f3f4f6;
        transform: scale(1.1);
        transition: transform 0.2s ease;
        
        @media (prefers-color-scheme: dark) {
          background-color: #4b5563;
        }
      }
    }
  }
}
</style>