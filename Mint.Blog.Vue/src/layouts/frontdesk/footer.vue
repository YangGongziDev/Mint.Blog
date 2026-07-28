<template>
  <div class="surfer-footer">
    <div class="footer-animals-layer" data-footer-animals>
      <div class="footer-animals-wrap">
        <img src="@/assets/blog/surfer/footer/animals.png" alt="动物" class="footer-animals" />
      </div>
    </div>

    <div class="footer-main px-5 sm:px-10">
      <!-- <div class="footer-profile mx-auto flex max-w-screen-xl flex-col items-center justify-center py-4 text-center">
        <img :src="authorAvatar" alt="作者头像" class="footer-avatar" @error="handleAvatarError" />
        <h2 class="footer-description">
          {{ settings.introduction || 'Fresh content, gentle reading' }}
        </h2>
      </div> -->

      <div class="footer-copyright">
        <div class="footer-copyright-line">
        <img :src="authorAvatar" alt="作者头像" class="footer-logo" @error="handleLogoError" />
          <span>
            © {{ new Date().getFullYear() }}
            <a href="https://www.yanggongzi.dev/blog/surfer/me" target="_blank" rel="noopener noreferrer">
              程序员-杨工子
            </a>
            All Rights Reserved.
          </span>
        </div>
        <div class="footer-powered-by">
          <img :src="blogLogo" alt="博客LOGO" class="footer-logo" @error="handleLogoError" />
          <span>
            基于开源项目
            <a href="https://gitee.com/YangGongziDev/Mint.Blog" target="_blank" rel="noopener noreferrer">
              Mint.Blog
            </a>
            构建
          </span>
        </div>
        <div v-if="false" class="footer-icp">
          <img src="@/assets/blog/surfer/footer/gonan.png" alt="备案图标" class="footer-icp-icon" />
          <a href="https://beian.miit.gov.cn" target="_blank" rel="noopener noreferrer">
            沪ICP备2021016234号
          </a>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue';
import { getBlogSettingsDetail } from '@/service/blog/surfer/setting';
import DefaultAvatar from '@/assets/system/svg/avatar.svg';

defineOptions({
  name: 'Footer'
});

type Api<T> = { success: boolean; data: T };
type Settings = {
  logo?: string;
  avatar?: string;
  introduction?: string;
};

const settings = ref<Settings>({});
const defaultAvatar = DefaultAvatar;

function resolveImageUrl(url?: string) {
  if (!url) return defaultAvatar;
  if (/^(https?:|data:|blob:)/i.test(url)) return url;
  return url.startsWith('/') ? url : `/${url}`;
}

const authorAvatar = computed(() => resolveImageUrl(settings.value.avatar));
const blogLogo = computed(() => resolveImageUrl(settings.value.logo));

function handleAvatarError() {
  settings.value.avatar = defaultAvatar;
}

function handleLogoError() {
  settings.value.logo = defaultAvatar;
}

onMounted(async () => {
  try {
    const res = await getBlogSettingsDetail<Api<Settings>>();
    if (res.success) settings.value = res.data || {};
  } catch {
    settings.value = {};
  }
});
</script>

<style scoped lang="scss">
.surfer-footer {
  color: #527064;
}

.footer-animals-layer {
  position: relative;
  z-index: 30;
  display: flex;
  width: 100%;
  transform: translateY(10px);
  justify-content: center;
  background-position: center;
  background-size: cover;
}

.footer-animals-layer::after {
  position: absolute;
  bottom: 10px;
  left: 0;
  width: 100%;
  height: 60%;
  background: linear-gradient(to top, rgb(var(--layout-bg-color)), transparent);
  content: '';
}

.footer-animals-wrap {
  z-index: 40;
  display: flex;
  width: 100%;
  max-width: 1200px;
  justify-content: center;
}

.footer-animals {
  position: relative;
  z-index: 40;
  display: none;
  width: min(660px, 72vw);
  height: auto;
}

.footer-main {
  position: relative;
  margin-top: 10px;
  background: #ffffff;
  padding-top: 44px;
}

.footer-main::before {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 1px;
  background: rgb(62 207 154 / 18%);
  content: '';
}

.footer-profile {
  gap: 14px;
}

.footer-avatar {
  width: 80px;
  height: 80px;
  flex-shrink: 0;
  border: 3px solid rgb(255 255 255 / 90%);
  border-radius: 52% 48% 46% 54% / 48% 52% 48% 52%;
  object-fit: cover;
  animation:
    footer-avatar-float 4s ease-in-out infinite,
    footer-avatar-glow 2.8s ease-in-out infinite alternate,
    footer-avatar-morph 7s ease-in-out infinite;
  box-shadow:
    0 0 0 6px rgb(83 157 253 / 10%),
    0 12px 34px rgb(83 157 253 / 20%),
    0 0 42px rgb(83 157 253 / 18%);
  transition:
    transform 0.3s ease,
    box-shadow 0.3s ease,
    border-color 0.3s ease;
}

.footer-avatar:hover {
  border-radius: 48% 52% 55% 45% / 53% 46% 54% 47%;
  transform: translateY(-4px) scale(1.08) rotate(3deg);
  box-shadow:
    0 0 0 8px rgb(83 157 253 / 14%),
    0 16px 44px rgb(83 157 253 / 28%),
    0 0 56px rgb(83 157 253 / 26%);
}

@keyframes footer-avatar-float {
  0%,
  100% {
    transform: translateY(0);
  }

  50% {
    transform: translateY(-7px);
  }
}

@keyframes footer-avatar-glow {
  from {
    box-shadow:
      0 0 0 5px rgb(83 157 253 / 8%),
      0 10px 30px rgb(83 157 253 / 16%),
      0 0 32px rgb(83 157 253 / 14%);
  }

  to {
    box-shadow:
      0 0 0 8px rgb(83 157 253 / 14%),
      0 16px 44px rgb(83 157 253 / 26%),
      0 0 54px rgb(83 157 253 / 24%);
  }
}

@keyframes footer-avatar-morph {
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

.footer-description {
  width: 90%;
  max-width: 640px;
  margin: 0;
  color: #527064;
  font-size: 14px;
  line-height: 1.8;
}

.footer-icp {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding-top: 10px;
  font-size: 14px;
}

.footer-icp-icon {
  width: 20px;
  height: 22px;
  object-fit: contain;
}

.footer-icp a,
.footer-copyright a,
.footer-powered-by a {
  color: #2faa7d;
  font-weight: 700;
  transition: color 0.2s ease;
}

.footer-icp a:hover,
.footer-copyright a:hover,
.footer-powered-by a:hover {
  color: #3ecf9a;
  text-decoration: underline;
}

.footer-copyright {
  border-top: 1px solid rgb(62 207 154 / 14%);
  padding: 16px 0;
  text-align: center;
  font-size: 14px;
}

.footer-copyright-line,
.footer-powered-by {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.footer-powered-by {
  padding-top: 12px;
}

.footer-logo {
  width: 30px;
  height: 30px;
  flex-shrink: 0;
  border: 3px solid rgb(255 255 255 / 90%);
  border-radius: 52% 48% 46% 54% / 48% 52% 48% 52%;
  object-fit: cover;
  animation:
    footer-avatar-float 4s ease-in-out infinite,
    footer-avatar-glow 2.8s ease-in-out infinite alternate,
    footer-avatar-morph 7s ease-in-out infinite;
  box-shadow:
    0 0 0 6px rgb(83 157 253 / 10%),
    0 12px 34px rgb(83 157 253 / 20%),
    0 0 42px rgb(83 157 253 / 18%);
  transition:
    transform 0.3s ease,
    box-shadow 0.3s ease,
    border-color 0.3s ease;
}

.footer-logo:hover {
  border-radius: 48% 52% 55% 45% / 53% 46% 54% 47%;
  transform: translateY(-4px) scale(1.08) rotate(3deg);
  box-shadow:
    0 0 0 8px rgb(83 157 253 / 14%),
    0 16px 44px rgb(83 157 253 / 28%),
    0 0 56px rgb(83 157 253 / 26%);
}

.dark .surfer-footer {
  color: #8c9ab1;
}

.dark .footer-main {
  background: #2c333e;
}

.dark .footer-main::before {
  background: rgb(83 157 253 / 16%);
}

.dark .footer-avatar {
  border-color: rgb(148 190 255 / 22%);
  box-shadow:
    0 0 0 6px rgb(83 157 253 / 10%),
    0 12px 34px rgb(83 157 253 / 18%),
    0 0 42px rgb(83 157 253 / 16%);
}

.dark .footer-avatar:hover {
  box-shadow:
    0 0 0 8px rgb(83 157 253 / 14%),
    0 16px 44px rgb(83 157 253 / 26%),
    0 0 56px rgb(83 157 253 / 24%);
}

.dark .footer-logo {
  border-color: rgb(148 190 255 / 22%);
  box-shadow:
    0 0 0 6px rgb(83 157 253 / 10%),
    0 12px 34px rgb(83 157 253 / 18%),
    0 0 42px rgb(83 157 253 / 16%);
}

.dark .footer-logo:hover {
  box-shadow:
    0 0 0 8px rgb(83 157 253 / 14%),
    0 16px 44px rgb(83 157 253 / 26%),
    0 0 56px rgb(83 157 253 / 24%);
}

.dark .footer-description {
  color: #8c9ab1;
}

.dark .footer-copyright {
  border-top-color: rgb(83 157 253 / 14%);
}

.dark .footer-icp a,
.dark .footer-copyright a,
.dark .footer-powered-by a {
  color: #7bb6ff;
}

.dark .footer-icp a:hover,
.dark .footer-copyright a:hover,
.dark .footer-powered-by a:hover {
  color: #539dfd;
}

@media (min-width: 768px) {
  .footer-animals {
    display: block;
  }
}

@media (max-width: 767px) {
  .footer-animals-layer {
    transform: translateY(0);
  }

  .footer-animals-layer::after {
    bottom: 0;
  }

  .footer-animals {
    display: block;
    width: min(330px, 82vw);
  }

  .footer-main {
    margin-top: 0;
    padding-top: 24px;
  }

  .footer-profile {
    gap: 12px;
    text-align: center;
  }

  .footer-avatar {
    width: 64px;
    height: 64px;
    border-width: 2px;
    border-radius: 52% 48% 46% 54% / 48% 52% 48% 52%;
  }

  .footer-description {
    width: 100%;
    font-size: 13px;
  }

  .footer-icp,
  .footer-copyright {
    font-size: 12px;
  }

  .footer-copyright-line,
  .footer-powered-by {
    flex-wrap: wrap;
    gap: 6px;
  }

  .footer-powered-by {
    padding-top: 10px;
  }
}
</style>
