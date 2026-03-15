# Social Media Strategy

## LinkedIn (primary channel — personal profile only)

- Post 2x/week (Tuesday + Thursday)
- Profile headline: includes both CutMyAWS and EZRA Cloud
- Experience section: CutMyAWS listed as role under Smart Talk LLC
- Content types: educational tips, story/opinion, case studies
- No company page needed — personal posts get 10x engagement

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
| LinkedIn (company page + ads) | **Active** | Company page + paid ads ($45/day total: $15 general + $30 investors) |
| LinkedIn (personal) | **Active** | Primary organic channel |
| Reddit (u/cutmyaws) | **Active** | Organic answers + paid ads ($30/day: $15 general + $15 investors), pixel: a2_inkp2wvyvllm |
| Google Ads | **Active** | Search ads ($30/day: CutMyAWS-V2 + CutMyAWS-Investors) |
| Bing/Microsoft Ads | **Active** | Import Google campaign ($10/day) |
| YouTube (@CutMyAWS) | **Active** | Channel live, record exploration calls as case studies |
| Dev.to / Hashnode | Future | Technical deep-dives for SEO |
| Twitter/X | Maybe later | DevOps community exists but slower |
| Facebook/Instagram/TikTok | Skip | Wrong audience |

## YouTube Channel

**Channel:** https://www.youtube.com/@CutMyAWS
**Handle:** @CutMyAWS

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
