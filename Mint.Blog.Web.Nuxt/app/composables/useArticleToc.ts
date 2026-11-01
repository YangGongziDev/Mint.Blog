export function useArticleToc(activeHeading: Ref<string>) {
  const desktopOpen = ref(true)
  const mobileOpen = ref(false)
  const isMobile = ref(false)
  const tocOpen = computed(() => isMobile.value ? mobileOpen.value : desktopOpen.value)
  const tocElement = ref<HTMLElement>()
  let restoreScroll: (() => void) | undefined

  function followActiveHeading() {
    const container = tocElement.value?.querySelector<HTMLElement>('.toc-wrapper')
    const active = container?.querySelector<HTMLElement>('[aria-current]')
    if (!container || !active || !container.clientHeight) return
    const bounds = container.getBoundingClientRect()
    const item = active.getBoundingClientRect()
    if (item.top < bounds.top || item.bottom > bounds.top + container.clientHeight) {
      container.scrollTo({ top: container.scrollTop + item.top - bounds.top - (container.clientHeight - item.height) / 2, behavior: 'instant' })
    }
  }
  watch([activeHeading, desktopOpen, isMobile, tocElement], () => {
    if (!isMobile.value && desktopOpen.value) followActiveHeading()
  }, { flush: 'post' })

  function lockScroll() {
    if (restoreScroll) return
    const { scrollX, scrollY } = window
    const body = document.body
    const { position, top, left, width } = body.style
    body.style.position = 'fixed'
    body.style.top = `-${scrollY}px`
    body.style.left = `-${scrollX}px`
    body.style.width = '100%'
    restoreScroll = () => {
      Object.assign(body.style, { position, top, left, width })
      window.scrollTo({ left: scrollX, top: scrollY, behavior: 'instant' })
      restoreScroll = undefined
    }
  }
  function resize() {
    isMobile.value = window.innerWidth < 768
    if (!isMobile.value) closeMobileToc()
  }
  function closeMobileToc() {
    if (tocElement.value instanceof HTMLDialogElement) tocElement.value.close()
    mobileOpen.value = false
    restoreScroll?.()
  }
  function syncMobileToc() {
    if (tocElement.value instanceof HTMLDialogElement && !tocElement.value.open) closeMobileToc()
  }
  function isBackdrop(event: MouseEvent | TouchEvent) {
    const dialog = tocElement.value
    if (!(dialog instanceof HTMLDialogElement) || event.target !== dialog) return false
    const point = 'touches' in event ? event.touches[0] : event
    if (!point) return false
    const bounds = dialog.getBoundingClientRect()
    return point.clientX < bounds.left || point.clientX > bounds.right || point.clientY < bounds.top || point.clientY > bounds.bottom
  }
  function backdropClick(event: MouseEvent) {
    if (isBackdrop(event)) closeMobileToc()
  }
  function preventBackdropScroll(event: WheelEvent | TouchEvent) {
    if (isBackdrop(event)) event.preventDefault()
  }
  function toggleToc() {
    if (!tocElement.value) return
    if (isMobile.value) mobileOpen.value = !mobileOpen.value
    else desktopOpen.value = !desktopOpen.value
    if (tocOpen.value) void nextTick(() => {
      if (!isMobile.value) return followActiveHeading()
      const container = tocElement.value?.querySelector<HTMLElement>('.toc-wrapper')
      const active = container?.querySelector<HTMLElement>('[aria-current]')
      if (container && active) container.scrollTop += active.getBoundingClientRect().top - container.getBoundingClientRect().top - container.clientHeight / 2
    })
  }
  watch([mobileOpen, tocElement], (_, __, onCleanup) => {
    const dialog = tocElement.value
    if (!(dialog instanceof HTMLDialogElement)) return
    if (mobileOpen.value) {
      lockScroll()
      if (!dialog.open) dialog.showModal()
      dialog.addEventListener('touchmove', preventBackdropScroll, { passive: false })
      dialog.addEventListener('wheel', preventBackdropScroll, { passive: false })
      onCleanup(() => {
        dialog.removeEventListener('touchmove', preventBackdropScroll)
        dialog.removeEventListener('wheel', preventBackdropScroll)
      })
    }
    else closeMobileToc()
  }, { flush: 'post' })
  onMounted(() => {
    resize()
    window.addEventListener('resize', resize)
    window.addEventListener('blog-surfer:toggle-toc', toggleToc)
  })
  onBeforeUnmount(() => {
    closeMobileToc()
    window.removeEventListener('resize', resize)
    window.removeEventListener('blog-surfer:toggle-toc', toggleToc)
  })
  return { tocOpen, desktopOpen, isMobile, tocElement, toggleToc, closeMobileToc, syncMobileToc, backdropClick }
}
