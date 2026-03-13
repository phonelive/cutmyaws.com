export default defineNuxtPlugin(() => {
  const w = window as any
  const s = document.createElement('script')
  s.async = true
  s.src = 'https://www.googletagmanager.com/gtag/js?id=G-ZGPX081LFE'
  document.head.appendChild(s)

  w.dataLayer = w.dataLayer || []
  function gtag(...args: any[]) { w.dataLayer.push(arguments) }
  gtag('js', new Date())
  gtag('config', 'G-ZGPX081LFE')
  gtag('config', 'GT-K8KHLNZJ')

  // Track Calendly link clicks as engagement (not conversion — conversion fires on /confirmed with name)
  document.addEventListener('click', (e) => {
    const link = (e.target as HTMLElement).closest('a[href*="/book"], a[href*="calendly.com"]')
    if (link) {
      gtag('event', 'cta_click', {
        event_category: 'engagement',
        event_label: link.getAttribute('href')
      })
    }
  })
})
