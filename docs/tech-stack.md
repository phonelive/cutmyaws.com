# Tech Stack

## Stack

| Component | Technology |
|-----------|-----------|
| Framework | Nuxt 4 (static generation) |
| CSS | Tailwind CSS |
| Hosting | GitHub Pages (free) |
| Domain | AWS Route 53 (cutmyaws.com) — registered in `pl` account, transfer to `cutmyaws` after 2026-03-23 |
| DNS | Route 53 hosted zone `Z10236932X9JIETO6LHWY` (cutmyaws account 731039145080) |
| Email | Google Workspace (cutmyaws.com as secondary domain) |
| Analytics | Google Analytics (`G-ZGPX081LFE`) via client plugin |
| Heatmaps | Microsoft Clarity (`vr2el2utus`) via client plugin |
| Booking | Calendly (inline embed on every page via `CalendlyEmbed.vue` component) |
| Deployment | GitHub Actions → GitHub Pages (auto on push to main) |

## Key Files

| File | Purpose |
|------|---------|
| `app/pages/index.vue` | The entire landing page (single page site) |
| `app/components/CalendlyEmbed.vue` | Reusable Calendly widget — embedded inline on every page with a booking CTA |
| `app/pages/book.vue` | Legacy Calendly page — kept for backward compat (existing ad links). New traffic uses inline embeds. |
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
| `public/david.png` | David's headshot (resized to 512px for web performance, original at `david-full.png`) |
| `public/david-full.png` | Original full-resolution headshot (1248x832, 1.1MB) — for ad images/print |
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

## Deployment

Push to `main` → GitHub Actions builds Nuxt static → deploys to GitHub Pages. Takes ~45 seconds.

## DNS Records (Route 53)

| Record | Type | Value |
|--------|------|-------|
| `cutmyaws.com` | A | GitHub Pages IPs (185.199.108-111.153) |
| `www.cutmyaws.com` | CNAME | `phonelive.github.io` |
| `cutmyaws.com` | MX | Google Workspace (5 records) |
| `cutmyaws.com` | TXT | SPF (`v=spf1 include:_spf.google.com ~all`) |
| `cutmyaws.com` | TXT | Google site verification |
| `_dmarc.cutmyaws.com` | TXT | DMARC (`v=DMARC1; p=quarantine`) |
| `google._domainkey.cutmyaws.com` | TXT | DKIM |
