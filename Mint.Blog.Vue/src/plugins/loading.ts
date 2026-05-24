import { getColorPaletteMap, getRgb } from '@/utils/color';
import { localStg } from '@/utils/storage';
import loadingSvg from '@/assets/system/svg/loading-lemonade.svg';
import { $t } from '@/locales';

export function setupLoading() {
  const themeColor = localStg.get('themeColor') || '#646cff';
  const palette = getColorPaletteMap(themeColor);
  const layoutColor = getLoadingLayoutColor();

  const { r, g, b } = getRgb(themeColor);

  const primaryColor = `--primary-color: ${r} ${g} ${b}`;
  const layoutBgColor = `--layout-bg-color: ${layoutColor}`;

  const svgCssVars = Array.from(palette.entries())
    .map(([key, value]) => `--logo-color-${key}: ${value}`)
    .join(';');

  const cssVars = `${primaryColor}; ${layoutBgColor}; ${svgCssVars}`;

  const loadingStyle = `
    <style>
      .app-loading-screen {
        position: fixed;
        inset: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: rgb(var(--layout-bg-color));
      }
      .app-loading-wrapper {
        display: flex;
        width: 360px;
        flex-direction: column;
        align-items: center;
      }
      .app-loading-logo {
        width: 230px;
        height: 230px;
      }
      .app-loading-spin-box {
        width: 56px;
        height: 56px;
        margin: 36px 0;
      }
      .app-loading-spin {
        position: relative;
        height: 100%;
        animation: app-loading-spin 1s linear infinite;
      }
      .app-loading-dot {
        position: absolute;
        width: 16px;
        height: 16px;
        border-radius: 8px;
        background-color: rgb(var(--primary-color));
        animation: app-loading-pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
      }
      .app-loading-dot_top-left {
        left: 0;
        top: 0;
      }
      .app-loading-dot_bottom-left {
        left: 0;
        bottom: 0;
        animation-delay: 500ms;
      }
      .app-loading-dot_top-right {
        right: 0;
        top: 0;
        animation-delay: 1000ms;
      }
      .app-loading-dot_bottom-right {
        right: 0;
        bottom: 0;
        animation-delay: 1500ms;
      }
      .app-loading-title {
        color: rgb(var(--primary-color));
        font-size: 28px;
        line-height: 1.2;
        font-weight: 500;
        text-align: center;
      }
      @keyframes app-loading-spin {
        to {
          transform: rotate(360deg);
        }
      }
      @keyframes app-loading-pulse {
        50% {
          opacity: 0.5;
        }
      }
      @media (max-width: 640px) {
        .app-loading-wrapper {
          width: 280px;
        }
        .app-loading-logo {
          width: 160px;
          height: 160px;
        }
        .app-loading-spin-box {
          width: 48px;
          height: 48px;
          margin: 28px 0;
        }
        .app-loading-dot {
          width: 14px;
          height: 14px;
        }
        .app-loading-title {
          font-size: 22px;
        }
        .app-loading-logo-img {
          width: 100%;
          height: 100%;
          object-fit: contain;
        }
      }
    </style>
  `;

  const loading = `
    ${loadingStyle}
    <div class="app-loading-screen" style="${cssVars}">
      <div class="app-loading-wrapper">
        <div class="app-loading-logo">
          ${getLogoSvg()}
        </div>
        <div class="app-loading-spin-box">
          <div class="app-loading-spin">
            <div class="app-loading-dot app-loading-dot_top-left"></div>
            <div class="app-loading-dot app-loading-dot_bottom-left"></div>
            <div class="app-loading-dot app-loading-dot_top-right"></div>
            <div class="app-loading-dot app-loading-dot_bottom-right"></div>
          </div>
        </div>
        <h2 class="app-loading-title">${$t('system.title')}</h2>
      </div>
    </div>
  `;

  const app = document.getElementById('app');

  if (app) {
    app.innerHTML = loading;
  }
}

function getLoadingLayoutColor() {
  const settings = localStg.get('themeSettings') as {
    themeScheme?: 'light' | 'dark' | 'auto';
    tokens?: {
      light?: { colors?: { layout?: string } };
      dark?: { colors?: { layout?: string } };
    };
  } | null;

  const systemDark = window.matchMedia?.('(prefers-color-scheme: dark)').matches ?? false;
  const scheme = settings?.themeScheme || 'light';
  const useDark = scheme === 'dark' || (scheme === 'auto' && systemDark);

  const lightLayout = settings?.tokens?.light?.colors?.layout || 'rgb(247, 250, 252)';
  const darkLayout = settings?.tokens?.dark?.colors?.layout || 'rgb(18, 18, 18)';
  const color = useDark ? darkLayout : lightLayout;

  return color
    .replace('rgb(', '')
    .replace(')', '')
    .split(',')
    .map(item => item.trim())
    .join(' ');
}

function getLogoSvg() {
  return `<img src="${loadingSvg}" alt="logo" class="app-loading-logo-img" />`;
}
