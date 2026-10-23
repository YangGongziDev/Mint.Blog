import type { App } from 'vue';
import type { PiniaPluginContext } from 'pinia';
import { createPinia } from 'pinia';
import { jsonClone } from '@/utils/klona';
import { SetupStoreId } from '@/enum';

function resetSetupStore(context: PiniaPluginContext) {
  const setupSyntaxIds = Object.values(SetupStoreId) as string[];

  if (setupSyntaxIds.includes(context.store.$id)) {
    const { $state } = context.store;
    const defaultStore = jsonClone($state);
    context.store.$reset = () => {
      context.store.$patch(defaultStore);
    };
  }
}

/** Setup Vue store plugin pinia */
export function setupStore(app: App) {
  const store = createPinia();

  store.use(resetSetupStore);

  app.use(store);
}
