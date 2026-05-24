import process from 'node:process';
import path from 'node:path';
import { URL, fileURLToPath } from 'node:url';
import { defineConfig, loadEnv } from 'vite';
import type { IndexHtmlTransformContext, Plugin, PluginOption } from 'vite';
import vue from '@vitejs/plugin-vue';
import vueJsx from '@vitejs/plugin-vue-jsx';
import progress from 'vite-plugin-progress';
import { createSvgIconsPlugin } from 'vite-plugin-svg-icons';
import VueDevtools from 'vite-plugin-vue-devtools';
import { FileSystemIconLoader } from 'unplugin-icons/loaders';
import IconsResolver from 'unplugin-icons/resolver';
import Icons from 'unplugin-icons/vite';
import { AntDesignVueResolver } from 'unplugin-vue-components/resolvers';
import Components from 'unplugin-vue-components/vite';
import tailwindcss from '@tailwindcss/vite';

const ICON_PREFIX = 'icon';
const ICON_LOCAL_PREFIX = 'icon-local';

export default defineConfig(configEnv => {
  const viteEnv = loadEnv(configEnv.mode, process.cwd()) as unknown as Env.ViteEnv;
  const { VITE_BASE_URL } = viteEnv;

  const localIconPath = path.join(process.cwd(), 'src/assets/system/svg');
  const collectionName = ICON_LOCAL_PREFIX.replace(`${ICON_PREFIX}-`, '');
  const isDev = configEnv.mode === 'development';

  const tailwindPlugin = tailwindcss() as unknown as PluginOption;

  const removeCrossoriginPlugin: Plugin = {
    name: 'remove-crossorigin',
    enforce: 'post',
    transformIndexHtml(html: string, _ctx: IndexHtmlTransformContext) {
      return html.replace(/\s*crossorigin(?=\s|\/|>)/g, '');
    }
  };

  return {
    base: VITE_BASE_URL,
    resolve: {
      alias: {
        '~': fileURLToPath(new URL('./', import.meta.url)),
        '@': fileURLToPath(new URL('./src', import.meta.url))
      }
    },
    plugins: [
      vue(),
      vueJsx(),
      ...(isDev ? [VueDevtools()] : []),
      Icons({
        compiler: 'vue3',
        customCollections: {
          [collectionName]: FileSystemIconLoader(localIconPath, svg =>
            svg.replace(/^<svg\s/, '<svg width="1em" height="1em" ')
          )
        },
        scale: 1,
        defaultClass: 'inline-block'
      }),
      Components({
        dts: 'src/typings/components.d.ts',
        excludeNames: [/^\d/],
        types: [{ from: 'vue-router', names: ['RouterLink', 'RouterView'] }],
        resolvers: [
          AntDesignVueResolver({
            importStyle: false
          }),
          IconsResolver({ customCollections: [collectionName], componentPrefix: ICON_PREFIX })
        ]
      }),
      createSvgIconsPlugin({
        iconDirs: [localIconPath],
        symbolId: `${ICON_LOCAL_PREFIX}-[dir]-[name]`,
        inject: 'body-last',
        customDomId: '__SVG_ICON_LOCAL__'
      }),
      progress(),
      tailwindPlugin,
      ...(isDev ? [] : [removeCrossoriginPlugin])
    ],
    build: {
      target: 'es2015',
      cssTarget: 'safari14'
    },
    server: {
      host: '0.0.0.0',
      port: 8100,
      open: true,
      proxy: {
        '/api': {
          target: 'http://localhost:8000',
          changeOrigin: true
        }
      }
    }
  };
});
