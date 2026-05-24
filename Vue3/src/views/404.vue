<template>
    <Header></Header>
    <!-- 主内容区域 -->
    <main class="@container max-w-screen-xl mx-auto px-4 md:px-6 py-4 flex items-center justify-center flex-col">
        <img src="../assets/404.svg" alt="404 Not Found" class="w-96 h-96 mb-8" />
        <p class="mt-2 mb-10 text-gray-400">您要找的页面飞到月球去啦~</p>
        <p class="mb-16">
            <button @click="router.push('/')" type="button" class="text-white bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-blue-300 dark:focus:ring-blue-800 font-medium rounded-lg text-sm px-5 py-2.5 text-center mr-2 mb-2">返回首页</button>
        </p>
    </main>
    <Footer></Footer>
</template>

<script setup lang="ts">
import Header from '@/layouts/surfer/components/Header.vue'
import Footer from '@/layouts/surfer/components/Footer.vue'
import { useRouter, type Router } from 'vue-router'

const router: Router = useRouter()
</script>

<style lang="scss" scoped>

</style>
