<script setup lang="ts">
import { nextTick, onBeforeUnmount, onMounted, ref } from 'vue';
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
let activeLockTimer: ReturnType<typeof window.setTimeout> | null = null;
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
  const levels = ['h2', 'h3', 'h4'];
  const headings = container.querySelectorAll(levels.join(', '));

  const titlesArr: TitleItem[] = [];
  let index = 1;

  headings.forEach(heading => {
    const htmlHeading = heading as HTMLElement;
    const headingLevel = Number.parseInt(htmlHeading.tagName.substring(1), 10);
    const headingText = htmlHeading.textContent || '';
    const offsetTop = calcOffsetTop(htmlHeading);

    if (headingLevel === 2) {
      titlesArr.push({ index, level: headingLevel, text: headingText, offsetTop, children: [] });
    } else if (headingLevel === 3) {
      const parentH2 = titlesArr[titlesArr.length - 1];
      if (parentH2 && parentH2.children) {
        parentH2.children.push({ index, level: headingLevel, text: headingText, offsetTop, children: [] });
      }
    } else if (headingLevel === 4) {
      const lastH2 = titlesArr[titlesArr.length - 1];
      if (lastH2 && lastH2.children && lastH2.children.length > 0) {
        const lastH3 = lastH2.children[lastH2.children.length - 1];
        if (lastH3 && lastH3.children) {
          lastH3.children.push({ index, level: headingLevel, text: headingText, offsetTop });
        }
      }
    }
    index += 1;
  });

  titles.value = titlesArr;
}

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

function handleScroll(): void {
  const scrollY = getScrollY();
  const activeOffsetY = scrollY + 24;

  let matchedIndex = -1;
  titles.value.forEach(title => {
    if (activeOffsetY >= title.offsetTop) {
      matchedIndex = title.index;
    }
    const children = title.children;
    if (children && children.length > 0) {
      children.forEach(child => {
        if (activeOffsetY >= child.offsetTop) {
          matchedIndex = child.index;
        }
        const grandChildren = child.children;
        if (grandChildren && grandChildren.length > 0) {
          grandChildren.forEach(gc => {
            if (activeOffsetY >= gc.offsetTop) {
              matchedIndex = gc.index;
            }
          });
        }
      });
    }
  });
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

function scrollTocToActive() {
  if (!tocCardRef.value) return;
  const wrapper = tocCardRef.value.querySelector('.toc-wrapper') as HTMLElement | null;
  if (!wrapper) return;

  const activeEl = wrapper.querySelector('.active') as HTMLElement | null;
  if (!activeEl) return;

  const wrapperRect = wrapper.getBoundingClientRect();
  const activeRect = activeEl.getBoundingClientRect();
  const itemHeight = activeRect.height || 28;

  if (activeRect.bottom > wrapperRect.bottom - 4) {
    wrapper.scrollTop += activeRect.bottom - wrapperRect.bottom + itemHeight + 4;
  } else if (activeRect.top < wrapperRect.top + 4) {
    wrapper.scrollTop += activeRect.top - wrapperRect.top - itemHeight - 4;
  }
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
      const headings = container.querySelectorAll('h2, h3, h4');
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
    scroller.addEventListener('scroll', handleScroll);
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
  tryInitToc();

  bodyObserver = new MutationObserver(() => {
    tryInitToc();
  });
  bodyObserver.observe(document.body, { childList: true, subtree: true });
});

onBeforeUnmount(() => {
  if (scrollBound) {
    scroller.removeEventListener('scroll', handleScroll);
    window.removeEventListener('resize', onResize);
    scrollBound = false;
  }
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
          <li v-for="h2 in titles" :key="h2.index">
            <span
              class="block py-1.5 hover:text-[#3ecf9a] transition-colors cursor-pointer"
              :class="[
                h2.index === activeHeadingIndex
                  ? 'active toc-h2-active text-[#3ecf9a] border-s-2 border-[#3ecf9a] font-bold pl-3 text-base'
                  : 'text-[#0d3d2d] dark:text-white font-bold pl-3.5 text-base'
              ]"
              @click="scrollToView(h2.offsetTop, h2.index)"
            >
              {{ h2.text }}
            </span>
            <ul v-if="h2.children && h2.children.length > 0" class="mt-1">
              <li v-for="h3 in h2.children" :key="h3.index">
                <span
                  class="block py-1 hover:text-[#3ecf9a] transition-colors cursor-pointer"
                  :class="[
                    h3.index === activeHeadingIndex
                      ? 'active toc-h3-active text-[#3ecf9a] border-s-2 border-[#3ecf9a] font-semibold pl-7 text-sm'
                      : 'text-[#557468] dark:text-[#cbd5e1] font-normal pl-8 text-sm'
                  ]"
                  @click="scrollToView(h3.offsetTop, h3.index)"
                >
                  {{ h3.text }}
                </span>
                <ul v-if="h3.children && h3.children.length > 0" class="mt-0.5">
                  <li v-for="h4 in h3.children" :key="h4.index">
                    <span
                      class="block py-0.5 hover:text-[#3ecf9a] transition-colors cursor-pointer"
                      :class="[
                        h4.index === activeHeadingIndex
                          ? 'active toc-h4-active text-[#3ecf9a] border-s-2 border-[#3ecf9a] font-medium pl-12 text-[11px]'
                          : 'text-[#6b8074] dark:text-[#8aab99] font-normal pl-[50px] text-[11px]'
                      ]"
                      @click="scrollToView(h4.offsetTop, h4.index)"
                    >
                      · {{ h4.text }}
                    </span>
                  </li>
                </ul>
              </li>
            </ul>
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
