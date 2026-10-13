<template>
  <div class="page-container">
    <div class="card flex flex-1 min-h-[500px] items-center justify-center">
      <a-result
        status="403"
        :title="$t('exampleException.403title')"
        :sub-title="$t('exampleException.403description')"
      >
        <template #extra>
          <a-button type="primary" @click="router.push('/')">
            {{ $t('error.backHome') }}
          </a-button>
        </template>
      </a-result>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';

const router = useRouter();
</script>
