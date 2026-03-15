# Ad Budget, UTM Tracking & Conversions

## Budget: $100/day total (revised 2026-03-14)

| Platform | Campaigns | Daily Budget | Status |
|----------|-----------|-------------|--------|
| Google Ads (120-353-4001) | 7 campaigns | **$70/day** | **Active** |
| Reddit Ads (u/cutmyaws) | 3 campaigns | **$30/day** | **Active** |
| Bing/Microsoft Ads (G145R2VD) | CutMyAWS-V2 | $0/day | **Not working** |
| LinkedIn Ads (525710547) | 2 campaigns | $0/day | **All paused** |

**Strategy (2026-03-14):** All campaigns use conversion objective (not clicks/traffic). Google Investors is top performer. Reddit testing 3 campaigns at $10/day each with conversion objective — evaluate by 2026-03-28. If no bookings, kill Reddit and move $30/day to Google.

## UTM Parameter Standard

All ad platforms use consistent UTM params for GA4 reporting:

| Parameter | Purpose | Values |
|-----------|---------|--------|
| `utm_source` | Platform | `google`, `linkedin`, `reddit`, `bing` |
| `utm_medium` | Channel type | `cpc` (search), `paid` (social/display) |
| `utm_campaign` | Campaign name | `cutmyaws-investors`, `cutmyaws-v2`, `cutmyaws-symptom`, `cutmyaws-25pct`, `cutmyaws-human`, `cutmyaws-serverless`, `cutmyaws-audit`, `cutmyaws-natgateway` |
| `utm_content` | Ad variant (optional) | `ad1`, `ad2` for A/B testing |

**GA4 reporting:** Reports → Acquisition → Traffic acquisition → primary dimension: Session campaign, secondary: Session source/medium.

## Conversion Tracking

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

User interacts with video
  → video_{name}_{page}_{action} (e.g. video_intro_home_play, video_intro_book_pause)
  → Actions: ready, play, pause, buffer, progress_25/50/75, complete, speed_change, error
```

Plugins: `gtag.client.ts`, `uet.client.ts`, `linkedin.client.ts`, `reddit.client.ts`
Composable: `app/composables/useTracking.ts`

## Ad Platform Promos

| Platform | Offer | Status |
|----------|-------|--------|
| Google Ads | Spend $500, get $500 | Applied |
| Reddit Ads | Spend $500, get $500 | Applied |
| Microsoft/Bing | Spend $250, get $500 | Available (auto-applied at signup) |
