export function usePricing() {
  // ── Pricing (change here, updates everywhere) ──
  const pricing = {
    depositPct: 1,       // Down payment: 1% of AWS annual spend to start (The Report)
    fixDepositPct: 4,    // Down payment: 4% of AWS annual spend to start (The Fix)
    reportPct: 15,       // The Report: 15% of annual savings (deposit deducted)
    implPct: 60,         // Implementation portion
    fixPct: 75,          // The Fix: 75% total (15% report + 60% implementation)
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
  function calculateExample(monthlySpend: number, wastePct: number) {
    const monthlySavings = Math.round(monthlySpend * wastePct / 100)
    const annualSavings = monthlySavings * 12
    const awsAnnual = monthlySpend * 12
    const depositFee = Math.round(awsAnnual * pricing.depositPct / 100)
    const reportFee = Math.round(annualSavings * pricing.reportPct / 100)
    const reportRemainder = reportFee - depositFee
    const fixDepositFee = Math.round(awsAnnual * pricing.fixDepositPct / 100)
    const fixFee = Math.round(annualSavings * pricing.fixPct / 100)
    const reportNet = annualSavings - reportFee
    const fixNet = annualSavings - fixFee
    const monthsToRoi = monthlySavings > 0 ? Math.ceil(fixFee / monthlySavings) : 0
    const threeYearNet = (annualSavings * 3) - fixFee
    const fiveYearSavings = annualSavings * 5
    const fiveYearNet = fiveYearSavings - fixFee

    return {
      monthlySavings,
      annualSavings,
      awsAnnual,
      depositFee,
      reportFee,
      reportRemainder,
      fixDepositFee,
      fixFee,
      reportNet,
      fixNet,
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
