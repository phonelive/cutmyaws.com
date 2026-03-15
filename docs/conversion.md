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
