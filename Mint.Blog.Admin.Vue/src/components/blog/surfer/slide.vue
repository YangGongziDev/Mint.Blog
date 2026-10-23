<template>
  <div class="slide">
    <div class="slide-inner" :style="slideStyle">
      <div
        v-if="fallbackSrc"
        class="slide-background slide-background-fallback"
        :style="{ backgroundImage: `url(${fallbackSrc})` }"
      ></div>
      <div v-if="src" class="slide-background" :style="{ backgroundImage: `url(${src})` }"></div>
      <div v-if="loading" class="slide-skeleton">
        <slot name="skeleton" />
      </div>
      <div class="slide-overlay"></div>
      <div v-if="isStarry" class="slide-starry">
        <Starry />
      </div>
      <div class="slide-fade"></div>
      <div v-if="!loading" class="slide-content">
        <slot />
      </div>
    </div>
    <Ripple v-if="isRipple" />
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import Ripple from '@/components/blog/surfer/ripple.vue';
import Starry from '@/components/blog/surfer/starry.vue';

defineOptions({ name: 'SurferSlide' });

const props = withDefaults(
  defineProps<{
    src?: string;
    fallbackSrc?: string;
    loading?: boolean;
    isRipple?: boolean;
    isStarry?: boolean;
    height?: string;
    heightSm?: string;
    heightMd?: string;
  }>(),
  {
    src: '',
    fallbackSrc: '',
    loading: false,
    isRipple: true,
    isStarry: true
  }
);

const slideStyle = computed(() => ({
  '--slide-height': props.height,
  '--slide-height-sm': props.heightSm,
  '--slide-height-md': props.heightMd
}));
</script>

<style scoped>
.slide-inner {
  position: relative;
  height: var(--slide-height, 340px);
  overflow: hidden;
  background-color: var(--slide-background-color, #1a1a2e);
}

.slide-background,
.slide-overlay,
.slide-starry,
.slide-fade,
.slide-skeleton {
  position: absolute;
  inset: 0;
}

.slide-background {
  z-index: 0;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
}

.slide-background-fallback {
  background-color: var(--slide-background-color, #1a1a2e);
}

.slide-skeleton {
  z-index: 1;
}

.slide-overlay {
  z-index: 2;
  background: var(--slide-overlay-color, rgb(0 0 0 / 35%));
}

.slide-starry {
  z-index: 3;
  overflow: hidden;
  pointer-events: none;
}

.slide-fade {
  top: auto;
  z-index: 4;
  height: 24%;
  background: linear-gradient(to top, rgb(var(--layout-bg-color)), rgb(var(--layout-bg-color) / 72%), transparent);
}

.slide-content {
  position: relative;
  z-index: 10;
  height: 100%;
  text-shadow: 0 4px 22px rgb(0 0 0 / 55%);
}

@media (min-width: 640px) {
  .slide-inner {
    height: var(--slide-height-sm, 420px);
  }
}

@media (min-width: 768px) {
  .slide-inner {
    height: var(--slide-height-md, 500px);
  }
}
</style>
