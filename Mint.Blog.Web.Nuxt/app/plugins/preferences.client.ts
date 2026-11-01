export default defineNuxtPlugin(() => {
  const { systemDark } = useSitePreferences()
  const media = window.matchMedia('(prefers-color-scheme: dark)')
  const update = () => { systemDark.value = media.matches }
  update()
  media.addEventListener('change', update)
})
