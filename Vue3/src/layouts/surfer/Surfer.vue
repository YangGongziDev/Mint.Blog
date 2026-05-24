<template>
  <div class="surfer-layout-container theme-bg-secondary theme-text-primary">
    <div class="surfer-layout-hander">
      <Header></Header>
    </div>
    <div class="surfer-layout-main" ref="mainEl">
      <div class="surfer-layout-content">
        <router-view></router-view>
      </div>
      <!-- 返回顶部 -->
      <ScrollToTopButton></ScrollToTopButton>
      
      <div class="pointer-events-none fixed inset-x-0 bottom-0 z-30 flex justify-center pb-[env(safe-area-inset-bottom)]">
        <div class="flex justify-center lg:w-[950px] xl:w-[960px] mx-auto">
          <img class="block h-auto w-[min(300px,92vw)] sm:w-[min(380px,92vw)] md:w-[520px] lg:w-[620px] xl:w-[720px] 2xl:w-[820px]"
            src="@/assets/surfer/footer/Animals.png"
            alt=""
          />
        </div>
      </div>

      <div class="surfer-layout-footer" ref="footerEl">
        <Footer></Footer>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import Header from '@/layouts/surfer/components/Header.vue'
import Footer from '@/layouts/surfer/components/Footer.vue'
import ScrollToTopButton from '@/layouts/surfer/components/ScrollToTopButton.vue'







</script>

<style scoped lang="scss">
.surfer-layout-container {
  height: 100vh;
  width: 100vw;
  //background-image: url("@/assets/surfer/Background.jpg");
  //background-size: cover;
  //background-position: center;
  /* 隐藏滚动条 */
  overflow-y: hidden; /* 隐藏垂直滚动条 */
  overflow-x: hidden; /* 隐藏水平滚动条 */
  &::-webkit-scrollbar {
    display: none; /* Chrome, Safari, Opera */
  }
  -ms-overflow-style: none;  /* IE and Edge */
  scrollbar-width: none;  /* Firefox */
  .surfer-layout-hander {
    width: 100%;
    height: 64px;
  }
  .surfer-layout-main{
    width: 100%;
    height: calc(100vh - 64px);
    overflow-y: scroll;
    /* overflow-y: auto; */
    position: relative; /* 让绝对定位的 in-gap 参照容器 */
    .surfer-layout-content {
      width: 100%;
    }
    .surfer-layout-footer {
      width: 100%;
      height: 160px;
    }
  }
}

@media (min-width: 1024px) and (hover: hover) and (pointer: fine) {
  .surfer-layout-container {
    .surfer-layout-hander {
      height: 80px;
    }
    .surfer-layout-main{
      height: calc(100vh - 80px);
    }
  }
}




</style>
