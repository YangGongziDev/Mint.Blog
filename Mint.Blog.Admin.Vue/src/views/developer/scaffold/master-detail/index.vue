<template>
  <div class="page-container">
    <div class="card">
      <h2>{{ $t('developer.scaffold.masterDetail.title') }}</h2>
      <p class="text-secondary mb-lg">{{ $t('developer.scaffold.masterDetail.description') }}</p>

      <ProTable
        layout="content"
        :columns="columns"
        :data-source="listData"
        :search="false"
        :toolbar="false"
        row-key="id"
        :pagination="{ pageSize: 8 }"
        :show-index-column="false"
        :on-row="buildRowProps"
      >
        <template #bodyCell="{ column, record }">
          <template v-if="column.dataIndex === 'status'">
            <a-tag :color="getStatusColor(record.status)">{{ getStatusText(record.status) }}</a-tag>
          </template>
        </template>
      </ProTable>
    </div>

    <a-drawer
      v-model:open="drawerOpen"
      width="560"
      :title="$t('developer.scaffold.masterDetail.drawerTitle')"
      :destroy-on-hidden="false"
    >
      <template v-if="activeRecord">
        <ProDetail
          :title="`#${activeRecord.id}`"
          :sub-title="$t('developer.scaffold.masterDetail.ticketNumber')"
          :tags="[
            {
              text: getStatusText(activeRecord.status),
              color: getStatusColor(activeRecord.status),
            },
          ]"
          :descriptions="detailColumns"
          :data="activeRecord"
          :description-column="1"
          :tabs="drawerTabs"
          v-model:active-tab="activeTab"
        >
          <template #tab-desc>
            <div class="tab-panel">
              {{ activeRecord.description }}
            </div>
          </template>
          <template #tab-logs>
            <a-timeline>
              <a-timeline-item v-for="log in activeRecord.logs" :key="log.time + log.action">
                <strong>{{ log.action }}</strong>
                <div class="text-secondary">{{ log.operator }} · {{ log.time }}</div>
              </a-timeline-item>
            </a-timeline>
          </template>
        </ProDetail>
      </template>
    </a-drawer>
  </div>
</template>

<script setup lang="ts">
import type { ProDescriptionItem, ProDetailTab, ProTableColumn } from '@/types/pro';

import { computed, ref } from 'vue';

import ProDetail from '@/components/Pro/ProDetail/index.vue';
import ProTable from '@/components/Pro/ProTable/index.vue';
import { $t } from '@/locales';

type TicketStatus = 'open' | 'processing' | 'closed';

interface TicketRecord {
  id: string;
  title: string;
  owner: string;
  priority: 'P0' | 'P1' | 'P2';
  status: TicketStatus;
  createdAt: string;
  description: string;
  logs: Array<{
    action: string;
    operator: string;
    time: string;
  }>;
}

const statusTextMap: Record<TicketStatus, string> = computed(() => ({
  open: $t('developer.scaffold.masterDetail.statusOpen'),
  processing: $t('developer.scaffold.masterDetail.statusProcessing'),
  closed: $t('developer.scaffold.masterDetail.statusClosed'),
})).value;

const statusColorMap: Record<TicketStatus, string> = {
  open: 'blue',
  processing: 'processing',
  closed: 'default',
};

const listData = ref<TicketRecord[]>(
  Array.from({ length: 18 }, (_, index) => {
    const i = index + 1;

    return {
      id: `T${String(i).padStart(4, '0')}`,
      title: $t('developer.scaffold.masterDetail.ticketTitle', { index: i }),
      owner:
        i % 2 === 0
          ? $t('developer.scaffold.masterDetail.ownerZhang')
          : $t('developer.scaffold.masterDetail.ownerLi'),
      priority: i % 5 === 0 ? 'P0' : i % 2 === 0 ? 'P1' : 'P2',
      status: i % 4 === 0 ? 'closed' : i % 3 === 0 ? 'processing' : 'open',
      createdAt: new Date(Date.now() - i * 3600 * 1000).toLocaleString(),
      description: $t('developer.scaffold.masterDetail.ticketDescription', { index: i }),
      logs: [
        {
          action: $t('developer.scaffold.masterDetail.actionCreate'),
          operator: $t('developer.scaffold.masterDetail.operatorSystem'),
          time: new Date(Date.now() - i * 3600 * 1000).toLocaleString(),
        },
        {
          action: $t('developer.scaffold.masterDetail.actionAssign'),
          operator: $t('developer.scaffold.masterDetail.operatorDispatch'),
          time: new Date(Date.now() - i * 1800 * 1000).toLocaleString(),
        },
      ],
    };
  }),
);

const columns = computed<ProTableColumn[]>(() => [
  { title: $t('developer.scaffold.masterDetail.colTicketNumber'), dataIndex: 'id', width: 120 },
  { title: $t('developer.scaffold.masterDetail.colTitle'), dataIndex: 'title', ellipsis: true },
  { title: $t('developer.scaffold.masterDetail.colOwner'), dataIndex: 'owner', width: 120 },
  { title: $t('developer.scaffold.masterDetail.colPriority'), dataIndex: 'priority', width: 100 },
  { title: $t('developer.scaffold.masterDetail.colStatus'), dataIndex: 'status', width: 120 },
  { title: $t('developer.scaffold.masterDetail.colCreatedAt'), dataIndex: 'createdAt', width: 190 },
]);

const detailColumns = computed<ProDescriptionItem[]>(() => [
  { label: $t('developer.scaffold.masterDetail.titleLabel'), dataIndex: 'title' },
  { label: $t('developer.scaffold.masterDetail.ownerLabel'), dataIndex: 'owner' },
  { label: $t('developer.scaffold.masterDetail.priorityLabel'), dataIndex: 'priority' },
  { label: $t('developer.scaffold.masterDetail.createdAtLabel'), dataIndex: 'createdAt' },
]);

const drawerTabs = computed<ProDetailTab[]>(() => [
  { key: 'desc', label: $t('developer.scaffold.masterDetail.descTab') },
  { key: 'logs', label: $t('developer.scaffold.masterDetail.logsTab') },
]);

const drawerOpen = ref(false);
const activeTab = ref('desc');
const activeRecord = ref<TicketRecord | null>(null);

const buildRowProps = (record: TicketRecord) => {
  return {
    style: { cursor: 'pointer' },
    onClick: () => {
      activeRecord.value = record;
      activeTab.value = 'desc';
      drawerOpen.value = true;
    },
  };
};

const getStatusText = (status: unknown) => {
  const key = (status || 'open') as TicketStatus;
  return statusTextMap[key] || statusTextMap.open;
};

const getStatusColor = (status: unknown) => {
  const key = (status || 'open') as TicketStatus;
  return statusColorMap[key] || statusColorMap.open;
};
</script>

<style scoped lang="scss">
.mb-lg {
  margin-bottom: var(--spacing-lg);
}

.tab-panel {
  line-height: 1.8;
  color: var(--color-text-secondary);
}
</style>
