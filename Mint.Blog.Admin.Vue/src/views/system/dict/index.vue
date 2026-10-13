<template>
  <div class="page-container">
    <ProSplitLayout :side-width="260">
      <template #side>
        <!-- dict type list -->
        <div class="dict-types-header">
          <h3>{{ t('dict.dictType') }}</h3>
          <a-button type="primary" size="small" @click="handleAddType">
            <template #icon><PlusOutlined /></template>
            {{ t('common.add') }}
          </a-button>
        </div>
        <div class="dict-types-list">
          <div
            v-for="type in dictTypes"
            :key="type.id"
            class="dict-type-item"
            :class="{ active: selectedTypeCode === type.code }"
            @click="handleSelectType(type)"
          >
            <div class="type-info">
              <div class="type-name">{{ type.name }}</div>
              <div class="type-code">{{ type.code }}</div>
            </div>
            <div class="type-actions" @click.stop>
              <a-tooltip :title="t('common.edit')">
                <a-button type="text" size="small" @click="handleEditType(type)">
                  <template #icon><EditOutlined /></template>
                </a-button>
              </a-tooltip>
              <a-tooltip :title="t('common.delete')">
                <a-button type="text" size="small" danger @click="handleDeleteType(type)">
                  <template #icon><DeleteOutlined /></template>
                </a-button>
              </a-tooltip>
            </div>
          </div>
        </div>
      </template>

      <template #main>
        <!-- dict data list -->
        <ProTable
          ref="tableRef"
          v-if="selectedTypeCode"
          :key="selectedTypeCode"
          :columns="columns"
          :request="loadData"
          :search="false"
          :toolbar="{
            title: t('dict.dictDataTitle', { name: selectedTypeName }),
          }"
        >
          <template #toolbar-actions>
            <a-button type="primary" @click="handleAdd">
              <PlusOutlined /> {{ t('dict.createData') }}
            </a-button>
          </template>
          <template #bodyCell="{ column, record }">
            <template v-if="column.key === 'status'">
              <ProStatus :value="record.status" :status-map="dictStatusMap" />
            </template>
            <template v-if="column.key === 'action'">
              <a-space :size="4">
                <a-button type="link" size="small" @click="handleEdit(record)">
                  <template #icon><EditOutlined /></template>
                  {{ t('common.edit') }}
                </a-button>
                <a-button type="link" size="small" danger @click="handleDelete(record)">
                  <template #icon><DeleteOutlined /></template>
                  {{ t('common.delete') }}
                </a-button>
              </a-space>
            </template>
          </template>
        </ProTable>
        <div v-else class="dict-data-empty">
          <a-empty :description="t('dict.selectTypeHint')" />
        </div>
      </template>
    </ProSplitLayout>

    <!-- dict type modal -->
    <a-modal v-model:open="typeModalVisible" :title="typeModalTitle" @ok="handleTypeSubmit">
      <a-form :model="typeForm" :label-col="{ span: 6 }">
        <a-form-item :label="t('dict.typeName')" required>
          <a-input v-model:value="typeForm.name" :placeholder="t('dict.typeNamePlaceholder')" />
        </a-form-item>
        <a-form-item :label="t('dict.typeCode')" required>
          <a-input
            v-model:value="typeForm.code"
            :placeholder="t('dict.typeCodePlaceholder')"
            :disabled="!!typeForm.id"
          />
        </a-form-item>
        <a-form-item :label="t('dict.description')">
          <a-textarea
            v-model:value="typeForm.description"
            :placeholder="t('dict.descriptionPlaceholder')"
            :rows="3"
          />
        </a-form-item>
        <a-form-item :label="t('common.status')">
          <a-radio-group v-model:value="typeForm.status">
            <a-radio value="enabled">{{ t('dict.enabled') }}</a-radio>
            <a-radio value="disabled">{{ t('dict.disabled') }}</a-radio>
          </a-radio-group>
        </a-form-item>
      </a-form>
    </a-modal>

    <!-- dict data modal -->
    <a-modal v-model:open="dataModalVisible" :title="dataModalTitle" @ok="handleDataSubmit">
      <a-form :model="dataForm" :label-col="{ span: 6 }">
        <a-form-item :label="t('dict.dictLabel')" required>
          <a-input v-model:value="dataForm.label" :placeholder="t('dict.labelPlaceholder')" />
        </a-form-item>
        <a-form-item :label="t('dict.dictValue')" required>
          <a-input v-model:value="dataForm.value" :placeholder="t('dict.valuePlaceholder')" />
        </a-form-item>
        <a-form-item :label="t('dict.sort')">
          <a-input-number v-model:value="dataForm.sort" :min="0" style="width: 100%" />
        </a-form-item>
        <a-form-item :label="t('common.status')">
          <a-radio-group v-model:value="dataForm.status">
            <a-radio value="enabled">{{ t('dict.enabled') }}</a-radio>
            <a-radio value="disabled">{{ t('dict.disabled') }}</a-radio>
          </a-radio-group>
        </a-form-item>
        <a-form-item :label="t('dict.remark')">
          <a-textarea
            v-model:value="dataForm.remark"
            :placeholder="t('dict.remarkPlaceholder')"
            :rows="3"
          />
        </a-form-item>
      </a-form>
    </a-modal>
  </div>
</template>

<script lang="ts">
import type { DictType, DictData } from '@/types/dict';

const initialTime = '2026-01-01 10:00:00';
export const initialDictTypes: DictType[] = [
  ['用户状态', 'user_status', '用户账号状态'],
  ['性别', 'gender', '用户性别'],
  ['订单状态', 'order_status', '订单状态'],
  ['支付方式', 'payment_method', '支付方式'],
  ['通知类型', 'notification_type', '系统通知类型'],
].map(([name, code, description], index) => ({
  id: String(index + 1),
  name,
  code,
  description,
  status: 'enabled',
  createTime: initialTime,
  updateTime: initialTime,
}));

export const initialDictData: DictData[] = [
  ['user_status', '正常', 'active', 1],
  ['user_status', '禁用', 'inactive', 2],
  ['user_status', '锁定', 'locked', 3],
  ['gender', '男', 'male', 1],
  ['gender', '女', 'female', 2],
  ['gender', '未知', 'unknown', 3],
  ['order_status', '待支付', 'pending', 1],
  ['order_status', '已支付', 'paid', 2],
  ['order_status', '配送中', 'shipping', 3],
  ['order_status', '已完成', 'completed', 4],
  ['order_status', '已取消', 'cancelled', 5],
  ['payment_method', '支付宝', 'alipay', 1],
  ['payment_method', '微信支付', 'wechat', 2],
  ['payment_method', '银行卡', 'bank_card', 3],
  ['notification_type', '系统通知', 'system', 1],
  ['notification_type', '订单通知', 'order', 2],
  ['notification_type', '活动通知', 'activity', 3],
].map(([typeCode, label, value, sort], index) => ({
  id: String(index + 1),
  typeCode: String(typeCode),
  label: String(label),
  value: String(value),
  sort: Number(sort),
  status: 'enabled',
  createTime: initialTime,
  updateTime: initialTime,
}));
</script>

<script setup lang="ts">
import type { ProTableColumn, ProStatusMap } from '@/types/pro';

import { PlusOutlined, EditOutlined, DeleteOutlined } from '@antdv-next/icons';
import { message, Modal } from 'antdv-next';
import { ref, computed } from 'vue';
import { useI18n } from 'vue-i18n';

import ProSplitLayout from '@/components/Pro/ProSplitLayout/index.vue';
import ProStatus from '@/components/Pro/ProStatus/index.vue';
import ProTable from '@/components/Pro/ProTable/index.vue';
import { useDictStore } from '@/stores/dict';

const { t } = useI18n();
const dictStore = useDictStore();
const tableRef = ref<InstanceType<typeof ProTable>>();

const dictStatusMap = computed<ProStatusMap>(() => ({
  enabled: { text: t('dict.enabled'), color: '#52c41a' },
  disabled: { text: t('dict.disabled'), color: '#bfbfbf' },
}));

// dict type list
const dictTypes = ref<DictType[]>([]);
const selectedTypeCode = ref<string>('');
const selectedTypeName = computed(() => {
  const type = dictTypes.value.find((item) => item.code === selectedTypeCode.value);
  return type?.name || '';
});

// dict type modal
const typeModalVisible = ref(false);
const typeModalTitle = computed(() =>
  typeForm.value.id ? t('dict.editType') : t('dict.createType'),
);
const typeForm = ref<Partial<DictType>>({
  name: '',
  code: '',
  description: '',
  status: 'enabled',
});

// dict data modal
const dataModalVisible = ref(false);
const dataModalTitle = computed(() =>
  dataForm.value.id ? t('dict.editData') : t('dict.createData'),
);
const dataForm = ref<Partial<DictData>>({
  label: '',
  value: '',
  sort: 0,
  status: 'enabled',
  remark: '',
});

// table columns
const columns: ProTableColumn[] = [
  {
    title: t('dict.dictLabel'),
    dataIndex: 'label',
    key: 'label',
  },
  {
    title: t('dict.dictValue'),
    dataIndex: 'value',
    key: 'value',
  },
  {
    title: t('dict.sort'),
    dataIndex: 'sort',
    key: 'sort',
    width: 80,
  },
  {
    title: t('common.status'),
    dataIndex: 'status',
    key: 'status',
    width: 80,
  },
  {
    title: t('dict.remark'),
    dataIndex: 'remark',
    key: 'remark',
  },
  {
    title: t('common.actions'),
    dataIndex: 'action',
    key: 'action',
    width: 150,
    fixed: 'right',
  },
];

// load dict type list
const loadDictTypes = async () => {
  await dictStore.loadDictData();
  const response = { code: 200, data: dictStore.dictTypes };
  dictTypes.value = response.data;
  if (!dictTypes.value.some((item) => item.code === selectedTypeCode.value)) {
    selectedTypeCode.value = dictTypes.value[0]?.code || '';
  }
};

// load dict data list
const loadData = async (params: Record<string, unknown>) => {
  await dictStore.loadDictData();
  const filtered = dictStore.allDictData
    .filter(
      (item) =>
        item.typeCode === selectedTypeCode.value &&
        (!params.label || item.label.includes(String(params.label))) &&
        (!params.value || item.value.includes(String(params.value))) &&
        (!params.status || item.status === params.status),
    )
    .sort((a, b) => a.sort - b.sort);
  const pageSize = Number(params.pageSize || 10);
  const start = (Number(params.current || 1) - 1) * pageSize;
  const response = {
    code: 200,
    data: { list: filtered.slice(start, start + pageSize), total: filtered.length },
  };
  return { data: response.data.list, total: response.data.total, success: true };
};

// select dict type
const handleSelectType = (type: DictType) => {
  selectedTypeCode.value = type.code;
};

// add dict type
const handleAddType = () => {
  typeForm.value = {
    name: '',
    code: '',
    description: '',
    status: 'enabled',
  };
  typeModalVisible.value = true;
};

// edit dict type
const handleEditType = (type: DictType) => {
  typeForm.value = { ...type };
  typeModalVisible.value = true;
};

// delete dict type
const handleDeleteType = (type: DictType) => {
  Modal.confirm({
    title: t('dict.confirmDelete'),
    content: t('dict.confirmDeleteType', { name: type.name }),
    onOk: async () => {
      dictStore.dictTypes = dictStore.dictTypes.filter((item) => item.id !== type.id);
      dictStore.allDictData = dictStore.allDictData.filter((item) => item.typeCode !== type.code);
      await loadDictTypes();
      message.success(t('dict.deleteSuccess'));
    },
  });
};

// submit dict type
const handleTypeSubmit = async () => {
  if (!typeForm.value.name || !typeForm.value.code) {
    message.warning(t('dict.requiredFields'));
    return;
  }

  const now = new Date().toISOString();
  const existing = dictStore.dictTypes.find((item) => item.id === typeForm.value.id);
  const response = {
    code: 200,
    data: {
      ...typeForm.value,
      id: existing?.id || crypto.randomUUID(),
      name: typeForm.value.name,
      code: typeForm.value.code,
      status: typeForm.value.status || 'enabled',
      createTime: existing?.createTime || now,
      updateTime: now,
    } satisfies DictType,
  };
  if (existing) Object.assign(existing, response.data);
  else dictStore.dictTypes.push(response.data);
  message.success(t(existing ? 'dict.updateSuccess' : 'dict.createSuccess'));
  typeModalVisible.value = false;
  await loadDictTypes();
};

// add dict data
const handleAdd = () => {
  dataForm.value = {
    typeCode: selectedTypeCode.value,
    label: '',
    value: '',
    sort: 0,
    status: 'enabled',
    remark: '',
  };
  dataModalVisible.value = true;
};

// edit dict data
const handleEdit = (record: DictData) => {
  dataForm.value = { ...record };
  dataModalVisible.value = true;
};

// delete dict data
const handleDelete = (record: DictData) => {
  Modal.confirm({
    title: t('dict.confirmDelete'),
    content: t('dict.confirmDeleteData', { label: record.label }),
    onOk: () => {
      dictStore.allDictData = dictStore.allDictData.filter((item) => item.id !== record.id);
      tableRef.value?.reload();
      message.success(t('dict.deleteSuccess'));
    },
  });
};

// submit dict data
const handleDataSubmit = async () => {
  if (!dataForm.value.label || !dataForm.value.value) {
    message.warning(t('dict.requiredFields'));
    return;
  }

  const now = new Date().toISOString();
  const existing = dictStore.allDictData.find((item) => item.id === dataForm.value.id);
  const response = {
    code: 200,
    data: {
      ...dataForm.value,
      id: existing?.id || crypto.randomUUID(),
      typeCode: selectedTypeCode.value,
      label: dataForm.value.label,
      value: dataForm.value.value,
      sort: dataForm.value.sort ?? 0,
      status: dataForm.value.status || 'enabled',
      createTime: existing?.createTime || now,
      updateTime: now,
    } satisfies DictData,
  };
  if (existing) Object.assign(existing, response.data);
  else dictStore.allDictData.push(response.data);
  message.success(t(existing ? 'dict.updateSuccess' : 'dict.createSuccess'));
  dataModalVisible.value = false;
  tableRef.value?.reload();
};

// init
loadDictTypes();
</script>

<style scoped lang="scss">
// dict types content
.dict-types-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
  padding-bottom: 12px;
  border-bottom: 1px solid var(--color-border-secondary, #f0f0f0);

  h3 {
    margin: 0;
    font-size: 15px;
    font-weight: 600;
    color: var(--color-text);
  }
}

.dict-types-list {
  flex: 1;
  overflow-y: auto;
  margin: 0 -8px;
  padding: 0 8px;

  &::-webkit-scrollbar {
    width: 4px;
  }
  &::-webkit-scrollbar-thumb {
    background: rgba(0, 0, 0, 0.1);
    border-radius: 4px;
  }
  &::-webkit-scrollbar-track {
    background: transparent;
  }

  .dict-type-item {
    position: relative;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 12px 12px 12px 16px;
    border-radius: 8px;
    cursor: pointer;
    margin-bottom: 4px;
    border: none;
    transition: all 0.2s ease;
    overflow: hidden;

    &::before {
      content: '';
      position: absolute;
      left: 0;
      top: 50%;
      transform: translateY(-50%);
      width: 3px;
      height: 0;
      background: var(--ant-primary-color);
      border-radius: 0 3px 3px 0;
      transition: height 0.2s ease;
    }

    &:hover {
      background: var(--color-fill-quaternary, #fafafa);

      .type-actions {
        opacity: 1;
        transform: translateX(0);
      }
    }

    &.active {
      background: color-mix(in srgb, var(--color-primary) 8%, transparent);

      &::before {
        height: 60%;
      }

      .type-name {
        color: var(--color-primary);
        font-weight: 600;
      }
    }

    .type-info {
      flex: 1;
      min-width: 0;

      .type-name {
        font-size: 14px;
        font-weight: 500;
        margin-bottom: 2px;
        color: var(--color-text);
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        transition: color 0.2s;
      }

      .type-code {
        font-size: 12px;
        color: var(--color-text-quaternary, #bfbfbf);
        font-family: 'SF Mono', 'Monaco', 'Menlo', monospace;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
      }
    }

    .type-actions {
      display: flex;
      gap: 2px;
      opacity: 0;
      transform: translateX(8px);
      transition: all 0.2s ease;
      flex-shrink: 0;
    }
  }
}

// dict data content
:deep(.ant-table-thead > tr > th),
:deep(.ant-table-thead > tr > td) {
  background: var(--color-fill-quaternary, #fafafa);
}

.dict-data-empty {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
}
</style>
