/** Default theme settings */
export const themeSettings: App.Theme.ThemeSetting = {
  themeScheme: 'light',
  grayscale: false,
  colourWeakness: false,
  recommendColor: false,
  themeColor: '#646cff',
  otherColor: {
    info: '#2080f0',
    success: '#52c41a',
    warning: '#faad14',
    error: '#f5222d'
  },
  isInfoFollowPrimary: true,
  resetCacheStrategy: 'close',
  layout: {
    mode: 'vertical',
    scrollMode: 'content',
    reverseHorizontalMix: false
  },
  page: {
    animate: true,
    animateMode: 'fade-slide'
  },
  header: {
    height: 45,
    breadcrumb: {
      visible: true,
      showIcon: true
    }
  },
  tab: {
    visible: true,
    cache: true,
    height: 33,
    mode: 'chrome'
  },
  fixedHeaderAndTab: true,
  sider: {
    inverted: false,
    // 宽度
    width: 220,
    // 折叠宽度
    collapsedWidth: 85,
    // 混合宽度
    mixWidth: 90,
    // 混合折叠宽度
    mixCollapsedWidth: 64,
    // 混合子菜单宽度
    mixChildMenuWidth: 200
  },
  footer: {
    visible: true,
    fixed: false,
    height: 48,
    right: true
  },
  watermark: {
    visible: false,
    text: 'MintAdmin'
  },
  tokens: {
    light: {
      colors: {
        container: 'rgb(255, 255, 255)',
        layout: 'rgb(247, 250, 252)',
        inverted: 'rgb(0, 20, 40)',
        'base-text': 'rgb(31, 31, 31)'
      },
      boxShadow: {
        header: '0 2px 8px rgba(0, 0, 0, 0.08)',
        sider: '2px 0 8px 0 rgb(29, 35, 41, 0.05)',
        tab: '0 1px 2px rgb(0, 21, 41, 0.08)'
      }
    },
    dark: {
      colors: {
        container: 'rgb(44, 51, 62)',
        layout: 'rgb(35, 41, 49)',
        'base-text': 'rgb(203, 213, 225)'
      },
      boxShadow: {
        header: '0 2px 12px rgba(0, 0, 0, 0.4)',
        sider: '2px 0 8px 0 rgb(0, 0, 0, 0.3)',
        tab: '0 1px 2px rgb(0, 0, 0, 0.3)'
      }
    }
  }
};

/**
 * Override theme settings
 *
 * If publish new version, use `overrideThemeSettings` to override certain theme settings
 */
export const overrideThemeSettings: Partial<App.Theme.ThemeSetting> = {};
