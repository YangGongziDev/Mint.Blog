<script setup lang="ts">
import { computed, nextTick, onBeforeUnmount, onMounted, ref, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import {
  CalendarOutlined,
  ClockCircleOutlined,
  CopyrightOutlined,
  EyeOutlined,
  FileTextOutlined,
  LeftOutlined,
  LinkOutlined,
  RightOutlined
} from '@ant-design/icons-vue';
import hljs from 'highlight.js';
import { getArticleDetail } from '@/service/blog/surfer/article';
import { getBlogSettingsDetail } from '@/service/blog/surfer/setting';
import { getColumnArticlePreNext, getColumnCatalogs } from '@/service/blog/surfer/column';
import { useTabStore } from '@/store/system/tab';
import SurferComment from '@/components/blog/surfer/comment.vue';
import SurferToc from '@/components/blog/surfer/toc.vue';

defineOptions({ name: 'SurferColumnDetailPage' });

type Tag = { id?: number; name?: string };
type Article = {
  id?: number;
  title?: string;
  content?: string;
  tags?: Tag[];
  totalWords?: number;
  readTime?: string;
  createTime?: string;
  updateTime?: string;
  categoryId?: number;
  categoryName?: string;
  readNum?: number;
};
type PreNext = {
  preArticle?: { articleId: number; articleTitle: string };
  nextArticle?: { articleId: number; articleTitle: string };
};
type ColumnCatalog = { id: number; title: string; children: { articleId: number; title: string }[] };
type BlogSettings = { copyrightDeclaration?: string };

const route = useRoute();
const router = useRouter();
const tabStore = useTabStore();

const article = ref<Article>({});
const blogSettings = ref<BlogSettings>({});
const preNext = ref<PreNext | null>(null);
const catalogs = ref<ColumnCatalog[]>([]);
const activeKeys = ref<(string | number)[]>([]);
const catalogsVisible = ref(true);
const desktopTocVisible = ref(true);
const mobileTocVisible = ref(false);
const mobileTocRenderKey = ref(0);
const isMobile = ref(false);
const loading = ref(true);
const shouldFallbackToFirstArticle = ref(false);

const currentArticleUrl = computed(() => window.location.href);
const copyrightDeclaration = computed(() => {
  const declaration = blogSettings.value.copyrightDeclaration?.trim();

  if (declaration) return declaration;

  const year = article.value.createTime ? new Date(article.value.createTime).getFullYear() : new Date().getFullYear();

  return `© ${year} 保留所有权利，转载请注明出处和原文链接。`;
});
const renderedContent = computed(() => renderMarkdown(article.value.content || ''));
const hasTocHeadings = computed(() => /^#{2,4}\s+\S+/m.test(article.value.content || ''));

function escapeHtml(text: string) {
  return text
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#39;');
}

function renderInlineMarkdown(text: string) {
  return escapeHtml(text)
    .replace(/!\[([^\]]*)\]\(([^)]+)\)/g, '<img src="$2" alt="$1" />')
    .replace(/\[([^\]]+)\]\(([^)]+)\)/g, '<a href="$2" target="_blank" rel="noopener noreferrer">$1</a>')
    .replace(/`([^`]+)`/g, '<code>$1</code>')
    .replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>')
    .replace(/__([^_]+)__/g, '<strong>$1</strong>')
    .replace(/\*([^*]+)\*/g, '<em>$1</em>')
    .replace(/_([^_]+)_/g, '<em>$1</em>')
    .replace(/~~([^~]+)~~/g, '<del>$1</del>');
}

function highlightCode(code: string, language: string) {
  const normalizedLanguage = language.trim().toLowerCase();

  if (normalizedLanguage && hljs.getLanguage(normalizedLanguage)) {
    return hljs.highlight(code, { language: normalizedLanguage, ignoreIllegals: true }).value;
  }

  return hljs.highlightAuto(code).value;
}

const LANGUAGE_NAMES: Record<string, string> = {
  javascript: 'JavaScript', js: 'JavaScript',
  typescript: 'TypeScript', ts: 'TypeScript',
  python: 'Python', py: 'Python',
  java: 'Java',
  csharp: 'C#', cs: 'C#', 'c#': 'C#',
  cpp: 'C++', 'c++': 'C++', cxx: 'C++',
  c: 'C',
  go: 'Go', golang: 'Go',
  rust: 'Rust', rs: 'Rust',
  php: 'PHP',
  ruby: 'Ruby', rb: 'Ruby',
  swift: 'Swift',
  kotlin: 'Kotlin', kt: 'Kotlin',
  scala: 'Scala',
  dart: 'Dart',
  objectivec: 'Objective-C', objc: 'Objective-C', 'objective-c': 'Objective-C',
  html: 'HTML',
  css: 'CSS',
  scss: 'SCSS', sass: 'Sass',
  less: 'Less',
  json: 'JSON',
  xml: 'XML',
  yaml: 'YAML', yml: 'YAML',
  sql: 'SQL',
  bash: 'Bash', sh: 'Bash', shell: 'Shell', zsh: 'Zsh',
  powershell: 'PowerShell', ps1: 'PowerShell',
  dockerfile: 'Dockerfile', docker: 'Dockerfile',
  makefile: 'Makefile',
  graphql: 'GraphQL', gql: 'GraphQL',
  markdown: 'Markdown', md: 'Markdown',
  text: 'Text', txt: 'Text', plain: 'Text', plaintext: 'Text',
  vbnet: 'VB.NET', 'vb.net': 'VB.NET',
  fsharp: 'F#', fs: 'F#', 'f#': 'F#',
  lua: 'Lua',
  r: 'R',
  perl: 'Perl',
  elixir: 'Elixir',
  haskell: 'Haskell', hs: 'Haskell',
  clojure: 'Clojure',
  groovy: 'Groovy',
  erlang: 'Erlang',
  matlab: 'MATLAB',
  assembly: 'Assembly', asm: 'Assembly',
  nginx: 'Nginx',
  ini: 'INI', toml: 'TOML', env: '.env',
  diff: 'Diff',
  vhdl: 'VHDL',
  verilog: 'Verilog',
  apex: 'Apex',
  abap: 'ABAP',
  cobol: 'COBOL',
  pascal: 'Pascal',
  prolog: 'Prolog',
  scheme: 'Scheme',
  racket: 'Racket',
  latex: 'LaTeX', tex: 'LaTeX',
};

function toPascalCase(str: string) {
  const key = str.toLowerCase();
  if (LANGUAGE_NAMES[key]) return LANGUAGE_NAMES[key];
  return str
    .split(/[-_\s]+/)
    .map(word => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
    .join('');
}

function renderCodeBlock(code: string, language: string) {
  const normalizedLanguage = language.trim().toLowerCase() || 'text';
  const displayLang = toPascalCase(normalizedLanguage);
  const escapedCode = highlightCode(code, normalizedLanguage);
  const langLabel = `<span class="code-lang-label">${escapeHtml(displayLang)}</span>`;

  return `<div class="code-block-wrapper"><div class="code-block-header"><div class="code-block-dots"><span></span><span></span><span></span></div>${langLabel}<button class="code-copy-btn" onclick="navigator.clipboard.writeText(this.dataset.code).then(() => { this.innerHTML = '<svg width=\\'14\\' height=\\'14\\' viewBox=\\'0 0 24 24\\' fill=\\'none\\' stroke=\\'currentColor\\' stroke-width=\\'2.5\\'><polyline points=\\'20 6 9 17 4 12\\'/></svg>'; setTimeout(() => { this.innerHTML = '<svg width=\\'14\\' height=\\'14\\' viewBox=\\'0 0 24 24\\' fill=\\'none\\' stroke=\\'currentColor\\' stroke-width=\\'2\\'><rect x=\\'9\\' y=\\'9\\' width=\\'13\\' height=\\'13\\' rx=\\'2\\' ry=\\'2\\'/><path d=\\'M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1\\'/></svg>'; }, 2000); })" data-code="${escapeHtml(code)}"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/></svg></button></div><pre data-language="${escapeHtml(normalizedLanguage)}"><code class="hljs language-${escapeHtml(normalizedLanguage)}">${escapedCode}</code></pre></div>`;
}

function renderMarkdown(markdown: string) {
  const lines = markdown.replace(/\r\n/g, '\n').split('\n');
  const html: string[] = [];
  let paragraph: string[] = [];
  let listItems: string[] = [];
  let listType: 'ul' | 'ol' | null = null;
  let inCodeBlock = false;
  let codeLanguage = '';
  let codeLines: string[] = [];

  const flushParagraph = () => {
    if (!paragraph.length) return;
    html.push(`<p>${renderInlineMarkdown(paragraph.join(' '))}</p>`);
    paragraph = [];
  };

  const flushList = () => {
    if (!listType) return;
    html.push(`<${listType}>${listItems.join('')}</${listType}>`);
    listItems = [];
    listType = null;
  };

  for (const line of lines) {
    const trimmed = line.trim();

    if (trimmed.startsWith('```')) {
      if (inCodeBlock) {
        html.push(renderCodeBlock(codeLines.join('\n'), codeLanguage));
        codeLanguage = '';
        codeLines = [];
        inCodeBlock = false;
      } else {
        flushParagraph();
        flushList();
        codeLanguage = trimmed.slice(3).trim();
        inCodeBlock = true;
      }
    } else if (inCodeBlock) {
      codeLines.push(line);
    } else if (!trimmed) {
      flushParagraph();
      flushList();
    } else {
      const headingMatch = trimmed.match(/^(#{1,6})\s+(.+)$/);
      const unorderedMatch = trimmed.match(/^[-*+]\s+(.+)$/);
      const orderedMatch = trimmed.match(/^\d+\.\s+(.+)$/);

      if (headingMatch) {
        flushParagraph();
        flushList();
        const level = headingMatch[1].length;
        html.push(`<h${level}>${renderInlineMarkdown(headingMatch[2])}</h${level}>`);
      } else if (/^(-{3,}|\*{3,}|_{3,})$/.test(trimmed)) {
        flushParagraph();
        flushList();
        html.push('<hr />');
      } else if (trimmed.startsWith('>')) {
        flushParagraph();
        flushList();
        html.push(`<blockquote><p>${renderInlineMarkdown(trimmed.replace(/^>\s?/, ''))}</p></blockquote>`);
      } else if (unorderedMatch) {
        flushParagraph();
        if (listType && listType !== 'ul') flushList();
        listType = 'ul';
        listItems.push(`<li>${renderInlineMarkdown(unorderedMatch[1])}</li>`);
      } else if (orderedMatch) {
        flushParagraph();
        if (listType && listType !== 'ol') flushList();
        listType = 'ol';
        listItems.push(`<li>${renderInlineMarkdown(orderedMatch[1])}</li>`);
      } else {
        paragraph.push(trimmed);
      }
    }
  }

  if (inCodeBlock) html.push(renderCodeBlock(codeLines.join('\n'), codeLanguage));
  flushParagraph();
  flushList();

  return html.join('\n');
}

function updateIsMobile() {
  isMobile.value = window.innerWidth < 768;

  if (!isMobile.value) {
    mobileTocVisible.value = false;
  }
}

function handleToggleToc() {
  if (!article.value.content || !hasTocHeadings.value) return;

  if (isMobile.value) {
    mobileTocVisible.value = !mobileTocVisible.value;

    if (mobileTocVisible.value) {
      mobileTocRenderKey.value += 1;
      nextTick(() => {
        window.dispatchEvent(new Event('resize'));
      });
    }

    return;
  }

  desktopTocVisible.value = !desktopTocVisible.value;

  if (desktopTocVisible.value) {
    nextTick(() => {
      window.dispatchEvent(new Event('resize'));
    });
  }
}

function getFirstCatalogArticleId(items: ColumnCatalog[]) {
  return items.flatMap(item => item.children || []).find(child => child.articleId > 0)?.articleId;
}

function openFirstCatalogArticle(items = catalogs.value) {
  const firstArticleId = getFirstCatalogArticleId(items);
  if (!firstArticleId) {
    loading.value = false;
    return;
  }

  router.replace({ path: `/blog/surfer/column/${route.params.columnId}`, query: { articleId: String(firstArticleId) } });
}

async function loadBlogSettings() {
  try {
    const res = await getBlogSettingsDetail<{ success: boolean; data: BlogSettings }>();
    if (res.success) blogSettings.value = res.data || {};
  } catch {
    blogSettings.value = {};
  }
}

function loadArticle(articleId: string | number) {
  loading.value = true;
  getArticleDetail<{ success: boolean; data: Article; errorCode?: string }>(articleId)
    .then(res => {
      if (!res.success && res.errorCode === '20010') {
        shouldFallbackToFirstArticle.value = true;
        openFirstCatalogArticle();
        return;
      }
      shouldFallbackToFirstArticle.value = false;
      article.value = res.data || {};
      if (article.value.title) tabStore.setTabLabel(article.value.title);

      nextTick(() => {
        window.scrollTo({ top: 0, behavior: 'smooth' });
      });
    })
    .catch(() => {
      article.value = {};
    })
    .finally(() => {
      loading.value = false;
    });
}

function loadCatalogs() {
  getColumnCatalogs<{ success: boolean; data: ColumnCatalog[] }>(route.params.columnId as string)
    .then(res => {
      if (res.success) {
        const list = res.data || [];
        catalogs.value = list;
        const currentArticleId = Number(route.query.articleId) || getFirstCatalogArticleId(list);
        if (currentArticleId) {
          const parentCatalog = list.find(c => c.children?.some(child => child.articleId === currentArticleId));
          activeKeys.value = parentCatalog ? [parentCatalog.id] : [];
        } else {
          activeKeys.value = [];
        }

        if (!route.query.articleId || shouldFallbackToFirstArticle.value) openFirstCatalogArticle(list);
      }
    })
    .catch(() => {
      catalogs.value = [];
      activeKeys.value = [];
    });
}

function loadPreNext(articleId: string | number) {
  getColumnArticlePreNext<{ success: boolean; data: PreNext }>({ id: route.params.columnId, articleId })
    .then(res => {
      if (res.success) preNext.value = res.data || null;
    })
    .catch(() => {
      preNext.value = null;
    });
}

function goColumnArticle(articleId: number) {
  if (window.innerWidth < 640) {
    catalogsVisible.value = false;
  }
  setTimeout(() => window.dispatchEvent(new Event('resize')), 300);
  router.push({ path: `/blog/surfer/column/${route.params.columnId}`, query: { articleId: String(articleId) } });
}

function toggleCatalogs() {
  catalogsVisible.value = !catalogsVisible.value;
  setTimeout(() => window.dispatchEvent(new Event('resize')), 300);
}

watch(
  () => route.query.articleId,
  id => {
    if (id) {
      loadArticle(id as string);
      loadPreNext(id as string);
    }
  }
);

onMounted(async () => {
  updateIsMobile();
  window.addEventListener('resize', updateIsMobile);
  window.addEventListener('blog-surfer:toggle-toc', handleToggleToc);

  await loadBlogSettings();
  loadCatalogs();
  const articleId = route.query.articleId as string;
  if (articleId) {
    loadArticle(articleId);
    loadPreNext(articleId);
  }
});

onBeforeUnmount(() => {
  window.removeEventListener('resize', updateIsMobile);
  window.removeEventListener('blog-surfer:toggle-toc', handleToggleToc);
});
</script>

<template>
  <div class="flex">
    <aside
      class="column-sidebar fixed bottom-0 z-[90] overflow-y-auto border-r border-[#3ecf9a]/14 bg-white p-4 transition-all duration-300 dark:border-[#334155] dark:bg-[#2c333e]"
      :class="[
        catalogsVisible
          ? 'left-0 w-[280px] sm:w-[280px]'
          : '-left-[280px] sm:left-[-280px] w-[280px] p-0 sm:p-0'
      ]"
    >
      <div class="pt-6" :class="[catalogsVisible ? 'block' : 'hidden']">
        <h3 class="mb-3 text-sm font-bold text-[#0d3d2d] dark:text-white">目录</h3>
        <div v-for="cat in catalogs" :key="cat.id" class="mb-2">
          <button
            class="flex w-full items-center gap-2 rounded-lg px-2 py-1.5 text-sm font-bold text-[#0d3d2d] dark:text-white hover:bg-[#3ecf9a]/8"
            @click="
              activeKeys.includes(cat.id)
                ? (activeKeys = activeKeys.filter(k => k !== cat.id))
                : activeKeys.push(cat.id)
            "
          >
            <span class="text-xs transition-transform" :class="[activeKeys.includes(cat.id) ? 'rotate-90' : '']">
              ▶
            </span>
            {{ cat.title }}
          </button>
          <ul v-if="activeKeys.includes(cat.id)" class="ml-5 mt-1 space-y-1">
            <li v-for="child in cat.children" :key="child.articleId">
              <button
                class="block w-full rounded-lg px-2 py-1 text-left text-xs text-[#557468] dark:text-[#cbd5e1] hover:bg-[#3ecf9a]/8 transition-colors truncate"
                :class="[
                  route.query.articleId === String(child.articleId)
                    ? 'bg-[#3ecf9a]/12 text-[#3ecf9a] font-bold dark:text-[#539dfd]'
                    : ''
                ]"
                @click="goColumnArticle(child.articleId)"
              >
                {{ child.title }}
              </button>
            </li>
          </ul>
        </div>
      </div>
    </aside>

    <button
      class="column-sidebar-toggle fixed z-[91] flex h-8 w-8 items-center justify-center rounded-full border border-[#3ecf9a]/14 bg-white/92 text-sm text-[#557468] shadow-sm transition-all duration-300 hover:text-[#3ecf9a] dark:bg-[#2c333e]/92 dark:text-[#cbd5e1] dark:border-[#334155]"
      :class="[catalogsVisible ? 'left-[264px]' : 'left-4']"
      @click="toggleCatalogs"
    >
      {{ catalogsVisible ? '◀' : '▶' }}
    </button>

    <div
      v-if="catalogsVisible"
      class="column-sidebar-overlay fixed inset-0 z-[89] bg-black/30 sm:hidden"
      @click="catalogsVisible = false"
    />

    <main
      class="w-full px-4 md:px-6 py-4 transition-all duration-300"
      :class="[catalogsVisible ? 'sm:ml-[280px] max-w-screen-2xl' : 'mx-auto max-w-screen-2xl']"
    >
      <div class="grid grid-cols-1 gap-7 lg:grid-cols-4">
        <div
          class="mt-6 col-span-1 mb-3"
          :class="desktopTocVisible && hasTocHeadings ? 'lg:col-span-3' : 'lg:col-span-4'"
        >
          <div v-if="loading" class="animate-pulse space-y-4">
            <div class="h-10 w-3/5 rounded-xl bg-[#3ecf9a]/8 dark:bg-white/8"></div>
            <div class="h-4 w-2/5 rounded bg-gray-200 dark:bg-white/5"></div>
            <div class="h-[400px] rounded-2xl bg-white/80 dark:bg-white/5"></div>
          </div>

          <template v-else-if="article.content">
            <div
              class="mb-3 rounded-lg border border-[#3ecf9a]/14 bg-white/84 p-5 dark:border-[#334155] dark:bg-[#2c333e]/72"
            >
              <h1 class="mb-3 text-3xl font-black text-[#0d3d2d] dark:text-white">{{ article.title }}</h1>

              <div v-if="article.tags && article.tags.length" class="mb-4 flex flex-wrap gap-2">
                <ATooltip v-for="tag in article.tags" :key="tag.id" title="标签">
                  <span
                    class="cursor-pointer rounded-md bg-[#3ecf9a]/12 px-2.5 py-0.5 text-xs font-medium text-[#15956b] dark:text-[#539dfd] hover:bg-[#3ecf9a]/20"
                  >
                    # {{ tag.name }}
                  </span>
                </ATooltip>
              </div>

              <div class="mb-5 flex flex-wrap items-center gap-3 text-xs text-[#557468] dark:text-[#cbd5e1]">
                <span class="flex items-center">
                  <CalendarOutlined class="mr-1 w-3.5 h-3.5" />
                  发布时间&nbsp;{{ article.createTime }}
                </span>
                <span class="flex items-center">
                  <EyeOutlined class="mr-1 w-3.5 h-3.5" />
                  阅读人次&nbsp;{{ article.readNum }}
                </span>
                <span class="flex items-center">
                  <FileTextOutlined class="mr-1 w-3.5 h-3.5" />
                  总字数&nbsp;{{ article.totalWords }}
                </span>
                <span class="flex items-center">
                  <ClockCircleOutlined class="mr-1 w-3.5 h-3.5" />
                  阅读耗时&nbsp;{{ article.readTime }}
                </span>
              </div>

              <article>
                <div class="mt-5 leading-relaxed article-content" v-html="renderedContent"></div>
              </article>

              <div class="flex items-center text-sm mt-5 mb-5 text-[#557468] dark:text-[#cbd5e1]">
                最后编辑于 {{ article.updateTime }}
              </div>

              <div class="mt-6 mb-6">
                <div
                  class="flex items-start gap-3 p-4 rounded-xl border shadow-sm bg-[#f0faf5]/80 text-[#557468] border-[#3ecf9a]/14 dark:bg-[#2c333e]/60 dark:text-[#cbd5e1] dark:border-[#334155]"
                >
                  <CopyrightOutlined class="w-5 h-5 text-[#3ecf9a] dark:text-[#539dfd] mt-0.5 shrink-0" />
                  <div>
                    <p class="text-sm font-bold uppercase tracking-wide text-[#557468] dark:text-[#cbd5e1] mb-1">
                      版权声明
                    </p>
                    <p class="whitespace-pre-line text-sm leading-relaxed">
                      {{ copyrightDeclaration }}
                    </p>
                    <div class="mt-2 text-xs flex items-start gap-1 text-[#557468] dark:text-[#cbd5e1]">
                      <LinkOutlined class="mt-[2px] w-3.5 h-3.5 shrink-0" />
                      <span class="text-sm shrink-0">原文链接：</span>
                      <a
                        :href="currentArticleUrl"
                        target="_blank"
                        rel="noopener noreferrer"
                        class="text-sm text-[#3ecf9a] dark:text-[#539dfd] hover:underline break-all"
                      >
                        {{ currentArticleUrl }}
                      </a>
                    </div>
                  </div>
                </div>
              </div>

              <nav v-if="preNext" class="flex gap-4 mt-7">
                <div class="flex-1">
                  <button
                    v-if="preNext.preArticle"
                    class="flex w-full flex-col rounded-lg border border-[#3ecf9a]/14 bg-white/72 p-4 text-left transition-colors hover:border-[#3ecf9a]/40 dark:bg-[#2c333e]/72 dark:border-[#334155]"
                    @click="goColumnArticle(preNext.preArticle.articleId)"
                  >
                    <div class="text-xs text-[#557468] dark:text-[#cbd5e1]">
                      <LeftOutlined class="mr-1 w-3 h-3" />
                      上一篇
                    </div>
                    <div class="mt-1 text-sm font-medium text-[#0d3d2d] dark:text-white line-clamp-1">
                      {{ preNext.preArticle.articleTitle }}
                    </div>
                  </button>
                </div>
                <div class="flex-1 text-right">
                  <button
                    v-if="preNext.nextArticle"
                    class="flex w-full flex-col rounded-lg border border-[#3ecf9a]/14 bg-white/72 p-4 text-right transition-colors hover:border-[#3ecf9a]/40 dark:bg-[#2c333e]/72 dark:border-[#334155]"
                    @click="goColumnArticle(preNext.nextArticle.articleId)"
                  >
                    <div class="text-xs text-[#557468] dark:text-[#cbd5e1]">
                      下一篇
                      <RightOutlined class="ml-1 w-3 h-3" />
                    </div>
                    <div class="mt-1 text-sm font-medium text-[#0d3d2d] dark:text-white line-clamp-1">
                      {{ preNext.nextArticle.articleTitle }}
                    </div>
                  </button>
                </div>
              </nav>
            </div>

            <SurferComment />
          </template>
        </div>

        <div v-show="desktopTocVisible && hasTocHeadings" class="col-span-1 mt-6 hidden md:block">
          <SurferToc :key="route.query.articleId as string" :header-offset="150" />
        </div>
      </div>
    </main>

    <ADrawer
      v-model:open="mobileTocVisible"
      title="文章目录"
      placement="right"
      width="86%"
      class="column-mobile-toc-drawer"
    >
      <SurferToc
        v-if="mobileTocVisible"
        :key="mobileTocRenderKey"
        :header-offset="80"
        :pinnable="false"
        @item-click="mobileTocVisible = false"
      />
    </ADrawer>
  </div>
</template>

<style scoped>
.column-sidebar {
  top: calc(var(--soy-header-height) + var(--soy-tab-height));
  scrollbar-width: thin;
  scrollbar-color: rgb(62 207 154 / 20%) transparent;
}

.column-sidebar-toggle {
  top: calc(var(--soy-header-height) + var(--soy-tab-height) + 4px);
}

:deep(.article-content) {
  --ct-text: #49695d;
  --ct-heading: #3ecf9a;
  --ct-heading3: #3ecf9a;
  --ct-heading5: #3ecf9a;
  --ct-accent: #15956b;
  --ct-link: #15956b;
  --ct-link-hover: #15956b;
  --ct-link-underline: rgba(24, 181, 127, 0.32);
  --ct-strong: #3ecf9a;
  --ct-border: rgba(62, 207, 154, 0.18);
  --ct-bg-code: rgba(62, 207, 154, 0.1);
  --ct-bg-blockquote: linear-gradient(135deg, rgba(62, 207, 154, 0.12), rgba(24, 181, 127, 0.04));
  --ct-blockquote-border: #3ecf9a;
  --ct-blockquote-quote: rgba(24, 181, 127, 0.15);
  --ct-bullet: #3ecf9a;
  --ct-bullet-shadow: rgba(24, 181, 127, 0.11);
  --ct-img-border: rgba(62, 207, 154, 0.14);
  --ct-img-shadow: rgba(141, 240, 202, 0.08);
  --ct-img-shadow-hover: rgba(62, 207, 154, 0.12);
  --ct-pre-bg: linear-gradient(145deg, #111827, #0b1411);
  --ct-pre-shadow: rgba(62, 207, 154, 0.12);
  --ct-pre-code: #f5fff9;
  --ct-pre-lang-border: rgba(62, 207, 154, 0.14);
  --ct-pre-lang-bg: rgba(141, 240, 202, 0.08);
  --ct-pre-lang-color: #3ecf9a;
  --ct-hr: linear-gradient(90deg, transparent, rgba(24, 181, 127, 0.45), transparent);
  --ct-h2-before: linear-gradient(180deg, #3ecf9a, #3ecf9a);
  --ct-h2-before-shadow: rgba(24, 181, 127, 0.32);
  --ct-h2-border: rgba(62, 207, 154, 0.18);
  --ct-del: #7b9188;
  --ct-del-line: rgba(24, 181, 127, 0.6);
  --ct-copy-hover: rgba(141, 240, 202, 0.12);
  --ct-tr-stripe: rgba(62, 207, 154, 0.04);
  --ct-th-bg: rgba(62, 207, 154, 0.12);
  --ct-th-color: #3ecf9a;
  --ct-table-border: rgba(62, 207, 154, 0.16);
  --ct-td-border: rgba(62, 207, 154, 0.13);
  color: var(--ct-text);
  font-size: 16px;
  line-height: 1.9;
  letter-spacing: 0.2px;
  overflow-wrap: break-word;
  font-family: -apple-system, BlinkMacSystemFont, PingFang SC, Hiragino Sans GB, Microsoft Yahei, Arial, sans-serif;
}

:deep(html.dark .article-content) {
  --ct-text: #cbd5e1;
  --ct-heading: #f8fafc;
  --ct-heading3: #e2e8f0;
  --ct-heading5: #cbd5e1;
  --ct-accent: #539dfd;
  --ct-link: #539dfd;
  --ct-link-hover: #60a5fa;
  --ct-link-underline: rgba(83, 157, 253, 0.32);
  --ct-strong: #cbd5e1;
  --ct-border: rgba(83, 157, 253, 0.18);
  --ct-bg-code: rgba(83, 157, 253, 0.1);
  --ct-bg-blockquote: linear-gradient(135deg, rgba(83, 157, 253, 0.12), rgba(255, 255, 255, 0.03));
  --ct-blockquote-border: #539dfd;
  --ct-blockquote-quote: rgba(83, 157, 253, 0.15);
  --ct-bullet: #539dfd;
  --ct-bullet-shadow: rgba(83, 157, 253, 0.11);
  --ct-img-border: rgba(83, 157, 253, 0.14);
  --ct-img-shadow: rgba(83, 157, 253, 0.08);
  --ct-img-shadow-hover: rgba(83, 157, 253, 0.12);
  --ct-pre-bg: linear-gradient(145deg, #111827, #1e293b);
  --ct-pre-shadow: rgba(83, 157, 253, 0.12);
  --ct-pre-code: #cbd5e1;
  --ct-pre-lang-border: rgba(83, 157, 253, 0.14);
  --ct-pre-lang-bg: rgba(83, 157, 253, 0.08);
  --ct-pre-lang-color: #539dfd;
  --ct-hr: linear-gradient(90deg, transparent, rgba(83, 157, 253, 0.45), transparent);
  --ct-h2-before: linear-gradient(180deg, #539dfd, #539dfd);
  --ct-h2-before-shadow: rgba(83, 157, 253, 0.32);
  --ct-h2-border: rgba(83, 157, 253, 0.18);
  --ct-del: #94a3b8;
  --ct-del-line: rgba(83, 157, 253, 0.4);
  --ct-copy-hover: rgba(83, 157, 253, 0.12);
  --ct-tr-stripe: rgba(83, 157, 253, 0.04);
  --ct-th-bg: rgba(83, 157, 253, 0.1);
  --ct-th-color: #cbd5e1;
  --ct-table-border: rgba(83, 157, 253, 0.16);
  --ct-td-border: rgba(83, 157, 253, 0.13);
}

:deep(.article-content > *:first-child) { margin-top: 0 !important; }

:deep(.article-content h1),
:deep(.article-content h2),
:deep(.article-content h3),
:deep(.article-content h4),
:deep(.article-content h5),
:deep(.article-content h6) {
  position: relative;
  color: var(--ct-heading);
  font-weight: 850;
  line-height: 1.35;
  scroll-margin-top: 120px;
}

:deep(.article-content h3),
:deep(.article-content h4) { color: var(--ct-heading3); }

:deep(.article-content h5),
:deep(.article-content h6) { color: var(--ct-heading5); }

:deep(.article-content h1) { margin: 2.2em 0 0.8em; font-size: 2.1rem; }

:deep(.article-content h2) {
  display: flex; align-items: center; gap: 0.7rem;
  margin: 2.4em 0 1em; padding-bottom: 0.75rem;
  border-bottom: 1px solid var(--ct-h2-border); font-size: 1.65rem;
}

:deep(.article-content h2::before) {
  content: ''; width: 0.34rem; height: 1.45rem; border-radius: 999px;
  background: var(--ct-h2-before); box-shadow: 0 0 18px var(--ct-h2-before-shadow);
}

:deep(.article-content h3) { margin: 2em 0 0.85em; font-size: 1.32rem; }

:deep(.article-content h3::before) {
  content: '#'; margin-right: 0.45rem; color: var(--ct-accent); font-weight: 900;
}

:deep(.article-content h4) { margin: 1.6em 0 0.7em; font-size: 1.16rem; }

:deep(.article-content h5),
:deep(.article-content h6) { margin: 1.4em 0 0.65em; font-size: 1rem; }

:deep(.article-content p) { margin: 0 0 1.25rem; color: var(--ct-text); }

:deep(.article-content strong) { color: var(--ct-strong); font-weight: 800; }

:deep(.article-content em) { color: var(--ct-accent); font-style: italic; }

:deep(.article-content del) { color: var(--ct-del); text-decoration-color: var(--ct-del-line); }

:deep(.article-content a) {
  color: var(--ct-link); font-weight: 650; text-decoration: none;
  border-bottom: 1px dashed var(--ct-link-underline);
  transition: color 0.2s ease, border-color 0.2s ease, background-color 0.2s ease;
}

:deep(.article-content a:hover) {
  color: var(--ct-link-hover); border-bottom-color: transparent;
  background: var(--ct-bg-code);
}

:deep(.article-content blockquote) {
  position: relative; margin: 1.6rem 0; padding: 1.1rem 1.25rem 1.1rem 1.45rem;
  overflow: hidden;
  border: 1px solid var(--ct-border); border-left: 4px solid var(--ct-blockquote-border);
  border-radius: 10px; background: var(--ct-bg-blockquote); color: var(--ct-text);
}

:deep(.article-content blockquote::before) {
  content: '\201c'; position: absolute; right: 1rem; top: -0.35rem;
  color: var(--ct-blockquote-quote); font-size: 4rem; font-weight: 900; line-height: 1;
}

:deep(.article-content blockquote p) { margin-bottom: 0; }

:deep(.article-content ul),
:deep(.article-content ol) { margin: 1rem 0 1.35rem; padding-left: 1.4rem; }
:deep(.article-content ul) { list-style: none; }
:deep(.article-content ol) { list-style-position: outside; }
:deep(.article-content li) { margin: 0.42rem 0; padding-left: 0.2rem; color: var(--ct-text); }

:deep(.article-content ul > li) { position: relative; padding-left: 1.05rem; }

:deep(.article-content ul > li::before) {
  content: ''; position: absolute; left: 0; top: 0.78em;
  width: 0.42rem; height: 0.42rem; border-radius: 999px;
  background: var(--ct-bullet); box-shadow: 0 0 0 4px var(--ct-bullet-shadow);
}

:deep(.article-content img) {
  display: block; max-width: 100%; margin: 1.75rem auto;
  border: 1px solid var(--ct-img-border); border-radius: 18px;
  box-shadow: 0 16px 48px var(--ct-img-shadow);
  transition: transform 0.25s ease, box-shadow 0.25s ease;
}

:deep(.article-content img:hover) {
  transform: translateY(-2px); box-shadow: 0 22px 64px var(--ct-img-shadow-hover);
}

:deep(.article-content code:not(pre code)) {
  padding: 0.16rem 0.38rem; margin: 0 0.12rem;
  border: 1px solid var(--ct-border3); border-radius: 7px;
  background: var(--ct-bg-code); color: var(--ct-accent);
  font-size: 0.92em; font-family: 'Fira Code', Monaco, Consolas, monospace;
}

:deep(.article-content pre) {
  position: relative; margin: 0; padding: 0 1.15rem 1.1rem 1.15rem;
  overflow-x: auto;
  background: transparent; border: none; border-radius: 0;
  box-shadow: none;
}

:deep(.article-content pre code) {
  display: block; padding: 0; border: 0; background: transparent;
  color: var(--ct-pre-code); font-size: 0.92rem; line-height: 1.75;
  font-family: 'Fira Code', Monaco, Consolas, monospace; white-space: pre;
}

:deep(.article-content table) {
  display: block; width: 100%; margin: 1.5rem 0; overflow-x: auto;
  border-collapse: separate; border-spacing: 0;
  border: 1px solid var(--ct-table-border); border-radius: 14px;
}

:deep(.article-content th),
:deep(.article-content td) {
  padding: 0.82rem 1rem;
  border-right: 1px solid var(--ct-td-border); border-bottom: 1px solid var(--ct-td-border);
  text-align: left; white-space: nowrap;
}

:deep(.article-content th) {
  background: var(--ct-th-bg); color: var(--ct-th-color); font-weight: 800;
}

:deep(.article-content tr:nth-child(2n) td) { background: var(--ct-tr-stripe); }

:deep(.article-content hr) {
  height: 1px; margin: 2.25rem 0; border: 0; background: var(--ct-hr);
}
</style>

<style>
html.dark .article-content { color: #cbd5e1; }
html.dark .article-content h1,
html.dark .article-content h2,
html.dark .article-content h3,
html.dark .article-content h4,
html.dark .article-content h5,
html.dark .article-content h6 { color: #f8fafc; }
html.dark .article-content h3,
html.dark .article-content h4 { color: #e2e8f0; }
html.dark .article-content h5,
html.dark .article-content h6 { color: #cbd5e1; }
html.dark .article-content p { color: #cbd5e1; }
html.dark .article-content strong { color: #cbd5e1; }
html.dark .article-content em { color: #539dfd; }
html.dark .article-content a { color: #539dfd; }
html.dark .article-content blockquote {
  color: #cbd5e1;
  border-color: rgba(255,255,255,0.08);
  border-left-color: #539dfd;
  background: linear-gradient(135deg, rgba(83,157,253,0.12), rgba(255,255,255,0.03));
}
html.dark .article-content blockquote::before { color: rgba(83,157,253,0.15); }
html.dark .article-content li { color: #cbd5e1; }
html.dark .article-content ul > li::before { background: #539dfd; }
html.dark .article-content h2 { border-bottom-color: rgba(83,157,253,0.18); }
html.dark .article-content h2::before { background: linear-gradient(180deg, #539dfd, #539dfd); }
html.dark .article-content h3::before { color: #539dfd; }
html.dark .article-content code:not(pre code) {
  color: #539dfd;
  background: rgba(83,157,253,0.1);
  border-color: rgba(255,255,255,0.08);
}
html.dark .article-content pre { background: linear-gradient(145deg, #111827, #1e293b); }
html.dark .article-content pre code { color: #cbd5e1; }
html.dark .article-content pre::after {
  color: #539dfd;
  border-color: rgba(83,157,253,0.14);
  background: rgba(83,157,253,0.08);
}
html.dark .article-content hr { background: linear-gradient(90deg, transparent, rgba(83,157,253,0.45), transparent); }
html.dark .article-content th { color: #cbd5e1; }
html.dark .article-content img {
  border-color: rgba(83,157,253,0.14);
  box-shadow: 0 16px 48px rgba(83,157,253,0.08);
}
html.dark .article-content img:hover {
  box-shadow: 0 22px 64px rgba(83,157,253,0.12);
}

html.dark .code-lang-label {
  color: #539dfd;
  font-weight: 400;
}

html.dark .code-copy-btn {
  color: #539dfd;
}

html.dark .code-copy-btn:hover {
  background: rgba(83, 157, 253, 0.08);
}

html.dark .code-block-wrapper {
  box-shadow: 0 18px 48px rgba(83, 157, 253, 0.12);
}

.code-block-wrapper {
  margin: 1.7rem 0;
  border: 1px solid rgba(255, 255, 255, 0.08); border-radius: 18px;
  background: var(--ct-pre-bg); box-shadow: 0 18px 48px var(--ct-pre-shadow);
  overflow: hidden;
}

.code-block-header {
  display: flex; align-items: center; justify-content: center;
  height: 2.2rem; padding: 0 1rem;
  position: relative;
}

.code-block-dots {
  position: absolute; left: 1.05rem; top: 50%; transform: translateY(-50%);
  display: flex; gap: 0.43rem;
}

.code-block-dots span {
  width: 0.72rem; height: 0.72rem; border-radius: 50%;
}

.code-block-dots span:nth-child(1) { background: #ff5f56; }
.code-block-dots span:nth-child(2) { background: #ffbd2e; }
.code-block-dots span:nth-child(3) { background: #27c93f; }

.code-lang-label {
  font-size: 0.72rem; letter-spacing: 0.06em;
  color: var(--ct-pre-lang-color);
}

.code-copy-btn {
  position: absolute; right: 1rem; top: 50%; transform: translateY(-50%);
  display: flex; align-items: center; justify-content: center;
  width: 2rem; height: 2rem; border-radius: 8px;
  border: none; background: transparent; cursor: pointer;
  color: var(--ct-pre-lang-color); opacity: 0.6;
  transition: opacity 0.2s, background 0.2s;
}

.code-copy-btn:hover {
  opacity: 1; background: var(--ct-pre-lang-bg);
}
</style>
