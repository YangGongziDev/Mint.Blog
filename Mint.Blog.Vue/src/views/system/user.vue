<template>
  <LookForward v-if="isDetailPage">
    <p>{{ detailId }}</p>
  </LookForward>
  <div v-else class="min-h-[500px] flex flex-col gap-[16px] overflow-hidden max-sm:overflow-auto">
    <ACard :title="$t('common.search')" :bordered="false" class="card-wrapper">
      <AForm ref="searchFormRef" :model="searchParams" :label-col="{ span: 6, md: 8 }">
        <ARow :gutter="[16, 16]" wrap>
          <ACol :span="24" :md="12" :lg="6">
            <AFormItem label="用户名" name="userName" class="m-0">
              <AInput v-model:value="searchParams.userName" placeholder="请输入用户名" />
            </AFormItem>
          </ACol>
          <ACol :span="24" :md="12" :lg="6">
            <AFormItem label="显示名称" name="displayName" class="m-0">
              <AInput v-model:value="searchParams.displayName" placeholder="请输入显示名称" />
            </AFormItem>
          </ACol>
          <ACol :span="24" :md="12" :lg="6">
            <AFormItem label="删除状态" name="isDeleted" class="m-0">
              <ASelect
                v-model:value="searchParams.isDeleted"
                placeholder="请选择删除状态"
                :options="isDeletedOptions"
                allow-clear
              />
            </AFormItem>
          </ACol>
          <ACol :span="24" :md="12" :lg="6" class="search-action-col">
            <AFormItem class="m-0">
              <div class="search-action-group w-full flex flex-wrap items-center justify-end gap-3">
                <AButton class="search-action-btn" @click="handleSearchReset">
                  <template #icon>
                    <icon-ic-round-refresh class="align-sub text-icon" />
                  </template>
                  <span class="ml-[8px] whitespace-nowrap">{{ $t('common.reset') }}</span>
                </AButton>
                <AButton type="primary" ghost class="search-action-btn" @click="handleSearch">
                  <template #icon>
                    <icon-ic-round-search class="align-sub text-icon" />
                  </template>
                  <span class="ml-[8px] whitespace-nowrap">{{ $t('common.search') }}</span>
                </AButton>
              </div>
            </AFormItem>
          </ACol>
        </ARow>
      </AForm>
    </ACard>

    <ACard
      title="用户管理"
      :bordered="false"
      :body-style="{ flex: 1, overflow: 'hidden' }"
      class="min-h-0 flex flex-col card-wrapper sm:min-w-0 sm:flex-1 sm:overflow-hidden"
    >
      <template #extra>
        <TableHeaderOperation
          v-model:columns="columnChecks"
          :disabled-delete="checkedRowKeys.length === 0"
          :loading="loading"
          @add="handleAdd"
          @delete="handleBatchDelete"
          @refresh="getData"
        />
      </template>
      <ATable
        ref="tableWrapperRef"
        :columns="columns"
        :data-source="data"
        size="small"
        :row-selection="rowSelection"
        :scroll="scrollConfig"
        :loading="loading"
        row-key="id"
        :pagination="mobilePagination"
        class="h-full"
      />

      <ADrawer v-model:open="drawerVisible" :title="drawerTitle" :width="360">
        <AForm ref="drawerFormRef" layout="vertical" :model="drawerModel" :rules="drawerRules">
          <AFormItem label="用户名" name="userName">
            <AInput v-model:value="drawerModel.userName" placeholder="请输入用户名" />
          </AFormItem>
          <AFormItem label="显示名称" name="displayName">
            <AInput v-model:value="drawerModel.displayName" placeholder="请输入显示名称" />
          </AFormItem>
          <AFormItem label="删除状态" name="isDeleted">
            <ARadioGroup v-model:value="drawerModel.isDeleted">
              <ARadio :value="0">0 - 未删除</ARadio>
              <ARadio :value="1">1 - 已删除</ARadio>
            </ARadioGroup>
          </AFormItem>
        </AForm>
        <template #footer>
          <ASpace :size="16">
            <AButton @click="closeDrawer">{{ $t('common.cancel') }}</AButton>
            <AButton type="primary" @click="handleDrawerSubmit">{{ $t('common.confirm') }}</AButton>
          </ASpace>
        </template>
      </ADrawer>
    </ACard>
  </div>
</template>

<script setup lang="tsx">
import { computed, ref, watch } from 'vue';
import { useRoute } from 'vue-router';
import { Button, Popconfirm, Tag } from 'ant-design-vue';
import { fetchGetUserList, fetchUpdateUser } from '@/service/system/user';
import { useAuthStore } from '@/store/system/auth';
import { useTable, useTableOperate, useTableScroll } from '@/hooks/table/use-table';
import { useAntdForm, useFormRules } from '@/hooks/form/use-antd-form';
import { $t } from '@/locales';

defineOptions({
  name: 'SystemUser'
});

const route = useRoute();
const authStore = useAuthStore();
const readonlyActionMessage = '演示账号仅允许查看，不能执行会修改后端数据的操作';
const isDemoAccount = computed(() => {
  const roleText = authStore.userInfo.roles.join(',').toLowerCase();
  const userText = `${authStore.userInfo.userName},${authStore.userInfo.displayName}`.toLowerCase();
  return /demo|演示/.test(roleText) || /demo|演示/.test(userText);
});

function warnReadonlyAction() {
  window.$message?.warning(readonlyActionMessage);
}

const isDetailPage = computed(() => route.name === 'system_user-detail');

const detailId = computed(() => route.params.id as string);

const { tableWrapperRef, scrollConfig } = useTableScroll(980);

const isDeletedOptions = [
  { label: '0 - 未删除', value: 0 },
  { label: '1 - 已删除', value: 1 }
];

const {
  columns,
  columnChecks,
  data,
  getData,
  getDataByPage,
  loading,
  mobilePagination,
  searchParams,
  resetSearchParams
} = useTable({
  apiFn: fetchGetUserList,
  apiParams: {
    current: 1,
    size: 10,
    userName: undefined,
    displayName: undefined,
    isDeleted: undefined
  },
  columns: () => [
    {
      key: 'index',
      title: $t('common.index'),
      dataIndex: 'index',
      align: 'center',
      width: 64
    },
    {
      key: 'id',
      dataIndex: 'id',
      title: 'ID',
      align: 'center',
      width: 180
    },
    {
      key: 'userName',
      dataIndex: 'userName',
      title: '用户名',
      align: 'center',
      minWidth: 140
    },
    {
      key: 'displayName',
      dataIndex: 'displayName',
      title: '显示名称',
      align: 'center',
      minWidth: 140
    },
    {
      key: 'isDeleted',
      dataIndex: 'isDeleted',
      title: '删除状态',
      align: 'center',
      width: 110,
      customRender: ({ record }) => {
        const isDeleted = record.isDeleted === 1;
        return <Tag color={isDeleted ? 'warning' : 'success'}>{record.isDeleted}</Tag>;
      }
    },
    {
      key: 'createTime',
      dataIndex: 'createTime',
      title: '创建时间',
      align: 'center',
      width: 180
    },
    {
      key: 'updateTime',
      dataIndex: 'updateTime',
      title: '更新时间',
      align: 'center',
      width: 180
    },
    {
      key: 'operate',
      title: $t('common.operate'),
      align: 'center',
      width: 130,
      customRender: ({ record }) => (
        <div class="flex items-center justify-center gap-[8px]">
          <Button type="primary" ghost size="small" onClick={() => edit(record.id)}>
            {$t('common.edit')}
          </Button>
          <Popconfirm title={$t('common.confirmDelete')} onConfirm={() => handleDelete(record.id)}>
            <Button danger size="small">
              {$t('common.delete')}
            </Button>
          </Popconfirm>
        </div>
      )
    }
  ]
});

const {
  drawerVisible,
  operateType,
  editingData,
  handleAdd,
  handleEdit,
  checkedRowKeys,
  rowSelection,
  onBatchDeleted,
  onDeleted
} = useTableOperate(data, getData);

async function handleBatchDelete() {
  if (isDemoAccount.value) {
    warnReadonlyAction();
    return;
  }

  onBatchDeleted();
}

function handleDelete(_id?: number) {
  if (isDemoAccount.value) {
    warnReadonlyAction();
    return;
  }

  onDeleted();
}

function edit(id: number) {
  handleEdit(id);
}

const { formRef: searchFormRef, validate: validateSearch, resetFields: resetSearchFields } = useAntdForm();

async function handleSearchReset() {
  await resetSearchFields();
  resetSearchParams();
}

async function handleSearch() {
  await validateSearch();
  getDataByPage();
}

const { formRef: drawerFormRef, validate: validateDrawer, resetFields: resetDrawerFields } = useAntdForm();
const { defaultRequiredRule } = useFormRules();

const drawerTitle = computed(() => {
  const titles: Record<AntDesign.TableOperateType, string> = {
    add: $t('page.manage.user.addUser'),
    edit: $t('page.manage.user.editUser')
  };
  return titles[operateType.value];
});

type DrawerModel = Pick<Api.SystemManage.User, 'userName' | 'displayName' | 'isDeleted'>;

const drawerModel = ref(createDefaultDrawerModel());

function createDefaultDrawerModel(): DrawerModel {
  return {
    userName: '',
    displayName: '',
    isDeleted: 0
  };
}

type DrawerRuleKey = Extract<keyof DrawerModel, 'userName' | 'isDeleted'>;

const drawerRules: Record<DrawerRuleKey, App.Global.FormRule> = {
  userName: defaultRequiredRule,
  isDeleted: defaultRequiredRule
};

function handleInitDrawerModel() {
  drawerModel.value = createDefaultDrawerModel();

  if (operateType.value === 'edit' && editingData.value) {
    Object.assign(drawerModel.value, editingData.value);
  }
}

function closeDrawer() {
  drawerVisible.value = false;
}

async function handleDrawerSubmit() {
  if (isDemoAccount.value) {
    warnReadonlyAction();
    return;
  }

  await validateDrawer();

  if (operateType.value === 'edit' && editingData.value) {
    const { error } = await fetchUpdateUser(editingData.value.id, drawerModel.value);
    if (error) return;
  }

  window.$message?.success($t('common.updateSuccess'));
  closeDrawer();
  getDataByPage();
}

watch(drawerVisible, () => {
  if (drawerVisible.value) {
    handleInitDrawerModel();
    resetDrawerFields();
  }
});
</script>

<style scoped lang="scss">
:deep(.search-action-col .ant-form-item-control-input) {
  min-height: 32px;
}

.search-action-group {
  min-height: 32px;
}

:deep(.search-action-btn) {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-height: 32px;
  padding-inline: 12px;
  flex-shrink: 0;
  white-space: nowrap;
}

:deep(.search-action-btn .ant-btn-icon),
:deep(.search-action-btn > span),
:deep(.search-action-btn .ant-btn-icon + span) {
  display: inline-flex;
  align-items: center;
  white-space: nowrap;
}
</style>
