# CLAUDE.md — CutMyAWS.com

> Full details in `docs/` — this file has highlights and references.

## Quick Reference

| | Value |
|--|--|
| **Company** | Smart Talk LLC dba Cut My AWS |
| **Domain** | cutmyaws.com |
| **Founder** | David Plappert — 19 years AWS, Senior Serverless Architect |
| **What** | Business-aligned AWS cost audit & optimization for $5K+/mo spenders |
| **Differentiator** | Not a dashboard. Not an AI. Just David. |
| **Framework** | Nuxt 4 (static) + Tailwind CSS on S3 + CloudFront |
| **Deployment** | Push to `main` → dev, git tag → prod (GitHub Actions → S3 + CloudFront) |

## Pricing

Specific pricing percentages are **not published on the website**. Pricing is discussed during the engagement after the client sees the audit findings.

| | Public messaging |
|--|-----|
| **Audit** | Free |
| **Fee** | Percentage of verified savings — discussed during engagement |
| **No savings** | No fee |

**Internal reference only (not shown on site):** 75% of verified savings, $500/hr overage. See [docs/products-pricing.md](docs/products-pricing.md) for full internal details.

Pricing constants are in `app/composables/usePricing.ts` (minAws, overageRate only — percentages removed from site).

→ Full details: [docs/products-pricing.md](docs/products-pricing.md)

## Brand Voice

Witty, humorous, confident — never condescending. AWS is the villain, not the customer. Emojis encouraged. Short and punchy. Self-deprecating > arrogant.

**Key phrases:** "AWS cost therapy" · "Not a dashboard. Not an AI. Just David." · "No savings? No fee." · "19 years of AWS"

→ Full details: [docs/brand-voice.md](docs/brand-voice.md)

## Design

Dark-mode only. Brand orange `#f97316`. Background `#030712`. Logo: `✂️ Cut My AWS` (scissors emoji = logo).

→ Full details: [docs/design.md](docs/design.md) (colors, typography, client logos, OG image, promo)

## Tech Stack & Key Files

| File | Purpose |
|------|---------|
| `app/pages/index.vue` | Entire landing page + pricing object |
| `app/components/CalendlyEmbed.vue` | Inline Calendly widget (on every page) |
| `app/composables/useTracking.ts` | Unified event tracking (GA4 + UET + LinkedIn + Reddit) |
| `app/pages/confirmed.vue` | Post-booking conversion page |
| `nuxt.config.ts` | Meta tags, SEO, structured data |
| `app/plugins/*.client.ts` | Analytics/tracking plugins (gtag, clarity, uet, linkedin, reddit) |

→ Full details: [docs/tech-stack.md](docs/tech-stack.md) (all files, DNS, deployment)

## Client Audit Infrastructure

Cross-account IAM role assumption: `pl` → `cutmyaws` → `cutmyaws-<client>`. Client deploys CloudFormation stack (`audit/client-role.yaml`) to grant read-only access with external ID.

→ Full details: [docs/audit.md](docs/audit.md) (accounts, CLI profiles, onboarding flow, audit commands)

## SEO & AI Optimization

Schema.org JSON-LD in `nuxt.config.ts`. AI crawlers allowed in `robots.txt`. `llms.txt` for AI systems.

→ Full details: [docs/seo.md](docs/seo.md)

## Paid Advertising — $90/day total

| Platform | Budget | Status | Details |
|----------|--------|--------|---------|
| Google Ads (120-353-4001) | $60/day, 2 active (5 paused) | Active | [docs/ads-google.md](docs/ads-google.md) |
| Reddit Ads (u/cutmyaws) | $30/day, 1 active ad (Human only) | Active (testing) | [docs/ads-reddit.md](docs/ads-reddit.md) |
| LinkedIn Ads (525710547) | $0/day | All paused | [docs/ads-other.md](docs/ads-other.md) |
| Bing/Microsoft (G145R2VD) | $0/day | Not working | [docs/ads-other.md](docs/ads-other.md) |

**Google (as of Mar 17 EOD):** $213.60 spent, 125 clicks, 4 conversions, $53.40 avg CPA, 11.70% CTR. Investors ($45/day, 3 conv) + Serverless ($15/day, 1 conv, best CPA $25.58). V2 paused.
**Reddit (as of Mar 17 EOD):** $166.75 spent, 103 clicks, 0 bookings. Only Human ad active ($30/day, 7 clicks, 0.389% CTR). 25pct and NATGateway paused. Kill deadline: 2026-03-28. **11 days remain.**

→ UTM standards, conversion tracking, promos: [docs/ads-tracking.md](docs/ads-tracking.md)

## Conversion Funnel

```
Ad → Landing page → Scroll to #book (inline Calendly) → Book
  → calendly.event_scheduled → /confirmed?invitee_full_name=...
    → trackEvent('booking_confirmed') → GA4 + UET + LinkedIn + Reddit
```

Primary conversion: `booking_confirmed` (GA4 import). All CTAs use `href="#book"` for smooth scroll.

→ Full details: [docs/conversion.md](docs/conversion.md)

## Social Media

LinkedIn personal profile is primary organic channel (2x/week). YouTube (@CutMyAWS) for case studies. Reddit organic for authority building.

→ Full details: [docs/social-media.md](docs/social-media.md) (content bank, YouTube scripts, investor campaign)

## Revenue Model — Path to $1M

| Metric | Value |
|--------|-------|
| Avg engagement revenue | ~$75K |
| Clients needed | ~14 |
| Monthly costs | ~$3K |
| Target margin | 96% |

**Back-loaded:** Fees arrive after implementation verification. Months 7-12 is where the big checks land.

**Annual Checkup:** ~33% of clients return every 12-24 months. Same pricing, no discount. ~$25K avg repeat engagement. Creates $300K+ annual floor by Year 3.

→ Full details: [docs/revenue.md](docs/revenue.md) (scenarios, monthly cadence, funnel targets, milestones)

## Hiring

First hire: 1099 AWS Implementation Contractor around month 4-5 (Jun-Jul 2026). Executes optimizations from David's audits. Start hourly ($125-175/hr), shift to revenue share (20-30%). Doubles capacity from 2-3 to 5-7 concurrent engagements.

→ Full details: [docs/hiring.md](docs/hiring.md)

## Company & Account IDs

| Service | ID |
|---------|-----|
| Google Analytics | G-ZGPX081LFE |
| Google Tag | GT-K8KHLNZJ |
| MS Clarity | vr2el2utus |
| Google Ads | 120-353-4001 |
| Reddit Pixel | a2_inkp2wvyvllm |
| Microsoft Ads | G145R2VD |
| UET Tag | 343238663 |
| LinkedIn Company | 525710547 |
| LinkedIn Insight | 8785714 |
| Stripe | acct_1TA6p5E7PhfaMBf2 |
| AWS Account | 731039145080 |
| AWS Org | 734267377938 |
| Route 53 Zone (cutmyaws.com) | Z10236932X9JIETO6LHWY (cutmyaws acct) |
| Route 53 Zone (cutmyazure.com) | Z069219924T1FMI64PIIU (cutmyaws acct) |
| Calendly | calendly.com/phonelivestreaming/cutmyaws-com-intro |

→ Full details: [docs/company.md](docs/company.md) (founder bio, target audience, competitive landscape, email deliverability)

## Compact Instructions

When compacting, preserve: pricing approach (free audit, percentage of verified savings, no savings = no fee), brand voice rules, key file paths, conversion funnel architecture, ad platform account IDs/budgets, and the $1M revenue model. Refer to `docs/` files for full details.
