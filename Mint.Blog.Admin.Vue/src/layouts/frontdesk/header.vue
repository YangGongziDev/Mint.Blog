<template>
  <DarkModeContainer class="h-full flex items-center px-[8px] sm:px-[12px] shadow-header">
    <RouterLink
      v-if="showLogo && appStore.isMobile"
      to="/blog/surfer/home"
      class="h-full flex items-center shrink-0 overflow-visible justify-start"
    >
      <SystemLogo
        :src="authorAvatar"
        class="header-blog-logo shrink-0 ml-[0px]" :style="{ '--lw': '35px', '--lh': '35px' }"
      />
      <h2 class="pl-[6px] sm:pl-[8px] text-[18px] sm:text-[21px] text-primary font-bold transition duration-300 ease-in-out truncate">
        {{ $t('system.title') }}
      </h2>
    </RouterLink>
    <MenuToggler v-if="showMenuToggler" :collapsed="appStore.siderCollapse" @click="appStore.toggleSiderCollapse" />

    <div class="h-full min-w-0 flex flex-1 items-center overflow-hidden">
      <div v-if="!appStore.isMobile && !showMenu" class="ml-[12px] mr-[12px] flex-shrink-0 overflow-hidden">
        <Breadcrumb />
      </div>
      <div
        v-if="showMenu"
        :id="GLOBAL_HEADER_MENU_ID"
        class="h-full min-w-0 flex flex-1 items-center overflow-hidden pb-[1px]"
      ></div>
    </div>

    <div class="h-full flex items-center justify-end gap-[4px] sm:gap-2 shrink-0">
      <SurferSearchInput :is-mobile="appStore.isMobile" />
      <!-- <ButtonIcon
        v-if="!appStore.isMobile"
        size-class="text-icon-large"
        icon="mdi:history"
        tooltip-content="V1版本"
        @click="openV1"
      /> -->
      <ButtonIcon
        size-class="text-icon-large"
        icon="mdi:view-dashboard-outline"
        tooltip-content="去后台"
        @click="routerPushByKey('blog-admin_home')"
      />
      <FullScreen v-if="!appStore.isMobile" :full="isFullscreen" @click="toggle" />
      <LangSwitch :lang="appStore.locale" :lang-options="appStore.localeOptions" @change-lang="appStore.changeLocale" />
      <ThemeSchemaSwitch
        :theme-schema="themeStore.themeScheme"
        :is-dark="themeStore.darkMode"
        @switch="themeStore.toggleThemeScheme"
      />
      <ButtonIcon
        size-class="text-icon-large"
        icon="majesticons:color-swatch-line"
        :tooltip-content="$t('icon.themeConfig')"
        class="mr-[-5px]"
        @click="appStore.openThemeDrawer"
      />
    </div>
  </DarkModeContainer>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { useFullscreen } from '@vueuse/core';
import { GLOBAL_HEADER_MENU_ID } from '@/constants/app';
import { getBlogSettingsDetail } from '@/service/blog/surfer/setting';
import { useAppStore } from '@/store/system/app';
import { useThemeStore } from '@/store/system/theme';
import { useRouterPush } from '@/hooks/routing/use-router-push';
import { $t } from '@/locales';
import Breadcrumb from '@/layouts/frontdesk/breadcrumb.vue';
import SurferSearchInput from '@/components/blog/surfer/search-input.vue';

defineOptions({
  name: 'SurferHeader'
});

interface Props {
  showLogo?: App.Global.HeaderProps['showLogo'];
  showMenuToggler?: App.Global.HeaderProps['showMenuToggler'];
  showMenu?: App.Global.HeaderProps['showMenu'];
}

type Api<T> = { success: boolean; data: T };
type Settings = { avatar?: string };

defineProps<Props>();

const appStore = useAppStore();
const themeStore = useThemeStore();
const { isFullscreen, toggle } = useFullscreen();
const { routerPushByKey } = useRouterPush();
const authorAvatar = ref<string>();

function resolveImageUrl(url?: string) {
  if (!url) return undefined;
  if (/^(https?:|data:|blob:)/i.test(url)) return url;
  return url.startsWith('/') ? url : `/${url}`;
}

onMounted(async () => {
  try {
    const res = await getBlogSettingsDetail<Api<Settings>>();
    if (res.success) authorAvatar.value = resolveImageUrl(res.data?.avatar);
  } catch {
    authorAvatar.value = undefined;
  }
});

</script>

<style scoped lang="scss">
.header-blog-logo {
  flex-shrink: 0;
  overflow: hidden;
  border: 2px solid rgb(255 255 255 / 90%);
  border-radius: 52% 48% 46% 54% / 48% 52% 48% 52%;
  animation:
    header-logo-float 4s ease-in-out infinite,
    header-logo-glow 2.8s ease-in-out infinite alternate,
    header-logo-morph 7s ease-in-out infinite;
  box-shadow:
    0 0 0 4px rgb(83 157 253 / 10%),
    0 6px 18px rgb(83 157 253 / 20%),
    0 0 24px rgb(83 157 253 / 18%);
  transition:
    transform 0.3s ease,
    box-shadow 0.3s ease,
    border-color 0.3s ease;
}

.header-blog-logo:hover {
  border-radius: 48% 52% 55% 45% / 53% 46% 54% 47%;
  animation-play-state: paused;
  transform: translateY(-2px) scale(1.08) rotate(3deg);
  box-shadow:
    0 0 0 5px rgb(83 157 253 / 14%),
    0 8px 24px rgb(83 157 253 / 28%),
    0 0 30px rgb(83 157 253 / 26%);
}

.header-blog-logo :deep(.logo) {
  border-radius: inherit;
}

@keyframes header-logo-float {
  0%,
  100% {
    transform: translateY(0);
  }

  50% {
    transform: translateY(-3px);
  }
}

@keyframes header-logo-glow {
  from {
    box-shadow:
      0 0 0 3px rgb(83 157 253 / 8%),
      0 5px 16px rgb(83 157 253 / 16%),
      0 0 18px rgb(83 157 253 / 14%);
  }

  to {
    box-shadow:
      0 0 0 5px rgb(83 157 253 / 14%),
      0 8px 24px rgb(83 157 253 / 26%),
      0 0 28px rgb(83 157 253 / 24%);
  }
}

@keyframes header-logo-morph {
  0%,
  100% {
    border-radius: 52% 48% 46% 54% / 48% 52% 48% 52%;
  }

  25% {
    border-radius: 44% 56% 52% 48% / 58% 44% 56% 42%;
  }

  50% {
    border-radius: 58% 42% 45% 55% / 45% 58% 42% 55%;
  }

  75% {
    border-radius: 47% 53% 58% 42% / 52% 45% 55% 48%;
  }
}

:deep(.ant-btn) {
  border: 1px solid transparent !important;
}

@media (max-width: 639px) {
  :deep(.ant-btn) {
    padding: 0 5px !important;
  }
}
</style>
