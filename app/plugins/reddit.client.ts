export default defineNuxtPlugin(() => {
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

  // Link clicks are engagement only — real Lead conversion fires on /confirmed with name
  // (Reddit Lead tracked via useTracking in confirmed.vue)
})
