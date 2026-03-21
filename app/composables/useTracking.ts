export function useTracking() {
  function trackEvent(name: string, opts: { event_category?: string, event_label?: string, linkedin_conversion_id?: number, reddit_event?: string } = {}) {
    if (!useIsProd()) return

    const w = window as any
    // GA4
    if (w.dataLayer) {
      function gtag(..._a: any[]) { w.dataLayer.push(arguments) }
      gtag('event', name, { event_category: opts.event_category || 'engagement', event_label: opts.event_label || '' })
    }
    // Bing UET
    if (w.uetq) w.uetq.push('event', name, { event_category: opts.event_category || 'engagement', event_label: opts.event_label || '' })
    // LinkedIn
    if (opts.linkedin_conversion_id && w.lintrk) w.lintrk('track', { conversion_id: opts.linkedin_conversion_id })
    // Reddit
    if (opts.reddit_event && w.rdt) w.rdt('track', opts.reddit_event)
  }
  return { trackEvent }
}
