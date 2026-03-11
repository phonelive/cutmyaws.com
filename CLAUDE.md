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
| MS Clarity | vr2el2utus |

## Founder

**David Plappert** — Senior AWS Serverless Architect with 19 years of AWS experience (since AWS launched in 2006). Builds and runs production serverless SaaS at Fortune 100 scale. Currently consulting at Caterpillar. Also founder of EZRA Cloud (church expense management SaaS) and PhoneLive (live streaming platform).

## What CutMyAWS Does

Business-aligned AWS technology audit and cost optimization for small and medium businesses spending **$5K-$150K/month** on AWS. Not just cost cutting — finding the mismatch between tech and business needs. The savings are a side effect of getting that alignment right.

**Key differentiator:** David is a real person who reads your architecture, understands your business, and tells you exactly what to change and why. Not a dashboard. Not an AI. Not a junior analyst with a checklist.

## Target Audience

- Small and medium businesses spending **$5,000 to $150,000/month** on AWS
- Below $5K: not enough waste to justify an engagement
- Above $150K: likely needs a full-time FinOps team
- Sweet spot: companies big enough to have real infrastructure but too busy building product to optimize it
- Addressable US market: ~75,000-113,000 accounts

## Pricing

All pricing is centralized in `app/pages/index.vue` in the `pricing` object:

```js
const pricing = {
  reportPct: 15,      // The Report: 15% of annual savings found
  fixPct: 50,         // The Fix: 50% total (15% report + 35% implementation)
  implPct: 35,        // Implementation portion (fixPct - reportPct)
  minAws: 5000,       // We work best with $5K/mo+ AWS spend
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
         📊 THE PROOF       +35% of VERIFIED savings due
                            (no savings = $0 owed)

Max total: 50% (15% report + 35% implementation)
```

### Example ($25K/mo AWS spend, 30% waste found)

| Phase | Amount |
|-------|-------:|
| Intro Call | Free |
| Exploration Call (15% of $108K) | $16,200 |
| 90 Days After Implementation (+35%) | $37,800 |
| **Total max (50%)** | **$54,000** |
| **Client keeps year 1** | **$54,000** |
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
| `app/plugins/gtag.client.ts` | Google Analytics plugin |
| `app/plugins/clarity.client.ts` | Microsoft Clarity plugin |
| `nuxt.config.ts` | Meta tags, SEO, structured data, OG tags |
| `public/logos/` | Client logos (8 logos, PNG/SVG) |
| `public/david.png` | David's headshot |
| `public/og-image.png` | Social sharing preview image (1200x630) |
| `public/robots.txt` | Search + AI crawler permissions |
| `public/sitemap.xml` | Search engine sitemap |
| `public/llms.txt` | AI/LLM-readable service description |
| `public/CNAME` | GitHub Pages custom domain |
| `.github/workflows/deploy.yml` | Auto-deploy on push |
| `/tmp/og-template.html` | HTML template used to generate og-image.png via Playwright |

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
- `Service` (The Fix) — 35% implementation service
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
| LinkedIn (personal) | **Active** | Primary channel |
| YouTube | Future (month 2-3) | Record exploration calls as case studies |
| Dev.to / Hashnode | Future | Technical deep-dives for SEO |
| Twitter/X | Maybe later | DevOps community exists but slower |
| Facebook/Instagram/TikTok | Skip | Wrong audience |

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
| Big consulting | Duckbill Group, Accenture, KPMG | They target $1M+ spends. We target $10-150K. |
| SaaS dashboards | ProsperOps, CloudHealth, Vantage, nOps | They show charts. We read architecture + business. |
| Boutique consultants | Miro, Rambunct, SUDO, StableLogic | None publish pricing. We're fully transparent. |

**Nobody else offers:** transparent % pricing, free intro call, human consulting for $10-150K/mo, witty brand, verified-savings implementation fee.

## OG Image Generation

The social sharing image (`public/og-image.png`) is generated using Playwright screenshotting an HTML template:

```bash
# Template at /tmp/og-template.html
npx playwright screenshot --viewport-size="1200,630" --full-page /tmp/og-template.html public/og-image.png
```

To regenerate: edit `/tmp/og-template.html` and re-run the command. Requires Playwright with Chromium installed.

## Compact Instructions

When compacting, preserve pricing structure, brand voice rules, and key file paths.
