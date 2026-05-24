import { menuOptions } from '@/menu';
import locales from '@/locales/locale';
import { createStaticRoutes } from '@/router';
import { flattenRoutes } from '@/store/system/route/shared';

function hasNestedKey(source: unknown, path: string) {
  let current: unknown = source;

  return path.split('.').every(key => {
    if (current && typeof current === 'object' && key in current) {
      current = (current as Record<string, unknown>)[key];
      return true;
    }

    return false;
  });
}

function getStaticRoutes() {
  return createStaticRoutes();
}

function validateMenuI18nKeys() {
  const menuKeys = [...new Set(menuOptions.map(menu => menu.menuI18nKey))];
  const missingEntries = Object.entries(locales).flatMap(([lang, schema]) => {
    return menuKeys.filter(key => !hasNestedKey(schema, key)).map(key => `${lang}: ${key}`);
  });

  if (missingEntries.length === 0) {
    return;
  }

  // eslint-disable-next-line no-console
  console.error(`[menu-i18n-check] Missing menu i18n keys:\n${missingEntries.join('\n')}`);
}

function validateRouteMenuMappings() {
  const routes = flattenRoutes(getStaticRoutes());
  const menuRouteKeys = new Set(menuOptions.map(menu => menu.routerName).filter(Boolean));
  const missingMenuRoutes = routes
    .filter(route => route.name)
    .filter(route => !route.meta?.hideInMenu)
    .filter(route => !menuRouteKeys.has(String(route.name) as never))
    .map(route => String(route.name));

  if (missingMenuRoutes.length === 0) {
    return;
  }

  // eslint-disable-next-line no-console
  console.error(`[menu-route-check] Missing menu records for routes:\n${missingMenuRoutes.join('\n')}`);
}

function validateBreadcrumbFallbackRoutes() {
  const routes = flattenRoutes(getStaticRoutes());
  const menuRouteKeys = new Set(menuOptions.map(menu => menu.routerName).filter(Boolean));
  const fallbackRoutes = routes
    .filter(route => route.name)
    .filter(route => !route.meta?.hideInMenu || Boolean(route.meta?.activeMenu))
    .map(route => {
      const routeName = String(route.name);
      const activeMenu = (route.meta?.activeMenu as string | null) || null;
      const breadcrumbKey = activeMenu || routeName;

      return {
        routeName,
        breadcrumbKey,
        willFallback: !menuRouteKeys.has(breadcrumbKey as never)
      };
    })
    .filter(item => item.willFallback)
    .map(item => `${item.routeName} -> ${item.breadcrumbKey}`);

  if (fallbackRoutes.length === 0) {
    return;
  }

  // eslint-disable-next-line no-console
  console.warn(`[breadcrumb-fallback-check] These routes will show default breadcrumb icon and "无标题":\n${fallbackRoutes.join('\n')}`);
}

export function validateMenuSetup() {
  if (!import.meta.env.DEV) {
    return;
  }

  validateMenuI18nKeys();
  validateRouteMenuMappings();
  validateBreadcrumbFallbackRoutes();
}
