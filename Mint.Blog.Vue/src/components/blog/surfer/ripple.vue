<script setup lang="ts">
defineOptions({ name: 'surfer-ripple' });
</script>

<template>
  <div class="ripple-component">
    <div class="ripple-spacer">
      <svg
        class="ripple-waves"
        xmlns="http://www.w3.org/2000/svg"
        xmlns:xlink="http://www.w3.org/1999/xlink"
        viewBox="0 24 150 28"
        preserveAspectRatio="none"
        shape-rendering="auto"
      >
        <defs>
          <path
            id="ripple-gentle-wave"
            d="M-160 44c30 0 58-14 88-14s 58 14 88 14 58-14 88-14 58 14 88 14 v44h-352z"
          ></path>
        </defs>

        <g class="ripple-parallax">
          <use xlink:href="#ripple-gentle-wave" x="48" y="0" />
          <use xlink:href="#ripple-gentle-wave" x="48" y="6" />
          <use xlink:href="#ripple-gentle-wave" x="48" y="12" />
          <use xlink:href="#ripple-gentle-wave" x="48" y="18" />
        </g>
      </svg>
    </div>
  </div>
</template>

<style>
.ripple-component .ripple-spacer {
  height: 1px;
}

.ripple-component .ripple-waves {
  position: relative;
  width: 100%;
  min-height: 80px;
  max-height: 150px;
  margin-bottom: -7px;
  transform: translateY(-100%);
  z-index: 2;
}

.ripple-parallax > use {
  animation: ripple-move-forever 25s cubic-bezier(0.55, 0.5, 0.45, 0.5) infinite;
}

.ripple-parallax > use:nth-child(1) {
  animation-delay: -2s;
  animation-duration: 7s;
  fill: rgba(249, 249, 249, 0.85);
}

.ripple-parallax > use:nth-child(2) {
  animation-delay: -3s;
  animation-duration: 10s;
  fill: rgba(249, 249, 249, 0.5);
}

.ripple-parallax > use:nth-child(3) {
  animation-delay: -4s;
  animation-duration: 13s;
  fill: rgba(249, 249, 249, 0.22);
}

.ripple-parallax > use:nth-child(4) {
  animation-delay: -5s;
  animation-duration: 20s;
  fill: rgba(249, 249, 249, 0.05);
}

.dark .ripple-parallax > use:nth-child(1) { fill: rgba(35, 41, 49, 0.85); }
.dark .ripple-parallax > use:nth-child(2) { fill: rgba(35, 41, 49, 0.45); }
.dark .ripple-parallax > use:nth-child(3) { fill: rgba(35, 41, 49, 0.18); }
.dark .ripple-parallax > use:nth-child(4) { fill: rgba(35, 41, 49, 0.04); }

@keyframes ripple-move-forever {
  0% {
    transform: translate3d(-90px, 0, 0);
  }
  100% {
    transform: translate3d(85px, 0, 0);
  }
}

@media (max-width: 768px) {
  .ripple-component .ripple-waves {
    min-height: 40px;
    max-height: 40px;
  }
}
</style>
