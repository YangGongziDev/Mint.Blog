import { createError, defineEventHandler, setHeader, setResponseStatus } from 'h3'
import { useRuntimeConfig } from 'nitropack/runtime'

export default defineEventHandler(async event => {
  setHeader(event, 'cache-control', 'no-store')
  const base = useRuntimeConfig(event).apiBase.replace(/\/$/, '')
  const controller = new AbortController()
  const timeout = setTimeout(() => controller.abort(), 15_000)
  try {
    const response = await fetch(`${base}/rss`, {
      method: 'GET',
      redirect: 'manual',
      signal: controller.signal
    })
    const body = new Uint8Array(await response.arrayBuffer())
    setResponseStatus(event, response.status, response.statusText)
    const contentType = response.headers.get('content-type')
    if (contentType) setHeader(event, 'content-type', contentType)
    return body
  } catch {
    throw createError({ statusCode: 502, statusMessage: 'RSS unavailable' })
  } finally {
    clearTimeout(timeout)
  }
})
