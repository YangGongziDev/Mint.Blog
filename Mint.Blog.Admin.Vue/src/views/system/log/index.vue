<template>
  <div class="page-container">
    <div class="log-container">
      <a-tabs v-model:activeKey="activeTab" @change="handleTabChange">
        <a-tab-pane key="operation" :tab="t('log.operationLog')">
          <ProTable
            ref="operationTableRef"
            :key="'operation-' + operationRefreshKey"
            :columns="operationColumns"
            :request="loadOperationLogs"
            :toolbar="{ title: t('log.operationLog') }"
            :search="{ formItems: operationSearchFormItems }"
          >
            <template #toolbar-actions>
              <a-button danger @click="handleClearOperationLog">
                <DeleteOutlined /> {{ t('log.clearLog') }}
              </a-button>
            </template>
            <template #bodyCell="{ column, record }">
              <template v-if="column.key === 'action'">
                <a-tag :color="actionColorMap[record.action] || 'default'">
                  {{ t(`log.actionTypes.${record.action}`) || record.action }}
                </a-tag>
              </template>
              <template v-if="column.key === 'status'">
                <ProStatus :value="record.status" :status-map="logStatusMap" />
              </template>
              <template v-if="column.key === 'duration'">
                <span
                  :style="{
                    color:
                      record.duration > 300
                        ? '#ff4d4f'
                        : record.duration > 100
                          ? '#faad14'
                          : '#52c41a',
                  }"
                >
                  {{ record.duration }}ms
                </span>
              </template>
            </template>
          </ProTable>
        </a-tab-pane>

        <a-tab-pane key="login" :tab="t('log.loginLog')">
          <ProTable
            ref="loginTableRef"
            :key="'login-' + loginRefreshKey"
            :columns="loginColumns"
            :request="loadLoginLogs"
            :toolbar="{ title: t('log.loginLog') }"
            :search="{ formItems: loginSearchFormItems }"
          >
            <template #toolbar-actions>
              <a-button danger @click="handleClearLoginLog">
                <DeleteOutlined /> {{ t('log.clearLog') }}
              </a-button>
            </template>
            <template #bodyCell="{ column, record }">
              <template v-if="column.key === 'status'">
                <ProStatus :value="record.status" :status-map="logStatusMap" />
              </template>
            </template>
          </ProTable>
        </a-tab-pane>
      </a-tabs>
    </div>
  </div>
</template>

<script setup lang="ts">
import type { OperationLog, LoginLog } from '@/types/log';
import type { ProFormItem, ProTableColumn, ProStatusMap } from '@/types/pro';

import { DeleteOutlined } from '@antdv-next/icons';
import { message, Modal } from 'antdv-next';
import { ref, computed } from 'vue';
import { useI18n } from 'vue-i18n';

import ProStatus from '@/components/Pro/ProStatus/index.vue';
import ProTable from '@/components/Pro/ProTable/index.vue';

const operationLogs: OperationLog[] = [
  {
    module: 'systemLogin',
    action: 'login',
    description: 'System login',
    method: 'POST',
    url: '/api/auth/login',
    status: 'success',
    duration: 45,
  },
  {
    module: 'userManagement',
    action: 'create',
    description: 'Create user',
    method: 'POST',
    url: '/api/user',
    status: 'success',
    duration: 120,
  },
  {
    module: 'roleManagement',
    action: 'update',
    description: 'Update role permissions',
    method: 'PUT',
    url: '/api/role/1',
    status: 'fail',
    duration: 35,
  },
  {
    module: 'menuManagement',
    action: 'delete',
    description: 'Delete menu',
    method: 'DELETE',
    url: '/api/permission/1',
    status: 'success',
    duration: 80,
  },
  {
    module: 'dictionary',
    action: 'create',
    description: 'Create dict data',
    method: 'POST',
    url: '/api/dict/data',
    status: 'success',
    duration: 150,
  },
  {
    module: 'profile',
    action: 'update',
    description: 'Update profile',
    method: 'PUT',
    url: '/api/profile',
    status: 'success',
    duration: 60,
  },
  {
    module: 'dashboard',
    action: 'other',
    description: 'View dashboard',
    method: 'GET',
    url: '/api/dashboard/stats',
    status: 'success',
    duration: 350,
  },
  {
    module: 'userManagement',
    action: 'export',
    description: 'Export user list',
    method: 'GET',
    url: '/api/user/export',
    status: 'success',
    duration: 420,
  },
  {
    module: 'systemLogin',
    action: 'logout',
    description: 'System logout',
    method: 'POST',
    url: '/api/auth/logout',
    status: 'success',
    duration: 20,
  },
  {
    module: 'dictionary',
    action: 'update',
    description: 'Update dict data',
    method: 'PUT',
    url: '/api/dict/data/1',
    status: 'fail',
    duration: 30,
  },
  {
    module: 'roleManagement',
    action: 'create',
    description: 'Create role',
    method: 'POST',
    url: '/api/role',
    status: 'success',
    duration: 100,
  },
  {
    module: 'userManagement',
    action: 'delete',
    description: 'Delete user',
    method: 'DELETE',
    url: '/api/user/1',
    status: 'success',
    duration: 75,
  },
].map((item, index) => ({
  ...item,
  id: String(index + 1),
  action: item.action as OperationLog['action'],
  status: item.status as OperationLog['status'],
  username: ['admin', 'user', 'zhangsan', 'lisi'][index % 4],
  ip: `192.168.1.${100 + index}`,
  browser: 'Chrome 120',
  os: 'Windows 11',
  errorMsg: item.status === 'fail' ? 'Insufficient permissions' : undefined,
  createTime: `2026-06-${String(12 - index).padStart(2, '0')} 10:00:00`,
}));
const loginLogs: LoginLog[] = [
  { username: 'admin', status: 'success', message: 'Login successful' },
  { username: 'user', status: 'fail', message: 'Wrong password' },
  { username: 'zhangsan', status: 'success', message: 'Login successful' },
  { username: 'lisi', status: 'fail', message: 'Account locked' },
  { username: 'wangwu', status: 'fail', message: 'Captcha error' },
  { username: 'user', status: 'success', message: 'Login successful' },
  { username: 'admin', status: 'success', message: 'Login successful' },
  { username: 'zhangsan', status: 'fail', message: 'Wrong password' },
  { username: 'lisi', status: 'success', message: 'Login successful' },
  { username: 'wangwu', status: 'success', message: 'Login successful' },
  { username: 'user', status: 'fail', message: 'Captcha error' },
  { username: 'admin', status: 'success', message: 'Login successful' },
].map((item, index) => ({
  ...item,
  id: String(index + 1),
  status: item.status as LoginLog['status'],
  ip: `192.168.1.${100 + index}`,
  browser: ['Chrome 120', 'Firefox 121', 'Safari 17', 'Edge 120'][index % 4],
  os: ['Windows 11', 'macOS 14', 'Ubuntu 22.04', 'iOS 17'][index % 4],
  createTime: `2026-06-${String(12 - index).padStart(2, '0')} 09:00:00`,
}));

const { t } = useI18n();

const logStatusMap = computed<ProStatusMap>(() => ({
  success: { text: t('log.success'), color: '#52c41a' },
  fail: { text: t('log.fail'), color: '#ff4d4f' },
}));

const activeTab = ref('operation');
const operationRefreshKey = ref(0);
const loginRefreshKey = ref(0);

const actionColorMap: Record<string, string> = {
  login: 'blue',
  logout: 'default',
  create: 'green',
  update: 'orange',
  delete: 'red',
  export: 'purple',
  import: 'cyan',
  other: 'default',
};

// operation log search form items
const operationSearchFormItems = computed<ProFormItem[]>(() => [
  { name: 'username', label: t('log.operationUser'), type: 'input' },
  {
    name: 'module',
    label: t('log.operationModule'),
    type: 'select',
    options: [
      { label: t('log.modules.userManagement'), value: 'userManagement' },
      { label: t('log.modules.roleManagement'), value: 'roleManagement' },
      { label: t('log.modules.menuManagement'), value: 'menuManagement' },
      { label: t('log.modules.dictionary'), value: 'dictionary' },
      { label: t('log.modules.systemLogin'), value: 'systemLogin' },
      { label: t('log.modules.profile'), value: 'profile' },
      { label: t('log.modules.dashboard'), value: 'dashboard' },
    ],
  },
  {
    name: 'action',
    label: t('log.operationType'),
    type: 'select',
    options: [
      { label: t('log.actionTypes.login'), value: 'login' },
      { label: t('log.actionTypes.logout'), value: 'logout' },
      { label: t('log.actionTypes.create'), value: 'create' },
      { label: t('log.actionTypes.update'), value: 'update' },
      { label: t('log.actionTypes.delete'), value: 'delete' },
      { label: t('log.actionTypes.export'), value: 'export' },
    ],
  },
  {
    name: 'status',
    label: t('common.status'),
    type: 'select',
    options: [
      { label: t('log.success'), value: 'success' },
      { label: t('log.fail'), value: 'fail' },
    ],
  },
]);

// operation log columns
const operationColumns = computed<ProTableColumn[]>(() => [
  {
    title: t('log.operationUser'),
    dataIndex: 'username',
    key: 'username',
    width: 100,
  },
  {
    title: t('log.operationModule'),
    dataIndex: 'module',
    key: 'module',
    width: 110,
  },
  {
    title: t('log.operationType'),
    dataIndex: 'action',
    key: 'action',
    width: 90,
  },
  {
    title: t('log.operationDescription'),
    dataIndex: 'description',
    key: 'description',
    ellipsis: true,
  },
  {
    title: t('log.requestMethod'),
    dataIndex: 'method',
    key: 'method',
    width: 90,
  },
  {
    title: t('log.ipAddress'),
    dataIndex: 'ip',
    key: 'ip',
    width: 130,
  },
  {
    title: t('common.status'),
    dataIndex: 'status',
    key: 'status',
    width: 80,
  },
  {
    title: t('log.duration'),
    dataIndex: 'duration',
    key: 'duration',
    width: 80,
  },
  {
    title: t('log.operationTime'),
    dataIndex: 'createTime',
    key: 'createTime',
    width: 170,
  },
]);

// login log search form items
const loginSearchFormItems = computed<ProFormItem[]>(() => [
  { name: 'username', label: t('log.username'), type: 'input' },
  { name: 'ip', label: t('log.ipAddress'), type: 'input' },
  {
    name: 'status',
    label: t('common.status'),
    type: 'select',
    options: [
      { label: t('log.success'), value: 'success' },
      { label: t('log.fail'), value: 'fail' },
    ],
  },
]);

// login log columns
const loginColumns = computed<ProTableColumn[]>(() => [
  {
    title: t('log.username'),
    dataIndex: 'username',
    key: 'username',
    width: 120,
  },
  {
    title: t('log.ipAddress'),
    dataIndex: 'ip',
    key: 'ip',
    width: 140,
  },
  {
    title: t('log.browser'),
    dataIndex: 'browser',
    key: 'browser',
    width: 130,
  },
  {
    title: t('log.os'),
    dataIndex: 'os',
    key: 'os',
    width: 130,
  },
  {
    title: t('common.status'),
    dataIndex: 'status',
    key: 'status',
    width: 80,
  },
  {
    title: t('log.message'),
    dataIndex: 'message',
    key: 'message',
    ellipsis: true,
  },
  {
    title: t('log.loginTime'),
    dataIndex: 'createTime',
    key: 'createTime',
    width: 170,
  },
]);

const handleTabChange = () => {};

const loadOperationLogs = async (params: Record<string, unknown>) => {
  try {
    const current = Number(params.current) || 1;
    const pageSize = Number(params.pageSize) || 10;
    const filtered = operationLogs.filter(
      (item) =>
        (!params.username || item.username.includes(String(params.username))) &&
        (!params.module || item.module === params.module) &&
        (!params.action || item.action === params.action) &&
        (!params.status || item.status === params.status) &&
        (!params.startTime || item.createTime >= String(params.startTime)) &&
        (!params.endTime || item.createTime <= String(params.endTime)),
    );
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
    console.error(t('log.loadOperationLogFailed'), (error as Error).message);
  }
  return { data: [], total: 0, success: false };
};

const loadLoginLogs = async (params: Record<string, unknown>) => {
  try {
    const current = Number(params.current) || 1;
    const pageSize = Number(params.pageSize) || 10;
    const filtered = loginLogs.filter(
      (item) =>
        (!params.username || item.username.includes(String(params.username))) &&
        (!params.ip || item.ip.includes(String(params.ip))) &&
        (!params.status || item.status === params.status) &&
        (!params.startTime || item.createTime >= String(params.startTime)) &&
        (!params.endTime || item.createTime <= String(params.endTime)),
    );
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
    console.error(t('log.loadLoginLogFailed'), (error as Error).message);
  }
  return { data: [], total: 0, success: false };
};

const handleClearOperationLog = () => {
  Modal.confirm({
    title: t('log.confirmClear'),
    content: t('log.confirmClearOperation'),
    okType: 'danger',
    onOk: async () => {
      try {
        operationLogs.length = 0;
        const response = { code: 200, message: 'success', success: true };
        if (response.code === 200) {
          message.success(t('log.clearSuccess'));
          operationRefreshKey.value++;
        }
      } catch (_error: unknown) {
        message.error(t('log.clearFailed'));
      }
    },
  });
};

const handleClearLoginLog = () => {
  Modal.confirm({
    title: t('log.confirmClear'),
    content: t('log.confirmClearLogin'),
    okType: 'danger',
    onOk: async () => {
      try {
        loginLogs.length = 0;
        const response = { code: 200, message: 'success', success: true };
        if (response.code === 200) {
          message.success(t('log.clearSuccess'));
          loginRefreshKey.value++;
        }
      } catch (_error: unknown) {
        message.error(t('log.clearFailed'));
      }
    },
  });
};
</script>

<style scoped lang="scss">
.log-container {
  background: var(--color-bg-container);
  border-radius: 8px;
  padding: 16px 20px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
  flex: 1;
  min-height: 0;
  display: flex;
  flex-direction: column;

  :deep(.ant-tabs) {
    flex: 1;
    min-height: 0;
    display: flex;
    flex-direction: column;
  }

  :deep(.ant-tabs-content-holder) {
    flex: 1;
    min-height: 0;
  }

  :deep(.ant-tabs-content) {
    height: 100%;
  }

  :deep(.ant-tabs-tabpane) {
    height: 100%;
  }

  :deep(.ant-tabs-nav) {
    margin-bottom: 8px;
  }

  :deep(.ant-table-thead > tr > th),
  :deep(.ant-table-thead > tr > td) {
    background: var(--color-fill-quaternary);
  }
}
</style>
