export function usePricing() {
  // ── Pricing (change here, updates everywhere) ──
  // Free audit. You only pay a percentage of verified savings.
  const pricing = {
    minAws: 5000,        // We work best with $5K+/mo AWS spend
    overageRate: 500,    // Hourly rate for out-of-scope work
  }

  // ── Derived convenience values ──
  const minAwsK = `$${pricing.minAws / 1000}K`

  // ── Calendly link builder ──
  const calendly = (campaign: string) => `/book?c=${campaign}`

  return {
    pricing,
    minAwsK,
    calendly,
  }
}
