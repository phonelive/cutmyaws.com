# Reddit Ads

**Account:** u/cutmyaws
**Pixel ID:** a2_inkp2wvyvllm (installed via `app/plugins/reddit.client.ts`)
**Pixel events:** `PageVisit` (every page load), `Lead` (on /book or calendly.com link clicks + booking confirmation)
**Promo:** $500 spend-match credit (applied)

**Shared targeting (all campaigns):** Keywords (aws bill, aws cost, aws infrastructure, aws savings, cloud optimization, cloud spend, cloud waste, finops, reduce aws) + Communities (r/FinOps, r/SaaS, r/aws, r/cloudcomputing, r/devops, r/startups, r/sysadmin) + US only

## Old Campaigns (all paused/inactive)

| Campaign | Lifetime Performance | Status |
|----------|---------------------|--------|
| CutMyAWS-Investors (traffic) | 9,532 impr, 58 clicks, $0.59 CPC, 0.608% CTR, $34.40 spent | Inactive |
| Cut My AWS V1 (traffic) | 6,056 impr, 31 clicks, $1.00 CPC, 0.512% CTR, $30.87 spent | Inactive |
| CutMyAWS-Investors-Conversion | 174 impr, 1 click, $8.98 CPC, $51.62 eCPM, $8.98 spent | Inactive |

**Reddit total (as of Mar 17 EOD): 103 clicks, $166.75 spent, 0 bookings.** 20,235 impressions. If no bookings by 2026-03-28, kill Reddit ads entirely and move $30/day to Google. **11 days remain.**

### Changes (Mar 17)
- **25pct ad paused** — 1,332 impr, 2 clicks, 0.150% CTR, $30.23 spent. Dead weight.
- **NATGateway ad paused** — 1,343 impr, 4 clicks, 0.298% CTR, $30.80 spent. Underperforming.
- **Human is now the only active ad** — best performer at 0.389% CTR, $4.50 CPC, 7 clicks. All $30/day concentrated here.

## Active Ads (within CutMyAWS-Investors campaign, Ad group 1)

**Budget:** ~$30/day total for the campaign. Reddit rotates between the 3 active ad creatives.

### Ad 1: CutMyAWS-Human (ONLY ACTIVE AD)

- **Objective:** Conversions
- **Performance (as of Mar 17 EOD):** 1,798 impr, 7 clicks, $4.50 CPC, 0.389% CTR, $17.50 eCPM, $31.47 spent, 0 conversions
- **Headline:** Cloud cost tools show charts. I read your architecture and tell you what to change. Just David.
- **Image:** `public/reddit-ad-human.png` (1080x1080)
- **CTA:** Learn More
- **Landing:** `cutmyaws.com?utm_source=reddit&utm_medium=paid&utm_campaign=cutmyaws-human`

### Ad 2: CutMyAWS-NATGateway (PAUSED)

- **Objective:** Conversions
- **Performance (final):** 1,343 impr, 4 clicks, $7.70 CPC, 0.298% CTR, $22.93 eCPM, $30.80 spent, 0 conversions
- **Headline:** Your NAT Gateway costs more than your team's lunch budget. I find the charges nobody's watching.
- **Image:** `public/reddit-ad-natgateway.png` (1080x1080)
- **CTA:** Learn More
- **Landing:** `cutmyaws.com?utm_source=reddit&utm_medium=paid&utm_campaign=cutmyaws-natgateway`

### Ad 3: CutMyAWS-25pct (PAUSED)

- **Objective:** Conversions
- **Performance (final):** 1,332 impr, 2 clicks, $15.12 CPC, 0.150% CTR, $22.70 eCPM, $30.23 spent, 0 conversions
- **Headline:** Save 25% on your AWS bill in 90 days. No savings = no fee.
- **Image:** `public/reddit-ad-25pct.png` (1080x1080)
- **CTA:** Learn More
- **Landing:** `cutmyaws.com?utm_source=reddit&utm_medium=paid&utm_campaign=cutmyaws-25pct`

## Shelved Reddit Campaigns (activate if Reddit proves it can convert)

| Campaign | Headline | Image |
|----------|----------|-------|
| CutMyAWS-Symptom | Your AWS bill is a symptom. The disease is architecture nobody's touched in 3 years. | `reddit-ad-symptom.png` |
| CutMyAWS-Investors | Found $9K/mo in AWS waste for a startup last week. Their investors had no idea. | `reddit-ad-investors-v2.png` |

## Reddit Ad Assets

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

## Reddit Ad Image Generation

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

## Reddit Organic Strategy

Answer questions in these subreddits to build authority (don't self-promote directly):
- r/aws — cost optimization questions
- r/devops — infrastructure and cloud spend discussions
- r/sysadmin — AWS billing complaints
- r/cloudcomputing — general cloud cost topics
- r/startups, r/smallbusiness — "our AWS bill is too high" posts
