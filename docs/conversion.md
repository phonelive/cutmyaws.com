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
