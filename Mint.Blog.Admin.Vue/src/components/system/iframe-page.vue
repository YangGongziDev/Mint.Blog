<template>
  <div class="h-full">
    <iframe v-if="url" id="iframePage" class="size-full" :src="url"></iframe>
    <div v-else class="flex h-full items-center justify-center text-gray-500">
      公共站点地址未配置或无效，当前入口不可用。
    </div>
  </div>
</template>

<script setup lang="ts">
interface Props {
  url?: string;
}
defineProps<Props>();
</script>
