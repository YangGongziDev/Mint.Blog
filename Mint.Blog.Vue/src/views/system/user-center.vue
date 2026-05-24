<template>
  <ASpace direction="vertical" :size="16" class="w-full">
    <ARow :gutter="[16, 16]">
      <ACol :span="24" :lg="8">
        <ACard :bordered="false" class="card-wrapper h-full">
          <div class="flex flex-col items-center gap-4 py-4 text-center">
            <div class="h-[96px] w-[96px] overflow-hidden rounded-full ring-4 ring-primary/15">
              <img :src="avatarSrc" class="size-full object-cover" alt="" />
            </div>
            <div class="w-full space-y-2">
              <h2 class="text-[20px] font-semibold">{{ authStore.userInfo.displayName }}</h2>
              <p class="text-sm text-base-text/60">@{{ authStore.userInfo.userName }}</p>
              <div class="flex flex-wrap justify-center gap-2 pt-1">
                <ATag v-for="role in authStore.userInfo.roles" :key="role" color="processing">
                  {{ role }}
                </ATag>
                <ATag v-if="!authStore.userInfo.roles.length" color="default">
                  {{ $t('page.userCenter.noRoles') }}
                </ATag>
              </div>
            </div>
            <ADivider class="!my-2" />
            <div class="w-full space-y-3 text-left text-sm">
              <div class="flex items-center justify-between gap-3">
                <span class="text-base-text/60">{{ $t('page.userCenter.userId') }}</span>
                <span class="font-medium">{{ authStore.userInfo.userId || '-' }}</span>
              </div>
              <div class="rounded-xl bg-primary/5 p-4 text-left text-sm leading-6 text-base-text/70">
                {{ $t('page.userCenter.profileDesc') }}
              </div>
            </div>
          </div>
        </ACard>
      </ACol>

      <ACol :span="24" :lg="16">
        <ASpace direction="vertical" :size="16" class="w-full">
          <ACard :title="$t('page.userCenter.basicInfo')" :bordered="false" class="card-wrapper">
            <AForm
              ref="profileFormRef"
              :model="profileForm"
              :rules="profileRules"
              :label-col="{ span: 6, md: 5 }"
              :wrapper-col="{ span: 18, md: 17 }"
              class="max-w-[640px]"
            >
              <AFormItem :label="$t('page.userCenter.userName')" name="userName">
                <AInput v-model:value="profileForm.userName" disabled />
                <p class="mt-1 text-xs text-base-text/50">{{ $t('page.userCenter.userNameReadonlyTip') }}</p>
              </AFormItem>
              <AFormItem :label="$t('page.userCenter.displayName')" name="displayName">
                <AInput v-model:value="profileForm.displayName" allow-clear :maxlength="32" />
              </AFormItem>
              <AFormItem :wrapper-col="{ offset: 6, md: { offset: 5 } }">
                <AButton type="primary" :loading="profileLoading" @click="handleProfileSubmit">
                  {{ $t('page.userCenter.updateProfile') }}
                </AButton>
              </AFormItem>
            </AForm>
          </ACard>

          <ACard :title="$t('page.userCenter.security')" :bordered="false" class="card-wrapper">
            <AForm
              ref="passwordFormRef"
              :model="passwordForm"
              :rules="passwordRules"
              :label-col="{ span: 6, md: 5 }"
              :wrapper-col="{ span: 18, md: 17 }"
              class="max-w-[640px]"
            >
              <AFormItem :label="$t('page.userCenter.newPassword')" name="password">
                <AInputPassword v-model:value="passwordForm.password" autocomplete="new-password" />
              </AFormItem>
              <AFormItem :label="$t('page.userCenter.confirmPassword')" name="confirmPassword">
                <AInputPassword v-model:value="passwordForm.confirmPassword" autocomplete="new-password" />
              </AFormItem>
              <AFormItem :wrapper-col="{ offset: 6, md: { offset: 5 } }">
                <AButton type="primary" :loading="passwordLoading" @click="handlePasswordSubmit">
                  {{ $t('page.userCenter.updatePassword') }}
                </AButton>
              </AFormItem>
            </AForm>
          </ACard>

          <ACard :title="$t('page.userCenter.permissionInfo')" :bordered="false" class="card-wrapper">
            <div class="space-y-4">
              <div class="space-y-2">
                <div class="text-sm text-base-text/60">{{ $t('page.userCenter.roles') }}</div>
                <div class="flex flex-wrap gap-2">
                  <ATag v-for="role in authStore.userInfo.roles" :key="`role-${role}`" color="blue">
                    {{ role }}
                  </ATag>
                  <span v-if="!authStore.userInfo.roles.length" class="text-sm text-base-text/50">
                    {{ $t('page.userCenter.noRoles') }}
                  </span>
                </div>
              </div>
              <div class="space-y-2">
                <div class="text-sm text-base-text/60">{{ $t('page.userCenter.buttons') }}</div>
                <div class="flex flex-wrap gap-2">
                  <ATag v-for="code in authStore.userInfo.buttons" :key="`btn-${code}`">
                    {{ code }}
                  </ATag>
                  <span v-if="!authStore.userInfo.buttons.length" class="text-sm text-base-text/50">
                    {{ $t('page.userCenter.noButtons') }}
                  </span>
                </div>
              </div>
            </div>
          </ACard>
        </ASpace>
      </ACol>
    </ARow>
  </ASpace>
</template>

<script setup lang="ts">
import { computed, reactive, ref, watch } from 'vue';
import { useAuthStore } from '@/store/system/auth';
import { fetchGetUserInfo } from '@/service/system/auth';
import { fetchUpdatePassword, fetchUpdateUser } from '@/service/system/user';
import { useAntdForm, useFormRules } from '@/hooks/form/use-antd-form';
import { $t } from '@/locales';
import avatarSrc from '@/assets/blog/surfer/author/author-yangmufa-picture.jpg';

defineOptions({
  name: 'SystemUserCenter'
});

const authStore = useAuthStore();
const { defaultRequiredRule, formRules, createConfirmPwdRule } = useFormRules();
const { formRef: profileFormRef, validate: validateProfile, resetFields: resetProfileFields } = useAntdForm();
const { formRef: passwordFormRef, validate: validatePassword, resetFields: resetPasswordFields } = useAntdForm();

const profileLoading = ref(false);
const passwordLoading = ref(false);

const profileForm = reactive({
  userName: '',
  displayName: ''
});

const passwordForm = reactive({
  password: '',
  confirmPassword: ''
});

const profileRules = {
  displayName: [defaultRequiredRule]
};

const passwordRules = computed(() => ({
  password: formRules.pwd,
  confirmPassword: createConfirmPwdRule(computed(() => passwordForm.password))
}));

function syncProfileForm() {
  profileForm.userName = authStore.userInfo.userName;
  profileForm.displayName = authStore.userInfo.displayName;
}

async function refreshUserInfo() {
  const { data, error } = await fetchGetUserInfo();
  if (!error && data) {
    Object.assign(authStore.userInfo, data);
    syncProfileForm();
  }
}

async function handleProfileSubmit() {
  await validateProfile();

  const userId = Number(authStore.userInfo.userId);
  if (!userId) return;

  profileLoading.value = true;
  try {
    const { error } = await fetchUpdateUser(userId, {
      userName: authStore.userInfo.userName,
      displayName: profileForm.displayName.trim(),
      isDeleted: 0
    });
    if (error) return;

    await refreshUserInfo();
    window.$message?.success($t('common.updateSuccess'));
  } finally {
    profileLoading.value = false;
  }
}

function resetPasswordForm() {
  passwordForm.password = '';
  passwordForm.confirmPassword = '';
  resetPasswordFields();
}

async function handlePasswordSubmit() {
  await validatePassword();

  passwordLoading.value = true;
  try {
    const { error } = await fetchUpdatePassword({
      userName: authStore.userInfo.userName,
      password: passwordForm.password
    });
    if (error) return;

    resetPasswordForm();
    window.$message?.success($t('page.userCenter.passwordUpdated'));
    await authStore.logout();
  } finally {
    passwordLoading.value = false;
  }
}

watch(
  () => authStore.userInfo,
  () => {
    syncProfileForm();
  },
  { immediate: true, deep: true }
);
</script>

<style scoped lang="scss"></style>
