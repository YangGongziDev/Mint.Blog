export interface SiteSettings {
  name: string
  author: string
  introduction: string
  copyrightDeclaration: string
  logo: string
  avatar: string
  githubHomepage?: string
  giteeHomepage?: string
  csdnHomepage?: string
  douyinHomepage?: string
}

export function useSiteSettings() {
  const api = usePublicApi()
  return useAsyncData('public-site-settings', async () => {
    const result = await api<{ success: boolean; data: SiteSettings }>('setting', { retry: false })
    if (!result.success || !result.data) throw new Error('Public settings unavailable')
    return result.data
  })
}

export function useAssetUrl() {
  const base = useRuntimeConfig().public.assetBaseUrl
  return (path?: string) => {
    if (!path) return undefined
    try {
      const url = new URL(path, base)
      return ['http:', 'https:'].includes(url.protocol) ? url.href : undefined
    } catch { return undefined }
  }
}
