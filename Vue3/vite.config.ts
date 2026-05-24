import { defineConfig, loadEnv, type UserConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import tailwindcss from "@tailwindcss/vite";
import path from "path"; // 需要引入 path 模块

export default defineConfig(({ command, mode }): UserConfig => {
  command === "serve" && console.log("启动服务");
  // 加载环境变量
  const env = loadEnv(mode, process.cwd(), "");
  // 是否为生产环境
  const isProduction = mode === "production";
  // 是否为开发环境
  const isDevelopment = mode === "development";

  return {
    plugins: [
      // vue(),
      vue({
        // 生产环境下禁用 devtools
        template: {
          compilerOptions: {
            isCustomElement: (tag) => tag.startsWith("micro-"),
          },
        },
      }),
      tailwindcss(),
    ],

    resolve: {
      alias: {
        "@": path.resolve(__dirname, "src"), // 配置 @ 别名指向 src 目录
      },
    },

    // 开发服务器配置
    server: {
      // 将本地开发服务器监听的端口设置为 9724。你可以根据需要自定义端口号。
      port: parseInt(env.VITE_DEV_PORT) || 9201,
      // 设置本地开发服务器启动后显示的 IP 访问地址为 0.0.0.0。这样可以使得你可以通过本地网络中的其他设备访问该开发服务器。
      host: "0.0.0.0",
      open: env.VITE_OPEN_BROWSER === "true",
      hmr: env.VITE_HMR !== "false",
      // 开启跨域资源共享（Cross-Origin Resource Sharing）。允许从其他域名下的网页访问当前域名的资源。
      cors: true,
      // 配置代理跨域，使用代理服务器转发 API 请求。
      proxy: {
        // 匹配带有 /api 路径的请求
        "/api": {
          // 转发到目标后端服务
          target: env.VITE_API_BASE_URL || "http://localhost:9100",
          // - 作用 : 修改请求的 Host 头部,使其与目标服务器匹配,解决跨域问题
          // - 原理 : 将请求头中的 Host 从前端地址改为后端地址
          changeOrigin: true,
          // 转发时移除 /api 前缀，因为后端控制器路径没有 /api
          rewrite: (path) => path.replace(/^\/api/, '')
        },
      },
    },

    // 构建配置
    build: {
      // 生产环境优化
      minify: isProduction ? "terser" : false,
      sourcemap: env.VITE_ENABLE_SOURCE_MAP === "true",
      // 代码分割
      rollupOptions: {
        output: {
          // 手动分割代码块
          manualChunks: {
            vue: ["vue", "vue-router", "pinia"],
            utils: ["axios", "dayjs"],
          },
        },
      },
      // 输出目录
      outDir: "dist",
      // 清空输出目录
      emptyOutDir: true,
    },

    // 环境变量前缀
    envPrefix: "VITE_",

    // 定义全局常量
    define: {
      __APP_VERSION__: JSON.stringify(env.VITE_APP_VERSION || "1.0.0"),
      __BUILD_TIME__: JSON.stringify(new Date().toISOString()),
      __DEV__: isDevelopment,
      __PROD__: isProduction,
    },

    // 优化配置
    optimizeDeps: {
      include: ["vue", "vue-router", "pinia", "axios", "dayjs"],
    },

    // 预览服务器配置
    preview: {
      port: 4173,
      open: true,
    },
  };
});
