<script setup lang="ts">
import { computed, nextTick, onBeforeUnmount, ref, watch } from 'vue';
import { useRouter } from 'vue-router';
import { SearchOutlined } from '@ant-design/icons-vue';
import { getArticleSearchPageList } from '@/service/blog/surfer/article';

interface Props {
  isMobile?: boolean;
}

withDefaults(defineProps<Props>(), {
  isMobile: false
});

const router = useRouter();
const query = ref('');
const results = ref<{ id: number; title: string }[]>([]);
const open = ref(false);
const modalVisible = ref(false);
const inputRef = ref<HTMLInputElement>();
const containerRef = ref<HTMLDivElement>();
const modalInputRef = ref<HTMLInputElement>();

let timer: ReturnType<typeof setTimeout>;

type ArticleResult = { id: number; title: string };
type SearchResp = { success: boolean; data: { items: ArticleResult[] } };

const hasResults = computed(() => results.value.length > 0);

function highlightKeyword(text: string, keyword: string): string {
  if (!keyword) return text;
  const escaped = keyword.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  return text.replace(new RegExp(`(${escaped})`, 'gi'), '<mark class="search-highlight">$1</mark>');
}

function onInput() {
  clearTimeout(timer);
  const v = query.value.trim();
  if (!v) {
    results.value = [];
    open.value = false;
    return;
  }
  timer = setTimeout(async () => {
    try {
      const res = await getArticleSearchPageList<SearchResp>({ keyword: v, pageSize: 8 });
      if (res.success) {
        results.value = (res.data?.items || []).filter(
          (a: ArticleResult) => a.title && a.title.includes(v)
        );
        open.value = true;
      }
    } catch {
      results.value = [];
    }
  }, 300);
}

function onFocus() {
  if (query.value.trim()) open.value = true;
}

function goArticle(id: number) {
  closeAll();
  router.push(`/blog/surfer/article/${id}`);
}

function closeAll() {
  open.value = false;
  modalVisible.value = false;
  query.value = '';
  results.value = [];
}

function openModal() {
  modalVisible.value = true;
  nextTick(() => {
    modalInputRef.value?.focus();
  });
}

function onClickOutside(e: MouseEvent) {
  if (containerRef.value && !containerRef.value.contains(e.target as Node)) {
    open.value = false;
  }
}

function onKeydown(e: KeyboardEvent) {
  if (e.key === 'Escape') {
    open.value = false;
    inputRef.value?.blur();
  }
}

watch(modalVisible, (val) => {
  if (!val) {
    query.value = '';
    results.value = [];
    open.value = false;
  }
});

document.addEventListener('click', onClickOutside);
onBeforeUnmount(() => document.removeEventListener('click', onClickOutside));
</script>

<template>
  <template v-if="isMobile">
    <ButtonIcon
      size-class="text-icon-xl"
      icon="ic:round-search"
      tooltip-content="搜索文章"
      @click="openModal"
    />
    <AModal
      v-model:open="modalVisible"
      :footer="null"
      :closable="false"
      width="100%"
      wrap-class-name="search-modal-mobile"
      :body-style="{ padding: '12px' }"
    >
      <div class="flex flex-col gap-3" @keydown="onKeydown">
        <div class="flex items-center gap-2">
          <div
            class="flex flex-1 items-center rounded-lg border border-[#3ecf9a]/20 bg-white/72 px-3 py-2 transition-colors focus-within:border-[#3ecf9a]/50 dark:bg-[#2c333e]/72 dark:border-[#334155] dark:focus-within:border-[#539dfd]/50"
          >
            <SearchOutlined class="mr-2 shrink-0 text-sm text-[#557468] dark:text-[#cbd5e1]" />
            <input
              ref="modalInputRef"
              v-model="query"
              type="text"
              placeholder="搜索文章..."
              class="w-full min-w-0 bg-transparent text-sm text-[#3ecf9a] outline-none placeholder:text-[#a0b8ad] dark:text-white dark:placeholder:text-[#94a3b8]"
              @input="onInput"
              @focus="onFocus"
            />
          </div>
          <AButton size="small" @click="modalVisible = false">取消</AButton>
        </div>

        <div v-if="hasResults" class="flex flex-col gap-1 max-h-[60vh] overflow-y-auto">
          <button
            v-for="article in results"
            :key="article.id"
            class="block w-full rounded-md px-3 py-2 text-left text-sm text-[#3ecf9a] transition-colors hover:bg-[#3ecf9a]/10 dark:text-white truncate"
            @click="goArticle(article.id)"
            v-html="highlightKeyword(article.title, query)"
          />
        </div>

        <div
          v-if="!hasResults && query.trim()"
          class="py-8 text-center text-sm text-[#a0b8ad] dark:text-[#94a3b8]"
        >
          未找到相关文章
        </div>
      </div>
    </AModal>
  </template>

  <template v-else>
    <div ref="containerRef" class="relative w-[150px] sm:w-[200px] sm:mr-4" @keydown="onKeydown">
      <div
        class="flex items-center rounded-lg border border-[#3ecf9a]/20 bg-white/72 px-3 py-1.5 transition-colors focus-within:border-[#3ecf9a]/50 dark:bg-[#2c333e]/72 dark:border-[#334155] dark:focus-within:border-[#539dfd]/50"
      >
        <SearchOutlined class="mr-2 shrink-0 text-sm text-[#557468] dark:text-[#cbd5e1]" />
        <input
          ref="inputRef"
          v-model="query"
          type="text"
          placeholder="搜索文章..."
          class="w-full min-w-0 bg-transparent text-sm text-[#3ecf9a] outline-none placeholder:text-[#a0b8ad] dark:text-white dark:placeholder:text-[#94a3b8]"
          @input="onInput"
          @focus="onFocus"
        />
      </div>

      <div
        v-if="open && hasResults"
        class="absolute left-0 right-0 top-full z-50 mt-1 max-h-[320px] overflow-y-auto rounded-lg border border-[#3ecf9a]/14 bg-white/96 p-1 shadow-lg backdrop-blur dark:border-[#334155] dark:bg-[#2c333e]/96"
      >
        <button
          v-for="article in results"
          :key="article.id"
          class="block w-full rounded-md px-3 py-2 text-left text-sm text-[#3ecf9a] transition-colors hover:bg-[#3ecf9a]/10 dark:text-white truncate"
          @click="goArticle(article.id)"
          v-html="highlightKeyword(article.title, query)"
        />
      </div>
    </div>
  </template>
</template>

<style>
.search-highlight {
  color: #eb373a;
  background: transparent;
  font-weight: 800;
}

.search-modal-mobile {
  display: flex;
  align-items: flex-start;
  justify-content: center;
}
.search-modal-mobile .ant-modal {
  max-width: 100%;
  margin: 0;
  padding: 0;
}
.search-modal-mobile .ant-modal-content {
  border-radius: 0;
  min-height: auto;
}

.dark .search-modal-mobile .ant-modal-content {
  background: #1e2127;
}
.dark .search-modal-mobile .ant-modal-header {
  background: #1e2127;
}
.dark .search-modal-mobile .ant-modal-body {
  background: #1e2127;
}
</style>
