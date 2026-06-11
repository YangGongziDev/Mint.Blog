<script setup lang="ts">
defineOptions({ name: 'surfer-slide' });

withDefaults(defineProps<{
  src?: string;
  fallbackSrc?: string;
  isRipple?: boolean;
}>(), {
  isRipple: true,
});
</script>

<template>
  <div>
    <div
      class="slide-inner"
      style="min-height: 300px; position: relative; background: #1a1a2e; overflow: hidden;"
    >
      <div
        v-if="fallbackSrc"
        style="position: absolute; inset: 0; background-size: cover; background-position: center; background-repeat: no-repeat;"
        :style="{ backgroundImage: `url(${fallbackSrc})` }"
      />
      <div
        v-if="src"
        style="position: absolute; inset: 0; background-size: cover; background-position: center; background-repeat: no-repeat;"
        :style="{ backgroundImage: `url(${src})` }"
      />
      <div style="position: absolute; inset: 0; background: rgba(0,0,0,0.2); z-index: 1;" />
      <div class="slide-fade" />
      <div style="position: relative; height: 100%; z-index: 10;">
        <slot />
      </div>
    </div>
    <Ripple v-if="isRipple" />
  </div>
</template>

<style scoped>
.slide-inner {
  height: 300px;
}
.slide-fade {
  position: absolute;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 1;
  height: 24%;
  background: linear-gradient(to top, rgb(var(--layout-bg-color)), rgb(var(--layout-bg-color) / 72%), transparent);
}
@media (min-width: 640px) {
  .slide-inner {
    height: 400px;
  }
}
@media (min-width: 768px) {
  .slide-inner {
    height: 500px;
  }
}
</style>


