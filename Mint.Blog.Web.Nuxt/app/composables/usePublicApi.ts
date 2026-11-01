export function usePublicApi() {
  return <T>(path: string, options: { method?: 'GET' | 'POST' | 'PUT' | 'DELETE'; query?: Record<string, string | number>; body?: Record<string, unknown>; retry?: false } = {}) => {
    if (!path || path.split('/').some(part => !/^[a-zA-Z0-9_-]+$/.test(part))) throw new Error('Invalid public API path')
    return $fetch<T>(`/api/surfer/${path}`, { ...options, credentials: 'omit' })
  }
}
