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
| Reddit | u/cutmyaws |
| Reddit Pixel | a2_inkp2wvyvllm |
| Google Ads | david@phonelive.io account |
| Microsoft Ads | G145R2VD |
| UET Tag | 343238663 |
| LinkedIn Company Page | Cut My AWS (525710547) |
| LinkedIn Insight Tag | 8785714 |

## Founder

**David Plappert** — Senior AWS Serverless Architect with 19 years of AWS experience (since AWS launched in 2006). Builds and runs production serverless SaaS at Fortune 100 scale. Currently consulting at Caterpillar. Also founder of EZRA Cloud (church expense management SaaS) and PhoneLive (live streaming platform).

## What CutMyAWS Does

Business-aligned AWS technology audit and cost optimization for businesses spending **$5K+/month** on AWS. Not just cost cutting — finding the mismatch between tech and business needs. The savings are a side effect of getting that alignment right.

**Key differentiator:** David is a real person who reads your architecture, understands your business, and tells you exactly what to change and why. Not a dashboard. Not an AI. Not a junior analyst with a checklist.

## Target Audience

- Businesses spending **$5,000+/month** on AWS
- Below $5K: not enough waste to justify an engagement
- Companies big enough to have real infrastructure but too busy building product to optimize it

## Pricing

All pricing is centralized in `app/pages/index.vue` in the `pricing` object:

```js
const pricing = {
  depositPct: 1,       // Down payment: 1% of AWS annual spend to start
  reportPct: 15,       // The Report: 15% of annual savings (deposit deducted)
  implPct: 60,         // Implementation portion
  fixPct: 75,          // The Fix: 75% total (15% report + 60% implementation)
  securityPct: 10,     // Security Audit: 10% of AWS annual spend (free during promo)
  minAws: 5000,        // We work best with $5K+/mo AWS spend
}
```

**Change pricing in ONE place** — the entire site updates automatically. All template references use `{{ pricing.* }}`.

### Pricing Flow

```
🗓️ INTRO CALL           Free (15 min)
        ↓
   5-10 business days    (David audits the account)
        ↓
📋 EXPLORATION CALL      15% of annual savings found
   │                     Client receives full report PDF
   │
   └─ Want implementation?
      │
      ├─ No → Done. Team implements from the report.
      │
      └─ Yes → Scope timeline, deliverables together
               ↓
         🔧 IMPLEMENTATION
               ↓
         ⏳ 90 DAYS LATER
               ↓
         📊 THE PROOF       +60% of VERIFIED savings due
                            (no savings = $0 owed)

Max total: 75% (15% report + 60% implementation)
```

### Example ($25K/mo AWS spend, 30% waste found)

| Phase | Amount |
|-------|-------:|
| Intro Call | Free |
| Exploration Call (15% of $108K) | $16,200 |
| 90 Days After Implementation (+60%) | $64,800 |
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
- "19 years of AWS" — since launch in 2006

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
| `.github/workflows/deploy.yml` | Auto-deploy on push |
| `/tmp/og-template.html` | HTML template for og-image.png |
| `/tmp/reddit-ad-image.html` | HTML template for reddit-ad.png |
| `/tmp/reddit-ad-thumb.html` | HTML template for reddit-ad-thumb.png |
| `/tmp/reddit-banner.html` | HTML template for reddit-banner.png |

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
| Reddit (u/cutmyaws) | **Active** | Organic answers + paid ads ($15/day), pixel: a2_inkp2wvyvllm |
| Google Ads | **Active** | Search ads ($30/day: CutMyAWS-V2 + CutMyAWS-Investors) |
| Bing/Microsoft Ads | **Active** | Import Google campaign ($10/day) |
| YouTube | Future (month 2-3) | Record exploration calls as case studies |
| Dev.to / Hashnode | Future | Technical deep-dives for SEO |
| Twitter/X | Maybe later | DevOps community exists but slower |
| Facebook/Instagram/TikTok | Skip | Wrong audience |

### Investor Ad Campaign

**Landing page:** `cutmyaws.com/investors` (dedicated, noindex)

**Angle:** Angel investors / VCs audit portfolio companies' AWS spend to extend runway without cutting headcount.

**Key messages:**
- "Your portfolio companies are overpaying AWS"
- "Nobody audited the AWS bill"
- "30-40% waste on average"
- "9-month ROI, pay on results only"
- "One engagement, permanent savings"

**Platforms:**
- **Google Ads** — Search keywords: `reduce aws costs portfolio`, `aws cost optimization startup`, `reduce burn rate startup`, `cloud cost optimization small business`
- **LinkedIn Ads** — Sponsored Content + InMail. Target: Angel Investor, Venture Partner, Managing Partner, General Partner titles. VC/PE industries. Director+ seniority.
- **Reddit Ads** — Promoted posts in r/startups, r/venturecapital, r/SaaS, r/aws, r/devops, r/Entrepreneur

## Email Deliverability

Domain fully configured for maximum deliverability:
- SPF ✅
- DKIM ✅
- DMARC ✅ (quarantine policy)
- MX records ✅ (Google Workspace)

**Warm-up strategy:** New domain — first 2-4 weeks, only send to people expecting emails (Calendly confirmations, direct replies). Ramp to 15-20/day by week 3-4. Use LinkedIn for cold outreach, email for follow-through.

## Competitive Landscape

| Competitor Type | Examples | CutMyAWS Edge |
|----------------|----------|---------------|
| Big consulting | Duckbill Group, Accenture, KPMG | They target $1M+ spends. We target $5K+. |
| SaaS dashboards | ProsperOps, CloudHealth, Vantage, nOps | They show charts. We read architecture + business. |
| Boutique consultants | Miro, Rambunct, SUDO, StableLogic | None publish pricing. We're fully transparent. |

**Nobody else offers:** transparent % pricing, free intro call, human consulting for $5K+/mo, witty brand, verified-savings implementation fee.

## Paid Advertising

### Ad Accounts & IDs

| Platform | Account | Daily Budget | Status |
|----------|---------|-------------|--------|
| Google Ads | david@phonelive.io | $30/day | Active (campaigns: CutMyAWS-V2, CutMyAWS-Investors) |
| Reddit Ads | u/cutmyaws | $15/day | Active |
| Bing/Microsoft Ads | david@phonelive.io (G145R2VD) | $10/day | Active (campaign: CutMyAWS-V2) |
| LinkedIn Ads (General) | Cut My AWS (525710547) | $15/day | Active (campaign: CutMyAWS-V1) |
| LinkedIn Ads (Investors) | Cut My AWS (525710547) | $30/day | Active (campaign: CutMyAWS - Investors) |

**Total ad spend:** ~$100/day / ~$3,000/month

### Google Ads

- **Campaign:** CutMyAWS-V2 (Search campaign)
- **Google Tag:** GT-K8KHLNZJ (configured in `app/plugins/gtag.client.ts`)
- **Conversion tracking:** GA4-imported event `manual_event_SUBMIT_LEAD_FORM` — fires when any `a[href*="calendly.com"]` link is clicked (including hello bar)
- **Budget:** $30/day
- **Promo:** $500 spend-match credit (spend $500, get $500)

#### Keywords Strategy

**High-intent keywords to target:** aws cost optimization consultant, aws cost reduction services, aws bill optimization, reduce aws costs, aws cloud cost management, aws cost saving consultant, aws infrastructure optimization, aws spending optimization, aws cost analysis, aws waste reduction, aws cost audit, cloud cost optimization consultant, cloud cost reduction services, cloud infrastructure optimization, cloud spending optimization, aws finops consultant, aws cost consultant, aws optimization services

**Negative keywords:** aws savings plans, aws free tier, aws certification, aws training, aws cost optimisation (British spelling)

**Skip these** (wrong intent — people looking for software tools, not consulting): aws cost optimization tools, cloud cost optimization tools, aws cost management tools, cloud cost management tools, aws cost optimizer

#### Ad Assets

| File | Size | Purpose |
|------|------|---------|
| `public/logo-dollar.png` | — | Google Ads logo (dollar sign) |
| `public/logo-scissors.png` | — | Google Ads logo (scissors) |

### Reddit Ads

- **Account:** u/cutmyaws
- **Pixel ID:** a2_inkp2wvyvllm (installed via `app/plugins/reddit.client.ts`)
- **Pixel events:** `PageVisit` (every page load), `Lead` (on /book or calendly.com link clicks + booking confirmation)
- **Campaign:** Traffic objective, $15/day
- **Targeting:** Subreddit communities (r/aws, r/devops, r/sysadmin, r/cloudcomputing, r/serverless, r/startups, r/smallbusiness) + keywords
- **Ad copy:** "Your AWS bill is a symptom." → "NO SAVINGS = NO FEE" CTA
- **Promo:** $500 spend-match credit (spend $500, get $500)
- **Landing page:** cutmyaws.com with UTM params

#### Reddit Ad Assets

| File | Size | Purpose |
|------|------|---------|
| `public/reddit-ad.png` | 1080x1080 | Main ad image |
| `public/reddit-ad-thumb.png` | 400x300 | Ad thumbnail |
| `public/reddit-banner.png` | 1920x576 | Profile banner |
| `public/david-reddit.jpg` | 832x832 | Profile picture (square crop of david.png) |

#### Reddit Ad Image Generation

Ad images are generated from HTML templates via Playwright, same as OG images:

```bash
# Main ad image (1080x1080)
npx playwright screenshot --viewport-size="1080,1080" --full-page /tmp/reddit-ad-image.html public/reddit-ad.png

# Thumbnail (400x300)
npx playwright screenshot --viewport-size="400,300" --full-page /tmp/reddit-ad-thumb.html public/reddit-ad-thumb.png

# Profile banner (1920x576)
npx playwright screenshot --viewport-size="1920,576" --full-page /tmp/reddit-banner.html public/reddit-banner.png
```

Templates: `/tmp/reddit-ad-image.html`, `/tmp/reddit-ad-thumb.html`, `/tmp/reddit-banner.html`

#### Reddit Organic Strategy

Answer questions in these subreddits to build authority (don't self-promote directly):
- r/aws — cost optimization questions
- r/devops — infrastructure and cloud spend discussions
- r/sysadmin — AWS billing complaints
- r/cloudcomputing — general cloud cost topics
- r/startups, r/smallbusiness — "our AWS bill is too high" posts

### LinkedIn Ads

- **Account:** Cut My AWS (525710547)
- **Insight Tag:** 8785714 (installed via `app/plugins/linkedin.client.ts`)
- **Conversion:** Calendly Clicks V2 (Lead category, Direct API source) + booking_confirmed via useTracking (conversion_id: 26412858)

#### Campaign: CutMyAWS-V1 (General)

- **Objective:** Website visits, $15/day
- **Targeting:** Job titles (CTO, VP Engineering, Director of Engineering, Head of Infrastructure, Cloud Architect, DevOps Manager, VP of Operations, Engineering Manager) + Company size (11-50, 51-200, 201-500) + Skills (AWS, Cloud Computing, DevOps)
- **Ad format:** Single image ad (1200x627)
- **Ad copy headline:** "Your AWS Bill Is a Symptom. Let's Fix the Disease."
- **CTA:** Learn More
- **Landing page:** cutmyaws.com?utm_source=linkedin&utm_medium=paid&utm_campaign=cutmyaws-v1

#### Campaign: CutMyAWS - Investors (Seed/Series A)

- **Objective:** Website visits, $30/day
- **Targeting:** Job titles (Investor, Private Investor, Venture Partner, Venture Manager, Director New Venture, Managing Partner, Managing Principal, Managing Director) + US only + English
- **Ad format:** Single image ad (1200x627)
- **Landing page:** cutmyaws.com/investors
- **Conversion tracking:** Calendly Clicks V2
- **Audience size:** 1,200,000+

#### LinkedIn Ad Assets

| File | Size | Purpose |
|------|------|---------|
| `public/linkedin-ad.png` | 1200x627 | Single image ad (general campaign) |
| `public/linkedin-ad-investors.png` | 1200x627 | Single image ad (investors campaign) |
| `/tmp/linkedin-ad-image.html` | — | HTML template for general ad image |
| `/tmp/linkedin-ad-investors.html` | — | HTML template for investors ad image |

### Bing/Microsoft Ads

- **Account:** G145R2VD (david@phonelive.io)
- **Campaign:** CutMyAWS-V2 (imported from Google Ads)
- **UET Tag:** 343238663 (installed via `app/plugins/uet.client.ts`)
- **Conversion event:** `calendly_click` (custom event, fired on Calendly link clicks)
- **Budget:** $10/day
- **Promo:** Spend $250, get $500 free (valid through June 30, 2026)

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
