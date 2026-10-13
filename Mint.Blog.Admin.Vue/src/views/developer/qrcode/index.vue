<template>
  <div class="page-container">
    <div class="card">
      <h2>{{ $t('exampleQRCode.title') }}</h2>
      <p class="mb-lg">{{ $t('exampleQRCode.description') }}</p>

      <a-tabs v-model:activeKey="activeTab">
        <a-tab-pane key="basic" :tab="$t('exampleQRCode.basicTab')">
          <div class="qrcode-section">
            <a-form layout="vertical" :style="{ maxWidth: '400px' }">
              <a-form-item :label="$t('exampleQRCode.content')">
                <a-input v-model:value="basicContent" />
              </a-form-item>
              <a-form-item :label="$t('exampleQRCode.size')">
                <a-input-number v-model:value="basicSize" :min="100" :max="400" :step="20" />
              </a-form-item>
            </a-form>
            <div class="qrcode-preview">
              <a-qrcode :value="basicContent" :size="basicSize" />
            </div>
          </div>
        </a-tab-pane>

        <a-tab-pane key="style" :tab="$t('exampleQRCode.styleTab')">
          <div class="qrcode-section">
            <a-form layout="vertical" :style="{ maxWidth: '400px' }">
              <a-form-item :label="$t('exampleQRCode.bgColor')">
                <input type="color" v-model="styleBgColor" />
              </a-form-item>
              <a-form-item :label="$t('exampleQRCode.fgColor')">
                <input type="color" v-model="styleFgColor" />
              </a-form-item>
              <a-form-item :label="$t('exampleQRCode.errorLevel')">
                <a-select v-model:value="styleErrorLevel" style="width: 150px">
                  <a-select-option value="L">L (7%)</a-select-option>
                  <a-select-option value="M">M (15%)</a-select-option>
                  <a-select-option value="Q">Q (25%)</a-select-option>
                  <a-select-option value="H">H (30%)</a-select-option>
                </a-select>
              </a-form-item>
            </a-form>
            <div class="qrcode-preview">
              <a-qrcode
                value="https://www.antdv-next.com"
                :size="200"
                :bg-color="styleBgColor"
                :fg-color="styleFgColor"
                :error-level="styleErrorLevel"
              />
            </div>
          </div>
        </a-tab-pane>

        <a-tab-pane key="logo" :tab="$t('exampleQRCode.logoTab')">
          <div class="qrcode-section">
            <p class="hint">{{ $t('exampleQRCode.logoHint') }}</p>
            <div class="qrcode-preview">
              <a-qrcode value="https://www.antdv-next.com" :size="280" :error-level="'H'">
                <template #icon>
                  <img
                    src="https://www.antdv-next.com/antdv-next.svg"
                    alt="logo"
                    style="width: 40px; height: 40px"
                  />
                </template>
              </a-qrcode>
            </div>
          </div>
        </a-tab-pane>

        <a-tab-pane key="status" :tab="$t('exampleQRCode.statusTab')">
          <div class="qrcode-section">
            <a-space :size="24">
              <div class="status-item">
                <a-qrcode value="https://www.antdv-next.com" status="active" />
                <span class="status-label">{{ $t('exampleQRCode.statusActive') }}</span>
              </div>
              <div class="status-item">
                <a-qrcode value="https://www.antdv-next.com" status="expired" />
                <span class="status-label">{{ $t('exampleQRCode.statusExpired') }}</span>
              </div>
              <div class="status-item">
                <a-qrcode value="https://www.antdv-next.com" status="loading" />
                <span class="status-label">{{ $t('exampleQRCode.statusLoading') }}</span>
              </div>
            </a-space>
          </div>
        </a-tab-pane>

        <a-tab-pane key="download" :tab="$t('exampleQRCode.downloadTab')">
          <div class="qrcode-section">
            <a-form layout="vertical" :style="{ maxWidth: '400px' }">
              <a-form-item :label="$t('exampleQRCode.downloadContent')">
                <a-input v-model:value="downloadContent" />
              </a-form-item>
              <a-form-item :label="$t('exampleQRCode.fileName')">
                <a-input v-model:value="downloadFileName" />
              </a-form-item>
            </a-form>
            <div class="qrcode-preview">
              <a-qrcode ref="downloadQRRef" :value="downloadContent" :size="200" />
              <a-button type="primary" style="margin-top: 16px" @click="handleDownload">
                <DownloadOutlined /> {{ $t('exampleQRCode.downloadButton') }}
              </a-button>
            </div>
          </div>
        </a-tab-pane>
      </a-tabs>
    </div>
  </div>
</template>

<script setup lang="ts">
import type { QRCodeProps } from 'antdv-next';

import { DownloadOutlined } from '@antdv-next/icons';
import { message } from 'antdv-next';
import { ref } from 'vue';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

const activeTab = ref('basic');
const basicContent = ref('https://www.antdv-next.com');
const basicSize = ref(200);

const styleBgColor = ref('#ffffff');
const styleFgColor = ref('#000000');
const styleErrorLevel = ref<QRCodeProps['errorLevel']>('M');

const downloadContent = ref('https://www.antdv-next.com');
const downloadFileName = ref('antdv-next-qrcode');

const downloadQRRef = ref();

const handleDownload = () => {
  const canvas = downloadQRRef.value?.$el?.querySelector('canvas');
  if (canvas) {
    const url = canvas.toDataURL('image/png');
    const link = document.createElement('a');
    link.href = url;
    link.download = `${downloadFileName.value}.png`;
    link.click();
    message.success(t('exampleQRCode.downloadSuccess'));
  }
};
</script>

<style scoped lang="scss">
.mb-lg {
  margin-bottom: var(--spacing-lg);
}

.qrcode-section {
  display: flex;
  gap: 32px;
  align-items: flex-start;
  padding: 16px 0;
}

.qrcode-preview {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.hint {
  color: var(--color-text-secondary);
  font-size: 14px;
  margin-bottom: 16px;
}

.status-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
}

.status-label {
  font-size: 14px;
  color: var(--color-text-secondary);
}

input[type='color'] {
  width: 60px;
  height: 32px;
  padding: 0;
  border: 1px solid var(--color-border);
  border-radius: 4px;
  cursor: pointer;
}
</style>
