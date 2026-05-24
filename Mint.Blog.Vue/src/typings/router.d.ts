import 'vue-router';
import type { MenuModuleKey, RouteKey, RouteLayout } from '@/router/types';

declare module 'vue-router' {
  interface RouteMeta {
    /**
     * Title of the route
     *
     * It can be used in document title
     */
    title?: string;
    /**
     * I18n key of the route
     *
     * It's used in i18n, if it is set, the title will be ignored
     */
    i18nKey?: App.I18n.I18nKey | null;
    /**
     * Roles of the route
     *
     * Route can be accessed if the current user has at least one of the roles
     *
     * It only works when the route mode is "static", if the route mode is "dynamic", it will be ignored
     */
    roles?: string[];
    /** The layout shell used by the module route */
    layout?: RouteLayout;
    /** The menu module used by the module route */
    menuModule?: MenuModuleKey;
    /** Whether to cache the route */
    keepAlive?: boolean | null;
    /**
     * Whether login is required for the route
     *
     * If true, unauthenticated users will be redirected to login and then back to this page after login.
     */
    public?: boolean | null;
    /**
     * Is constant route
     *
     * @deprecated Use `public` instead.
     */
    constant?: boolean | null;
    /**
     * Iconify icon
     *
     * It can be used in the menu or breadcrumb
     */
    icon?: string;
    /**
     * Local icon
     *
     * In "src/assets/system", if it is set, the icon will be ignored
     */
    localIcon?: string;
    /** Icon size. width and height are the same. */
    iconFontSize?: number;
    /** Router order */
    order?: number | null;
    /** The outer link of the route */
    href?: string | null;
    /** Whether to hide the route in the menu */
    hideInMenu?: boolean | null;
    /**
     * The menu key will be activated when entering the route
     *
     * The route is not in the menu
     *
     * @example
     *   the route is "user_detail", if it is set to "user_list", the menu "user_list" will be activated
     */
    activeMenu?: RouteKey | null;
    /**
     * By default, the same route path will use one tab, even with different query, if set true, the route with
     * different query will use different tabs
     */
    multiTab?: boolean | null;
    /** If set, the route will be fixed in tabs, and the value is the order of fixed tabs */
    fixedIndexInTab?: number | null;
    /** if set query parameters, it will be automatically carried when entering the route */
    query?: { key: string; value: string }[] | null;
  }
}
