<template>
  <div class="page-container">
    <div class="card mb-lg">
      <h2>{{ $t('developer.scaffold.observability.title') }}</h2>
      <p class="text-secondary">
        {{ $t('developer.scaffold.observability.description') }}
      </p>

      <a-space wrap class="mt-sm">
        <a-button type="primary" @click="runScenario('success')">{{
          $t('developer.scaffold.observability.simulateSuccess')
        }}</a-button>
        <a-button @click="runScenario('empty')">{{
          $t('developer.scaffold.observability.simulateEmpty')
        }}</a-button>
        <a-button danger @click="runScenario('network')">{{
          $t('developer.scaffold.observability.simulateNetwork')
        }}</a-button>
        <a-button danger @click="runScenario('auth')">{{
          $t('developer.scaffold.observability.simulateAuth')
        }}</a-button>
        <a-button danger @click="runScenario('business')">{{
          $t('developer.scaffold.observability.simulateBusiness')
        }}</a-button>
      </a-space>
    </div>

    <div class="grid-two">
      <div class="card">
        <div class="section-title">
          {{ $t('developer.scaffold.observability.requestStateTitle') }}
        </div>

        <template v-if="state === 'loading'">
          <a-skeleton active :paragraph="{ rows: 5 }" />
        </template>

        <template v-else-if="state === 'empty'">
          <a-empty :description="$t('developer.scaffold.observability.emptyData')" />
        </template>

        <template v-else-if="state === 'error'">
          <a-result
            status="error"
            :title="$t('developer.scaffold.observability.requestFailed')"
            :sub-title="errorMessage"
          >
            <template #extra>
              <a-button type="primary" @click="retryLast">{{
                $t('developer.scaffold.observability.retryButton')
              }}</a-button>
            </template>
          </a-result>
        </template>

        <template v-else-if="state === 'success'">
          <a-list size="small" bordered :data-source="records">
            <template #renderItem="{ item }">
              <a-list-item>
                <strong>{{ item.name }}</strong>
                <span class="text-secondary">{{ item.value }}</span>
              </a-list-item>
            </template>
          </a-list>
        </template>

        <template v-else>
          <a-empty :description="$t('developer.scaffold.observability.clickToStart')" />
        </template>
      </div>

      <div class="card">
        <div class="section-title">
          {{ $t('developer.scaffold.observability.errorLogTitle') }}
        </div>

        <div class="error-stats">
          <div class="stat-item">
            <span>{{ $t('developer.scaffold.observability.networkError') }}</span>
            <strong>{{ errorStats.network }}</strong>
          </div>
          <div class="stat-item">
            <span>{{ $t('developer.scaffold.observability.authError') }}</span>
            <strong>{{ errorStats.auth }}</strong>
          </div>
          <div class="stat-item">
            <span>{{ $t('developer.scaffold.observability.businessError') }}</span>
            <strong>{{ errorStats.business }}</strong>
          </div>
        </div>

        <div class="event-list">
          <div v-if="events.length === 0" class="event-empty">
            {{ $t('developer.scaffold.observability.noEvents') }}
          </div>
          <div v-for="item in events" :key="item.id" class="event-item" :class="`is-${item.level}`">
            <span class="event-time">{{ item.time }}</span>
            <span class="event-text">{{ item.text }}</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { reactive, ref } from 'vue';

import { $t, getLocale } from '@/locales';

type Scenario = 'success' | 'empty' | 'network' | 'auth' | 'business';
type State = 'idle' | 'loading' | 'success' | 'empty' | 'error';

type LogLevel = 'info' | 'error' | 'success';

const state = ref<State>('idle');
const records = ref<Array<{ name: string; value: string }>>([]);
const errorMessage = ref('');
const lastScenario = ref<Scenario | null>(null);

const errorStats = reactive({
  network: 0,
  auth: 0,
  business: 0,
});

const events = ref<Array<{ id: number; time: string; text: string; level: LogLevel }>>([]);
let logId = 0;

const pushEvent = (text: string, level: LogLevel = 'info') => {
  events.value.unshift({
    id: ++logId,
    time: new Date().toLocaleTimeString(getLocale(), { hour12: false }),
    text,
    level,
  });

  if (events.value.length > 60) {
    events.value = events.value.slice(0, 60);
  }
};

const demoFetch = async (scenario: Scenario) => {
  await new Promise((resolve) => setTimeout(resolve, 700));

  switch (scenario) {
    case 'success':
      return {
        code: 200,
        data: [
          { name: 'service_a_latency', value: '120ms' },
          { name: 'service_b_qps', value: '2,398' },
          { name: 'error_rate', value: '0.35%' },
        ],
      };
    case 'empty':
      return {
        code: 200,
        data: [],
      };
    case 'network':
      throw new Error($t('developer.scaffold.observability.errorNetwork'));
    case 'auth':
      throw new Error($t('developer.scaffold.observability.errorAuth'));
    case 'business':
      throw new Error($t('developer.scaffold.observability.errorBusiness'));
    default:
      return {
        code: 200,
        data: [],
      };
  }
};

const classifyError = (message: string) => {
  const lower = message.toLowerCase();
  if (lower.includes('network')) {
    return 'network' as const;
  }
  if (lower.includes('auth') || lower.includes('token')) {
    return 'auth' as const;
  }
  return 'business' as const;
};

const runScenario = async (scenario: Scenario) => {
  lastScenario.value = scenario;
  state.value = 'loading';
  records.value = [];
  errorMessage.value = '';

  pushEvent($t('developer.scaffold.observability.eventStart', { scenario }));

  try {
    const result = await demoFetch(scenario);

    if (result.data.length === 0) {
      state.value = 'empty';
      pushEvent($t('developer.scaffold.observability.eventEmpty'));
      return;
    }

    state.value = 'success';
    records.value = result.data;
    pushEvent($t('developer.scaffold.observability.eventSuccess'), 'success');
  } catch (error: unknown) {
    state.value = 'error';
    errorMessage.value =
      (error as Error).message || $t('developer.scaffold.observability.unknownError');

    const type = classifyError(errorMessage.value);
    errorStats[type] += 1;

    pushEvent(
      $t('developer.scaffold.observability.eventError', {
        type,
        message: errorMessage.value,
      }),
      'error',
    );
  }
};

const retryLast = async () => {
  if (!lastScenario.value) {
    return;
  }
  await runScenario(lastScenario.value);
};
</script>

<style scoped lang="scss">
.mb-lg {
  margin-bottom: var(--spacing-lg);
}

.mt-sm {
  margin-top: var(--spacing-sm);
}

.grid-two {
  display: grid;
  gap: 14px;
  grid-template-columns: repeat(2, minmax(0, 1fr));
}

.section-title {
  font-weight: var(--font-weight-semibold);
  margin-bottom: 12px;
}

.error-stats {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 8px;
  margin-bottom: 12px;
}

.stat-item {
  border: 1px solid var(--color-border-secondary);
  border-radius: 8px;
  padding: 8px;
  display: flex;
  flex-direction: column;
  gap: 2px;

  span {
    color: var(--color-text-secondary);
    font-size: 12px;
  }
}

.event-list {
  border: 1px solid var(--color-border-secondary);
  border-radius: 8px;
  max-height: 310px;
  overflow-y: auto;
}

.event-empty {
  text-align: center;
  color: var(--color-text-tertiary);
  padding: 20px;
}

.event-item {
  display: grid;
  grid-template-columns: 92px 1fr;
  gap: 8px;
  padding: 8px 10px;
  border-bottom: 1px solid var(--color-border-secondary);

  &:last-child {
    border-bottom: none;
  }

  &.is-success .event-text {
    color: var(--color-success);
  }

  &.is-error .event-text {
    color: var(--color-error);
  }
}

.event-time {
  color: var(--color-text-tertiary);
  font-family: var(--font-family-code);
}

@media (max-width: 960px) {
  .grid-two {
    grid-template-columns: 1fr;
  }
}
</style>
