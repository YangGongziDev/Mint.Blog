<template>
  <span hidden aria-hidden="true" />
</template>

<script setup lang="ts">
import { onBeforeUnmount, onMounted } from 'vue';

const words = ['富强', '民主', '文明', '和谐', '自由', '平等', '公正', '法治', '爱国', '敬业', '诚信', '友善'];
const colors = ['#15956b', '#8b5cf6', '#10b981', '#f59e0b', '#ef4444', '#06b6d4'];
const effects = new Map<HTMLElement, Animation>();
let reducedMotion: MediaQueryList | undefined;

function animateElement(element: HTMLElement, frames: Keyframe[], options: KeyframeAnimationOptions) {
  document.body.appendChild(element);
  const animation = element.animate(frames, { ...options, fill: 'both' });
  effects.set(element, animation);
  animation.onfinish = () => {
    element.remove();
    effects.delete(element);
  };
}

function handleClick(event: MouseEvent) {
  if (event.detail === 0 || reducedMotion?.matches) return;
  const start = Math.floor(Math.random() * words.length);
  words.forEach((_, index) => {
    const span = document.createElement('span');
    const color = colors[Math.floor(Math.random() * colors.length)]!;
    const angle = (Math.PI * 2 * index) / words.length + (Math.random() - 0.5) * 0.45;
    const radius = 65 + Math.random() * 55;
    const startRadius = 8 + Math.random() * 8;
    const x = Math.cos(angle) * radius;
    const y = Math.sin(angle) * radius;
    const rotation = Math.random() * 16 - 8;
    span.textContent = words[(start + index) % words.length]!;
    Object.assign(span.style, {
      position: 'fixed',
      left: `${event.clientX + Math.cos(angle) * startRadius}px`,
      top: `${event.clientY + Math.sin(angle) * startRadius}px`,
      zIndex: '999999',
      pointerEvents: 'none',
      userSelect: 'none',
      fontWeight: '500',
      color,
      webkitTextFillColor: color,
      fontSize: `${14 + Math.floor(Math.random() * 4)}px`,
      whiteSpace: 'nowrap',
      textShadow: `0 0 4px ${color}55, 0 1px 3px #0002`
    });
    span.setAttribute('aria-hidden', 'true');
    animateElement(
      span,
      [
        { offset: 0, transform: 'translate(-50%, -50%) scale(.75)', opacity: 0 },
        { offset: 0.18, opacity: 0.9 },
        { offset: 0.6, opacity: 0.75 },
        {
          offset: 1,
          transform: `translate(-50%, -50%) translate(${x}px, ${y - 30}px) rotate(${rotation}deg) scale(.95)`,
          opacity: 0
        }
      ],
      { duration: 1300 + Math.random() * 400, delay: index * 12, easing: 'cubic-bezier(.22,.61,.36,1)' }
    );
  });
  const dot = document.createElement('span');
  dot.setAttribute('aria-hidden', 'true');
  Object.assign(dot.style, {
    position: 'fixed',
    left: `${event.clientX}px`,
    top: `${event.clientY}px`,
    zIndex: '999998',
    width: '8px',
    height: '8px',
    borderRadius: '50%',
    pointerEvents: 'none',
    background: '#49b1f5',
    boxShadow: '0 0 18px #49b1f5e6, 0 0 36px #8b5cf673'
  });
  animateElement(
    dot,
    [
      { transform: 'translate(-50%, -50%) scale(.6)', opacity: 0.95 },
      { transform: 'translate(-50%, -50%) scale(8)', opacity: 0 }
    ],
    { duration: 420, easing: 'ease-out' }
  );
}

onMounted(() => {
  reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)');
  window.addEventListener('click', handleClick);
});
onBeforeUnmount(() => {
  window.removeEventListener('click', handleClick);
  for (const [element, animation] of effects) {
    animation.cancel();
    element.remove();
  }
  effects.clear();
});
</script>
