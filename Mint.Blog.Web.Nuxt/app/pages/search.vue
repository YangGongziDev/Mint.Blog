<template>
<section class="preview-panel"><h1>搜索文章</h1><PublicSearch :keyword="keyword" :page-number="pageNumber" :page-size="pageSize" /></section>
</template>

<script setup lang="ts">
const route = useRoute()
const keyword = computed(() => typeof route.query.keyword === 'string' ? route.query.keyword : '')
function positive(value: unknown, fallback: number) { return typeof value === 'string' && /^\d+$/.test(value) && Number.isSafeInteger(Number(value)) && Number(value) > 0 ? Number(value) : fallback }
const pageNumber = computed(() => positive(route.query.pageNumber, 1))
const pageSize = computed(() => positive(route.query.pageSize, 8))
useSeoMeta({ title: () => `${keyword.value ? `${keyword.value} - ` : ''}搜索文章`, description: '搜索博客公开文章' })
</script>
