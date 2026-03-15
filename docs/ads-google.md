# Google Ads

**Account:** Cut My AWS (120-353-4001), david@phonelive.io
**Google Tag:** GT-K8KHLNZJ (configured in `app/plugins/gtag.client.ts`)
**Conversion:** GA4-imported `booking_confirmed` event (Primary, fires on /confirmed with name param). Old `manual_event_SUBMIT_LEAD_FORM` demoted to Secondary (click-based only).
**Promo:** $500 spend-match credit (applied)

**RSA Character Limits:** Headlines ≤ 30 chars, Descriptions ≤ 90 chars, Paths ≤ 15 chars each

**Negative keywords (all campaigns):** aws free tier, aws certification, aws training, aws jobs, aws tutorial, aws pricing calculator

## Campaign 1: CutMyAWS-Investors — $45/day (TOP PERFORMER)

- **Bid Strategy:** Maximize conversions
- **Networks:** Google Search + Search Partners
- **Landing:** `cutmyaws.com/investors`
- **Performance (Mar 11-15):** 74 clicks, 609 impr, **11.77% CTR**, $1.55 CPC, $115.00 spend, **3 reported conversions** (2 false), $38.33 reported CPA, 4.05% conv rate
- **Note:** 2 of 3 conversions were false positives — old tracking (`manual_event_SUBMIT_LEAD_FORM`) fired on booking page load, not actual Calendly completion. Fixed 2026-03-14: primary conversion is now `booking_confirmed` (fires on /confirmed with invitee name). **Real conversions: 1.** Real CPA: ~$115.
- **Ads Advisor (Mar 15):** "Conversions up, great start! CutMyAWS-Investors driving 3.00 conversions in the last 7 days (March 8 to March 14). Cost per conversion of $11.68." (Note: $11.68 CPA is inflated by false conversions.)
- **54 keywords** (Broad): cloud optimization tools, aws cost review, optimizing cloud spend, aws waste, cost optimization cloud, cloud optimisation, aws overspending, cloud cost optimization, reduce cloud costs, cut aws bill, aws cost savings, cloud spend optimization, aws finops, lower aws bill, aws cost audit, aws cost optimization, aws consulting, finops consulting, cloud cost audit, reduce aws bill, + 34 more
- **Headlines:** Cut Your AWS Bill by 30-40% | No Savings = No Fee | Free 15-Min Intro Call | 19 Years of AWS Experience | Pay Only on Verified Savings | AWS Cost Audit for Startups | 9-Month ROI on Average | Not a Dashboard. A Real Human. | Stop Overpaying AWS | No Retainer. No Hourly. | Extend Your Startup's Runway | Free Security Audit Included | Trusted by Caterpillar & PBS | AWS Cost Optimization Expert
- **Descriptions:** We find 30-40% AWS waste on average. Pay only on verified savings. Free intro call. | 19 years of AWS experience. A real architect, not a dashboard. Free 15-min call. | Your startups are overpaying AWS. One engagement, permanent savings. No retainer. | Cut your AWS bill without slowing dev teams. No commitment. Results-based pricing.

## Campaign 2: CutMyAWS-V2 — $10/day

- **Bid Strategy:** Maximize conversions
- **Networks:** Google Search only
- **Landing:** `cutmyaws.com`
- **Performance (Mar 11-15):** 3 clicks, 156 impr, 1.92% CTR, $5.61 CPC, $16.84 spend, 0 conversions
- **Cleanup (2026-03-14):** Paused 20 bad keywords (savings plans, tools, AWS features like compute optimizer, audit manager, trusted advisor)
- **49 keywords** (Broad, 20 paused): aws cloud cost optimization, aws optimization, aws cost optimisation, ec2 cost optimization, aws architecture review, aws cost cutting, cloud cost optimization aws, rds cost optimization, s3 cost optimization, aws audit, eks cost optimization, aws lambda cost optimization, + more
- **Headlines:** Cut Your AWS Bill 30%+ | AWS Cost Optimization Expert | 19 Years AWS Experience | No Savings = No Fee | Not a Dashboard. A Human. | Free 15-Min Intro Call | $5K+/mo AWS Spend? | Senior AWS Architect | Pay For Only Real Savings | AWS Cost Audit & Fix | Business-Aligned AWS Audit | Transparent % Pricing | Stop Overpaying for AWS | AWS Bill Analysis | Proven AWS Savings
- **Descriptions:** Spending $5K+/mo on AWS? Free intro call. Pay only a % of verified savings found. | Senior AWS architect with 19 years experience audits your account & finds real savings. | Not a dashboard or AI tool. A real architect understands your setup & can fix it. | Book a free 15-min call. Get a full report. No savings = no fee. It's that simple.

## Campaign 3: CutMyAWS-Symptom — $5/day (PAUSED 2026-03-15)

- **Angle:** Problem awareness — "your bill is a symptom"
- **Bid Strategy:** Maximize conversions
- **Networks:** Google Search only
- **Performance (Mar 11-15):** 0 clicks, 1 impr, $0.00 spend, 0 conversions
- **Landing:** `cutmyaws.com?utm_source=google&utm_medium=cpc&utm_campaign=cutmyaws-symptom`
- **Path:** aws / audit
- **Keywords (10, Broad):** aws bill too high, aws costs growing, why is my aws bill so high, aws spending too much, aws bill keeps increasing, aws overspending, cloud spend out of control, aws infrastructure costs, aws bill analysis, aws cost problem
- **Headlines:** Your AWS Bill Is a Symptom | Save 25% in 90 Days | No Savings = No Fee | Free 15-Min Intro Call | 19 Years of AWS Experience | Stop Overpaying for AWS | Not a Dashboard. A Human.
- **Descriptions:** Your AWS bill is a symptom. Architecture nobody touched in years. Free call. | I find 30-40% waste on every AWS account. 19 years exp. Pay a % of savings.

## Campaign 4: CutMyAWS-25pct — $5/day (PAUSED 2026-03-15)

- **Angle:** Hard number + risk reversal — "save 25% in 90 days"
- **Bid Strategy:** Maximize conversions
- **Networks:** Google Search only
- **Performance (Mar 11-15):** 0 clicks, 2 impr, $0.00 spend, 0 conversions
- **Landing:** `cutmyaws.com?utm_source=google&utm_medium=cpc&utm_campaign=cutmyaws-25pct`
- **Path:** aws / savings
- **Keywords (10, Broad):** reduce aws costs, cut aws bill, lower aws bill, aws cost reduction, save on aws, aws cost savings, reduce cloud costs, cut cloud costs, aws bill optimization, aws spending optimization
- **Headlines:** Save 25% on Your AWS Bill | In 90 Days. Guaranteed. | No Savings = No Fee | Free 15-Min Intro Call | 19 Years AWS Experience | Cut Your AWS Bill 25%+ | Pay Only on Verified Savings
- **Descriptions:** Save 25% on your AWS bill in 90 days. No savings = no fee. Free intro call. | I find 30-40% waste on every account. You pay a % of savings. One-time fee.

## Campaign 5: CutMyAWS-Human — $5/day (PAUSED 2026-03-15)

- **Angle:** Differentiation — "not a dashboard, a human"
- **Bid Strategy:** Maximize conversions
- **Networks:** Google Search only
- **Performance (Mar 11-15):** 0 clicks, 4 impr, $0.00 spend, 0 conversions
- **Landing:** `cutmyaws.com?utm_source=google&utm_medium=cpc&utm_campaign=cutmyaws-human`
- **Path:** aws / consultant
- **Keywords (10, Broad):** aws cost consultant, aws consulting, finops consultant, cloud cost consultant, aws architect for hire, cloud cost optimization consultant, aws cost optimization services, hire aws expert, aws cost optimization consultant, finops consulting
- **Headlines:** Not a Dashboard. A Human. | Real AWS Consultant | 19 Years of AWS Experience | No Savings = No Fee | Free 15-Min Intro Call | I Read Your Architecture | AWS Cost Optimization Expert
- **Descriptions:** Cloud cost tools show charts. I read your architecture and tell you what to fix. | Not a dashboard. Not an AI. A real architect who finds waste no tool can see.

## Campaign 6: CutMyAWS-Serverless — $15/day (NEW 2026-03-14)

- **Angle:** Technical — "still running EC2 24/7?"
- **Bid Strategy:** Maximize conversions
- **Networks:** Google Search only
- **Performance (Mar 11-15):** 3 clicks, 9 impr, **33.33% CTR**, $0.99 CPC, $2.96 spend, 0 conversions
- **Landing:** `cutmyaws.com?utm_source=google&utm_medium=cpc&utm_campaign=cutmyaws-serverless`
- **Path:** aws / serverless
- **Keywords (10, Broad):** serverless migration aws, ec2 cost optimization, ec2 to lambda migration, rds cost optimization, ec2 to serverless, aws serverless consultant, migrate ec2 to containers, aws architecture modernization, ec2 right sizing, aws lambda migration
- **Headlines:** Still Running EC2 24/7? | Serverless Saves 40-70% | 19 Years AWS Experience | No Savings = No Fee | Free 15-Min Intro Call | Right-Size Your AWS | Serverless Migration Expert
- **Descriptions:** Still running EC2 24/7? Serverless saves 40-70%. 19 years migrating workloads. | Architecture from 3 years ago is costing you today. Modernize and save.

## Campaign 7: CutMyAWS-Audit — $5/day (PAUSED 2026-03-15)

- **Angle:** Direct intent — "AWS cost audit"
- **Bid Strategy:** Maximize conversions
- **Networks:** Google Search only
- **Performance (Mar 11-15):** 0 clicks, 0 impr, $0.00 spend, 0 conversions
- **Landing:** `cutmyaws.com?utm_source=google&utm_medium=cpc&utm_campaign=cutmyaws-audit`
- **Path:** aws / audit
- **Keywords (10, Broad):** aws cost audit, aws architecture review, cloud cost audit, aws account audit, aws infrastructure audit, aws cost analysis, aws spend analysis, aws cost review, audit aws account, aws bill review service
- **Headlines:** AWS Cost Audit in 10 Days | Full Report. Every Waste Item. | No Savings = No Fee | Free 15-Min Intro Call | 19 Years AWS Experience | Save 25% on Your AWS Bill | Not a Dashboard. A Human.
- **Descriptions:** Full AWS cost audit in 5-10 days. Every waste item with dollar amounts and fixes. | A real architect reads your account, not a dashboard. Finds waste no tool sees.

## Shared Assets

**Callout Extensions:** 19 Years AWS Experience | Free Security Audit | Free Intro Call | Results-Based Pricing | Transparent Pricing | No Savings = No Fee | Fortune 100 Experience

**Sitelinks:** About David → /#about | How Pricing Works → /#pricing | Book Free Intro Call → /book?c=google-sitelink | How It Works → /#how-it-works | ROI Calculator → /#calculator | Free Intro Call → /book?c=google-search

**Logo Assets:** `public/logo-dollar.png`, `public/logo-scissors.png`

## Google Ads Editor (bulk management)

Export/import campaigns via Google Ads Editor (free desktop app). Import file format: UTF-8 TSV.

**IMPORTANT:** Location targeting must be on a SEPARATE row from campaign definition (otherwise "Ambiguous row type" error). RSA ads sometimes fail to attach on import — create manually in Google Ads UI if "Campaign has no ads" appears.
