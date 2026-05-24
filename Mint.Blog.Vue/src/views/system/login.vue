<script setup lang="ts">
import { computed, reactive } from 'vue';
import { LockOutlined, UserOutlined } from '@ant-design/icons-vue';
import { useAppStore } from '@/store/system/app';
import { useAuthStore } from '@/store/system/auth';
import { useThemeStore } from '@/store/system/theme';
import { useAntdForm, useFormRules } from '@/hooks/form/use-antd-form';
import loadingSvg from '@/assets/system/svg/loading-lemonade.svg';
import { $t } from '@/locales';

defineOptions({
  name: 'SystemLogin'
});

interface LoginForm {
  userName: string;
  password: string;
}

const authStore = useAuthStore();
const appStore = useAppStore();
const themeStore = useThemeStore();
const { formRef, validate } = useAntdForm();

const form: LoginForm = reactive({
  userName: 'VisitorAdmin',
  password: 'VisitorAdmin'
});

const rules = computed<Record<keyof LoginForm, App.Global.FormRule[]>>(() => {
  const { formRules } = useFormRules();

  return {
    userName: formRules.userName,
    password: formRules.pwd
  };
});

async function handleEnter() {
  await handleSubmit();
}

async function handleSubmit() {
  await validate();
  await authStore.login(form.userName, form.password);
}
</script>

<template>
  <div
    class="login-page !p-0 fixed inset-0 grid grid-cols-1 overflow-hidden bg-gradient-to-br from-[#fffbe6] via-[#fdf1b5] to-[#d5f7e8] transition-all duration-500 dark:from-[#181f2a] dark:via-[#232b38] dark:to-[#111827] lg:grid-cols-2"
  >
    <div
      class="login-brand relative hidden overflow-hidden bg-gradient-to-br from-[#fac506] via-[#dbe049] to-[#3ecf9a] transition-all duration-500 dark:from-[#232b38] dark:via-[#2c333e] dark:to-[#111827] lg:flex lg:items-center lg:justify-center"
    >
      <div class="absolute inset-0 bg-white/10 dark:bg-[#539dfd]/8"></div>
      <div class="absolute left-10 top-10 h-32 w-32 rounded-full bg-[#fffbe6]/35 blur-xl dark:bg-[#539dfd]/14"></div>
      <div
        class="absolute bottom-20 right-20 h-40 w-40 rounded-full bg-[#76c5a5]/24 blur-2xl dark:bg-[#539dfd]/10"
      ></div>

      <div class="relative z-10 flex h-full flex-col items-center justify-center p-12 text-center">
        <div class="mb-0 text-center">
          <h1
            class="typing-logo mb-4 text-center text-5xl font-black leading-tight text-white drop-shadow-lg lg:text-6xl"
          >
            <span>{{ $t('system.title') }}</span>
          </h1>
          <div
            class="mx-auto h-1 w-24 rounded-full bg-gradient-to-r from-[#fffbe6] via-[#fbe66b] to-white/85 dark:from-[#539dfd] dark:to-[#8cc8ff]"
          ></div>
        </div>

        <div class="mb-8 max-w-md space-y-4 text-center">
          <p class="text-center text-2xl font-medium leading-relaxed text-white/90">高性能现代化全栈博客系统</p>
          <p class="text-center text-lg leading-relaxed text-white/70">后端基于 C#.Net + SqlSugar + PostgreSql 构建</p>
          <p class="text-center text-lg leading-relaxed text-white/70">
            前端基于 TypeScript + Vue + Ant Design Vue 构建
          </p>
        </div>

        <div class="mb-8 flex flex-wrap justify-center gap-2">
          <span class="rounded-full bg-white/20 px-3 py-1 text-lg text-white backdrop-blur-sm">响应式设计</span>
          <span class="rounded-full bg-white/20 px-3 py-1 text-lg text-white backdrop-blur-sm">暗色模式</span>
          <span class="rounded-full bg-white/20 px-3 py-1 text-lg text-white backdrop-blur-sm">优雅界面</span>
          <span class="rounded-full bg-white/20 px-3 py-1 text-lg text-white backdrop-blur-sm">高性能</span>
        </div>

        <div class="developer-visual relative flex justify-center">
          <div class="absolute inset-0 rounded-2xl bg-gradient-to-t from-white/20 to-transparent"></div>
          <img
            :src="loadingSvg"
            alt="Mint loading"
            class="h-auto w-64 rounded-2xl object-contain opacity-90 drop-shadow-2xl"
          />
        </div>
      </div>
    </div>

    <div
      class="login-form-panel relative col-span-1 bg-[linear-gradient(145deg,rgba(255,251,230,0.92)_0%,rgba(253,241,181,0.82)_40%,rgba(213,247,232,0.72)_100%)] backdrop-blur-xl transition-all duration-500 dark:bg-[linear-gradient(145deg,rgba(35,43,56,0.94)_0%,rgba(44,51,62,0.82)_52%,rgba(17,24,39,0.94)_100%)] lg:col-span-1"
    >
      <div
        class="absolute right-0 top-0 h-72 w-72 rounded-full bg-gradient-to-bl from-[#fbe66b]/45 via-[#3ecf9a]/18 to-transparent blur-3xl dark:from-[#539dfd]/18 dark:via-[#8cc8ff]/8"
      ></div>
      <div
        class="absolute bottom-0 left-0 h-96 w-96 rounded-full bg-gradient-to-tr from-[#3ecf9a]/22 via-[#dbe049]/18 to-transparent blur-3xl dark:from-[#539dfd]/12 dark:via-[#8cc8ff]/8"
      ></div>

      <div
        class="login-tools absolute right-3 top-3 z-20 flex items-center gap-1.5 rounded-full border border-[#3ecf9a]/18 bg-white/72 px-2.5 py-1 shadow-[0_10px_28px_rgba(62,207,154,0.14)] backdrop-blur-md dark:border-[#539dfd]/18 dark:bg-[#232b38]/72 sm:right-6 sm:top-6 sm:gap-3 sm:px-4 sm:py-2"
      >
        <ThemeSchemaSwitch
          :theme-schema="themeStore.themeScheme"
          :show-tooltip="false"
          class="theme-switch text-[16px] sm:text-[20px]"
          @switch="themeStore.toggleThemeScheme"
        />
        <LangSwitch
          :lang="appStore.locale"
          :lang-options="appStore.localeOptions"
          :show-tooltip="false"
          @change-lang="appStore.changeLocale"
        />
      </div>

      <div class="relative z-10 flex h-full flex-col items-center justify-center px-8 py-14 lg:px-16 lg:py-0">
        <div class="mb-5 text-center lg:hidden">
          <h1 class="typing-mobile mb-0 text-4xl font-black text-[#3ecf9a] dark:text-[#8cc8ff]">
            <span
              class="bg-gradient-to-r from-[#fac506] via-[#dbe049] to-[#3ecf9a] bg-clip-text text-transparent dark:from-[#539dfd] dark:to-[#8cc8ff]"
            >
              Mint.
            </span>
            <span
              class="bg-gradient-to-r from-[#3ecf9a] to-[#2faa7d] bg-clip-text text-transparent dark:from-[#8cc8ff] dark:to-[#539dfd]"
            >
              Blog
            </span>
          </h1>
          <div
            class="mx-auto mb-4 h-3 w-52 rounded-full bg-gradient-to-r from-[#fbe66b] via-[#dbe049] to-[#3ecf9a] lg:h-1 lg:w-24 dark:from-[#539dfd] dark:to-[#8cc8ff]"
          ></div>
          <p class="text-sm text-[#60786e] dark:text-[#cbd5e1]">现代化博客管理平台</p>
        </div>

        <div class="mb-0 text-center">
          <h2 class="mb-3 text-3xl font-bold text-[#0d3d2d] transition-colors duration-300 dark:text-white lg:text-4xl">
            {{ $t('page.login.pwdLogin.title') }}
          </h2>
        </div>

        <div class="w-full max-w-sm">
          <AForm ref="formRef" :rules="rules" :model="form" layout="vertical" class="space-y-6">
            <AFormItem name="userName" class="mb-0">
              <label class="input-label">
                {{ $t('page.login.common.userNamePlaceholder') }}
              </label>
              <div class="input-wrapper group relative">
                <div class="input-icon-wrapper">
                  <UserOutlined class="input-icon" />
                </div>
                <AInput
                  v-model:value="form.userName"
                  size="large"
                  :placeholder="$t('page.login.common.userNamePlaceholder')"
                  allow-clear
                  :bordered="false"
                  class="login-input"
                />
              </div>
            </AFormItem>

            <AFormItem name="password" class="mb-0">
              <label class="input-label">
                {{ $t('page.login.common.passwordPlaceholder') }}
              </label>
              <div class="input-wrapper group relative">
                <div class="input-icon-wrapper">
                  <LockOutlined class="input-icon" />
                </div>
                <AInputPassword
                  v-model:value="form.password"
                  size="large"
                  :placeholder="$t('page.login.common.passwordPlaceholder')"
                  allow-clear
                  :bordered="false"
                  class="login-input"
                  @keyup.enter="handleEnter"
                />
              </div>
            </AFormItem>

            <div class="pt-0">
              <AButton
                class="login-button w-full"
                size="large"
                :loading="authStore.loginLoading"
                type="primary"
                @click="handleSubmit"
              >
                <span class="login-button-text font-medium">
                  {{ $t('page.login.pwdLogin.title') }}
                </span>
              </AButton>
            </div>
          </AForm>

          <div class="login-footnote mt-8 text-center">
            <p class="text-sm text-[#60786e] transition-colors duration-300 dark:text-[#cbd5e1] lg:text-base">
              <span>登录即表示您同意</span>
              <span class="login-footnote-link">服务条款</span>
              <span>和</span>
              <span class="login-footnote-link">隐私政策</span>
            </p>
            <p class="text-sm text-[#60786e] transition-colors duration-300 dark:text-[#cbd5e1] lg:text-base">
              <span>最终解释权归作者</span>
              <span class="login-footnote-author">程序员-杨工子</span>
              <span>所有 2026-{{ new Date().getFullYear() }}</span>
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.login-page {
  padding-top: env(safe-area-inset-top, 0px) !important;
  padding-bottom: env(safe-area-inset-bottom, 0px) !important;
  animation: fade-in 1.5s ease-out;
}

.login-brand {
  animation: slide-in-from-left 1s ease-out;

  > .absolute:nth-child(2) {
    animation: pulse 4s ease-in-out infinite;
  }

  > .absolute:nth-child(3) {
    animation: float 6s ease-in-out infinite;
  }
}

.login-form-panel {
  animation: slide-in-from-right 1s ease-out;

  > .absolute:nth-child(1) {
    animation: float 10s ease-in-out infinite;
  }

  > .absolute:nth-child(2) {
    animation: float 12s ease-in-out infinite reverse;
  }
}

.developer-visual img {
  animation: float 8s ease-in-out infinite;
  transition: all 0.4s ease;

  &:hover {
    filter: brightness(1.1);
    transform: scale(1.05) rotate(2deg);
  }
}

.login-brand .flex.flex-wrap span {
  cursor: default;
  transition: all 0.3s ease;

  &:hover {
    transform: translateY(-2px) scale(1.05);
    background: rgb(255 255 255 / 30%);
    box-shadow: 0 4px 15px rgb(255 255 255 / 20%);
  }

  &:active {
    animation: heartbeat 0.6s ease;
  }
}

.theme-switch {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);

  &:hover {
    animation: pulse 0.5s ease;
  }

  &:active {
    animation: bounce 0.3s ease;
  }
}

.login-footnote {
  p {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: center;
    gap: 4px;
  }
}

.login-footnote-link {
  cursor: pointer;
  color: #2faa7d;
  font-weight: 700;
  transition:
    color 0.2s ease,
    text-shadow 0.2s ease,
    transform 0.2s ease;
}

.login-footnote-link:hover {
  color: #3ecf9a;
  text-shadow: 0 0 14px rgb(62 207 154 / 28%);
  transform: translateY(-1px);
}

.login-footnote-author {
  cursor: pointer;
  color: #2faa7d;
  font-weight: 800;
  transition:
    color 0.2s ease,
    text-shadow 0.2s ease,
    transform 0.2s ease;
}

.login-footnote-author:hover {
  color: #2faa7d;
  text-shadow: 0 0 14px rgb(47 170 125 / 24%);
  transform: translateY(-1px);
}

.typing-logo {
  display: inline-flex;
  justify-content: center;
  max-width: 100%;
}

.typing-logo > span,
.typing-mobile {
  display: inline-block;
  width: fit-content;
  max-width: 100%;
  overflow: hidden;
  white-space: nowrap;
  border-right: 2px solid currentColor;
  animation:
    typing 2s steps(20) 0.5s both,
    blink 1s step-end infinite 2.5s;
}

.input-label {
  display: block;
  margin-bottom: 8px;
  color: #0d3d2d;
  font-size: 14px;
  font-weight: 600;
  letter-spacing: 0.025em;
  transition: color 0.3s ease;
}

.input-wrapper {
  position: relative;
  overflow: hidden;
  border: 1px solid rgb(62 207 154 / 18%);
  border-radius: 20px;
  background: linear-gradient(
    135deg,
    rgb(255 255 255 / 92%) 0%,
    rgb(255 251 230 / 84%) 48%,
    rgb(213 247 232 / 72%) 100%
  );
  box-shadow:
    0 4px 20px rgb(62 207 154 / 10%),
    0 1px 3px rgb(47 170 125 / 6%);
  padding-left: 56px;
  backdrop-filter: blur(20px);
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.input-wrapper:hover {
  transform: translateY(-3px);
  border-color: rgb(62 207 154 / 42%);
  background: linear-gradient(
    135deg,
    rgb(255 255 255 / 96%) 0%,
    rgb(255 251 230 / 88%) 44%,
    rgb(213 247 232 / 82%) 100%
  );
  box-shadow:
    0 8px 30px rgb(62 207 154 / 16%),
    0 4px 12px rgb(47 170 125 / 8%);
}

.input-wrapper:focus-within {
  transform: translateY(-3px) scale(1.01);
  border-color: #3ecf9a;
  background: linear-gradient(
    135deg,
    rgb(255 255 255 / 98%) 0%,
    rgb(255 251 230 / 90%) 44%,
    rgb(213 247 232 / 88%) 100%
  );
  box-shadow:
    0 0 0 4px rgb(62 207 154 / 16%),
    0 12px 40px rgb(47 170 125 / 18%);
}

.input-icon-wrapper {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  z-index: 1;
  display: flex;
  width: 56px;
  align-items: center;
  justify-content: center;
  border-radius: 20px 0 0 20px;
  background: linear-gradient(135deg, rgb(62 207 154 / 13%) 0%, rgb(219 224 73 / 10%) 100%);
  transition: all 0.3s ease;
}

.input-wrapper:focus-within .input-icon-wrapper {
  background: linear-gradient(135deg, rgb(62 207 154 / 20%) 0%, rgb(219 224 73 / 14%) 100%);
}

.input-icon {
  color: #2faa7d;
  font-size: 18px;
  opacity: 0.8;
  transition: all 0.3s ease;
}

.input-wrapper:focus-within .input-icon {
  color: #15956b;
  opacity: 1;
  transform: scale(1.1);
}

:deep(.login-input) {
  width: 100% !important;
  padding: 12px 16px !important;
  border-radius: 0 20px 20px 0 !important;

  .ant-input,
  &.ant-input-affix-wrapper,
  &.ant-input-password {
    border: none !important;
    border-radius: 0 20px 20px 0 !important;
    background: transparent !important;
    box-shadow: none !important;
  }

  .ant-input {
    color: #0d3d2d;
    font-weight: 500;
  }

  .ant-input::placeholder {
    color: #60786e;
  }

  &.ant-input-password .ant-input {
    border-radius: 0 !important;
  }
}

:deep(.login-input input:-webkit-autofill),
:deep(.login-input input:-webkit-autofill:hover),
:deep(.login-input input:-webkit-autofill:focus),
:deep(.login-input input:-webkit-autofill:active) {
  box-shadow: 0 0 0 1000px rgb(255 255 255 / 0%) inset !important;
  -webkit-box-shadow: 0 0 0 1000px rgb(255 255 255 / 0%) inset !important;
  -webkit-text-fill-color: #0d3d2d !important;
  caret-color: #0d3d2d !important;
  transition: background-color 9999s ease-in-out 0s;
}

:global(html.dark) :deep(.login-input input:-webkit-autofill),
:global(html.dark) :deep(.login-input input:-webkit-autofill:hover),
:global(html.dark) :deep(.login-input input:-webkit-autofill:focus),
:global(html.dark) :deep(.login-input input:-webkit-autofill:active) {
  box-shadow: 0 0 0 1000px rgb(35 43 56 / 98%) inset !important;
  -webkit-box-shadow: 0 0 0 1000px rgb(35 43 56 / 98%) inset !important;
  -webkit-text-fill-color: #e4e4e7 !important;
  caret-color: #8cc8ff !important;
}

:deep(.ant-form-item) {
  width: 100% !important;
  margin-bottom: 24px;

  .ant-form-item-control,
  .ant-form-item-control-input,
  .ant-form-item-control-input-content {
    width: 100% !important;
  }

  .ant-form-item-explain {
    margin-top: 8px;
    color: #ef4444;
    font-size: 14px;
    animation: slide-down 0.3s ease;
  }
}

:deep(.login-button) {
  position: relative;
  height: 45.6px !important;
  overflow: hidden;
  border: none;
  border-radius: 12px;
  background: linear-gradient(135deg, #fac506 0%, #dbe049 48%, #3ecf9a 100%);
  box-shadow: 0 4px 15px rgb(62 207 154 / 32%);
  font-size: 16px;
  font-weight: 600;
  transition: all 0.3s ease;

  &::before {
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgb(255 255 255 / 20%), transparent);
    content: '';
    transition: left 0.5s;
  }

  &:hover {
    transform: translateY(-2px);
    background: linear-gradient(135deg, #fdeb99 0%, #dbe049 42%, #2faa7d 100%) !important;
    box-shadow: 0 8px 25px rgb(62 207 154 / 42%);

    &::before {
      left: 100%;
    }
  }

  &:active {
    animation: bounce 0.6s ease;
    transform: translateY(0);
  }

  &:focus {
    box-shadow: 0 0 0 3px rgb(62 207 154 / 28%);
  }

  &.ant-btn-loading::after {
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgb(255 255 255 / 20%), transparent);
    animation: loading-shimmer 1.5s infinite;
    content: '';
  }
}

:global(html.dark) .login-tools {
  border-color: rgb(83 157 253 / 22%) !important;
  background: rgb(35 43 56 / 82%) !important;
  box-shadow: 0 10px 28px rgb(83 157 253 / 16%) !important;
}

:global(html.dark) .login-tools :deep(.ant-btn),
:global(html.dark) .login-tools :deep(.ant-select-selector),
:global(html.dark) .login-tools :deep(.ant-dropdown-trigger),
:global(html.dark) .login-tools :deep(button) {
  color: #8cc8ff !important;
  border-color: rgb(83 157 253 / 18%) !important;
  background: rgb(83 157 253 / 8%) !important;
  box-shadow: none !important;
}

:global(html.dark) .login-tools :deep(.ant-btn:hover),
:global(html.dark) .login-tools :deep(button:hover) {
  color: #d8ecff !important;
  border-color: rgb(83 157 253 / 36%) !important;
  background: rgb(83 157 253 / 14%) !important;
  box-shadow: 0 0 0 3px rgb(83 157 253 / 14%) !important;
}

:global(html.dark) .input-label {
  color: #e2e8f0;
}

:global(html.dark) .input-wrapper {
  border-color: rgb(83 157 253 / 24%);
  background: linear-gradient(135deg, rgb(44 51 62 / 92%) 0%, rgb(35 43 56 / 90%) 54%, rgb(17 24 39 / 92%) 100%);
  box-shadow:
    0 4px 20px rgb(0 0 0 / 20%),
    0 1px 3px rgb(0 0 0 / 30%);
}

:global(html.dark) .input-wrapper:hover {
  border-color: rgb(83 157 253 / 46%);
  background: linear-gradient(135deg, rgb(44 51 62 / 98%) 0%, rgb(35 43 56 / 96%) 54%, rgb(17 24 39 / 96%) 100%);
  box-shadow:
    0 8px 30px rgb(83 157 253 / 14%),
    0 4px 12px rgb(0 0 0 / 25%);
}

:global(html.dark) .input-wrapper:focus-within {
  border-color: #539dfd;
  background: linear-gradient(135deg, rgb(44 51 62) 0%, rgb(35 43 56 / 98%) 54%, rgb(17 24 39 / 98%) 100%);
  box-shadow:
    0 0 0 4px rgb(83 157 253 / 18%),
    0 12px 40px rgb(83 157 253 / 22%);
}

:global(html.dark) .input-icon-wrapper {
  background: linear-gradient(135deg, rgb(83 157 253 / 14%) 0%, rgb(140 200 255 / 8%) 100%);
}

:global(html.dark) .input-wrapper:focus-within .input-icon-wrapper {
  background: linear-gradient(135deg, rgb(83 157 253 / 20%) 0%, rgb(140 200 255 / 12%) 100%);
}

:global(html.dark) .input-icon {
  color: #539dfd;
}

:global(html.dark) .input-wrapper:focus-within .input-icon {
  color: #8cc8ff;
}

:global(html.dark) :deep(.login-input) {
  .ant-input,
  &.ant-input-affix-wrapper,
  &.ant-input-password {
    color: #e4e4e7 !important;
    -webkit-text-fill-color: #e4e4e7 !important;
    caret-color: #8cc8ff !important;
  }

  .ant-input::placeholder {
    color: #a1a1aa !important;
    -webkit-text-fill-color: #a1a1aa !important;
  }

  .ant-input-password-icon,
  .ant-input-clear-icon {
    color: #8cc8ff !important;
  }
}

:global(html.dark) :deep(.login-button) {
  background: linear-gradient(135deg, #539dfd 0%, #8cc8ff 100%) !important;
  box-shadow: 0 4px 15px rgb(83 157 253 / 28%) !important;
  color: #ffffff !important;
}

:global(html.dark) :deep(.login-button:hover),
:global(html.dark) :deep(.login-button:focus) {
  background: linear-gradient(135deg, #8cc8ff 0%, #539dfd 100%) !important;
  box-shadow: 0 8px 25px rgb(83 157 253 / 36%) !important;
  color: #ffffff !important;
}

@keyframes typing {
  from {
    width: 0;
  }

  to {
    width: 100%;
  }
}

@keyframes blink {
  0%,
  50% {
    border-right-color: transparent;
  }

  51%,
  100% {
    border-right-color: currentColor;
  }
}

@keyframes slide-in-from-left {
  from {
    opacity: 0;
    transform: translateX(-100%);
  }

  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes slide-in-from-right {
  from {
    opacity: 0;
    transform: translateX(100%);
  }

  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes fade-in {
  from {
    opacity: 0;
  }

  to {
    opacity: 1;
  }
}

@keyframes float {
  0%,
  100% {
    transform: translateY(0);
  }

  50% {
    transform: translateY(-10px);
  }
}

@keyframes pulse {
  0%,
  100% {
    opacity: 1;
  }

  50% {
    opacity: 0.8;
  }
}

@keyframes bounce {
  0%,
  20%,
  53%,
  80%,
  100% {
    transform: translate3d(0, 0, 0);
  }

  40%,
  43% {
    transform: translate3d(0, -8px, 0);
  }

  70% {
    transform: translate3d(0, -4px, 0);
  }

  90% {
    transform: translate3d(0, -2px, 0);
  }
}

@keyframes heartbeat {
  0% {
    transform: scale(1);
  }

  14% {
    transform: scale(1.1);
  }

  28% {
    transform: scale(1);
  }

  42% {
    transform: scale(1.1);
  }

  70% {
    transform: scale(1);
  }
}

@keyframes slide-down {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }

  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes loading-shimmer {
  0% {
    left: -100%;
  }

  100% {
    left: 100%;
  }
}

@media (max-width: 767px) {
  .login-page {
    grid-template-columns: 1fr;
    min-height: 100vh;
  }

  .login-form-panel {
    display: flex;
    min-height: 100vh;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 16px;
  }

  .typing-mobile {
    min-height: 48px;
    line-height: 1.2;
  }

  :deep(.login-input) {
    .ant-input {
      border-radius: 10px;
      font-size: 16px;
    }

    &.ant-input-affix-wrapper,
    &.ant-input-password {
      border-radius: 0 20px 20px 0 !important;
    }
  }

  :deep(.login-button) {
    height: 45px !important;
    margin-top: 20px;
    border-radius: 10px;
    font-size: 16px;
  }
}
</style>

<style lang="scss">
html.dark .login-page .login-tools {
  border-color: rgb(83 157 253 / 24%) !important;
  background: rgb(35 43 56 / 86%) !important;
  box-shadow: 0 10px 28px rgb(83 157 253 / 16%) !important;
}

html.dark .login-page .login-tools,
html.dark .login-page .login-tools * {
  color: #8cc8ff !important;
}

html.dark .login-page .login-tools button,
html.dark .login-page .login-tools .ant-btn,
html.dark .login-page .login-tools .ant-select-selector,
html.dark .login-page .login-tools .ant-dropdown-trigger {
  border-color: transparent !important;
  background: transparent !important;
  box-shadow: none !important;
  transition:
    color 0.2s ease,
    background-color 0.2s ease,
    transform 0.2s ease !important;
}

html.dark .login-page .login-tools button:hover,
html.dark .login-page .login-tools .ant-btn:hover,
html.dark .login-page .login-tools .ant-dropdown-trigger:hover {
  border-color: transparent !important;
  background: rgb(83 157 253 / 10%) !important;
  box-shadow: none !important;
  transform: translateY(-1px) scale(1.04);
}

html.dark .login-page .input-wrapper {
  border-color: rgb(83 157 253 / 26%) !important;
  background: linear-gradient(
    135deg,
    rgb(44 51 62 / 94%) 0%,
    rgb(35 43 56 / 92%) 54%,
    rgb(17 24 39 / 94%) 100%
  ) !important;
  box-shadow:
    0 4px 20px rgb(0 0 0 / 20%),
    0 1px 3px rgb(0 0 0 / 30%) !important;
}

html.dark .login-page .input-wrapper:hover {
  border-color: rgb(83 157 253 / 48%) !important;
  background: linear-gradient(
    135deg,
    rgb(44 51 62 / 98%) 0%,
    rgb(35 43 56 / 96%) 54%,
    rgb(17 24 39 / 96%) 100%
  ) !important;
  box-shadow:
    0 8px 30px rgb(83 157 253 / 14%),
    0 4px 12px rgb(0 0 0 / 25%) !important;
}

html.dark .login-page .input-wrapper:focus-within {
  border-color: #539dfd !important;
  background: linear-gradient(135deg, rgb(44 51 62) 0%, rgb(35 43 56 / 98%) 54%, rgb(17 24 39 / 98%) 100%) !important;
  box-shadow:
    0 0 0 4px rgb(83 157 253 / 18%),
    0 12px 40px rgb(83 157 253 / 22%) !important;
}

html.dark .login-page .input-icon-wrapper {
  background: linear-gradient(135deg, rgb(83 157 253 / 14%) 0%, rgb(140 200 255 / 8%) 100%) !important;
}

html.dark .login-page .input-wrapper:focus-within .input-icon-wrapper {
  background: linear-gradient(135deg, rgb(83 157 253 / 20%) 0%, rgb(140 200 255 / 12%) 100%) !important;
}

html.dark .login-page .input-icon,
html.dark .login-page .input-wrapper:focus-within .input-icon {
  color: #8cc8ff !important;
}

html.dark .login-page .login-input,
html.dark .login-page .login-input.ant-input-affix-wrapper,
html.dark .login-page .login-input.ant-input-password,
html.dark .login-page .login-input .ant-input,
html.dark .login-page .login-input input,
html.dark .login-page .ant-input,
html.dark .login-page .ant-input-password input {
  color: #e4e4e7 !important;
  background: transparent !important;
  -webkit-text-fill-color: #e4e4e7 !important;
  caret-color: #8cc8ff !important;
}

html.dark .login-page .login-input .ant-input::placeholder,
html.dark .login-page .login-input input::placeholder,
html.dark .login-page .ant-input::placeholder {
  color: #a1a1aa !important;
  -webkit-text-fill-color: #a1a1aa !important;
}

html.dark .login-page .login-input .ant-input-password-icon,
html.dark .login-page .login-input .ant-input-clear-icon,
html.dark .login-page .ant-input-password-icon,
html.dark .login-page .ant-input-clear-icon {
  color: #8cc8ff !important;
}

html.dark .login-page .login-button,
html.dark .login-page .login-button.ant-btn,
html.dark .login-page .login-button.ant-btn-primary {
  border: none !important;
  background: linear-gradient(135deg, #539dfd 0%, #8cc8ff 100%) !important;
  background-color: #539dfd !important;
  box-shadow: 0 4px 15px rgb(83 157 253 / 28%) !important;
  color: #ffffff !important;
  font-weight: 900 !important;
}

html.dark .login-page .login-button:hover,
html.dark .login-page .login-button:focus,
html.dark .login-page .login-button.ant-btn-primary:hover,
html.dark .login-page .login-button.ant-btn-primary:focus {
  background: linear-gradient(135deg, #8cc8ff 0%, #539dfd 100%) !important;
  background-color: #8cc8ff !important;
  box-shadow: 0 8px 25px rgb(83 157 253 / 36%) !important;
  color: #ffffff !important;
}

html.dark .login-page .login-button span,
html.dark .login-page .login-button .ant-btn-loading-icon {
  color: #ffffff !important;
  font-weight: 900 !important;
}

html.dark .login-page .login-footnote {
  color: #cbd5e1;
}

html.dark .login-page .login-footnote-link {
  cursor: pointer;
  color: #8cc8ff !important;
  font-weight: 800;
  transition:
    color 0.2s ease,
    text-shadow 0.2s ease,
    transform 0.2s ease;
}

html.dark .login-page .login-footnote-link:hover {
  color: #d8ecff !important;
  text-shadow: 0 0 16px rgb(83 157 253 / 34%);
  transform: translateY(-1px);
}

html.dark .login-page .login-footnote-author {
  cursor: pointer;
  color: #8cc8ff !important;
  font-weight: 900;
  transition:
    color 0.2s ease,
    text-shadow 0.2s ease,
    transform 0.2s ease;
}

html.dark .login-page .login-footnote-author:hover {
  color: #8cc8ff !important;
  text-shadow: 0 0 16px rgb(140 200 255 / 34%);
  transform: translateY(-1px);
}

.dark .login-page .login-button-text,
html.dark .login-page .login-button-text,
.dark .login-page .login-button span,
html.dark .login-page .login-button span,
.dark .login-page .login-button .ant-btn-loading-icon,
html.dark .login-page .login-button .ant-btn-loading-icon {
  color: #ffffff !important;
  -webkit-text-fill-color: #ffffff !important;
  font-weight: 900 !important;
}

.dark .login-page .login-footnote .login-footnote-link,
html.dark .login-page .login-footnote .login-footnote-link,
.dark .login-page .login-footnote .login-footnote-author,
html.dark .login-page .login-footnote .login-footnote-author {
  cursor: pointer;
  color: #8cc8ff !important;
  -webkit-text-fill-color: #8cc8ff !important;
}

.dark .login-page .login-footnote .login-footnote-link:hover,
html.dark .login-page .login-footnote .login-footnote-link:hover,
.dark .login-page .login-footnote .login-footnote-author:hover,
html.dark .login-page .login-footnote .login-footnote-author:hover {
  color: #d8ecff !important;
  -webkit-text-fill-color: #d8ecff !important;
  text-shadow: 0 0 16px rgb(83 157 253 / 34%);
  transform: translateY(-1px);
}
</style>
