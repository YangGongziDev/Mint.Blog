<template>
  <div class="min-h-[500px] flex flex-col gap-[16px] overflow-hidden max-sm:overflow-auto">
    <ACard :title="$t('common.search')" :bordered="false" class="card-wrapper">
      <AForm ref="searchFormRef" :model="searchParams" :label-col="{ span: 6, md: 8 }">
        <ARow :gutter="[16, 16]" wrap>
          <ACol :span="24" :md="12" :lg="6">
            <AFormItem label="username" name="userName" class="m-0">
              <AInput v-model:value="searchParams.userName" placeholder="请输入 username" />
            </AFormItem>
          </ACol>
          <ACol :span="24" :md="12" :lg="6">
            <AFormItem label="role" name="role" class="m-0">
              <AInput v-model:value="searchParams.role" placeholder="请输入 role" />
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
      title="sys_user_role"
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
        :row-selection="rowSelection"
        :loading="loading"
        row-key="id"
        size="small"
        :pagination="mobilePagination"
        :scroll="scrollConfig"
        class="h-full"
      />
    </ACard>

    <ADrawer v-model:open="drawerVisible" :title="drawerTitle" :width="360">
      <AForm ref="drawerFormRef" layout="vertical" :model="drawerModel" :rules="drawerRules">
        <AFormItem label="username" name="userName">
          <AInput v-model:value="drawerModel.userName" placeholder="请输入 username" />
        </AFormItem>
        <AFormItem label="role" name="role">
          <AInput v-model:value="drawerModel.role" placeholder="请输入 role" />
        </AFormItem>
      </AForm>
      <template #footer>
        <div class="flex items-center justify-end gap-[12px]">
          <AButton @click="closeDrawer">{{ $t('common.cancel') }}</AButton>
          <AButton type="primary" @click="handleDrawerSubmit">{{ $t('common.confirm') }}</AButton>
        </div>
      </template>
    </ADrawer>
  </div>
</template>

<script setup lang="tsx">
import { computed, ref, watch } from 'vue';
import { Button, Popconfirm } from 'ant-design-vue';
import { fetchGetRoleList, fetchUpdateUserRole } from '@/service/system/role';
import { useTable, useTableOperate, useTableScroll } from '@/hooks/table/use-table';
import { useAntdForm, useFormRules } from '@/hooks/form/use-antd-form';
import { $t } from '@/locales';

defineOptions({
  name: 'SystemRole'
});

const { tableWrapperRef, scrollConfig } = useTableScroll(780);

const {
  columns,
  columnChecks,
  data,
  loading,
  getData,
  getDataByPage,
  mobilePagination,
  searchParams,
  resetSearchParams
} = useTable({
  apiFn: fetchGetRoleList,
  apiParams: {
    current: 1,
    size: 10,
    userName: undefined,
    role: undefined
  },
  columns: () => [
    {
      key: 'index',
      dataIndex: 'index',
      title: $t('common.index'),
      width: 64,
      align: 'center'
    },
    {
      key: 'id',
      dataIndex: 'id',
      title: 'id',
      align: 'center',
      width: 180
    },
    {
      key: 'userName',
      dataIndex: 'userName',
      title: 'username',
      align: 'center',
      minWidth: 160
    },
    {
      key: 'role',
      dataIndex: 'role',
      title: 'role',
      align: 'center',
      minWidth: 160
    },
    {
      key: 'createTime',
      dataIndex: 'createTime',
      title: 'create_time',
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
          <Popconfirm onConfirm={() => handleDelete(record.id)} title={$t('common.confirmDelete')}>
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
  onBatchDeleted();
}

function handleDelete(id: number) {
  console.log(id);
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
    add: $t('page.manage.role.addRole'),
    edit: $t('page.manage.role.editRole')
  };
  return titles[operateType.value];
});

type DrawerModel = Pick<Api.SystemManage.Role, 'userName' | 'role'>;

const drawerModel = ref(createDefaultDrawerModel());

function createDefaultDrawerModel(): DrawerModel {
  return {
    userName: '',
    role: ''
  };
}

const drawerRules: Record<keyof DrawerModel, App.Global.FormRule> = {
  userName: defaultRequiredRule,
  role: defaultRequiredRule
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
  await validateDrawer();

  if (operateType.value === 'edit' && editingData.value) {
    const { error } = await fetchUpdateUserRole(editingData.value.id, drawerModel.value);
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
