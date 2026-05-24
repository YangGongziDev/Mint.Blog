/**
 * Namespace Env
 *
 * It is used to declare the type of the import.meta object
 */
declare module 'virtual:svg-icons-register';

declare module '*.vue' {
  import type { DefineComponent } from 'vue';
  const component: DefineComponent<object, object, unknown>;
  export default component;
}

declare namespace Env {
  /** Interface for import.meta.env */
  interface ViteEnv extends ImportMetaEnv {
    /** The base url of the application */
    readonly VITE_BASE_URL: string;
    /** The title of the application */
    readonly VITE_APP_TITLE: string;
    /** The description of the application */
    readonly VITE_APP_DESC: string;
    /** backend service base url */
    readonly VITE_SERVICE_BASE_URL: string;
    /**
     * success code of backend service
     *
     * when the code is received, the request is successful
     */
    readonly VITE_SERVICE_SUCCESS_CODE: string;
    /** Whether to enable the http proxy
     *
     * Only valid in the development environment
     */
    readonly VITE_HTTP_PROXY?: CommonType.YesOrNo;
    /** Whether to build with sourcemap */
    readonly VITE_SOURCE_MAP?: CommonType.YesOrNo;
    /**
     * Iconify api provider url
     *
     * If the project is deployed in intranet, you can set the api provider url to the local iconify server
     *
     * @link https://docs.iconify.design/api/providers.html
     */
    readonly VITE_ICONIFY_URL?: string;
  }
}

interface ImportMeta {
  readonly env: Env.ViteEnv;
}
