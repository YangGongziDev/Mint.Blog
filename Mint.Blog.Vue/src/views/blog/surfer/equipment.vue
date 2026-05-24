<script setup lang="ts">
import SurferSidebar from '@/components/blog/surfer/sidebar-right.vue';

defineOptions({ name: 'SurferEquipmentPage' });
</script>

<template>
  <main class="mx-auto max-w-screen-2xl px-4 md:px-6 py-4">
    <div class="grid grid-cols-1 gap-7 lg:grid-cols-4">
      <div class="mt-10 col-span-1 lg:col-span-3 mb-3">
        <div
          class="flex flex-col items-center justify-center rounded-lg border border-[#3ecf9a]/14 bg-white/84 p-16 dark:border-[#334155] dark:bg-[#2c333e]/72"
        >
          <div class="text-6xl font-black text-[#3ecf9a]/20">🖥️</div>
          <h2 class="mt-4 text-xl font-black text-[#0d3d2d] dark:text-white">设备</h2>
          <p class="mt-2 text-sm text-[#557468] dark:text-[#cbd5e1]">即将上线，敬请期待</p>
        </div>
      </div>
      <div class="col-span-1 mt-10 mb-3">
        <SurferSidebar />
      </div>
    </div>
  </main>
</template>
