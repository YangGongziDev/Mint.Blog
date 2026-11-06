<template>
  <ACard v-if="isDetailPage" title="用户详情" :loading="detailLoading" class="card-wrapper">
    <ADescriptions v-if="detail" bordered :column="2">
      <ADescriptionsItem label="ID">{{ detail.id }}</ADescriptionsItem>
      <ADescriptionsItem label="用户名">{{ detail.username }}</ADescriptionsItem>
      <ADescriptionsItem label="姓名">{{ detail.realName }}</ADescriptionsItem>
      <ADescriptionsItem label="状态">{{ detail.status === 'active' ? '启用' : '禁用' }}</ADescriptionsItem>
      <ADescriptionsItem label="邮箱">{{ detail.email || '-' }}</ADescriptionsItem>
      <ADescriptionsItem label="电话">{{ detail.phone || '-' }}</ADescriptionsItem>
      <ADescriptionsItem label="角色">{{ detail.roles.map(role => role.name).join('、') || '-' }}</ADescriptionsItem>
      <ADescriptionsItem label="创建时间">{{ detail.createdAt }}</ADescriptionsItem>
      <ADescriptionsItem label="更新时间">{{ detail.updatedAt || '-' }}</ADescriptionsItem>
    </ADescriptions>
    <AEmpty v-else-if="!detailLoading" description="未能加载用户详情" />
  </ACard>
  <div v-else class="h-full min-h-0 overflow-hidden flex flex-col gap-4">
    <ACard title="搜索" :bordered="false" class="card-wrapper search-card">
      <AForm layout="inline" :model="searchParams" class="flex flex-wrap gap-3">
        <AFormItem label="用户名"><AInput v-model:value="searchParams.username" allow-clear /></AFormItem>
        <AFormItem label="姓名"><AInput v-model:value="searchParams.realName" allow-clear /></AFormItem>
        <AFormItem label="邮箱"><AInput v-model:value="searchParams.email" allow-clear /></AFormItem>
        <AFormItem label="电话"><AInput v-model:value="searchParams.phone" allow-clear /></AFormItem>
        <AFormItem label="状态">
          <ASelect
            v-model:value="searchParams.status"
            :options="statusOptions"
            :virtual="false"
            allow-clear
            style="width: 120px"
            :dropdown-style="{ minWidth: '120px' }"
          />
        </AFormItem>
        <AButton @click="resetSearchParams">重置</AButton>
        <AButton type="primary" @click="getDataByPage()">搜索</AButton>
      </AForm>
    </ACard>
    <ACard title="用户管理" :bordered="false" class="card-wrapper table-card">
      <template #extra>
        <ASpace>
          <AButton v-if="can('add')" type="primary" @click="openForm()">新增</AButton>
          <APopconfirm v-if="can('delete')" title="确认删除所选用户？" @confirm="deleteUsers(checkedIds)">
            <AButton danger :disabled="!checkedIds.length || deleting">批量删除</AButton>
          </APopconfirm>
          <AButton :loading="loading" @click="getData">刷新</AButton>
        </ASpace>
      </template>
      <ATable :columns="columns" :data-source="data" :loading="loading || deleting" row-key="id"
        :row-selection="rowSelection" :pagination="mobilePagination" :scroll="{ x: 1300, y: '100%' }" size="small" />
    </ACard>
    <ADrawer v-model:open="drawerVisible" :title="editingId ? '编辑用户' : '新增用户'" :width="420">
      <AForm ref="formRef" layout="vertical" :model="model" :rules="rules">
        <AFormItem label="用户名" name="username"><AInput v-model:value="model.username" :disabled="Boolean(editingId)" :maxlength="60" /></AFormItem>
        <AFormItem label="姓名" name="realName"><AInput v-model:value="model.realName" :maxlength="100" /></AFormItem>
        <AFormItem v-if="!editingId" label="初始密码（至少8字符，不超过72 UTF-8字节）" name="password"><AInputPassword v-model:value="model.password" autocomplete="new-password" /></AFormItem>
        <AFormItem label="邮箱"><AInput v-model:value="model.email" /></AFormItem>
        <AFormItem label="电话"><AInput v-model:value="model.phone" /></AFormItem>
        <AFormItem label="状态"><ASelect v-model:value="model.status" :options="statusOptions" :disabled="isSelf" /></AFormItem>
        <AFormItem label="角色">
          <ASelect v-model:value="model.roleIds" mode="multiple" :options="sortedRoleOptions" :loading="rolesLoading" :disabled="isSelf || !rolesReady" @change="rolesChanged = true" />
          <p v-if="isSelf">不能修改自己的角色或禁用自己。</p>
          <p v-else-if="!rolesReady">角色选项未加载成功，保存不会修改原角色关联。</p>
        </AFormItem>
      </AForm>
      <template #footer><ASpace><AButton @click="drawerVisible = false">取消</AButton><AButton type="primary" :loading="saving" :disabled="!can(editingId ? 'edit' : 'add')" @click="submit">保存</AButton></ASpace></template>
    </ADrawer>
  </div>
</template>

<script setup lang="tsx">
import { computed, nextTick, reactive, ref, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { Button, Popconfirm } from 'ant-design-vue';
import { DeleteOutlined, EditOutlined, EyeOutlined } from '@ant-design/icons-vue';
import type { TableRowSelection } from 'ant-design-vue/es/table/interface';
import { fetchCreateUser, fetchDeleteUser, fetchGetAssignableRoles, fetchGetUser, fetchGetUserList, fetchUpdateUser } from '@/api/system/user';
import type { RbacUser, UserUpdateInput } from '@/api/system/user';
import { useAuthStore } from '@/store/system/auth';
import { useAuth } from '@/hooks/auth/use-auth';
import { useTable } from '@/hooks/table/use-table';
import { useAntdForm } from '@/hooks/form/use-antd-form';
import { sortOptionsByLabel } from '@/utils/common';

defineOptions({ name: 'SystemUser' });
const route = useRoute();
const router = useRouter();
const auth = useAuthStore();
const { hasAuth } = useAuth();
const can = (action: string) => !auth.isReadonly && hasAuth(`system.user.${action}`);
const isDetailPage = computed(() => route.name === 'system_user-detail');
const detail = ref<RbacUser | null>(null);
const detailLoading = ref(false);
const statusOptions = computed(() => sortOptionsByLabel([{ label: '启用', value: 'active' }, { label: '禁用', value: 'inactive' }], option => option.label));
const { columns, data, loading, getData, getDataByPage, mobilePagination, searchParams, resetSearchParams } = useTable({
  apiFn: fetchGetUserList,
  immediate: false,
  apiParams: { current: 1, size: 10, username: undefined, realName: undefined, email: undefined, phone: undefined, status: undefined },
  columns: () => [
    { key: 'id', dataIndex: 'id', title: 'ID', width: 180 },
    { key: 'username', dataIndex: 'username', title: '用户名' },
    { key: 'realName', dataIndex: 'realName', title: '姓名' },
    { key: 'email', dataIndex: 'email', title: '邮箱' },
    { key: 'phone', dataIndex: 'phone', title: '电话' },
    { key: 'status', title: '状态', customRender: ({ record }) => record.status === 'active' ? '启用' : '禁用' },
    { key: 'roles', title: '角色', customRender: ({ record }) => record.roles.map(role => role.name).join('、') },
    { key: 'createdAt', dataIndex: 'createdAt', title: '创建时间' },
    { key: 'updatedAt', dataIndex: 'updatedAt', title: '更新时间' },
    { key: 'operate', title: '操作', width: 180, align: 'center', fixed: 'right', customRender: ({ record }) => <div class="grid grid-cols-2 gap-x-2 gap-y-1 justify-items-center whitespace-nowrap">
      <Button type="link" size="small" onClick={() => router.push({ name: 'system_user-detail', params: { id: record.id } })}><EyeOutlined />详情</Button>
      {can('edit') && <Button type="link" size="small" onClick={() => openForm(record)}><EditOutlined />编辑</Button>}
      {can('delete') && <Popconfirm title="确认删除？" disabled={record.id === auth.userInfo.userId || deleting.value} onConfirm={() => deleteUsers([record.id])}>
        <Button type="link" size="small" danger disabled={record.id === auth.userInfo.userId || deleting.value}><DeleteOutlined />删除</Button>
      </Popconfirm>}
    </div> }
  ]
});
const checkedIds = ref<string[]>([]);
const deleting = ref(false);
const rowSelection = computed<TableRowSelection<RbacUser> | undefined>(() => can('delete') ? {
  selectedRowKeys: checkedIds.value,
  onChange: keys => { checkedIds.value = keys as string[]; },
  getCheckboxProps: record => ({ disabled: record.id === auth.userInfo.userId || deleting.value })
} : undefined);
async function deleteUsers(ids: string[]) {
  if (!can('delete') || deleting.value) return;
  const targets = [...ids].filter(id => id !== auth.userInfo.userId);
  if (!targets.length) return;
  deleting.value = true;
  try {
    const results = await Promise.all(targets.map(async id => ({ id, ...await fetchDeleteUser(id) })));
    const failed = results.filter(result => result.error).map(result => result.id);
    checkedIds.value = failed;
    const succeeded = results.length - failed.length;
    if (failed.length) window.$message?.warning(`删除成功 ${succeeded} 项，失败 ${failed.length} 项；失败项已保留选择，请查看错误提示。`);
    else window.$message?.success(`已删除 ${succeeded} 项`);
    await getData();
  } finally { deleting.value = false; }
}
const drawerVisible = ref(false);
const editingId = ref('');
const isSelf = computed(() => Boolean(editingId.value) && editingId.value === auth.userInfo.userId);
const saving = ref(false);
const rolesLoading = ref(false);
const rolesReady = ref(false);
const rolesChanged = ref(false);
const roleOptions = ref<{ label: string; value: string }[]>([]);
const sortedRoleOptions = computed(() => sortOptionsByLabel(roleOptions.value, option => option.label));
const model = reactive({ username: 'VisitorAdmin', realName: '', password: 'VisitorAdmin', email: '', phone: '', status: 'active' as RbacUser['status'], roleIds: [] as string[] });
const { formRef, validate } = useAntdForm();
const rules = {
  username: [{ required: true, whitespace: true, message: '请输入用户名' }],
  realName: [{ required: true, whitespace: true, message: '请输入姓名' }],
  password: [{ validator: async (_rule: unknown, value: string) => {
    if (!editingId.value && (value.length < 8 || new TextEncoder().encode(value).length > 72)) throw new Error('密码至少8字符且不超过72 UTF-8字节');
  } }]
};
async function openForm(user?: RbacUser) {
  if (!can(user ? 'edit' : 'add')) return;
  editingId.value = user?.id || '';
  Object.assign(model, { username: user?.username || '', realName: user?.realName || '', password: '', email: user?.email || '', phone: user?.phone || '', status: user?.status || 'active', roleIds: user?.roles.map(role => role.id) || [] });
  rolesChanged.value = false;
  rolesReady.value = false;
  roleOptions.value = user?.roles.map(role => ({ label: role.name, value: role.id })) || [];
  drawerVisible.value = true;
  await nextTick();
  formRef.value?.clearValidate();
  if (isSelf.value) return;
  rolesLoading.value = true;
  try {
    const result = await fetchGetAssignableRoles();
    if (result.error || !result.data) return;
    const options = new Map(roleOptions.value.map(option => [option.value, option]));
    result.data.forEach(role => options.set(role.id, { label: role.name, value: role.id }));
    roleOptions.value = [...options.values()];
    rolesReady.value = true;
  } finally { rolesLoading.value = false; }
}
async function submit() {
  if (!can(editingId.value ? 'edit' : 'add') || saving.value) return;
  await validate();
  const payload: UserUpdateInput = { realName: model.realName.trim(), email: model.email, phone: model.phone, status: isSelf.value ? 'active' : model.status };
  if (!isSelf.value && rolesReady.value && rolesChanged.value) payload.roleIds = [...model.roleIds];
  saving.value = true;
  try {
    const result = editingId.value ? await fetchUpdateUser(editingId.value, payload) : await fetchCreateUser({ ...payload, username: model.username.trim(), password: model.password });
    if (result.error) return;
    window.$message?.success('保存成功');
    drawerVisible.value = false;
    model.password = '';
    await getData();
  } finally { saving.value = false; }
}
watch(() => [route.name, route.params.id], async () => {
  drawerVisible.value = false;
  if (!isDetailPage.value) { await getData(); return; }
  const id = String(route.params.id || '');
  detail.value = null;
  detailLoading.value = true;
  try {
    const result = await fetchGetUser(id);
    if (isDetailPage.value && route.params.id === id && !result.error) detail.value = result.data;
  } finally { detailLoading.value = false; }
}, { immediate: true });
</script>

<style scoped lang="scss">
.search-card {
  flex-shrink: 0;
}
.table-card {
  display: flex;
  flex: 1;
  min-height: 0;
  overflow: hidden;
  flex-direction: column;
}
.table-card :deep(.ant-card-body),
.table-card :deep(.ant-table-wrapper),
.table-card :deep(.ant-spin-nested-loading),
.table-card :deep(.ant-spin-container),
.table-card :deep(.ant-table),
.table-card :deep(.ant-table-container) {
  display: flex;
  flex: 1;
  min-height: 0;
  flex-direction: column;
}
.table-card :deep(.ant-card-body) {
  overflow: hidden;
}
.table-card :deep(.ant-card-head),
.table-card :deep(.ant-alert),
.table-card :deep(.ant-table-header),
.table-card :deep(.ant-table-pagination) {
  flex-shrink: 0;
}
.table-card :deep(.ant-table-body) {
  flex: 1;
  min-height: 0;
  overflow-y: auto !important;
}
</style>
