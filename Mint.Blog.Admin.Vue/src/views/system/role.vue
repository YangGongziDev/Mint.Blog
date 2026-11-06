<template>
  <div class="h-full min-h-0 overflow-hidden flex flex-col gap-4">
    <ACard title="搜索" :bordered="false" class="card-wrapper search-card">
      <AForm layout="inline" :model="searchParams" class="flex flex-wrap gap-3">
        <AFormItem label="角色名称"><AInput v-model:value="searchParams.name" allow-clear /></AFormItem>
        <AFormItem label="角色编码"><AInput v-model:value="searchParams.code" allow-clear /></AFormItem>
        <AButton @click="resetSearchParams">重置</AButton><AButton type="primary" @click="getDataByPage()">搜索</AButton>
      </AForm>
    </ACard>
    <ACard title="角色定义" :bordered="false" class="card-wrapper table-card">
      <template #extra><ASpace>
        <AButton v-if="can('add')" type="primary" @click="openForm()">新增角色</AButton>
        <APopconfirm v-if="can('delete')" title="确认删除所选角色？" @confirm="deleteRoles(checkedIds)"><AButton danger :disabled="!checkedIds.length || deleting">批量删除</AButton></APopconfirm>
        <AButton :loading="loading" @click="getData">刷新</AButton>
      </ASpace></template>
      <AAlert message="内置角色及自己持有的角色不可编辑或删除；已分配的角色须先解除用户关联。" type="info" class="mb-4" />
      <ATable :columns="columns" :data-source="data" :row-selection="rowSelection" :loading="loading || deleting" row-key="id" :pagination="mobilePagination" :scroll="{ x: 1100, y: '100%' }" size="small" />
    </ACard>
    <ADrawer v-model:open="drawerVisible" :title="editingId ? '编辑角色' : '新增角色'" :width="480">
      <AForm ref="formRef" layout="vertical" :model="model" :rules="rules">
        <AFormItem label="名称" name="name"><AInput v-model:value="model.name" :maxlength="100" /></AFormItem>
        <AFormItem label="编码" name="code"><AInput v-model:value="model.code" :disabled="Boolean(editingId)" :maxlength="60" /></AFormItem>
        <AFormItem label="描述"><ATextarea v-model:value="model.description" /></AFormItem>
        <AFormItem label="权限授权">
          <ACheckbox v-model:checked="changePermissions" :disabled="!permissionsReady">修改权限关联</ACheckbox>
          <p>仅勾选并操作授权时提交 permissionIds；普通编辑保留原权限。</p>
          <ASpin :spinning="permissionsLoading">
            <ATree v-if="permissionsReady" v-model:checked-keys="checkedPermissions" :tree-data="permissionTree" checkable check-strictly :disabled="!changePermissions" />
          </ASpin>
          <p v-if="!permissionsLoading && !permissionsReady">权限选项加载失败，保存不会改变原关联。</p>
        </AFormItem>
      </AForm>
      <template #footer><ASpace><AButton @click="drawerVisible = false">取消</AButton><AButton type="primary" :loading="saving" :disabled="!can(editingId ? 'edit' : 'add')" @click="submit">保存</AButton></ASpace></template>
    </ADrawer>
  </div>
</template>

<script setup lang="tsx">
import { computed, nextTick, reactive, ref } from 'vue';
import { Button, Popconfirm } from 'ant-design-vue';
import { DeleteOutlined, EditOutlined } from '@ant-design/icons-vue';
import type { TableRowSelection } from 'ant-design-vue/es/table/interface';
import { fetchCreateRole, fetchDeleteRole, fetchGetAssignablePermissions, fetchGetRoleList, fetchUpdateRole } from '@/api/system/role';
import type { RbacPermission, RbacRole, RoleInput } from '@/api/system/role';
import { useAuthStore } from '@/store/system/auth';
import { useAuth } from '@/hooks/auth/use-auth';
import { useTable } from '@/hooks/table/use-table';
import { useAntdForm } from '@/hooks/form/use-antd-form';

defineOptions({ name: 'SystemRole' });
const auth = useAuthStore();
const { hasAuth } = useAuth();
const can = (action: string) => !auth.isReadonly && hasAuth(`system.role.${action}`);
const protectedRole = (role: RbacRole) => ['ROLE_ADMIN', 'ROLE_SUPER'].includes(role.code) || auth.userInfo.roles.includes(role.code);
const { columns, data, loading, getData, getDataByPage, mobilePagination, searchParams, resetSearchParams } = useTable({
  apiFn: fetchGetRoleList,
  apiParams: { current: 1, size: 10, name: undefined, code: undefined },
  columns: () => [
    { key: 'id', dataIndex: 'id', title: 'ID', width: 180 },
    { key: 'name', dataIndex: 'name', title: '名称' },
    { key: 'code', dataIndex: 'code', title: '编码' },
    { key: 'description', dataIndex: 'description', title: '描述' },
    { key: 'permissions', title: '权限', width: 260, ellipsis: true, customRender: ({ record }) => record.permissions.map(permission => permission.code).join('、') || '-' },
    { key: 'createdAt', dataIndex: 'createdAt', title: '创建时间' },
    { key: 'updatedAt', dataIndex: 'updatedAt', title: '更新时间' },
    { key: 'operate', title: '操作', width: 180, align: 'center', fixed: 'right', customRender: ({ record }) => <div class="flex justify-center gap-2 whitespace-nowrap">
      {can('edit') && <Button type="link" size="small" disabled={protectedRole(record)} onClick={() => openForm(record)}><EditOutlined />编辑</Button>}
      {can('delete') && <Popconfirm title="确认删除？" disabled={protectedRole(record) || deleting.value} onConfirm={() => deleteRoles([record.id])}>
        <Button type="link" size="small" danger disabled={protectedRole(record) || deleting.value}><DeleteOutlined />删除</Button>
      </Popconfirm>}
    </div> }
  ]
});
const checkedIds = ref<string[]>([]);
const deleting = ref(false);
const rowSelection = computed<TableRowSelection<RbacRole> | undefined>(() => can('delete') ? {
  selectedRowKeys: checkedIds.value,
  onChange: keys => { checkedIds.value = keys as string[]; },
  getCheckboxProps: record => ({ disabled: protectedRole(record) || deleting.value })
} : undefined);
async function deleteRoles(ids: string[]) {
  if (!can('delete') || deleting.value) return;
  const targets = [...ids].filter(id => !data.value.some(role => role.id === id && protectedRole(role)));
  if (!targets.length) return;
  deleting.value = true;
  try {
    const results = await Promise.all(targets.map(async id => ({ id, ...await fetchDeleteRole(id) })));
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
const saving = ref(false);
const permissionsLoading = ref(false);
const permissionsReady = ref(false);
const changePermissions = ref(false);
const checkedPermissions = ref<{ checked: string[]; halfChecked: string[] }>({ checked: [], halfChecked: [] });
const retainedPermissionIds = ref<string[]>([]);
interface PermissionNode { key: string; title: string; children?: PermissionNode[] }
const permissionTree = ref<PermissionNode[]>([]);
function toTree(permissions: RbacPermission[]): PermissionNode[] {
  return permissions.map(permission => ({
    key: permission.id,
    title: `${typeof permission.name === 'string' ? permission.name : permission.name['zh-CN'] || permission.name.zh || Object.values(permission.name)[0] || permission.code} (${permission.code})`,
    children: toTree(permission.children || [])
  }));
}
function collectIds(permissions: RbacPermission[]): string[] {
  return permissions.flatMap(permission => [permission.id, ...collectIds(permission.children || [])]);
}
const model = reactive({ name: '', code: '', description: '' });
const { formRef, validate } = useAntdForm();
const rules = {
  name: [{ required: true, whitespace: true, message: '请输入角色名称' }],
  code: [{ required: true, whitespace: true, message: '请输入角色编码' }]
};
async function openForm(role?: RbacRole) {
  if (!can(role ? 'edit' : 'add') || (role && protectedRole(role))) return;
  editingId.value = role?.id || '';
  Object.assign(model, { name: role?.name || '', code: role?.code || '', description: role?.description || '' });
  changePermissions.value = false;
  permissionsReady.value = false;
  permissionTree.value = [];
  retainedPermissionIds.value = [];
  checkedPermissions.value = { checked: [], halfChecked: [] };
  drawerVisible.value = true;
  await nextTick();
  formRef.value?.clearValidate();
  permissionsLoading.value = true;
  try {
    const result = await fetchGetAssignablePermissions();
    if (result.error || !result.data) return;
    const allowed = new Set(collectIds(result.data));
    const existing = role?.permissions.map(permission => permission.id) || [];
    retainedPermissionIds.value = existing.filter(id => !allowed.has(id));
    checkedPermissions.value = { checked: existing.filter(id => allowed.has(id)), halfChecked: [] };
    permissionTree.value = toTree(result.data);
    permissionsReady.value = true;
  } finally { permissionsLoading.value = false; }
}
async function submit() {
  if (!can(editingId.value ? 'edit' : 'add') || saving.value) return;
  await validate();
  const payload: RoleInput = { name: model.name.trim(), code: model.code.trim(), description: model.description };
  if (changePermissions.value && permissionsReady.value) payload.permissionIds = [...new Set([...retainedPermissionIds.value, ...checkedPermissions.value.checked])];
  saving.value = true;
  try {
    const result = editingId.value ? await fetchUpdateRole(editingId.value, payload) : await fetchCreateRole(payload);
    if (result.error) return;
    window.$message?.success('保存成功');
    drawerVisible.value = false;
    await getData();
  } finally { saving.value = false; }
}
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
