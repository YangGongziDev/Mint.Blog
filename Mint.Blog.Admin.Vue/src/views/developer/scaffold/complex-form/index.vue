<template>
  <div class="page-container">
    <div class="card">
      <h2>{{ $t('developer.scaffold.complexForm.title') }}</h2>
      <p class="text-secondary mb-lg">
        {{ $t('developer.scaffold.complexForm.description') }}
      </p>

      <a-form ref="formRef" :model="formState" :rules="rules" layout="vertical">
        <ProStepForm
          ref="stepFormRef"
          v-model="currentStep"
          :steps="stepDefinitions"
          @next="nextStep"
          @submit="submitForm"
        >
          <template #step-0>
            <div class="grid-two">
              <a-form-item
                :label="$t('developer.scaffold.complexForm.projectNameLabel')"
                name="projectName"
              >
                <a-input
                  v-model:value="formState.projectName"
                  :placeholder="$t('developer.scaffold.complexForm.projectNamePlaceholder')"
                />
              </a-form-item>
              <a-form-item :label="$t('developer.scaffold.complexForm.ownerLabel')" name="owner">
                <a-input
                  v-model:value="formState.owner"
                  :placeholder="$t('developer.scaffold.complexForm.ownerPlaceholder')"
                />
              </a-form-item>
              <a-form-item :label="$t('developer.scaffold.complexForm.sceneLabel')" name="scene">
                <a-select
                  v-model:value="formState.scene"
                  :placeholder="$t('developer.scaffold.complexForm.scenePlaceholder')"
                  :options="sceneOptions"
                />
              </a-form-item>
              <a-form-item
                :label="$t('developer.scaffold.complexForm.descriptionLabel')"
                name="description"
              >
                <a-textarea
                  v-model:value="formState.description"
                  :rows="3"
                  :placeholder="$t('developer.scaffold.complexForm.descriptionPlaceholder')"
                />
              </a-form-item>
            </div>
          </template>

          <template #step-1>
            <div class="mb-md">
              <a-space>
                <a-button type="dashed" @click="addRule">{{
                  $t('developer.scaffold.complexForm.addRuleButton')
                }}</a-button>
                <a-tag>{{
                  $t('developer.scaffold.complexForm.currentRulesCount', {
                    count: formState.rules.length,
                  })
                }}</a-tag>
              </a-space>
            </div>

            <div v-for="(rule, index) in formState.rules" :key="rule.id" class="rule-row">
              <a-input
                v-model:value="rule.metric"
                :placeholder="$t('developer.scaffold.complexForm.metricPlaceholder')"
              />
              <a-select
                v-model:value="rule.operator"
                :options="operatorOptions"
                style="width: 120px"
              />
              <a-input-number
                v-model:value="rule.threshold"
                :min="0"
                :max="10000"
                style="width: 180px"
              />
              <a-button danger @click="removeRule(index)">{{
                $t('developer.scaffold.complexForm.deleteButton')
              }}</a-button>
            </div>

            <a-alert v-if="ruleError" class="mt-md" type="error" show-icon :message="ruleError" />
          </template>

          <template #step-2>
            <div class="grid-two">
              <a-form-item
                :label="$t('developer.scaffold.complexForm.publishTypeLabel')"
                name="publishType"
              >
                <a-radio-group v-model:value="formState.publishType">
                  <a-radio value="immediate">{{
                    $t('developer.scaffold.complexForm.publishImmediate')
                  }}</a-radio>
                  <a-radio value="schedule">{{
                    $t('developer.scaffold.complexForm.publishSchedule')
                  }}</a-radio>
                </a-radio-group>
              </a-form-item>

              <a-form-item
                :label="$t('developer.scaffold.complexForm.publishTimeLabel')"
                name="publishTime"
                :rules="[
                  {
                    validator: validatePublishTime,
                    trigger: 'change',
                  },
                ]"
              >
                <a-date-picker
                  v-model:value="formState.publishTime"
                  show-time
                  style="width: 100%"
                  :disabled="formState.publishType !== 'schedule'"
                />
              </a-form-item>

              <a-form-item
                :label="$t('developer.scaffold.complexForm.notifyUsersLabel')"
                name="notifyUsers"
                class="full-row"
              >
                <a-select
                  v-model:value="formState.notifyUsers"
                  mode="tags"
                  :token-separators="[',']"
                  :placeholder="$t('developer.scaffold.complexForm.notifyUsersPlaceholder')"
                />
              </a-form-item>
            </div>
          </template>

          <template #extra-actions>
            <a-button @click="saveDraft">{{
              $t('developer.scaffold.complexForm.saveDraftButton')
            }}</a-button>
            <a-button @click="resetForm">{{
              $t('developer.scaffold.complexForm.resetButton')
            }}</a-button>
          </template>
        </ProStepForm>
      </a-form>
    </div>
  </div>
</template>

<script setup lang="ts">
import type { ProStepFormStep } from '@/types/pro';
import type { Dayjs } from 'dayjs';

import { message } from 'antdv-next';
import { computed, onMounted, reactive, ref } from 'vue';

import ProStepForm from '@/components/Pro/ProStepForm/index.vue';
import { $t } from '@/locales';

interface PolicyRule {
  id: string;
  metric: string;
  operator: '>' | '>=' | '<' | '<=';
  threshold: number | null;
}

interface FormState {
  projectName: string;
  owner: string;
  scene: string;
  description: string;
  rules: PolicyRule[];
  publishType: 'immediate' | 'schedule';
  publishTime: Dayjs | null;
  notifyUsers: string[];
}

const DRAFT_KEY = 'example:complex-form:draft';

const formRef = ref<{
  validateFields: (fields?: string[]) => Promise<void>;
  clearValidate: () => void;
  setFields: (fields: { name: string[]; errors: string[] }[]) => void;
} | null>(null);
const currentStep = ref(0);
const ruleError = ref('');

const stepDefinitions = computed<ProStepFormStep[]>(() => [
  {
    title: $t('developer.scaffold.complexForm.step1Title'),
    description: $t('developer.scaffold.complexForm.step1Description'),
  },
  {
    title: $t('developer.scaffold.complexForm.step2Title'),
    description: $t('developer.scaffold.complexForm.step2Description'),
  },
  {
    title: $t('developer.scaffold.complexForm.step3Title'),
    description: $t('developer.scaffold.complexForm.step3Description'),
  },
]);

const formState = reactive<FormState>({
  projectName: '',
  owner: '',
  scene: '',
  description: '',
  rules: [
    {
      id: `${Date.now()}`,
      metric: 'error_rate',
      operator: '>',
      threshold: 5,
    },
  ],
  publishType: 'immediate',
  publishTime: null,
  notifyUsers: [],
});

const sceneOptions = computed(() => [
  { label: $t('developer.scaffold.complexForm.sceneGrowth'), value: 'growth' },
  { label: $t('developer.scaffold.complexForm.sceneRisk'), value: 'risk' },
  {
    label: $t('developer.scaffold.complexForm.sceneStability'),
    value: 'stability',
  },
]);

const operatorOptions = [
  { label: '>', value: '>' },
  { label: '>=', value: '>=' },
  { label: '<', value: '<' },
  { label: '<=', value: '<=' },
];

const checkProjectNameUnique = async (_rule: unknown, value: string) => {
  // 空值由 required 规则处理,这里只负责唯一性校验,避免重复提示
  if (!value) {
    return Promise.resolve();
  }

  await new Promise((resolve) => setTimeout(resolve, 300));

  const reservedNames = ['default', 'admin', 'production'];
  if (reservedNames.includes(value.trim().toLowerCase())) {
    return Promise.reject(new Error($t('developer.scaffold.complexForm.projectNameExists')));
  }

  return Promise.resolve();
};

const rules = computed(() => ({
  projectName: [
    {
      required: true,
      message: $t('developer.scaffold.complexForm.projectNameRequired'),
    },
    { validator: checkProjectNameUnique, trigger: 'blur' },
  ],
  owner: [
    {
      required: true,
      message: $t('developer.scaffold.complexForm.ownerRequired'),
    },
  ],
  scene: [
    {
      required: true,
      message: $t('developer.scaffold.complexForm.sceneRequired'),
    },
  ],
  publishType: [
    {
      required: true,
      message: $t('developer.scaffold.complexForm.publishTypeRequired'),
    },
  ],
}));

const validatePublishTime = async () => {
  if (formState.publishType === 'schedule' && !formState.publishTime) {
    return Promise.reject(new Error($t('developer.scaffold.complexForm.publishTimeRequired')));
  }
  return Promise.resolve();
};

const validateRuleList = () => {
  if (formState.rules.length === 0) {
    ruleError.value = $t('developer.scaffold.complexForm.ruleListEmpty');
    return false;
  }

  const invalid = formState.rules.some((item) => {
    return !item.metric || !item.operator || item.threshold == null;
  });

  if (invalid) {
    ruleError.value = $t('developer.scaffold.complexForm.ruleListIncomplete');
    return false;
  }

  ruleError.value = '';
  return true;
};

const addRule = () => {
  formState.rules.push({
    id: `${Date.now()}-${Math.random()}`,
    metric: '',
    operator: '>',
    threshold: null,
  });
};

const removeRule = (index: number) => {
  formState.rules.splice(index, 1);
};

const nextStep = async (step: number) => {
  if (step === 0) {
    await formRef.value?.validateFields?.(['projectName', 'owner', 'scene']);
  }

  if (step === 1 && !validateRuleList()) {
    return;
  }

  currentStep.value = step + 1;
};

const resetForm = () => {
  formState.projectName = '';
  formState.owner = '';
  formState.scene = '';
  formState.description = '';
  formState.rules = [{ id: `${Date.now()}`, metric: 'error_rate', operator: '>', threshold: 5 }];
  formState.publishType = 'immediate';
  formState.publishTime = null;
  formState.notifyUsers = [];
  currentStep.value = 0;
  ruleError.value = '';
  formRef.value?.clearValidate?.();
};

const saveDraft = () => {
  localStorage.setItem(DRAFT_KEY, JSON.stringify(formState));
  message.success($t('developer.scaffold.complexForm.draftSaved'));
};

const loadDraft = () => {
  const draft = localStorage.getItem(DRAFT_KEY);
  if (!draft) {
    return;
  }

  try {
    const parsed = JSON.parse(draft);
    Object.assign(formState, parsed);
  } catch {
    localStorage.removeItem(DRAFT_KEY);
  }
};

const submitForm = async () => {
  await formRef.value?.validateFields?.(['publishType', 'publishTime']);

  if (!validateRuleList()) {
    currentStep.value = 1;
    return;
  }

  // 模拟后端字段错误映射
  if (formState.projectName.toLowerCase().includes('fail')) {
    currentStep.value = 0;
    formRef.value?.setFields?.([
      {
        name: ['projectName'],
        errors: [$t('developer.scaffold.complexForm.serverValidationError')],
      },
    ]);
    message.error($t('developer.scaffold.complexForm.submitFailed'));
    return;
  }

  await new Promise((resolve) => setTimeout(resolve, 600));
  localStorage.removeItem(DRAFT_KEY);
  message.success($t('developer.scaffold.complexForm.submitSuccess'));
};

onMounted(() => {
  loadDraft();
});
</script>

<style scoped lang="scss">
.mb-lg {
  margin-bottom: var(--spacing-lg);
}

.mb-md {
  margin-bottom: var(--spacing-md);
}

.mt-md {
  margin-top: var(--spacing-md);
}

.grid-two {
  display: grid;
  gap: 12px;
  grid-template-columns: repeat(2, minmax(0, 1fr));
}

.full-row {
  grid-column: 1 / -1;
}

.rule-row {
  display: grid;
  gap: 8px;
  grid-template-columns: 1fr 120px 180px 80px;
  margin-bottom: 10px;
}

@media (max-width: 900px) {
  .grid-two {
    grid-template-columns: 1fr;
  }

  .rule-row {
    grid-template-columns: 1fr;
  }
}
</style>
