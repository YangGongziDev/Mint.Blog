import { computed, nextTick, ref } from 'vue';

type UseBannerImageOptions = {
  images: string[];
  fallbackImage: string;
  storageNamespace: string;
};

export function useBannerImage(options: UseBannerImageOptions) {
  const images = options.images.filter(Boolean);
  const image = ref('');
  const imageKey = ref(0);
  const resolved = ref(false);
  const imageSrc = computed(() => (resolved.value ? image.value || options.fallbackImage : ''));
  const backgroundStyle = computed(() =>
    resolved.value ? { backgroundImage: `url(${image.value || options.fallbackImage})` } : {}
  );
  const lastImageKey = `${options.storageNamespace}:last-image`;
  const confirmedImageKey = `${options.storageNamespace}:last-confirmed-image`;
  let preloadStopped = false;
  let preloadStarted = false;
  let preloadTimer: ReturnType<typeof setTimeout> | null = null;
  let idleCallbackId: number | null = null;
  let animationFrameId: number | null = null;

  function readSessionImage(storageKey: string, allowedImages?: string[]) {
    try {
      const storedImage = window.sessionStorage.getItem(storageKey) || '';
      return !allowedImages || allowedImages.includes(storedImage) ? storedImage : '';
    } catch {
      return '';
    }
  }

  function writeSessionImage(storageKey: string, nextImage?: string) {
    try {
      if (nextImage) window.sessionStorage.setItem(storageKey, nextImage);
      else window.sessionStorage.removeItem(storageKey);
    } catch {
      // Storage may be unavailable in Safari private/privacy modes.
    }
  }

  function setImage(nextImage: string) {
    if (image.value === nextImage) return;
    image.value = nextImage;
    imageKey.value += 1;
  }

  function pickRandomImage(availableImages: string[]) {
    const lastImage = readSessionImage(lastImageKey);
    const candidates =
      availableImages.length > 1
        ? availableImages.filter(item => item !== lastImage && item !== image.value)
        : availableImages;
    const pool = candidates.length ? candidates : availableImages.filter(item => item !== image.value);
    const nextPool = pool.length ? pool : availableImages;

    return nextPool[Math.floor(Math.random() * nextPool.length)];
  }

  async function ensureImageReady(src: string, timeoutMs = 10000) {
    if (!src) return false;

    return new Promise<boolean>(resolve => {
      const imageElement = new Image();
      let settled = false;
      let timeoutId = 0;

      const finish = (ready: boolean) => {
        if (settled) return;
        settled = true;
        window.clearTimeout(timeoutId);
        resolve(ready);
      };

      timeoutId = window.setTimeout(() => finish(false), timeoutMs);
      imageElement.onload = () => {
        if (typeof imageElement.decode === 'function') {
          imageElement
            .decode()
            .then(() => finish(true))
            .catch(() => finish(true));
          return;
        }
        finish(true);
      };
      imageElement.onerror = () => finish(false);
      imageElement.src = src;

      if (imageElement.complete) finish(imageElement.naturalWidth > 0);
    });
  }

  async function pickImage(forceChange = false) {
    const availableImages = images.filter(item => item !== options.fallbackImage);

    if (!availableImages.length) {
      setImage('');
      writeSessionImage(confirmedImageKey);
      return;
    }

    if (!forceChange && image.value && availableImages.includes(image.value)) return;

    const confirmedImage = readSessionImage(confirmedImageKey, availableImages);
    const firstImage = pickRandomImage(availableImages);
    const remainingImages = availableImages
      .filter(item => item !== firstImage && item !== confirmedImage)
      .sort(() => Math.random() - 0.5);
    const candidates = [firstImage, confirmedImage, ...remainingImages].filter(Boolean);

    async function findReadyImage(index = 0): Promise<string> {
      const candidate = candidates[index];
      if (!candidate) return '';
      if (await ensureImageReady(candidate)) return candidate;
      return findReadyImage(index + 1);
    }

    const readyImage = await findReadyImage();
    if (readyImage) {
      setImage(readyImage);
      writeSessionImage(confirmedImageKey, readyImage);
      writeSessionImage(lastImageKey, readyImage);
      return;
    }

    setImage('');
    writeSessionImage(confirmedImageKey);
  }

  async function resolveInitialImage() {
    resolved.value = false;

    try {
      await pickImage();
    } finally {
      resolved.value = true;
    }
  }

  async function preloadImage(src: string) {
    return ensureImageReady(src);
  }

  function runWhenIdle(callback: () => void) {
    if ('requestIdleCallback' in window) {
      idleCallbackId = window.requestIdleCallback(callback, { timeout: 8000 });
      return;
    }
    preloadTimer = setTimeout(callback, 5000);
  }

  function startPreload() {
    if (preloadStarted || preloadStopped) return;
    preloadStarted = true;
    const preloadImages = images.filter(item => item !== options.fallbackImage);
    let index = 0;

    const runBatch = async () => {
      idleCallbackId = null;
      preloadTimer = null;
      if (preloadStopped) return;

      const batch = preloadImages.slice(index, index + 2);
      index += 2;
      await Promise.all(batch.map(preloadImage));
      if (!preloadStopped && index < preloadImages.length) runWhenIdle(runBatch);
    };

    if (preloadImages.length) runWhenIdle(runBatch);
  }

  async function schedulePreloadAfterRender() {
    await nextTick();
    if (preloadStopped || preloadStarted) return;
    animationFrameId = window.requestAnimationFrame(() => {
      animationFrameId = null;
      startPreload();
    });
  }

  function stopPreload() {
    preloadStopped = true;
    if (preloadTimer) clearTimeout(preloadTimer);
    if (idleCallbackId !== null && 'cancelIdleCallback' in window) window.cancelIdleCallback(idleCallbackId);
    if (animationFrameId !== null) window.cancelAnimationFrame(animationFrameId);
    preloadTimer = null;
    idleCallbackId = null;
    animationFrameId = null;
  }

  return {
    image,
    imageKey,
    resolved,
    imageSrc,
    backgroundStyle,
    resolveInitialImage,
    pickImage,
    schedulePreloadAfterRender,
    stopPreload
  };
}
