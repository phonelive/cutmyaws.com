# Branding & Design

## Colors

| Color | Hex | Usage |
|-------|-----|-------|
| **Brand Orange** | `#f97316` (orange-500) | Primary — CTAs, headings, highlights |
| **Background** | `#030712` (gray-950) | Page background |
| **Card Background** | `#111827` (gray-900) | Cards, sections |
| **Border** | `#1f2937` (gray-800) | Card borders, dividers |
| **Body Text** | `#9ca3af` (gray-400) | Paragraph text |
| **Heading Text** | `#f3f4f6` (gray-100) | Headlines |
| **Muted Text** | `#6b7280` (gray-500) | Footnotes, captions |
| **Green (savings)** | `#4ade80` (green-400) | "You keep" amounts |
| **Red (waste)** | `#f87171` (red-400) | Waste/loss amounts |

## Typography

- System font stack: `-apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif`
- Headlines: Bold/Extra-bold
- Body: Regular weight, `text-lg` for readability

## Logo

- Primary: `✂️ Cut My AWS` (scissors emoji + text)
- Favicon: Orange square with `$` sign (`/public/favicon.svg`)
- No separate logo image — the scissors emoji IS the logo

## Dark Theme

The site is dark-mode only. All design tokens assume a dark background. Do not add a light mode.

## Client Logos

8 client logos displayed in "Trusted by teams at" section:

| Client | Logo File | Link |
|--------|-----------|------|
| Caterpillar | `/logos/cat.svg` | caterpillar.com |
| DC Government | `/logos/dc-gov.png` | dc.gov |
| Best Buy | `/logos/best-buy.svg` | bestbuy.com |
| PBS | `/logos/pbs.svg` | pbs.org |
| Commonwealth of MA | `/logos/ma-state.png` | mass.gov |
| Argonne National Lab | `/logos/argonne.png` | anl.gov |
| PhoneLive | `/logos/phonelive.png` | phonelive.com |
| EZRA Cloud | `/logos/ezra.png` | ezracloud.com |

PNG logos are 280x80, centered on transparent canvas, optimized for web (7-14KB each). SVGs scale natively. All logos display grayscale at 50% opacity, full color at 90% on hover.

## OG Image Generation

The social sharing image (`public/og-image.png`) is generated using Playwright screenshotting an HTML template:

```bash
# Template at /tmp/og-template.html
npx playwright screenshot --viewport-size="1200,630" --full-page /tmp/og-template.html public/og-image.png
```

To regenerate: edit `/tmp/og-template.html` and re-run the command. Requires Playwright with Chromium installed.

## Promo: Free Security Scan

Time-limited promo configured in `app/pages/index.vue`:

```js
const promoEnd = new Date('2026-04-04T23:59:59')
```

- Shows top banner with countdown when active
- Adds bonus line item in the exploration call section
- Auto-hides when `promoEnd` passes
- Covers: misconfigs, public S3 buckets, overprivileged IAM roles

To extend: change the date. To end early: set to a past date.
