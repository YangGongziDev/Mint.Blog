<template>
  <DarkModeContainer class="size-full min-h-0 flex flex-col shadow-sider" :inverted="darkMenu">
    <RouterLink
      v-if="showLogo"
      to="/"
      class="w-full flex items-center justify-center overflow-hidden whitespace-nowrap"
      :style="{ height: themeStore.header.height + 'px' }"
    >
      <SystemLogo
        :src="authorAvatar"
        class="header-blog-logo"
        :style="{
          '--lw': appStore.isMobile ? '27px' : '48px',
          '--lh': appStore.isMobile ? '27px' : '48px'
        }"
      />
      <h2
        v-show="!appStore.siderCollapse"
        class="pl-[8px] text-[16px] text-primary font-bold transition duration-300 ease-in-out"
      >
        {{ $t('system.title') }}
      </h2>
    </RouterLink>
    <div :id="GLOBAL_SIDER_MENU_ID" :class="menuWrapperClass"></div>
  </DarkModeContainer>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue';
import { GLOBAL_SIDER_MENU_ID } from '@/constants/app';
import { getBlogSettingsDetail } from '@/service/blog/surfer/setting';
import { useAppStore } from '@/store/system/app';
import { useThemeStore } from '@/store/system/theme';
import { $t } from '@/locales';

defineOptions({
  name: 'AdminSider'
});

const appStore = useAppStore();
const themeStore = useThemeStore();

type Api<T> = { success: boolean; data: T };
type Settings = { avatar?: string };

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

const isVerticalMix = computed(() => themeStore.layout.mode === 'vertical-mix');
const isHorizontalMix = computed(() => themeStore.layout.mode === 'horizontal-mix');
const darkMenu = computed(() => !themeStore.darkMode && !isHorizontalMix.value && themeStore.sider.inverted);
const showLogo = computed(() => !isVerticalMix.value && !isHorizontalMix.value);
const menuWrapperClass = computed(() => (showLogo.value ? 'min-w-0 min-h-0 flex-1 overflow-hidden' : 'h-full'));
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
</style>
