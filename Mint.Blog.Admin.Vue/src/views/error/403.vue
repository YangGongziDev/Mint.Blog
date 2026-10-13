<template>
  <div class="flex min-h-screen items-center justify-center bg-[var(--color-bg-layout)]">
    <div class="text-center">
      <div class="text-[120px] font-bold leading-none text-error mb-6">403</div>
      <h1 class="text-3xl font-semibold mb-4 text-[var(--color-text-primary)]">
        {{ $t('error.403') }}
      </h1>
      <p class="text-lg text-[var(--color-text-secondary)] mb-8">
        {{ $t('error.noPermission') }}
      </p>
      <a-button type="primary" size="large" @click="goHome">
        {{ $t('error.backHome') }}
      </a-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';

const router = useRouter();

const goHome = () => {
  router.push('/');
};
</script>
