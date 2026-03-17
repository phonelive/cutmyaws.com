# Social Media Strategy

## LinkedIn (primary channel — personal profile only)

- Post 2x/week (Tuesday + Thursday)
- Profile headline: includes both CutMyAWS and EZRA Cloud
- Experience section: CutMyAWS listed as role under Smart Talk LLC
- Content types: educational tips, story/opinion, case studies
- No company page needed — personal posts get 10x engagement
- **Outbound automation:** [Botdog](https://botdog.co) — automated LinkedIn sequences. Scales outbound InMails to CEOs/CTOs at tech companies spending $5K+/mo on AWS.
- **Active campaign:** "SWB AWS Take 3" — 173 contacts, 30 InMails sent, 0% reply rate (as of Mar 16). Started Mar 11, 2026.
- **InMail copy updated Mar 15:** Old copy (~22-23 sends, 0 replies). New copy started ~Mar 15. Too early to evaluate — check back after ~50 total sends.
- **Note:** Clarity shows 6 LinkedIn sessions and 35% "FacebookApp" browser traffic — this is LinkedIn's mobile in-app browser from Botdog outreach. People are clicking through to the site even if not replying.

### Botdog Sequence Flow

```
1. Visit profile
2. Wait 2 hours
3. Send InMail (not-connected path)
```

### InMail Copy (v2 — Mar 15, 2026)

**Subject line:** Your {{currentCompany | }} AWS bill has a secret

```
{{firstName | Hey}} —

I've spent 19 years reading AWS accounts. Every single one I audit has 30-40%
waste hiding in plain sight. {{currentCompany | Your company}} is probably no
different.

Three things I find in every account:

1. Ghost resources — idle RDS instances and over-provisioned EBS volumes
   billing you 24/7 for zero utilization

2. Architecture from 2021 — workloads still on x86 that should be on Graviton,
   no Spot for non-critical jobs. 40%+ compute savings left on the table.

3. S3 hoarding — old data sitting in Standard that should be in
   Intelligent-Tiering or Glacier. You're paying premium prices for files
   nobody's touched in years.

The catch? Your engineers are too busy shipping to do this housekeeping. That's
where I come in.

Not a dashboard. Not an AI. Just me, reading your architecture and telling you
exactly what to change. I only charge a percentage of verified savings. No
savings? No fee.

15 minutes — I'll tell you if it's worth going deeper: https://cutmyaws.com

David Plappert
(651) 894-4607
```

**Template variables:** `{{firstName}}` (fallback: "Hey"), `{{currentCompany}}` (fallback: "Your company")

### Targeting Quality Issues (Mar 16 audit)

The contact list has targeting problems. Several contacts are off-target for an AWS cost optimization pitch:

**Remove / skip — wrong audience:**

| Contact | Company | Why |
|---------|---------|-----|
| Phil Pergola | CloudZero | **Direct competitor** — CloudZero is an AWS cost optimization platform |
| Vadim Vladimirskiy | Nerdio | **Microsoft cloud** company, not AWS |
| Jeff Uphues | DC BLOX | Data center company, competes *with* AWS |
| Chitra Patel | WealthWorth | Financial advisor, not running tech infrastructure |
| Anthem Hayek Blanchard | Substack | Crypto newsletter publisher, no significant AWS spend |
| Prof Rick Hillum | Novocomms | Space/defence hardware, not SaaS/cloud |

**Good targets in the list:**

| Contact | Company | Why |
|---------|---------|-----|
| Nick Turner | Dreamdata | B2B SaaS attribution platform, likely AWS-heavy |
| Rahul Sasi | CloudSEK | Cybersecurity SaaS, likely heavy AWS user |
| Cody Barbo | Trust & Will | Online estate planning platform, likely AWS |
| Ronen Schwartz | K2view | Data/cloud management company |
| Yoram Wijngaarde | Dealroom.co | Startup data platform |

**Recommendation:** Tighten Botdog filters to focus on SaaS/tech companies. Filter out financial services, hardware, publishers, and (obviously) cloud cost optimization competitors. Each wasted InMail credit is a missed shot at a real prospect.

## Content Bank (first month)

1. Launch post: "I spent 19 years paying AWS bills I didn't fully understand..."
2. "5 signs your AWS has been collecting cobwebs"
3. "I found $4,200/mo hiding in a NAT Gateway"
4. "Serverless isn't always the answer. But it's the answer more often than you think."
5. "Your AWS bill is a symptom. The disease is tech that doesn't match your business."
6. "The most expensive AWS service isn't EC2. It's the one nobody's monitoring."
7. "I asked a CTO how many EC2 instances they had. They said 12. It was 47."
8. "Dashboards find waste. I find misalignment."

## Other Channels

| Platform | Status | Notes |
|----------|--------|-------|
| LinkedIn (personal) | **Active** | Primary organic channel + Botdog outbound automation |
| LinkedIn (company page + ads) | **Paused** | All LinkedIn ads paused (account 525710547) |
| Google Ads | **Active** | $70/day: Investors $45, Serverless $15, V2 $10. 4 campaigns paused. |
| Reddit (u/cutmyaws) | **Active (testing)** | $30/day across 3 conversion campaigns. 0 bookings. Kill deadline: 2026-03-28. |
| Bing/Microsoft Ads | **Not working** | Account G145R2VD |
| YouTube (@CutMyAWS) | **Active** | 1 sub, 4 views, 1 video published (Mar 13). 67.8% avg retention. |
| Dev.to / Hashnode | Future | Technical deep-dives for SEO |
| Twitter/X | Maybe later | DevOps community exists but slower |
| Facebook/Instagram/TikTok | Skip | Wrong audience |

## YouTube Channel

**Channel:** https://www.youtube.com/@CutMyAWS
**Handle:** @CutMyAWS

### Channel Stats (as of 2026-03-16, last 28 days: Feb 16 – Mar 15)

| Metric | Value |
|--------|-------|
| Subscribers | 1 |
| Views | 4 |
| Watch time (hours) | 0.1 |
| Impressions CTR | 1.4% |

**Latest video:** "Your AWS Bill Is a Symptom. Here's the Cure." (published Mar 13, 2026)
- Views: 4
- Avg view duration: 1:17 (67.8% retention)

### Welcome Video (first video — 30-60 seconds)

**Placement:** Homepage hero section, embedded between headline/subheadline and the stats row.

```
[Hello bar]
[Nav]
[Hero headline + subheadline]
[YouTube embed]          <-- here
[Stats row: 19 years / $100M+ / 150+ accounts]
[Trusted by logos]
```

**Script:**

> Hey — I'm David. I've been building on AWS since 2007. That's 19 years of watching businesses accidentally pay for things they don't need.
>
> *[slight smirk]*
>
> You know that feeling when you open your AWS bill and think... "that can't be right"? Yeah. It's right. It's just wrong.
>
> Here's what I do: you give me read-only access, I spend a week reading your architecture, and I come back with a report that says "here's what you're wasting, here's why, and here's exactly what to change."
>
> Not a dashboard. Not an AI tool. Just me, reading your account, understanding your business.
>
> *[lean in slightly]*
>
> And here's the fun part — I only charge a percentage of the savings I find. No savings? No fee. So the worst case scenario is... you wasted 15 minutes on an intro call with me.
>
> *[shrug]*
>
> I've seen worse uses of 15 minutes. You've *had* worse meetings today.
>
> Link's in the description. Let's cut your AWS bill.

**Recording notes:** One take, conversational, at desk. Imperfection is on-brand. ~45 seconds at natural pace.

**Implementation:** Embed as YouTube iframe in `app/pages/index.vue`. Upload to YouTube (public), swap in the video ID.

### YouTube Banner

| File | Size | Purpose |
|------|------|---------|
| `public/youtube-banner.png` | 2048x1152 | Channel banner image |
| `/tmp/youtube-banner.html` | — | HTML template for banner |

```bash
# Regenerate banner
npx playwright screenshot --viewport-size="2048,1152" --full-page /tmp/youtube-banner.html public/youtube-banner.png
```

### Future Video Content

| Video | Source | Effort |
|-------|--------|--------|
| Welcome intro (60s) | Script above | Low |
| Exploration call recordings | Record live calls (with permission) | Near-zero marginal |
| "I found $X hiding in Y" | Real audits, anonymized | Medium |
| LinkedIn post repurposes | Read your own post on camera | Low |

## Investor Ad Campaign

**Landing page:** `cutmyaws.com/investors` (dedicated, noindex)

**Angle:** Angel investors / VCs audit portfolio companies' AWS spend to extend runway without cutting headcount.

**Key messages:**
- "Your portfolio companies are overpaying AWS"
- "Nobody audited the AWS bill"
- "Every startup I audit wastes 30-40% on AWS"
- "Extend runway without cutting headcount"
- "One engagement, permanent savings"
- "No savings = no fee"

**Active on all 3 paid social platforms:**
- **LinkedIn Ads** ($30/day) — Targeting: Investor, Private Investor, Venture Partner, Managing Partner, General Partner, Managing Director titles. US only. Campaign ID: 1000806254
- **Reddit Ads** ($15/day) — Same targeting as general campaign. Investor-specific ad creative with dollar breakdown. Campaign: CutMyAWS-Investors
- **Google Ads** — Search keywords: `reduce aws costs portfolio`, `aws cost optimization startup`, `reduce burn rate startup`, `cloud cost optimization small business`
