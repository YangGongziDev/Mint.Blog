import { createApp } from 'vue';
import { setupDayjs, setupIconifyOffline, setupLoading, setupNProgress } from './plugins';
import { validateMenuSetup } from './menu';
import { setupStore } from './store';
import { setupRouter } from './router';
import { setupI18n } from './locales';
import 'virtual:svg-icons-register';
import './styles/index.scss';
import './styles/tailwind.css';
import App from './App.vue';

async function setupApp() {
  validateMenuSetup();

  setupLoading();

  setupNProgress();

  setupIconifyOffline();

  setupDayjs();

  const app = createApp(App);

  setupStore(app);

  await setupRouter(app);

  setupI18n(app);

  app.mount('#app');
}

setupApp();
