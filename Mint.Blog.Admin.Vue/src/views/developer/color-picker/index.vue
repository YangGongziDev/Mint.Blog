<template>
  <div class="page-container">
    <div class="card">
      <h2>{{ $t('exampleColorPicker.title') }}</h2>
      <p class="mb-lg">{{ $t('exampleColorPicker.description') }}</p>

      <a-tabs v-model:activeKey="activeTab">
        <a-tab-pane key="basic" :tab="$t('exampleColorPicker.basicTab')">
          <div class="demo-section">
            <h4>{{ $t('exampleColorPicker.basicUsage') }}</h4>
            <a-space :size="16">
              <a-color-picker v-model:value="basicColor" />
              <span class="color-value">{{ basicColor }}</span>
            </a-space>
          </div>

          <div class="demo-section">
            <h4>{{ $t('exampleColorPicker.sizes') }}</h4>
            <a-space :size="16">
              <div class="size-item">
                <span>small:</span>
                <a-color-picker v-model:value="sizeColor" size="small" />
              </div>
              <div class="size-item">
                <span>default:</span>
                <a-color-picker v-model:value="sizeColor" />
              </div>
              <div class="size-item">
                <span>large:</span>
                <a-color-picker v-model:value="sizeColor" size="large" />
              </div>
            </a-space>
          </div>
        </a-tab-pane>

        <a-tab-pane key="preset" :tab="$t('exampleColorPicker.presetTab')">
          <div class="demo-section">
            <h4>{{ $t('exampleColorPicker.presetColors') }}</h4>
            <a-color-picker v-model:value="presetColor" :presets="presetColors" />
            <p class="value-preview">
              {{ $t('exampleColorPicker.currentColor') }}: {{ presetColor }}
            </p>
          </div>
        </a-tab-pane>

        <a-tab-pane key="format" :tab="$t('exampleColorPicker.formatTab')">
          <div class="demo-section">
            <h4>{{ $t('exampleColorPicker.formatSupport') }}</h4>
            <a-space direction="vertical" :size="16">
              <div class="format-item">
                <span>HEX:</span>
                <a-color-picker v-model:value="hexColor" format="hex" />
                <span class="color-value">{{ hexColor }}</span>
              </div>
              <div class="format-item">
                <span>RGB:</span>
                <a-color-picker v-model:value="rgbColor" format="rgb" />
                <span class="color-value">{{ rgbColor }}</span>
              </div>
              <div class="format-item">
                <span>HSL:</span>
                <a-color-picker v-model:value="hslColor" format="hsl" />
                <span class="color-value">{{ hslColor }}</span>
              </div>
            </a-space>
          </div>
        </a-tab-pane>

        <a-tab-pane key="alpha" :tab="$t('exampleColorPicker.alphaTab')">
          <div class="demo-section">
            <h4>{{ $t('exampleColorPicker.withAlpha') }}</h4>
            <a-color-picker v-model:value="alphaColor" show-alpha />
            <p class="value-preview">
              {{ $t('exampleColorPicker.currentColor') }}: {{ alphaColor }}
            </p>
          </div>

          <div class="demo-section">
            <h4>{{ $t('exampleColorPicker.withoutAlpha') }}</h4>
            <a-color-picker v-model:value="noAlphaColor" />
            <p class="value-preview">
              {{ $t('exampleColorPicker.currentColor') }}: {{ noAlphaColor }}
            </p>
          </div>
        </a-tab-pane>

        <a-tab-pane key="disabled" :tab="$t('exampleColorPicker.disabledTab')">
          <div class="demo-section">
            <h4>{{ $t('exampleColorPicker.disabledState') }}</h4>
            <a-space :size="16">
              <a-color-picker v-model:value="disabledColor" disabled />
              <span class="color-value">{{ $t('exampleColorPicker.disabledHint') }}</span>
            </a-space>
          </div>
        </a-tab-pane>

        <a-tab-pane key="business" :tab="$t('exampleColorPicker.businessTab')">
          <div class="demo-section">
            <h4>{{ $t('exampleColorPicker.themeColor') }}</h4>
            <div class="theme-picker">
              <div class="theme-colors">
                <div
                  v-for="color in themeColors"
                  :key="color.value"
                  class="theme-color-item"
                  :class="{ active: selectedTheme === color.value }"
                  :style="{ backgroundColor: color.value }"
                  @click="selectedTheme = color.value"
                >
                  <CheckOutlined v-if="selectedTheme === color.value" />
                </div>
              </div>
              <a-color-picker v-model:value="customTheme" class="custom-picker" />
            </div>
          </div>

          <div class="demo-section">
            <h4>{{ $t('exampleColorPicker.tagColors') }}</h4>
            <div class="tag-demo">
              <a-tag v-for="tag in tags" :key="tag.label" :color="tag.color">
                {{ tag.label }}
              </a-tag>
              <a-button size="small" @click="showTagModal = true">
                <PlusOutlined /> {{ $t('exampleColorPicker.addTag') }}
              </a-button>
            </div>
          </div>
        </a-tab-pane>
      </a-tabs>
    </div>

    <a-modal
      v-model:open="showTagModal"
      :title="$t('exampleColorPicker.addTag')"
      @ok="handleAddTag"
    >
      <a-form layout="vertical">
        <a-form-item :label="$t('exampleColorPicker.tagName')">
          <a-input v-model:value="newTag.label" />
        </a-form-item>
        <a-form-item :label="$t('exampleColorPicker.tagColor')">
          <a-color-picker v-model:value="newTag.color" show-alpha />
        </a-form-item>
      </a-form>
    </a-modal>
  </div>
</template>

<script setup lang="ts">
import { CheckOutlined, PlusOutlined } from '@antdv-next/icons';
import { message } from 'antdv-next';
import { reactive, ref } from 'vue';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

const activeTab = ref('basic');
const basicColor = ref('#1677ff');
const sizeColor = ref('#1677ff');

const presetColor = ref('#1677ff');
const presetColors = [
  {
    label: 'Recommended',
    colors: [
      '#1677ff',
      '#52c41a',
      '#faad14',
      '#f5222d',
      '#722ed1',
      '#13c2c2',
      '#eb2f96',
      '#fa8c16',
    ],
  },
  {
    label: 'Gray',
    colors: [
      '#ffffff',
      '#f5f5f5',
      '#d9d9d9',
      '#bfbfbf',
      '#8c8c8c',
      '#595959',
      '#434343',
      '#262626',
      '#1f1f1f',
      '#141414',
      '#000000',
    ],
  },
];

const hexColor = ref('#1677ff');
const rgbColor = ref('rgb(22, 119, 255)');
const hslColor = ref('hsl(210, 100%, 54%)');

const alphaColor = ref('rgba(22, 119, 255, 0.6)');
const noAlphaColor = ref('#1677ff');

const disabledColor = ref('#1677ff');

const selectedTheme = ref('#1677ff');
const customTheme = ref('#1677ff');
const themeColors = [
  { name: 'Blue', value: '#1677ff' },
  { name: 'Green', value: '#52c41a' },
  { name: 'Purple', value: '#722ed1' },
  { name: 'Red', value: '#f5222d' },
  { name: 'Orange', value: '#fa8c16' },
  { name: 'Cyan', value: '#13c2c2' },
];

const tags = ref([
  { label: 'Vue', color: '#42b883' },
  { label: 'React', color: '#61dafb' },
  { label: 'Angular', color: '#dd0031' },
]);

const showTagModal = ref(false);
const newTag = reactive({
  label: '',
  color: '#1677ff',
});

const handleAddTag = () => {
  if (!newTag.label) {
    message.warning(t('exampleColorPicker.tagNameRequired'));
    return;
  }
  tags.value.push({ label: newTag.label, color: newTag.color });
  newTag.label = '';
  newTag.color = '#1677ff';
  showTagModal.value = false;
  message.success(t('exampleColorPicker.addTagSuccess'));
};
</script>

<style scoped lang="scss">
.mb-lg {
  margin-bottom: var(--spacing-lg);
}

.demo-section {
  margin-bottom: 32px;

  h4 {
    margin-bottom: 12px;
    font-weight: 500;
  }
}

.color-value {
  font-family: monospace;
  font-size: 14px;
  color: var(--color-text-secondary);
  background: var(--color-bg-container);
  padding: 4px 8px;
  border-radius: 4px;
}

.value-preview {
  margin-top: 12px;
  padding: 8px 12px;
  background: var(--color-bg-container);
  border-radius: 4px;
  font-family: monospace;
  font-size: 14px;
}

.size-item {
  display: flex;
  align-items: center;
  gap: 8px;

  span {
    color: var(--color-text-secondary);
  }
}

.format-item {
  display: flex;
  align-items: center;
  gap: 12px;

  span:first-child {
    width: 50px;
    color: var(--color-text-secondary);
  }
}

.theme-picker {
  display: flex;
  align-items: center;
  gap: 16px;
}

.theme-colors {
  display: flex;
  gap: 8px;
}

.theme-color-item {
  width: 28px;
  height: 28px;
  border-radius: 4px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  transition: transform 0.2s;

  &:hover {
    transform: scale(1.1);
  }

  &.active {
    box-shadow:
      0 0 0 2px #fff,
      0 0 0 4px var(--color-primary);
  }
}

.custom-picker {
  margin-left: 8px;
}

.tag-demo {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  align-items: center;
}
</style>
