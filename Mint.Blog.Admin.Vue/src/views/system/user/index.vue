<template>
  <div class="page-container">
    <ProTable
      ref="tableRef"
      :columns="columns"
      :request="fetchTableData"
      :toolbar="toolbarConfig"
      :search="{
        formItems: searchFormItems,
        labelWidth: 6,
        defaultCollapsed: true,
      }"
      row-key="id"
    >
      <template #toolbar-actions>
        <a-space>
          <a-tooltip
            title="CSV 必须包含 username、realName、email、password（至少 8 字符）列；密码不会导出。"
          >
            <a-upload
              v-if="can('system.user.add')"
              :disabled="importing"
              :show-upload-list="false"
              accept=".csv"
              :before-upload="handleImport"
            >
              <a-button> <UploadOutlined /> {{ $t('common.import') }} </a-button>
            </a-upload>
          </a-tooltip>
          <a-button v-if="can('system.user.view')" @click="handleExport">
            <DownloadOutlined /> {{ $t('common.export') }}
          </a-button>
          <a-button v-if="can('system.user.add')" type="primary" @click="handleCreate">
            <PlusOutlined /> {{ $t('user.createUser') }}
          </a-button>
        </a-space>
      </template>
    </ProTable>

    <ProFormModal
      v-model:open="modalVisible"
      :title="editingUserId ? $t('user.editUser') : $t('user.createUser')"
      :confirm-loading="submitting"
      :session-key="formSessionKey"
      :form-items="formItems"
      :initial-values="formData"
      :grid="{ cols: 2, gutter: 16 }"
      :layout="{ layout: 'vertical' }"
      width="760px"
      @submit="handleSubmit"
      @cancel="handleCancel"
      @closed="finishFormClose"
    />
  </div>
</template>

<script setup lang="ts">
import type { UpdateUserParams } from '@/api/user';
import type { Role, User } from '@/types/auth';
import type { ProFormItem, ProTableColumn } from '@/types/pro';

import {
  PlusOutlined,
  EditOutlined,
  DeleteOutlined,
  UploadOutlined,
  DownloadOutlined,
} from '@antdv-next/icons';
import { message, Modal } from 'antdv-next';
import { computed, h, ref } from 'vue';

import { createUser, deleteUser, getAssignableRoles, getUserList, updateUser } from '@/api/user';
import ProFormModal from '@/components/Pro/ProFormModal/index.vue';
import ProTable from '@/components/Pro/ProTable/index.vue';
import { useCrudFormSession } from '@/composables/useCrudFormSession';
import { usePermission } from '@/composables/usePermission';
import { $t } from '@/locales';
import { useAuthStore } from '@/stores/auth';
import { exportToCSV, parseCSVRecords } from '@/utils/export';

type UserFormValues = {
  password?: string;
  username: string;
  realName: string;
  email: string;
  phone: string;
  gender: 'male' | 'female';
  status: boolean;
  roleIds: string[];
  bio: string;
};

const tableRef = ref<{
  refresh: () => void;
  reload: () => void;
} | null>(null);
const {
  open: modalVisible,
  record: editingUser,
  initialValues: formData,
  sessionKey: formSessionKey,
  openCreate: openCreateForm,
  openEdit: openEditForm,
  close: closeFormModal,
  finishClose: finishFormClose,
} = useCrudFormSession<User, UserFormValues>(createDefaultFormValues);
const submitting = ref(false);
const importing = ref(false);
const { can } = usePermission();
const authStore = useAuthStore();
const editingUserId = computed(() => editingUser.value?.id ?? null);
const editingSelf = computed(() => editingUserId.value === authStore.user?.id);
const roleOptions = ref<Role[]>([]);

const toolbarConfig = computed(() => ({
  title: $t('user.title'),
  subTitle: 'ProTable + ProForm',
  actions: ['refresh', 'density', 'columnSetting'] as Array<
    'refresh' | 'density' | 'columnSetting'
  >,
}));

const statusOptions = computed(() => [
  { label: $t('user.active'), value: 'active' },
  { label: $t('user.inactive'), value: 'inactive' },
]);

const genderOptions = computed(() => [
  { label: $t('user.male'), value: 'male' },
  { label: $t('user.female'), value: 'female' },
]);

const roleSelectOptions = computed(() => {
  return roleOptions.value.map((role) => ({
    label: role.name,
    value: role.id,
  }));
});

const genderValueEnum = computed<Record<string, { text: string; status?: string; color?: string }>>(
  () => ({
    male: { text: $t('user.male'), color: 'blue' },
    female: { text: $t('user.female'), color: 'magenta' },
  }),
);

const statusValueEnum = computed<Record<string, { text: string; status?: string; color?: string }>>(
  () => ({
    active: { text: $t('user.active'), status: 'success' },
    inactive: { text: $t('user.inactive'), status: 'default' },
  }),
);

const searchFormItems = computed<ProFormItem[]>(() => [
  { name: 'username', label: $t('user.username'), type: 'input' },
  { name: 'email', label: $t('user.email'), type: 'input' },
  { name: 'status', label: $t('user.status'), type: 'select', options: statusOptions.value },
]);

const columns = computed((): ProTableColumn[] => [
  {
    title: $t('user.username'),
    dataIndex: 'username',
    width: 150,
    fixed: 'left',
  },
  {
    title: $t('user.realName'),
    dataIndex: 'realName',
    width: 140,
  },
  {
    title: $t('user.email'),
    dataIndex: 'email',
    width: 220,
  },
  {
    title: $t('user.phone'),
    dataIndex: 'phone',
    width: 150,
  },
  {
    title: $t('user.role'),
    dataIndex: 'roleNames',
    width: 220,
  },
  {
    title: $t('user.gender'),
    dataIndex: 'gender',
    width: 100,
    valueType: 'tag',
    valueEnum: genderValueEnum.value,
  },
  {
    title: $t('user.status'),
    dataIndex: 'status',
    width: 120,
    valueType: 'badge',
    valueEnum: statusValueEnum.value,
  },
  {
    title: $t('common.createTime'),
    dataIndex: 'createdAt',
    width: 200,
    valueType: 'dateTime',
  },
  {
    title: $t('common.actions'),
    dataIndex: 'action',
    width: 160,
    fixed: 'right',
    actions: [
      {
        label: $t('common.edit'),
        icon: EditOutlined,
        permission: 'system.user.edit',
        hidden: () => !can('system.user.edit'),
        onClick: (record) => handleEdit(record as unknown as User),
      },
      {
        label: $t('common.delete'),
        icon: DeleteOutlined,
        permission: 'system.user.delete',
        hidden: () => !can('system.user.delete'),
        disabled: (record) => record.id === authStore.user?.id,
        danger: true,
        confirm: $t('user.confirmDelete'),
        onClick: (record) => handleDelete(record as unknown as User),
      },
    ],
  },
]);

const formItems = computed<ProFormItem[]>(() => [
  {
    name: 'password',
    label: '初始密码',
    type: 'password',
    hidden: Boolean(editingUserId.value),
    required: !editingUserId.value,
    rules: [{ min: 8, message: '密码至少 8 字符' }],
  },
  {
    name: 'username',
    label: $t('user.username'),
    type: 'input',
    required: true,
    props: {
      disabled: Boolean(editingUserId.value),
    },
    rules: [
      { required: true, message: $t('user.usernameRequired') },
      { min: 3, max: 20, message: $t('user.usernameLength') },
    ],
  },
  {
    name: 'realName',
    label: $t('user.realName'),
    type: 'input',
    required: true,
  },
  {
    name: 'email',
    label: $t('user.email'),
    type: 'input',
    required: true,
    rules: [
      { required: true, message: $t('user.emailRequired') },
      { type: 'email', message: $t('validation.email') },
    ],
  },
  {
    name: 'phone',
    label: $t('user.phone'),
    type: 'input',
    rules: [{ pattern: /^1[3-9]\d{9}$/, message: $t('validation.phone') }],
  },
  {
    name: 'gender',
    label: $t('user.gender'),
    type: 'select',
    options: genderOptions.value,
  },
  {
    name: 'status',
    label: $t('user.status'),
    type: 'switch',
    valuePropName: 'checked',
    required: true,
    props: {
      disabled: editingSelf.value,
      checkedChildren: $t('user.active'),
      unCheckedChildren: $t('user.inactive'),
    },
  },
  {
    name: 'roleIds',
    label: $t('user.role'),
    type: 'select',
    options: roleSelectOptions.value,
    props: {
      disabled: editingSelf.value,
      mode: 'multiple',
      allowClear: true,
    },
    rules: [{ type: 'array', required: !editingSelf.value, message: $t('user.selectRole') }],
  },
  {
    name: 'bio',
    label: $t('user.bio'),
    type: 'textarea',
    colSpan: 2,
    props: {
      rows: 3,
      maxLength: 200,
      showCount: true,
    },
  },
]);

function createDefaultFormValues(): UserFormValues {
  return {
    username: '',
    realName: '',
    email: '',
    phone: '',
    gender: 'male',
    status: true,
    roleIds: [],
    bio: '',
  };
}

const formatRoleNames = (roles: Role[]) => {
  if (!roles || roles.length === 0) {
    return '-';
  }
  return roles.map((role) => role.name).join(', ');
};

const fetchTableData = async (params: Record<string, unknown>) => {
  const response = await getUserList({
    current: Number(params.current || 1),
    pageSize: Number(params.pageSize || 10),
    username: (params.username as string)?.trim() || undefined,
    email: (params.email as string)?.trim() || undefined,
    status: params.status as string,
  });

  const list = response.data.list.map((item) => ({
    ...item,
    roleNames: formatRoleNames(item.roles),
  }));

  return {
    data: list,
    total: response.data.total,
    success: true,
  };
};

const fetchRoleOptions = async () => {
  roleOptions.value = (await getAssignableRoles()).data;
};

const refreshTable = () => {
  tableRef.value?.refresh();
};

const reloadTable = () => {
  tableRef.value?.reload();
};

const handleCreate = async () => {
  if (!can('system.user.add')) return;
  await fetchRoleOptions();
  openCreateForm();
};

const handleEdit = async (record: User) => {
  if (!can('system.user.edit')) return;
  if (record.id !== authStore.user?.id) await fetchRoleOptions();
  const statusStr = record.status || 'active';
  const initialValues: UserFormValues = {
    username: record.username,
    realName: record.realName,
    email: record.email,
    phone: record.phone,
    gender: record.gender || 'male',
    status: statusStr === 'active',
    roleIds: (record.roles || []).map((role) => role.id),
    bio: record.bio || '',
  };
  openEditForm(record, initialValues);
};

const handleCancel = () => {
  closeFormModal();
};

const handleDelete = async (record: User) => {
  Modal.confirm({
    title: $t('user.deleteUser'),
    content: $t('user.confirmDelete'),
    onOk: async () => {
      await deleteUser(record.id);
      message.success($t('common.success'));
      refreshTable();
    },
  });
};

const handleSubmit = async (rawValues: Record<string, unknown>) => {
  if (!can(editingUserId.value ? 'system.user.edit' : 'system.user.add')) return;
  const values = rawValues as UserFormValues;

  const payload: UpdateUserParams = {
    realName: values.realName?.trim(),
    email: values.email?.trim(),
    phone: values.phone?.trim(),
    gender: values.gender,
    bio: values.bio?.trim(),
    ...(!editingSelf.value
      ? {
          status: values.status ? ('active' as const) : ('inactive' as const),
          roleIds: values.roleIds || [],
        }
      : {}),
  };

  submitting.value = true;
  try {
    if (editingUserId.value) {
      await updateUser(editingUserId.value, payload);
      await authStore.syncIdentity();
      message.success($t('user.updateSuccess'));
      refreshTable();
    } else {
      await createUser({
        ...payload,
        username: values.username.trim(),
        password: values.password || '',
      });
      message.success($t('user.createSuccess'));
      reloadTable();
    }
    closeFormModal();
  } finally {
    submitting.value = false;
  }
};



// export user data
const handleExport = async () => {
  try {
    const list: User[] = [];
    for (let current = 1; ; current++) {
      const { data } = await getUserList({ current, pageSize: 1000 });
      list.push(...data.list);
      if (list.length >= data.total || data.list.length === 0) break;
    }
    exportToCSV(
      [
        { title: $t('user.username'), dataIndex: 'username' },
        { title: $t('user.realName'), dataIndex: 'realName' },
        { title: $t('user.email'), dataIndex: 'email' },
        { title: $t('user.phone'), dataIndex: 'phone' },
        {
          title: $t('user.gender'),
          dataIndex: 'gender',
          render: (v: unknown) => (v === 'male' ? $t('user.male') : $t('user.female')),
        },
        {
          title: $t('user.status'),
          dataIndex: 'status',
          render: (v: unknown) => (v === 'active' ? $t('user.active') : $t('user.inactive')),
        },
        {
          title: $t('user.role'),
          dataIndex: 'roles',
          render: (_: unknown, r: unknown) =>
            (((r as Record<string, unknown>).roles as Array<{ name: string }>) || [])
              .map((role) => role.name)
              .join(', '),
        },
        { title: $t('common.createTime'), dataIndex: 'createdAt' },
      ],
      list,
      `${$t('user.title')}_${new Date().toISOString().slice(0, 10)}`,
    );
    message.success($t('user.exportSuccess'));
  } catch {
    message.error($t('user.exportFailed'));
  }
};

// import user data
const handleImport = async (file: File) => {
  if (!can('system.user.add') || importing.value) return false;
  importing.value = true;
  try {
    const rows = await parseCSVRecords(file, false);
    if (rows.length < 2) {
      message.warning($t('user.importEmpty'));
      return false;
    }
    const header = rows[0].cells.map((cell) => cell.trim().toLowerCase());
    const findColumn = (...names: string[]) => header.findIndex((cell) => names.includes(cell));
    const usernameIdx = findColumn('username', '用户名');
    const realNameIdx = findColumn('realname', 'real name', '姓名', '真实姓名');
    const emailIdx = findColumn('email', '邮箱');
    const passwordIdx = findColumn('password', '密码', '初始密码');
    if ([usernameIdx, realNameIdx, emailIdx, passwordIdx].includes(-1)) {
      message.error('CSV 必须包含 username、realName、email、password 列');
      return false;
    }

    let successCount = 0;
    const failures: string[] = [];
    for (const { cells: row, line } of rows.slice(1)) {
      const username = row[usernameIdx]?.trim();
      const realName = row[realNameIdx]?.trim();
      const email = row[emailIdx]?.trim();
      const password = row[passwordIdx] || '';
      if (!username || !realName || !email || password.length < 8) {
        failures.push(`第 ${line} 行：用户名、姓名、邮箱不能为空，密码至少 8 字符`);
        continue;
      }
      try {
        await createUser({ username, realName, email, password, status: 'active' });
        successCount++;
      } catch {
        failures.push(`第 ${line} 行：创建失败，请检查字段格式、账号是否重复及操作权限`);
      }
    }
    if (successCount) {
      message.success($t('user.importSuccess', { count: successCount }));
      refreshTable();
    }
    if (failures.length) {
      Modal.warning({
        title: `导入完成：成功 ${successCount} 行，失败 ${failures.length} 行`,
        content: h(
          'div',
          { style: { whiteSpace: 'pre-wrap', maxHeight: '360px', overflow: 'auto' } },
          failures.join('\n'),
        ),
        width: 640,
      });
    }
  } catch (error) {
    message.error(error instanceof Error ? error.message : $t('user.importFailed'));
  } finally {
    importing.value = false;
  }
  return false;
};
</script>
