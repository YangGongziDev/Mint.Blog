<template>
  <div class="page-container">
    <div class="card">
      <h2>{{ $t('developer.codeEditor.title') }}</h2>
      <p class="mb-lg text-secondary">
        {{ $t('developer.codeEditor.description') }}
      </p>

      <a-row :gutter="[16, 16]">
        <a-col :xs="24" :sm="24" :md="12">
          <div class="editor-card">
            <div class="editor-header">
              <span class="editor-title">{{ $t('developer.codeEditor.themePreview') }}</span>
              <a-select
                v-model:value="selectedTheme"
                style="width: 140px"
                size="small"
                :options="themeOptions"
              />
            </div>
            <ProCodeEditor
              v-model="themePreviewContent"
              language="typescript"
              :height="250"
              :theme="selectedTheme"
            />
          </div>
        </a-col>

        <a-col :xs="24" :sm="24" :md="12">
          <div class="editor-card">
            <div class="editor-title">{{ $t('developer.codeEditor.jsEditor') }}</div>
            <ProCodeEditor v-model="jsContent" language="javascript" :height="250" />
          </div>
        </a-col>

        <a-col :xs="24" :sm="24" :md="12">
          <div class="editor-card">
            <div class="editor-title">{{ $t('developer.codeEditor.jsonEditor') }}</div>
            <ProCodeEditor
              v-model="jsonContent"
              language="json"
              :height="250"
              :show-toolbar="true"
            />
          </div>
        </a-col>

        <a-col :xs="24" :sm="24" :md="12">
          <div class="editor-card">
            <div class="editor-title">{{ $t('developer.codeEditor.multiLanguage') }}</div>
            <ProCodeEditor
              v-model="multiLangContent"
              :language="selectedLanguage"
              :height="250"
              :show-language-select="true"
              @language-change="handleLanguageChange"
            />
          </div>
        </a-col>

        <a-col :xs="24" :sm="24" :md="12">
          <div class="editor-card">
            <div class="editor-title">{{ $t('developer.codeEditor.readonlyMode') }}</div>
            <ProCodeEditor
              v-model="readonlyContent"
              language="typescript"
              :height="250"
              :readonly="true"
            />
          </div>
        </a-col>

        <a-col :xs="24" :sm="24" :md="12">
          <div class="editor-card">
            <div class="editor-title">{{ $t('developer.codeEditor.autoHeight') }}</div>
            <div class="auto-height-wrapper">
              <ProCodeEditor
                v-model="autoHeightContent"
                language="markdown"
                :height="250"
                :line-numbers="false"
              />
            </div>
          </div>
        </a-col>
      </a-row>

      <a-divider orientation="left">{{ $t('common.preview') }}</a-divider>
      <a-card :title="$t('developer.codeEditor.outputPreview')" size="small">
        <pre class="output-preview">{{ jsonContent }}</pre>
      </a-card>
    </div>
  </div>
</template>

<script setup lang="ts">
import type { EditorTheme, SupportedLanguage } from '@/components/Pro/ProCodeEditor/index.vue';

import { ref } from 'vue';

import ProCodeEditor from '@/components/Pro/ProCodeEditor/index.vue';

const jsonContent = ref(`{
  "name": "antdv-next-admin",
  "version": "1.0.0",
  "description": "A Vue 3 admin scaffold",
  "dependencies": {
    "vue": "^3.4.0",
    "antdv-next": "^1.1.3",
    "pinia": "^2.1.7"
  },
  "scripts": {
    "dev": "vite",
    "build": "vite build"
  }
}`);

const jsContent = ref(`// JavaScript Example
function fibonacci(n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

const result = fibonacci(10);
console.log(\`Fibonacci(10) = \${result}\`);

// Arrow function example
const double = (x) => x * 2;
const numbers = [1, 2, 3, 4, 5];
const doubled = numbers.map(double);
console.log(doubled);`);

const readonlyContent = ref(`// TypeScript Interface Example
interface User {
  id: string;
  name: string;
  email: string;
  role: 'admin' | 'user' | 'guest';
  createdAt: Date;
}

interface ApiResponse<T> {
  data: T;
  success: boolean;
  message: string;
}

async function fetchUser(id: string): Promise<ApiResponse<User>> {
  const response = await fetch(\`/api/users/\${id}\`);
  return response.json();
}`);

const themePreviewContent = ref(`// TypeScript Theme Preview
interface ThemeConfig {
  name: string;
  colors: {
    primary: string;
    background: string;
    text: string;
  };
}

const themes: ThemeConfig[] = [
  { name: 'light', colors: { primary: '#1890ff', background: '#fff', text: '#333' } },
  { name: 'dark', colors: { primary: '#177ddc', background: '#141414', text: '#fff' } },
  { name: 'github', colors: { primary: '#0366d6', background: '#fff', text: '#24292e' } },
  { name: 'dracula', colors: { primary: '#bd93f9', background: '#282a36', text: '#f8f8f2' } },
  { name: 'nord', colors: { primary: '#88c0d0', background: '#2e3440', text: '#d8dee9' } },
];

function applyTheme(theme: ThemeConfig) {
  document.documentElement.style.setProperty('--color-primary', theme.colors.primary);
  document.documentElement.style.setProperty('--color-bg', theme.colors.background);
  document.documentElement.style.setProperty('--color-text', theme.colors.text);
}`);

const autoHeightContent = ref(`# Markdown Example

## Features

- **Lightweight**: Only ~100KB
- **Fast**: Built on CodeMirror 6
- **Extensible**: Support 14+ languages

## Code Block

\`\`\`javascript
const greeting = "Hello, World!";
console.log(greeting);
\`\`\`

## Table

| Feature | Status |
|---------|--------|
| Syntax Highlighting | ✅ |
| Line Numbers | ✅ |
| Code Folding | ✅ |
`);

const selectedLanguage = ref<SupportedLanguage>('javascript');
const multiLangContent = ref(`// JavaScript code\nconst hello = 'world';\nconsole.log(hello);`);

const selectedTheme = ref<EditorTheme>('auto');

const themeOptions = [
  { label: '跟随系统', value: 'auto' },
  { label: '亮色', value: 'light' },
  { label: '暗色', value: 'dark' },
  { label: 'GitHub', value: 'github' },
  { label: 'GitHub Dark', value: 'githubDark' },
  { label: 'Dracula', value: 'dracula' },
  { label: 'Material', value: 'material' },
  { label: 'Material Dark', value: 'materialDark' },
  { label: 'Monokai', value: 'monokai' },
  { label: 'Nord', value: 'nord' },
  { label: 'Tokyo Night', value: 'tokyoNight' },
  { label: 'Solarized Light', value: 'solarized' },
  { label: 'Solarized Dark', value: 'solarizedDark' },
];

const languageDeveloper: Record<SupportedLanguage, string> = {
  json: '{\n  "key": "value",\n  "array": [1, 2, 3]\n}',
  javascript: "// JavaScript code\nconst hello = 'world';\nconsole.log(hello);",
  typescript:
    "// TypeScript code\ninterface Config {\n  apiUrl: string;\n}\nconst config: Config = { apiUrl: '/api' };",
  html: '<!DOCTYPE html>\n<html>\n<head>\n  <title>Hello</title>\n</head>\n<body>\n  <h1>Hello World</h1>\n</body>\n</html>',
  css: '/* CSS Example */\n.container {\n  display: flex;\n  gap: 16px;\n  padding: 20px;\n}',
  markdown: '# Heading\n\nParagraph text here.',
  sql: '-- SQL Example\nSELECT * FROM users WHERE age > 18;',
  yaml: 'name: example\nversion: 1.0\nenvironment: development',
  xml: '<?xml version="1.0"?>\n<root>\n  <item>value</item>\n</root>',
  python: "# Python Example\ndef greet(name):\n    return f'Hello, {name}!'",
  java: '// Java Example\npublic class Main {\n    public static void main(String[] args) {\n    }\n}',
  php: "<?php\n// PHP Example\necho 'Hello World';",
  rust: '// Rust Example\nfn main() {\n    println!("Hello, world!");\n}',
  go: '// Go Example\npackage main\n\nfunc main() {\n    println("Hello")\n}',
};

function handleLanguageChange(lang: SupportedLanguage) {
  selectedLanguage.value = lang;
  multiLangContent.value = languageDeveloper[lang] || '';
}
</script>

<style scoped lang="scss">
.page-container {
  padding: 0;
}

.card {
  background: var(--color-bg-container);
  border-radius: 8px;
  padding: 24px;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

.mb-lg {
  margin-bottom: 24px;
}

.text-secondary {
  color: var(--color-text-secondary);
}

.editor-card {
  height: 100%;
  display: flex;
  flex-direction: column;
}

.editor-title {
  font-weight: 500;
  margin-bottom: 12px;
  color: var(--color-text);
}

.editor-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 12px;

  .editor-title {
    margin-bottom: 0;
  }
}

.auto-height-wrapper {
  flex: 1;
  max-height: 250px;
  overflow: auto;
}

.output-preview {
  background: var(--color-bg-layout);
  padding: 16px;
  border-radius: 4px;
  overflow-x: auto;
  font-family: monospace;
  font-size: 12px;
  max-height: 300px;
  overflow-y: auto;
  white-space: pre-wrap;
  word-break: break-all;
}

:deep(.ant-divider) {
  margin: 24px 0 16px;
}
</style>
