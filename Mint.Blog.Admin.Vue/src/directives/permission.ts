import type { App, Directive, DirectiveBinding } from 'vue';

import { useAuthStore } from '@/stores/auth';

const placeholderMap = new WeakMap<HTMLElement, Comment>();

export const vPermission: Directive = {
  mounted(el: HTMLElement, binding: DirectiveBinding) {
    checkPermission(el, binding);
  },
  updated(el: HTMLElement, binding: DirectiveBinding) {
    checkPermission(el, binding);
  },
};

function checkPermission(el: HTMLElement, binding: DirectiveBinding) {
  const { value, modifiers } = binding;
  const authStore = useAuthStore();

  if (!value) {
    throw new Error('Permission value is required. Usage: v-permission="\'user.create\'"');
  }

  const permissions = Array.isArray(value) ? value : [value];
  let hasPermission = false;

  if (modifiers.all) {
    hasPermission = permissions.every((perm) => authStore.hasPermission(perm));
  } else {
    hasPermission = permissions.some((perm) => authStore.hasPermission(perm));
  }

  if (!hasPermission) {
    const placeholder = placeholderMap.get(el) ?? document.createComment('v-permission');

    if (el.parentNode && !placeholderMap.has(el)) {
      placeholderMap.set(el, placeholder);
      el.parentNode.replaceChild(placeholder, el);
    }
  } else {
    const placeholder = placeholderMap.get(el);
    if (placeholder?.parentNode) {
      placeholder.parentNode.replaceChild(el, placeholder);
      placeholderMap.delete(el);
    }
  }
}

export function setupPermissionDirective(app: App) {
  app.directive('permission', vPermission);
}

export default vPermission;
