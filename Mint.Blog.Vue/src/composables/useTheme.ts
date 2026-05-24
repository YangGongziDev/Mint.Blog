import { ref } from 'vue';
import { useDark, useToggle } from '@vueuse/core';

export function useTheme() {
  const darkSwitch = ref(false);

  const isDark = useDark({
    selector: 'html',
    attribute: 'class',
    valueDark: 'dark',
    valueLight: '',
    onChanged(dark: boolean) {
      darkSwitch.value = dark;
      if (dark) {
        document.documentElement.classList.add('dark');
      } else {
        document.documentElement.classList.remove('dark');
      }
    },
  });

  const toggleDark = useToggle(isDark);

  return { isDark, darkSwitch, toggleDark };
}
