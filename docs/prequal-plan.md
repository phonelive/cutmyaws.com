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
  api/                              # NEW - Ruby Lambda backend (SAM)
    template.yaml                   # SAM template (API GW + Lambda + IAM)
    samconfig.toml                  # SAM deploy config (dev + prod)
    router.rb                       # Lambda entry point (dynamic routing)
    init.rb                         # Bootstrap (bundler, env, auto-loading)
    Gemfile                         # Ruby dependencies (trilogy, activerecord, aws-sdk)
    Rakefile                        # Dev tasks (irb_dev, irb_prod, http_dev, db_create)
    app/
      libs/
        aws.rb                      # AWS SDK global config
        aws_ssm.rb                  # SSM parameter fetching with ENV caching
        db.rb                       # TiDB connection via Trilogy + AutoReconnect
        api_response.rb             # CORS, api_success/error, api_handler wrapper
        turnstile.rb                # Cloudflare Turnstile token verification
        ses.rb                      # SES email notification to David
        validate.rb                 # Server-side form validation rules
      controllers/
        prequal.rb                  # POST /prequal (main endpoint)
    fn/
      router_test.rb                # Lambda health check / warmup
    scripts/
      irb.sh                        # IRB console launcher
    .docker/
      bundle-install/               # Docker build for Lambda-compatible gems
    db/
      001_create_prequal_submissions.sql
  .github/
    workflows/
      api.yml                       # GitHub Actions: SAM deploy on push
      deploy.yml                    # GitHub Actions: Nuxt → GitHub Pages
  app/                              # EXISTING - Nuxt source (unchanged structure)
    components/
      CalendlyEmbed.vue             # MODIFY - accept prefill props
      PreQualForm.vue               # NEW - form that gates CalendlyEmbed
    composables/
      useConfig.ts                  # NEW - API URL + Turnstile site key
```

## Turnstile

- **Site key:** `0x4AAAAAACrv6ddaepEh0qEx` (public, in frontend code)
- **Secret key:** stored in SSM at `/cutmyaws/{env}/turnstile/secret_key`
- **Mode:** Invisible (no widget shown, validates silently)
- Load script: `https://challenges.cloudflare.com/turnstile/v0/api.js`
- Call `turnstile.execute(siteKey)` on form submit → get token → include in POST body

## SAM Template (`api/template.yaml`)

**Language:** Ruby 3.4 (NOT Node.js — matches Ezra project patterns)

**Resources:**
1. `PreQualApi` — `AWS::Serverless::HttpApi` (HTTP API, payload 2.0)
2. `RouterFunction` — `AWS::Serverless::Function`
   - Runtime: `ruby3.4`, Architecture: `arm64`, Memory: 256, Timeout: 15
   - Handler: `router.router`
   - Policies: SSM read (`/cutmyaws/{stage}/*`), SES send
   - Events: ANY `/{proxy+}` + ANY `/`

**Environments:** dev and prod (via `Stage` parameter in samconfig.toml)

**Deployment:** GitHub Actions ONLY — push to `main` (prod) or `dev` branch (dev).
NEVER deploy from the command line.

**SSM Parameters (already created in both dev and prod):**
- `/cutmyaws/{env}/db/host` — gateway01.us-east-1.prod.aws.tidbcloud.com
- `/cutmyaws/{env}/db/port` — 4000
- `/cutmyaws/{env}/db/user` — 4EA5RRLJJAkgUTA.root
- `/cutmyaws/{env}/db/pass` — (SecureString)
- `/cutmyaws/{env}/db/name` — test
- `/cutmyaws/{env}/turnstile/secret_key` — (SecureString; dev uses Cloudflare test key)

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

1. ~~Create SSM parameters~~ ✅ Done (both dev and prod)
2. Set up SES identity for `cutmyaws.com` domain (or verify sender in sandbox)
3. ~~Create TiDB database + run CREATE TABLE~~ ✅ Done (`bundle exec rake db_create`)
4. Set GitHub secrets: `AWS_ACCESS_KEY_ID_CUTMYAWS` + `AWS_SECRET_ACCESS_KEY_CUTMYAWS`
5. Push `api/` to `main` → GitHub Actions deploys to prod via SAM
6. Get API Gateway URL from CloudFormation outputs → update `useConfig.ts`
7. (Optional) Set up `api.cutmyaws.com` custom domain in Route 53 → API Gateway
8. Push frontend changes to `main` (auto-deploys via GitHub Actions)

**IMPORTANT:** All deployments happen through GitHub Actions on push.
NEVER deploy from the command line. See `.github/workflows/api.yml`.

**Environments:**
- Push to `main` → deploys to **prod** (cutmyaws-prod-api stack)
- Push to `dev` branch → deploys to **dev** (cutmyaws-dev-api stack)
- Manual workflow_dispatch → choose dev or prod

## Ruby Dependencies (Gemfile)

```ruby
gem 'trilogy'                              # MySQL/TiDB adapter (faster than mysql2)
gem 'activerecord', '~> 8.0.0'            # ORM for database queries
gem 'activesupport'                        # Timezone, utilities
gem 'aws-sdk-ssm'                          # SSM Parameter Store
gem 'aws-sdk-ses'                          # Email sending
```

Trilogy is chosen over mysql2 (same as Ezra project) for better Lambda performance and TiDB Cloud SSL compatibility. Auto-reconnect module handles idle connection drops.

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
