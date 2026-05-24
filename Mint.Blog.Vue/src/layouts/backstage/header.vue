<template>
  <DarkModeContainer class="h-full flex items-center px-[12px] shadow-header">
    <RouterLink
      v-if="showLogo"
      to="/blog/admin/home"
      class="h-full flex items-center justify-center overflow-hidden whitespace-nowrap"
      :style="{ width: themeStore.sider.width + 'px' }"
    >
      <SystemLogo class="h-[32px] w-[32px]" />
      <h2 class="pl-[8px] text-[16px] text-primary font-bold transition duration-300 ease-in-out">
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

    <div class="h-full flex items-center justify-end">
      <!-- <ButtonIcon
        v-if="!appStore.isMobile"
        size-class="text-[24px]"
        icon="mdi:history"
        tooltip-content="V1版本"
        :trigger-parent="true"
        @click="openV1"
      /> -->
      <ButtonIcon
        size-class="text-[24px]"
        icon="mdi:web"
        tooltip-content="去前台"
        :trigger-parent="true"
        @click="routerPushByKey('blog-surfer_home')"
      />
      <FullScreen v-if="!appStore.isMobile" :full="isFullscreen" @click="toggle" />
      <LangSwitch :lang="appStore.locale" :lang-options="appStore.localeOptions" @change-lang="appStore.changeLocale" />
      <ThemeSchemaSwitch
        :theme-schema="themeStore.themeScheme"
        :is-dark="themeStore.darkMode"
        @switch="themeStore.toggleThemeScheme"
      />
      <ButtonIcon
        size-class="text-icon"
        icon="majesticons:color-swatch-line"
        :tooltip-content="$t('icon.themeConfig')"
        :trigger-parent="true"
        @click="appStore.openThemeDrawer"
      />
      <AButton v-if="!authStore.isLogin" @click="loginOrRegister">{{ $t('page.login.common.loginOrRegister') }}</AButton>
      <ADropdown v-else placement="bottomRight" trigger="click">
        <ButtonIcon>
          <SvgIcon icon="ph:user-circle" class="text-icon-large" />
          <span class="hidden sm:inline text-[16px] font-medium">{{ authStore.userInfo.displayName }}</span>
        </ButtonIcon>
        <template #overlay>
          <AMenu>
            <AMenuItem @click="routerPushByKey('user-center')">
              <div class="flex items-center justify-center gap-[8px]">
                <SvgIcon icon="ph:user-circle" class="text-icon" />
                {{ $t('common.userCenter') }}
              </div>
            </AMenuItem>
            <AMenuDivider />
            <AMenuItem @click="logout">
              <div class="flex items-center justify-center gap-[8px]">
                <SvgIcon icon="ph:sign-out" class="text-icon" />
                {{ $t('common.logout') }}
              </div>
            </AMenuItem>
          </AMenu>
        </template>
      </ADropdown>
    </div>
  </DarkModeContainer>
</template>

<script setup lang="ts">
import { Modal } from 'ant-design-vue';
import { useFullscreen } from '@vueuse/core';
import { GLOBAL_HEADER_MENU_ID } from '@/constants/app';
import { useAppStore } from '@/store/system/app';
import { useThemeStore } from '@/store/system/theme';
import { useAuthStore } from '@/store/system/auth';
import { useRouterPush } from '@/hooks/routing/use-router-push';
import { $t } from '@/locales';
import Breadcrumb from '@/layouts/backstage/breadcrumb.vue';

defineOptions({
  name: 'Header'
});

interface Props {
  showLogo?: App.Global.HeaderProps['showLogo'];
  showMenuToggler?: App.Global.HeaderProps['showMenuToggler'];
  showMenu?: App.Global.HeaderProps['showMenu'];
}

defineProps<Props>();

const appStore = useAppStore();
const themeStore = useThemeStore();
const authStore = useAuthStore();
const { isFullscreen, toggle } = useFullscreen();
const { routerPushByKey, toLogin } = useRouterPush();

function loginOrRegister() {
  toLogin();
}

function logout() {
  Modal.confirm({
    title: $t('common.tip'),
    content: $t('common.logoutConfirm'),
    okText: $t('common.confirm'),
    cancelText: $t('common.cancel'),
    onOk: () => {
      authStore.resetStore();
    }
  });
}

function openV1() {
  window.open('https://v1.yangmufa.cn/admin/home', '_blank', 'noopener,noreferrer');
}
</script>

<style scoped lang="scss"></style>
