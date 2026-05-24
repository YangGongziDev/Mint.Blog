<template>
  <div class="ml-[12px]">
    <ABreadcrumb v-if="themeStore.header.breadcrumb.visible" v-bind="attrs">
      <ABreadcrumbItem v-for="item in routeStore.breadcrumbs" :key="item.key">
        <span class="breadcrumb-label inline-flex cursor-pointer items-center align-middle">
          <component :is="item.icon" v-if="themeStore.header.breadcrumb.showIcon && item.icon" class="mr-[4px] text-icon" />
          <span>{{ item.title || item.label }}</span>
        </span>

        <template v-if="item.children?.length" #overlay>
          <AMenu>
            <template v-for="option in item.children" :key="option.key">
              <ASubMenu v-if="option.children?.length">
                <template #title>
                  <span class="inline-flex cursor-pointer items-center align-middle">
                    <component
                      :is="option.icon"
                      v-if="themeStore.header.breadcrumb.showIcon && option.icon"
                      class="mr-[4px] text-icon"
                    />
                    <span>{{ option.title || option.label }}</span>
                  </span>
                </template>
                <AMenuItem v-for="child in option.children" :key="child.key" @click="handleClickMenu(child)">
                  <span class="inline-flex cursor-pointer items-center align-middle">
                    <component
                      :is="child.icon"
                      v-if="themeStore.header.breadcrumb.showIcon && child.icon"
                      class="mr-[4px] text-icon"
                    />
                    <span>{{ child.title || child.label }}</span>
                  </span>
                </AMenuItem>
              </ASubMenu>
              <AMenuItem v-else @click="handleClickMenu(option)">
                <span class="inline-flex items-center align-middle">
                  <component
                    :is="option.icon"
                    v-if="themeStore.header.breadcrumb.showIcon && option.icon"
                    class="mr-[4px] text-icon"
                  />
                  <span>{{ option.title || option.label }}</span>
                </span>
              </AMenuItem>
            </template>
          </AMenu>
        </template>
      </ABreadcrumbItem>
    </ABreadcrumb>
  </div>
</template>

<script setup lang="ts">
import { useAttrs } from 'vue';
import { useThemeStore } from '@/store/system/theme';
import { useRouteStore } from '@/store/system/route';
import { useRouterPush } from '@/hooks/routing/use-router-push';

defineOptions({
  name: 'Breadcrumb',
  inheritAttrs: false
});

const attrs = useAttrs();
const themeStore = useThemeStore();
const routeStore = useRouteStore();
const { routerPushByKey } = useRouterPush();

function handleClickMenu(menu: App.Global.Menu) {
  if (menu.children?.length) return;

  routerPushByKey(menu.routeKey);
}
</script>

<style scoped lang="scss">
.breadcrumb-label {
  cursor: pointer;
}

:deep(.ant-dropdown-trigger) {
  cursor: pointer;
}
</style>
