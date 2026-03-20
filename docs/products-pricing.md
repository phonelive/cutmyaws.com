# Pricing

## The Offering

Free audit. You only pay 75% of the savings David actually fixes.

| | Fee |
|--|-----|
| **Audit** | Free (high-level: services, amounts, what's fixable) |
| **Savings David fixes** | 75% of annualized verified savings |
| **Savings found but not fixed** | Free — no charge |
| **Deposit** | 4% of annualized AWS spend (only when client wants implementation, deducted from total) |
| **No savings** | No fee |

- Free audit removes all barriers — client sees the numbers before spending a dollar
- Deposit only required when client decides they want David to fix it
- Fee due 90 days after implementation, based on verified savings only
- Unfixed savings are not charged

## Pricing

All pricing is centralized in `app/composables/usePricing.ts`:

```js
const pricing = {
  depositPct: 4,       // Down payment: 4% of AWS annual spend to start implementation (after free audit)
  fixedPct: 75,        // 75% of annualized savings David finds AND fixes
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
   Grant read-only access (no payment yet)
        ↓
   5-10 business days    (David audits the account)
        ↓
📋 FINDINGS CALL          High-level: services, amounts, what's fixable
   │                      Free — no charge for the audit
   │
   └─ Want David to fix it?
      │
      ├─ No → Walk away free. Keep the report.
      │
      └─ Yes → 4% deposit (of AWS annual spend, deducted from total)
                     ↓
               🔧 IMPLEMENTATION
                     ↓
               ⏳ 90 DAYS LATER
                     ↓
               📊 VERIFICATION    75% of VERIFIED savings David fixed
                                  (minus deposit; no savings = $0 owed)
                                  (unfixed savings = $0 owed)
```

### Example ($25K/mo AWS spend, 36% waste found, all savings fixed)

| Phase | Amount |
|-------|-------:|
| Free Chat | Free |
| Audit + Findings | Free |
| Deposit (4% of $300K annual) | $12,000 |
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

### How Marketplace Pricing Works

Actual dollar amounts are set per client via **private offers**. When David closes a deal:
1. Calculate the client's verified savings
2. Create a private offer with the specific dollar amount (75% of fixed savings)
3. Client accepts through AWS Marketplace
4. Payment processed through AWS (2.5% Marketplace fee)

**Categories:** Assessments, Implementation, Cloud Financial Management
**Product logo:** `public/marketplace-product-logo.png` (400x400, `/tmp/marketplace-product-logo.html`)
