# Booking & Conversion Architecture (updated 2026-03-14)

## Inline Calendly Embed (no more /book redirect)

Every page with a booking CTA now has Calendly embedded inline via `CalendlyEmbed.vue`. Users scroll to `#book` instead of navigating to `/book`. This eliminates one click from the funnel.

**Component:** `app/components/CalendlyEmbed.vue`
- Props: `campaign` (string, for UTM tracking)
- Loads Calendly widget script (deduplicated — only loads once)
- Listens for `calendly.event_scheduled` message → extracts invitee name/email → redirects to `/confirmed`
- Responsive: 1300px height on mobile, 950px on desktop

**Pages with inline Calendly:**
- Homepage (`campaign="homepage"`) — after How It Works section
- Investors (`campaign="investors"`) — after How It Works
- Government (`campaign="government"`) — after How It Works
- Referrals (`campaign="referral"`) — replaces bottom CTA
- Hire (`campaign="hire"`) — replaces bottom CTA
- Agreements (`campaign="agreements"`) — replaces bottom CTA
- Calculate Savings (`campaign="calculate-savings"`) — at bottom

**All CTAs site-wide** (hero, mid-page, nav, footer, mobile sticky, promo banner) use `href="#book"` for smooth scroll.

**`/book` page is kept** for backward compatibility — existing ad URLs and bookmarks still work.

## Conversion Funnel

```
Ad impression (Google/Reddit)
  → Click → Landing page (homepage, /investors, /government)
    → Scroll to #book (Calendly inline embed)
      → User selects time + enters info in Calendly
        → calendly.event_scheduled fires
          → Redirect to /confirmed?invitee_full_name=...
            → IF name present: trackEvent('booking_confirmed')
              → GA4 + Bing UET + LinkedIn (26412858) + Reddit (Lead)
            → IF no name: trackEvent('confirmed_page_view') (not a conversion)
```

**Google Ads primary conversion:** `booking_confirmed` (GA4 import, Primary action under Book appointment goal). Old `manual_event_SUBMIT_LEAD_FORM` demoted to Secondary.

## Microsoft Clarity Insights (Mar 1-16, 2026)

**Dashboard:** MS Clarity (vr2el2utus)

### Traffic Sources (sessions)
| Source | Sessions | Notes |
|--------|----------|-------|
| Google | 92 | Paid search (dominant) |
| syndicatedsearch.goog | 11 | Google Search Partners |
| Direct | 6 | Bookmarks/typed URL |
| LinkedIn | 6 | Likely Botdog outreach clicks |
| cutmyazure.com | 6 | Referral — future Azure version of CutMyAWS (same model). Add UTM params to cross-link. |
| Reddit | 5 | Paid social |

### Campaign Sessions (paid traffic)
| Campaign | Sessions | Notes |
|----------|----------|-------|
| cutmyaws-serverless | 18 | Top paid campaign by engagement |
| cutmyaws-human | 3 | Google paused, low volume |
| cutmyaws-symptom | 3 | Google paused |
| cutmyaws-25pct | 2 | Google paused |
| cutmyaws-investors-conversion | 1 | Reddit inactive |
| cutmyaws-natgateway | 1 | Reddit active |

### Browser Distribution (critical insight)
| Browser | % | Sessions | Implications |
|---------|---|----------|-------------|
| **FacebookApp** | **35.34%** | **47** | LinkedIn in-app browser (from Botdog outreach on mobile). NOT actual Facebook traffic. |
| Chrome | 28.57% | 38 | Desktop |
| ChromeMobile | 15.79% | 21 | Mobile Chrome |
| MobileSafari | 13.53% | 18 | iPhone Safari |
| Other | 6.77% | 9 | — |

**~65% of traffic is mobile.** Site must be fast and optimized for mobile-first.

### Region
| Country | % | Sessions |
|---------|---|----------|
| United States | 79.70% | 106 |
| Spain | 6.02% | 8 |
| India | 4.51% | 6 |
| Mexico | 2.26% | 3 |
| Netherlands | 2.26% | 3 |

**~20% non-US traffic.** Verify all campaign geo-targeting is US-only.

### Page Performance (Clarity Core Web Vitals)
| URL | Score | LCP | INP | CLS | Issue |
|-----|-------|-----|-----|-----|-------|
| /investors/ | **90** | 2.1s | 320ms | 0 | INP needs work |
| / | **80** | **5.4s** | 320ms | **0.15** | **LCP critical**, CLS bad |

**Root causes & fixes:**
- **Homepage LCP 5.4s:** `david.png` was 1.1MB, loaded in hero as 112px image. **FIXED 2026-03-16:** Resized to 512px (209KB), added `fetchpriority="high"` and explicit `width`/`height`. Expected LCP drop to ~2s.
- **Homepage CLS 0.15:** Calendly widget height jumps (starts at CSS default 1300px, then resizes via postMessage). Images without explicit dimensions. **PARTIAL FIX 2026-03-16:** Added `width`/`height` to all `david.png` images. Calendly height tuning still needed.
- **INP 320ms (both pages):** Heavy JS: YouTube API, Calendly widget, 4 analytics plugins, ticker animation. **TODO:** Lazy-load YouTube embed (click-to-play poster) to remove ~500KB third-party JS from initial load.

### Funnel Leak Analysis
| Page | Views | Entry | Exit |
|------|-------|-------|------|
| / | 67 | 62 | 63 |
| /investors/ | 66 | 65 | 63 |
| /book/ | 6 | 5 | 5 |
| /bookMore | 1 | 1 | 1 |
| /confirmed | 1 | — | 1 |

**Conversion rate: ~0.75%** (1 confirmed booking from 133 landing page sessions). Note: Calendly is inline on landing pages, so /book/ visits are from old links or direct nav.

### JavaScript Errors (1.50% error rate)
| Error | % | Cause |
|-------|---|-------|
| `null is not an object (evaluating 'e.contentwindow.postmessage')` | 75% | Calendly iframe not yet loaded when postMessage fires. Especially on mobile in-app browsers (FacebookApp/LinkedIn). |
| `error invoking postmessage: java object is gone` | 25% | Calendly iframe navigated/destroyed mid-message. Mobile browser lifecycle issue. |

**Fix:** These are Calendly widget errors, not our code. They fire inside the Calendly iframe. No action needed unless they increase.

## GA4 User Acquisition (Mar 2-15, 2026)

| # | Channel | Users | New | Returning | Avg Engagement | Engaged Sessions/User | Events | Key Events | Key Event Rate |
|---|---------|-------|-----|-----------|----------------|----------------------|--------|------------|----------------|
| | **Total** | **349** | **345** | **11** | **26s** | | | **19** | **4.03%** |
| 1 | Direct | 141 (40.4%) | 140 | 9 (81.82%) | 45s | 0.38 | 1,410 (55.1%) | 5 (26.3%) | 1.42% |
| 2 | Paid Social | 76 (21.8%) | 76 | 1 (9.09%) | 2s | 0.08 | 260 (10.2%) | 0 | 0% |
| 3 | Paid Search | 71 (20.3%) | 71 | 0 | 26s | 0.38 | 492 (19.2%) | 12 (63.2%) | 15.49% |
| 4 | Referral | 27 (7.7%) | 29 | 0 | 1s | 0.11 | 131 (5.1%) | 0 | 0% |
| 5 | Unassigned | 26 (7.5%) | 1 | 0 | 9s | 0.00 | 55 (2.2%) | 0 | 0% |
| 6 | Cross-network | 21 (6.0%) | 20 | 0 | 12s | 0.05 | 95 (3.7%) | 2 (10.5%) | 4.76% |
| 7 | Organic Search | 5 (1.4%) | 5 | 1 (9.09%) | 57s | 0.40 | 85 (3.3%) | 0 | 0% |
| 8 | Organic Social | 3 (0.9%) | 3 | 0 | 25s | 1.00 | 31 (1.2%) | 0 | 0% |

**Key takeaways:**
- **Paid Search is the conversion engine:** 15.49% key event rate, 63.2% of all key events (12 of 19) from only 20.3% of users. Note: many key events are inflated — old tracking fired on booking page load, not actual Calendly completion. Fixed 2026-03-14 to use `booking_confirmed` (requires /confirmed + invitee name).
- **Paid Social (Reddit) is bouncing:** 76 users, 2s avg engagement, 0 conversions — users leave immediately.
- **Direct traffic is highest volume** (141 users) with longest engagement (45s) and 81.82% of returning users.
- **Organic Search is tiny but engaged:** only 5 users but 57s avg engagement — highest of any channel.
- **Referral traffic doesn't convert:** 27 users, 1s engagement, 0 key events.

## GA4 Overview (Mar 1-16, 2026)

| Metric | Value |
|--------|-------|
| Active users | 405 |
| Event count | 3.2K |
| Key events | 20 |
| New users | 405 |
