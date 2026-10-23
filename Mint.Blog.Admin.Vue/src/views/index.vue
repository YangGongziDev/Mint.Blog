<template>
  <RouterView />
</template>

<script setup lang="ts">
import { onMounted, onUnmounted } from 'vue';

defineOptions({
  name: 'RootView'
});

const coreValues = ['富强', '民主', '文明', '和谐', '自由', '平等', '公正', '法治', '爱国', '敬业', '诚信', '友善'];

const brightColors = ['#15956b', '#8b5cf6', '#10b981', '#f59e0b', '#ef4444', '#06b6d4'];

function pickRandom<T>(items: T[], fallback: T): T {
  if (!items.length) {
    return fallback;
  }

  return items[Math.floor(Math.random() * items.length)] ?? fallback;
}

function createFloatingWord(event: MouseEvent, text: string, options: { index: number; total: number }) {
  const span = document.createElement('span');
  const duration = 850 + Math.floor(Math.random() * 450);
  const fontSize = 14 + Math.floor(Math.random() * 7);
  const color = pickRandom(brightColors, '#15956b');
  const angle = (Math.PI * 2 * options.index) / options.total + (Math.random() - 0.5) * 0.45;
  const startRadius = 8 + Math.random() * 8;
  const burstRadius = 78 + Math.random() * 72;
  const startX = Math.cos(angle) * startRadius;
  const startY = Math.sin(angle) * startRadius;
  const burstX = Math.cos(angle) * burstRadius;
  const burstY = Math.sin(angle) * burstRadius;
  const rotate = Math.floor(Math.random() * 50 - 25);

  span.textContent = text;
  span.style.position = 'fixed';
  span.style.left = `${event.clientX + startX}px`;
  span.style.top = `${event.clientY + startY}px`;
  span.style.zIndex = '999999';
  span.style.pointerEvents = 'none';
  span.style.userSelect = 'none';
  span.style.fontWeight = 'bold';
  span.style.color = color;
  span.style.webkitTextFillColor = color;
  span.style.fontSize = `${fontSize}px`;
  span.style.transform = 'translate(-50%, -50%) scale(0.3)';
  span.style.whiteSpace = 'nowrap';
  span.style.textShadow = `0 0 10px ${color}, 0 2px 10px rgba(0,0,0,0.2)`;
  span.style.transition = `transform ${duration}ms cubic-bezier(0.12, 0.72, 0.18, 1), opacity ${duration}ms ease-out`;
  span.style.opacity = '1';

  document.body.appendChild(span);

  requestAnimationFrame(() => {
    requestAnimationFrame(() => {
      span.style.transform = `translate(-50%, -50%) translate(${burstX}px, ${burstY}px) rotate(${rotate}deg) scale(1.08)`;
      span.style.opacity = '0';
    });
  });

  window.setTimeout(() => {
    span.remove();
  }, duration + 120);
}

function getClickWords() {
  const startIndex = Math.floor(Math.random() * coreValues.length);
  const count = 12;

  return Array.from({ length: count }, (_, index) => coreValues[(startIndex + index) % coreValues.length] ?? '富强');
}

function createBurstCore(event: MouseEvent) {
  const dot = document.createElement('span');

  dot.style.position = 'fixed';
  dot.style.left = `${event.clientX}px`;
  dot.style.top = `${event.clientY}px`;
  dot.style.zIndex = '999998';
  dot.style.width = '8px';
  dot.style.height = '8px';
  dot.style.borderRadius = '999px';
  dot.style.pointerEvents = 'none';
  dot.style.background = 'rgba(73, 177, 245, 0.95)';
  dot.style.boxShadow = '0 0 18px rgba(73, 177, 245, 0.9), 0 0 36px rgba(139, 92, 246, 0.45)';
  dot.style.transform = 'translate(-50%, -50%) scale(0.6)';
  dot.style.transition = 'transform 420ms ease-out, opacity 420ms ease-out';
  dot.style.opacity = '0.95';

  document.body.appendChild(dot);

  requestAnimationFrame(() => {
    requestAnimationFrame(() => {
      dot.style.transform = 'translate(-50%, -50%) scale(8)';
      dot.style.opacity = '0';
    });
  });

  window.setTimeout(() => {
    dot.remove();
  }, 520);
}

function handleClick(event: MouseEvent) {
  const words = getClickWords();

  createBurstCore(event);

  words.forEach((word, index) => {
    window.setTimeout(() => {
      createFloatingWord(event, word, { index, total: words.length });
    }, index * 18);
  });
}

onMounted(() => {
  window.addEventListener('click', handleClick);
});

onUnmounted(() => {
  window.removeEventListener('click', handleClick);
});
</script>
