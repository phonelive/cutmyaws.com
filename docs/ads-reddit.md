# Reddit Ads

**Account:** u/cutmyaws
**Pixel ID:** a2_inkp2wvyvllm (installed via `app/plugins/reddit.client.ts`)
**Pixel events:** `PageVisit` (every page load), `Lead` (on /book or calendly.com link clicks + booking confirmation)
**Promo:** $500 spend-match credit (applied)

**Shared targeting (all campaigns):** Keywords (aws bill, aws cost, aws infrastructure, aws savings, cloud optimization, cloud spend, cloud waste, finops, reduce aws) + Communities (r/FinOps, r/SaaS, r/aws, r/cloudcomputing, r/devops, r/startups, r/sysadmin) + US only

## Old Campaigns (all paused/inactive)

| Campaign | Lifetime Performance | Status |
|----------|---------------------|--------|
| CutMyAWS-Investors (traffic) | 9,532 impr, 58 clicks, $0.59 CPC, 0.608% CTR, $34.40 spent | Inactive (cheap clicks, 0 bookings) |
| Cut My AWS V1 (traffic) | 6,056 impr, 31 clicks, $1.00 CPC, 0.512% CTR, $30.87 spent | Inactive (cheap clicks, 0 bookings) |
| CutMyAWS-Investors-Conversion | 174 impr, 1 click, $8.98 CPC, $51.62 eCPM, $8.98 spent | Inactive (conversion obj failed at low budget) |

**Reddit total (Mar 1-16): 94 clicks, $127.18 spent, 0 bookings.** 17,766 impressions, $1.35 CPC, 0.529% CTR. Testing 3 new conversion campaigns at $10/day each. If no bookings by 2026-03-28, kill Reddit ads entirely and move $30/day to Google.

### Recommendations (as of Mar 16)
- **Pause CutMyAWS-25pct:** 563 impr, 0 clicks, highest eCPM ($31.13) of 3 active campaigns. Zero engagement. Redistribute $10/day to Human or NATGateway.
- **Verify geo-targeting:** Clarity shows ~20% non-US sessions. Confirm US-only targeting on all campaigns (shared targeting says US only — may be Search Partners or VPN traffic).

## Campaign 1: CutMyAWS-25pct — $10/day (NEW 2026-03-14)

- **Objective:** Conversions
- **Performance (Mar 1-16):** 563 impr, 0 clicks, $31.13 eCPM, $17.53 spent, 0 conversions
- **Headline:** Save 25% on your AWS bill in 90 days. No savings = no fee.
- **Image:** `public/reddit-ad-25pct.png` (1080x1080)
- **CTA:** Learn More
- **Landing:** `cutmyaws.com?utm_source=reddit&utm_medium=paid&utm_campaign=cutmyaws-25pct`

## Campaign 2: CutMyAWS-NATGateway — $10/day (NEW 2026-03-14)

- **Objective:** Conversions
- **Performance (Mar 1-16):** 683 impr, 2 clicks, $9.16 CPC, 0.293% CTR, $26.83 eCPM, $18.33 spent, 0 conversions
- **Headline:** Your NAT Gateway costs more than your team's lunch budget. I find the charges nobody's watching.
- **Image:** `public/reddit-ad-natgateway.png` (1080x1080)
- **CTA:** Learn More
- **Landing:** `cutmyaws.com?utm_source=reddit&utm_medium=paid&utm_campaign=cutmyaws-natgateway`

## Campaign 3: CutMyAWS-Human — $10/day (NEW 2026-03-14)

- **Objective:** Conversions
- **Performance (Mar 1-16):** 758 impr, 2 clicks, $8.54 CPC, 0.264% CTR, $22.54 eCPM, $17.08 spent, 0 conversions
- **Headline:** Cloud cost tools show charts. I read your architecture and tell you what to change. Just David.
- **Image:** `public/reddit-ad-human.png` (1080x1080)
- **CTA:** Learn More
- **Landing:** `cutmyaws.com?utm_source=reddit&utm_medium=paid&utm_campaign=cutmyaws-human`

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
