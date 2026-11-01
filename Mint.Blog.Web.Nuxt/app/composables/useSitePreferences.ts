const defaultPrimaryColor = '#ee2b7f'
const defaultFooterVisible = true

export function useSitePreferences() {
  const themeCookie = useCookie<string>('mint-theme', { default: () => 'system', sameSite: 'lax', path: '/', maxAge: 31536000 })
  const localeCookie = useCookie<string>('mint-locale', { default: () => 'zh', sameSite: 'lax', path: '/', maxAge: 31536000 })
  const primaryColorCookie = useCookie<string>('mint-primary', { default: () => defaultPrimaryColor, sameSite: 'lax', path: '/', maxAge: 31536000 })
  const footerVisibleCookie = useCookie<boolean>('mint-footer', { default: () => defaultFooterVisible, sameSite: 'lax', path: '/', maxAge: 31536000 })
  const normalizePrimaryColor = (value: unknown) => typeof value === 'string' && /^#[0-9a-f]{6}$/i.test(value) ? value.toLowerCase() : defaultPrimaryColor
  const normalizeFooterVisible = (value: unknown) => value === true || value === false ? value : defaultFooterVisible
  const primaryColor = computed({
    get: () => normalizePrimaryColor(primaryColorCookie.value),
    set: (value: string) => { primaryColorCookie.value = normalizePrimaryColor(value) }
  })
  const footerVisible = computed({
    get: () => normalizeFooterVisible(footerVisibleCookie.value),
    set: (value: boolean) => { footerVisibleCookie.value = normalizeFooterVisible(value) }
  })
  function resetPrimaryColorAndFooter() {
    primaryColor.value = defaultPrimaryColor
    footerVisible.value = defaultFooterVisible
  }
  const theme = computed({
    get: () => ['light', 'dark', 'system'].includes(themeCookie.value) ? themeCookie.value : 'system',
    set: (value: string) => { themeCookie.value = value }
  })
  const locale = computed({ get: () => localeCookie.value === 'en' ? 'en' : 'zh', set: (value: string) => { localeCookie.value = value } })
  const systemDark = useState('system-dark', () => false)
  const isDark = computed(() => theme.value === 'dark' || (theme.value === 'system' && systemDark.value))
  return { theme, locale, primaryColor, footerVisible, resetPrimaryColorAndFooter, isDark, systemDark, text: (zh: string, en: string) => locale.value === 'zh' ? zh : en }
}
