# Reddit Ads

**Account:** u/cutmyaws
**Pixel ID:** a2_inkp2wvyvllm (installed via `app/plugins/reddit.client.ts`)
**Pixel events:** `PageVisit` (every page load), `Lead` (on form submit confirmation)
**Promo:** $500 spend-match credit (applied)

**Shared targeting (all campaigns):** Keywords (aws bill, aws cost, aws infrastructure, aws savings, cloud optimization, cloud spend, cloud waste, finops, reduce aws) + Communities (r/FinOps, r/SaaS, r/aws, r/cloudcomputing, r/devops, r/startups, r/sysadmin) + US only

## New Ad Copy (v2 — simplified voice, Mar 20 2026)

### Ad 1: CutMyAWS-FreeAudit (PRIMARY)

- **Objective:** Conversions
- **Headline:** Free AWS audit. I find the waste, you decide what to do about it. No savings = no fee.
- **Image:** Needs new creative — `public/reddit-ad-freeaudit.png` (1080x1080)
- **CTA:** Learn More
- **Landing:** `cutmyaws.com?utm_source=reddit&utm_medium=paid&utm_campaign=cutmyaws-freeaudit`

### Ad 2: CutMyAWS-GuaranteedROI

- **Objective:** Conversions
- **Headline:** Guaranteed ROI on your AWS bill. Free audit. You only pay a % of actual savings.
- **Image:** Needs new creative — `public/reddit-ad-guaranteedroi.png` (1080x1080)
- **CTA:** Learn More
- **Landing:** `cutmyaws.com?utm_source=reddit&utm_medium=paid&utm_campaign=cutmyaws-guaranteedroi`

### Ad 3: CutMyAWS-NotADashboard

- **Objective:** Conversions
- **Headline:** Cloud cost tools show charts. I read your architecture and tell you what to fix. Audit is free.
- **Image:** `public/reddit-ad-human.png` (1080x1080) (reuse existing)
- **CTA:** Learn More
- **Landing:** `cutmyaws.com?utm_source=reddit&utm_medium=paid&utm_campaign=cutmyaws-notadashboard`

### Recommendation

Start with **FreeAudit** as the only active ad at $30/day. "Free audit" is the strongest hook now that pricing is hidden. If it performs, add GuaranteedROI and NotADashboard to test.

---

## Budget & Performance

| Ad | Budget | Status | Performance (as of Mar 23) |
|----|--------|--------|---------------------------|
| v3-reddit (FreeAudit) | $30/day | Active | 4,695 impr, 33 clicks, $2.42 CPC, 0.703% CTR, $79.88 spent, 0 conv |
| GuaranteedROI | — | Ready to test | — |
| NotADashboard | — | Ready to test | — |
| **Total** | **$30/day** | | |

## Old Campaigns (all paused/inactive)

| Campaign | Lifetime Performance | Status |
|----------|---------------------|--------|
| CutMyAWS-Human | 4,355 impr, 12 clicks, $5.38 CPC, 0.276% CTR, $64.52 spent, 0 conv | Inactive |
| CutMyAWS-NATGateway | 1,347 impr, 4 clicks, $7.71 CPC, 0.297% CTR, $30.85 spent, 0 conv | Inactive |
| CutMyAWS-25pct | 1,346 impr, 2 clicks, $15.32 CPC, 0.149% CTR, $30.65 spent, 0 conv | Inactive |
| CutMyAWS-Investors-Conversion | 174 impr, 1 click, $8.98 CPC, $8.98 spent, 0 conv | Inactive |
| CutMyAWS-Investors (traffic) | 9,532 impr, 58 clicks, $0.59 CPC, 0.608% CTR, $34.40 spent | Inactive |
| Cut My AWS V1 (traffic) | 6,056 impr, 31 clicks, $1.00 CPC, 0.512% CTR, $30.87 spent | Inactive |

**Reddit total (as of Mar 23): 141 clicks, $280.14 spent, 0 bookings.** 27,505 impressions, $1.99 avg CPC, 0.513% CTR. Kill deadline: 2026-03-28. **5 days remain.**

## Reddit Ad Assets

| File | Size | Purpose |
|------|------|---------|
| `public/reddit-ad-human.png` | 1080x1080 | Human vs dashboard (reusable) |
| `public/reddit-ad-freeaudit.png` | 1080x1080 | Free audit campaign (TODO: create) |
| `public/reddit-ad-guaranteedroi.png` | 1080x1080 | Guaranteed ROI campaign (TODO: create) |
| `public/reddit-ad-symptom.png` | 1080x1080 | Old symptom campaign |
| `public/reddit-ad-25pct.png` | 1080x1080 | Old 25% campaign |
| `public/reddit-ad-natgateway.png` | 1080x1080 | Old NAT Gateway campaign |
| `public/reddit-ad-investors-v2.png` | 1080x1080 | Old investor campaign |
| `public/reddit-ad-thumb.png` | 400x300 | Ad thumbnail |
| `public/reddit-banner.png` | 1920x576 | Profile banner |
| `public/david-reddit.jpg` | 832x832 | Profile picture |

## Reddit Ad Image Generation

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

## Reddit Organic Strategy

Answer questions in these subreddits to build authority (don't self-promote directly):
- r/aws — cost optimization questions
- r/devops — infrastructure and cloud spend discussions
- r/sysadmin — AWS billing complaints
- r/cloudcomputing — general cloud cost topics
- r/startups, r/smallbusiness — "our AWS bill is too high" posts
