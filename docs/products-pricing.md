# Products & Pricing

## Products

Two separate products, purchased sequentially:

| Product | Fee | Deposit | What it is |
|---------|-----|---------|------------|
| **The Report** | 15% of annual savings found | 1% of AWS annual spend (deducted from fee) | Read-only audit, 5-10 business days. Deliverable: detailed report with every waste item, dollar amounts, root causes, and fixes. |
| **The Fix** | 60% of verified annual savings | 4% of AWS annual spend (deducted from fee) | Hands-on implementation of optimizations from The Report. Savings verified against actual bill after 90 days. No verified savings = no fee. |

- **The Fix requires The Report first** — they are separate engagements, not a bundle
- **Max total if both purchased:** 75% of annual savings (15% + 60%)
- **On the website:** `fixPct: 75` represents the combined max total, not The Fix alone
- **On AWS Marketplace:** listed as 2 separate pricing dimensions (15% and 60%)

## Pricing

All pricing is centralized in `app/pages/index.vue` in the `pricing` object:

```js
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
```

**Change pricing in ONE place** — the entire site updates automatically. All template references use `{{ pricing.* }}`.

### Pricing Flow

```
🗓️ INTRO CALL           Free (15 min)
        ↓
   1% deposit            (of AWS annual spend, deducted from report fee)
        ↓
   5-10 business days    (David audits the account)
        ↓
📋 EXPLORATION CALL      15% of annual savings found (minus deposit)
   │                     Client receives full report PDF
   │
   └─ Want implementation?
      │
      ├─ No → Done. Team implements from the report.
      │
      └─ Yes → Scope timeline, deliverables together
               ↓
         4% deposit      (of AWS annual spend, deducted from impl fee)
               ↓
         🔧 IMPLEMENTATION
               ↓
         ⏳ 90 DAYS LATER
               ↓
         📊 THE PROOF       +60% of VERIFIED REALIZED savings due
                            (minus deposit; no savings = $0 owed)

Max total: 75% (15% report + 60% implementation)
Note: Not all Report items may be implementable due to dependencies,
compliance, or third-party constraints. Fee is based only on realized savings.
```

### Example ($25K/mo AWS spend, 30% waste found)

| Phase | Amount |
|-------|-------:|
| Intro Call | Free |
| Report Deposit (1% of $300K annual) | $3,000 |
| Exploration Call (15% of $108K − deposit) | $13,200 |
| Implementation Deposit (4% of $300K annual) | $12,000 |
| 90 Days After Implementation (+60% − deposit) | $52,800 |
| **Total max (75%)** | **$81,000** |
| **Client keeps year 1** | **$27,000** |
| **Client keeps every year after** | **$108,000** |

## AWS Marketplace

**Product:** Cut My AWS (Professional Services)
**SKU:** CUTMYAWS
**Request ID:** emaf2gb7q6v8o68eew59bshu2
**Submitted:** 2026-03-12
**Status:** Created (seller preview only — not public until tax/bank/KYC completed)
**Listing URL:** https://aws.amazon.com/marketplace/pp/prodview-a33byl4vxcau2
**Account:** 731039145080 (Cut My AWS)

### Marketplace Pricing Dimensions

| Dimension | Fee | API Identifier |
|-----------|-----|----------------|
| The Report - AWS Cost Audit & Optimization Plan | 15% of annual savings | `TheReportAWSCostAuditOptimizationPlan` |
| The Fix - Hands-On Implementation | 60% of verified annual savings | `TheFixHandsOnImplementation` |

**Categories:** Assessments, Implementation, Cloud Financial Management
**Product logo:** `public/marketplace-product-logo.png` (400x400, `/tmp/marketplace-product-logo.html`)

### How Marketplace Pricing Works

Actual dollar amounts are set per client via **private offers**. The dimensions are line items on the contract. When David closes a deal:
1. Calculate the client's savings
2. Create a private offer with the specific dollar amount for whichever dimension(s) apply
3. Client accepts through AWS Marketplace
4. Payment processed through AWS (2.5% Marketplace fee)

### Marketplace vs Website Pricing

| | Website | AWS Marketplace |
|--|---------|-----------------|
| The Report | 15% | 15% (separate dimension) |
| The Fix | 75% total max (report + impl bundled) | 60% (implementation only, separate dimension) |
| Combined | 75% max | 15% + 60% = 75% max |

Same math, different packaging. Website shows 75% as the all-in max. Marketplace splits them because they're separate purchases.
