import { createError, defineEventHandler, getHeader, getMethod, readRawBody, setHeader, setResponseStatus } from 'h3'
import { useRuntimeConfig } from 'nitropack/runtime'

export default defineEventHandler(async event => {
  setHeader(event, 'cache-control', 'no-store')
  const rawPath = (event.node.req.url || '').split('?')[0] || ''
  let decoded: string
  try { decoded = decodeURIComponent(rawPath) } catch { throw createError({ statusCode: 400, statusMessage: 'Invalid public API path' }) }
  const prefix = '/api/surfer/'
  const suffix = decoded.startsWith(prefix) ? decoded.slice(prefix.length) : ''
  if (!suffix || suffix.split('/').some(part => !/^[a-zA-Z0-9_-]+$/.test(part))) {
    throw createError({ statusCode: 400, statusMessage: 'Invalid public API path' })
  }
  const base = useRuntimeConfig(event).apiBase.replace(/\/$/, '')
  const url = new URL(`${base}/surfer/${suffix}`)
  const search = (event.node.req.url || '').indexOf('?')
  if (search >= 0) url.search = (event.node.req.url || '').slice(search)
  const method = getMethod(event)
  const contentType = getHeader(event, 'content-type')
  const body = ['GET', 'HEAD'].includes(method) ? undefined : await readRawBody(event, false)
  const controller = new AbortController()
  const timeout = setTimeout(() => controller.abort(), 15_000)
  try {
    const response = await fetch(url, {
      method,
      headers: contentType ? { 'content-type': contentType } : {},
      body: body as BodyInit | undefined,
      redirect: 'manual',
      signal: controller.signal
    })
    const responseBody = new Uint8Array(await response.arrayBuffer())
    setResponseStatus(event, response.status, response.statusText)
    const responseType = response.headers.get('content-type')
    if (responseType) setHeader(event, 'content-type', responseType)
    return responseBody
  } catch {
    throw createError({ statusCode: 502, statusMessage: 'Public API unavailable' })
  } finally {
    clearTimeout(timeout)
  }
})
