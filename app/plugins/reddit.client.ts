export default defineNuxtPlugin(() => {
  if (!useIsProd()) return

  const w = window as any
  if (!w.rdt) {
    w.rdt = function (...args: any[]) { w.rdt.sendEvent ? w.rdt.sendEvent.apply(w.rdt, args) : w.rdt.callQueue.push(args) }
    w.rdt.callQueue = []
  }

  const s = document.createElement('script')
  s.async = true
  s.src = 'https://www.redditstatic.com/ads/pixel.js'
  document.head.appendChild(s)

  w.rdt('init', 'a2_inkp2wvyvllm', { optOut: false, useDecimalCurrencyValues: true })
  w.rdt('track', 'PageVisit')
})
