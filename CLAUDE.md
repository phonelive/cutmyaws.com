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
| **Framework** | Nuxt 4 (static) + Tailwind CSS on GitHub Pages |
| **Deployment** | Push to `main` → GitHub Actions → GitHub Pages (~45s) |

## Products & Pricing

| Product | Fee | Deposit |
|---------|-----|---------|
| **The Report** | 15% of annual savings | 1% of AWS annual spend |
| **The Fix** | 60% of verified savings | 4% of AWS annual spend |
| **Max total** | 75% (15% + 60%) | — |

Pricing is centralized in `app/pages/index.vue` in the `pricing` object. Change in ONE place.

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

## Paid Advertising — $100/day total

| Platform | Budget | Status | Details |
|----------|--------|--------|---------|
| Google Ads (120-353-4001) | $70/day, 7 campaigns | Active | [docs/ads-google.md](docs/ads-google.md) |
| Reddit Ads (u/cutmyaws) | $30/day, 3 campaigns | Active (testing) | [docs/ads-reddit.md](docs/ads-reddit.md) |
| LinkedIn Ads (525710547) | $0/day | All paused | [docs/ads-other.md](docs/ads-other.md) |
| Bing/Microsoft (G145R2VD) | $0/day | Not working | [docs/ads-other.md](docs/ads-other.md) |

**Top performer:** Google Investors ($40/day, 12.06% CTR, 1 real conversion — 2 of 3 were false from code issues)
**Reddit deadline:** If 0 bookings by 2026-03-28, kill Reddit ads and move $30/day to Google.

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
| Avg engagement revenue | ~$75K (Report + Fix) |
| Clients needed | ~20 (at 50% Fix conversion) |
| Monthly costs | ~$3K |
| Target margin | 96% |

**Back-loaded:** Fix fees ($52-65K) arrive 90 days post-implementation. Months 7-12 is where the big checks land.

**Annual Checkup:** ~33% of clients return every 12-24 months. Same pricing, no discount. ~$25K avg repeat engagement. Creates $300K+ annual floor by Year 3.

→ Full details: [docs/revenue.md](docs/revenue.md) (scenarios, monthly cadence, funnel targets, milestones)

## Hiring

First hire: 1099 AWS Implementation Contractor around month 4-5 (Jun-Jul 2026). Executes Fix optimizations from David's Reports. Start hourly ($125-175/hr), shift to revenue share (20-30%). Doubles Fix capacity from 2-3 to 5-7 concurrent engagements.

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
| Route 53 Zone | Z094524813GXW2EAFA9GE |
| Calendly | calendly.com/phonelivestreaming/cutmyaws-com-intro |

→ Full details: [docs/company.md](docs/company.md) (founder bio, target audience, competitive landscape, email deliverability)

## Compact Instructions

When compacting, preserve: pricing structure (15%/75%), brand voice rules, key file paths, conversion funnel architecture, ad platform account IDs/budgets, and the $1M revenue model. Refer to `docs/` files for full details.
