import { AntdvNextResolver } from '@antdv-next/auto-import-resolver';
import tailwindcss from '@tailwindcss/vite';
import vue from '@vitejs/plugin-vue';
import { fileURLToPath, URL } from 'node:url';
import Components from 'unplugin-vue-components/vite';
import { defineConfig } from 'vite';
import pkg from './package.json' with { type: 'json' };

export default defineConfig({
  base: '/',
  define: { __APP_VERSION__: JSON.stringify(pkg.version) },
  plugins: [
    vue(),
    Components({ dts: false, resolvers: [AntdvNextResolver({ exclude: ['Select', 'DatePicker', 'DateRangePicker'] })] }),
    tailwindcss(),
  ],
  css: { preprocessorOptions: {
    scss: { silenceDeprecations: ['legacy-js-api'] },
    sass: { silenceDeprecations: ['legacy-js-api'] },
  } },
  resolve: { alias: { '@': fileURLToPath(new URL('./src', import.meta.url)) } },
  server: {
    host: '0.0.0.0',
    port: 8100,
    open: false,
    proxy: { '/api': { target: 'http://localhost:8000', changeOrigin: true } },
  },
  build: {
    target: 'es2020', outDir: 'dist', assetsDir: 'assets', sourcemap: false, chunkSizeWarningLimit: 1500,
    rollupOptions: { output: { manualChunks(id) {
      if (id.includes('node_modules/vue/') || id.includes('node_modules/vue-router/') || id.includes('node_modules/pinia/')) return 'vue-vendor';
      if (id.includes('node_modules/echarts/') || id.includes('node_modules/vue-echarts/')) return 'chart-vendor';
    } } },
  },
});
