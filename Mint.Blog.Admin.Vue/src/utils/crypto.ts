import { colord, extend } from 'colord';
import namesPlugin from 'colord/plugins/names';
import mixPlugin from 'colord/plugins/mix';
import labPlugin from 'colord/plugins/lab';
import type { AnyColor, HslColor, HsvColor, RgbColor } from 'colord';

extend([namesPlugin, mixPlugin, labPlugin]);

/**
 * Add color alpha
 *
 * @param color - Color
 * @param alpha - Alpha (0 - 1)
 */
export function addColorAlpha(color: string, alpha: number) {
  return colord(color).alpha(alpha).toHex();
}

/**
 * Mix color
 *
 * @param firstColor - First color
 * @param secondColor - Second color
 * @param ratio - The ratio of the second color (0 - 1)
 */
export function mixColor(firstColor: string, secondColor: string, ratio: number) {
  return colord(firstColor).mix(secondColor, ratio).toHex();
}

/**
 * Transform color with opacity to similar color without opacity
 *
 * @param color - Color
 * @param alpha - Alpha (0 - 1)
 * @param bgColor Background color (usually white or black)
 */
export function transformColorWithOpacity(color: string, alpha: number, bgColor = '#ffffff') {
  const originColor = addColorAlpha(color, alpha);
  const { r: oR, g: oG, b: oB } = colord(originColor).toRgb();

  const { r: bgR, g: bgG, b: bgB } = colord(bgColor).toRgb();

  function calRgb(or: number, bg: number, al: number) {
    return bg + (or - bg) * al;
  }

  const resultRgb: RgbColor = {
    r: calRgb(oR, bgR, alpha),
    g: calRgb(oG, bgG, alpha),
    b: calRgb(oB, bgB, alpha)
  };

  return colord(resultRgb).toHex();
}

/**
 * Is white color
 *
 * @param color - Color
 */
export function isWhiteColor(color: string) {
  return colord(color).isEqual('#ffffff');
}

/**
 * Get rgb of color
 *
 * @param color Color
 */
export function getRgbOfColor(color: string) {
  return colord(color).toRgb();
}

export function getRgb(color: AnyColor) {
  return colord(color).toRgb();
}

export type ColorPaletteNumber = 50 | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 | 950;

type ColorPalette = { hex: string; number: ColorPaletteNumber };

type ColorPaletteFamily = { name: string; palettes: ColorPalette[] };

export function getColorPaletteMap(color: AnyColor, recommended = false) {
  const colorMap = new Map<ColorPaletteNumber, string>();

  if (recommended) {
    const colorPaletteFamily = getRecommendedColorPaletteFamily(getHex(color));
    colorPaletteFamily.palettes.forEach(palette => {
      colorMap.set(palette.number, palette.hex);
    });
  } else {
    const colors = getAntDColorPaletteForMap(color);

    const colorNumbers: ColorPaletteNumber[] = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950];

    colorNumbers.forEach((number, index) => {
      colorMap.set(number, colors[index]);
    });
  }

  return colorMap;
}

export function getPaletteColorByNumber(color: AnyColor, number: ColorPaletteNumber, recommended = false) {
  const colorMap = getColorPaletteMap(color, recommended);

  return colorMap.get(number)!;
}

/** Hue step */
const hueStep = 2;
/** Saturation step, light color part */
const saturationStep = 16;
/** Saturation step, dark color part */
const saturationStep2 = 5;
/** Brightness step, light color part */
const brightnessStep1 = 5;
/** Brightness step, dark color part */
const brightnessStep2 = 15;
/** Light color count, main color up */
const lightColorCount = 5;
/** Dark color count, main color down */
const darkColorCount = 4;

/**
 * The color index of color palette
 *
 * From left to right, the color is from light to dark, 6 is main color
 */
type ColorIndex = 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10;

/**
 * Get color palette (from left to right, the color is from light to dark, 6 is main color)
 *
 * @param color - Color
 * @param index - The color index of color palette (the main color index is 6)
 * @returns Hex color
 */
export function getColorPalette(color: AnyColor, index: ColorIndex): string {
  const transformColor = colord(color);

  if (!transformColor.isValid()) {
    throw new Error('invalid input color value');
  }

  if (index === 6) {
    return colord(transformColor).toHex();
  }

  const isLight = index < 6;
  const hsv = transformColor.toHsv();
  const i = isLight ? lightColorCount + 1 - index : index - lightColorCount - 1;

  const newHsv: HsvColor = {
    h: getHue(hsv, i, isLight),
    s: getSaturation(hsv, i, isLight),
    v: getValue(hsv, i, isLight)
  };

  return colord(newHsv).toHex();
}

/** Map of dark color index and opacity */
const darkColorMap = [
  { index: 7, opacity: 0.15 },
  { index: 6, opacity: 0.25 },
  { index: 5, opacity: 0.3 },
  { index: 5, opacity: 0.45 },
  { index: 5, opacity: 0.65 },
  { index: 5, opacity: 0.85 },
  { index: 4, opacity: 0.9 },
  { index: 3, opacity: 0.95 },
  { index: 2, opacity: 0.97 },
  { index: 1, opacity: 0.98 }
];

/**
 * Get color palettes
 *
 * @param color - Color
 * @param darkTheme - Dark theme
 * @param darkThemeMixColor - Dark theme mix color (default: #141414)
 */
export function getColorPalettes(color: AnyColor, darkTheme = false, darkThemeMixColor = '#141414'): string[] {
  const indexes: ColorIndex[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  const patterns = indexes.map(index => getColorPalette(color, index));

  if (darkTheme) {
    const darkPatterns = darkColorMap.map(({ index, opacity }) => {
      const darkColor = colord(darkThemeMixColor).mix(patterns[index], opacity);

      return darkColor;
    });

    return darkPatterns.map(item => colord(item).toHex());
  }

  return patterns;
}

/**
 * Get hue
 *
 * @param hsv - Hsv format color
 * @param i - The relative distance from 6
 * @param isLight - Is light color
 */
function getHue(hsv: HsvColor, i: number, isLight: boolean) {
  let hue: number;

  const hsvH = Math.round(hsv.h);

  if (hsvH >= 60 && hsvH <= 240) {
    hue = isLight ? hsvH - hueStep * i : hsvH + hueStep * i;
  } else {
    hue = isLight ? hsvH + hueStep * i : hsvH - hueStep * i;
  }

  if (hue < 0) {
    hue += 360;
  }

  if (hue >= 360) {
    hue -= 360;
  }

  return hue;
}

/**
 * Get saturation
 *
 * @param hsv - Hsv format color
 * @param i - The relative distance from 6
 * @param isLight - Is light color
 */
function getSaturation(hsv: HsvColor, i: number, isLight: boolean) {
  if (hsv.h === 0 && hsv.s === 0) {
    return hsv.s;
  }

  let saturation: number;

  if (isLight) {
    saturation = hsv.s - saturationStep * i;
  } else if (i === darkColorCount) {
    saturation = hsv.s + saturationStep;
  } else {
    saturation = hsv.s + saturationStep2 * i;
  }

  if (saturation > 100) {
    saturation = 100;
  }

  if (isLight && i === lightColorCount && saturation > 10) {
    saturation = 10;
  }

  if (saturation < 6) {
    saturation = 6;
  }

  return saturation;
}

/**
 * Get value of hsv
 *
 * @param hsv - Hsv format color
 * @param i - The relative distance from 6
 * @param isLight - Is light color
 */
function getValue(hsv: HsvColor, i: number, isLight: boolean) {
  let value: number;

  if (isLight) {
    value = hsv.v + brightnessStep1 * i;
  } else {
    value = hsv.v - brightnessStep2 * i;
  }

  if (value > 100) {
    value = 100;
  }

  return value;
}

function isValidColor(color: AnyColor) {
  return colord(color).isValid();
}

function getHex(color: AnyColor) {
  return colord(color).toHex();
}

function getHsl(color: AnyColor) {
  return colord(color).toHsl();
}

function getDeltaE(color1: AnyColor, color2: AnyColor) {
  return colord(color1).delta(color2);
}

function transformHslToHex(color: HslColor) {
  return colord(color).toHex();
}

type AntdColorIndex = 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11;

function getAntDPaletteColorByIndex(color: AnyColor, index: AntdColorIndex): string {
  const transformColor = colord(color);

  if (!transformColor.isValid()) {
    throw new Error('invalid input color value');
  }

  if (index === 6) {
    return colord(transformColor).toHex();
  }

  const isLight = index < 6;
  const hsv = transformColor.toHsv();
  const i = isLight ? lightColorCount + 1 - index : index - lightColorCount - 1;

  const newHsv: HsvColor = {
    h: getHue(hsv, i, isLight),
    s: getSaturation(hsv, i, isLight),
    v: getValue(hsv, i, isLight)
  };

  return colord(newHsv).toHex();
}

function getAntDColorPaletteForMap(color: AnyColor): string[] {
  const indexes: AntdColorIndex[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

  return indexes.map(index => getAntDPaletteColorByIndex(color, index));
}

const recommendedColorPalettes: ColorPaletteFamily[] = [
  {
    name: 'Slate',
    palettes: [
      { hex: '#f8fafc', number: 50 },
      { hex: '#f1f5f9', number: 100 },
      { hex: '#e2e8f0', number: 200 },
      { hex: '#cbd5e1', number: 300 },
      { hex: '#94a3b8', number: 400 },
      { hex: '#64748b', number: 500 },
      { hex: '#475569', number: 600 },
      { hex: '#334155', number: 700 },
      { hex: '#1e293b', number: 800 },
      { hex: '#0f172a', number: 900 },
      { hex: '#020617', number: 950 }
    ]
  },
  {
    name: 'Gray',
    palettes: [
      { hex: '#f9fafb', number: 50 },
      { hex: '#f3f4f6', number: 100 },
      { hex: '#e5e7eb', number: 200 },
      { hex: '#d1d5db', number: 300 },
      { hex: '#9ca3af', number: 400 },
      { hex: '#6b7280', number: 500 },
      { hex: '#4b5563', number: 600 },
      { hex: '#374151', number: 700 },
      { hex: '#1f2937', number: 800 },
      { hex: '#111827', number: 900 },
      { hex: '#030712', number: 950 }
    ]
  },
  {
    name: 'Zinc',
    palettes: [
      { hex: '#fafafa', number: 50 },
      { hex: '#f4f4f5', number: 100 },
      { hex: '#e4e4e7', number: 200 },
      { hex: '#d4d4d8', number: 300 },
      { hex: '#a1a1aa', number: 400 },
      { hex: '#71717a', number: 500 },
      { hex: '#52525b', number: 600 },
      { hex: '#3f3f46', number: 700 },
      { hex: '#27272a', number: 800 },
      { hex: '#18181b', number: 900 },
      { hex: '#09090b', number: 950 }
    ]
  },
  {
    name: 'Neutral',
    palettes: [
      { hex: '#fafafa', number: 50 },
      { hex: '#f5f5f5', number: 100 },
      { hex: '#e5e5e5', number: 200 },
      { hex: '#d4d4d4', number: 300 },
      { hex: '#a3a3a3', number: 400 },
      { hex: '#737373', number: 500 },
      { hex: '#525252', number: 600 },
      { hex: '#404040', number: 700 },
      { hex: '#262626', number: 800 },
      { hex: '#171717', number: 900 },
      { hex: '#0a0a0a', number: 950 }
    ]
  },
  {
    name: 'Stone',
    palettes: [
      { hex: '#fafaf9', number: 50 },
      { hex: '#f5f5f4', number: 100 },
      { hex: '#e7e5e4', number: 200 },
      { hex: '#d6d3d1', number: 300 },
      { hex: '#a8a29e', number: 400 },
      { hex: '#78716c', number: 500 },
      { hex: '#57534e', number: 600 },
      { hex: '#44403c', number: 700 },
      { hex: '#292524', number: 800 },
      { hex: '#1c1917', number: 900 },
      { hex: '#0c0a09', number: 950 }
    ]
  },
  {
    name: 'Red',
    palettes: [
      { hex: '#fef2f2', number: 50 },
      { hex: '#fee2e2', number: 100 },
      { hex: '#fecaca', number: 200 },
      { hex: '#fca5a5', number: 300 },
      { hex: '#f87171', number: 400 },
      { hex: '#ef4444', number: 500 },
      { hex: '#dc2626', number: 600 },
      { hex: '#b91c1c', number: 700 },
      { hex: '#991b1b', number: 800 },
      { hex: '#7f1d1d', number: 900 },
      { hex: '#450a0a', number: 950 }
    ]
  },
  {
    name: 'Orange',
    palettes: [
      { hex: '#fff7ed', number: 50 },
      { hex: '#ffedd5', number: 100 },
      { hex: '#fed7aa', number: 200 },
      { hex: '#fdba74', number: 300 },
      { hex: '#fb923c', number: 400 },
      { hex: '#f97316', number: 500 },
      { hex: '#ea580c', number: 600 },
      { hex: '#c2410c', number: 700 },
      { hex: '#9a3412', number: 800 },
      { hex: '#7c2d12', number: 900 },
      { hex: '#431407', number: 950 }
    ]
  },
  {
    name: 'Amber',
    palettes: [
      { hex: '#fffbeb', number: 50 },
      { hex: '#fef3c7', number: 100 },
      { hex: '#fde68a', number: 200 },
      { hex: '#fcd34d', number: 300 },
      { hex: '#fbbf24', number: 400 },
      { hex: '#f59e0b', number: 500 },
      { hex: '#d97706', number: 600 },
      { hex: '#b45309', number: 700 },
      { hex: '#92400e', number: 800 },
      { hex: '#78350f', number: 900 },
      { hex: '#451a03', number: 950 }
    ]
  },
  {
    name: 'Yellow',
    palettes: [
      { hex: '#fefce8', number: 50 },
      { hex: '#fef9c3', number: 100 },
      { hex: '#fef08a', number: 200 },
      { hex: '#fde047', number: 300 },
      { hex: '#facc15', number: 400 },
      { hex: '#eab308', number: 500 },
      { hex: '#ca8a04', number: 600 },
      { hex: '#a16207', number: 700 },
      { hex: '#854d0e', number: 800 },
      { hex: '#713f12', number: 900 },
      { hex: '#422006', number: 950 }
    ]
  },
  {
    name: 'Lime',
    palettes: [
      { hex: '#f7fee7', number: 50 },
      { hex: '#ecfccb', number: 100 },
      { hex: '#d9f99d', number: 200 },
      { hex: '#bef264', number: 300 },
      { hex: '#a3e635', number: 400 },
      { hex: '#84cc16', number: 500 },
      { hex: '#65a30d', number: 600 },
      { hex: '#4d7c0f', number: 700 },
      { hex: '#3f6212', number: 800 },
      { hex: '#365314', number: 900 },
      { hex: '#1a2e05', number: 950 }
    ]
  },
  {
    name: 'Green',
    palettes: [
      { hex: '#f0fdf4', number: 50 },
      { hex: '#dcfce7', number: 100 },
      { hex: '#bbf7d0', number: 200 },
      { hex: '#86efac', number: 300 },
      { hex: '#4ade80', number: 400 },
      { hex: '#22c55e', number: 500 },
      { hex: '#16a34a', number: 600 },
      { hex: '#15803d', number: 700 },
      { hex: '#166534', number: 800 },
      { hex: '#14532d', number: 900 },
      { hex: '#052e16', number: 950 }
    ]
  },
  {
    name: 'Emerald',
    palettes: [
      { hex: '#ecfdf5', number: 50 },
      { hex: '#d1fae5', number: 100 },
      { hex: '#a7f3d0', number: 200 },
      { hex: '#6ee7b7', number: 300 },
      { hex: '#34d399', number: 400 },
      { hex: '#10b981', number: 500 },
      { hex: '#059669', number: 600 },
      { hex: '#047857', number: 700 },
      { hex: '#065f46', number: 800 },
      { hex: '#064e3b', number: 900 },
      { hex: '#022c22', number: 950 }
    ]
  },
  {
    name: 'Teal',
    palettes: [
      { hex: '#f0fdfa', number: 50 },
      { hex: '#ccfbf1', number: 100 },
      { hex: '#99f6e4', number: 200 },
      { hex: '#5eead4', number: 300 },
      { hex: '#2dd4bf', number: 400 },
      { hex: '#14b8a6', number: 500 },
      { hex: '#0d9488', number: 600 },
      { hex: '#0f766e', number: 700 },
      { hex: '#115e59', number: 800 },
      { hex: '#134e4a', number: 900 },
      { hex: '#042f2e', number: 950 }
    ]
  },
  {
    name: 'Cyan',
    palettes: [
      { hex: '#ecfeff', number: 50 },
      { hex: '#cffafe', number: 100 },
      { hex: '#a5f3fc', number: 200 },
      { hex: '#67e8f9', number: 300 },
      { hex: '#22d3ee', number: 400 },
      { hex: '#06b6d4', number: 500 },
      { hex: '#0891b2', number: 600 },
      { hex: '#0e7490', number: 700 },
      { hex: '#155e75', number: 800 },
      { hex: '#164e63', number: 900 },
      { hex: '#083344', number: 950 }
    ]
  },
  {
    name: 'Sky',
    palettes: [
      { hex: '#f0f9ff', number: 50 },
      { hex: '#e0f2fe', number: 100 },
      { hex: '#bae6fd', number: 200 },
      { hex: '#7dd3fc', number: 300 },
      { hex: '#38bdf8', number: 400 },
      { hex: '#0ea5e9', number: 500 },
      { hex: '#0284c7', number: 600 },
      { hex: '#0369a1', number: 700 },
      { hex: '#075985', number: 800 },
      { hex: '#0c4a6e', number: 900 },
      { hex: '#082f49', number: 950 }
    ]
  },
  {
    name: 'Blue',
    palettes: [
      { hex: '#eff6ff', number: 50 },
      { hex: '#dbeafe', number: 100 },
      { hex: '#bfdbfe', number: 200 },
      { hex: '#93c5fd', number: 300 },
      { hex: '#60a5fa', number: 400 },
      { hex: '#3b82f6', number: 500 },
      { hex: '#2563eb', number: 600 },
      { hex: '#1d4ed8', number: 700 },
      { hex: '#1e40af', number: 800 },
      { hex: '#1e3a8a', number: 900 },
      { hex: '#172554', number: 950 }
    ]
  }
];

function getNearestColorPaletteFamily(color: string, families: ColorPaletteFamily[]) {
  const familyWithConfig = families.map(family => {
    const palettes = family.palettes.map(palette => {
      return {
        ...palette,
        delta: getDeltaE(color, palette.hex)
      };
    });

    const nearestPalette = palettes.reduce((prev, curr) => (prev.delta < curr.delta ? prev : curr));

    return {
      ...family,
      palettes,
      nearestPalette
    };
  });

  const nearestPaletteFamily = familyWithConfig.reduce((prev, curr) =>
    prev.nearestPalette.delta < curr.nearestPalette.delta ? prev : curr
  );

  const { l } = getHsl(color);

  return {
    ...nearestPaletteFamily,
    nearestLightnessPalette: nearestPaletteFamily.palettes.reduce((prev, curr) => {
      const { l: prevLightness } = getHsl(prev.hex);
      const { l: currLightness } = getHsl(curr.hex);

      const deltaPrev = Math.abs(prevLightness - l);
      const deltaCurr = Math.abs(currLightness - l);

      return deltaPrev < deltaCurr ? prev : curr;
    })
  };
}

function getRecommendedColorPaletteFamily(color: string) {
  if (!isValidColor(color)) {
    throw new Error('Invalid color, please check color value!');
  }

  const { h: h1, s: s1 } = getHsl(color);

  const { nearestLightnessPalette, palettes } = getNearestColorPaletteFamily(color, recommendedColorPalettes);

  const { number, hex } = nearestLightnessPalette;

  const { h: h2, s: s2 } = getHsl(hex);

  const deltaH = h1 - h2;

  const sRatio = s1 / s2;

  const colorPaletteFamily: ColorPaletteFamily = {
    name: 'custom',
    palettes: palettes.map(palette => {
      let hexValue = color;

      const isSame = number === palette.number;

      if (!isSame) {
        const { h: h3, s: s3, l } = getHsl(palette.hex);

        const newH = deltaH < 0 ? h3 + deltaH : h3 - deltaH;
        const newS = s3 * sRatio;

        hexValue = transformHslToHex({
          h: newH,
          s: newS,
          l
        });
      }

      return {
        hex: hexValue,
        number: palette.number
      };
    })
  };

  return colorPaletteFamily;
}
