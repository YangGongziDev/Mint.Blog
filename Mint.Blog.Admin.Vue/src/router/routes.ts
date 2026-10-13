import type { AppRouteRecordRaw } from '@/types/router';

import { PERMISSIONS } from '@/constants/permissions';

/**
 * Static routes that don't require authentication
 */
export const staticRoutes: AppRouteRecordRaw[] = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/login/index.vue'),
    meta: {
      title: 'login.title',
      requiresAuth: false,
      hidden: true,
    },
  },
  {
    path: '/404',
    name: 'NotFound',
    component: () => import('@/views/error/404.vue'),
    meta: {
      title: 'error.404',
      requiresAuth: false,
      hidden: true,
    },
  },
  {
    path: '/403',
    name: 'Forbidden',
    component: () => import('@/views/error/403.vue'),
    meta: {
      title: 'error.403',
      requiresAuth: false,
      hidden: true,
    },
  },
  {
    path: '/500',
    name: 'ServerError',
    component: () => import('@/views/error/500.vue'),
    meta: {
      title: 'error.500',
      requiresAuth: false,
      hidden: true,
    },
  },
];

/**
 * Basic routes that require authentication
 */
export const basicRoutes: AppRouteRecordRaw[] = [
  {
    path: '/',
    name: 'Root',
    redirect: '/dashboard',
    component: () => import('@/components/Layout/AdminLayout.vue'),
    meta: {
      title: 'Dashboard',
      requiresAuth: true,
    },
    children: [
      {
        path: '/redirect/:path(.*)',
        name: 'Redirect',
        component: () => import('@/views/redirect/index.vue'),
        meta: {
          title: 'Redirect',
          hidden: true,
        },
      },
      {
        path: 'dashboard',
        name: 'Dashboard',
        component: () => import('@/views/dashboard/index.vue'),
        meta: {
          title: 'menu.dashboard',
          icon: 'DashboardOutlined',
          requiresAuth: true,
          affix: true,
          order: 1,
        },
      },
      {
        path: 'profile',
        name: 'Profile',
        component: () => import('@/views/profile/index.vue'),
        meta: {
          title: 'menu.profile',
          icon: 'UserOutlined',
          requiresAuth: true,
          hidden: true,
        },
      },
      {
        path: 'notifications',
        name: 'Notifications',
        component: () => import('@/views/notification/index.vue'),
        meta: {
          title: 'layout.notifications',
          icon: 'BellOutlined',
          requiresAuth: true,
          hidden: true,
        },
      },
      {
        path: 'about',
        name: 'About',
        component: () => import('@/views/about/index.vue'),
        meta: {
          title: 'menu.about',
          icon: 'InfoCircleOutlined',
          requiresAuth: true,
          order: 5,
        },
      },
    ],
  },
];

/**
 * Async routes that require permission checking
 */
export const asyncRoutes: AppRouteRecordRaw[] = [
  {
    path: '/organization',
    name: 'Organization',
    redirect: '/organization/dept',
    component: () => import('@/components/Layout/AdminLayout.vue'),
    meta: {
      title: 'menu.organization',
      icon: 'TeamOutlined',
      requiresAuth: true,
      order: 3,
    },
    children: [
      {
        path: 'dept',
        name: 'OrganizationDept',
        component: () => import('@/views/system/dept/index.vue'),
        meta: {
          title: 'menu.dept',
          icon: 'ApartmentOutlined',
          requiresAuth: true,
          requiredPermissions: [PERMISSIONS.SYSTEM_DEPT_VIEW],
        },
      },
      {
        path: 'user',
        name: 'OrganizationUser',
        component: () => import('@/views/system/user/index.vue'),
        meta: {
          title: 'menu.user',
          icon: 'UserOutlined',
          requiresAuth: true,
          requiredPermissions: [PERMISSIONS.SYSTEM_USER_VIEW],
        },
      },
      {
        path: 'role',
        name: 'OrganizationRole',
        component: () => import('@/views/system/role/index.vue'),
        meta: {
          title: 'menu.role',
          icon: 'TeamOutlined',
          requiresAuth: true,
          requiredPermissions: [PERMISSIONS.SYSTEM_ROLE_VIEW],
        },
      },
      {
        path: 'permission',
        name: 'OrganizationPermission',
        component: () => import('@/views/system/permission/index.vue'),
        meta: {
          title: 'menu.permission',
          icon: 'SafetyOutlined',
          requiresAuth: true,
          requiredPermissions: [PERMISSIONS.SYSTEM_PERMISSION_VIEW],
        },
      },
    ],
  },
  {
    path: '/system',
    name: 'System',
    redirect: '/system/config',
    component: () => import('@/components/Layout/AdminLayout.vue'),
    meta: {
      title: 'menu.system',
      icon: 'SettingOutlined',
      requiresAuth: true,
      order: 4,
    },
    children: [
      {
        path: 'config',
        name: 'SystemConfig',
        component: () => import('@/views/system/config/index.vue'),
        meta: {
          title: 'menu.config',
          icon: 'ControlOutlined',
          requiresAuth: true,
          requiredPermissions: [PERMISSIONS.SYSTEM_CONFIG_VIEW],
        },
      },
      {
        path: 'dict',
        name: 'SystemDict',
        component: () => import('@/views/system/dict/index.vue'),
        meta: {
          title: 'menu.dict',
          icon: 'BookOutlined',
          requiresAuth: true,
          requiredPermissions: [PERMISSIONS.SYSTEM_DICT_VIEW],
        },
      },
      {
        path: 'file',
        name: 'SystemFile',
        component: () => import('@/views/system/file/index.vue'),
        meta: {
          title: 'menu.file',
          icon: 'FolderOutlined',
          requiresAuth: true,
          requiredPermissions: [PERMISSIONS.SYSTEM_FILE_VIEW],
        },
      },
      {
        path: 'log',
        name: 'SystemLog',
        component: () => import('@/views/system/log/index.vue'),
        meta: {
          title: 'menu.log',
          icon: 'FileTextOutlined',
          requiresAuth: true,
          requiredPermissions: [PERMISSIONS.SYSTEM_LOG_VIEW],
        },
      },
    ],
  },
  {
    path: '/developer',
    name: 'Developer',
    redirect: '/developer/pro-table-advanced',
    component: () => import('@/components/Layout/AdminLayout.vue'),
    meta: {
      title: 'menu.developer',
      icon: 'AppstoreOutlined',
      requiresAuth: true,
      order: 2,
    },
    children: [
      {
        path: 'quick-start',
        name: 'DeveloperQuickStartGroup',
        redirect: '/developer/pro-table-advanced',
        component: () => import('@/components/RouteView.vue'),
        meta: {
          title: 'menu.developerQuickStart',
          icon: 'ThunderboltOutlined',
          requiresAuth: true,
          order: 1,
        },
        children: [
          {
            path: '/developer/pro-table-advanced',
            name: 'DeveloperProTableAdvanced',
            component: () => import('@/views/developer/scaffold/pro-table-advanced/index.vue'),
            meta: {
              title: 'menu.proTableAdvanced',
              icon: 'TableOutlined',
              requiresAuth: true,
              order: 1,
            },
          },
          {
            path: '/developer/complex-form',
            name: 'DeveloperComplexForm',
            component: () => import('@/views/developer/scaffold/complex-form/index.vue'),
            meta: {
              title: 'menu.complexForm',
              icon: 'FormOutlined',
              requiresAuth: true,
              order: 2,
            },
          },
          {
            path: '/developer/master-detail',
            name: 'DeveloperMasterDetail',
            component: () => import('@/views/developer/scaffold/master-detail/index.vue'),
            meta: {
              title: 'menu.masterDetail',
              icon: 'ProfileOutlined',
              requiresAuth: true,
              order: 3,
            },
          },
          {
            path: '/developer/virtual-table',
            name: 'DeveloperVirtualTable',
            component: () => import('@/views/developer/scaffold/virtual-table/index.vue'),
            meta: {
              title: 'menu.virtualTable',
              icon: 'TableOutlined',
              requiresAuth: true,
              order: 4,
            },
          },
        ],
      },
      {
        path: 'form-input',
        name: 'DeveloperFormInputGroup',
        redirect: '/developer/form',
        component: () => import('@/components/RouteView.vue'),
        meta: {
          title: 'menu.developerFormInput',
          icon: 'FormOutlined',
          requiresAuth: true,
          order: 2,
        },
        children: [
          {
            path: '/developer/form',
            name: 'DeveloperForm',
            component: () => import('@/views/developer/form/index.vue'),
            meta: {
              title: 'menu.form',
              icon: 'FormOutlined',
              requiresAuth: true,
              order: 1,
            },
          },
          {
            path: '/developer/json-input',
            name: 'DeveloperJsonInput',
            component: () => import('@/views/developer/json-input/index.vue'),
            meta: {
              title: 'menu.jsonInput',
              icon: 'CodeOutlined',
              requiresAuth: true,
              order: 2,
            },
          },
          {
            path: '/developer/i18n-input',
            name: 'DeveloperI18nInput',
            component: () => import('@/views/developer/i18n-input/index.vue'),
            meta: {
              title: 'menu.i18nInput',
              icon: 'GlobalOutlined',
              requiresAuth: true,
              order: 3,
            },
          },
          {
            path: '/developer/advanced-filter',
            name: 'DeveloperAdvancedFilter',
            component: () => import('@/views/developer/scaffold/advanced-filter/index.vue'),
            meta: {
              title: 'menu.advancedFilter',
              icon: 'ControlOutlined',
              requiresAuth: true,
              order: 4,
            },
          },
        ],
      },
      {
        path: 'content-editors',
        name: 'DeveloperContentGroup',
        redirect: '/developer/editor',
        component: () => import('@/components/RouteView.vue'),
        meta: {
          title: 'menu.developerContent',
          icon: 'EditOutlined',
          requiresAuth: true,
          order: 3,
        },
        children: [
          {
            path: '/developer/editor',
            name: 'DeveloperEditor',
            component: () => import('@/views/developer/editor/index.vue'),
            meta: {
              title: 'menu.editor',
              icon: 'EditOutlined',
              requiresAuth: true,
              order: 1,
            },
          },
          {
            path: '/developer/milkdown',
            name: 'DeveloperMilkdown',
            component: () => import('@/views/developer/milkdown/index.vue'),
            meta: {
              title: 'menu.milkdown',
              icon: 'FileMarkdownOutlined',
              requiresAuth: true,
              order: 2,
            },
          },
          {
            path: '/developer/code-editor',
            name: 'DeveloperCodeEditor',
            component: () => import('@/views/developer/code-editor/index.vue'),
            meta: {
              title: 'menu.codeEditor',
              icon: 'CodeOutlined',
              requiresAuth: true,
              order: 3,
            },
          },
        ],
      },
      {
        path: 'basic-interaction',
        name: 'DeveloperInteractionGroup',
        redirect: '/developer/table',
        component: () => import('@/components/RouteView.vue'),
        meta: {
          title: 'menu.developerInteraction',
          icon: 'AppstoreAddOutlined',
          requiresAuth: true,
          order: 4,
        },
        children: [
          {
            path: '/developer/table',
            name: 'DeveloperTable',
            component: () => import('@/views/developer/table/index.vue'),
            meta: {
              title: 'menu.table',
              icon: 'TableOutlined',
              requiresAuth: true,
              order: 1,
            },
          },
          {
            path: '/developer/modal',
            name: 'DeveloperModal',
            component: () => import('@/views/developer/modal/index.vue'),
            meta: {
              title: 'menu.modal',
              icon: 'ExpandOutlined',
              requiresAuth: true,
              order: 2,
            },
          },
          {
            path: '/developer/icon',
            name: 'DeveloperIcon',
            component: () => import('@/views/developer/icon/index.vue'),
            meta: {
              title: 'menu.icon',
              icon: 'SmileOutlined',
              requiresAuth: true,
              order: 3,
            },
          },
          {
            path: '/developer/spin',
            name: 'DeveloperSpin',
            component: () => import('@/views/developer/spin/index.vue'),
            meta: {
              title: 'menu.spin',
              icon: 'LoadingOutlined',
              requiresAuth: true,
              order: 4,
            },
          },
          {
            path: '/developer/captcha',
            name: 'DeveloperCaptcha',
            component: () => import('@/views/developer/captcha/index.vue'),
            meta: {
              title: 'menu.captcha',
              icon: 'SafetyCertificateOutlined',
              requiresAuth: true,
              order: 5,
            },
          },
          {
            path: '/developer/watermark',
            name: 'DeveloperWatermark',
            component: () => import('@/views/developer/watermark/index.vue'),
            meta: {
              title: 'menu.watermark',
              icon: 'HighlightOutlined',
              requiresAuth: true,
              order: 6,
            },
          },
          {
            path: '/developer/splitter',
            name: 'DeveloperSplitter',
            component: () => import('@/views/developer/splitter/index.vue'),
            meta: {
              title: 'menu.splitter',
              icon: 'ColumnHeightOutlined',
              requiresAuth: true,
              order: 7,
            },
          },
          {
            path: '/developer/tour',
            name: 'DeveloperTour',
            component: () => import('@/views/developer/tour/index.vue'),
            meta: {
              title: 'menu.tour',
              icon: 'CompassOutlined',
              requiresAuth: true,
              order: 8,
            },
          },
          {
            path: '/developer/qrcode',
            name: 'DeveloperQRCode',
            component: () => import('@/views/developer/qrcode/index.vue'),
            meta: {
              title: 'menu.qrcode',
              icon: 'QrcodeOutlined',
              requiresAuth: true,
              order: 9,
            },
          },
          {
            path: '/developer/segmented',
            name: 'DeveloperSegmented',
            component: () => import('@/views/developer/segmented/index.vue'),
            meta: {
              title: 'menu.segmented',
              icon: 'AppstoreOutlined',
              requiresAuth: true,
              order: 10,
            },
          },
          {
            path: '/developer/color-picker',
            name: 'DeveloperColorPicker',
            component: () => import('@/views/developer/color-picker/index.vue'),
            meta: {
              title: 'menu.colorPicker',
              icon: 'BgColorsOutlined',
              requiresAuth: true,
              order: 11,
            },
          },
        ],
      },
      {
        path: 'business-scaffold',
        name: 'DeveloperBusinessScaffoldGroup',
        redirect: '/developer/upload-system',
        component: () => import('@/components/RouteView.vue'),
        meta: {
          title: 'menu.developerBusinessScaffold',
          icon: 'ProfileOutlined',
          requiresAuth: true,
          order: 5,
        },
        children: [
          {
            path: '/developer/upload-system',
            name: 'DeveloperUploadSystem',
            component: () => import('@/views/developer/scaffold/upload-system/index.vue'),
            meta: {
              title: 'menu.uploadSystem',
              icon: 'CloudUploadOutlined',
              requiresAuth: true,
              order: 1,
            },
          },
          {
            path: '/developer/state-cache',
            name: 'DeveloperStateCache',
            component: () => import('@/views/developer/scaffold/state-cache/index.vue'),
            meta: {
              title: 'menu.stateCache',
              icon: 'DatabaseOutlined',
              requiresAuth: true,
              order: 2,
            },
          },
          {
            path: '/developer/import-export',
            name: 'DeveloperImportExport',
            component: () => import('@/views/developer/scaffold/import-export/index.vue'),
            meta: {
              title: 'menu.importExport',
              icon: 'FileTextOutlined',
              requiresAuth: true,
              order: 3,
            },
          },
        ],
      },
      {
        path: 'security-engineering',
        name: 'DeveloperSecurityEngineeringGroup',
        redirect: '/developer/request-auth',
        component: () => import('@/components/RouteView.vue'),
        meta: {
          title: 'menu.developerSecurityEngineering',
          icon: 'SafetyOutlined',
          requiresAuth: true,
          order: 6,
        },
        children: [
          {
            path: '/developer/request-auth',
            name: 'DeveloperRequestAuth',
            component: () => import('@/views/developer/scaffold/request-auth/index.vue'),
            meta: {
              title: 'menu.requestAuth',
              icon: 'SafetyOutlined',
              requiresAuth: true,
              order: 1,
            },
          },
          {
            path: '/developer/rbac-flow',
            name: 'DeveloperRbacFlow',
            component: () => import('@/views/developer/scaffold/rbac/index.vue'),
            meta: {
              title: 'menu.rbacFlow',
              icon: 'SafetyCertificateOutlined',
              requiresAuth: true,
              order: 2,
            },
          },
          {
            path: '/developer/observability',
            name: 'DeveloperObservability',
            component: () => import('@/views/developer/scaffold/observability/index.vue'),
            meta: {
              title: 'menu.observability',
              icon: 'LineChartOutlined',
              requiresAuth: true,
              order: 3,
            },
          },
          {
            path: '/developer/testing',
            name: 'DeveloperTesting',
            component: () => import('@/views/developer/scaffold/testing/index.vue'),
            meta: {
              title: 'menu.testing',
              icon: 'CheckCircleOutlined',
              requiresAuth: true,
              order: 4,
            },
          },
        ],
      },
      {
        path: 'integration-navigation',
        name: 'DeveloperIntegrationGroup',
        redirect: '/developer/external/iframe/typescript',
        component: () => import('@/components/RouteView.vue'),
        meta: {
          title: 'menu.developerIntegration',
          icon: 'LinkOutlined',
          requiresAuth: true,
          order: 7,
        },
        children: [
          {
            path: 'iframe',
            name: 'DeveloperExternalIframe',
            redirect: '/developer/external/iframe/typescript',
            component: () => import('@/components/RouteView.vue'),
            meta: {
              title: 'menu.externalIframe',
              icon: 'AppstoreAddOutlined',
              requiresAuth: true,
              order: 1,
            },
            children: [
              {
                path: '/developer/external/iframe/typescript',
                name: 'DeveloperExternalIframeTypescript',
                component: () => import('@/views/developer/external/iframe/typescript.vue'),
                meta: {
                  title: 'menu.externalTypescript',
                  icon: 'CodeOutlined',
                  requiresAuth: true,
                  order: 1,
                },
              },
              {
                path: '/developer/external/iframe/antdv-next',
                name: 'DeveloperExternalIframeAntdvNext',
                component: () => import('@/views/developer/external/iframe/antdv-next.vue'),
                meta: {
                  title: 'menu.externalAntdvNext',
                  icon: 'AntDesignOutlined',
                  requiresAuth: true,
                  order: 2,
                },
              },
            ],
          },
          {
            path: 'link',
            name: 'DeveloperExternalLink',
            component: () => import('@/components/RouteView.vue'),
            meta: {
              title: 'menu.externalLink',
              icon: 'LinkOutlined',
              requiresAuth: true,
              order: 2,
            },
            children: [
              {
                path: '/developer/external/link/vite',
                name: 'DeveloperExternalLinkVite',
                component: () => import('@/views/developer/external/link/vite.vue'),
                meta: {
                  title: 'menu.externalVite',
                  icon: 'ThunderboltOutlined',
                  requiresAuth: true,
                  externalLink: 'https://vite.dev',
                  order: 1,
                },
              },
              {
                path: '/developer/external/link/vue',
                name: 'DeveloperExternalLinkVue',
                component: () => import('@/views/developer/external/link/vue.vue'),
                meta: {
                  title: 'menu.externalVue',
                  icon: 'CoffeeOutlined',
                  requiresAuth: true,
                  externalLink: 'https://vuejs.org',
                  order: 2,
                },
              },
            ],
          },
        ],
      },
      {
        path: 'exception-pages',
        name: 'DeveloperExceptionGroup',
        redirect: '/developer/exception/403',
        component: () => import('@/components/RouteView.vue'),
        meta: {
          title: 'menu.developerExceptionPages',
          icon: 'WarningOutlined',
          requiresAuth: true,
          order: 8,
        },
        children: [
          {
            path: '/developer/exception/403',
            name: 'DeveloperException403',
            component: () => import('@/views/developer/exception/403.vue'),
            meta: {
              title: 'menu.exception403',
              icon: 'StopOutlined',
              requiresAuth: true,
              order: 1,
            },
          },
          {
            path: '/developer/exception/404',
            name: 'DeveloperException404',
            component: () => import('@/views/developer/exception/404.vue'),
            meta: {
              title: 'menu.exception404',
              icon: 'FileUnknownOutlined',
              requiresAuth: true,
              order: 2,
            },
          },
          {
            path: '/developer/exception/500',
            name: 'DeveloperException500',
            component: () => import('@/views/developer/exception/500.vue'),
            meta: {
              title: 'menu.exception500',
              icon: 'BugOutlined',
              requiresAuth: true,
              order: 3,
            },
          },
        ],
      },
    ],
  },
];

/**
 * Catch-all route
 */
export const notFoundRoute: AppRouteRecordRaw = {
  path: '/:pathMatch(.*)*',
  name: 'NotFoundCatchAll',
  component: () => import('@/views/error/404.vue'),
  meta: {
    title: 'error.404',
    requiresAuth: false,
    hidden: true,
  },
};
