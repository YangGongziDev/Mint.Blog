import { defineConfig } from '@soybeanjs/eslint-config';

const baseConfig = await defineConfig(
  { vue: true },
  {
    rules: {
      'vue/multi-word-component-names': [
        'warn',
        {
          ignores: ['index', 'App', 'Register', '[id]', '[url]']
        }
      ],
      'vue/component-name-in-template-casing': [
        'warn',
        'PascalCase',
        {
          registeredComponentsOnly: false,
          ignores: ['/^icon-/']
        }
      ]
    }
  }
);

const ignoreConfig = {
  ignores: ['.vscode/**']
};

export default [ignoreConfig, ...(Array.isArray(baseConfig) ? baseConfig : [baseConfig])];
