export default defineNuxtPlugin(() => {
  const w = window as any
  w.clarity = w.clarity || function (...args: any[]) {
    (w.clarity.q = w.clarity.q || []).push(args)
  }
  const s = document.createElement('script')
  s.async = true
  s.src = 'https://www.clarity.ms/tag/vr2el2utus'
  document.head.appendChild(s)
})
