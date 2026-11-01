<template>
  <ASpace direction="vertical" :size="16" class="w-full">
    <ACard title="个人资料" :bordered="false" class="card-wrapper">
      <div class="mb-4 flex items-center gap-4">
        <img :src="avatarSrc" class="h-[72px] w-[72px] rounded-full object-cover" alt="" />
        <div><h2 class="text-xl font-semibold">{{ authStore.userInfo.displayName }}</h2><p>@{{ authStore.userInfo.userName }}</p></div>
      </div>
      <AAlert message="当前后端没有自助资料更新接口，资料保存未接入，此处仅供查看。管理员请在用户管理中按权限编辑。" type="info" show-icon class="mb-4" />
      <ADescriptions bordered :column="1">
        <ADescriptionsItem label="用户ID">{{ authStore.userInfo.userId || '-' }}</ADescriptionsItem>
        <ADescriptionsItem label="用户名">{{ authStore.userInfo.userName }}</ADescriptionsItem>
        <ADescriptionsItem label="显示名称">{{ authStore.userInfo.displayName }}</ADescriptionsItem>
        <ADescriptionsItem label="角色"><ASpace wrap><ATag v-for="role in authStore.userInfo.roles" :key="role">{{ role }}</ATag></ASpace></ADescriptionsItem>
      </ADescriptions>
    </ACard>
    <ACard title="安全设置" :bordered="false" class="card-wrapper">
      <AAlert v-if="authStore.isReadonly" :message="READONLY_ACTION_MESSAGE" type="info" class="mb-4" />
      <AForm ref="formRef" :model="passwordForm" :rules="passwordRules" layout="vertical" class="max-w-[480px]">
        <AFormItem label="原密码" name="oldPassword"><AInputPassword v-model:value="passwordForm.oldPassword" autocomplete="current-password" :disabled="authStore.isReadonly" /></AFormItem>
        <AFormItem label="新密码（6至64字符）" name="newPassword"><AInputPassword v-model:value="passwordForm.newPassword" autocomplete="new-password" :disabled="authStore.isReadonly" /></AFormItem>
        <AFormItem label="确认新密码" name="confirmPassword"><AInputPassword v-model:value="passwordForm.confirmPassword" autocomplete="new-password" :disabled="authStore.isReadonly" /></AFormItem>
        <AButton type="primary" :loading="passwordLoading" :disabled="authStore.isReadonly" @click="handlePasswordSubmit">修改密码</AButton>
      </AForm>
    </ACard>
    <ACard title="权限信息" :bordered="false" class="card-wrapper">
      <ASpace wrap><ATag v-for="code in authStore.userInfo.buttons" :key="code">{{ code }}</ATag><span v-if="!authStore.userInfo.buttons.length">暂无权限</span></ASpace>
    </ACard>
  </ASpace>
</template>

<script setup lang="ts">
import { onMounted, reactive, ref } from 'vue';
import { fetchGetUserInfo } from '@/api/system/auth';
import { fetchUpdatePassword } from '@/api/system/user';
import { READONLY_ACTION_MESSAGE, useAuthStore } from '@/store/system/auth';
import { useAntdForm } from '@/hooks/form/use-antd-form';
import avatarSrc from '@/assets/author-yangmufa-picture.jpg';

defineOptions({ name: 'SystemUserCenter' });
const authStore = useAuthStore();
const { formRef, validate } = useAntdForm();
const passwordLoading = ref(false);
const passwordForm = reactive({ oldPassword: '', newPassword: '', confirmPassword: '' });
const passwordRules = {
  oldPassword: [{ required: true, message: '请输入原密码' }],
  newPassword: [{ required: true, min: 6, max: 64, message: '新密码长度须为6至64字符' }],
  confirmPassword: [{ validator: async (_rule: unknown, value: string) => {
    if (!value || value !== passwordForm.newPassword) throw new Error('两次输入的新密码不一致');
  } }]
};
onMounted(async () => {
  const { data, error } = await fetchGetUserInfo();
  if (!error && data) Object.assign(authStore.userInfo, data);
});
async function handlePasswordSubmit() {
  if (authStore.isReadonly) { window.$message?.warning(READONLY_ACTION_MESSAGE); return; }
  if (passwordLoading.value) return;
  await validate();
  passwordLoading.value = true;
  try {
    const { error } = await fetchUpdatePassword({ oldPassword: passwordForm.oldPassword, newPassword: passwordForm.newPassword });
    if (error) return;
    Object.assign(passwordForm, { oldPassword: '', newPassword: '', confirmPassword: '' });
    window.$message?.success('密码修改成功，登录凭据已撤销，请重新登录。');
    await authStore.logout();
  } finally { passwordLoading.value = false; }
}
</script>
