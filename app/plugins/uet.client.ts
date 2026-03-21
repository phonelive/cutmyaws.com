export default defineNuxtPlugin(() => {
  if (!useIsProd()) return

  const w = window as any
  w.uetq = w.uetq || []

  const s = document.createElement('script')
  s.async = true
  s.src = '//bat.bing.com/bat.js'
  s.onload = () => {
    const uet = new (w as any).UET({
      ti: '343238663',
      enableAutoSpaTracking: true,
    })
    uet.push('pageLoad')
    w.uetq = uet
  }
  document.head.appendChild(s)

  // Track CTA link clicks as engagement
  document.addEventListener('click', (e) => {
    const link = (e.target as HTMLElement).closest('a[href*="/book"], a[href*="#book"]')
    if (link) {
      w.uetq.push('event', 'cta_click', {
        event_category: 'engagement',
        event_label: link.getAttribute('href'),
      })
    }
  })
})
