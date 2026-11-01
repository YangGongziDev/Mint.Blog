<template>
  <div class="p-4">
    <ACard :bordered="false">
      <ASpace wrap><ASelect v-model:value="selectedId" :options="tagOptions" show-search option-filter-prop="label" placeholder="请选择标签" style="width: 280px" :disabled="saving" /><AButton :loading="loading" @click="loadVersions">刷新</AButton><AButton type="primary" :disabled="!canWrite || saving || loading || failed || !selectedId" @click="openVersion()">新增版本</AButton></ASpace>
      <AAlert v-if="failed" type="error" message="加载失败，请刷新重试" class="my-4" />
      <ATable class="mt-4" :columns="columns" :data-source="versions" row-key="id" :loading="loading" :pagination="false" :scroll="{ x: 800 }">
        <template #bodyCell="{ column, record }">
          <template v-if="column.key === 'general'"><ATag>{{ record.isGeneral ? '通用版本' : '普通版本' }}</ATag></template>
          <template v-else-if="column.key === 'action'"><ASpace><AButton :disabled="!canWrite || saving || loading || failed" @click="openVersion(record as TagVersion)">编辑</AButton><AButton danger :disabled="!canWrite || saving || loading || failed || record.isGeneral" @click="confirmDelete(record as TagVersion)">删除</AButton></ASpace></template>
        </template>
      </ATable>
    </ACard>
    <AModal :open="visible" :title="editing ? '编辑版本' : '新增版本'" :confirm-loading="saving" :mask-closable="false" :ok-button-props="{ disabled: !canWrite || saving }" @cancel="!saving && (visible = false)" @ok="save">
      <AForm ref="formRef" :model="form" layout="vertical" :disabled="saving">
        <AFormItem label="所属标签" name="tagId" :rules="[{ required: true, message: '请选择标签' }]"><ASelect v-model:value="form.tagId" :options="tagOptions" :disabled="editing?.isGeneral" /></AFormItem>
        <AAlert v-if="editing?.isGeneral" message="通用版本由系统创建，不能删除、迁移或修改通用标记。" class="mb-4" />
        <AFormItem label="版本名称" name="name" :rules="[{ required: true, whitespace: true, max: 60, message: '请输入不超过60字符的名称' }]"><AInput v-model:value="form.name" :maxlength="60" /></AFormItem>
        <AFormItem label="排序（有符号64位整数）" name="sort" :rules="sortRules"><AInput v-model:value="form.sort" /></AFormItem>
      </AForm>
      <p>普通版本被正式文章、草稿或资源引用时不能迁移或删除，引用检查包括软删除内容。</p>
    </AModal>
  </div>
</template>

<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, reactive, ref, watch } from 'vue';
import { message, Modal, type FormInstance, type FormProps, type TableColumnsType } from 'ant-design-vue';
import { createTagVersion, deleteTagVersion, getNavigationTags, getTagVersions, updateTagVersion, type NavigationTag, type TagVersion } from '@/api/blog/resource';
import { useAuth } from '@/hooks/auth/use-auth';
import { useAuthStore } from '@/store/system/auth';
import { sortOptionsByLabel } from '@/utils/common';

defineOptions({ name: 'BlogTagVersionManage' });
const { isReadonly } = useAuth();
const auth = useAuthStore();
const canWrite = computed(() => !isReadonly.value && auth.userInfo.roles.some(role => ['ROLE_ADMIN', 'ROLE_SUPER'].includes(role)));
const tags = ref<NavigationTag[]>([]);
const selectedId = ref<string>();
const tagOptions = computed(() => sortOptionsByLabel(tags.value.map(tag => ({ value: tag.id, label: tag.name })), option => option.label));
const versions = ref<TagVersion[]>([]);
const loading = ref(false);
const failed = ref(false);
const saving = ref(false);
const visible = ref(false);
const editing = ref<TagVersion>();
const formRef = ref<FormInstance>();
const form = reactive({ tagId: '', name: '', sort: '0' });
let request = 0;
let disposed = false;
const columns: TableColumnsType<TagVersion> = [
  { title: '名称', dataIndex: 'name' }, { title: '类型', key: 'general' },
  { title: '排序', dataIndex: 'sort' }, { title: '文章数', dataIndex: 'articleCount' },
  { title: '资源数', dataIndex: 'resourceCount' }, { title: '操作', key: 'action' }
];
const sortRules: NonNullable<FormProps['rules']>[string] = [{ required: true, validator: async (_rule, value: string) => {
  if (!/^-?\d+$/.test(value) || BigInt(value) < -9223372036854775808n || BigInt(value) > 9223372036854775807n) throw new Error('请输入有符号64位整数');
} }];
async function loadVersions() {
  const generation = ++request;
  const tagId = selectedId.value;
  versions.value = [];
  failed.value = false;
  loading.value = true;
  try {
    const result = await getNavigationTags();
    if (disposed || generation !== request) return;
    if (!result.success) throw new Error();
    tags.value = result.data;
    if (!tagId || !tags.value.some(tag => tag.id === tagId)) {
      selectedId.value = tags.value[0]?.id;
      return;
    }
    const response = await getTagVersions(tagId);
    if (disposed || generation !== request || selectedId.value !== tagId) return;
    if (!response.success) throw new Error();
    versions.value = response.data;
  } catch { if (!disposed && generation === request) failed.value = true; }
  finally { if (!disposed && generation === request) loading.value = false; }
}
function openVersion(version?: TagVersion) {
  if (!canWrite.value || saving.value || loading.value || failed.value || !selectedId.value) return;
  editing.value = version;
  Object.assign(form, { tagId: version?.tagId ?? selectedId.value, name: version?.name ?? '', sort: version?.sort ?? '0' });
  visible.value = true;
  formRef.value?.clearValidate();
}
async function save() {
  if (!canWrite.value || saving.value) return;
  saving.value = true;
  try {
    await formRef.value?.validate();
    if (!tags.value.some(tag => tag.id === form.tagId)) return;
    if (editing.value?.isGeneral && form.tagId !== editing.value.tagId) return;
    const data = { name: form.name.trim(), sort: form.sort };
    const result = editing.value
      ? await updateTagVersion(editing.value.tagId, editing.value.id, { ...data, tagId: form.tagId })
      : await createTagVersion(form.tagId, data);
    if (!result.success || disposed) return;
    visible.value = false;
    message.success('版本已保存');
    await loadVersions();
  } catch { /* 请求或校验失败时保留输入。 */ }
  finally { saving.value = false; }
}
function confirmDelete(version: TagVersion) {
  if (!canWrite.value || saving.value || version.isGeneral) return;
  Modal.confirm({ title: `删除“${version.name}”？`, content: '被正式文章、草稿或资源引用（包括软删除内容）的版本不能删除。', async onOk() {
    if (disposed || saving.value || !canWrite.value) return;
    saving.value = true;
    try {
      const result = await deleteTagVersion(version.tagId, version.id);
      if (!result.success) throw new Error('删除失败');
      if (!disposed) { message.success('删除成功'); await loadVersions(); }
    } finally { saving.value = false; }
  } });
}
watch(selectedId, () => { visible.value = false; void loadVersions(); });
onMounted(loadVersions);
onBeforeUnmount(() => { disposed = true; ++request; });
</script>
