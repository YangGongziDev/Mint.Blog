<template>
  <div class="page-container">
    <ProSplitLayout :side-width="200">
      <template #side>
        <!-- groups nav -->
        <div class="config-groups-header">
          <h3>{{ $t('config.configGroups') }}</h3>
        </div>
        <a-menu
          v-model:selectedKeys="selectedMenuKeys"
          mode="inline"
          :items="menuItems"
          class="config-groups-menu"
          @click="handleMenuClick"
        />
      </template>

      <template #main>
        <!-- config list -->
        <ProTable
          :key="selectedGroup + refreshKey"
          :columns="columns"
          :request="loadConfigList"
          :search="false"
          :toolbar="{ title: $t(`config.groups.${selectedGroup}`) }"
        >
          <template #toolbar-actions>
            <a-button type="primary" @click="handleAdd">
              <PlusOutlined /> {{ $t('config.createConfig') }}
            </a-button>
          </template>
          <template #bodyCell="{ column, record }">
            <template v-if="column.key === 'value'">
              <template v-if="record.valueType === 'boolean'">
                <a-tag :color="record.value === 'true' ? 'green' : 'default'">
                  {{ record.value === 'true' ? $t('common.yes') : $t('common.no') }}
                </a-tag>
              </template>
              <template v-else>
                <span class="config-value">{{ record.value }}</span>
              </template>
            </template>
            <template v-if="column.key === 'valueType'">
              <a-tag>{{ $t(`config.valueTypes.${record.valueType}`) || record.valueType }}</a-tag>
            </template>
            <template v-if="column.key === 'builtIn'">
              <a-tag :color="record.builtIn ? 'blue' : 'default'">
                {{
                  record.builtIn
                    ? $t('config.builtInTypes.builtIn')
                    : $t('config.builtInTypes.custom')
                }}
              </a-tag>
            </template>
            <template v-if="column.key === 'action'">
              <a-space :size="4">
                <a-button type="link" size="small" @click="handleEdit(record)">
                  <template #icon><EditOutlined /></template>
                  {{ $t('common.edit') }}
                </a-button>
                <a-button
                  v-if="!record.builtIn"
                  type="link"
                  size="small"
                  danger
                  @click="handleDelete(record)"
                >
                  <template #icon><DeleteOutlined /></template>
                  {{ $t('common.delete') }}
                </a-button>
              </a-space>
            </template>
          </template>
        </ProTable>
      </template>
    </ProSplitLayout>

    <!-- add/edit modal -->
    <a-modal v-model:open="modalVisible" :title="modalTitle" @ok="handleSubmit" :width="520">
      <a-form :model="form" :label-col="{ span: 6 }" style="margin-top: 16px">
        <a-form-item :label="$t('config.configName')" required>
          <a-input v-model:value="form.name" :placeholder="$t('config.placeholders.configName')" />
        </a-form-item>
        <a-form-item :label="$t('config.configKey')" required>
          <a-input
            v-model:value="form.key"
            :placeholder="$t('config.placeholders.configKey')"
            :disabled="!!form.id"
          />
        </a-form-item>
        <a-form-item :label="$t('config.configValue')" required>
          <a-switch v-if="form.valueType === 'boolean'" v-model:checked="boolValue" />
          <a-input-number
            v-else-if="form.valueType === 'number'"
            v-model:value="form.value"
            style="width: 100%"
          />
          <a-textarea
            v-else-if="form.valueType === 'json'"
            v-model:value="form.value"
            :rows="4"
            :placeholder="$t('config.placeholders.jsonFormat')"
          />
          <a-input
            v-else
            v-model:value="form.value"
            :placeholder="$t('config.placeholders.configValue')"
          />
        </a-form-item>
        <a-form-item :label="$t('config.valueType')">
          <a-select
            v-model:value="form.valueType"
            :disabled="!!form.id"
            :options="valueTypeOptions"
          />
        </a-form-item>
        <a-form-item :label="$t('config.group')">
          <a-select v-model:value="form.group" allow-clear :options="groupOptions" />
        </a-form-item>
        <a-form-item :label="$t('config.sort')">
          <a-input-number v-model:value="form.sort" :min="0" style="width: 100%" />
        </a-form-item>
        <a-form-item :label="$t('config.description')">
          <a-textarea
            v-model:value="form.description"
            :placeholder="$t('config.placeholders.description')"
            :rows="2"
          />
        </a-form-item>
      </a-form>
    </a-modal>
  </div>
</template>

<script setup lang="ts">
import type { SysConfig } from '@/types/config';
import type { ProTableColumn } from '@/types/pro';
import type { MenuItemType } from 'antdv-next';

import { EditOutlined, DeleteOutlined, PlusOutlined } from '@antdv-next/icons';
import { message, Modal } from 'antdv-next';
import { ref, computed, h } from 'vue';
import { useI18n } from 'vue-i18n';

import ProSplitLayout from '@/components/Pro/ProSplitLayout/index.vue';
import ProTable from '@/components/Pro/ProTable/index.vue';

const configTime = '2026-06-06 06:06:06';
const configs: SysConfig[] = [
  {
    id: '1',
    name: 'Site Name',
    key: 'site.name',
    value: 'Mint.Blog.Admin',
    valueType: 'string',
    group: 'basic',
    description: 'System display name',
    builtIn: true,
    sort: 1,
  },
  {
    id: '2',
    name: 'Site Description',
    key: 'site.description',
    value: 'Vue3 + Ant Design Vue Admin System',
    valueType: 'string',
    group: 'basic',
    description: 'Site SEO description',
    builtIn: true,
    sort: 2,
  },
  {
    id: '3',
    name: 'Copyright',
    key: 'site.copyright',
    value: '© 2026 Mint.Blog.Admin',
    valueType: 'string',
    group: 'basic',
    description: 'Footer copyright text',
    builtIn: false,
    sort: 3,
  },
  {
    id: '4',
    name: 'System Version',
    key: 'site.version',
    value: '1.0.0',
    valueType: 'string',
    group: 'basic',
    description: 'Current system version',
    builtIn: true,
    sort: 4,
  },
  {
    id: '10',
    name: 'Max Login Attempts',
    key: 'security.maxLoginAttempts',
    value: '5',
    valueType: 'number',
    group: 'security',
    description: 'Lock account after N failed login attempts',
    builtIn: true,
    sort: 1,
  },
  {
    id: '11',
    name: 'Lock Duration (min)',
    key: 'security.lockDuration',
    value: '30',
    valueType: 'number',
    group: 'security',
    description: 'Account lock duration in minutes',
    builtIn: true,
    sort: 2,
  },
  {
    id: '12',
    name: 'Token Expiry (hours)',
    key: 'security.tokenExpiry',
    value: '24',
    valueType: 'number',
    group: 'security',
    description: 'Login token expiration time',
    builtIn: true,
    sort: 3,
  },
  {
    id: '13',
    name: 'Enable Captcha',
    key: 'security.captchaEnabled',
    value: 'true',
    valueType: 'boolean',
    group: 'security',
    description: 'Require captcha for login',
    builtIn: false,
    sort: 4,
  },
  {
    id: '14',
    name: 'Min Password Length',
    key: 'security.minPasswordLength',
    value: '6',
    valueType: 'number',
    group: 'security',
    description: 'Minimum password character count',
    builtIn: true,
    sort: 5,
  },
  {
    id: '20',
    name: 'Max Upload Size (MB)',
    key: 'upload.maxSize',
    value: '10',
    valueType: 'number',
    group: 'upload',
    description: 'Maximum single file upload size',
    builtIn: true,
    sort: 1,
  },
  {
    id: '21',
    name: 'Allowed Upload Types',
    key: 'upload.allowedTypes',
    value: 'jpg,jpeg,png,gif,pdf,doc,docx,xls,xlsx,zip',
    valueType: 'string',
    group: 'upload',
    description: 'Allowed file extensions, comma separated',
    builtIn: true,
    sort: 2,
  },
  {
    id: '22',
    name: 'Image Compression Quality',
    key: 'upload.imageQuality',
    value: '80',
    valueType: 'number',
    group: 'upload',
    description: 'Auto compression quality for uploaded images (0-100)',
    builtIn: false,
    sort: 3,
  },
  {
    id: '30',
    name: 'Enable Email Notification',
    key: 'notify.emailEnabled',
    value: 'true',
    valueType: 'boolean',
    group: 'notification',
    description: 'Enable email notification feature',
    builtIn: false,
    sort: 1,
  },
  {
    id: '31',
    name: 'SMTP Server',
    key: 'notify.smtpHost',
    value: 'smtp.example.com',
    valueType: 'string',
    group: 'notification',
    description: 'SMTP server address for sending emails',
    builtIn: false,
    sort: 2,
  },
  {
    id: '32',
    name: 'SMTP Port',
    key: 'notify.smtpPort',
    value: '465',
    valueType: 'number',
    group: 'notification',
    description: 'SMTP server port',
    builtIn: false,
    sort: 3,
  },
  {
    id: '33',
    name: 'Sender Email',
    key: 'notify.senderEmail',
    value: 'noreply@example.com',
    valueType: 'string',
    group: 'notification',
    description: 'System notification sender email',
    builtIn: false,
    sort: 4,
  },
].map((item) => ({
  ...item,
  valueType: item.valueType as SysConfig['valueType'],
  createTime: configTime,
  updateTime: configTime,
}));
let nextConfigId = 34;

const { t } = useI18n();

const groups = ref<string[]>(['basic', 'security', 'upload', 'notification']);
const selectedGroup = ref('basic');
const allConfigs = ref<SysConfig[]>([]);
const refreshKey = ref(0);
const valueTypeOptions = computed(() =>
  ['string', 'number', 'boolean', 'json'].map((value) => ({
    label: t(`config.valueTypes.${value}`),
    value,
  })),
);
const groupOptions = computed(() =>
  groups.value.map((group) => ({
    label: t(`config.groups.${group}`),
    value: group,
  })),
);
const selectedMenuKeys = computed({
  get: () => [selectedGroup.value],
  set: (keys: string[]) => {
    if (keys.length > 0) selectedGroup.value = keys[0];
  },
});

const getGroupCount = (group: string) => allConfigs.value.filter((c) => c.group === group).length;

const menuItems = computed<MenuItemType[]>(() =>
  groups.value.map((group) => ({
    key: group,
    label: h('div', { class: 'menu-item-label' }, [
      h('span', { class: 'group-name' }, t(`config.groups.${group}`)),
      h('span', { class: 'group-count' }, String(getGroupCount(group))),
    ]),
    title: t(`config.groups.${group}`),
  })),
);

const handleMenuClick = ({ key }: { key: string }) => {
  selectedGroup.value = key;
};

// modal
const modalVisible = ref(false);
const modalTitle = computed(() =>
  form.value.id ? t('config.editConfig') : t('config.createConfig'),
);
const form = ref<Partial<SysConfig>>({
  name: '',
  key: '',
  value: '',
  valueType: 'string',
  group: 'basic',
  sort: 0,
  description: '',
});
const boolValue = computed({
  get: () => form.value.value === 'true',
  set: (v: boolean) => {
    form.value.value = String(v);
  },
});

const columns: ProTableColumn[] = [
  { title: t('config.configName'), dataIndex: 'name', key: 'name', width: 160 },
  { title: t('config.configKey'), dataIndex: 'key', key: 'key', width: 200 },
  {
    title: t('config.configValue'),
    dataIndex: 'value',
    key: 'value',
    ellipsis: true,
  },
  {
    title: t('config.valueType'),
    dataIndex: 'valueType',
    key: 'valueType',
    width: 90,
  },
  {
    title: t('config.builtIn'),
    dataIndex: 'builtIn',
    key: 'builtIn',
    width: 90,
  },
  {
    title: t('config.description'),
    dataIndex: 'description',
    key: 'description',
    ellipsis: true,
  },
  {
    title: t('common.actions'),
    dataIndex: 'action',
    key: 'action',
    width: 150,
    fixed: 'right',
  },
];

const loadConfigList = async (params: Record<string, unknown>) => {
  try {
    const current = Number(params.current) || 1;
    const pageSize = Number(params.pageSize) || 20;
    const filtered = configs
      .filter((item) => item.group === selectedGroup.value)
      .sort((a, b) => a.sort - b.sort);
    const start = (current - 1) * pageSize;
    const response = {
      code: 200,
      message: 'success',
      success: true,
      data: {
        list: filtered.slice(start, start + pageSize),
        total: filtered.length,
        current,
        pageSize,
      },
    };
    if (response.code === 200) {
      return {
        data: response.data.list,
        total: response.data.total,
        success: true,
      };
    }
  } catch (error: unknown) {
    console.error(t('config.loadConfigFailed'), (error as Error).message);
  }
  return { data: [], total: 0, success: false };
};

// load all configs for group count
const loadAllConfigs = async () => {
  try {
    const response = {
      code: 200,
      message: 'success',
      success: true,
      data: { list: [...configs], total: configs.length, current: 1, pageSize: configs.length },
    };
    if (response.code === 200) allConfigs.value = response.data.list;
  } catch (_error: unknown) {}
};

const handleAdd = () => {
  form.value = {
    name: '',
    key: '',
    value: '',
    valueType: 'string',
    group: selectedGroup.value,
    sort: 0,
    description: '',
  };
  modalVisible.value = true;
};

const handleEdit = (record: SysConfig) => {
  form.value = { ...record };
  modalVisible.value = true;
};

const handleDelete = (record: SysConfig) => {
  Modal.confirm({
    title: t('config.confirmDelete'),
    content: t('config.confirmDeleteContent', { name: record.name }),
    onOk: async () => {
      try {
        if (record.builtIn) return;
        const index = configs.findIndex((item) => item.id === record.id);
        if (index !== -1) configs.splice(index, 1);
        const response = { code: 200, message: 'success', success: true };
        if (response.code === 200) {
          message.success(t('config.deleteSuccess'));
          refreshKey.value++;
          loadAllConfigs();
        } else {
          message.error(response.message || t('config.deleteFailed'));
        }
      } catch (_error: unknown) {
        message.error(t('config.deleteFailed'));
      }
    },
  });
};

const handleSubmit = async () => {
  if (!form.value.name || !form.value.key) {
    message.warning(t('config.requiredFields'));
    return;
  }
  try {
    if (configs.some((item) => item.key === form.value.key && item.id !== form.value.id)) {
      message.error('Config key already exists');
      return;
    }
    const existing = configs.find((item) => item.id === form.value.id);
    const now = new Date().toISOString().replace('T', ' ').slice(0, 19);
    const config: SysConfig = {
      ...form.value,
      id: existing?.id || String(nextConfigId++),
      name: form.value.name,
      key: form.value.key,
      value: String(form.value.value ?? ''),
      valueType: form.value.valueType || 'string',
      group: form.value.group || selectedGroup.value,
      sort: form.value.sort || 0,
      builtIn: existing?.builtIn || false,
      createTime: existing?.createTime || now,
      updateTime: now,
    };
    if (existing) configs.splice(configs.indexOf(existing), 1, config);
    else configs.push(config);
    const response = { code: 200, message: 'success', success: true, data: config };
    if (response.code === 200) {
      message.success(t(existing ? 'config.updateSuccess' : 'config.createSuccess'));
      modalVisible.value = false;
      refreshKey.value++;
      loadAllConfigs();
    }
  } catch (_error: unknown) {
    message.error(t('config.operateFailed'));
  }
};

loadAllConfigs();
</script>

<style scoped lang="scss">
.page-container {
  display: flex;
  gap: 16px;
  flex: 1;
  min-height: 0;
}

.config-groups-header {
  padding: 0 16px;
  margin-bottom: 8px;

  h3 {
    margin: 0;
    font-size: 15px;
    font-weight: 600;
    color: var(--color-text-heading);
  }
}

.config-groups-menu {
  flex: 1;
  overflow: auto;
  background: transparent;
  border: none;

  :deep(.ant-menu-item) {
    margin: 4px 8px;
    padding: 10px 12px !important;
    border-radius: 8px;
    height: auto;
    transition: all 0.2s;

    &::before {
      // Remove default selected indicator
      display: none;
    }

    &:hover {
      background: var(--color-fill-quaternary, #fafafa);
    }

    &.ant-menu-item-selected {
      background: color-mix(in srgb, var(--color-primary) 8%, transparent);

      .group-name {
        color: var(--color-primary);
        font-weight: 600;
      }
    }
  }

  .menu-item-label {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;

    .group-name {
      font-size: 14px;
      flex: 1;
    }

    .group-count {
      font-size: 12px;
      color: var(--color-text-quaternary);
      background: var(--color-fill-quaternary);
      padding: 0 8px;
      border-radius: 10px;
      line-height: 20px;
      margin-left: 8px;
      flex-shrink: 0;
    }
  }
}
</style>
