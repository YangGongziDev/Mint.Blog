import { computed, effectScope, onScopeDispose, ref, toRefs, watch } from 'vue';
import type { Ref } from 'vue';
import type { RouteLocationNormalizedGeneric, RouteLocationNormalizedLoaded } from 'vue-router';
import { useEventListener, usePreferredColorScheme } from '@vueuse/core';
import { defineStore } from 'pinia';
import { getPaletteColorByNumber } from '@/utils/color';
import { localStg } from '@/utils/storage';
import { SetupStoreId } from '@/enum';
import {
  addThemeVarsToGlobal,
  createThemeToken,
  getAntdTheme,
  initThemeSettings,
  toggleAuxiliaryColorModes,
  toggleCssDarkMode
} from './shared';

/** Theme store */
export const useThemeStore = defineStore(SetupStoreId.Theme, () => {
  const scope = effectScope();
  const osTheme = usePreferredColorScheme();

  type LayoutSection = 'admin' | 'surfer';
  const currentLayoutSection = ref<LayoutSection | null>(null);

  function getLayoutSectionByRoute(
    route: RouteLocationNormalizedGeneric | RouteLocationNormalizedLoaded
  ): LayoutSection | null {
    if (route.meta.layout === 'backstage') return 'admin';
    if (route.meta.layout === 'frontdesk') return 'surfer';

    return null;
  }

  function getDefaultLayoutBySection(section: LayoutSection): UnionKey.ThemeLayoutMode {
    return section === 'admin' ? 'vertical' : 'horizontal';
  }

  function getCachedLayoutModes() {
    return localStg.get('themeLayoutModes') || {};
  }

  /** Theme settings */
  const settings: Ref<App.Theme.ThemeSetting> = ref(initThemeSettings());

  /** Reset store */
  function resetStore() {
    const themeStore = useThemeStore();

    themeStore.$reset();
  }

  /** Theme colors */
  const themeColors = computed(() => {
    const { themeColor, otherColor, isInfoFollowPrimary } = settings.value;
    const colors: App.Theme.ThemeColor = {
      primary: themeColor,
      ...otherColor,
      info: isInfoFollowPrimary ? themeColor : otherColor.info
    };
    return colors;
  });

  /** Dark mode */
  const darkMode = computed(() => {
    if (settings.value.themeScheme === 'auto') {
      return osTheme.value === 'dark';
    }
    return settings.value.themeScheme === 'dark';
  });

  /** grayscale mode */
  const grayscaleMode = computed(() => settings.value.grayscale);

  /** colourWeakness mode */
  const colourWeaknessMode = computed(() => settings.value.colourWeakness);

  /** Antd theme */
  const antdTheme = computed(() => getAntdTheme(themeColors.value, darkMode.value));

  /**
   * Settings json
   *
   * It is for copy settings
   */
  const settingsJson = computed(() => JSON.stringify(settings.value));

  /**
   * Set theme scheme
   *
   * @param themeScheme
   */
  function setThemeScheme(themeScheme: UnionKey.ThemeScheme) {
    settings.value.themeScheme = themeScheme;

    const nextDarkMode = themeScheme === 'auto' ? osTheme.value === 'dark' : themeScheme === 'dark';
    toggleCssDarkMode(nextDarkMode);
  }

  /**
   * Set grayscale value
   *
   * @param isGrayscale
   */
  function setGrayscale(isGrayscale: boolean) {
    settings.value.grayscale = isGrayscale;
  }

  /**
   * Set colourWeakness value
   *
   * @param isColourWeakness
   */
  function setColourWeakness(isColourWeakness: boolean) {
    settings.value.colourWeakness = isColourWeakness;
  }

  /** Toggle theme scheme */
  function toggleThemeScheme() {
    const themeSchemes: UnionKey.ThemeScheme[] = ['light', 'dark', 'auto'];

    const index = themeSchemes.findIndex(item => item === settings.value.themeScheme);

    const nextIndex = index === themeSchemes.length - 1 ? 0 : index + 1;

    const nextThemeScheme = themeSchemes[nextIndex];

    setThemeScheme(nextThemeScheme);
  }

  /**
   * Set theme layout
   *
   * @param mode Theme layout mode
   */
  function setThemeLayout(mode: UnionKey.ThemeLayoutMode) {
    settings.value.layout.mode = mode;

    const section = currentLayoutSection.value;
    if (!section) return;

    localStg.set('themeLayoutModes', {
      ...getCachedLayoutModes(),
      [section]: mode
    });
  }

  function setTemporaryThemeLayout(mode: UnionKey.ThemeLayoutMode) {
    settings.value.layout.mode = mode;
  }

  function applyThemeLayoutByRoute(route: RouteLocationNormalizedLoaded | RouteLocationNormalizedGeneric) {
    const section = getLayoutSectionByRoute(route);
    if (!section) return;

    currentLayoutSection.value = section;
    const cachedModes = getCachedLayoutModes();
    const cachedMode = cachedModes[section];

    if (section === 'surfer' && cachedMode === 'vertical') {
      localStg.set('themeLayoutModes', {
        ...cachedModes,
        surfer: getDefaultLayoutBySection(section)
      });
      settings.value.layout.mode = getDefaultLayoutBySection(section);
      return;
    }

    settings.value.layout.mode = cachedMode || getDefaultLayoutBySection(section);
  }

  /**
   * Update theme colors
   *
   * @param key Theme color key
   * @param color Theme color
   */
  function updateThemeColors(key: App.Theme.ThemeColorKey, color: string) {
    let colorValue = color;

    if (settings.value.recommendColor) {
      // get a color palette by provided color and color name, and use the suitable color

      colorValue = getPaletteColorByNumber(color, 500, true);
    }

    if (key === 'primary') {
      settings.value.themeColor = colorValue;
    } else {
      settings.value.otherColor[key] = colorValue;
    }
  }

  /** Setup theme vars to global */
  function setupThemeVarsToGlobal() {
    const { themeTokens, darkThemeTokens } = createThemeToken(
      themeColors.value,
      settings.value.tokens,
      settings.value.recommendColor
    );
    addThemeVarsToGlobal(themeTokens, darkThemeTokens);
  }

  /**
   * Set layout reverse horizontal mix
   *
   * @param reverse Reverse horizontal mix
   */
  function setLayoutReverseHorizontalMix(reverse: boolean) {
    settings.value.layout.reverseHorizontalMix = reverse;
  }

  /** Cache theme settings */
  function cacheThemeSettings() {
    localStg.set('themeSettings', settings.value);
  }

  // cache theme settings when page is closed or refreshed
  useEventListener(window, 'beforeunload', () => {
    cacheThemeSettings();
  });

  // watch store
  scope.run(() => {
    // watch dark mode
    watch(
      darkMode,
      val => {
        toggleCssDarkMode(val);
      },
      { immediate: true }
    );

    watch(
      [grayscaleMode, colourWeaknessMode],
      val => {
        toggleAuxiliaryColorModes(val[0], val[1]);
      },
      { immediate: true }
    );

    watch(
      settings,
      () => {
        cacheThemeSettings();
      },
      { deep: true }
    );

    // themeColors change, update css vars and storage theme color
    watch(
      themeColors,
      val => {
        setupThemeVarsToGlobal();
        localStg.set('themeColor', val.primary);
      },
      { immediate: true }
    );
  });

  /** On scope dispose */
  onScopeDispose(() => {
    scope.stop();
  });

  return {
    ...toRefs(settings.value),
    darkMode,
    themeColors,
    antdTheme,
    settingsJson,
    setGrayscale,
    setColourWeakness,
    resetStore,
    toggleThemeScheme,
    setThemeScheme,
    updateThemeColors,
    setThemeLayout,
    setTemporaryThemeLayout,
    applyThemeLayoutByRoute,
    setLayoutReverseHorizontalMix
  };
});
