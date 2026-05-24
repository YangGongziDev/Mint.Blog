<script setup lang="ts">
import { nextTick, onMounted, reactive, ref } from 'vue';
import { useRoute } from 'vue-router';
import { message } from 'ant-design-vue';
import { UserOutlined } from '@ant-design/icons-vue';
import { getComments, getUserInfoByQQ, publishComment } from '@/service/blog/surfer/comment';
import EmojiBag from './emoji-bag.vue';

defineOptions({
  name: 'SurferComment'
});

interface UserInfo {
  avatar: string;
  nickname: string;
  mail: string;
  website: string;
}

interface CommentForm {
  avatar: string;
  content: string;
  mail: string;
  nickname: string;
  routerUrl: string;
  website: string;
  replyCommentId: number | null;
  parentCommentId: number | null;
}

interface ChildComment {
  id: number;
  nickname: string;
  avatar: string;
  content: string;
  createTime: string;
  website?: string;
  replyNickname?: string;
}

interface Comment {
  id: number;
  nickname: string;
  avatar: string;
  content: string;
  createTime: string;
  website?: string;
  childComments?: ChildComment[];
  isShowReplyForm?: boolean;
}

interface CommentApiResponse {
  success: boolean;
  message?: string;
  data: {
    total: number;
    comments: Comment[];
  };
}

const route = useRoute();

const COMMENT_STORAGE_KEY = 'surferCommentUserInfo';

function loadUserInfo(): UserInfo {
  try {
    const raw = localStorage.getItem(COMMENT_STORAGE_KEY);
    if (raw) {
      return JSON.parse(raw) as UserInfo;
    }
  } catch {
    // ignore
  }
  return { avatar: '', nickname: '', mail: '', website: '' };
}

function saveUserInfo(info: UserInfo) {
  localStorage.setItem(COMMENT_STORAGE_KEY, JSON.stringify(info));
}

const userInfo = ref<UserInfo>(loadUserInfo());

const commentForm = reactive<CommentForm>({
  avatar: '',
  content: '',
  mail: '',
  nickname: '',
  routerUrl: route.path,
  website: '',
  replyCommentId: null,
  parentCommentId: null
});

const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

function syncUserInfoToForm() {
  commentForm.avatar = userInfo.value.avatar;
  commentForm.mail = userInfo.value.mail;
  commentForm.nickname = userInfo.value.nickname;
  commentForm.website = userInfo.value.website;
  saveUserInfo(userInfo.value);
}

onMounted(() => {
  syncUserInfoToForm();
});

const comments = ref<Comment[]>([]);
const total = ref(0);

function initComments() {
  getComments<CommentApiResponse>(route.path).then(res => {
    if (res.success) {
      total.value = res.data.total;
      comments.value = res.data.comments ?? [];
    }
  });
}

initComments();

function showMessage(msg: string, type: 'success' | 'warning' | 'error' = 'success') {
  message[type](msg);
}

function checkIfPureNumber(text: string): boolean {
  return /^\d+$/.test(text.trim());
}

const onNicknameInputBlur = () => {
  const nickname = userInfo.value.nickname;
  if (!checkIfPureNumber(nickname)) {
    return;
  }

  getUserInfoByQQ<{ success: boolean; data?: { avatar: string; nickname: string; mail: string } }>(nickname).then(
    res => {
      if (!res.success) {
        showMessage('获取 QQ 信息失败', 'error');
        return;
      }
      if (res.data) {
        userInfo.value.avatar = res.data.avatar;
        userInfo.value.nickname = res.data.nickname;
        userInfo.value.mail = res.data.mail;
        saveUserInfo(userInfo.value);
      }
    }
  );
};

const onPublishCommentClick = () => {
  syncUserInfoToForm();

  if (commentForm.nickname.length === 0) {
    showMessage('请填写 QQ 号或昵称', 'warning');
    return;
  }
  if (commentForm.mail.length === 0 || !emailRegex.test(commentForm.mail)) {
    showMessage('邮箱格式不正确', 'warning');
    return;
  }
  if (commentForm.content.length === 0) {
    showMessage('请填写评论内容', 'warning');
    return;
  }

  publishComment<{ success: boolean; message?: string }>(commentForm).then(res => {
    if (!res.success) {
      showMessage(res.message || '评论发布失败', 'error');
      return;
    }

    showMessage('评论发布成功');
    commentForm.content = '';
    initComments();
  });
};

const textareaRef = ref<HTMLTextAreaElement | null>(null);
const emojiPanelOpen = ref(false);

function insertEmoji(emoji: string) {
  emojiPanelOpen.value = false;
  const textarea = textareaRef.value;
  if (!textarea) {
    commentForm.content += emoji;
    return;
  }
  const start = textarea.selectionStart ?? commentForm.content.length;
  const end = textarea.selectionEnd ?? commentForm.content.length;
  commentForm.content = commentForm.content.slice(0, start) + emoji + commentForm.content.slice(end);
  nextTick(() => {
    textarea.focus();
    textarea.setSelectionRange(start + emoji.length, start + emoji.length);
  });
}

const replyPlaceholderText = ref('发表一个友善的评论吧...');
const replyContent = ref('');
const replyTextareaRef = ref<HTMLTextAreaElement | null>(null);
const replyEmojiPanelOpen = ref(false);
const currReplyCommentId = ref<number | null>(null);
const currParentCommentId = ref<number | null>(null);

const showReplyForm = (
  index: number,
  nickname: string,
  replyInfo: { replyCommentId: number; parentCommentId: number }
) => {
  currReplyCommentId.value = replyInfo.replyCommentId;
  currParentCommentId.value = replyInfo.parentCommentId;
  comments.value.forEach(c => {
    c.isShowReplyForm = false;
  });
  const target = comments.value[index];
  if (!target) return;
  target.isShowReplyForm = true;
  replyPlaceholderText.value = `回复 @${nickname}:`;
  nextTick(() => {});
};

function insertReplyEmoji(emoji: string) {
  replyEmojiPanelOpen.value = false;
  const textarea = replyTextareaRef.value;
  if (!textarea) {
    replyContent.value += emoji;
    return;
  }
  const start = textarea.selectionStart ?? replyContent.value.length;
  const end = textarea.selectionEnd ?? replyContent.value.length;
  replyContent.value = replyContent.value.slice(0, start) + emoji + replyContent.value.slice(end);
  nextTick(() => {
    textarea.focus();
    textarea.setSelectionRange(start + emoji.length, start + emoji.length);
  });
}

const onReplyContentSubmit = () => {
  syncUserInfoToForm();

  if (commentForm.nickname.length === 0) {
    showMessage('请填写 QQ 号或昵称', 'warning');
    return;
  }
  if (commentForm.mail.length === 0 || !emailRegex.test(commentForm.mail)) {
    showMessage('邮箱格式不正确', 'warning');
    return;
  }
  if (replyContent.value.length === 0) {
    showMessage('请填写回复内容', 'warning');
    return;
  }

  commentForm.content = replyContent.value;
  commentForm.replyCommentId = currReplyCommentId.value;
  commentForm.parentCommentId = currParentCommentId.value;

  publishComment<{ success: boolean; message?: string }>(commentForm).then(res => {
    if (!res.success) {
      showMessage(res.message || '回复评论失败', 'error');
      return;
    }

    showMessage('回复评论成功');
    replyContent.value = '';
    initComments();
  });
};

const jumpToWebsite = (url: string) => {
  if (url) {
    window.open(url, '_blank', 'noopener,noreferrer');
  }
};
</script>

<template>
  <div class="mt-14">
    <h2 class="flex justify-center items-center mb-7 text-[#557468] dark:text-[#cbd5e1] text-sm font-semibold">
      全部评论
      <span>({{ total }})</span>
    </h2>
    <div
      class="w-full px-5 py-10 mb-3 bg-white border border-[#3ecf9a]/14 rounded-lg dark:bg-[#2c333e]/72 dark:border-[#334155]"
    >
      <form @submit.prevent>
        <div class="flex gap-3">
          <div class="grow">
            <div class="flex flex-wrap items-center gap-5">
              <div class="comment-user-field flex min-w-0 flex-1 basis-48">
                <span
                  class="inline-flex shrink-0 items-center rounded-l-md border border-gray-200 bg-gray-50 px-3 text-xs text-gray-600 dark:border-[#334155] dark:bg-white/5 dark:text-[#cbd5e1]"
                >
                  昵称
                </span>
                <ATooltip title="输入 QQ 号会自动获取昵称和头像">
                  <input
                    v-model="userInfo.nickname"
                    type="text"
                    class="block w-full min-w-0 flex-1 rounded-none rounded-r-lg border border-l-0 border-gray-200 bg-white p-2.5 text-xs text-gray-800 focus:outline-none focus:ring-0 dark:border-[#334155] dark:bg-white/5 dark:text-white dark:placeholder-gray-500"
                    placeholder="必填"
                    @blur="onNicknameInputBlur"
                  />
                </ATooltip>
              </div>
              <div class="comment-user-field flex min-w-0 flex-1 basis-48">
                <span
                  class="inline-flex shrink-0 items-center rounded-l-md border border-gray-200 bg-gray-50 px-3 text-xs text-gray-600 dark:border-[#334155] dark:bg-white/5 dark:text-[#cbd5e1]"
                >
                  邮箱
                </span>
                <ATooltip title="收到回复将会发送到您的邮箱">
                  <input
                    v-model="userInfo.mail"
                    type="text"
                    class="block w-full min-w-0 flex-1 rounded-none rounded-r-lg border border-l-0 border-gray-200 bg-white p-2.5 text-xs text-gray-800 focus:outline-none focus:ring-0 dark:border-[#334155] dark:bg-white/5 dark:text-white dark:placeholder-gray-500"
                    placeholder="必填"
                  />
                </ATooltip>
              </div>
              <div class="comment-user-field flex min-w-0 flex-1 basis-48">
                <span
                  class="inline-flex shrink-0 items-center rounded-l-md border border-gray-200 bg-gray-50 px-3 text-xs text-gray-600 dark:border-[#334155] dark:bg-white/5 dark:text-[#cbd5e1]"
                >
                  网址
                </span>
                <ATooltip title="可通过点击头像访问你的网站 (非必填)">
                  <input
                    v-model="userInfo.website"
                    type="text"
                    class="block w-full min-w-0 flex-1 rounded-none rounded-r-lg border border-l-0 border-gray-200 bg-white p-2.5 text-xs text-gray-800 focus:outline-none focus:ring-0 dark:border-[#334155] dark:bg-white/5 dark:text-white dark:placeholder-gray-500"
                    placeholder="选填"
                  />
                </ATooltip>
              </div>
            </div>
            <div
              class="comment-text-field w-full mb-4 mt-4 rounded-lg border border-gray-200 bg-gray-50 dark:border-[#334155] dark:bg-white/5"
            >
              <div class="px-4 py-2 bg-white rounded-t-lg dark:bg-transparent">
                <textarea
                  id="comment"
                  ref="textareaRef"
                  v-model="commentForm.content"
                  rows="4"
                  class="w-full border-0 bg-white px-0 text-sm text-gray-800 focus:outline-none focus:ring-0 dark:bg-transparent dark:text-white dark:placeholder-gray-500"
                  placeholder="发表一个友善的评论吧..."
                ></textarea>
              </div>
              <div class="flex items-center justify-between px-3 py-2 border-t border-gray-200 dark:border-[#334155]">
                <button
                  type="button"
                  class="inline-flex items-center rounded-lg bg-[#3ecf9a] px-4 py-2.5 text-xs font-medium text-white hover:bg-[#15956b] focus:outline-none focus:ring-2 focus:ring-[#3ecf9a]/40 transition-colors"
                  @click="onPublishCommentClick"
                >
                  发送
                </button>
                <div class="relative flex pl-0 sm:pl-2">
                  <APopover v-model:open="emojiPanelOpen" trigger="click" placement="bottomRight">
                    <button
                      type="button"
                      class="inline-flex items-center justify-center rounded-md border border-transparent px-2 py-1 text-2xl transition hover:border-gray-200 hover:bg-gray-50 dark:hover:border-white/10 dark:hover:bg-[white/8]"
                    >
                      😀
                    </button>
                    <template #content>
                      <EmojiBag @select="insertEmoji" />
                    </template>
                  </APopover>
                </div>
              </div>
            </div>
          </div>
        </div>
      </form>

      <div v-if="comments.length > 0">
        <div v-for="(comment, index) in comments" :key="comment.id || index">
          <div v-if="index > 0" class="border-t ml-12 mt-5 border-gray-100 dark:border-[#334155]"></div>

          <div class="flex gap-3 mt-5">
            <div>
              <a v-if="comment.website" class="cursor-pointer" @click="jumpToWebsite(comment.website)">
                <img v-if="comment.avatar" :src="comment.avatar" class="w-10 h-10 rounded-full" />
                <UserOutlined v-else class="w-10 h-10 text-[#9cc1b1] rounded-full dark:text-[#557468]" />
              </a>
              <template v-else>
                <img v-if="comment.avatar" :src="comment.avatar" class="w-10 h-10 rounded-full" />
                <UserOutlined v-else class="w-10 h-10 text-[#9cc1b1] rounded-full dark:text-[#557468]" />
              </template>
            </div>
            <div class="flex flex-col gap-2 grow">
              <div class="text-xs font-bold text-[#3ecf9a] dark:text-[#539dfd]">{{ comment.nickname }}</div>
              <div class="text-sm text-[#557468] dark:text-[#b1d3c4]">{{ comment.content }}</div>
              <div class="flex items-center text-xs text-[#557468] dark:text-[#cbd5e1]">
                <div>{{ comment.createTime }}</div>
                <button
                  type="button"
                  class="ml-4 cursor-pointer hover:text-[#3ecf9a] dark:hover:text-[#539dfd] transition-colors"
                  @click="
                    showReplyForm(index, comment.nickname, { replyCommentId: comment.id, parentCommentId: comment.id })
                  "
                >
                  回复
                </button>
              </div>
            </div>
          </div>

          <div v-if="comment.childComments && comment.childComments.length > 0" class="ml-12">
            <div v-for="childComment in comment.childComments" :key="childComment.id">
              <div class="flex items-center gap-3 mt-5">
                <div>
                  <a v-if="childComment.website" class="cursor-pointer" @click="jumpToWebsite(childComment.website)">
                    <img v-if="childComment.avatar" :src="childComment.avatar" class="w-6 h-6 rounded-full" />
                    <UserOutlined v-else class="w-6 h-6 text-[#9cc1b1] rounded-full dark:text-[#557468]" />
                  </a>
                  <template v-else>
                    <img v-if="childComment.avatar" :src="childComment.avatar" class="w-6 h-6 rounded-full" />
                    <UserOutlined v-else class="w-6 h-6 text-[#9cc1b1] rounded-full dark:text-[#557468]" />
                  </template>
                </div>
                <div class="text-xs font-bold text-[#3ecf9a] dark:text-[#539dfd]">
                  {{ childComment.nickname }}
                  <span
                    v-if="childComment.replyNickname"
                    class="text-[#557468] dark:text-[#cbd5e1] font-normal ml-1 mr-1"
                  >
                    回复
                    <span class="text-[#3ecf9a] dark:text-[#539dfd] font-normal text-sm">
                      @{{ childComment.replyNickname }}
                    </span>
                    <span class="text-[#557468] dark:text-[#cbd5e1]">:</span>
                  </span>
                </div>
                <div class="text-sm text-[#557468] dark:text-[#b1d3c4]">{{ childComment.content }}</div>
              </div>
              <div class="ml-9 mt-1 flex items-center text-xs text-[#557468] dark:text-[#cbd5e1]">
                <div>{{ childComment.createTime }}</div>
                <button
                  type="button"
                  class="ml-4 cursor-pointer hover:text-[#3ecf9a] dark:hover:text-[#539dfd] transition-colors"
                  @click="
                    showReplyForm(index, childComment.nickname, {
                      replyCommentId: childComment.id,
                      parentCommentId: comment.id
                    })
                  "
                >
                  回复
                </button>
              </div>
            </div>
          </div>

          <form v-if="comment.isShowReplyForm" class="ml-12 mt-5" @submit.prevent>
            <div class="flex gap-3">
              <div>
                <img v-if="userInfo.avatar" :src="userInfo.avatar" class="w-10 h-10 rounded-full" />
                <UserOutlined v-else class="w-10 h-10 text-[#9cc1b1] dark:text-[#557468]" />
              </div>
              <div class="grow">
                <div class="flex flex-wrap items-center gap-5">
                  <div class="comment-user-field flex min-w-0 flex-1 basis-48">
                    <span
                      class="inline-flex shrink-0 items-center rounded-l-md border border-gray-200 bg-gray-50 px-3 text-xs text-gray-600 dark:border-[#334155] dark:bg-white/5 dark:text-[#cbd5e1]"
                    >
                      昵称
                    </span>
                    <ATooltip title="输入 QQ 号会自动获取昵称和头像">
                      <input
                        v-model="userInfo.nickname"
                        type="text"
                        class="block w-full min-w-0 flex-1 rounded-none rounded-r-lg border border-l-0 border-gray-200 bg-white p-2.5 text-xs text-gray-800 focus:outline-none focus:ring-0 dark:border-[#334155] dark:bg-white/5 dark:text-white dark:placeholder-gray-500"
                        placeholder="必填"
                        @blur="onNicknameInputBlur"
                      />
                    </ATooltip>
                  </div>
                  <div class="comment-user-field flex min-w-0 flex-1 basis-48">
                    <span
                      class="inline-flex shrink-0 items-center rounded-l-md border border-gray-200 bg-gray-50 px-3 text-xs text-gray-600 dark:border-[#334155] dark:bg-white/5 dark:text-[#cbd5e1]"
                    >
                      邮箱
                    </span>
                    <ATooltip title="收到回复将会发送到您的邮箱">
                      <input
                        v-model="userInfo.mail"
                        type="text"
                        class="block w-full min-w-0 flex-1 rounded-none rounded-r-lg border border-l-0 border-gray-200 bg-white p-2.5 text-xs text-gray-800 focus:outline-none focus:ring-0 dark:border-[#334155] dark:bg-white/5 dark:text-white dark:placeholder-gray-500"
                        placeholder="必填"
                      />
                    </ATooltip>
                  </div>
                  <div class="comment-user-field flex min-w-0 flex-1 basis-48">
                    <span
                      class="inline-flex shrink-0 items-center rounded-l-md border border-gray-200 bg-gray-50 px-3 text-xs text-gray-600 dark:border-[#334155] dark:bg-white/5 dark:text-[#cbd5e1]"
                    >
                      网址
                    </span>
                    <ATooltip title="可通过点击头像访问你的网站 (非必填)">
                      <input
                        v-model="userInfo.website"
                        type="text"
                        class="block w-full min-w-0 flex-1 rounded-none rounded-r-lg border border-l-0 border-gray-200 bg-white p-2.5 text-xs text-gray-800 focus:outline-none focus:ring-0 dark:border-[#334155] dark:bg-white/5 dark:text-white dark:placeholder-gray-500"
                        placeholder="选填"
                      />
                    </ATooltip>
                  </div>
                </div>
                <div
                  class="comment-text-field w-full mb-4 mt-4 rounded-lg border border-gray-200 bg-gray-50 dark:border-[#334155] dark:bg-white/5"
                >
                  <div class="px-4 py-2 bg-white rounded-t-lg dark:bg-transparent">
                    <textarea
                      ref="replyTextareaRef"
                      v-model="replyContent"
                      rows="4"
                      class="w-full border-0 bg-white px-0 text-sm text-gray-800 focus:outline-none focus:ring-0 dark:bg-transparent dark:text-white dark:placeholder-gray-500"
                      :placeholder="replyPlaceholderText"
                    ></textarea>
                  </div>
                  <div
                    class="flex items-center justify-between px-3 py-2 border-t border-gray-200 dark:border-[#334155]"
                  >
                    <button
                      type="button"
                      class="inline-flex items-center rounded-lg bg-[#3ecf9a] px-4 py-2.5 text-xs font-medium text-white hover:bg-[#15956b] focus:outline-none focus:ring-2 focus:ring-[#3ecf9a]/40 transition-colors"
                      @click="onReplyContentSubmit"
                    >
                      发送
                    </button>
                    <div class="relative flex pl-0 sm:pl-2">
                      <APopover v-model:open="replyEmojiPanelOpen" trigger="click" placement="bottomRight">
                        <button
                          type="button"
                          class="inline-flex items-center justify-center rounded-md border border-transparent px-2 py-1 text-2xl transition hover:border-gray-200 hover:bg-gray-50 dark:hover:border-white/10 dark:hover:bg-[white/8]"
                        >
                          😀
                        </button>
                        <template #content>
                          <EmojiBag @select="insertReplyEmoji" />
                        </template>
                      </APopover>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.comment-user-field {
  border-radius: 8px;
  transition:
    box-shadow 0.2s ease,
    transform 0.2s ease;

  > span,
  > :deep(.ant-tooltip-open),
  > :deep(input),
  input {
    transition:
      border-color 0.2s ease,
      box-shadow 0.2s ease;
  }

  &:focus-within {
    transform: translateY(-1px);
    box-shadow:
      0 0 0 3px rgb(62 207 154 / 18%),
      0 10px 24px rgb(62 207 154 / 12%);

    > span,
    input {
      border-color: #3ecf9a;
    }
  }
}

.dark .comment-user-field:focus-within {
  box-shadow:
    0 0 0 3px rgb(83 157 253 / 18%),
    0 10px 24px rgb(83 157 253 / 14%);

  > span,
  input {
    border-color: #539dfd;
  }
}

.comment-text-field {
  transition:
    border-color 0.2s ease,
    box-shadow 0.2s ease,
    transform 0.2s ease;

  &:focus-within {
    transform: translateY(-1px);
    border-color: #3ecf9a;
    box-shadow:
      0 0 0 3px rgb(62 207 154 / 18%),
      0 12px 28px rgb(62 207 154 / 12%);
  }
}

.dark .comment-text-field:focus-within {
  border-color: #539dfd;
  box-shadow:
    0 0 0 3px rgb(83 157 253 / 18%),
    0 12px 28px rgb(83 157 253 / 14%);
}

@media (max-width: 768px) {
  .comment-user-field input,
  .comment-text-field textarea {
    font-size: 16px !important;
    line-height: 1.5;
  }
}
</style>
