<template>
  <a-config-provider
    :locale="locale"
    :theme="{
      algorithm: isDark ? theme.darkAlgorithm : theme.defaultAlgorithm,
      token: {
        colorPrimary: '#3b82f6',
      }
    }"
  >
    <router-view />
  </a-config-provider>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { theme } from 'ant-design-vue'
import zhCN from 'ant-design-vue/es/locale/zh_CN'
import { useTheme } from '@/composables/useTheme'

const { isDark } = useTheme()
const locale = ref(zhCN)

</script>

<style scoped lang="scss">

</style>
