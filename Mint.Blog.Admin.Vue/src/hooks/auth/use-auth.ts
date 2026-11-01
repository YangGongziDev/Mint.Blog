import { computed } from 'vue';
import { useAuthStore } from '@/store/system/auth';

export function useAuth() {
  const authStore = useAuthStore();

  function hasAuth(codes: string | string[]) {
    if (!authStore.isLogin) {
      return false;
    }

    if (authStore.userInfo.buttons.includes('*')) return true;

    if (typeof codes === 'string') {
      return authStore.userInfo.buttons.includes(codes);
    }

    return codes.some(code => authStore.userInfo.buttons.includes(code));
  }

  return {
    hasAuth,
    isReadonly: computed(() => authStore.isReadonly),
    isReadonlyVisitor: computed(() => authStore.isReadonlyVisitor)
  };
}
