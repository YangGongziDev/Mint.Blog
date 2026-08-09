<script setup lang="ts">
import { computed, nextTick, onActivated, onBeforeUnmount, onMounted, ref, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import {
  CalendarOutlined,
  ClockCircleOutlined,
  CopyrightOutlined,
  EditOutlined,
  EyeOutlined,
  FileTextOutlined,
  FolderOutlined,
  LeftOutlined,
  LinkOutlined,
  RightOutlined
} from '@ant-design/icons-vue';
import hljs from 'highlight.js';
import { getArticleDetail } from '@/service/blog/surfer/article';
import { getBlogSettingsDetail } from '@/service/blog/surfer/setting';
import { useTabStore } from '@/store/system/tab';
import { useBannerImage } from '@/hooks/blog/use-banner-image';
import { formatDateTime } from '@/utils/date-time';
import bannerDefaultImg from '@/assets/blog/surfer/article-banner/banner-default.jpg';
import SurferComment from '@/components/blog/surfer/comment.vue';
import Slide from '@/components/blog/surfer/slide.vue';
import SurferToc from '@/components/blog/surfer/toc.vue';

defineOptions({ name: 'SurferArticleDetailPage' });

type Tag = { id?: number; name?: string };
type Article = {
  id?: string;
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
  preArticle?: { articleId: number; articleTitle: string };
  nextArticle?: { articleId: number; articleTitle: string };
};

type BlogSettings = {
  copyrightDeclaration?: string;
};

const route = useRoute();
const router = useRouter();
const tabStore = useTabStore();

const article = ref<Article>({});
const typedArticleTitle = ref('');
const blogSettings = ref<BlogSettings>({});
const loading = ref(true);
const articleNotFound = ref(false);
const articleContentRef = ref<HTMLElement | null>(null);
const previewImageSrc = ref('');
const previewImageAlt = ref('');
const desktopTocVisible = ref(true);
const mobileTocVisible = ref(false);
const mobileTocRenderKey = ref(0);
const isMobile = ref(false);
const articleDetailImages = Object.values(
  import.meta.glob('@/assets/blog/surfer/article-banner/*.{png,jpg,jpeg,webp,avif,gif}', {
    eager: true,
    import: 'default'
  })
) as string[];

const currentArticleUrl = computed(() => window.location.href);
const copyrightDeclaration = computed(() => {
  const declaration = blogSettings.value.copyrightDeclaration?.trim();

  if (declaration) return declaration;

  const year = article.value.createTime ? new Date(article.value.createTime).getFullYear() : new Date().getFullYear();

  return `© ${year} 保留所有权利，转载请注明出处和原文链接。`;
});
const renderedContent = computed(() => renderMarkdown(article.value.content || ''));
const hasTocHeadings = computed(() => /^#{1,6}\s+\S+/m.test(article.value.content || ''));
const {
  imageKey: heroImageKey,
  resolved: heroResolved,
  imageSrc: articleHeroImageSrc,
  resolveInitialImage: resolveInitialHeroImage,
  pickImage: pickHeroImage,
  schedulePreloadAfterRender: scheduleBannerPreloadAfterRender,
  stopPreload: stopBannerPreload
} = useBannerImage({
  images: articleDetailImages,
  fallbackImage: bannerDefaultImg,
  storageNamespace: 'blog-surfer:article-detail-hero'
});
let hasSkippedInitialActivated = false;
let articleTitleTypingTimer: ReturnType<typeof setTimeout> | null = null;
function typeArticleTitle(title?: string) {
  if (articleTitleTypingTimer) clearTimeout(articleTitleTypingTimer);
  articleTitleTypingTimer = null;
  typedArticleTitle.value = '';

  const chars = Array.from(title || '');
  let index = 0;

  function tick() {
    index += 1;
    typedArticleTitle.value = chars.slice(0, index).join('');

    if (index < chars.length) {
      articleTitleTypingTimer = setTimeout(tick, 80);
    }
  }

  if (chars.length) {
    articleTitleTypingTimer = setTimeout(tick, 80);
  }
}

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
  javascript: 'JavaScript',
  js: 'JavaScript',
  typescript: 'TypeScript',
  ts: 'TypeScript',
  python: 'Python',
  py: 'Python',
  java: 'Java',
  csharp: 'C#',
  cs: 'C#',
  'c#': 'C#',
  cpp: 'C++',
  'c++': 'C++',
  cxx: 'C++',
  c: 'C',
  go: 'Go',
  golang: 'Go',
  rust: 'Rust',
  rs: 'Rust',
  php: 'PHP',
  ruby: 'Ruby',
  rb: 'Ruby',
  swift: 'Swift',
  kotlin: 'Kotlin',
  kt: 'Kotlin',
  scala: 'Scala',
  dart: 'Dart',
  objectivec: 'Objective-C',
  objc: 'Objective-C',
  'objective-c': 'Objective-C',
  html: 'HTML',
  css: 'CSS',
  scss: 'SCSS',
  sass: 'Sass',
  less: 'Less',
  json: 'JSON',
  xml: 'XML',
  yaml: 'YAML',
  yml: 'YAML',
  sql: 'SQL',
  bash: 'Bash',
  sh: 'Bash',
  shell: 'Shell',
  zsh: 'Zsh',
  powershell: 'PowerShell',
  ps1: 'PowerShell',
  dockerfile: 'Dockerfile',
  docker: 'Dockerfile',
  makefile: 'Makefile',
  graphql: 'GraphQL',
  gql: 'GraphQL',
  markdown: 'Markdown',
  md: 'Markdown',
  text: 'Text',
  txt: 'Text',
  plain: 'Text',
  plaintext: 'Text',
  vbnet: 'VB.NET',
  'vb.net': 'VB.NET',
  fsharp: 'F#',
  fs: 'F#',
  'f#': 'F#',
  lua: 'Lua',
  r: 'R',
  perl: 'Perl',
  elixir: 'Elixir',
  haskell: 'Haskell',
  hs: 'Haskell',
  clojure: 'Clojure',
  groovy: 'Groovy',
  erlang: 'Erlang',
  matlab: 'MATLAB',
  assembly: 'Assembly',
  asm: 'Assembly',
  nginx: 'Nginx',
  ini: 'INI',
  toml: 'TOML',
  env: '.env',
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
  latex: 'LaTeX',
  tex: 'LaTeX'
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

function splitMarkdownTableRow(row: string) {
  const normalized = row.trim().replace(/^\|/, '').replace(/\|$/, '');
  return normalized.split('|').map(cell => cell.trim());
}

function isMarkdownTableRow(line: string) {
  const cells = splitMarkdownTableRow(line);
  return line.includes('|') && cells.length >= 2;
}

function isMarkdownTableSeparator(line: string) {
  const cells = splitMarkdownTableRow(line);
  return cells.length > 0 && cells.every(cell => /^:?-+:?$/.test(cell.replace(/\s+/g, '')));
}

function getTableAlignments(separatorLine: string) {
  return splitMarkdownTableRow(separatorLine).map(cell => {
    const normalized = cell.replace(/\s+/g, '');
    if (normalized.startsWith(':') && normalized.endsWith(':')) return 'center';
    if (normalized.endsWith(':')) return 'right';
    return 'left';
  });
}

function renderTable(headerLine: string, separatorLine: string, rowLines: string[]) {
  const headers = splitMarkdownTableRow(headerLine);
  const alignments = getTableAlignments(separatorLine);
  const alignStyle = (index: number) => ` style="text-align: ${alignments[index] || 'left'}"`;
  const thead = `<thead><tr>${headers
    .map((cell, index) => `<th${alignStyle(index)}>${renderInlineMarkdown(cell)}</th>`)
    .join('')}</tr></thead>`;
  const tbody = rowLines.length
    ? `<tbody>${rowLines
        .map(row => {
          const cells = splitMarkdownTableRow(row);
          return `<tr>${headers
            .map((_, index) => `<td${alignStyle(index)}>${renderInlineMarkdown(cells[index] || '')}</td>`)
            .join('')}</tr>`;
        })
        .join('')}</tbody>`
    : '';

  return `<div class="markdown-table-wrapper"><table>${thead}${tbody}</table></div>`;
}

type MarkdownTableBlock = {
  html: string;
  endIndex: number;
};

function parseMarkdownTable(lines: string[], startIndex: number): MarkdownTableBlock | null {
  const headerLine = lines[startIndex]?.trim() || '';
  const separatorLine = lines[startIndex + 1]?.trim() || '';

  if (!isMarkdownTableRow(headerLine) || !isMarkdownTableSeparator(separatorLine)) return null;

  const rowLines: string[] = [];
  let rowIndex = startIndex + 2;

  while (rowIndex < lines.length && isMarkdownTableRow((lines[rowIndex] || '').trim())) {
    rowLines.push((lines[rowIndex] || '').trim());
    rowIndex += 1;
  }

  return {
    html: renderTable(headerLine, separatorLine, rowLines),
    endIndex: rowIndex - 1
  };
}

function isStandaloneStrongLine(line: string) {
  return /^(\*\*[^*]+\*\*|__[^_]+__)$/.test(line.trim());
}

function getMarkdownIndentLevel(line: string) {
  const leadingWhitespace = line.match(/^\s*/)?.[0] || '';
  const spaces = leadingWhitespace.replace(/\t/g, '    ').length;
  return Math.floor(spaces / 2);
}

function renderMarkdown(markdown: string) {
  const hardBreakMark = '\uE000';
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
    html.push(`<p>${renderInlineMarkdown(paragraph.join(' ')).replaceAll(hardBreakMark, '<br />')}</p>`);
    paragraph = [];
  };

  const flushList = () => {
    if (!listType) return;
    html.push(`<${listType}>${listItems.join('')}</${listType}>`);
    listItems = [];
    listType = null;
  };

  for (let index = 0; index < lines.length; index += 1) {
    const line = lines[index] || '';
    const hasHardBreak = / {2,}$/.test(line);
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
      const tableBlock = parseMarkdownTable(lines, index);

      if (tableBlock) {
        flushParagraph();
        flushList();
        html.push(tableBlock.html);
        index = tableBlock.endIndex;
      } else if (headingMatch) {
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
        const indent = getMarkdownIndentLevel(line);
        listItems.push(`<li style="margin-left: ${indent * 1.5}rem">${renderInlineMarkdown(unorderedMatch[1])}</li>`);
      } else if (orderedMatch) {
        flushParagraph();
        if (listType && listType !== 'ol') flushList();
        listType = 'ol';
        const indent = getMarkdownIndentLevel(line);
        listItems.push(`<li style="margin-left: ${indent * 1.5}rem">${renderInlineMarkdown(orderedMatch[1])}</li>`);
      } else if (isStandaloneStrongLine(trimmed)) {
        flushParagraph();
        flushList();
        html.push(`<p>${renderInlineMarkdown(trimmed)}</p>`);
      } else {
        paragraph.push(hasHardBreak ? `${trimmed}${hardBreakMark}` : trimmed);
      }
    }
  }

  if (inCodeBlock) html.push(renderCodeBlock(codeLines.join('\n'), codeLanguage));
  flushParagraph();
  flushList();

  let headingLevel = 0;
  return html
    .map(block => {
      const headingMatch = block.match(/^<h([1-6])>/);
      if (headingMatch) headingLevel = Number(headingMatch[1]);

      if (!headingLevel) return block;
      const indent = Math.max(0, headingLevel - 1) * 1.5;
      return `<div class="markdown-section-content" style="margin-left: ${indent}rem">${block}</div>`;
    })
    .join('\n');
}

function updateIsMobile() {
  isMobile.value = window.innerWidth < 768;

  if (!isMobile.value) {
    mobileTocVisible.value = false;
  }
}

function handleToggleToc() {
  if (!article.value.content || articleNotFound.value || !hasTocHeadings.value) return;

  if (isMobile.value) {
    mobileTocVisible.value = !mobileTocVisible.value;

    if (mobileTocVisible.value) {
      mobileTocRenderKey.value += 1;
      nextTick(() => {
        window.dispatchEvent(new Event('resize'));
        window.dispatchEvent(new CustomEvent('blog-surfer:toc-opened'));
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

function openArticleImagePreview(image: HTMLImageElement) {
  if (!image.currentSrc && !image.src) return;
  previewImageSrc.value = image.currentSrc || image.src;
  previewImageAlt.value = image.alt || '文章图片预览';
}

function closeArticleImagePreview() {
  previewImageSrc.value = '';
  previewImageAlt.value = '';
}

function handleArticleContentClick(event: MouseEvent) {
  const target = event.target;
  if (!(target instanceof HTMLImageElement)) return;

  event.preventDefault();
  openArticleImagePreview(target);
}

function handleImagePreviewKeydown(event: KeyboardEvent) {
  if (event.key === 'Escape') closeArticleImagePreview();
}

function goTagArticleListPage(tagId: number, tagName: string) {
  router.push({ path: '/blog/surfer/tag', query: { id: String(tagId), name: tagName } });
}

function goCategoryArticleListPage(categoryId: number, categoryName: string) {
  router.push({ path: '/blog/surfer/category', query: { id: String(categoryId), name: categoryName } });
}

async function loadBlogSettings() {
  try {
    const res = await getBlogSettingsDetail<{ success: boolean; data: BlogSettings }>();
    if (res.success) blogSettings.value = res.data || {};
  } catch {
    blogSettings.value = {};
  }
}

async function loadArticle(articleId: string | number) {
  loading.value = true;
  closeArticleImagePreview();
  try {
    const res = await getArticleDetail<{ success: boolean; data: Article; errorCode?: string }>(articleId);
    if (!res.success && res.errorCode === '20010') {
      articleNotFound.value = true;
      typedArticleTitle.value = '';
      return;
    }
    article.value = res.data || {};
    typeArticleTitle(article.value.title);
    if (article.value.title) {
      tabStore.setTabLabel(article.value.title);
      document.title = `${article.value.title} - ${import.meta.env.VITE_APP_TITLE}`;
    }
    articleNotFound.value = false;

    nextTick(() => {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  } catch {
    article.value = {};
    typedArticleTitle.value = '';
    articleNotFound.value = true;
  } finally {
    loading.value = false;
    await scheduleBannerPreloadAfterRender();
  }
}

watch(
  () => route.params.id,
  async id => {
    if (id) {
      pickHeroImage(true);
      await loadArticle(id as string);
    }
  }
);

onMounted(() => {
  updateIsMobile();
  window.addEventListener('resize', updateIsMobile);
  window.addEventListener('keydown', handleImagePreviewKeydown);
  window.addEventListener('blog-surfer:toggle-toc', handleToggleToc);

  loadBlogSettings().catch(() => undefined);
  resolveInitialHeroImage().catch(() => undefined);
  const articleId = route.params.id as string;
  if (articleId) loadArticle(articleId).catch(() => undefined);
});

onBeforeUnmount(() => {
  stopBannerPreload();
  window.removeEventListener('resize', updateIsMobile);
  window.removeEventListener('keydown', handleImagePreviewKeydown);
  window.removeEventListener('blog-surfer:toggle-toc', handleToggleToc);
  if (articleTitleTypingTimer) clearTimeout(articleTitleTypingTimer);
});

onActivated(() => {
  if (!hasSkippedInitialActivated) {
    hasSkippedInitialActivated = true;
    return;
  }

  pickHeroImage();
});
</script>

<template>
  <div>
    <Slide :key="heroImageKey" :src="articleHeroImageSrc" :loading="!heroResolved" class="article-hero">
      <template #skeleton>
        <div class="article-hero-skeleton" aria-hidden="true">
          <div class="article-hero-skeleton-cover"></div>
          <div class="article-hero-skeleton-body">
            <div class="article-hero-skeleton-line article-hero-skeleton-title"></div>
            <div class="article-hero-skeleton-meta">
              <span></span>
              <span></span>
              <span></span>
            </div>
            <div class="article-hero-skeleton-info">
              <span></span>
              <span></span>
              <span></span>
              <span></span>
            </div>
          </div>
        </div>
      </template>

      <div
        class="article-hero-inner mx-auto flex h-full max-w-screen-2xl items-center justify-center px-4 text-white md:px-6"
      >
        <div v-if="loading" class="w-full max-w-3xl animate-pulse space-y-5 text-center">
          <div class="mx-auto h-10 w-3/4 rounded-xl bg-white/20"></div>
          <div class="mx-auto flex justify-center gap-3">
            <div v-for="i in 3" :key="i" class="h-7 w-20 rounded-full bg-white/16"></div>
          </div>
          <div class="mx-auto flex justify-center gap-5">
            <div v-for="i in 4" :key="i" class="h-5 w-24 rounded bg-white/12"></div>
          </div>
        </div>

        <div
          v-else-if="articleNotFound"
          class="flex flex-col items-center justify-center text-center custom-text-shadow"
        >
          <div class="text-7xl font-black text-white/50">404</div>
          <h2 class="mt-4 text-2xl font-bold text-white">文章不存在</h2>
          <p class="mt-2 text-sm text-white/78">该文章可能已被删除或链接地址错误</p>
          <RouterLink
            to="/blog/surfer/home"
            class="mt-6 inline-flex rounded-full bg-[#3ecf9a] px-6 py-2.5 text-sm font-semibold text-white hover:bg-[#15956b] dark:bg-[#539dfd] dark:hover:bg-[#8cc8ff]"
          >
            返回首页
          </RouterLink>
        </div>

        <template v-else>
          <div class="article-hero-content w-full max-w-5xl text-center custom-text-shadow md:-translate-y-8">
            <h1
              :key="article.title"
              class="article-typing-title mb-5 text-3xl font-bold leading-tight text-white sm:mb-8 sm:text-4xl md:text-5xl"
            >
              <span class="article-typed-title-text">{{ typedArticleTitle }}</span>
              <!--
              -->
              <span class="article-title-cursor">|</span>
            </h1>

            <div
              v-if="article.tags && article.tags.length > 0"
              class="mb-4 flex flex-wrap justify-center gap-2 sm:mb-5"
            >
              <ATooltip v-for="tag in article.tags" :key="tag.id" title="标签">
                <button
                  class="inline-flex cursor-pointer rounded-full bg-white/18 px-3 py-1 text-sm font-medium text-white backdrop-blur-sm transition-all hover:-translate-y-0.5 hover:bg-white/26"
                  @click="goTagArticleListPage(tag.id!, tag.name!)"
                >
                  # {{ tag.name }}
                </button>
              </ATooltip>
            </div>

            <div
              class="mx-auto flex max-w-4xl flex-wrap items-center justify-center gap-x-4 gap-y-2 text-xs text-white/90 sm:gap-x-6 sm:gap-y-3 sm:text-sm"
            >
              <ATooltip title="分类">
                <div class="flex items-center">
                  <span class="hero-meta-icon bg-[#4fa759]"><FolderOutlined /></span>
                  <button
                    class="cursor-pointer hover:underline"
                    @click="goCategoryArticleListPage(article.categoryId!, article.categoryName!)"
                  >
                    {{ article.categoryName }}
                  </button>
                </div>
              </ATooltip>
              <ATooltip title="发布时间">
                <div class="flex items-center">
                  <span class="hero-meta-icon bg-[#ea3b24]"><CalendarOutlined /></span>
                  {{ formatDateTime(article.createTime) }}
                </div>
              </ATooltip>
              <ATooltip title="阅读人次">
                <div class="flex items-center">
                  <span class="hero-meta-icon bg-[#f59e0b]"><EyeOutlined /></span>
                  {{ article.readNum }}
                </div>
              </ATooltip>
              <ATooltip title="总字数">
                <div class="flex items-center">
                  <span class="hero-meta-icon bg-[#a543e6]"><FileTextOutlined /></span>
                  {{ article.totalWords }} 字
                </div>
              </ATooltip>
              <ATooltip title="阅读耗时">
                <div class="flex items-center">
                  <span class="hero-meta-icon bg-[#5a9cf8]"><ClockCircleOutlined /></span>
                  {{ article.readTime }}
                </div>
              </ATooltip>
            </div>
          </div>
        </template>
      </div>
    </Slide>

    <main class="mx-auto max-w-screen-2xl px-1 py-1 md:px-6">
      <ARow :gutter="[28, 28]">
        <ACol :xs="24" :md="desktopTocVisible && hasTocHeadings ? 18 : 24" class="min-h-0">
          <div v-if="!loading && !articleNotFound && article.content" class="mb-3">
            <div
              class="rounded-lg border border-[#3ecf9a]/14 bg-white/84 p-2 mb-3 dark:border-[#334155] dark:bg-[#2c333e]/72"
            >
              <article>
                <div>
                  <div
                    ref="articleContentRef"
                    class="mt-5 leading-relaxed article-content"
                    @click="handleArticleContentClick"
                    v-html="renderedContent"
                  ></div>
                </div>

                <div class="flex items-center text-sm mt-5 mb-5 text-[#557468] dark:text-[#cbd5e1]">
                  <EditOutlined class="icon inline-block w-4 h-4 mr-1" />
                  最后编辑于 {{ formatDateTime(article.updateTime) }}
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

                <nav class="flex justify-between mt-7">
                  <button
                    v-if="article.preArticle"
                    class="cursor-pointer flex flex-col h-full p-4 text-base font-medium text-[#557468] bg-white border border-gray-200 rounded-lg hover:border-[#3ecf9a] hover:bg-[#f0faf5] hover:text-[#3ecf9a] dark:bg-[#2c333e]/72 dark:border-[#334155] dark:text-[#cbd5e1] dark:hover:bg-[white/8] dark:hover:text-white transition-colors max-w-[48%]"
                    @click="router.push('/blog/surfer/article/' + article.preArticle.articleId)"
                  >
                    <div>
                      <LeftOutlined class="inline w-3.5 h-3.5 mr-2 mb-1" />
                      上一篇
                    </div>
                    <div class="line-clamp-1">{{ article.preArticle.articleTitle }}</div>
                  </button>
                  <div v-if="!article.preArticle" />
                  <button
                    v-if="article.nextArticle"
                    class="cursor-pointer flex flex-col h-full text-right p-4 text-base font-medium text-[#557468] bg-white border border-gray-200 rounded-lg hover:border-[#3ecf9a] hover:bg-[#f0faf5] hover:text-[#3ecf9a] dark:bg-[#2c333e]/72 dark:border-[#334155] dark:text-[#cbd5e1] dark:hover:bg-[white/8] dark:hover:text-white transition-colors max-w-[48%] ml-auto"
                    @click="router.push('/blog/surfer/article/' + article.nextArticle.articleId)"
                  >
                    <div>
                      下一篇
                      <RightOutlined class="inline w-3.5 h-3.5 ml-2 mb-1" />
                    </div>
                    <div class="line-clamp-1">{{ article.nextArticle.articleTitle }}</div>
                  </button>
                </nav>
              </article>
            </div>
            <SurferComment />
          </div>
        </ACol>

        <ACol v-show="desktopTocVisible && hasTocHeadings" :xs="0" :md="6">
          <SurferToc :header-offset="150" />
        </ACol>
      </ARow>
    </main>

    <div
      v-if="previewImageSrc"
      class="article-image-preview"
      role="dialog"
      aria-modal="true"
      :aria-label="previewImageAlt"
      @click.self="closeArticleImagePreview"
    >
      <button
        class="article-image-preview-close"
        type="button"
        aria-label="关闭图片预览"
        @click="closeArticleImagePreview"
      >
        ×
      </button>
      <img :src="previewImageSrc" :alt="previewImageAlt" class="article-image-preview-img" />
    </div>

    <ADrawer
      v-model:open="mobileTocVisible"
      title="文章目录"
      placement="right"
      width="86%"
      class="article-mobile-toc-drawer"
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
.article-hero-skeleton {
  position: absolute;
  inset: 0;
  overflow: hidden;
  display: flex;
  align-items: stretch;
  border: 1px solid rgb(62 207 154 / 28%);
  background:
    radial-gradient(circle at 6% 0%, rgb(62 207 154 / 9%), transparent 38%),
    linear-gradient(135deg, rgb(255 255 255 / 96%), rgb(247 255 251 / 92%));
  animation: pulse 1.6s ease-in-out infinite;
}

.article-hero-skeleton-cover {
  width: 42%;
  min-width: 42%;
  background: linear-gradient(135deg, rgb(62 207 154 / 13%), rgb(62 207 154 / 5%));
  clip-path: polygon(0 0, 90% 0, 100% 100%, 0 100%);
}

.article-hero-skeleton-body {
  display: flex;
  min-width: 0;
  flex: 1;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap: 18px;
  padding: 24px 32px;
}

.article-hero-skeleton-line,
.article-hero-skeleton-meta span,
.article-hero-skeleton-info span {
  display: block;
  border-radius: 999px;
  background: rgb(62 207 154 / 12%);
}

.article-hero-skeleton-title {
  width: min(56%, 420px);
  height: 34px;
}

.article-hero-skeleton-meta,
.article-hero-skeleton-info {
  display: flex;
  justify-content: center;
  gap: 12px;
  width: 100%;
  flex-wrap: wrap;
}

.article-hero-skeleton-meta span {
  width: 78px;
  height: 28px;
}

.article-hero-skeleton-info span {
  width: 96px;
  height: 18px;
}

.custom-text-shadow {
  text-shadow: 0 4px 22px rgb(0 0 0 / 55%);
}

.article-hero-content {
  transform: translateY(-18px);
}

@media (max-width: 767px) {
  .article-hero-content {
    transform: translateY(-30px);
  }
}

.article-typing-title {
  display: inline-block;
  max-width: 100%;
  min-height: 1.2em;
  white-space: normal;
  word-break: break-word;
}

.article-typed-title-text {
  display: inline;
}

.hero-meta-icon {
  display: inline-flex;
  width: 20px;
  height: 20px;
  align-items: center;
  justify-content: center;
  margin-right: 6px;
  border-radius: 999px;
  color: #fff;
  font-size: 12px;
  box-shadow: 0 6px 16px rgb(0 0 0 / 24%);
}

.article-title-cursor {
  margin-left: 0.08em;
  animation: article-title-cursor-blink 0.86s step-end infinite;
}

@keyframes article-title-cursor-blink {
  0%,
  45% {
    opacity: 1;
  }

  46%,
  100% {
    opacity: 0;
  }
}

@media (max-width: 768px) {
  .article-typing-title {
    font-size: 1.75rem;
  }

  .article-hero-skeleton-cover {
    width: 34%;
    min-width: 34%;
  }

  .article-hero-skeleton-body {
    gap: 14px;
    padding: 20px 18px;
  }

  .article-hero-skeleton-title {
    width: min(72%, 280px);
    height: 28px;
  }
}

:deep(.article-content) {
  --ct-text: #49695d;
  --ct-heading: #3ecf9a;
  --ct-heading3: #3ecf9a;
  --ct-heading4: #3ecf9a;
  --ct-heading5: #3ecf9a;
  --ct-heading6: #3ecf9a;
  --ct-accent: #15956b;
  --ct-link: #15956b;
  --ct-link-hover: #15956b;
  --ct-link-underline: rgba(24, 181, 127, 0.32);
  --ct-strong: #3ecf9a;
  --ct-border: rgba(62, 207, 154, 0.18);
  --ct-border3: rgba(62, 207, 154, 0.16);
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
  --ct-h3-before: #3ecf9a;
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
  font-family:
    -apple-system,
    BlinkMacSystemFont,
    PingFang SC,
    Hiragino Sans GB,
    Microsoft Yahei,
    Arial,
    sans-serif;
}

:deep(html.dark .article-content) {
  --ct-text: #cbd5e1;
  --ct-heading: #f8fafc;
  --ct-heading3: #e2e8f0;
  --ct-heading4: #e2e8f0;
  --ct-heading5: #cbd5e1;
  --ct-heading6: #cbd5e1;
  --ct-accent: #539dfd;
  --ct-link: #539dfd;
  --ct-link-hover: #60a5fa;
  --ct-link-underline: rgba(83, 157, 253, 0.32);
  --ct-strong: #cbd5e1;
  --ct-border: rgba(83, 157, 253, 0.18);
  --ct-border3: rgba(83, 157, 253, 0.16);
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
  --ct-h3-before: #539dfd;
  --ct-del: #94a3b8;
  --ct-del-line: rgba(83, 157, 253, 0.4);
  --ct-copy-hover: rgba(83, 157, 253, 0.12);
  --ct-tr-stripe: rgba(83, 157, 253, 0.04);
  --ct-th-bg: rgba(83, 157, 253, 0.1);
  --ct-th-color: #cbd5e1;
  --ct-table-border: rgba(83, 157, 253, 0.16);
  --ct-td-border: rgba(83, 157, 253, 0.13);
}

:deep(.article-content > *:first-child) {
  margin-top: 0 !important;
}

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
:deep(.article-content h4) {
  color: var(--ct-heading3);
}
:deep(.article-content h5),
:deep(.article-content h6) {
  color: var(--ct-heading5);
}

:deep(.article-content h1) {
  margin: 2.2em 0 0.8em;
  font-size: 2.1rem;
}

:deep(.article-content h2) {
  display: flex;
  align-items: center;
  gap: 0.7rem;
  margin: 2.4em 0 1em;
  padding-bottom: 0.75rem;
  border-bottom: 1px solid var(--ct-h2-border);
  font-size: 1.65rem;
}

:deep(.article-content h2::before) {
  content: '';
  width: 0.34rem;
  height: 1.45rem;
  border-radius: 999px;
  background: var(--ct-h2-before);
  box-shadow: 0 0 18px var(--ct-h2-before-shadow);
}

:deep(.article-content h3) {
  margin: 2em 0 0.85em;
  font-size: 1.32rem;
}

:deep(.article-content h3::before) {
  content: '#';
  margin-right: 0.45rem;
  color: var(--ct-h3-before);
  font-weight: 900;
}

:deep(.article-content h4) {
  margin: 1.6em 0 0.7em;
  font-size: 1.16rem;
}
:deep(.article-content h5),
:deep(.article-content h6) {
  margin: 1.4em 0 0.65em;
  font-size: 1rem;
}

:deep(.article-content p) {
  margin: 0 0 1.25rem;
  color: var(--ct-text);
}

:deep(.article-content strong) {
  color: var(--ct-strong);
  font-weight: 800;
}

:deep(.article-content em) {
  color: var(--ct-accent);
  font-style: italic;
}

:deep(.article-content del) {
  color: var(--ct-del);
  text-decoration-color: var(--ct-del-line);
}

:deep(.article-content a) {
  color: var(--ct-link);
  font-weight: 650;
  text-decoration: none;
  border-bottom: 1px dashed var(--ct-link-underline);
  transition:
    color 0.2s ease,
    border-color 0.2s ease,
    background-color 0.2s ease;
}

:deep(.article-content a:hover) {
  color: var(--ct-link-hover);
  border-bottom-color: transparent;
  background: var(--ct-bg-code);
}

:deep(.article-content blockquote) {
  position: relative;
  margin: 1.6rem 0;
  padding: 1.1rem 1.25rem 1.1rem 1.45rem;
  overflow: hidden;
  border: 1px solid var(--ct-border);
  border-left: 4px solid var(--ct-blockquote-border);
  border-radius: 10px;
  background: var(--ct-bg-blockquote);
  color: var(--ct-text);
}

:deep(.article-content blockquote::before) {
  content: '\201c';
  position: absolute;
  right: 1rem;
  top: -0.35rem;
  color: var(--ct-blockquote-quote);
  font-size: 4rem;
  font-weight: 900;
  line-height: 1;
}

:deep(.article-content blockquote p) {
  margin-bottom: 0;
}

:deep(.article-content ul),
:deep(.article-content ol) {
  margin: 1rem 0 1.35rem;
  padding-left: 1.4rem;
}
:deep(.article-content ul) {
  list-style: none;
}
:deep(.article-content ol) {
  list-style-position: outside;
}
:deep(.article-content li) {
  margin: 0.42rem 0;
  padding-left: 0.2rem;
  color: var(--ct-text);
}

:deep(.article-content ul > li) {
  position: relative;
  padding-left: 1.05rem;
}

:deep(.article-content ul > li::before) {
  content: '';
  position: absolute;
  left: 0;
  top: 0.78em;
  width: 0.42rem;
  height: 0.42rem;
  border-radius: 999px;
  background: var(--ct-bullet);
  box-shadow: 0 0 0 4px var(--ct-bullet-shadow);
}

:deep(.article-content img) {
  display: block;
  max-width: 100%;
  margin: 1.75rem 0;
  border: 1px solid var(--ct-img-border);
  border-radius: 18px;
  box-shadow: 0 16px 48px var(--ct-img-shadow);
  cursor: zoom-in;
  transition:
    transform 0.25s ease,
    box-shadow 0.25s ease;
}

:deep(.article-content img:hover) {
  transform: translateY(-2px);
  box-shadow: 0 22px 64px var(--ct-img-shadow-hover);
}

.article-image-preview {
  position: fixed;
  inset: 0;
  z-index: 30000;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: max(16px, env(safe-area-inset-top)) max(12px, env(safe-area-inset-right))
    max(16px, env(safe-area-inset-bottom)) max(12px, env(safe-area-inset-left));
  background: rgb(0 0 0 / 86%);
  backdrop-filter: blur(10px);
}

.article-image-preview-img {
  max-width: min(96vw, 1280px);
  max-height: 92vh;
  object-fit: contain;
  border-radius: 12px;
  box-shadow: 0 24px 80px rgb(0 0 0 / 50%);
}

.article-image-preview-close {
  position: fixed;
  top: max(14px, env(safe-area-inset-top));
  right: max(14px, env(safe-area-inset-right));
  z-index: 1;
  display: inline-flex;
  width: 42px;
  height: 42px;
  align-items: center;
  justify-content: center;
  border: 1px solid rgb(255 255 255 / 18%);
  border-radius: 999px;
  background: rgb(255 255 255 / 12%);
  color: #fff;
  cursor: pointer;
  font-size: 30px;
  line-height: 1;
}

.article-image-preview-close:hover {
  background: rgb(255 255 255 / 22%);
}

@media (max-width: 767px) {
  .article-image-preview {
    padding: max(12px, env(safe-area-inset-top)) max(8px, env(safe-area-inset-right))
      max(12px, env(safe-area-inset-bottom)) max(8px, env(safe-area-inset-left));
  }

  .article-image-preview-img {
    max-width: 100%;
    max-height: 88vh;
    border-radius: 8px;
  }
}

:deep(.article-content code:not(pre code)) {
  padding: 0.16rem 0.38rem;
  margin: 0 0.12rem;
  border: 1px solid var(--ct-border3);
  border-radius: 7px;
  background: var(--ct-bg-code);
  color: var(--ct-accent);
  font-size: 0.92em;
  font-family: 'Fira Code', Monaco, Consolas, monospace;
}

:deep(.article-content pre) {
  position: relative;
  margin: 0;
  padding: 0 1.15rem 1.1rem 1.15rem;
  overflow-x: auto;
  background: transparent;
  border: none;
  border-radius: 0;
  box-shadow: none;
}

:deep(.article-content pre code) {
  display: block;
  padding: 0;
  border: 0;
  background: transparent;
  color: var(--ct-pre-code);
  font-size: 0.92rem;
  line-height: 1.75;
  font-family: 'Fira Code', Monaco, Consolas, monospace;
  white-space: pre;
}

:deep(.hljs-keyword),
:deep(.hljs-selector-tag),
:deep(.hljs-built_in),
:deep(.hljs-name) {
  color: #ff7ab2;
  font-weight: 700;
}

:deep(.hljs-string),
:deep(.hljs-regexp),
:deep(.hljs-symbol),
:deep(.hljs-bullet) {
  color: #a5e075;
}

:deep(.hljs-comment),
:deep(.hljs-quote) {
  color: #78908a;
  font-style: italic;
}

:deep(.hljs-number),
:deep(.hljs-literal) {
  color: #f6c177;
}

:deep(.hljs-title),
:deep(.hljs-section),
:deep(.hljs-function .hljs-title) {
  color: #82aaff;
  font-weight: 700;
}

:deep(.hljs-attr),
:deep(.hljs-attribute),
:deep(.hljs-variable),
:deep(.hljs-template-variable) {
  color: #f78c6c;
}

:deep(.hljs-type),
:deep(.hljs-class .hljs-title) {
  color: #c792ea;
  font-weight: 700;
}

:deep(.article-content .markdown-table-wrapper) {
  width: 100%;
  margin: 1.5rem 0;
  overflow-x: auto;
  border: 1px solid var(--ct-table-border);
  border-radius: 14px;
}

:deep(.article-content table) {
  width: 100%;
  min-width: max-content;
  border-collapse: separate;
  border-spacing: 0;
}

:deep(.article-content th),
:deep(.article-content td) {
  padding: 0.82rem 1rem;
  border-right: 1px solid var(--ct-td-border);
  border-bottom: 1px solid var(--ct-td-border);
  text-align: left;
  white-space: nowrap;
}

:deep(.article-content th:last-child),
:deep(.article-content td:last-child) {
  border-right: 0;
}

:deep(.article-content tbody tr:last-child td) {
  border-bottom: 0;
}

:deep(.article-content th) {
  background: var(--ct-th-bg);
  color: var(--ct-th-color);
  font-weight: 800;
}

:deep(.article-content tr:nth-child(2n) td) {
  background: var(--ct-tr-stripe);
}

:deep(.article-content hr) {
  height: 1px;
  margin: 2.25rem 0;
  border: 0;
  background: var(--ct-hr);
}

:deep(.copy-code-btn) {
  position: absolute;
  top: 0.72rem;
  right: 0.72rem;
  z-index: 5;
  display: flex;
  width: 2.25rem;
  height: 2.25rem;
  align-items: center;
  justify-content: center;
  padding: 0;
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 10px;
  background: rgba(255, 255, 255, 0.06);
  cursor: pointer;
  opacity: 0;
  transition:
    opacity 0.25s ease,
    background 0.2s ease;
}

:deep(pre:hover .copy-code-btn),
:deep(.copy-code-btn.block) {
  opacity: 1;
}

:deep(.copy-code-btn:hover),
:deep(.copied) {
  background: var(--ct-copy-hover);
}

:deep(.copy-icon) {
  width: 1.08rem;
  height: 1.08rem;
  color: #93a49b;
  transition: color 0.2s ease;
}

:deep(.copy-code-btn:hover .copy-icon),
:deep(.copied .copy-icon) {
  color: var(--ct-accent);
}

:deep(.copied::after) {
  content: '\5df2\590d\5236';
  position: absolute;
  right: 2.65rem;
  padding: 0.22rem 0.7rem;
  border: 1px solid var(--ct-border);
  border-radius: 999px;
  background: var(--ct-bg-code);
  color: var(--ct-accent);
  font-size: 0.75rem;
  font-weight: 700;
  white-space: nowrap;
}
</style>

<style>
html.dark .article-content {
  color: #cbd5e1;
}
html.dark .article-content h1,
html.dark .article-content h2,
html.dark .article-content h3,
html.dark .article-content h4,
html.dark .article-content h5,
html.dark .article-content h6 {
  color: #f8fafc;
}
html.dark .article-content h3,
html.dark .article-content h4 {
  color: #e2e8f0;
}
html.dark .article-content h5,
html.dark .article-content h6 {
  color: #cbd5e1;
}
html.dark .article-content p {
  color: #cbd5e1;
}
html.dark .article-content strong {
  color: #cbd5e1;
}
html.dark .article-content em {
  color: #539dfd;
}
html.dark .article-content del {
  color: #94a3b8;
}
html.dark .article-content a {
  color: #539dfd;
}
html.dark .article-content blockquote {
  color: #cbd5e1;
  border-color: rgba(255, 255, 255, 0.08);
  border-left-color: #539dfd;
  background: linear-gradient(135deg, rgba(83, 157, 253, 0.12), rgba(255, 255, 255, 0.03));
}
html.dark .article-content blockquote::before {
  color: rgba(83, 157, 253, 0.15);
}
html.dark .article-content li {
  color: #cbd5e1;
}
html.dark .article-content ul > li::before {
  background: #539dfd;
}
html.dark .article-content h2 {
  border-bottom-color: rgba(83, 157, 253, 0.18);
}
html.dark .article-content h2::before {
  background: linear-gradient(180deg, #539dfd, #539dfd);
}
html.dark .article-content h3::before {
  color: #539dfd;
}
html.dark .article-content code:not(pre code) {
  color: #539dfd;
  background: rgba(83, 157, 253, 0.1);
  border-color: rgba(255, 255, 255, 0.08);
}
html.dark .article-content pre {
  background: linear-gradient(145deg, #111827, #1e293b);
}
html.dark .article-content pre code {
  color: #cbd5e1;
}
html.dark .article-content pre::after {
  color: #539dfd;
  border-color: rgba(83, 157, 253, 0.14);
  background: rgba(83, 157, 253, 0.08);
}
html.dark .article-content hr {
  background: linear-gradient(90deg, transparent, rgba(83, 157, 253, 0.45), transparent);
}
html.dark .article-content th {
  color: #cbd5e1;
}
html.dark .article-content img {
  border-color: rgba(83, 157, 253, 0.14);
  box-shadow: 0 16px 48px rgba(83, 157, 253, 0.08);
}
html.dark .article-content img:hover {
  box-shadow: 0 22px 64px rgba(83, 157, 253, 0.12);
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
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 18px;
  background: var(--ct-pre-bg);
  box-shadow: 0 18px 48px var(--ct-pre-shadow);
  overflow: hidden;
}

.code-block-header {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 2.2rem;
  padding: 0 1rem;
  position: relative;
}

.code-block-dots {
  position: absolute;
  left: 1.05rem;
  top: 50%;
  transform: translateY(-50%);
  display: flex;
  gap: 0.43rem;
}

.code-block-dots span {
  width: 0.72rem;
  height: 0.72rem;
  border-radius: 50%;
}

.code-block-dots span:nth-child(1) {
  background: #ff5f56;
}
.code-block-dots span:nth-child(2) {
  background: #ffbd2e;
}
.code-block-dots span:nth-child(3) {
  background: #27c93f;
}

.code-lang-label {
  font-size: 0.72rem;
  letter-spacing: 0.06em;
  color: var(--ct-pre-lang-color);
}

.code-copy-btn {
  position: absolute;
  right: 1rem;
  top: 50%;
  transform: translateY(-50%);
  display: flex;
  align-items: center;
  justify-content: center;
  width: 2rem;
  height: 2rem;
  border-radius: 8px;
  border: none;
  background: transparent;
  cursor: pointer;
  color: var(--ct-pre-lang-color);
  opacity: 0.6;
  transition:
    opacity 0.2s,
    background 0.2s;
}

.code-copy-btn:hover {
  opacity: 1;
  background: var(--ct-pre-lang-bg);
}
</style>
