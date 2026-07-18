<script setup lang="ts">
import { computed, nextTick, onBeforeUnmount, onMounted, ref } from 'vue';
import { UnorderedListOutlined } from '@ant-design/icons-vue';

defineOptions({
  name: 'SurferToc'
});

const emit = defineEmits<{
  itemClick: [];
}>();

const props = withDefaults(
  defineProps<{
    contentSelector?: string;
    headerOffset?: number;
    pinnable?: boolean;
  }>(),
  {
    contentSelector: '.article-content',
    headerOffset: 80,
    pinnable: true
  }
);

interface TitleItem {
  index: number;
  level: number;
  text: string;
  offsetTop: number;
  children?: TitleItem[];
}

const titles = ref<TitleItem[]>([]);
const activeHeadingIndex = ref<number>(-1);
const tocCardRef = ref<HTMLElement | null>(null);

let bodyObserver: MutationObserver | null = null;
let contentObserver: MutationObserver | null = null;
let scrollBound = false;
let scroller: HTMLElement | typeof window = window;
let prevContainer: Element | null = null;

let isTocPinned = false;
let savedTocNaturalTop = 0;
let savedTocLeft = 0;
let savedTocWidth = 0;
let lastAutoScrolledIndex = -1;
let lastTop = -1;
let lastMaxHeight = -1;
let activeLockTimer: number | null = null;
let scrollFrame: number | null = null;
let lockedActiveHeadingIndex: number | null = null;

function findScrollContainer(startEl: HTMLElement | null): HTMLElement | typeof window {
  let el = startEl;
  while (el) {
    const style = window.getComputedStyle(el);
    if (style.overflowY === 'auto' || style.overflowY === 'scroll') {
      return el;
    }
    el = el.parentElement;
  }
  return window;
}

function getScrollY(): number {
  return scroller === window ? window.scrollY : (scroller as HTMLElement).scrollTop;
}

function calcOffsetTop(el: HTMLElement): number {
  const scrollerEl = scroller === window ? null : (scroller as HTMLElement);

  if (scrollerEl) {
    const scrollerRect = scrollerEl.getBoundingClientRect();
    const headingRect = el.getBoundingClientRect();
    return headingRect.top - scrollerRect.top + scrollerEl.scrollTop - props.headerOffset;
  }

  return el.getBoundingClientRect().top + window.scrollY - props.headerOffset;
}

function initTocData(container: Element): void {
  const headings = container.querySelectorAll('h1, h2, h3, h4, h5, h6');
  const titlesArr: TitleItem[] = [];
  const stack: TitleItem[] = [];
  let index = 1;

  headings.forEach(heading => {
    const htmlHeading = heading as HTMLElement;
    const headingLevel = Number.parseInt(htmlHeading.tagName.substring(1), 10);
    const item: TitleItem = { index, level: headingLevel, text: htmlHeading.textContent || '', offsetTop: calcOffsetTop(htmlHeading), children: [] };

    while (stack.length > 0 && stack[stack.length - 1].level >= headingLevel) stack.pop();
    if (stack.length > 0) {
      stack[stack.length - 1].children?.push(item);
    } else {
      titlesArr.push(item);
    }
    stack.push(item);
    index += 1;
  });

  titles.value = titlesArr;
}

const flatTitles = computed(() => {
  const result: Array<TitleItem & { indent: number }> = [];
  const flatten = (items: TitleItem[], indent: number) => {
    items.forEach(item => {
      result.push({ ...item, indent });
      if (item.children?.length) flatten(item.children, indent + 1);
    });
  };
  flatten(titles.value, 0);
  return result;
});

function getTocNaturalTop(): number {
  if (!tocCardRef.value) return 0;
  const rect = tocCardRef.value.getBoundingClientRect();
  const scrollerEl = scroller === window ? null : (scroller as HTMLElement);
  const scrollerTop = scrollerEl ? scrollerEl.getBoundingClientRect().top : 0;
  return rect.top - scrollerTop + getScrollY();
}

function onResize() {
  unpinToc();
  handleScroll();
}

function findActiveHeadingIndex(activeOffsetY: number): number {
  const currentTitles = flatTitles.value;
  let low = 0;
  let high = currentTitles.length - 1;
  let matchedIndex = -1;

  while (low <= high) {
    const middle = Math.floor((low + high) / 2);
    if (activeOffsetY >= currentTitles[middle].offsetTop) {
      matchedIndex = currentTitles[middle].index;
      low = middle + 1;
    } else {
      high = middle - 1;
    }
  }

  return matchedIndex;
}

function requestScrollUpdate(): void {
  if (scrollFrame !== null) return;
  scrollFrame = window.requestAnimationFrame(() => {
    scrollFrame = null;
    handleScroll();
  });
}

function handleScroll(): void {
  const scrollY = getScrollY();
  const activeOffsetY = scrollY + 24;
  const matchedIndex = findActiveHeadingIndex(activeOffsetY);
  if (lockedActiveHeadingIndex !== null) {
    activeHeadingIndex.value = lockedActiveHeadingIndex;
  } else {
    activeHeadingIndex.value = matchedIndex;
  }

  if (!tocCardRef.value || !titles.value.length) return;

  if (!props.pinnable) {
    unpinToc();
    return;
  }

  const threshold = props.headerOffset;
  const tocNaturalTop = isTocPinned ? savedTocNaturalTop : getTocNaturalTop();

  if (scrollY >= tocNaturalTop) {
    const currentRect = tocCardRef.value.getBoundingClientRect();
    const currentParentCol = tocCardRef.value.closest('[class*="ant-col"]') as HTMLElement | null;

    if (!isTocPinned) {
      savedTocNaturalTop = tocNaturalTop;
      savedTocLeft = currentRect.left;
      savedTocWidth = currentRect.width;
      tocCardRef.value.style.position = 'fixed';
      tocCardRef.value.style.left = `${savedTocLeft}px`;
      tocCardRef.value.style.width = `${savedTocWidth}px`;
      tocCardRef.value.style.zIndex = '10';
      tocCardRef.value.style.overflow = 'hidden';
      isTocPinned = true;
      lastTop = -1;
      lastMaxHeight = -1;
    }

    const BOTTOM_GAP = 60;
    const MIN_CARD_HEIGHT = 150;
    const rawMaxHeight = Math.max(MIN_CARD_HEIGHT, window.innerHeight - threshold - BOTTOM_GAP);

    let top = threshold;

    const footerRect = getFooterRect();
    const colBottom = currentParentCol ? currentParentCol.getBoundingClientRect().bottom : window.innerHeight;
    const allowBottom = footerRect ? Math.min(footerRect, colBottom) : colBottom;
    const availableHeight = allowBottom - top - BOTTOM_GAP;

    if (availableHeight < MIN_CARD_HEIGHT) {
      top = Math.max(threshold, allowBottom - MIN_CARD_HEIGHT - BOTTOM_GAP);
    } else if (top + rawMaxHeight + BOTTOM_GAP > allowBottom) {
      top = allowBottom - rawMaxHeight - BOTTOM_GAP;
    }

    const finalMaxHeight = Math.round(Math.min(rawMaxHeight, allowBottom - top - BOTTOM_GAP));

    if (finalMaxHeight >= MIN_CARD_HEIGHT) {
      const roundedTop = Math.round(top);
      if (roundedTop !== lastTop) {
        tocCardRef.value.style.top = `${roundedTop}px`;
        lastTop = roundedTop;
      }
      if (finalMaxHeight !== lastMaxHeight) {
        tocCardRef.value.style.maxHeight = `${finalMaxHeight}px`;
        lastMaxHeight = finalMaxHeight;
      }
    } else if (isTocPinned) {
      unpinToc();
    }
  } else if (isTocPinned) {
    unpinToc();
  }

  if (activeHeadingIndex.value >= 0 && activeHeadingIndex.value !== lastAutoScrolledIndex) {
    lastAutoScrolledIndex = activeHeadingIndex.value;
    scrollTocToActive();
  }
}

function getFooterRect(): number | null {
  const footer = document.querySelector('footer') as HTMLElement | null;
  if (footer) {
    const rect = footer.getBoundingClientRect();
    if (rect.top < window.innerHeight) {
      return rect.top;
    }
  }
  const layoutFooter = document.querySelector('[class*="layout-footer"]') as HTMLElement | null;
  if (layoutFooter) {
    const rect = layoutFooter.getBoundingClientRect();
    if (rect.top < window.innerHeight) {
      return rect.top;
    }
  }
  return null;
}

function handleTocOpened() {
  nextTick(() => {
    requestAnimationFrame(() => {
      handleScroll();
      scrollTocToActive();
    });
  });
}

function scrollTocToActive() {
  nextTick(() => {
    if (!tocCardRef.value) return;
    const activeEl = tocCardRef.value.querySelector('.active') as HTMLElement | null;
    if (!activeEl) return;

    const tocWrapper = tocCardRef.value.querySelector('.toc-wrapper') as HTMLElement | null;
    const drawerBody = tocCardRef.value.closest('.ant-drawer-body') as HTMLElement | null;
    const scrollContainer =
      tocWrapper && tocWrapper.scrollHeight > tocWrapper.clientHeight ? tocWrapper : drawerBody;

    if (!scrollContainer) return;

    const containerRect = scrollContainer.getBoundingClientRect();
    const activeRect = activeEl.getBoundingClientRect();
    const targetTop = scrollContainer.scrollTop + activeRect.top - containerRect.top - scrollContainer.clientHeight / 2;
    scrollContainer.scrollTo({ top: Math.max(0, targetTop), behavior: 'smooth' });
  });
}

function unpinToc() {
  if (!tocCardRef.value) return;
  tocCardRef.value.style.position = '';
  tocCardRef.value.style.top = '';
  tocCardRef.value.style.left = '';
  tocCardRef.value.style.width = '';
  tocCardRef.value.style.maxHeight = '';
  tocCardRef.value.style.overflow = '';
  tocCardRef.value.style.zIndex = '';
  isTocPinned = false;
  savedTocNaturalTop = 0;
  savedTocLeft = 0;
  savedTocWidth = 0;
  lastTop = -1;
  lastMaxHeight = -1;
}

function lockActiveHeading(index: number) {
  lockedActiveHeadingIndex = index;
  activeHeadingIndex.value = index;
  lastAutoScrolledIndex = index;

  if (activeLockTimer) window.clearTimeout(activeLockTimer);
  activeLockTimer = window.setTimeout(() => {
    lockedActiveHeadingIndex = null;
    handleScroll();
  }, 900);
}

function scrollToView(offsetTop: number, index: number): void {
  if (typeof offsetTop !== 'number' || Number.isNaN(offsetTop)) return;

  lockActiveHeading(index);
  emit('itemClick');

  requestAnimationFrame(() => {
    const container = document.querySelector(props.contentSelector);
    if (container) {
      initTocData(container);
      const headings = container.querySelectorAll('h1, h2, h3, h4, h5, h6');
      let targetOffset = offsetTop;
      headings.forEach(h => {
        const t = calcOffsetTop(h as HTMLElement);
        if (t <= offsetTop + 120 && t >= offsetTop - 120) {
          targetOffset = t;
        }
      });

      if (scroller === window) {
        window.scrollTo({ top: Math.max(0, targetOffset), behavior: 'smooth' });
      } else {
        (scroller as HTMLElement).scrollTo({ top: Math.max(0, targetOffset), behavior: 'smooth' });
      }
    }
  });
}

async function refreshToc(container: Element) {
  await nextTick();
  initTocData(container);
  handleScroll();
}

function startToc(container: Element) {
  scroller = findScrollContainer(container as HTMLElement);
  initTocData(container);

  nextTick(() => {
    handleScroll();
  });

  if (!scrollBound) {
    scroller.addEventListener('scroll', requestScrollUpdate, { passive: true });
    window.addEventListener('resize', onResize);
    scrollBound = true;
  }

  contentObserver?.disconnect();
  contentObserver = new MutationObserver(() => {
    refreshToc(container);
    savedTocNaturalTop = 0;
    savedTocLeft = 0;
    savedTocWidth = 0;

    const images = container.querySelectorAll('img');
    images.forEach(img => {
      img.addEventListener(
        'load',
        () => {
          refreshToc(container);
          savedTocNaturalTop = 0;
          savedTocLeft = 0;
          savedTocWidth = 0;
        },
        { once: true }
      );
    });
  });

  contentObserver.observe(container, { childList: true, subtree: true });
}

function tryInitToc(): boolean {
  const container = document.querySelector(props.contentSelector);
  if (!container) return false;

  if (container === prevContainer) {
    refreshToc(container);
    return true;
  }

  prevContainer = container;
  startToc(container);
  return true;
}

onMounted(() => {
  window.addEventListener('blog-surfer:toc-opened', handleTocOpened);
  if (tryInitToc()) return;

  bodyObserver = new MutationObserver(() => {
    if (tryInitToc()) {
      bodyObserver?.disconnect();
      bodyObserver = null;
    }
  });
  bodyObserver.observe(document.body, { childList: true, subtree: true });
});

onBeforeUnmount(() => {
  window.removeEventListener('blog-surfer:toc-opened', handleTocOpened);
  if (scrollBound) {
    scroller.removeEventListener('scroll', requestScrollUpdate);
    window.removeEventListener('resize', onResize);
    scrollBound = false;
  }
  if (scrollFrame !== null) window.cancelAnimationFrame(scrollFrame);
  bodyObserver?.disconnect();
  contentObserver?.disconnect();
  if (activeLockTimer) window.clearTimeout(activeLockTimer);
  prevContainer = null;
});
</script>

<template>
  <aside v-if="titles.length > 0">
    <div
      ref="tocCardRef"
      class="toc-card text-sm/[30px] w-full p-5 rounded-lg border border-[#3ecf9a]/14 bg-white/84 dark:border-[#334155] dark:bg-[#2c333e]/72"
    >
      <h2 class="flex items-center mb-2 font-bold text-[#0d3d2d] dark:text-white">
        <UnorderedListOutlined class="w-3.5 h-3.5 mr-2" />
        文章目录
      </h2>
      <div class="toc-wrapper cursor-pointer">
        <ul class="toc-list">
          <li v-for="title in flatTitles" :key="title.index">
            <span
              class="block cursor-pointer py-1 hover:text-[#3ecf9a] transition-colors"
              :class="title.index === activeHeadingIndex ? 'active text-[#3ecf9a] border-s-2 border-[#3ecf9a] ps-2 font-bold' : 'text-[#557468] dark:text-[#cbd5e1]'"
              :style="{ marginLeft: `${title.indent * 1.25}rem`, fontSize: `${Math.max(0.7, 1 - title.indent * 0.08)}rem` }"
              @click="scrollToView(title.offsetTop, title.index)"
            >
              {{ title.text }}
            </span>
          </li>
        </ul>
      </div>
    </div>
  </aside>
</template>

<style scoped>
.toc-card {
  display: flex;
  flex-direction: column;
}

.toc-wrapper {
  flex: 1;
  min-height: 0;
  overflow-y: auto;
  text-overflow: ellipsis;
  white-space: nowrap;
  scroll-behavior: smooth;
  scrollbar-width: none;
}

.toc-wrapper::-webkit-scrollbar {
  display: none;
}
</style>
