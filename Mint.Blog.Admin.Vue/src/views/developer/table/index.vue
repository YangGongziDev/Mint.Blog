<template>
  <div class="page-container">
    <ProTable
      ref="tableRef"
      :columns="columns"
      :request="fetchData"
      :toolbar="{
        title: $t('exampleTable.userList'),
        subTitle: $t('exampleTable.subTitle'),
        actions: ['refresh', 'columnSetting'],
      }"
      :search="{
        formItems: searchFormItems,
        labelWidth: 80,
        defaultCollapsed: true,
      }"
      :header-filter="{
        defaultMode: 'server',
        requestPayload: 'flat',
      }"
      row-key="id"
    >
      <template #toolbar-actions>
        <a-button type="primary" @click="handleCreate">
          <PlusOutlined /> {{ $t('exampleTable.createUser') }}
        </a-button>
      </template>

      <template #bodyCell="{ column, record }">
        <template v-if="column.dataIndex === 'status'">
          <a-switch
            :checked="record.status === 'active'"
            @change="handleStatusChange(record, $event as boolean)"
          >
            <template #checkedChildren>{{ $t('user.active') }}</template>
            <template #unCheckedChildren>{{ $t('user.inactive') }}</template>
          </a-switch>
        </template>
        <template v-else-if="column.dataIndex === 'gender'">
          <a-tag :color="genderValueEnum[record.gender]?.color">
            {{ genderValueEnum[record.gender]?.text || record.gender }}
          </a-tag>
        </template>
      </template>
    </ProTable>

    <!-- Create/Edit Modal -->
    <ProFormModal
      v-model:open="modalVisible"
      :title="editingId ? $t('exampleTable.editUser') : $t('exampleTable.createUser')"
      :session-key="formSessionKey"
      :form-items="formItems"
      :initial-values="formData"
      :grid="{ cols: 2, gutter: 16 }"
      width="600px"
      @submit="handleSubmit"
      @cancel="closeFormModal"
      @closed="finishFormClose"
    />
  </div>
</template>

<script setup lang="ts">
import type { User } from '@/types/auth';
import type { ProTableColumn, ProFormItem, ProTableRequestParams } from '@/types/pro';

import { PlusOutlined, EditOutlined, DeleteOutlined } from '@antdv-next/icons';
import { message } from 'antdv-next';
import dayjs from 'dayjs';
import { computed, ref } from 'vue';

import ProFormModal from '@/components/Pro/ProFormModal/index.vue';
import ProTable from '@/components/Pro/ProTable/index.vue';
import { useCrudFormSession } from '@/composables/useCrudFormSession';
import { $t } from '@/locales';
import { commonRules } from '@/utils/formRules';

const tableRef = ref<InstanceType<typeof ProTable>>();
const users = ref<User[]>(
  Array.from({ length: 52 }, (_, index) => ({
    id: String(index + 1),
    username: index === 0 ? 'admin' : `user_${String(index).padStart(2, '0')}`,
    email: index === 0 ? 'admin@example.com' : `user${index}@example.com`,
    realName: index === 0 ? '系统管理员' : `示例用户${index}`,
    avatar: '',
    phone: `138${String(index).padStart(8, '0')}`,
    gender: index % 2 === 0 ? 'male' : 'female',
    bio: '表格示例用户',
    status: index % 3 === 2 ? 'inactive' : 'active',
    createdAt: new Date(Date.UTC(2026, 0, index + 1)).toISOString(),
    updatedAt: new Date(Date.UTC(2026, 0, index + 1)).toISOString(),
    roles: [],
    permissions: [],
  })),
);

type TableFormValues = {
  password?: string;
  username: string;
  email: string;
  realName: string;
  phone: string;
  gender: 'male' | 'female';
  status: boolean;
  bio: string;
};

const createDefaultFormValues = (): TableFormValues => ({
  username: '',
  email: '',
  realName: '',
  phone: '',
  gender: 'male',
  status: true,
  bio: '',
});

const {
  open: modalVisible,
  record: editingRecord,
  initialValues: formData,
  sessionKey: formSessionKey,
  openCreate: openCreateForm,
  openEdit: openEditForm,
  close: closeFormModal,
  finishClose: finishFormClose,
} = useCrudFormSession<User, TableFormValues>(createDefaultFormValues);
const editingId = computed(() => editingRecord.value?.id ?? null);

const genderOptions = computed(() => [
  { label: $t('user.male'), value: 'male' },
  { label: $t('user.female'), value: 'female' },
]);

const genderValueEnum = computed<Record<string, { text: string; color?: string }>>(() => ({
  male: { text: $t('user.male'), color: 'blue' },
  female: { text: $t('user.female'), color: 'pink' },
}));

// Search form items configuration
const searchFormItems = computed<ProFormItem[]>(() => [
  { name: 'email', label: $t('user.email'), type: 'input' },
  { name: 'realName', label: $t('user.realName'), type: 'input' },
  { name: 'gender', label: $t('user.gender'), type: 'select', options: genderOptions.value },
  { name: 'createdAt', label: $t('common.createTime'), type: 'dateRange' },
]);

// Table columns configuration
const columns = computed<ProTableColumn[]>(() => [
  {
    title: $t('user.username'),
    dataIndex: 'username',
    width: 150,
    fixed: 'left',
    headerFilter: {
      type: 'keyword',
      mode: 'server',
      icon: 'search',
      placeholder: `搜索${$t('user.username')}`,
      matchAllKeywords: true,
    },
  },
  {
    title: $t('user.email'),
    dataIndex: 'email',
    copyable: true,
  },
  {
    title: $t('user.realName'),
    dataIndex: 'realName',
  },
  {
    title: $t('user.phone'),
    dataIndex: 'phone',
  },
  {
    title: $t('user.gender'),
    dataIndex: 'gender',
    headerFilter: {
      type: 'select',
      mode: 'server',
      icon: 'filter',
      multiple: true,
      options: genderOptions.value,
    },
    valueType: 'tag',
    valueEnum: genderValueEnum.value,
  },
  {
    title: $t('common.status'),
    dataIndex: 'status',
    width: 150,
    headerFilter: {
      type: 'select',
      mode: 'server',
      icon: 'filter',
      multiple: false,
      options: [
        { label: $t('user.active'), value: 'active' },
        { label: $t('user.inactive'), value: 'inactive' },
      ],
    },
  },
  {
    title: $t('common.createTime'),
    dataIndex: 'createdAt',
    valueType: 'dateTime',
    sorter: true,
  },
  {
    title: $t('common.actions'),
    dataIndex: 'action',
    width: 200,
    fixed: 'right',
    actions: [
      {
        label: $t('common.edit'),
        icon: EditOutlined,
        onClick: (record) => handleEdit(record as unknown as User),
      },
      {
        label: $t('common.delete'),
        icon: DeleteOutlined,
        danger: true,
        confirm: $t('user.confirmDelete'),
        onClick: (record) => handleDelete(record as unknown as User),
      },
    ],
  },
]);

// Form items configuration
const formItems = computed<ProFormItem[]>(() => [
  {
    name: 'password',
    label: '初始密码',
    type: 'password',
    hidden: Boolean(editingId.value),
    required: !editingId.value,
    rules: [{ min: 8, message: '密码至少 8 字符' }],
  },
  {
    name: 'username',
    label: $t('user.username'),
    type: 'input',
    required: true,
    rules: [commonRules.required(), commonRules.length(3, 20), commonRules.username()],
  },
  {
    name: 'email',
    label: $t('user.email'),
    type: 'input',
    required: true,
    rules: [commonRules.required(), commonRules.email()],
  },
  {
    name: 'realName',
    label: $t('user.realName'),
    type: 'input',
    required: true,
  },
  {
    name: 'phone',
    label: $t('user.phone'),
    type: 'input',
    rules: [commonRules.phone()],
  },
  {
    name: 'gender',
    label: $t('user.gender'),
    type: 'select',
    required: true,
    options: genderOptions.value,
  },
  {
    name: 'status',
    label: $t('common.status'),
    type: 'switch',
    valuePropName: 'checked',
    required: true,
    initialValue: true,
    props: {
      checkedChildren: $t('user.active'),
      unCheckedChildren: $t('user.inactive'),
    },
  },
  {
    name: 'bio',
    label: $t('user.bio'),
    type: 'textarea',
    colSpan: 2,
    props: {
      rows: 4,
      maxLength: 200,
      showCount: true,
    },
  },
]);

// Methods
const fetchData = async (params: ProTableRequestParams) => {
  const gender = Array.isArray(params.gender)
    ? params.gender.map(String)
    : String(params.gender || '')
        .split(',')
        .filter(Boolean);
  const dateRange = Array.isArray(params.createdAt) ? params.createdAt : [];
  const filtered = users.value.filter((user) => {
    const matchesText = (key: 'username' | 'email' | 'realName') =>
      !params[key] ||
      String(params[key])
        .trim()
        .toLowerCase()
        .split(/\s+/)
        .every((keyword) => user[key].toLowerCase().includes(keyword));
    return (
      matchesText('username') &&
      matchesText('email') &&
      matchesText('realName') &&
      (!params.status || user.status === params.status) &&
      (!gender.length || gender.includes(user.gender || '')) &&
      (!dateRange[0] ||
        dayjs(user.createdAt).valueOf() >= dayjs(String(dateRange[0])).startOf('day').valueOf()) &&
      (!dateRange[1] ||
        dayjs(user.createdAt).valueOf() <= dayjs(String(dateRange[1])).endOf('day').valueOf())
    );
  });
  const sorter = params.sorter as { field?: string; order?: string } | undefined;
  if (sorter?.field === 'createdAt' && sorter.order) {
    filtered.sort(
      (a, b) =>
        (dayjs(a.createdAt).valueOf() - dayjs(b.createdAt).valueOf()) *
        (sorter.order === 'ascend' ? 1 : -1),
    );
  }
  const current = Number(params.current || 1);
  const pageSize = Number(params.pageSize || 10);
  const start = (current - 1) * pageSize;
  const res = {
    code: 200,
    data: { list: filtered.slice(start, start + pageSize), total: filtered.length },
  };
  return {
    data: res.data.list,
    total: res.data.total,
    success: true,
  };
};

const handleCreate = () => {
  openCreateForm();
};

const handleEdit = (record: User) => {
  openEditForm(record, {
    username: record.username,
    email: record.email,
    realName: record.realName,
    phone: record.phone,
    gender: record.gender || 'male',
    status: record.status === 'active',
    bio: record.bio || '',
  });
};

const handleDelete = async (record: User) => {
  users.value = users.value.filter((item) => item.id !== record.id);
  tableRef.value?.reload();
  message.success($t('exampleTable.deleteSuccess'));
};

const handleSubmit = async (rawValues: Record<string, unknown>) => {
  const values = rawValues as TableFormValues;
  const existing = users.value.find((item) => item.id === editingId.value);
  const now = new Date().toISOString();
  const response = {
    code: 200,
    data: {
      id: existing?.id || crypto.randomUUID(),
      username: values.username,
      email: values.email,
      realName: values.realName,
      phone: values.phone,
      gender: values.gender,
      bio: values.bio,
      status: values.status ? 'active' : 'inactive',
      avatar: existing?.avatar || '',
      roles: existing?.roles || [],
      permissions: existing?.permissions || [],
      createdAt: existing?.createdAt || now,
      updatedAt: now,
    } satisfies User,
  };
  if (existing) Object.assign(existing, response.data);
  else users.value.unshift(response.data);
  message.success($t(existing ? 'exampleTable.updateSuccess' : 'exampleTable.createSuccess'));
  closeFormModal();
  tableRef.value?.reload();
};

const handleStatusChange = async (record: User, checked: boolean) => {
  const user = users.value.find((item) => item.id === record.id);
  if (user) {
    user.status = checked ? 'active' : 'inactive';
    user.updatedAt = new Date().toISOString();
  }
  tableRef.value?.reload();
  message.success($t('exampleTable.updateSuccess'));
};
</script>
