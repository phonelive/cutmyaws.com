# Pricing — One Product

## The Offering

One engagement covers everything: audit, implementation, and verification.

| | Fee |
|--|-----|
| **Savings found AND fixed** | 75% of annualized savings |
| **Savings found but NOT fixed** | 15% of annualized savings |
| **Deposit to start** | 4% of annualized AWS spend (deducted from total fee) |
| **No savings** | No fee |

- One product, not two — audit + implementation bundled together
- No separate "report" fee — the audit is included in the engagement
- Fee due 90 days after implementation, based on verified savings only
- Not all findings may be fixable (dependencies, compliance, constraints) — unfixed items are only 15%

## Pricing

All pricing is centralized in `app/composables/usePricing.ts`:

```js
const pricing = {
  depositPct: 4,       // Down payment: 4% of AWS annual spend to start
  fixedPct: 75,        // 75% of annualized savings found AND fixed
  unfixedPct: 15,      // 15% of annualized savings found but NOT fixed
  securityPct: 10,     // Security Audit: 10% of AWS annual spend (free during promo)
  minAws: 5000,        // We work best with $5K+/mo AWS spend
  overageRate: 500,    // Hourly rate for out-of-scope work
}
```

**Change pricing in ONE place** — the entire site updates automatically. All template references use `{{ pricing.* }}`.

### Pricing Flow

```
🗓️ FREE CHAT             Free (15 min)
        ↓
   4% deposit            (of AWS annual spend, deducted from total fee)
        ↓
   5-10 business days    (David audits the account)
        ↓
📋 FINDINGS CALL          45 min — walk through every finding + full PDF
   │                      No separate fee — included in the engagement
   │
   └─ David implements everything he can
               ↓
         🔧 IMPLEMENTATION
               ↓
         ⏳ 90 DAYS LATER
               ↓
         📊 THE PROOF       75% of VERIFIED savings I fixed
                            15% of savings I found but didn't fix
                            (minus deposit; no savings = $0 owed)
```

### Example ($25K/mo AWS spend, 36% waste found, all savings fixed)

| Phase | Amount |
|-------|-------:|
| Free Chat | Free |
| Deposit (4% of $300K annual) | $12,000 |
| Findings Call + Report | $0 (included) |
| Implementation | $0 (during) |
| 90 Days After Implementation (75% of $108K − deposit) | $69,000 |
| **Total (75%)** | **$81,000** |
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
| AWS Cost Audit & Implementation - Fixed Savings | 75% of verified annual savings | `AWSCostAuditImplementationFixedSavings` |
| AWS Cost Audit & Implementation - Unfixed Savings | 15% of identified annual savings | `AWSCostAuditImplementationUnfixedSavings` |

**Categories:** Assessments, Implementation, Cloud Financial Management
**Product logo:** `public/marketplace-product-logo.png` (400x400, `/tmp/marketplace-product-logo.html`)

### How Marketplace Pricing Works

Actual dollar amounts are set per client via **private offers**. The dimensions are line items on the contract. When David closes a deal:
1. Calculate the client's savings (fixed vs unfixed)
2. Create a private offer with the specific dollar amounts
3. Client accepts through AWS Marketplace
4. Payment processed through AWS (2.5% Marketplace fee)

### Marketplace vs Website Pricing

Same pricing, same model. One engagement. 75% on fixed savings, 15% on unfixed savings. Marketplace uses separate dimensions for accounting.
