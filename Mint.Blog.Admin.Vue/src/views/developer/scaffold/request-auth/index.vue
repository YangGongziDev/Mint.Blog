<template>
  <div class="page-container">
    <div class="card">
      <h2>{{ $t('developer.scaffold.requestAuth.title') }}</h2>
      <p class="mb-lg text-secondary">
        {{ $t('developer.scaffold.requestAuth.description') }}
      </p>

      <a-alert
        v-if="reloginRequired"
        type="error"
        show-icon
        class="mb-lg"
        :message="$t('developer.scaffold.requestAuth.refreshFailedAlert')"
        :description="$t('developer.scaffold.requestAuth.refreshFailedDesc')"
      />

      <div class="status-grid mb-lg">
        <div class="status-item">
          <span class="label">{{ $t('developer.scaffold.requestAuth.accessToken') }}</span>
          <code>{{ accessToken || $t('developer.scaffold.requestAuth.empty') }}</code>
        </div>
        <div class="status-item">
          <span class="label">{{ $t('developer.scaffold.requestAuth.refreshToken') }}</span>
          <code>{{ refreshToken || $t('developer.scaffold.requestAuth.empty') }}</code>
        </div>
        <div class="status-item">
          <span class="label">{{ $t('developer.scaffold.requestAuth.refreshStatus') }}</span>
          <a-tag :color="refreshing ? 'processing' : 'default'">
            {{
              refreshing
                ? $t('developer.scaffold.requestAuth.refreshing')
                : $t('developer.scaffold.requestAuth.idle')
            }}
          </a-tag>
        </div>
      </div>

      <a-space wrap :size="10" class="mb-lg">
        <a-button type="primary" @click="handleSingleRequest">{{
          $t('developer.scaffold.requestAuth.singleRequest')
        }}</a-button>
        <a-button @click="handleConcurrentRequest">{{
          $t('developer.scaffold.requestAuth.concurrentRequest')
        }}</a-button>
        <a-button @click="expireAccessToken">{{
          $t('developer.scaffold.requestAuth.expireToken')
        }}</a-button>
        <a-button danger @click="handleRefreshFailScenario">{{
          $t('developer.scaffold.requestAuth.simulateRefreshFail')
        }}</a-button>
        <a-button @click="resetSession">{{
          $t('developer.scaffold.requestAuth.resetSession')
        }}</a-button>
      </a-space>

      <div class="log-toolbar">
        <span class="text-secondary">{{ $t('developer.scaffold.requestAuth.logTitle') }}</span>
        <a-button size="small" @click="logs = []">{{
          $t('developer.scaffold.requestAuth.clearLog')
        }}</a-button>
      </div>

      <div class="log-list">
        <div v-if="logs.length === 0" class="log-empty">
          {{ $t('developer.scaffold.requestAuth.noLogs') }}
        </div>
        <div v-for="item in logs" :key="item.id" class="log-item" :class="`is-${item.level}`">
          <span class="log-time">{{ item.time }}</span>
          <span class="log-text">{{ item.text }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { message } from 'antdv-next';
import { ref } from 'vue';

import { $t, getLocale } from '@/locales';

type LogLevel = 'info' | 'success' | 'error';

type RequestError = {
  status: number;
  message: string;
};

type SessionState = {
  accessToken: string;
  refreshToken: string;
};

const logs = ref<Array<{ id: number; time: string; level: LogLevel; text: string }>>([]);
const accessToken = ref('expired-token');
const refreshToken = ref('refresh-token-demo');
const refreshing = ref(false);
const reloginRequired = ref(false);

let failNextRefresh = false;
let logId = 0;
let refreshPromise: Promise<string> | null = null;

const now = () => new Date().toLocaleTimeString(getLocale(), { hour12: false });

const pushLog = (text: string, level: LogLevel = 'info') => {
  logs.value.unshift({
    id: ++logId,
    time: now(),
    level,
    text,
  });

  if (logs.value.length > 80) {
    logs.value = logs.value.slice(0, 80);
  }
};

const delay = (ms: number) => new Promise((resolve) => setTimeout(resolve, ms));

const demoProtectedApi = async (apiName: string) => {
  await delay(280 + Math.round(Math.random() * 320));

  if (!accessToken.value || accessToken.value.startsWith('expired')) {
    throw {
      status: 401,
      message: $t('developer.scaffold.requestAuth.tokenExpired', { apiName }),
    } as RequestError;
  }

  return {
    code: 200,
    message: $t('developer.scaffold.requestAuth.apiSuccess', { apiName }),
  };
};

const demoRefreshApi = async () => {
  await delay(700);

  if (!refreshToken.value || failNextRefresh) {
    failNextRefresh = false;
    throw {
      status: 401,
      message: $t('developer.scaffold.requestAuth.refreshTokenInvalid'),
    } as RequestError;
  }

  const nextToken = `valid-token-${Date.now()}`;
  return {
    code: 200,
    data: {
      token: nextToken,
      refreshToken: refreshToken.value,
    },
  };
};

const ensureTokenRefreshed = async () => {
  if (!refreshPromise) {
    refreshPromise = (async () => {
      try {
        refreshing.value = true;
        pushLog($t('developer.scaffold.requestAuth.logRefreshStart'));
        const result = await demoRefreshApi();
        accessToken.value = result.data.token;
        reloginRequired.value = false;
        pushLog($t('developer.scaffold.requestAuth.logRefreshSuccess'), 'success');
        return result.data.token;
      } catch (error: unknown) {
        accessToken.value = '';
        reloginRequired.value = true;
        pushLog(
          $t('developer.scaffold.requestAuth.logRefreshFailed', {
            message: (error as Error).message,
          }),
          'error',
        );
        throw error;
      } finally {
        refreshing.value = false;
        refreshPromise = null;
      }
    })();
  } else {
    pushLog($t('developer.scaffold.requestAuth.logQueueWait'));
  }

  return refreshPromise;
};

const requestWithAutoRefresh = async (apiName: string) => {
  try {
    const result = await demoProtectedApi(apiName);
    pushLog(result.message, 'success');
    return result;
  } catch (error: unknown) {
    const httpError = error as { status?: number; message?: string };
    if (httpError.status !== 401) {
      pushLog(
        $t('developer.scaffold.requestAuth.logNon401Error', {
          apiName,
          message: httpError.message,
        }),
        'error',
      );
      throw error;
    }

    pushLog($t('developer.scaffold.requestAuth.log401Detected', { apiName }), 'info');

    await ensureTokenRefreshed();

    const retried = await demoProtectedApi(`${apiName}-retry`);
    pushLog(retried.message, 'success');
    return retried;
  }
};

const expireAccessToken = () => {
  accessToken.value = 'expired-token';
  pushLog($t('developer.scaffold.requestAuth.logTokenExpired'));
};

const resetSession = () => {
  const session: SessionState = {
    accessToken: 'expired-token',
    refreshToken: 'refresh-token-demo',
  };

  accessToken.value = session.accessToken;
  refreshToken.value = session.refreshToken;
  reloginRequired.value = false;
  failNextRefresh = false;
  pushLog($t('developer.scaffold.requestAuth.logSessionReset'));
};

const handleSingleRequest = async () => {
  try {
    await requestWithAutoRefresh('single');
  } catch {
    message.error($t('developer.scaffold.requestAuth.singleRequestFailed'));
  }
};

const handleConcurrentRequest = async () => {
  pushLog($t('developer.scaffold.requestAuth.logConcurrentStart'));

  const results = await Promise.allSettled(
    Array.from({ length: 5 }, (_, index) => requestWithAutoRefresh(`parallel-${index + 1}`)),
  );

  const failedCount = results.filter((item) => item.status === 'rejected').length;
  if (failedCount > 0) {
    message.warning(
      $t('developer.scaffold.requestAuth.concurrentPartialFail', {
        count: failedCount,
      }),
    );
  } else {
    message.success($t('developer.scaffold.requestAuth.concurrentAllSuccess'));
  }
};

const handleRefreshFailScenario = async () => {
  expireAccessToken();
  failNextRefresh = true;
  pushLog($t('developer.scaffold.requestAuth.logRefreshWillFail'));

  try {
    await requestWithAutoRefresh('refresh-fail-case');
  } catch {
    message.error($t('developer.scaffold.requestAuth.refreshFailTriggered'));
  }
};
</script>

<style scoped lang="scss">
.mb-lg {
  margin-bottom: var(--spacing-lg);
}

.status-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 10px;
}

.status-item {
  display: flex;
  flex-direction: column;
  gap: 6px;
  border: 1px solid var(--color-border-secondary);
  border-radius: 10px;
  padding: 10px 12px;

  .label {
    font-size: 12px;
    color: var(--color-text-secondary);
  }

  code {
    display: block;
    font-family: var(--font-family-code);
    word-break: break-all;
  }
}

.log-toolbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 8px;
}

.log-list {
  border: 1px solid var(--color-border-secondary);
  border-radius: 10px;
  overflow: hidden;
  max-height: 340px;
  overflow-y: auto;
}

.log-empty {
  padding: 18px;
  text-align: center;
  color: var(--color-text-tertiary);
}

.log-item {
  display: grid;
  grid-template-columns: 90px 1fr;
  gap: 10px;
  padding: 8px 12px;
  border-bottom: 1px solid var(--color-border-secondary);
  font-size: 13px;

  &:last-child {
    border-bottom: none;
  }

  &.is-success .log-text {
    color: var(--color-success);
  }

  &.is-error .log-text {
    color: var(--color-error);
  }
}

.log-time {
  color: var(--color-text-tertiary);
  font-family: var(--font-family-code);
}
</style>
