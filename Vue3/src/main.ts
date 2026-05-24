import { createApp } from 'vue'
import './styles/style.css'
// 引入通用主题系统
import './styles/theme.css'
import App from './App.vue'

import 'animate.css';
import 'nprogress/nprogress.css';

// 路由
import router from "@/router/index.ts";
// 路由守卫
import "@/router/guards.ts"

// 引入全局状态管理 Pinia
import pinia from "@/stores/index.ts";

// Ant Design Vue
import Antd from 'ant-design-vue'
import 'ant-design-vue/dist/reset.css'

// 图片点击放大
import 'viewerjs/dist/viewer.css'
import VueViewer from 'v-viewer'

const app = createApp(App);

app.use(router);
app.use(pinia);
app.use(Antd)
app.use(VueViewer)

//挂载Vue实例到index.html的id为app的元素上面
app.mount('#app');
