<template>
  <div class="bg-container text-base-text transition duration-300" :class="{ 'bg-inverted text-[#1f1f1f]': inverted }">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
defineOptions({ name: 'DarkModeContainer' });

interface Props {
  inverted?: boolean;
}  

defineProps<Props>();
</script>

<style scoped lang="scss">

</style>
