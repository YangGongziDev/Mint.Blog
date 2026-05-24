<template>
    <div class="bg-white py-5 flex text-sm text-gray-500 shadow-none px-4 md:flex md:items-center md:justify-between">
        <!-- Copyright 版权信息 -->
      <span class="text-sm text-gray-500 sm:text-center dark:text-gray-400">© {{new Date().getFullYear()}}
        <a href="https://www.yangmufa.cn/surfer/author" target="_blank" class="hover:underline text-blue-400">
          &nbsp;杨工子&nbsp;
        </a>
        All Rights Reserved.
      </span>
      <ul class="flex flex-wrap items-center m-0 text-sm font-medium text-gray-500 dark:text-gray-400" style="margin: 0 !important;">
        <li style="display: flex;align-items: center;">
          <img src="../../../assets/Gonan.png" alt="" style="width: 15px;height: 15px;margin-right: 5px" />
          备案号：
          <a href="https://beian.miit.gov.cn" target="_blank" class="text-blue-400 mr-4 hover:underline md:mr-6 ">黔ICP备19007557号</a>
        </li>
      </ul>
    </div>
</template>
<script setup lang="ts">
</script>