export function usePricing() {
  // ── Pricing (change here, updates everywhere) ──
  // Free audit. You only pay when David fixes it.
  const pricing = {
    depositPct: 4,       // Down payment: 4% of AWS annual spend to start implementation (after free audit)
    fixedPct: 75,        // 75% of annualized savings David finds AND fixes
    securityPct: 10,     // Security Audit: 10% of AWS annual spend (free during promo)
    minAws: 5000,        // We work best with $5K+/mo AWS spend
    overageRate: 500,    // Hourly rate for out-of-scope work
  }

  // ── Promo: free security scan ──
  const promoEnd = new Date('2026-04-04T23:59:59')
  const now = new Date()
  const promoActive = now < promoEnd
  const promoDaysLeft = Math.max(0, Math.ceil((promoEnd.getTime() - now.getTime()) / (1000 * 60 * 60 * 24)))
  const securityPct = pricing.securityPct

  // ── Derived convenience values ──
  const minAwsK = `$${pricing.minAws / 1000}K`

  // ── Calendly link builder ──
  const calendly = (campaign: string) => `/book?c=${campaign}`

  // ── Example / calculator helper ──
  // Assumes all savings get fixed (75% fee). You only pay on what David fixes.
  function calculateExample(monthlySpend: number, wastePct: number) {
    const monthlySavings = Math.round(monthlySpend * wastePct / 100)
    const annualSavings = monthlySavings * 12
    const awsAnnual = monthlySpend * 12
    const depositFee = Math.round(awsAnnual * pricing.depositPct / 100)
    const totalFee = Math.round(annualSavings * pricing.fixedPct / 100)
    const feeAfterDeposit = totalFee - depositFee
    const yearOneNet = annualSavings - totalFee
    const monthsToRoi = monthlySavings > 0 ? Math.ceil(totalFee / monthlySavings) : 0
    const threeYearNet = (annualSavings * 3) - totalFee
    const fiveYearSavings = annualSavings * 5
    const fiveYearNet = fiveYearSavings - totalFee

    return {
      monthlySavings,
      annualSavings,
      awsAnnual,
      depositFee,
      totalFee,
      feeAfterDeposit,
      yearOneNet,
      monthsToRoi,
      threeYearNet,
      fiveYearSavings,
      fiveYearNet,
    }
  }

  return {
    pricing,
    promoEnd,
    promoActive,
    promoDaysLeft,
    securityPct,
    minAwsK,
    calendly,
    calculateExample,
  }
}
