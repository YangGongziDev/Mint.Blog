<script setup lang="ts">
import { computed, nextTick, onBeforeUnmount, onMounted, ref, watch } from 'vue';
import { useRoute } from 'vue-router';
import { message } from 'ant-design-vue';

interface FloatingPosition {
  x: number;
  y: number;
}

interface FloatingActionItem {
  id: string;
  label: string;
  icon?: string;
  svgIcon?: string;
  disabled?: boolean;
  onClick: () => void;
}

const STORAGE_KEY = 'blogSurferFloatingToolsPositionV3';
const BUTTON_SIZE = 52;
const MOBILE_BUTTON_SIZE = 46;
const DESKTOP_ACTION_RADIUS = 62;
const MOBILE_ACTION_RADIUS = 56;
const DRAG_CLICK_THRESHOLD = 4;
const DRAG_RESET_DELAY = 120;

const route = useRoute();
const floatingRef = ref<HTMLElement>();
const isExpanded = ref(true);
const isDragging = ref(false);
const isPointerDown = ref(false);
const isTocAvailable = ref(false);
const position = ref<FloatingPosition>({ x: 0, y: 0 });
const pointerStart = ref({ x: 0, y: 0 });
const dragStart = ref<FloatingPosition>({ x: 0, y: 0 });
const movedDistance = ref(0);
let resetDraggingTimer: ReturnType<typeof window.setTimeout> | null = null;
let tocObserver: MutationObserver | null = null;

const actionItems = computed<FloatingActionItem[]>(() => [
  {
    id: 'top',
    label: '顶部',
    svgIcon: 'ion:arrow-up-outline',
    onClick: returnTop
  },
  {
    id: 'toc',
    label: isTocAvailable.value ? '目录' : '当前页面暂目录',
    svgIcon: 'ant-design:unordered-list-outlined',
    disabled: !isTocAvailable.value,
    onClick: toggleToc
  },
  {
    id: 'share',
    label: '分享',
    svgIcon: 'ant-design:share-alt-outlined',
    onClick: shareCurrentPage
  }
]);

const floatingStyle = computed(() => ({
  transform: `translate3d(${position.value.x}px, ${position.value.y}px, 0)`,
  cursor: isDragging.value ? 'grabbing' : 'grab'
}));

function getButtonSize() {
  return window.innerWidth < 768 ? MOBILE_BUTTON_SIZE : BUTTON_SIZE;
}

function getDefaultPosition(): FloatingPosition {
  const size = getButtonSize();
  return {
    x: 24,
    y: Math.max(16, window.innerHeight - size - 180)
  };
}

function getStoredPosition() {
  const raw = window.localStorage.getItem(STORAGE_KEY);
  if (!raw) return null;

  try {
    const parsed = JSON.parse(raw) as FloatingPosition;
    if (Number.isFinite(parsed.x) && Number.isFinite(parsed.y)) {
      return parsed;
    }
  } catch {
    window.localStorage.removeItem(STORAGE_KEY);
  }

  return null;
}

function clampPosition(nextPosition: FloatingPosition) {
  const size = getButtonSize();
  const padding = 12;

  return {
    x: Math.min(Math.max(padding, nextPosition.x), window.innerWidth - size - padding),
    y: Math.min(Math.max(padding, nextPosition.y), window.innerHeight - size - padding)
  };
}

function savePosition() {
  window.localStorage.setItem(STORAGE_KEY, JSON.stringify(position.value));
}

function initPosition() {
  position.value = clampPosition(getStoredPosition() || getDefaultPosition());
}

function toggleExpanded() {
  if (isDragging.value) return;
  isExpanded.value = !isExpanded.value;
}

function collapse() {
  isExpanded.value = false;
}

function getScrollRoot() {
  return document.querySelector('#__SCROLL_EL_ID__') as HTMLElement | null;
}

function updateTocAvailability() {
  const articleContentEl = document.querySelector('.article-content');
  isTocAvailable.value = Boolean(articleContentEl?.querySelector('h2, h3, h4'));
}

function setupTocObserver() {
  tocObserver?.disconnect();
  tocObserver = new MutationObserver(() => updateTocAvailability());
  tocObserver.observe(document.body, { childList: true, subtree: true });
}

function toggleToc() {
  updateTocAvailability();

  if (!isTocAvailable.value) {
    message.info('当前页面暂无目录');
    return;
  }

  window.dispatchEvent(new CustomEvent('blog-surfer:toggle-toc'));
}

async function shareCurrentPage() {
  const shareData = {
    title: document.title,
    text: document.title,
    url: window.location.href
  };

  if (navigator.share) {
    await navigator.share(shareData);
    return;
  }

  await navigator.clipboard.writeText(shareData.url);
  message.success('链接已复制，快去分享吧');
}

function returnTop() {
  window.scrollTo({ top: 0, behavior: 'smooth' });
  getScrollRoot()?.scrollTo({ top: 0, behavior: 'smooth' });
}

function handleActionClick(item: FloatingActionItem) {
  if (item.disabled) {
    message.info(item.label);
    return;
  }

  item.onClick();
}

function getActionRadius() {
  return window.innerWidth < 768 ? MOBILE_ACTION_RADIUS : DESKTOP_ACTION_RADIUS;
}

function getActionPosition(index: number): Record<string, string> {
  const buttonCenterX = position.value.x + getButtonSize() / 2;
  const tocAngle = buttonCenterX > window.innerWidth / 2 ? 180 : 0;
  const angles = [-90, tocAngle, 90];
  const angle = angles[index] ?? 0;
  const radius = getActionRadius();
  const x = Math.cos((angle * Math.PI) / 180) * radius;
  const y = Math.sin((angle * Math.PI) / 180) * radius;

  return {
    '--action-delay': `${index * 80}ms`,
    transform: `translate3d(${x}px, ${y}px, 0)`
  };
}

function onPointerDown(event: PointerEvent) {
  if (event.button !== 0) return;

  isPointerDown.value = true;
  isDragging.value = false;
  movedDistance.value = 0;
  pointerStart.value = { x: event.clientX, y: event.clientY };
  dragStart.value = { ...position.value };
  floatingRef.value?.setPointerCapture(event.pointerId);
}

function onPointerMove(event: PointerEvent) {
  if (!isPointerDown.value) return;

  const offsetX = event.clientX - pointerStart.value.x;
  const offsetY = event.clientY - pointerStart.value.y;
  movedDistance.value = Math.max(Math.abs(offsetX), Math.abs(offsetY));

  if (movedDistance.value > DRAG_CLICK_THRESHOLD) {
    isDragging.value = true;
    collapse();
  }

  if (!isDragging.value) return;

  position.value = clampPosition({
    x: dragStart.value.x + offsetX,
    y: dragStart.value.y + offsetY
  });
}

function onPointerUp(event: PointerEvent) {
  if (!isPointerDown.value) return;

  isPointerDown.value = false;
  floatingRef.value?.releasePointerCapture(event.pointerId);

  if (isDragging.value) {
    savePosition();
    if (resetDraggingTimer) window.clearTimeout(resetDraggingTimer);
    resetDraggingTimer = window.setTimeout(() => {
      isDragging.value = false;
    }, DRAG_RESET_DELAY);
    return;
  }

  toggleExpanded();
}

function onResize() {
  position.value = clampPosition(position.value);
  savePosition();
}

watch(
  () => route.fullPath,
  async () => {
    isTocAvailable.value = false;
    await nextTick();
    window.setTimeout(updateTocAvailability, 300);
  }
);

onMounted(() => {
  initPosition();
  updateTocAvailability();
  setupTocObserver();
  window.setTimeout(updateTocAvailability, 300);
  window.addEventListener('resize', onResize);
  window.addEventListener('popstate', updateTocAvailability);
});

onBeforeUnmount(() => {
  window.removeEventListener('resize', onResize);
  window.removeEventListener('popstate', updateTocAvailability);
  tocObserver?.disconnect();
  if (resetDraggingTimer) window.clearTimeout(resetDraggingTimer);
});
</script>

<template>
  <div class="floating-tools-layer fixed inset-0 z-[999] pointer-events-none">
    <div
      ref="floatingRef"
      class="floating-tools pointer-events-auto fixed left-0 top-0 select-none touch-none"
      :class="{ 'is-expanded': isExpanded, 'is-dragging': isDragging }"
      :style="floatingStyle"
      @pointerdown="onPointerDown"
      @pointermove="onPointerMove"
      @pointerup="onPointerUp"
      @pointercancel="onPointerUp"
    >
      <TransitionGroup name="floating-action" tag="div" class="floating-actions absolute left-1/2 top-1/2">
        <div
          v-for="(item, index) in actionItems"
          v-show="isExpanded"
          :key="item.id"
          class="floating-action-wrap"
          :style="getActionPosition(index)"
        >
          <button
            class="floating-action-item"
            :class="{ 'is-disabled': item.disabled }"
            :aria-label="item.label"
            :title="item.label"
            @pointerdown.stop
            @click.stop="handleActionClick(item)"
          >
            <img v-if="item.icon" :src="item.icon" :alt="item.label" />
            <SvgIcon v-else-if="item.svgIcon" class="floating-action-svg" :icon="item.svgIcon" />
          </button>
        </div>
      </TransitionGroup>

      <button
        class="floating-main-button"
        :aria-label="isExpanded ? '收起功能菜单' : '展开功能菜单'"
        :title="isExpanded ? '收起功能菜单' : '展开功能菜单'"
        @click.prevent
      >
        <span class="floating-main-icon" :class="{ 'is-expanded': isExpanded }">
          <SvgIcon class="floating-main-svg" :icon="isExpanded ? 'bi:command' : 'bi:gear'" />
        </span>
      </button>
    </div>
  </div>
</template>

<style scoped>
.floating-tools {
  width: 52px;
  height: 52px;
  z-index: 999;
}

.floating-tools.is-dragging {
  z-index: 1000;
}

.floating-main-button,
.floating-action-item {
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid rgba(148, 163, 184, 0.28);
  border-radius: 999px;
  box-shadow: 0 12px 30px rgba(15, 23, 42, 0.16);
  backdrop-filter: blur(12px);
  transition:
    transform 0.2s ease,
    box-shadow 0.2s ease,
    background-color 0.2s ease,
    border-color 0.2s ease;
}

.floating-main-button {
  position: relative;
  z-index: 2;
  width: 52px;
  height: 52px;
  color: #fff;
  cursor: inherit;
  background: linear-gradient(135deg, #22c55e, #0ea5e9);
}

.floating-main-button:hover {
  box-shadow: 0 16px 38px rgba(14, 165, 233, 0.28);
  transform: scale(1.06);
}

.floating-main-button:active {
  transform: scale(0.96);
}

.floating-main-icon {
  display: inline-flex;
  transition: transform 0.3s ease;
}

.floating-main-icon.is-expanded {
  transform: rotate(180deg);
}

.floating-actions {
  z-index: 1;
  width: 0;
  height: 0;
}

.floating-action-wrap {
  position: absolute;
  left: 0;
  top: 0;
  width: max-content;
  transform-origin: left center;
}

.floating-action-item {
  display: inline-flex;
  width: 42px;
  height: 42px;
  padding: 8px;
  color: #334155;
  cursor: pointer;
  background: rgba(255, 255, 255, 0.94);
  transform: translate(-50%, -50%);
}

.floating-action-item:hover {
  color: #0f766e;
  border-color: rgba(14, 165, 233, 0.45);
  background: #f8fafc;
  box-shadow: 0 14px 34px rgba(14, 165, 233, 0.2);
  transform: translate(-50%, -50%) scale(1.08);
}

.floating-action-item.is-disabled {
  color: #94a3b8;
  cursor: not-allowed;
  opacity: 0.48;
  filter: grayscale(1);
}

.floating-action-item.is-disabled:hover {
  color: #94a3b8;
  border-color: rgba(148, 163, 184, 0.28);
  background: rgba(255, 255, 255, 0.94);
  box-shadow: 0 12px 30px rgba(15, 23, 42, 0.16);
  transform: translate(-50%, -50%);
}

.floating-action-item:active {
  transform: translate(-50%, -50%) scale(0.94);
}

.floating-action-item img {
  width: 31px;
  height: 31px;
  object-fit: contain;
  user-select: none;
  pointer-events: none;
}

.floating-action-enter-active,
.floating-action-leave-active {
  transition:
    opacity 0.24s ease var(--action-delay, 0ms),
    transform 0.28s cubic-bezier(0.25, 0.46, 0.45, 0.94) var(--action-delay, 0ms);
}

.floating-action-enter-from,
.floating-action-leave-to {
  opacity: 0;
  transform: translate3d(0, 0, 0) scale(0.2) !important;
}

.floating-action-enter-to,
.floating-action-leave-from {
  opacity: 1;
}

.dark .floating-action-item,
html.dark .floating-action-item {
  color: #e5e7eb;
  border-color: rgba(75, 85, 99, 0.78);
  background: rgba(17, 24, 39, 0.92);
}

.dark .floating-action-item:hover,
html.dark .floating-action-item:hover {
  border-color: rgba(34, 197, 94, 0.4);
  background: #1f2937;
}

.dark .floating-action-item.is-disabled:hover,
html.dark .floating-action-item.is-disabled:hover {
  color: #94a3b8;
  border-color: rgba(75, 85, 99, 0.78);
  background: rgba(17, 24, 39, 0.92);
}

@media (max-width: 767px) {
  .floating-tools {
    width: 46px;
    height: 46px;
  }

  .floating-main-button {
    width: 46px;
    height: 46px;
  }

  .floating-action-item {
    width: 38px;
    height: 38px;
    padding: 7px;
  }

  .floating-action-item img {
    width: 29px;
    height: 29px;
  }
}
</style>

<style>
.floating-action-svg {
  width: 30px !important;
  height: 30px !important;
  font-size: 30px !important;
}

.floating-main-svg {
  width: 25px !important;
  height: 25px !important;
  font-size: 25px !important;
}

@media (max-width: 767px) {
  .floating-action-svg {
    width: 27px !important;
    height: 27px !important;
    font-size: 27px !important;
  }
}
</style>
