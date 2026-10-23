<template>
  <main class="min-h-screen bg-layout px-4 py-10 sm:px-6">
    <section class="mx-auto max-w-5xl">
      <div class="mb-8 rounded-3xl border border-[#3ecf9a]/30 bg-white p-8 shadow-sm dark:border-white/10 dark:bg-white/5">
        <p class="text-sm font-bold uppercase tracking-[0.24em] text-[#3ecf9a]">Message Board</p>
        <h1 class="mt-3 text-3xl font-black text-[#0d3d2d] dark:text-white sm:text-4xl">留言板</h1>
        <p class="mt-3 max-w-2xl text-sm leading-7 text-[#60786e] dark:text-slate-300">
          写下你的想法、建议或问候。每一条留言都会成为这个小站的一部分。
        </p>
      </div>

      <div class="message-board-grid grid gap-6 lg:grid-cols-[380px_1fr]">
        <section ref="formPanelRef" class="message-form-panel rounded-3xl border border-[#3ecf9a]/25 bg-white p-6 shadow-sm dark:border-white/10 dark:bg-white/5">
          <h2 class="text-xl font-black text-[#0d3d2d] dark:text-white">留下足迹</h2>
          <div class="message-form-fields mt-5">
            <div class="message-form-field">
              <AInput v-model:value="form.nickname" placeholder="昵称" size="large" />
            </div>
            <div class="message-form-field">
              <AInput v-model:value="form.email" placeholder="邮箱，可选" size="large" />
            </div>
            <div class="message-form-field">
              <AInput v-model:value="form.website" placeholder="网站，可选" size="large" />
            </div>
            <div class="message-form-field">
              <ATextarea v-model:value="form.content" :rows="5" placeholder="想说点什么..." />
            </div>
            <div>
              <p class="mb-2 text-sm font-bold text-[#60786e] dark:text-slate-300">选择便签颜色</p>
              <div class="flex flex-wrap gap-2">
                <button
                  v-for="color in colorOptions"
                  :key="color"
                  class="h-8 w-8 rounded-full border-2 transition"
                  :class="form.color === color ? 'border-slate-900 scale-110 dark:border-white' : 'border-transparent'"
                  :style="{ backgroundColor: color }"
                  type="button"
                  @click="form.color = color"
                ></button>
              </div>
            </div>
            <AButton block type="primary" size="large" :loading="submitting" class="!mt-6" @click="submitMessage">
              发布留言
            </AButton>
          </div>
        </section>

        <section
          class="message-list-panel rounded-3xl border border-[#3ecf9a]/25 bg-white p-6 shadow-sm dark:border-white/10 dark:bg-white/5"
          :style="matchedPanelHeight ? { height: `${matchedPanelHeight}px` } : undefined"
        >
          <div class="message-list-header mb-5 flex shrink-0 items-center justify-between gap-3">
            <h2 class="text-xl font-black text-[#0d3d2d] dark:text-white">最新留言</h2>
            <span class="rounded-full bg-[#3ecf9a]/10 px-3 py-1 text-xs font-bold text-[#3ecf9a]">
              共 {{ totalCount }} 条
            </span>
          </div>

          <div class="message-list-scroll">
            <ASpin :spinning="loading">
              <div v-if="messages.length" class="grid gap-4 md:grid-cols-2">
                <article
                  v-for="item in messages"
                  :key="item.id"
                  class="rounded-3xl border border-black/5 p-5 shadow-sm dark:border-white/10"
                  :style="{ background: `${item.color || '#3ecf9a'}18` }"
                >
                  <div class="flex items-center justify-between gap-3">
                    <h3 class="line-clamp-1 font-black text-[#0d3d2d] dark:text-white">{{ item.nickname }}</h3>
                    <time class="shrink-0 text-xs text-[#60786e] dark:text-slate-400">{{ formatDate(item.createdAt) }}</time>
                  </div>
                  <p class="mt-3 whitespace-pre-wrap text-sm leading-7 text-[#40584d] dark:text-slate-200">{{ item.content }}</p>
                  <a
                    v-if="item.website"
                    class="mt-4 inline-flex text-xs font-bold text-[#3ecf9a]"
                    :href="item.website"
                    target="_blank"
                    rel="noopener noreferrer"
                  >
                    访问主页
                  </a>
                </article>
              </div>
              <AEmpty v-else description="暂无留言，来发布第一条吧" />
            </ASpin>
          </div>

          <div v-if="totalCount > pageSize" class="message-list-footer mt-6 flex shrink-0 justify-center">
            <APagination
              :current="pageNumber"
              :page-size="pageSize"
              :total="totalCount"
              :show-size-changer="false"
              @change="goPage"
            />
          </div>
        </section>
      </div>
    </section>
  </main>
</template>

<script setup lang="ts">
import { computed, onMounted, onUnmounted, reactive, ref, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { message as antMessage } from 'ant-design-vue';
import { type MessageItem, getMessageList, publishMessage } from '@/service/blog/surfer/message';

const colorOptions = ['#3ecf9a', '#539dfd', '#f59e0b', '#ef4444', '#a855f7', '#14b8a6'];

const loading = ref(false);
const submitting = ref(false);
const formPanelRef = ref<HTMLElement | null>(null);
const matchedPanelHeight = ref<number>();
let formPanelObserver: ResizeObserver | null = null;
const route = useRoute();
const router = useRouter();
const messages = ref<MessageItem[]>([]);
const pageNumber = computed(() => {
  const q = route.query.page;
  const n = Number(q);
  return Number.isFinite(n) && n > 0 ? n : 1;
});
const pageSize = ref(12);
const totalCount = ref(0);

const form = reactive({
  nickname: '',
  email: '',
  website: '',
  content: '',
  color: colorOptions[0]
});

const canSubmit = computed(() => form.nickname.trim() && form.content.trim());

function formatDate(value: string) {
  if (!value) return '';
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return value;
  return date.toLocaleDateString('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit'
  });
}

function resetForm() {
  form.nickname = '';
  form.email = '';
  form.website = '';
  form.content = '';
  form.color = colorOptions[0];
}

async function loadMessages() {
  loading.value = true;
  try {
    const response = await getMessageList(pageNumber.value, pageSize.value);
    if (response.success) {
      messages.value = response.data.items || [];
      pageSize.value = response.data.pageSize || pageSize.value;
      totalCount.value = response.data.totalCount || messages.value.length;
    }
  } finally {
    loading.value = false;
  }
}

function goPage(page: number) {
  router.replace({ query: { page: page > 1 ? String(page) : undefined } });
}

async function submitMessage() {
  if (!canSubmit.value) {
    antMessage.warning('请填写昵称和留言内容');
    return;
  }

  submitting.value = true;
  try {
    const response = await publishMessage({
      nickname: form.nickname.trim(),
      email: form.email.trim() || undefined,
      website: form.website.trim() || undefined,
      content: form.content.trim(),
      color: form.color
    });

    if (response.success) {
      antMessage.success('留言发布成功');
      resetForm();
      router.replace({ query: {} });
      await loadMessages();
    }
  } finally {
    submitting.value = false;
  }
}

function syncPanelHeight() {
  if (!formPanelRef.value || window.innerWidth < 1024) {
    matchedPanelHeight.value = undefined;
    return;
  }
  matchedPanelHeight.value = formPanelRef.value.offsetHeight;
}

onMounted(() => {
  loadMessages();
  syncPanelHeight();
  if (formPanelRef.value) {
    formPanelObserver = new ResizeObserver(() => syncPanelHeight());
    formPanelObserver.observe(formPanelRef.value);
  }
  window.addEventListener('resize', syncPanelHeight);
});

onUnmounted(() => {
  formPanelObserver?.disconnect();
  window.removeEventListener('resize', syncPanelHeight);
});

watch(
  () => route.query.page,
  () => {
    loadMessages();
  }
);
</script>

<style scoped lang="scss">
.message-list-panel {
  display: flex;
  flex-direction: column;
  min-height: 0;
}

.message-list-scroll {
  flex: 1 1 auto;
  min-height: 0;
  overflow-y: auto;
  overscroll-behavior: contain;
  scrollbar-width: thin;
  scrollbar-color: rgb(62 207 154 / 45%) transparent;
}

.message-list-scroll::-webkit-scrollbar {
  width: 6px;
}

.message-list-scroll::-webkit-scrollbar-thumb {
  border-radius: 999px;
  background: rgb(62 207 154 / 45%);
}

.message-list-scroll::-webkit-scrollbar-track {
  background: transparent;
}

.message-form-fields {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.message-form-field {
  display: block;
}
</style>
