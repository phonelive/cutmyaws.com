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
})
