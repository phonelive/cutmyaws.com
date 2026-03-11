export default defineNuxtPlugin(() => {
  const w = window as any
  w._linkedin_partner_id = '8785714'
  w._linkedin_data_partner_ids = w._linkedin_data_partner_ids || []
  w._linkedin_data_partner_ids.push(w._linkedin_partner_id)

  if (!w.lintrk) {
    w.lintrk = (a: any, b: any) => { w.lintrk.q.push([a, b]) }
    w.lintrk.q = []
  }

  const s = document.createElement('script')
  s.async = true
  s.src = 'https://snap.licdn.com/li.lms-analytics/insight.min.js'
  document.head.appendChild(s)

  // Track Calendly link clicks as conversions
  document.addEventListener('click', (e) => {
    const link = (e.target as HTMLElement).closest('a[href*="calendly.com"]')
    if (link) {
      w.lintrk('track', { conversion_id: 26412858 })
    }
  })
})
