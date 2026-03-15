# LinkedIn & Bing Ads

## LinkedIn Ads (ALL PAUSED as of 2026-03-14)

- **Account:** Cut My AWS (525710547)
- **Insight Tag:** 8785714 (installed via `app/plugins/linkedin.client.ts`)
- **Conversion:** Calendly Clicks V2 (Lead category, Direct API source) + booking_confirmed via useTracking (conversion_id: 26412858)
- **Status:** All campaigns paused to stay within $100/day budget

### Campaign: New Campaign Group (General) — ID: 998926464 — PAUSED

- **Objective:** Website visits, was $15/day
- **Targeting:** Job titles (CTO, VP Engineering, Director of Engineering, Head of Infrastructure, Cloud Architect, DevOps Manager, VP of Operations, Engineering Manager) + Company size (11-50, 51-200, 201-500) + Skills (AWS, Cloud Computing, DevOps)
- **Landing page:** cutmyaws.com?utm_source=linkedin&utm_medium=paid&utm_campaign=cutmyaws-v1

### Campaign: CutMyAWS - Investors — ID: 1000806254 — PAUSED

- **Objective:** Website visits, was $30/day
- **Targeting:** Job titles (Investor, Private Investor, Venture Partner, Managing Partner, Managing Director, General Partner) + US only
- **Landing page:** cutmyaws.com/investors?utm_source=linkedin&utm_medium=paid&utm_campaign=cutmyaws-investors

### LinkedIn Ad Assets

| File | Size | Purpose |
|------|------|---------|
| `public/linkedin-ad.png` | 1200x627 | Single image ad (general campaign) |
| `public/linkedin-ad-investors.png` | 1200x627 | Single image ad (investors campaign) |

## Bing/Microsoft Ads (NOT WORKING as of 2026-03-14)

- **Account:** G145R2VD (david@phonelive.io)
- **Campaign:** CutMyAWS-V2 (imported from Google Ads)
- **UET Tag:** 343238663 (installed via `app/plugins/uet.client.ts`)
- **Conversion event:** `calendly_click` (custom event, fired on Calendly link clicks)
- **Budget:** was $10/day
- **Status:** Not delivering — needs investigation
- **Promo:** Spend $250, get $500 free (valid through June 30, 2026)
