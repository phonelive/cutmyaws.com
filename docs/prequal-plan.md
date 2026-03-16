# Pre-Qualification Form + Lambda Backend Plan

> Created 2026-03-16. Execute when ready to gate Calendly with a validated form.

## Problem

Spam bookings via Calendly (fake names, keyboard-mash answers like "DERTFYUI"). Calendly has no bot protection or input validation. Inflates conversion metrics in Google Ads.

## Solution

Pre-qualification form that gates the Calendly embed. User fills validated form → Lambda verifies Turnstile + saves lead → Calendly appears with pre-filled data. Lead is captured whether or not they complete the Calendly booking.

## Architecture

```
Frontend (Nuxt static, GitHub Pages)
  PreQualForm component
    ├── Name, Email, Company, AWS Spend fields
    ├── Cloudflare Turnstile (invisible mode)
    ├── Client-side validation
    └── POST to API Gateway
        │
        ▼
Backend (Lambda + API Gateway, SAM)
  POST /prequal
    ├── Verify Turnstile token (Cloudflare API)
    ├── Server-side validation
    ├── Save to TiDB (MySQL-compatible)
    ├── Email David via SES
    └── Return success
        │
        ▼
Frontend on success
  └── Reveal CalendlyEmbed with pre-filled: name, email, a1, a2
      └── User just picks a time slot
```

## Directory Structure

```
cutmyaws.com/
  api/                              # NEW - SAM backend
    template.yaml                   # SAM template (API GW + Lambda + IAM)
    samconfig.toml                  # SAM deploy config
    package.json                    # Lambda deps (mysql2)
    src/
      prequal/
        index.mjs                   # Lambda handler
        lib/
          turnstile.mjs             # Turnstile verification
          tidb.mjs                  # TiDB connection + queries
          ses.mjs                   # SES email helper
          validate.mjs              # Server-side validation
  app/                              # EXISTING - Nuxt source (unchanged structure)
    components/
      CalendlyEmbed.vue             # MODIFY - accept prefill props
      PreQualForm.vue               # NEW - form that gates CalendlyEmbed
    composables/
      useConfig.ts                  # NEW - API URL + Turnstile site key
```

## Turnstile

- **Site key:** `0x4AAAAAACrv6ddaepEh0qEx` (public, in frontend code)
- **Secret key:** stored in SSM at `/cutmyaws/prequal/turnstile-secret`
- **Mode:** Invisible (no widget shown, validates silently)
- Load script: `https://challenges.cloudflare.com/turnstile/v0/api.js`
- Call `turnstile.execute(siteKey)` on form submit → get token → include in POST body

## SAM Template (`api/template.yaml`)

**Resources:**
1. `PreQualApi` — `AWS::Serverless::Api` with CORS for `https://cutmyaws.com`
2. `PreQualFunction` — `AWS::Serverless::Function`
   - Runtime: `nodejs20.x`, Architecture: `arm64`, Memory: 256, Timeout: 15
   - Handler: `src/prequal/index.handler`
   - Policies: SSM read (`/cutmyaws/prequal/*`), SES send
   - Event: POST `/prequal`

**SSM Parameters (create manually before deploy):**
- `/cutmyaws/prequal/turnstile-secret`
- `/cutmyaws/prequal/tidb-host`
- `/cutmyaws/prequal/tidb-port` (4000)
- `/cutmyaws/prequal/tidb-user`
- `/cutmyaws/prequal/tidb-password` (SecureString)
- `/cutmyaws/prequal/tidb-database`

## Lambda Handler Flow

```
POST /prequal
  1. Parse body: { name, email, company, awsMonthly, turnstileToken }
  2. Server-side validation (see rules below)
  3. POST to https://challenges.cloudflare.com/turnstile/v0/siteverify
     → body: { secret: SSM, response: turnstileToken }
  4. If Turnstile fails → 403 { success: false, error: 'bot_detected' }
  5. INSERT INTO prequal_submissions (...)
  6. SES SendEmail to david@cutmyaws.com
  7. Return 200 { success: true }
```

## Form Fields & Validation

| Field | Type | Client Validation | Server Validation |
|-------|------|-------------------|-------------------|
| Full Name | text | Required, 2+ chars | 2-100 chars, no URLs |
| Work Email | email | Required, email format | Valid format, not disposable |
| Monthly AWS Spend | dropdown select | Must select option | Must be valid option |
| Company & What You Do | textarea | Required, 5+ chars | 5-500 chars, 2+ real words |

**Dropdown options for AWS spend:**
- "$5K - $10K"
- "$10K - $25K"
- "$25K - $50K"
- "$50K - $100K"
- "$100K - $250K"
- "$250K+"

## TiDB Table Schema

```sql
CREATE TABLE prequal_submissions (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(255) NOT NULL,
  company TEXT NOT NULL,
  aws_monthly VARCHAR(50) NOT NULL,
  turnstile_success BOOLEAN DEFAULT TRUE,
  ip_address VARCHAR(45),
  user_agent TEXT,
  utm_source VARCHAR(100),
  utm_medium VARCHAR(100),
  utm_campaign VARCHAR(100),
  page_url VARCHAR(500),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_email (email),
  INDEX idx_created (created_at)
);
```

## CalendlyEmbed Changes

Add optional prefill props:
```js
prefillName: { type: String, default: '' }
prefillEmail: { type: String, default: '' }
prefillA1: { type: String, default: '' }   // AWS monthly spend
prefillA2: { type: String, default: '' }   // Company info
```

Append to Calendly URL when non-empty: `&name=...&email=...&a1=...&a2=...`

## PreQualForm Component

**States:** `form` → `submitting` → `success`

- `form`: Shows David's photo, heading, trust badges, and form fields (same visual style as current CalendlyEmbed header)
- `submitting`: Loading spinner
- `success`: Renders `<CalendlyEmbed>` with pre-filled props

**Tracking:** On success, fire `trackEvent('prequal_submitted', { event_category: 'engagement', event_label: campaign })`

## Pages to Update (swap CalendlyEmbed → PreQualForm)

| File | Campaign | Anchor |
|------|----------|--------|
| `app/pages/index.vue` | `homepage` | `book` |
| `app/pages/investors.vue` | `investors` | `book` |
| `app/pages/investors.vue` | `investors-bottom` | `book-bottom` |
| `app/pages/government.vue` | `government` | `book` |
| `app/pages/referrals.vue` | `referral` | `book` |
| `app/pages/hire.vue` | `hire` | `book` |
| `app/pages/agreements.vue` | `agreements` | `book` |
| `app/pages/onboarding/calculate-savings/index.vue` | `calculate-savings` | `book` |
| `app/pages/book.vue` | `book` | Refactor to use PreQualForm |

## SES Email

**From:** `prequal@cutmyaws.com` (or `noreply@cutmyaws.com`)
**To:** `david@cutmyaws.com`
**Subject:** `New Pre-Qual: {name} — {awsMonthly}/mo`

```
New pre-qualification submission from cutmyaws.com

Name: {name}
Email: {email}
AWS Monthly Spend: {awsMonthly}
Company: {company}

Campaign: {utm_campaign}
Source: {utm_source} / {utm_medium}
Page: {page_url}
Submitted: {timestamp}

---
This person is now seeing the Calendly booking widget.
```

## Frontend Config

```js
// app/composables/useConfig.ts
export function useConfig() {
  return {
    prequalApiUrl: 'https://api.cutmyaws.com/prod/prequal',
    turnstileSiteKey: '0x4AAAAAACrv6ddaepEh0qEx',
  }
}
```

Both values are public. API is protected by Turnstile + CORS + server-side validation.

## Deployment Order

1. Create SSM parameters in AWS Console
2. Set up SES identity for `cutmyaws.com` domain
3. Create TiDB database + run CREATE TABLE
4. `cd api/ && sam build && sam deploy --guided`
5. Get API Gateway URL → update `useConfig.ts`
6. (Optional) Set up `api.cutmyaws.com` custom domain in Route 53 → API Gateway
7. Push frontend changes to `main` (auto-deploys via GitHub Actions)

## Lambda Dependencies

```json
{
  "name": "cutmyaws-prequal-api",
  "private": true,
  "type": "module",
  "dependencies": {
    "mysql2": "^3.11.0"
  }
}
```

Only `mysql2` needed. AWS SDK v3 (SES, SSM) included in Lambda runtime. Turnstile uses native `fetch`.

## Calendly Configuration (manual)

- Make both custom questions **optional** (not required) in Calendly event settings
- Pre-fill params will populate them automatically
- Keeps backward compatibility if someone bypasses the form

## Risks & Mitigations

| Risk | Mitigation |
|------|-----------|
| Lambda cold start latency | arm64 architecture, small bundle, low traffic |
| TiDB connection in Lambda | Connection-per-invocation, close after each request |
| Turnstile blocked by ad blocker | Graceful fallback: submit without token, Lambda logs but allows through (or show "email david@cutmyaws.com" fallback) |
| Calendly pre-fill params change | Pre-fill is convenience, not required. User re-enters if needed. |
