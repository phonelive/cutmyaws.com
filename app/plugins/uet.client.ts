export default defineNuxtPlugin(() => {
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

  // Track Calendly link clicks as conversions
  document.addEventListener('click', (e) => {
    const link = (e.target as HTMLElement).closest('a[href*="/book"], a[href*="calendly.com"]')
    if (link) {
      w.uetq.push('event', 'calendly_click', {
        event_category: 'conversion',
        event_label: link.getAttribute('href'),
      })
    }
  })
})
