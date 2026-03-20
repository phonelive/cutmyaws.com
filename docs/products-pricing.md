# Pricing

## The Offering

Free audit. You only pay a percentage of verified savings.

> **NOTE:** Specific percentages are **not published on the website**. The site says "percentage of verified savings" and "no savings, no fee." Pricing details are discussed during the engagement after the client sees the audit findings.

### Internal Reference (not shown on site)

| | Fee |
|--|-----|
| **Audit** | Free |
| **Savings David fixes** | 75% of annualized verified savings |
| **Savings found but not fixed** | Free — no charge |
| **No savings** | No fee |
| **Overage rate** | $500/hr for out-of-scope work |

### What the website says

| | Public messaging |
|--|-----|
| **Audit** | Free |
| **Fee** | Percentage of verified savings |
| **No savings** | No fee |

## Pricing

Only `minAws` and `overageRate` remain in `app/composables/usePricing.ts`:

```js
const pricing = {
  minAws: 5000,        // We work best with $5K+/mo AWS spend
  overageRate: 500,    // Hourly rate for out-of-scope work
}
```

Specific fee percentages, deposit amounts, and calculators have been removed from the site. Pricing is discussed during the Findings Meeting.

### Engagement Flow

```
🗓️ FREE INTRO CALL       Free (15 min)
        ↓
   Grant read-only access (no payment yet)
        ↓
   5-10 business days    (David audits the account)
        ↓
📋 FINDINGS MEETING       Delivers: Audit PDF, Security PDF, Implementation Recommendations PDF
   │                      Free — no charge for the audit
   │
   └─ Want David to fix it?
      │
      ├─ No → Walk away free. Keep the reports.
      │
      └─ Yes → Pricing discussed, engagement begins
                     ↓
               🔧 IMPLEMENTATION
                     ↓
               📊 VERIFICATION & PAYMENT
                  Percentage of verified savings David fixed
                  (no savings = $0 owed)
```

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
2. Create a private offer with the specific dollar amount
3. Client accepts through AWS Marketplace
4. Payment processed through AWS (2.5% Marketplace fee)

**Categories:** Assessments, Implementation, Cloud Financial Management
**Product logo:** `public/marketplace-product-logo.png` (400x400, `/tmp/marketplace-product-logo.html`)
