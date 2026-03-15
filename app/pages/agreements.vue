<script setup>
useHead({
  title: 'Engagement Terms — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})

// Pricing — mirrors index.vue
const pricing = {
  depositPct: 1,
  fixDepositPct: 4,
  reportPct: 15,
  implPct: 60,
  fixPct: 75,
  securityPct: 10,
  minAws: 5000,
  overageRate: 500,
}

// Example: $25K/mo, 36% waste (matches index.vue)
const exampleBefore = 25000
const exampleSavings = 9000
const exampleAnnual = exampleSavings * 12
const exampleAwsAnnual = exampleBefore * 12
const depositFee = Math.round(exampleAwsAnnual * pricing.depositPct / 100)
const reportFee = Math.round(exampleAnnual * pricing.reportPct / 100)
const reportRemainder = reportFee - depositFee
const fixDepositFee = Math.round(exampleAwsAnnual * pricing.fixDepositPct / 100)
const fixFee = Math.round(exampleAnnual * pricing.fixPct / 100)
const implFee = fixFee - reportFee
const implRemainder = implFee - fixDepositFee

function fmt(n) {
  return '$' + n.toLocaleString()
}

const meetings = [
  { name: 'Intro Call', when: 'Before audit begins', duration: '15 min', format: 'Zoom', count: '1', phase: 'Report' },
  { name: 'Exploration Call', when: '5–10 business days after access', duration: '45 min', format: 'Zoom', count: '1', phase: 'Report' },
  { name: 'Implementation Kickoff', when: 'After SOW signed', duration: '30 min', format: 'Zoom', count: '1', phase: 'Fix' },
  { name: 'Weekly Check-ins', when: 'During implementation', duration: '15 min', format: 'Zoom', count: '1/week', phase: 'Fix' },
  { name: 'Final Review', when: 'Implementation complete', duration: '30 min', format: 'Zoom', count: '1', phase: 'Fix' },
  { name: '90-Day Verification', when: '90 days post-delivery', duration: '30 min', format: 'Zoom', count: '1', phase: 'Proof' },
]
</script>

<template>
  <div>
    <!-- Header -->
    <div class="max-w-3xl mx-auto px-6 pt-12 sm:pt-16 pb-8 text-center">
      <h1 class="text-2xl sm:text-3xl font-bold mb-3">📋 How Engagements Work</h1>
      <p class="text-gray-400 mb-2">Everything you need to know before we start. Transparent terms, clear process, no surprises.</p>
      <p class="text-gray-500 text-sm">This isn't a legal contract — it's a handshake in writing. The actual SOW gets customized for your engagement.</p>
    </div>

    <!-- ═══ Engagement Overview ═══ -->
    <div class="max-w-3xl mx-auto px-6 pb-12">
      <h2 class="text-xl font-bold mb-6 text-center">🗺️ The Three Phases</h2>
      <div class="grid sm:grid-cols-3 gap-4">
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-6 text-center">
          <p class="text-3xl mb-2">📋</p>
          <h3 class="font-bold mb-1">The Report</h3>
          <p class="text-brand-400 text-sm font-bold mb-2">{{ pricing.reportPct }}% of savings found</p>
          <p class="text-gray-500 text-xs">5–10 business days. Full audit + 45-min call + PDF report.</p>
        </div>
        <div class="bg-gray-900 rounded-xl border-2 border-brand-500 p-6 text-center">
          <p class="text-3xl mb-2">🔧</p>
          <h3 class="font-bold mb-1">The Fix</h3>
          <p class="text-brand-400 text-sm font-bold mb-2">{{ pricing.fixPct }}% total max</p>
          <p class="text-gray-500 text-xs">Custom timeline. {{ pricing.fixDepositPct }}% deposit at kickoff. Pay only on realized savings.</p>
        </div>
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-6 text-center">
          <p class="text-3xl mb-2">📊</p>
          <h3 class="font-bold mb-1">The Proof</h3>
          <p class="text-brand-400 text-sm font-bold mb-2">90 days later</p>
          <p class="text-gray-500 text-xs">Side-by-side bill comparison. Pay only on verified savings.</p>
        </div>
      </div>
      <p class="text-gray-600 text-xs text-center mt-4">Most clients do all three. Some stop after The Report and implement themselves. Both are great.</p>
    </div>

    <!-- ═══ Phase 1: The Report ═══ -->
    <section class="bg-gray-900 py-12">
      <div class="max-w-3xl mx-auto px-6">
        <h2 class="text-xl font-bold mb-6">📋 Phase 1: The Report</h2>
        <div class="space-y-4">
          <div class="flex items-start gap-4">
            <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">1</span>
            <div>
              <p class="text-gray-200 font-medium">Timeline</p>
              <p class="text-gray-400 text-sm">5–10 business days from the day David receives read-only access.</p>
            </div>
          </div>
          <div class="flex items-start gap-4">
            <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">2</span>
            <div>
              <p class="text-gray-200 font-medium">What's included</p>
              <ul class="text-gray-400 text-sm space-y-1 mt-1">
                <li>✅ Full architecture audit across all active services</li>
                <li>✅ 48-month billing history analysis</li>
                <li>✅ Line-by-line savings breakdown with dollar amounts</li>
                <li>✅ Architecture recommendations and implementation guide</li>
                <li>✅ Security observations (misconfigs, public buckets, overprivileged IAM)</li>
              </ul>
            </div>
          </div>
          <div class="flex items-start gap-4">
            <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">3</span>
            <div>
              <p class="text-gray-200 font-medium">Meetings</p>
              <p class="text-gray-400 text-sm"><strong class="text-gray-200">2 meetings total.</strong> Intro call (15 min) + Exploration call (45 min, report delivery). That's it.</p>
            </div>
          </div>
          <div class="flex items-start gap-4">
            <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">4</span>
            <div>
              <p class="text-gray-200 font-medium">Deliverable</p>
              <p class="text-gray-400 text-sm">PDF report. Yours to keep forever. Share it with your team, your CTO, your board — whoever needs to see it.</p>
            </div>
          </div>
          <div class="flex items-start gap-4">
            <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">5</span>
            <div>
              <p class="text-gray-200 font-medium">Payment</p>
              <p class="text-gray-400 text-sm">{{ pricing.depositPct }}% of annualized AWS spend at engagement start (deposit). Remainder of {{ pricing.reportPct }}% of annualized savings due at exploration call. Deposit deducted from report fee. <strong class="text-gray-200">No savings found = deposit refunded.</strong></p>
            </div>
          </div>
          <div class="flex items-start gap-4">
            <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">6</span>
            <div>
              <p class="text-gray-200 font-medium">Access required</p>
              <p class="text-gray-400 text-sm">Read-only IAM role. You provision it, you control it, you revoke it. <NuxtLink to="/onboarding/give-david-access" class="text-brand-400 hover:underline">Setup instructions →</NuxtLink></p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- ═══ Phase 2: The Fix ═══ -->
    <div class="max-w-3xl mx-auto px-6 py-12">
      <h2 class="text-xl font-bold mb-6">🔧 Phase 2: The Fix <span class="text-gray-500 text-sm font-normal">(optional)</span></h2>
      <div class="space-y-4">
        <div class="flex items-start gap-4">
          <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">1</span>
          <div>
            <p class="text-gray-200 font-medium">Timeline</p>
            <p class="text-gray-400 text-sm">Scoped at the exploration call. Typically 2–8 weeks depending on complexity. Exact milestones defined in SOW.</p>
          </div>
        </div>
        <div class="flex items-start gap-4">
          <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">2</span>
          <div>
            <p class="text-gray-200 font-medium">What's included</p>
            <ul class="text-gray-400 text-sm space-y-1 mt-1">
              <li>✅ David implements optimizations from The Report</li>
              <li>✅ Documentation of every change made</li>
              <li>✅ Before/after comparison at each milestone</li>
              <li>✅ Rollback plan for every change</li>
            </ul>
            <p class="text-gray-500 text-xs mt-2">⚠️ Not every item in The Report may be implementable. Dependencies, compliance requirements, org constraints, and third-party limitations can prevent certain changes. David works to maximize realized savings, but some items may be deferred or excluded. <strong class="text-gray-400">You only pay on savings that actually materialize.</strong></p>
          </div>
        </div>
        <div class="flex items-start gap-4">
          <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">3</span>
          <div>
            <p class="text-gray-200 font-medium">Meetings</p>
            <p class="text-gray-400 text-sm">Kickoff call (30 min) + weekly check-ins (15 min each) + final review call (30 min). <strong class="text-gray-200">Typically 5–8 meetings total</strong> depending on implementation duration.</p>
          </div>
        </div>
        <div class="flex items-start gap-4">
          <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">4</span>
          <div>
            <p class="text-gray-200 font-medium">Payment</p>
            <p class="text-gray-400 text-sm"><strong class="text-gray-200">Deposit:</strong> {{ pricing.fixDepositPct }}% of annualized AWS spend due at implementation kickoff. Deducted from the implementation fee. <strong class="text-gray-200">Implementation fee:</strong> +{{ pricing.implPct }}% of <strong class="text-gray-200">verified</strong> annual savings (minus deposit), due 90 days after final deliverable. Total max: {{ pricing.fixPct }}% (report + implementation). <strong class="text-gray-200">Verified savings = $0? Implementation fee = $0.</strong></p>
          </div>
        </div>
        <div class="flex items-start gap-4">
          <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">5</span>
          <div>
            <p class="text-gray-200 font-medium">Access required</p>
            <p class="text-gray-400 text-sm">Write access to specific services listed in the SOW only. No blanket admin access. Client reviews all changes before execution on production resources.</p>
          </div>
        </div>
      </div>
    </div>

    <!-- ═══ Phase 3: The Proof ═══ -->
    <section class="bg-gray-900 py-12">
      <div class="max-w-3xl mx-auto px-6">
        <h2 class="text-xl font-bold mb-6">📊 Phase 3: The Proof</h2>
        <div class="bg-gray-950 rounded-xl border border-gray-800 p-6">
          <div class="space-y-4 text-sm">
            <div>
              <p class="text-gray-200 font-medium">When</p>
              <p class="text-gray-400">Exactly 90 calendar days after the final implementation deliverable is marked complete.</p>
            </div>
            <div>
              <p class="text-gray-200 font-medium">How it works</p>
              <p class="text-gray-400">David pulls Cost Explorer data for the 90-day post-implementation period. Compares against the 90-day period immediately before implementation. Annualizes the delta.</p>
            </div>
            <div>
              <p class="text-gray-200 font-medium">What counts as savings</p>
              <ul class="text-gray-400 space-y-1 mt-1">
                <li class="flex gap-2"><span class="text-green-400">✓</span> Savings directly attributable to work performed under the SOW</li>
                <li class="flex gap-2"><span class="text-red-400">✗</span> Client's business growth causing spend increases in unrelated areas</li>
                <li class="flex gap-2"><span class="text-red-400">✗</span> Savings from work Client's team did independently</li>
                <li class="flex gap-2"><span class="text-red-400">✗</span> AWS price reductions or promotions</li>
                <li class="flex gap-2"><span class="text-red-400">✗</span> RI/Savings Plan purchases Client made without David</li>
              </ul>
            </div>
            <div>
              <p class="text-gray-200 font-medium">Meeting</p>
              <p class="text-gray-400">1 verification call (30 min). Walk through the numbers together. The number on the bill wins — not projections.</p>
            </div>
            <div>
              <p class="text-gray-200 font-medium">Payment</p>
              <p class="text-gray-400">{{ pricing.implPct }}% of verified annual savings, invoiced within 5 business days of verification call. Net 30 terms. If savings fell short of projections: fee based on <strong class="text-gray-200">actual verified amount</strong>. If savings are $0: fee is $0. No minimums.</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- ═══ Meeting Schedule ═══ -->
    <div class="max-w-3xl mx-auto px-6 py-12">
      <h2 class="text-xl font-bold mb-2">🗓️ Meeting Schedule</h2>
      <p class="text-gray-500 text-sm mb-6">Every meeting has a purpose. No status calls. No "let's circle back." Just work.</p>

      <!-- Desktop table -->
      <div class="hidden sm:block bg-gray-900 rounded-xl border border-gray-800 overflow-hidden">
        <div class="grid grid-cols-5 gap-0 text-xs uppercase tracking-wider text-gray-500 font-bold px-4 py-3 border-b border-gray-800">
          <span>Meeting</span>
          <span>When</span>
          <span>Duration</span>
          <span>Format</span>
          <span>Count</span>
        </div>
        <div
          v-for="(m, i) in meetings"
          :key="m.name"
          class="grid grid-cols-5 gap-0 text-sm px-4 py-3"
          :class="i < meetings.length - 1 ? 'border-b border-gray-800/50' : ''"
        >
          <span class="text-gray-200 font-medium">{{ m.name }}</span>
          <span class="text-gray-400">{{ m.when }}</span>
          <span class="text-gray-400">{{ m.duration }}</span>
          <span class="text-gray-400">{{ m.format }}</span>
          <span class="text-gray-400">{{ m.count }}</span>
        </div>
      </div>

      <!-- Mobile cards -->
      <div class="sm:hidden space-y-3">
        <div
          v-for="m in meetings"
          :key="m.name"
          class="bg-gray-900 rounded-xl border border-gray-800 p-4"
        >
          <p class="text-gray-200 font-medium text-sm mb-2">{{ m.name }}</p>
          <div class="grid grid-cols-2 gap-1 text-xs">
            <span class="text-gray-500">When:</span><span class="text-gray-400">{{ m.when }}</span>
            <span class="text-gray-500">Duration:</span><span class="text-gray-400">{{ m.duration }}</span>
            <span class="text-gray-500">Format:</span><span class="text-gray-400">{{ m.format }}</span>
            <span class="text-gray-500">Count:</span><span class="text-gray-400">{{ m.count }}</span>
          </div>
        </div>
      </div>

      <div class="mt-4 bg-gray-900 rounded-lg border border-gray-800 p-4">
        <p class="text-gray-500 text-xs"><strong class="text-gray-300">Report-only clients:</strong> 2 meetings total (intro + exploration).</p>
        <p class="text-gray-500 text-xs mt-1"><strong class="text-gray-300">Implementation clients:</strong> 5–8 meetings total depending on scope. Plus 1 verification call 90 days later.</p>
        <p class="text-gray-500 text-xs mt-1"><strong class="text-gray-300">Follow-up calls:</strong> 2 included (30 min each) during the 90-day verification period for questions. Additional calls billed at {{ fmt(pricing.overageRate) }}/hr.</p>
      </div>
    </div>

    <!-- ═══ Sample SOW: The Report ═══ -->
    <section class="bg-gray-900 py-12">
      <div class="max-w-3xl mx-auto px-6">
        <h2 class="text-xl font-bold mb-2">📋 Sample SOW: The Report</h2>
        <p class="text-gray-500 text-sm mb-6">This is a sample. Your actual SOW includes your specific AWS account ID, annualized spend, and deposit amount.</p>

        <div class="bg-gray-950 rounded-xl border border-gray-800 p-6 sm:p-8 space-y-5 text-sm">
          <div>
            <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Parties</p>
            <p class="text-gray-300">Smart Talk LLC d/b/a Cut My AWS ("Consultant") and [Client Name] ("Client")</p>
          </div>
          <div>
            <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Scope</p>
            <p class="text-gray-300">Read-only audit of Client's AWS account [account-id]. Review of up to 48 months of billing history, resource utilization, architecture alignment, and cost optimization opportunities.</p>
          </div>
          <div>
            <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Timeline</p>
            <p class="text-gray-300">Audit begins within 2 business days of receiving read-only access. Report delivered within 5–10 business days of audit start.</p>
          </div>
          <div>
            <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Deliverables</p>
            <ol class="text-gray-300 space-y-1 list-decimal list-inside">
              <li>45-minute exploration call (Zoom) walking through all findings</li>
              <li>PDF report: line-by-line savings breakdown, architecture recommendations, implementation guide, security observations</li>
            </ol>
          </div>
          <div>
            <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Compensation</p>
            <ul class="text-gray-300 space-y-2">
              <li><strong class="text-gray-100">Deposit:</strong> {{ pricing.depositPct }}% of Client's annualized AWS spend, due at engagement start <span class="text-gray-500">(example: {{ fmt(depositFee) }} on {{ fmt(exampleAwsAnnual) }}/yr spend)</span></li>
              <li><strong class="text-gray-100">Report fee:</strong> {{ pricing.reportPct }}% of annualized savings identified, minus deposit already paid, due at exploration call <span class="text-gray-500">(example: {{ fmt(reportFee) }} total − {{ fmt(depositFee) }} deposit = {{ fmt(reportRemainder) }} due)</span></li>
              <li><strong class="text-gray-100">No savings found:</strong> Deposit refunded in full</li>
            </ul>
          </div>
          <div>
            <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Access</p>
            <p class="text-gray-300">Read-only IAM role (<code class="text-brand-300 text-xs">CutMyAWS-ReadOnly-Auditor</code>). Client provisions and controls access. Consultant cannot modify any resources.</p>
          </div>
          <div>
            <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Confidentiality</p>
            <p class="text-gray-300">All findings, billing data, and architecture details are confidential. Report delivered only to Client. No data shared with third parties.</p>
          </div>
          <div>
            <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Termination</p>
            <p class="text-gray-300">Client may terminate at any time by deleting the IAM role. If terminated before report delivery, deposit is non-refundable (work already performed). If terminated after report delivery, full report fee applies.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- ═══ Sample SOW: The Fix ═══ -->
    <div class="max-w-3xl mx-auto px-6 py-12">
      <h2 class="text-xl font-bold mb-2">🔧 Sample SOW: The Fix</h2>
      <p class="text-gray-500 text-sm mb-6">Scoped at the exploration call. This sample shows typical terms.</p>

      <div class="bg-gray-900 rounded-xl border border-gray-800 p-6 sm:p-8 space-y-5 text-sm">
        <div>
          <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Parties</p>
          <p class="text-gray-300">Smart Talk LLC d/b/a Cut My AWS ("Consultant") and [Client Name] ("Client")</p>
        </div>
        <div>
          <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Scope</p>
          <p class="text-gray-300">Implementation of cost optimizations identified in The Report dated [date]. Specific items listed in Appendix A (attached separately). Note: not all items from The Report may be implementable due to dependencies, compliance requirements, organizational constraints, or third-party limitations outside Consultant's control. Appendix A will reflect the mutually agreed implementation scope.</p>
        </div>
        <div>
          <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Timeline</p>
          <p class="text-gray-300">[X] weeks from kickoff. Specific milestones defined in Appendix B. Hard end date: [date].</p>
        </div>
        <div>
          <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Deliverables</p>
          <ol class="text-gray-300 space-y-1 list-decimal list-inside">
            <li>All optimizations implemented per Appendix A</li>
            <li>Documentation of every change made</li>
            <li>Before/after cost comparison at each milestone</li>
            <li>Weekly 15-minute check-in calls</li>
            <li>Final review call (30 min) at completion</li>
          </ol>
        </div>
        <div>
          <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Compensation</p>
          <ul class="text-gray-300 space-y-2">
            <li><strong class="text-gray-100">Report fee (already paid):</strong> {{ pricing.reportPct }}% of annualized savings <span class="text-gray-500">(example: {{ fmt(reportFee) }})</span></li>
            <li><strong class="text-gray-100">Implementation deposit:</strong> {{ pricing.fixDepositPct }}% of Client's annualized AWS spend, due at implementation kickoff <span class="text-gray-500">(example: {{ fmt(fixDepositFee) }} on {{ fmt(exampleAwsAnnual) }}/yr spend)</span>. Deducted from implementation fee. Non-refundable after kickoff (work already underway).</li>
            <li><strong class="text-gray-100">Implementation fee:</strong> {{ pricing.implPct }}% of verified annual savings, minus deposit already paid, due 90 calendar days after final deliverable <span class="text-gray-500">(example: {{ fmt(implFee) }} − {{ fmt(fixDepositFee) }} = {{ fmt(implRemainder) }} due)</span></li>
            <li><strong class="text-gray-100">Total maximum:</strong> {{ pricing.fixPct }}% of verified annual savings <span class="text-gray-500">(example: {{ fmt(fixFee) }})</span></li>
            <li><strong class="text-gray-100">Verification method:</strong> Side-by-side Cost Explorer comparison — 3-month average × 12 before vs. after</li>
            <li><strong class="text-gray-100">Savings less than projected:</strong> Fee based on actual verified amount. Not all Report items may be implementable — fee is based only on realized savings.</li>
            <li><strong class="text-gray-100">Savings are $0:</strong> Implementation fee is $0 (deposit non-refundable)</li>
          </ul>
        </div>
        <div>
          <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Access</p>
          <p class="text-gray-300">Write access to services specified in Appendix A only. No blanket admin access. Client reviews all changes before execution on production resources.</p>
        </div>
        <div>
          <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Out of Scope</p>
          <p class="text-gray-300">Anything not listed in Appendix A. Additional work requires written approval and is billed at <strong class="text-gray-100">{{ fmt(pricing.overageRate) }}/hr</strong>. See Scope Changes below.</p>
        </div>
        <div>
          <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Confidentiality</p>
          <p class="text-gray-300">Same terms as The Report. All Client data, architecture, and billing information remains confidential.</p>
        </div>
        <div>
          <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Termination</p>
          <p class="text-gray-300">Either party may terminate with 5 business days written notice. Implementation deposit ({{ pricing.fixDepositPct }}%) is non-refundable. Client pays {{ pricing.implPct }}% of verified savings achieved up to termination date, minus deposit already paid. No kill fee. No penalties.</p>
        </div>
      </div>
    </div>

    <!-- ═══ Communication Policy ═══ -->
    <section class="bg-gray-900 py-12">
      <div class="max-w-3xl mx-auto px-6">
        <h2 class="text-xl font-bold mb-2">📧 Communication Policy</h2>
        <p class="text-gray-500 text-sm mb-6">Simple rules. No Slack channel. No project portal. Just email.</p>

        <div class="bg-gray-950 rounded-xl border border-gray-800 p-6 space-y-4 text-sm">
          <div class="flex items-start gap-3">
            <span class="text-brand-400 flex-shrink-0 mt-0.5">📬</span>
            <div>
              <p class="text-gray-200 font-medium">Primary channel: Email</p>
              <p class="text-gray-400">All formal communication, deliverables, and approvals via <a href="mailto:david@cutmyaws.com" class="text-brand-400 hover:underline">david@cutmyaws.com</a>.</p>
            </div>
          </div>
          <div class="flex items-start gap-3">
            <span class="text-brand-400 flex-shrink-0 mt-0.5">⏱️</span>
            <div>
              <p class="text-gray-200 font-medium">Response time</p>
              <p class="text-gray-400">Within <strong class="text-gray-200">1 business day</strong> for standard items. Within <strong class="text-gray-200">4 hours</strong> for urgent/blocking issues during implementation.</p>
            </div>
          </div>
          <div class="flex items-start gap-3">
            <span class="text-brand-400 flex-shrink-0 mt-0.5">📹</span>
            <div>
              <p class="text-gray-200 font-medium">Meetings</p>
              <p class="text-gray-400">Zoom only. Scheduled in advance. No "quick calls" without an agenda.</p>
            </div>
          </div>
          <div class="flex items-start gap-3">
            <span class="text-brand-400 flex-shrink-0 mt-0.5">📋</span>
            <div>
              <p class="text-gray-200 font-medium">Async updates</p>
              <p class="text-gray-400">During implementation, David sends a weekly email summary every Monday: what was done, what's next, any blockers.</p>
            </div>
          </div>
          <div class="flex items-start gap-3">
            <span class="text-brand-400 flex-shrink-0 mt-0.5">🚨</span>
            <div>
              <p class="text-gray-200 font-medium">Escalation</p>
              <p class="text-gray-400">For true emergencies: email with "URGENT" in subject line. David's phone number shared after SOW signing — for emergencies only.</p>
            </div>
          </div>
          <div class="flex items-start gap-3">
            <span class="text-brand-400 flex-shrink-0 mt-0.5">🚫</span>
            <div>
              <p class="text-gray-200 font-medium">No Slack / Teams / Discord</p>
              <p class="text-gray-400">One channel means nothing gets lost. Email is the record of everything. This is a feature, not a limitation.</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- ═══ Overage Rates ═══ -->
    <div class="max-w-3xl mx-auto px-6 py-12">
      <h2 class="text-xl font-bold mb-2">⏱️ Overage Rates</h2>
      <p class="text-gray-500 text-sm mb-6">Anything outside the SOW scope is billed hourly. No surprises.</p>

      <div class="bg-gray-900 rounded-xl border border-gray-800 p-6 sm:p-8">
        <!-- Rate callout -->
        <div class="text-center mb-6 pb-6 border-b border-gray-800">
          <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">Hourly rate for out-of-scope work</p>
          <p class="text-4xl font-bold text-brand-400">{{ fmt(pricing.overageRate) }}<span class="text-gray-500 text-lg">/hr</span></p>
          <p class="text-gray-600 text-xs mt-2">Requires written approval (email) before work begins. Billed monthly, net 15.</p>
        </div>

        <div class="grid sm:grid-cols-2 gap-6">
          <!-- Overage examples -->
          <div>
            <p class="text-gray-200 font-medium text-sm mb-3">Billed as overage:</p>
            <ul class="space-y-2 text-sm text-gray-400">
              <li class="flex gap-2"><span class="text-brand-400">💰</span> Additional services not in The Report (e.g., "can you also migrate our CI/CD pipeline?")</li>
              <li class="flex gap-2"><span class="text-brand-400">💰</span> Re-implementing fixes Client's team reverted</li>
              <li class="flex gap-2"><span class="text-brand-400">💰</span> Training sessions for Client's engineering team</li>
              <li class="flex gap-2"><span class="text-brand-400">💰</span> Compliance documentation or audit preparation</li>
              <li class="flex gap-2"><span class="text-brand-400">💰</span> Multi-account strategy or Organizations restructuring (unless in SOW)</li>
              <li class="flex gap-2"><span class="text-brand-400">💰</span> Additional meetings beyond included follow-ups</li>
            </ul>
          </div>

          <!-- Not overage -->
          <div>
            <p class="text-gray-200 font-medium text-sm mb-3">Never billed as overage:</p>
            <ul class="space-y-2 text-sm text-gray-400">
              <li class="flex gap-2"><span class="text-green-400">✓</span> Questions about The Report findings (unlimited, forever)</li>
              <li class="flex gap-2"><span class="text-green-400">✓</span> Minor adjustments discovered during implementation that relate to SOW items</li>
              <li class="flex gap-2"><span class="text-green-400">✓</span> The 90-day verification call</li>
              <li class="flex gap-2"><span class="text-green-400">✓</span> 2 included follow-up calls (30 min each) during verification period</li>
              <li class="flex gap-2"><span class="text-green-400">✓</span> Email questions about implementation progress</li>
            </ul>
          </div>
        </div>
      </div>
    </div>

    <!-- ═══ Scope Changes ═══ -->
    <section class="bg-gray-900 py-12">
      <div class="max-w-3xl mx-auto px-6">
        <h2 class="text-xl font-bold mb-2">🔄 Scope Changes</h2>
        <p class="text-gray-500 text-sm mb-6">Plans change. That's fine. Here's how we handle it.</p>

        <div class="space-y-4">
          <div class="flex items-start gap-4">
            <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">1</span>
            <p class="text-gray-300 text-sm">Either party identifies work outside the original SOW scope.</p>
          </div>
          <div class="flex items-start gap-4">
            <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">2</span>
            <p class="text-gray-300 text-sm">David documents the change: what, why, estimated hours, and impact on timeline.</p>
          </div>
          <div class="flex items-start gap-4">
            <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">3</span>
            <p class="text-gray-300 text-sm">Client approves or declines via email.</p>
          </div>
          <div class="flex items-start gap-4">
            <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">4</span>
            <p class="text-gray-300 text-sm">If approved: work proceeds at <strong class="text-gray-100">{{ fmt(pricing.overageRate) }}/hr</strong> (or folded into an adjusted SOW if the change is significant enough).</p>
          </div>
          <div class="flex items-start gap-4">
            <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">5</span>
            <p class="text-gray-300 text-sm">If declined: original SOW continues unchanged. No hard feelings.</p>
          </div>
        </div>

        <div class="bg-gray-950 rounded-lg border border-gray-800 p-4 mt-6">
          <p class="text-gray-500 text-xs">Scope changes don't delay the original timeline unless both parties agree in writing. David doesn't hold your project hostage over a change request.</p>
        </div>
      </div>
    </section>

    <!-- ═══ Access & Termination ═══ -->
    <div class="max-w-3xl mx-auto px-6 py-12">
      <h2 class="text-xl font-bold mb-6">🔑 Access & Termination</h2>

      <div class="grid sm:grid-cols-2 gap-6">
        <!-- Access -->
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-6">
          <h3 class="text-sm font-bold text-gray-200 uppercase tracking-wider mb-4">🔒 Access</h3>
          <ul class="space-y-3 text-sm text-gray-400">
            <li><strong class="text-gray-200">During audit:</strong> Read-only IAM role. <NuxtLink to="/onboarding/give-david-access" class="text-brand-400 hover:underline">Setup →</NuxtLink></li>
            <li><strong class="text-gray-200">During implementation:</strong> Scoped write access per SOW Appendix A only.</li>
            <li><strong class="text-gray-200">Client controls access at all times.</strong> You provision roles, you revoke them.</li>
            <li>No root access. No admin access. No access to application data, secrets, or databases.</li>
            <li><strong class="text-gray-200">After engagement:</strong> All access revoked. David deletes local CLI profiles.</li>
          </ul>
        </div>

        <!-- Termination -->
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-6">
          <h3 class="text-sm font-bold text-gray-200 uppercase tracking-wider mb-4">🚪 Termination</h3>
          <ul class="space-y-3 text-sm text-gray-400">
            <li><strong class="text-gray-200">The Report:</strong> Client may terminate before delivery. Deposit is non-refundable (work underway). After delivery: full report fee applies.</li>
            <li><strong class="text-gray-200">The Fix:</strong> Either party may terminate with 5 business days written notice. Implementation deposit is non-refundable. Client pays {{ pricing.implPct }}% of savings achieved to date (minus deposit). No kill fee.</li>
            <li><strong class="text-gray-200">Immediate termination:</strong> Delete the IAM role. David ceases all work immediately.</li>
            <li><strong class="text-gray-200">Post-termination:</strong> Client keeps all deliverables forever. David retains no copies of Client data.</li>
          </ul>
        </div>
      </div>
    </div>

    <!-- ═══ Example Engagement Timeline ═══ -->
    <section class="bg-gray-900 py-12">
      <div class="max-w-3xl mx-auto px-6">
        <h2 class="text-xl font-bold mb-2">📅 Example Engagement Timeline</h2>
        <p class="text-gray-500 text-sm mb-6">Full engagement (Report + Fix + Proof) for a {{ fmt(exampleBefore) }}/mo AWS account with ~36% waste.</p>

        <div class="bg-gray-950 rounded-xl border border-gray-800 overflow-hidden">
          <div class="divide-y divide-gray-800">
            <div class="flex justify-between items-center p-4">
              <div>
                <p class="text-gray-200 font-medium text-sm">Week 0 — Intro Call</p>
                <p class="text-gray-500 text-xs">15 min · Free · Client grants read-only access</p>
              </div>
              <span class="text-gray-600 text-sm">{{ fmt(0) }}</span>
            </div>
            <div class="flex justify-between items-center p-4">
              <div>
                <p class="text-gray-200 font-medium text-sm">Day 1 — Deposit</p>
                <p class="text-gray-500 text-xs">{{ pricing.depositPct }}% of {{ fmt(exampleAwsAnnual) }}/yr annualized</p>
              </div>
              <span class="text-brand-400 text-sm font-bold">{{ fmt(depositFee) }}</span>
            </div>
            <div class="flex justify-between items-center p-4">
              <div>
                <p class="text-gray-200 font-medium text-sm">Week 2 — Exploration Call (Report Delivery)</p>
                <p class="text-gray-500 text-xs">45 min · {{ pricing.reportPct }}% of {{ fmt(exampleAnnual) }}/yr savings minus deposit</p>
              </div>
              <span class="text-brand-400 text-sm font-bold">{{ fmt(reportRemainder) }}</span>
            </div>
            <div class="flex justify-between items-center p-4">
              <div>
                <p class="text-gray-200 font-medium text-sm">Week 3 — Implementation Deposit</p>
                <p class="text-gray-500 text-xs">{{ pricing.fixDepositPct }}% of {{ fmt(exampleAwsAnnual) }}/yr annualized · deducted from implementation fee</p>
              </div>
              <span class="text-brand-400 text-sm font-bold">{{ fmt(fixDepositFee) }}</span>
            </div>
            <div class="flex justify-between items-center p-4">
              <div>
                <p class="text-gray-200 font-medium text-sm">Weeks 3–8 — Implementation</p>
                <p class="text-gray-500 text-xs">Kickoff + weekly check-ins + final review</p>
              </div>
              <span class="text-gray-600 text-sm">$0</span>
            </div>
            <div class="flex justify-between items-center p-4">
              <div>
                <p class="text-gray-200 font-medium text-sm">Week 8 — Implementation Complete</p>
                <p class="text-gray-500 text-xs">90-day clock starts</p>
              </div>
              <span class="text-gray-600 text-sm">$0</span>
            </div>
            <div class="flex justify-between items-center p-4">
              <div>
                <p class="text-gray-200 font-medium text-sm">Week 20 — 90-Day Verification Call</p>
                <p class="text-gray-500 text-xs">30 min · {{ pricing.implPct }}% of verified annual savings minus deposit</p>
              </div>
              <span class="text-brand-400 text-sm font-bold">{{ fmt(implRemainder) }}</span>
            </div>
            <div class="flex justify-between items-center p-4 bg-gray-900/50">
              <div>
                <p class="text-gray-100 font-bold text-sm">Total paid ({{ pricing.fixPct }}% max)</p>
                <p class="text-gray-500 text-xs">{{ fmt(depositFee) }} + {{ fmt(reportRemainder) }} + {{ fmt(fixDepositFee) }} + {{ fmt(implRemainder) }}</p>
              </div>
              <span class="text-brand-400 font-bold">{{ fmt(fixFee) }}</span>
            </div>
            <div class="flex justify-between items-center p-4 bg-gray-900/50">
              <div>
                <p class="text-green-400 font-bold text-sm">Client keeps — year 1</p>
                <p class="text-gray-500 text-xs">{{ fmt(exampleAnnual) }} savings − {{ fmt(fixFee) }} fee</p>
              </div>
              <span class="text-green-400 font-bold">{{ fmt(exampleAnnual - fixFee) }}</span>
            </div>
            <div class="flex justify-between items-center p-4 bg-gray-900/50">
              <div>
                <p class="text-green-400 font-bold text-sm">Client keeps — every year after</p>
                <p class="text-gray-500 text-xs">100% of savings, zero ongoing fees</p>
              </div>
              <span class="text-green-400 font-bold">{{ fmt(exampleAnnual) }}<span class="text-gray-500 text-xs">/yr</span></span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Calendly Embed -->
    <section id="book-section">
      <CalendlyEmbed campaign="agreements" />
    </section>
  </div>
</template>
