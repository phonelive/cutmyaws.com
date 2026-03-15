# CLAUDE.md — CutMyAWS.com

## Company Information

| Field | Value |
|-------|-------|
| Legal Name | Smart Talk LLC |
| DBA | Cut My AWS |
| Domain | cutmyaws.com |
| Address | 445 NE 8th Ave, Ocala, FL 34470 |
| Email | david@cutmyaws.com |
| LinkedIn | https://www.linkedin.com/in/davidplappert/ |
| Calendly | https://calendly.com/phonelivestreaming/cutmyaws-com-intro |
| GitHub | https://github.com/phonelive/cutmyaws.com (private) |
| Google Analytics | G-ZGPX081LFE |
| Google Tag | GT-K8KHLNZJ |
| MS Clarity | vr2el2utus |
| YouTube | https://www.youtube.com/@CutMyAWS |
| Reddit | u/cutmyaws |
| Reddit Pixel | a2_inkp2wvyvllm |
| Google Ads | david@phonelive.io account |
| Microsoft Ads | G145R2VD |
| UET Tag | 343238663 |
| LinkedIn Company Page | Cut My AWS (525710547) |
| LinkedIn Insight Tag | 8785714 |
| Stripe | acct_1TA6p5E7PhfaMBf2 |
| AWS Account | 731039145080 (cutmyaws.aws@phonelive.io) |
| AWS Organization | PhoneLive (734267377938) |

## Founder

**David Plappert** — Senior AWS Serverless Architect with 19 years of AWS experience (since 2007). Builds and runs production serverless SaaS at Fortune 100 scale. Currently consulting at Caterpillar. Also founder of EZRA Cloud (church expense management SaaS) and PhoneLive (live streaming platform).

## What CutMyAWS Does

Business-aligned AWS technology audit and cost optimization for businesses spending **$5K+/month** on AWS. Not just cost cutting — finding the mismatch between tech and business needs. The savings are a side effect of getting that alignment right.

**Key differentiator:** David is a real person who reads your architecture, understands your business, and tells you exactly what to change and why. Not a dashboard. Not an AI. Not a junior analyst with a checklist.

## Target Audience

- Businesses spending **$5,000+/month** on AWS
- Below $5K: not enough waste to justify an engagement
- Companies big enough to have real infrastructure but too busy building product to optimize it

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

## Brand Voice

### Personality

CutMyAWS is witty, humorous, and confident — but never condescending. Think: a friend who happens to be an AWS expert and has a mildly aggressive sense of humor. Self-deprecating > arrogant. AWS is always the villain, never the customer.

### Voice Principles

| Principle | Example |
|-----------|---------|
| **AWS is the villain, not the customer** | "You've been busy building. AWS has been busy collecting rent." |
| **Empathetic, not accusatory** | "Nobody sets out to waste money. It just happens when you're building a business." |
| **Numbers are punchlines** | "Your NAT Gateway costs more than your team's lunch budget." |
| **Self-deprecating** | "My personal bill is a whole separate therapy session." |
| **Short and punchy** | One-liners > paragraphs |
| **Emojis are encouraged** | Use them liberally but purposefully — every section gets 2-3 |
| **Questions > statements** | "Been using AWS for years? When's the last time you cleaned house?" |

### Key Phrases

- "AWS cost therapy" — our positioning
- "Not a dashboard. Not an AI. Just David." — human differentiator
- "We only charge a % of the savings we find" — core value prop
- "No savings? No fee." — risk reversal
- "Not just cheaper — better." — business alignment angle
- "Pennies add up" — the accumulation message
- "19 years of AWS" — since 2007

### Emoji Usage

Emojis are a core part of the brand voice. Use them:
- In section headers (🧰, 🕵️, 🧮, ❓, 👋)
- After punchlines (😏, 🤷, 😅, 👻)
- On CTAs (🗓️, 💸)
- On list items (✅, 🎁)
- In stats and data points (📊, 💰, ⚡)

### Tone by Context

| Context | Tone |
|---------|------|
| **Website** | Full wit, emojis, personality |
| **Calendly** | Witty but slightly more professional |
| **LinkedIn posts** | Hook-driven, educational, personality at the end |
| **Email follow-ups** | Warm, direct, light humor |
| **Proposals/Reports** | Professional with subtle wit in headers |
| **Contracts** | Straight professional (no jokes in legal docs) |

### Error Messages / Edge Cases

Always blame yourself or AWS, never the customer:
- Bad: "Your account is a mess"
- Good: "Your account has been collecting cobwebs — that's AWS's specialty"

### Writing Checklist

Before publishing any CutMyAWS content:
- [ ] Is it witty but not try-hard?
- [ ] Does it blame AWS, not the customer?
- [ ] Are emojis present and purposeful?
- [ ] Is there a clear CTA?
- [ ] Would a busy CTO read this at 10pm and smirk?

## Branding & Design

### Colors

| Color | Hex | Usage |
|-------|-----|-------|
| **Brand Orange** | `#f97316` (orange-500) | Primary — CTAs, headings, highlights |
| **Background** | `#030712` (gray-950) | Page background |
| **Card Background** | `#111827` (gray-900) | Cards, sections |
| **Border** | `#1f2937` (gray-800) | Card borders, dividers |
| **Body Text** | `#9ca3af` (gray-400) | Paragraph text |
| **Heading Text** | `#f3f4f6` (gray-100) | Headlines |
| **Muted Text** | `#6b7280` (gray-500) | Footnotes, captions |
| **Green (savings)** | `#4ade80` (green-400) | "You keep" amounts |
| **Red (waste)** | `#f87171` (red-400) | Waste/loss amounts |

### Typography

- System font stack: `-apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif`
- Headlines: Bold/Extra-bold
- Body: Regular weight, `text-lg` for readability

### Logo

- Primary: `✂️ Cut My AWS` (scissors emoji + text)
- Favicon: Orange square with `$` sign (`/public/favicon.svg`)
- No separate logo image — the scissors emoji IS the logo

### Dark Theme

The site is dark-mode only. All design tokens assume a dark background. Do not add a light mode.

## Tech Stack

| Component | Technology |
|-----------|-----------|
| Framework | Nuxt 4 (static generation) |
| CSS | Tailwind CSS |
| Hosting | GitHub Pages (free) |
| Domain | AWS Route 53 (cutmyaws.com) |
| DNS | Route 53 hosted zone `Z094524813GXW2EAFA9GE` |
| Email | Google Workspace (cutmyaws.com as secondary domain) |
| Analytics | Google Analytics (`G-ZGPX081LFE`) via client plugin |
| Heatmaps | Microsoft Clarity (`vr2el2utus`) via client plugin |
| Booking | Calendly (free intro call) |
| Deployment | GitHub Actions → GitHub Pages (auto on push to main) |

### Key Files

| File | Purpose |
|------|---------|
| `app/pages/index.vue` | The entire landing page (single page site) |
| `app/pages/book.vue` | Calendly embed page — all CTAs route here via `/book?c=campaign` |
| `app/pages/investors.vue` | Dedicated investor landing page for ad campaigns (noindex) |
| `app/pages/give-david-access/index.vue` | Client audit onboarding — grant read-only AWS access (noindex) |
| `app/pages/calculate-savings/index.vue` | Annualized AWS bill calculator with savings estimates (noindex) |
| `app/plugins/gtag.client.ts` | Google Analytics plugin |
| `app/plugins/clarity.client.ts` | Microsoft Clarity plugin |
| `app/plugins/uet.client.ts` | Microsoft Ads UET conversion tracking |
| `app/plugins/linkedin.client.ts` | LinkedIn Insight Tag + conversion tracking |
| `app/plugins/reddit.client.ts` | Reddit pixel + PageVisit + Lead tracking |
| `app/composables/useTracking.ts` | Shared `trackEvent()` — fires GA4, Bing UET, LinkedIn, Reddit in one call |
| `app/pages/confirmed.vue` | Post-booking confirmation page (noindex), fires `booking_confirmed` conversion |
| `nuxt.config.ts` | Meta tags, SEO, structured data, OG tags |
| `public/logos/` | Client logos (8 logos, PNG/SVG) |
| `public/david.png` | David's headshot |
| `public/og-image.png` | Social sharing preview image (1200x630) |
| `public/robots.txt` | Search + AI crawler permissions |
| `public/sitemap.xml` | Search engine sitemap |
| `public/llms.txt` | AI/LLM-readable service description |
| `public/CNAME` | GitHub Pages custom domain |
| `public/logo-dollar.png` | Google Ads logo variant |
| `public/logo-scissors.png` | Google Ads logo variant |
| `public/reddit-ad.png` | Reddit ad image (1080x1080) |
| `public/reddit-ad-thumb.png` | Reddit ad thumbnail (400x300) |
| `public/reddit-banner.png` | Reddit profile banner (1920x576) |
| `public/david-reddit.jpg` | Reddit profile pic (832x832 square crop) |
| `public/linkedin-ad.png` | LinkedIn ad image (1200x627) |
| `public/youtube-banner.png` | YouTube channel banner (2048x1152) |
| `public/marketplace-product-logo.png` | AWS Marketplace product logo (400x400 orange $) |
| `.github/workflows/deploy.yml` | Auto-deploy on push |
| `/tmp/og-template.html` | HTML template for og-image.png |
| `/tmp/reddit-ad-image.html` | HTML template for reddit-ad.png |
| `/tmp/reddit-ad-thumb.html` | HTML template for reddit-ad-thumb.png |
| `/tmp/reddit-banner.html` | HTML template for reddit-banner.png |
| `/tmp/youtube-banner.html` | HTML template for youtube-banner.png |

### Deployment

Push to `main` → GitHub Actions builds Nuxt static → deploys to GitHub Pages. Takes ~45 seconds.

### DNS Records (Route 53)

| Record | Type | Value |
|--------|------|-------|
| `cutmyaws.com` | A | GitHub Pages IPs (185.199.108-111.153) |
| `www.cutmyaws.com` | CNAME | `phonelive.github.io` |
| `cutmyaws.com` | MX | Google Workspace (5 records) |
| `cutmyaws.com` | TXT | SPF (`v=spf1 include:_spf.google.com ~all`) |
| `cutmyaws.com` | TXT | Google site verification |
| `_dmarc.cutmyaws.com` | TXT | DMARC (`v=DMARC1; p=quarantine`) |
| `google._domainkey.cutmyaws.com` | TXT | DKIM |

## Client Audit Infrastructure

### AWS Accounts

| Account | ID | Email | Purpose |
|---------|-----|-------|---------|
| PhoneLive (management) | 734267377938 | aws@phonelive.io | Parent org, consolidated billing |
| Cut My AWS | 731039145080 | cutmyaws.aws@phonelive.io | Audit operations, assumes roles into client accounts |

Organization ID: `o-hub50yd8sx`. All billing rolls up to PhoneLive management account.

### AWS CLI Profiles

| Profile | Account | Method |
|---------|---------|--------|
| `pl` | 734267377938 | IAM user credentials (david.plappert) |
| `cutmyaws` | 731039145080 | Assumes `OrganizationAccountAccessRole` via `pl` |
| `cutmyaws-<client>` | Client account | Assumes `CutMyAWS-ReadOnly-Auditor` via `cutmyaws` |

### Client Onboarding Flow

```
1. Client books intro call → /book
2. After signing: David generates unique external ID
3. Client deploys CloudFormation stack (audit/client-role.yaml)
   - Creates IAM role: CutMyAWS-ReadOnly-Auditor
   - Trusts CutMyAWS account (731039145080)
   - Attaches: ReadOnlyAccess + custom billing policy
   - Client must enable IAM billing access + Cost Explorer
4. David runs: ./audit/add-client.sh <name> <account-id> <external-id>
5. David runs: ./audit/verify-access.sh <name>  (confirms all 4 onboarding steps)
6. Audit begins via CLI: aws ce get-cost-and-usage --profile cutmyaws-<client>
6. After audit: client deletes CloudFormation stack to revoke access
```

### Client Role Permissions

The `CutMyAWS-ReadOnly-Auditor` role grants:
- **ReadOnlyAccess** (AWS managed) — Get/List/Describe for all services
- **Custom billing policy** — Cost Explorer (48 months), Cost & Usage Reports, Budgets, Savings Plans, Cost Optimization Hub, Account info, Pricing API, Organizations read

The role uses an **external ID** per client to prevent confused deputy attacks.

### Audit Key Files

| File | Purpose |
|------|---------|
| `audit/client-role.yaml` | CloudFormation template — client deploys to create audit role |
| `audit/add-client.sh` | Script to add client CLI profile (`./audit/add-client.sh <name> <id> <ext-id>`) |
| `audit/verify-access.sh` | Verify all onboarding steps completed (`./audit/verify-access.sh <name>`) |
| `audit/CLIENT-INSTRUCTIONS.md` | Client-facing setup instructions (send to client) |
| `app/pages/onboarding/give-david-access/index.vue` | Web version of client setup instructions at `/onboarding/give-david-access` |
| `app/pages/onboarding/calculate-savings/index.vue` | Annualized AWS bill calculator at `/onboarding/calculate-savings` |

### Common Audit CLI Commands

```bash
# Last 48 months of monthly costs by service
aws ce get-cost-and-usage \
  --time-period Start=2022-04-01,End=2026-04-01 \
  --granularity MONTHLY \
  --metrics UnblendedCost \
  --group-by Type=DIMENSION,Key=SERVICE \
  --profile cutmyaws-<client>

# Rightsizing recommendations
aws ce get-rightsizing-recommendation \
  --service AmazonEC2 \
  --profile cutmyaws-<client>

# Savings plan recommendations
aws ce get-savings-plans-purchase-recommendation \
  --savings-plans-type COMPUTE_SP \
  --term-in-years ONE_YEAR \
  --payment-option NO_UPFRONT \
  --lookback-period-in-days SIXTY_DAYS \
  --profile cutmyaws-<client>

# List all EC2 instances across regions
for region in $(aws ec2 describe-regions --query 'Regions[].RegionName' --output text --profile cutmyaws-<client>); do
  echo "=== $region ==="
  aws ec2 describe-instances --query 'Reservations[].Instances[].[InstanceId,InstanceType,State.Name]' --output table --region $region --profile cutmyaws-<client>
done
```

## SEO & AI Optimization

### Structured Data (Schema.org JSON-LD)

Located in `nuxt.config.ts` as a script tag. Includes:
- `ProfessionalService` — the business entity
- `Service` (The Report) — 15% audit service
- `Service` (The Fix) — 60% implementation service
- `FAQPage` — 6 Q&A pairs for rich results
- `WebPage` — ties it all together

### AI/LLM Optimization

| Asset | Purpose |
|-------|---------|
| `robots.txt` | Explicitly allows GPTBot, ClaudeBot, PerplexityBot, Google-Extended, Applebot |
| `llms.txt` | Plain-text service description for AI systems |
| `meta summary` | Direct extraction for AI overviews |
| FAQ structured data | Q&A format AI systems prefer for extraction |

### Meta Tags

- `title`, `description`, `keywords`, `author`, `robots`, `canonical`
- Open Graph: `og:title`, `og:description`, `og:image`, `og:url`, `og:site_name`, `og:locale`
- Twitter Card: `twitter:card`, `twitter:title`, `twitter:description`, `twitter:image`
- GEO/AEO: `subject`, `topic`, `summary`

## Client Logos

8 client logos displayed in "Trusted by teams at" section:

| Client | Logo File | Link |
|--------|-----------|------|
| Caterpillar | `/logos/cat.svg` | caterpillar.com |
| DC Government | `/logos/dc-gov.png` | dc.gov |
| Best Buy | `/logos/best-buy.svg` | bestbuy.com |
| PBS | `/logos/pbs.svg` | pbs.org |
| Commonwealth of MA | `/logos/ma-state.png` | mass.gov |
| Argonne National Lab | `/logos/argonne.png` | anl.gov |
| PhoneLive | `/logos/phonelive.png` | phonelive.com |
| EZRA Cloud | `/logos/ezra.png` | ezracloud.com |

PNG logos are 280x80, centered on transparent canvas, optimized for web (7-14KB each). SVGs scale natively. All logos display grayscale at 50% opacity, full color at 90% on hover.

## Promo: Free Security Scan

Time-limited promo configured in `app/pages/index.vue`:

```js
const promoEnd = new Date('2026-04-04T23:59:59')
```

- Shows top banner with countdown when active
- Adds bonus line item in the exploration call section
- Auto-hides when `promoEnd` passes
- Covers: misconfigs, public S3 buckets, overprivileged IAM roles

To extend: change the date. To end early: set to a past date.

## Social Media Strategy

### LinkedIn (primary channel — personal profile only)

- Post 2x/week (Tuesday + Thursday)
- Profile headline: includes both CutMyAWS and EZRA Cloud
- Experience section: CutMyAWS listed as role under Smart Talk LLC
- Content types: educational tips, story/opinion, case studies
- No company page needed — personal posts get 10x engagement

### Content Bank (first month)

1. Launch post: "I spent 19 years paying AWS bills I didn't fully understand..."
2. "5 signs your AWS has been collecting cobwebs"
3. "I found $4,200/mo hiding in a NAT Gateway"
4. "Serverless isn't always the answer. But it's the answer more often than you think."
5. "Your AWS bill is a symptom. The disease is tech that doesn't match your business."
6. "The most expensive AWS service isn't EC2. It's the one nobody's monitoring."
7. "I asked a CTO how many EC2 instances they had. They said 12. It was 47."
8. "Dashboards find waste. I find misalignment."

### Other Channels

| Platform | Status | Notes |
|----------|--------|-------|
| LinkedIn (company page + ads) | **Active** | Company page + paid ads ($45/day total: $15 general + $30 investors) |
| LinkedIn (personal) | **Active** | Primary organic channel |
| Reddit (u/cutmyaws) | **Active** | Organic answers + paid ads ($30/day: $15 general + $15 investors), pixel: a2_inkp2wvyvllm |
| Google Ads | **Active** | Search ads ($30/day: CutMyAWS-V2 + CutMyAWS-Investors) |
| Bing/Microsoft Ads | **Active** | Import Google campaign ($10/day) |
| YouTube (@CutMyAWS) | **Active** | Channel live, record exploration calls as case studies |
| Dev.to / Hashnode | Future | Technical deep-dives for SEO |
| Twitter/X | Maybe later | DevOps community exists but slower |
| Facebook/Instagram/TikTok | Skip | Wrong audience |

### YouTube Channel

**Channel:** https://www.youtube.com/@CutMyAWS
**Handle:** @CutMyAWS

#### Welcome Video (first video — 30-60 seconds)

**Placement:** Homepage hero section, embedded between headline/subheadline and the stats row.

```
[Hello bar]
[Nav]
[Hero headline + subheadline]
[YouTube embed]          <-- here
[Stats row: 19 years / $100M+ / 150+ accounts]
[Trusted by logos]
```

**Script:**

> Hey — I'm David. I've been building on AWS since 2007. That's 19 years of watching businesses accidentally pay for things they don't need.
>
> *[slight smirk]*
>
> You know that feeling when you open your AWS bill and think... "that can't be right"? Yeah. It's right. It's just wrong.
>
> Here's what I do: you give me read-only access, I spend a week reading your architecture, and I come back with a report that says "here's what you're wasting, here's why, and here's exactly what to change."
>
> Not a dashboard. Not an AI tool. Just me, reading your account, understanding your business.
>
> *[lean in slightly]*
>
> And here's the fun part — I only charge a percentage of the savings I find. No savings? No fee. So the worst case scenario is... you wasted 15 minutes on an intro call with me.
>
> *[shrug]*
>
> I've seen worse uses of 15 minutes. You've *had* worse meetings today.
>
> Link's in the description. Let's cut your AWS bill.

**Recording notes:** One take, conversational, at desk. Imperfection is on-brand. ~45 seconds at natural pace.

**Implementation:** Embed as YouTube iframe in `app/pages/index.vue`. Upload to YouTube (public), swap in the video ID.

#### YouTube Banner

| File | Size | Purpose |
|------|------|---------|
| `public/youtube-banner.png` | 2048x1152 | Channel banner image |
| `/tmp/youtube-banner.html` | — | HTML template for banner |

```bash
# Regenerate banner
npx playwright screenshot --viewport-size="2048,1152" --full-page /tmp/youtube-banner.html public/youtube-banner.png
```

#### Future Video Content

| Video | Source | Effort |
|-------|--------|--------|
| Welcome intro (60s) | Script above | Low |
| Exploration call recordings | Record live calls (with permission) | Near-zero marginal |
| "I found $X hiding in Y" | Real audits, anonymized | Medium |
| LinkedIn post repurposes | Read your own post on camera | Low |

### Investor Ad Campaign

**Landing page:** `cutmyaws.com/investors` (dedicated, noindex)

**Angle:** Angel investors / VCs audit portfolio companies' AWS spend to extend runway without cutting headcount.

**Key messages:**
- "Your portfolio companies are overpaying AWS"
- "Nobody audited the AWS bill"
- "Every startup I audit wastes 30-40% on AWS"
- "Extend runway without cutting headcount"
- "One engagement, permanent savings"
- "No savings = no fee"

**Active on all 3 paid social platforms:**
- **LinkedIn Ads** ($30/day) — Targeting: Investor, Private Investor, Venture Partner, Managing Partner, General Partner, Managing Director titles. US only. Campaign ID: 1000806254
- **Reddit Ads** ($15/day) — Same targeting as general campaign. Investor-specific ad creative with dollar breakdown. Campaign: CutMyAWS-Investors
- **Google Ads** — Search keywords: `reduce aws costs portfolio`, `aws cost optimization startup`, `reduce burn rate startup`, `cloud cost optimization small business`

## Email Deliverability

Domain fully configured for maximum deliverability:
- SPF ✅
- DKIM ✅
- DMARC ✅ (quarantine policy)
- MX records ✅ (Google Workspace)

**Warm-up strategy:** New domain — first 2-4 weeks, only send to people expecting emails (Calendly confirmations, direct replies). Ramp to 15-20/day by week 3-4. Use LinkedIn for cold outreach, email for follow-through.

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

## Competitive Landscape

| Competitor Type | Examples | CutMyAWS Edge |
|----------------|----------|---------------|
| Big consulting | Duckbill Group, Accenture, KPMG | They target $1M+ spends. We target $5K+. |
| SaaS dashboards | ProsperOps, CloudHealth, Vantage, nOps | They show charts. We read architecture + business. |
| Boutique consultants | Miro, Rambunct, SUDO, StableLogic | None publish pricing. We're fully transparent. |

**Nobody else offers:** transparent % pricing, free intro call, human consulting for $5K+/mo, witty brand, verified-savings implementation fee.

## Paid Advertising

### Budget: $100/day total (revised 2026-03-14)

| Platform | Campaigns | Daily Budget | Status |
|----------|-----------|-------------|--------|
| Google Ads (120-353-4001) | 7 campaigns | **$70/day** | **Active** |
| Reddit Ads (u/cutmyaws) | 3 campaigns | **$30/day** | **Active** |
| Bing/Microsoft Ads (G145R2VD) | CutMyAWS-V2 | $0/day | **Not working** |
| LinkedIn Ads (525710547) | 2 campaigns | $0/day | **All paused** |

**Strategy (2026-03-14):** All campaigns use conversion objective (not clicks/traffic). Google Investors is top performer. Reddit testing 3 campaigns at $10/day each with conversion objective — evaluate by 2026-03-28. If no bookings, kill Reddit and move $30/day to Google.

### Google Ads

**Account:** Cut My AWS (120-353-4001), david@phonelive.io
**Google Tag:** GT-K8KHLNZJ (configured in `app/plugins/gtag.client.ts`)
**Conversion:** GA4-imported `booking_confirmed` event (Primary, fires on /confirmed with name param). Old `manual_event_SUBMIT_LEAD_FORM` demoted to Secondary (click-based only).
**Promo:** $500 spend-match credit (applied)

**RSA Character Limits:** Headlines ≤ 30 chars, Descriptions ≤ 90 chars, Paths ≤ 15 chars each

**Negative keywords (all campaigns):** aws free tier, aws certification, aws training, aws jobs, aws tutorial, aws pricing calculator

#### Campaign 1: CutMyAWS-Investors — $55/day (TOP PERFORMER)

- **Bid Strategy:** Maximize conversions
- **Networks:** Google Search + Search Partners
- **Landing:** `cutmyaws.com/investors`
- **Performance (Mar 11-14):** 25 clicks, 300 impr, **8.33% CTR**, $1.29 CPC, 3 click-conversions (old metric — Calendly link clicks, not actual bookings), ~1 real booking
- **Note:** Conversion tracking fixed 2026-03-14 — now uses `booking_confirmed` (actual Calendly completion with name) instead of link clicks
- **54 keywords** (Broad): cloud optimization tools, aws cost review, optimizing cloud spend, aws waste, cost optimization cloud, cloud optimisation, aws overspending, cloud cost optimization, reduce cloud costs, cut aws bill, aws cost savings, cloud spend optimization, aws finops, lower aws bill, aws cost audit, aws cost optimization, aws consulting, finops consulting, cloud cost audit, reduce aws bill, + 34 more
- **Headlines:** Cut Your AWS Bill by 30-40% | No Savings = No Fee | Free 15-Min Intro Call | 19 Years of AWS Experience | Pay Only on Verified Savings | AWS Cost Audit for Startups | 9-Month ROI on Average | Not a Dashboard. A Real Human. | Stop Overpaying AWS | No Retainer. No Hourly. | Extend Your Startup's Runway | Free Security Audit Included | Trusted by Caterpillar & PBS | AWS Cost Optimization Expert
- **Descriptions:** We find 30-40% AWS waste on average. Pay only on verified savings. Free intro call. | 19 years of AWS experience. A real architect, not a dashboard. Free 15-min call. | Your startups are overpaying AWS. One engagement, permanent savings. No retainer. | Cut your AWS bill without slowing dev teams. No commitment. Results-based pricing.

#### Campaign 2: CutMyAWS-V2 — $5/day

- **Bid Strategy:** Maximize conversions
- **Networks:** Google Search only
- **Landing:** `cutmyaws.com`
- **Performance (Mar 11-14):** 3 clicks, 155 impr, 1.94% CTR, $5.61 CPC
- **Cleanup (2026-03-14):** Paused 20 bad keywords (savings plans, tools, AWS features like compute optimizer, audit manager, trusted advisor)
- **49 keywords** (Broad, 20 paused): aws cloud cost optimization, aws optimization, aws cost optimisation, ec2 cost optimization, aws architecture review, aws cost cutting, cloud cost optimization aws, rds cost optimization, s3 cost optimization, aws audit, eks cost optimization, aws lambda cost optimization, + more
- **Headlines:** Cut Your AWS Bill 30%+ | AWS Cost Optimization Expert | 19 Years AWS Experience | No Savings = No Fee | Not a Dashboard. A Human. | Free 15-Min Intro Call | $5K+/mo AWS Spend? | Senior AWS Architect | Pay For Only Real Savings | AWS Cost Audit & Fix | Business-Aligned AWS Audit | Transparent % Pricing | Stop Overpaying for AWS | AWS Bill Analysis | Proven AWS Savings
- **Descriptions:** Spending $5K+/mo on AWS? Free intro call. Pay only a % of verified savings found. | Senior AWS architect with 19 years experience audits your account & finds real savings. | Not a dashboard or AI tool. A real architect understands your setup & can fix it. | Book a free 15-min call. Get a full report. No savings = no fee. It's that simple.

#### Campaign 3: CutMyAWS-Symptom — $5/day (NEW 2026-03-14)

- **Angle:** Problem awareness — "your bill is a symptom"
- **Bid Strategy:** Maximize conversions
- **Networks:** Google Search only
- **Landing:** `cutmyaws.com?utm_source=google&utm_medium=cpc&utm_campaign=cutmyaws-symptom`
- **Path:** aws / audit
- **Keywords (10, Broad):** aws bill too high, aws costs growing, why is my aws bill so high, aws spending too much, aws bill keeps increasing, aws overspending, cloud spend out of control, aws infrastructure costs, aws bill analysis, aws cost problem
- **Headlines:** Your AWS Bill Is a Symptom | Save 25% in 90 Days | No Savings = No Fee | Free 15-Min Intro Call | 19 Years of AWS Experience | Stop Overpaying for AWS | Not a Dashboard. A Human.
- **Descriptions:** Your AWS bill is a symptom. Architecture nobody touched in years. Free call. | I find 30-40% waste on every AWS account. 19 years exp. Pay a % of savings.

#### Campaign 4: CutMyAWS-25pct — $5/day (NEW 2026-03-14)

- **Angle:** Hard number + risk reversal — "save 25% in 90 days"
- **Bid Strategy:** Maximize conversions
- **Networks:** Google Search only
- **Landing:** `cutmyaws.com?utm_source=google&utm_medium=cpc&utm_campaign=cutmyaws-25pct`
- **Path:** aws / savings
- **Keywords (10, Broad):** reduce aws costs, cut aws bill, lower aws bill, aws cost reduction, save on aws, aws cost savings, reduce cloud costs, cut cloud costs, aws bill optimization, aws spending optimization
- **Headlines:** Save 25% on Your AWS Bill | In 90 Days. Guaranteed. | No Savings = No Fee | Free 15-Min Intro Call | 19 Years AWS Experience | Cut Your AWS Bill 25%+ | Pay Only on Verified Savings
- **Descriptions:** Save 25% on your AWS bill in 90 days. No savings = no fee. Free intro call. | I find 30-40% waste on every account. You pay a % of savings. One-time fee.

#### Campaign 5: CutMyAWS-Human — $5/day (NEW 2026-03-14)

- **Angle:** Differentiation — "not a dashboard, a human"
- **Bid Strategy:** Maximize conversions
- **Networks:** Google Search only
- **Landing:** `cutmyaws.com?utm_source=google&utm_medium=cpc&utm_campaign=cutmyaws-human`
- **Path:** aws / consultant
- **Keywords (10, Broad):** aws cost consultant, aws consulting, finops consultant, cloud cost consultant, aws architect for hire, cloud cost optimization consultant, aws cost optimization services, hire aws expert, aws cost optimization consultant, finops consulting
- **Headlines:** Not a Dashboard. A Human. | Real AWS Consultant | 19 Years of AWS Experience | No Savings = No Fee | Free 15-Min Intro Call | I Read Your Architecture | AWS Cost Optimization Expert
- **Descriptions:** Cloud cost tools show charts. I read your architecture and tell you what to fix. | Not a dashboard. Not an AI. A real architect who finds waste no tool can see.

#### Campaign 6: CutMyAWS-Serverless — $5/day (NEW 2026-03-14)

- **Angle:** Technical — "still running EC2 24/7?"
- **Bid Strategy:** Maximize conversions
- **Networks:** Google Search only
- **Landing:** `cutmyaws.com?utm_source=google&utm_medium=cpc&utm_campaign=cutmyaws-serverless`
- **Path:** aws / serverless
- **Keywords (10, Broad):** serverless migration aws, ec2 cost optimization, ec2 to lambda migration, rds cost optimization, ec2 to serverless, aws serverless consultant, migrate ec2 to containers, aws architecture modernization, ec2 right sizing, aws lambda migration
- **Headlines:** Still Running EC2 24/7? | Serverless Saves 40-70% | 19 Years AWS Experience | No Savings = No Fee | Free 15-Min Intro Call | Right-Size Your AWS | Serverless Migration Expert
- **Descriptions:** Still running EC2 24/7? Serverless saves 40-70%. 19 years migrating workloads. | Architecture from 3 years ago is costing you today. Modernize and save.

#### Campaign 7: CutMyAWS-Audit — $5/day (NEW 2026-03-14)

- **Angle:** Direct intent — "AWS cost audit"
- **Bid Strategy:** Maximize conversions
- **Networks:** Google Search only
- **Landing:** `cutmyaws.com?utm_source=google&utm_medium=cpc&utm_campaign=cutmyaws-audit`
- **Path:** aws / audit
- **Keywords (10, Broad):** aws cost audit, aws architecture review, cloud cost audit, aws account audit, aws infrastructure audit, aws cost analysis, aws spend analysis, aws cost review, audit aws account, aws bill review service
- **Headlines:** AWS Cost Audit in 10 Days | Full Report. Every Waste Item. | No Savings = No Fee | Free 15-Min Intro Call | 19 Years AWS Experience | Save 25% on Your AWS Bill | Not a Dashboard. A Human.
- **Descriptions:** Full AWS cost audit in 5-10 days. Every waste item with dollar amounts and fixes. | A real architect reads your account, not a dashboard. Finds waste no tool sees.

#### Google Ads — Shared Assets

**Callout Extensions:** 19 Years AWS Experience | Free Security Audit | Free Intro Call | Results-Based Pricing | Transparent Pricing | No Savings = No Fee | Fortune 100 Experience

**Sitelinks:** About David → /#about | How Pricing Works → /#pricing | Book Free Intro Call → /book?c=google-sitelink | How It Works → /#how-it-works | ROI Calculator → /#calculator | Free Intro Call → /book?c=google-search

**Logo Assets:** `public/logo-dollar.png`, `public/logo-scissors.png`

#### Google Ads Editor (bulk management)

Export/import campaigns via Google Ads Editor (free desktop app). Import file format: UTF-8 TSV.

**IMPORTANT:** Location targeting must be on a SEPARATE row from campaign definition (otherwise "Ambiguous row type" error). RSA ads sometimes fail to attach on import — create manually in Google Ads UI if "Campaign has no ads" appears.

### Reddit Ads

**Account:** u/cutmyaws
**Pixel ID:** a2_inkp2wvyvllm (installed via `app/plugins/reddit.client.ts`)
**Pixel events:** `PageVisit` (every page load), `Lead` (on /book or calendly.com link clicks + booking confirmation)
**Promo:** $500 spend-match credit (applied)

**Shared targeting (all campaigns):** Keywords (aws bill, aws cost, aws infrastructure, aws savings, cloud optimization, cloud spend, cloud waste, finops, reduce aws) + Communities (r/FinOps, r/SaaS, r/aws, r/cloudcomputing, r/devops, r/startups, r/sysadmin) + US only

#### Old Campaigns (all paused/inactive)

| Campaign | Lifetime Performance | Status |
|----------|---------------------|--------|
| CutMyAWS-Investors (traffic) | 9,532 impr, 58 clicks, $0.59 CPC, 0.608% CTR, $34.40 spent | Inactive (cheap clicks, 0 bookings) |
| Cut My AWS V1 (traffic) | 6,056 impr, 31 clicks, $1.00 CPC, 0.512% CTR, $30.87 spent | Inactive (cheap clicks, 0 bookings) |
| CutMyAWS-Investors-Conversion | 174 impr, 1 click, $8.98 CPC, $51.62 spent | Paused (conversion obj failed at low budget) |

**Reddit total: 90 clicks, $74.25 spent, 0 bookings.** Testing 3 campaigns with conversion objective at $10/day each for 2 weeks. If no bookings by 2026-03-28, kill Reddit ads entirely and move $30/day to Google.

#### Campaign 1: CutMyAWS-25pct — $10/day (NEW 2026-03-14)

- **Objective:** Conversions
- **Headline:** Save 25% on your AWS bill in 90 days. No savings = no fee.
- **Image:** `public/reddit-ad-25pct.png` (1080x1080)
- **CTA:** Learn More
- **Landing:** `cutmyaws.com?utm_source=reddit&utm_medium=paid&utm_campaign=cutmyaws-25pct`

#### Campaign 2: CutMyAWS-NATGateway — $10/day (NEW 2026-03-14)

- **Objective:** Conversions
- **Headline:** Your NAT Gateway costs more than your team's lunch budget. I find the charges nobody's watching.
- **Image:** `public/reddit-ad-natgateway.png` (1080x1080)
- **CTA:** Learn More
- **Landing:** `cutmyaws.com?utm_source=reddit&utm_medium=paid&utm_campaign=cutmyaws-natgateway`

#### Campaign 3: CutMyAWS-Human — $10/day (NEW 2026-03-14)

- **Objective:** Conversions
- **Headline:** Cloud cost tools show charts. I read your architecture and tell you what to change. Just David.
- **Image:** `public/reddit-ad-human.png` (1080x1080)
- **CTA:** Learn More
- **Landing:** `cutmyaws.com?utm_source=reddit&utm_medium=paid&utm_campaign=cutmyaws-human`

#### Shelved Reddit Campaigns (activate if Reddit proves it can convert)

| Campaign | Headline | Image |
|----------|----------|-------|
| CutMyAWS-Symptom | Your AWS bill is a symptom. The disease is architecture nobody's touched in 3 years. | `reddit-ad-symptom.png` |
| CutMyAWS-Investors | Found $9K/mo in AWS waste for a startup last week. Their investors had no idea. | `reddit-ad-investors-v2.png` |

#### Reddit Ad Assets

| File | Size | Purpose |
|------|------|---------|
| `public/reddit-ad.png` | 1080x1080 | Original general ad image (old campaign) |
| `public/reddit-ad-symptom.png` | 1080x1080 | Symptom campaign ad |
| `public/reddit-ad-25pct.png` | 1080x1080 | 25% savings campaign ad |
| `public/reddit-ad-human.png` | 1080x1080 | Human vs dashboard campaign ad |
| `public/reddit-ad-investors-v2.png` | 1080x1080 | Investor campaign ad (v2) |
| `public/reddit-ad-natgateway.png` | 1080x1080 | NAT Gateway campaign ad |
| `public/reddit-ad-thumb.png` | 400x300 | Ad thumbnail |
| `public/reddit-banner.png` | 1920x576 | Profile banner |
| `public/david-reddit.jpg` | 832x832 | Profile picture (square crop of david.png) |

#### Reddit Ad Image Generation

Ad images are generated from HTML templates via Playwright:

```bash
npm install --no-save playwright-core
node -e "
const { chromium } = require('playwright-core');
(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage();
  await page.setViewportSize({ width: 1080, height: 1080 });
  await page.goto('file:///tmp/reddit-ad-{name}.html', { waitUntil: 'networkidle' });
  await page.screenshot({ path: 'public/reddit-ad-{name}.png', fullPage: true });
  await page.close();
  await browser.close();
})();
"
npm uninstall playwright-core
```

Templates: `/tmp/reddit-ad-symptom.html`, `/tmp/reddit-ad-25pct.html`, `/tmp/reddit-ad-human.html`, `/tmp/reddit-ad-investors.html`, `/tmp/reddit-ad-natgateway.html`

#### Reddit Organic Strategy

Answer questions in these subreddits to build authority (don't self-promote directly):
- r/aws — cost optimization questions
- r/devops — infrastructure and cloud spend discussions
- r/sysadmin — AWS billing complaints
- r/cloudcomputing — general cloud cost topics
- r/startups, r/smallbusiness — "our AWS bill is too high" posts

### LinkedIn Ads (ALL PAUSED as of 2026-03-14)

- **Account:** Cut My AWS (525710547)
- **Insight Tag:** 8785714 (installed via `app/plugins/linkedin.client.ts`)
- **Conversion:** Calendly Clicks V2 (Lead category, Direct API source) + booking_confirmed via useTracking (conversion_id: 26412858)
- **Status:** All campaigns paused to stay within $100/day budget

#### Campaign: New Campaign Group (General) — ID: 998926464 — PAUSED

- **Objective:** Website visits, was $15/day
- **Targeting:** Job titles (CTO, VP Engineering, Director of Engineering, Head of Infrastructure, Cloud Architect, DevOps Manager, VP of Operations, Engineering Manager) + Company size (11-50, 51-200, 201-500) + Skills (AWS, Cloud Computing, DevOps)
- **Landing page:** cutmyaws.com?utm_source=linkedin&utm_medium=paid&utm_campaign=cutmyaws-v1

#### Campaign: CutMyAWS - Investors — ID: 1000806254 — PAUSED

- **Objective:** Website visits, was $30/day
- **Targeting:** Job titles (Investor, Private Investor, Venture Partner, Managing Partner, Managing Director, General Partner) + US only
- **Landing page:** cutmyaws.com/investors?utm_source=linkedin&utm_medium=paid&utm_campaign=cutmyaws-investors

#### LinkedIn Ad Assets

| File | Size | Purpose |
|------|------|---------|
| `public/linkedin-ad.png` | 1200x627 | Single image ad (general campaign) |
| `public/linkedin-ad-investors.png` | 1200x627 | Single image ad (investors campaign) |

### Bing/Microsoft Ads (NOT WORKING as of 2026-03-14)

- **Account:** G145R2VD (david@phonelive.io)
- **Campaign:** CutMyAWS-V2 (imported from Google Ads)
- **UET Tag:** 343238663 (installed via `app/plugins/uet.client.ts`)
- **Conversion event:** `calendly_click` (custom event, fired on Calendly link clicks)
- **Budget:** was $10/day
- **Status:** Not delivering — needs investigation
- **Promo:** Spend $250, get $500 free (valid through June 30, 2026)

### UTM Parameter Standard

All ad platforms use consistent UTM params for GA4 reporting:

| Parameter | Purpose | Values |
|-----------|---------|--------|
| `utm_source` | Platform | `google`, `linkedin`, `reddit`, `bing` |
| `utm_medium` | Channel type | `cpc` (search), `paid` (social/display) |
| `utm_campaign` | Campaign name | `cutmyaws-investors`, `cutmyaws-v2`, `cutmyaws-symptom`, `cutmyaws-25pct`, `cutmyaws-human`, `cutmyaws-serverless`, `cutmyaws-audit`, `cutmyaws-natgateway` |
| `utm_content` | Ad variant (optional) | `ad1`, `ad2` for A/B testing |

**GA4 reporting:** Reports → Acquisition → Traffic acquisition → primary dimension: Session campaign, secondary: Session source/medium.

### Conversion Tracking

Two layers of conversion tracking:

**Layer 1 — Click-based (plugins):** Each plugin fires on Calendly/book link clicks via event delegation.

```
User clicks any /book or calendly.com link
  → gtag fires `manual_event_SUBMIT_LEAD_FORM` → GA4 → Google Ads
  → uet fires `calendly_click` → Microsoft Ads
  → lintrk fires conversion → LinkedIn Ads
  → rdt fires `Lead` → Reddit Ads
```

**Layer 2 — Event-based (useTracking composable):** Centralized `trackEvent()` fires named events across all 4 platforms.

```
User visits /book page
  → trackEvent('book_page_view') → GA4 + Bing UET

User completes Calendly booking → Calendly redirects to /confirmed
  → trackEvent('booking_confirmed') → GA4 + Bing UET + LinkedIn (conversion_id: 26412858) + Reddit (Lead)

User scrolls homepage sections
  → trackEvent('section_view', { event_label: 'hero' }) → GA4 + Bing UET (per section, once each)

User interacts with video
  → video_{name}_{page}_{action} (e.g. video_intro_home_play, video_intro_book_pause)
  → Actions: ready, play, pause, buffer, progress_25/50/75, complete, speed_change, error
```

Plugins: `gtag.client.ts`, `uet.client.ts`, `linkedin.client.ts`, `reddit.client.ts`
Composable: `app/composables/useTracking.ts`

### Ad Platform Promos

| Platform | Offer | Status |
|----------|-------|--------|
| Google Ads | Spend $500, get $500 | Applied |
| Reddit Ads | Spend $500, get $500 | Applied |
| Microsoft/Bing | Spend $250, get $500 | Available (auto-applied at signup) |

## OG Image Generation

The social sharing image (`public/og-image.png`) is generated using Playwright screenshotting an HTML template:

```bash
# Template at /tmp/og-template.html
npx playwright screenshot --viewport-size="1200,630" --full-page /tmp/og-template.html public/og-image.png
```

To regenerate: edit `/tmp/og-template.html` and re-run the command. Requires Playwright with Chromium installed.

## Compact Instructions

When compacting, preserve pricing structure, brand voice rules, key file paths, and ad platform details (account IDs, budgets, conversion tracking flow).
