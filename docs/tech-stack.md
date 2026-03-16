# Tech Stack

## Stack

| Component | Technology |
|-----------|-----------|
| Framework | Nuxt 4 (static generation) |
| CSS | Tailwind CSS |
| Hosting | S3 + CloudFront (cutmyaws account) |
| Domain | AWS Route 53 (cutmyaws.com) — registered in `pl` account, transfer to `cutmyaws` after 2026-03-23 |
| DNS | Route 53 hosted zone `Z10236932X9JIETO6LHWY` (cutmyaws account 731039145080) |
| Email | Google Workspace (cutmyaws.com as secondary domain) + AWS SES (cutmyaws acct, us-east-1) |
| Analytics | Google Analytics (`G-ZGPX081LFE`) via client plugin |
| Heatmaps | Microsoft Clarity (`vr2el2utus`) via client plugin |
| Booking | Calendly (inline embed on every page via `CalendlyEmbed.vue` component) |
| Deployment | GitHub Actions → S3 sync + CloudFront invalidation (auto on push to main) |

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

Push to `main` → GitHub Actions builds Nuxt static → syncs to S3 → invalidates CloudFront.

All deploys via GitHub Actions only (no CLI deploys). Uses `github-deploy` IAM user credentials stored as GitHub secrets (`AWS_ACCESS_KEY_ID_CUTMYAWS`, `AWS_SECRET_ACCESS_KEY_CUTMYAWS`).

## DNS Records (Route 53 — zone Z10236932X9JIETO6LHWY in cutmyaws acct)

| Record | Type | Value |
|--------|------|-------|
| `cutmyaws.com` | A | GitHub Pages IPs (185.199.108-111.153) |
| `www.cutmyaws.com` | CNAME | `phonelive.github.io` |
| `cutmyaws.com` | MX | Google Workspace (5 records) |
| `cutmyaws.com` | TXT | SPF (`v=spf1 include:_spf.google.com include:amazonses.com ~all`) |
| `cutmyaws.com` | TXT | Google site verification |
| `_dmarc.cutmyaws.com` | TXT | DMARC (`v=DMARC1; p=quarantine`) |
| `google._domainkey.cutmyaws.com` | TXT | Google Workspace DKIM |
| `*._domainkey.cutmyaws.com` | CNAME | 3 SES DKIM records (`*.dkim.amazonses.com`) |
| `track.cutmyaws.com` | CNAME | `r.us-east-1.awstrack.me` (SES open/click tracking) |
| `_*.cutmyaws.com` | CNAME | ACM validation for cutmyaws.com + *.cutmyaws.com |
| `_*.dev.cutmyaws.com` | CNAME | ACM validation for *.dev.cutmyaws.com |

## AWS Infrastructure (cutmyaws account 731039145080)

| Resource | ID / ARN | Region |
|----------|----------|--------|
| S3 Bucket (prod) | `cutmyaws-com` | us-east-1 |
| S3 Bucket (dev) | `dev-cutmyaws-com` | us-east-1 |
| CloudFront (prod) | `E1QP2X8FI34J2A` → cutmyaws.com, www.cutmyaws.com | us-east-1 |
| CloudFront (dev) | `E3AM3WI3FESOBD` → dev.cutmyaws.com | us-east-1 |
| CloudFront OAC | `E3MY3M484PPXUC` (cutmyaws-s3-oac) | — |
| ACM Cert | `arn:aws:acm:us-east-1:731039145080:certificate/4380f959-075b-47e1-a5c4-a563f2b9aa35` | us-east-1 |
| ACM SANs | cutmyaws.com, *.cutmyaws.com, *.dev.cutmyaws.com | — |
| SES Domain | cutmyaws.com (DKIM verified, DMARC quarantine) | us-east-1 |
| SES Config Set | `cutmyaws-tracking` (open, click, delivery, bounce, complaint) | us-east-1 |
| SNS Topic | `arn:aws:sns:us-east-1:731039145080:cutmyaws-ses-events` | us-east-1 |
| SES Production | Pending review (sandbox: 200 emails/day) | us-east-1 |
| S3 Logs Bucket | `cutmyaws-logs` (90-day lifecycle expiry) | us-east-1 |
| SNS Site Alerts | `arn:aws:sns:us-east-1:731039145080:cutmyaws-site-alerts` | us-east-1 |
| CW Alarm | `cutmyaws-prod-5xx-errors` (>5% 5xx for 5min) | us-east-1 |
| CW Alarm | `cutmyaws-prod-4xx-errors` (>25% 4xx for 10min) | us-east-1 |

### Logging

| Source | Destination | Prefix |
|--------|-------------|--------|
| S3 `cutmyaws-com` access logs | `cutmyaws-logs` | `s3/cutmyaws-com/` |
| S3 `dev-cutmyaws-com` access logs | `cutmyaws-logs` | `s3/dev-cutmyaws-com/` |
| CloudFront prod standard logs | `cutmyaws-logs` | `cloudfront/prod/` |
| CloudFront dev standard logs | `cutmyaws-logs` | `cloudfront/dev/` |
| CloudFront real-time metrics | CloudWatch (`AWS/CloudFront`) | — |

### Environment DNS Plan

| Subdomain | Purpose |
|-----------|---------|
| `cutmyaws.com` | Production site (currently GitHub Pages, future S3+CloudFront) |
| `dev.cutmyaws.com` | Dev environment site |
| `api.cutmyaws.com` | Production API Gateway |
| `api.dev.cutmyaws.com` | Dev API Gateway |
| `track.cutmyaws.com` | SES open/click tracking |
