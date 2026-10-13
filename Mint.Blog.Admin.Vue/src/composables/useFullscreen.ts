import { ref, onMounted, onUnmounted } from 'vue';

interface FullscreenElement extends HTMLElement {
  webkitRequestFullscreen?: () => Promise<void>;
  mozRequestFullScreen?: () => Promise<void>;
  msRequestFullscreen?: () => Promise<void>;
}

interface FullscreenDocument extends Document {
  webkitExitFullscreen?: () => Promise<void>;
  mozCancelFullScreen?: () => Promise<void>;
  msExitFullscreen?: () => Promise<void>;
  webkitFullscreenElement?: Element | null;
  mozFullScreenElement?: Element | null;
  msFullscreenElement?: Element | null;
}

/**
 * Fullscreen composable
 */
export function useFullscreen() {
  const isFullscreen = ref(false);

  /**
   * Enter fullscreen
   */
  const enter = async (): Promise<void> => {
    try {
      const element = document.documentElement as FullscreenElement;

      if (element.requestFullscreen) {
        await element.requestFullscreen();
      } else if (element.webkitRequestFullscreen) {
        await element.webkitRequestFullscreen();
      } else if (element.mozRequestFullScreen) {
        await element.mozRequestFullScreen();
      } else if (element.msRequestFullscreen) {
        await element.msRequestFullscreen();
      }

      isFullscreen.value = true;
    } catch (error) {
      console.error('Failed to enter fullscreen:', error);
    }
  };

  /**
   * Exit fullscreen
   */
  const exit = async (): Promise<void> => {
    try {
      const doc = document as FullscreenDocument;
      if (document.exitFullscreen) {
        await document.exitFullscreen();
      } else if (doc.webkitExitFullscreen) {
        await doc.webkitExitFullscreen();
      } else if (doc.mozCancelFullScreen) {
        await doc.mozCancelFullScreen();
      } else if (doc.msExitFullscreen) {
        await doc.msExitFullscreen();
      }

      isFullscreen.value = false;
    } catch (error) {
      console.error('Failed to exit fullscreen:', error);
    }
  };

  /**
   * Toggle fullscreen
   */
  const toggle = async (): Promise<void> => {
    if (isFullscreen.value) {
      await exit();
    } else {
      await enter();
    }
  };

  /**
   * Handle fullscreen change event
   */
  const handleFullscreenChange = () => {
    const doc = document as FullscreenDocument;
    isFullscreen.value = !!(
      document.fullscreenElement ||
      doc.webkitFullscreenElement ||
      doc.mozFullScreenElement ||
      doc.msFullscreenElement
    );
  };

  onMounted(() => {
    // Listen to fullscreen change events
    document.addEventListener('fullscreenchange', handleFullscreenChange);
    document.addEventListener('webkitfullscreenchange', handleFullscreenChange);
    document.addEventListener('mozfullscreenchange', handleFullscreenChange);
    document.addEventListener('MSFullscreenChange', handleFullscreenChange);

    // Check initial state
    handleFullscreenChange();
  });

  onUnmounted(() => {
    // Remove event listeners
    document.removeEventListener('fullscreenchange', handleFullscreenChange);
    document.removeEventListener('webkitfullscreenchange', handleFullscreenChange);
    document.removeEventListener('mozfullscreenchange', handleFullscreenChange);
    document.removeEventListener('MSFullscreenChange', handleFullscreenChange);
  });

  return {
    isFullscreen,
    enter,
    exit,
    toggle,
  };
}
