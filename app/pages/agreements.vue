<script setup>
useHead({
  title: 'Engagement Terms — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})

const { pricing } = usePricing()

function fmt(n) {
  return '$' + n.toLocaleString()
}

const meetings = [
  { name: 'Free Intro Call', when: 'Before engagement begins', duration: '15 min', format: 'Zoom', count: '1', phase: 'Audit' },
  { name: 'Findings Meeting', when: '5–10 business days after access', duration: '45 min', format: 'Zoom', count: '1', phase: 'Audit' },
  { name: 'Implementation Kickoff', when: 'After findings meeting', duration: '30 min', format: 'Zoom', count: '1', phase: 'Fix' },
  { name: 'Weekly Check-ins', when: 'During implementation', duration: '15 min', format: 'Zoom', count: '1/week', phase: 'Fix' },
  { name: 'Final Review', when: 'Implementation complete', duration: '30 min', format: 'Zoom', count: '1', phase: 'Fix' },
  { name: 'Verification', when: 'Post-implementation', duration: '30 min', format: 'Zoom', count: '1', phase: 'Proof' },
]
</script>

<template>
  <PageSections>
    <!-- Header -->
    <div class="max-w-3xl mx-auto px-6 pt-12 sm:pt-16 pb-8 text-center">
      <h1 class="text-2xl sm:text-3xl font-bold mb-3">📋 How Engagements Work</h1>
      <p class="text-gray-400 mb-2">Everything you need to know before we start. Transparent terms, clear process, no surprises.</p>
      <p class="text-gray-500 text-sm">This isn't a legal contract — it's a handshake in writing. The actual SOW gets customized for your engagement.</p>
    </div>

    <!-- ═══ Engagement Overview ═══ -->
    <div class="max-w-3xl mx-auto px-6 pb-12">
      <h2 class="text-xl font-bold mb-6 text-center">🗺️ Free Audit. Pay Only When You Want the Fix.</h2>

      <!-- Three step overview -->
      <div class="grid sm:grid-cols-3 gap-4 mb-6">
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-6 text-center">
          <p class="text-green-400 text-xs uppercase tracking-wider font-bold mb-2">Audit</p>
          <p class="text-2xl font-bold mb-1">Free</p>
          <p class="text-gray-500 text-xs">Full audit + findings meeting + PDFs. No charge. See the numbers first.</p>
        </div>
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-6 text-center">
          <p class="text-brand-400 text-xs uppercase tracking-wider font-bold mb-2">Implementation</p>
          <p class="text-2xl font-bold mb-1">If You Want It</p>
          <p class="text-gray-500 text-xs">David fixes what the audit found. Pricing discussed at findings meeting.</p>
        </div>
        <div class="bg-gray-900 rounded-xl border-2 border-brand-500 p-6 text-center">
          <p class="text-brand-400 text-xs uppercase tracking-wider font-bold mb-2">Payment</p>
          <p class="text-2xl font-bold mb-1">% of Savings</p>
          <p class="text-gray-500 text-xs">You only pay a percentage of verified savings. No savings = no fee.</p>
        </div>
      </div>

      <!-- Pipeline steps -->
      <div class="flex items-center justify-center gap-2 text-xs text-gray-500">
        <span class="bg-gray-800 px-3 py-1 rounded-full">🗓️ Free Chat</span>
        <span>→</span>
        <span class="bg-gray-800 px-3 py-1 rounded-full">📋 Audit</span>
        <span>→</span>
        <span class="bg-gray-800 px-3 py-1 rounded-full">🛡️ Security</span>
        <span>→</span>
        <span class="bg-gray-800 px-3 py-1 rounded-full">🔧 Fix</span>
        <span>→</span>
        <span class="bg-gray-800 px-3 py-1 rounded-full">📊 Verify</span>
      </div>
      <p class="text-gray-600 text-xs text-center mt-4">These are steps in the pipeline, not separate products. One engagement, one SOW.</p>
    </div>

    <!-- ═══ Phase 1: The Audit ═══ -->
    <section class="py-12">
      <div class="max-w-3xl mx-auto px-6">
        <h2 class="text-xl font-bold mb-6">📋 Step 1: Audit</h2>
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
                <li>✅ Architecture review across all active services</li>
                <li>✅ Billing history analysis</li>
                <li>✅ High-level savings breakdown by service with dollar amounts</li>
                <li>✅ Enough detail to know what's fixable and what it's worth</li>
              </ul>
            </div>
          </div>
          <div class="flex items-start gap-4">
            <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">3</span>
            <div>
              <p class="text-gray-200 font-medium">Meetings</p>
              <p class="text-gray-400 text-sm"><strong class="text-gray-200">2 meetings total.</strong> Free chat (15 min) + Findings call (45 min, report delivery). That's it.</p>
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
              <p class="text-gray-400 text-sm"><strong class="text-gray-200">The audit is free.</strong> No payment. You see the findings before committing a dollar. If you want David to implement the fixes, pricing is discussed at the findings meeting.</p>
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
      <h2 class="text-xl font-bold mb-6">🔧 Step 2: Implementation</h2>
      <div class="space-y-4">
        <div class="flex items-start gap-4">
          <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">1</span>
          <div>
            <p class="text-gray-200 font-medium">Timeline</p>
            <p class="text-gray-400 text-sm">Scoped at the findings call. Typically 2–8 weeks depending on complexity. Exact milestones defined in SOW.</p>
          </div>
        </div>
        <div class="flex items-start gap-4">
          <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">2</span>
          <div>
            <p class="text-gray-200 font-medium">What's included</p>
            <ul class="text-gray-400 text-sm space-y-1 mt-1">
              <li>✅ David implements optimizations from the audit</li>
              <li>✅ Documentation of every change made</li>
              <li>✅ Before/after comparison at each milestone</li>
              <li>✅ Rollback plan for every change</li>
            </ul>
            <p class="text-gray-500 text-xs mt-2">⚠️ Not every item in the audit may be implementable. Dependencies, compliance requirements, org constraints, and third-party limitations can prevent certain changes. David works to maximize realized savings, but some items may be deferred or excluded. <strong class="text-gray-400">You only pay on savings David actually fixes.</strong></p>
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
            <p class="text-gray-400 text-sm">Payment terms are outlined in the SOW. You only pay a percentage of verified savings David actually fixes.</p>
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
    <section class="py-12">
      <div class="max-w-3xl mx-auto px-6">
        <h2 class="text-xl font-bold mb-6">📊 Step 3: Verification & Payment</h2>
        <div class="bg-gray-950 rounded-xl border border-gray-800 p-6">
          <div class="space-y-4 text-sm">
            <div>
              <p class="text-gray-200 font-medium">When</p>
              <p class="text-gray-400">After implementation is complete and savings have been verified in your bill.</p>
            </div>
            <div>
              <p class="text-gray-200 font-medium">How it works</p>
              <p class="text-gray-400">David pulls Cost Explorer data for the post-implementation period. Compares against the period immediately before implementation. Annualizes the delta.</p>
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
              <p class="text-gray-400">A percentage of verified annual savings David actually implemented, as outlined in your SOW. Invoiced within 5 business days of verification. Net 30 terms. If savings are $0: fee is $0. Savings identified but not fixed? No charge.</p>
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
        <p class="text-gray-500 text-xs"><strong class="text-gray-300">Typical engagement:</strong> 7–10 meetings total (intro + findings + kickoff + weekly check-ins + final review + verification).</p>
        <p class="text-gray-500 text-xs mt-1"><strong class="text-gray-300">Follow-up calls:</strong> 2 included (30 min each) during the verification period for questions. Additional calls billed at {{ fmt(pricing.overageRate) }}/hr.</p>
      </div>
    </div>

    <!-- ═══ Sample SOW ═══ -->
    <section class="py-12">
      <div class="max-w-3xl mx-auto px-6">
        <h2 class="text-xl font-bold mb-2">📋 Sample SOW</h2>
        <p class="text-gray-500 text-sm mb-6">This is a sample. Your actual SOW includes your specific AWS account ID, annualized spend, and deposit amount.</p>

        <div class="bg-gray-950 rounded-xl border border-gray-800 p-6 sm:p-8 space-y-5 text-sm">
          <div>
            <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Parties</p>
            <p class="text-gray-300">Smart Talk LLC d/b/a Cut My AWS ("Consultant") and [Client Name] ("Client")</p>
          </div>
          <div>
            <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Scope</p>
            <p class="text-gray-300">Full audit and implementation of cost optimizations for Client's AWS account [account-id]. Review of up to 48 months of billing history, resource utilization, architecture alignment, and cost optimization opportunities. Implementation of all feasible optimizations identified in the audit.</p>
          </div>
          <div>
            <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Timeline</p>
            <p class="text-gray-300">Audit begins within 2 business days of receiving read-only access. Report delivered within 5–10 business days. Implementation timeline scoped at findings call, typically 2–8 weeks. Specific milestones in Appendix A.</p>
          </div>
          <div>
            <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Deliverables</p>
            <ol class="text-gray-300 space-y-1 list-decimal list-inside">
              <li>45-minute findings call (Zoom) walking through all findings</li>
              <li>PDF report: line-by-line savings breakdown, architecture recommendations, security observations</li>
              <li>Implementation of all feasible optimizations per Appendix A</li>
              <li>Documentation of every change made</li>
              <li>Before/after cost comparison at each milestone</li>
              <li>Weekly check-in calls during implementation</li>
              <li>Final review call at completion</li>
            </ol>
          </div>
          <div>
            <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Compensation</p>
            <ul class="text-gray-300 space-y-2">
              <li><strong class="text-gray-100">Fee:</strong> A percentage of verified annual savings that Consultant implemented. Specific percentage outlined in each client's SOW.</li>
              <li><strong class="text-gray-100">Unfixed savings:</strong> No fee. Savings identified but not implemented (due to dependencies, compliance, or constraints) are not charged.</li>
              <li><strong class="text-gray-100">Payment timing:</strong> Per SOW terms, based on verified savings only.</li>
              <li><strong class="text-gray-100">Verification method:</strong> Side-by-side Cost Explorer comparison — before vs. after</li>
              <li><strong class="text-gray-100">Savings are $0:</strong> Fee is $0. No savings = no fee.</li>
            </ul>
          </div>
          <div>
            <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Access</p>
            <p class="text-gray-300">Read-only IAM role (<code class="text-brand-300 text-xs">CutMyAWS-ReadOnly-Auditor</code>) during audit. Write access to services specified in Appendix A during implementation. Client provisions and controls access. No blanket admin access.</p>
          </div>
          <div>
            <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Confidentiality</p>
            <p class="text-gray-300">All findings, billing data, and architecture details are confidential. Report delivered only to Client. No data shared with third parties.</p>
          </div>
          <div>
            <p class="text-gray-500 text-xs uppercase tracking-wider font-bold mb-1">Termination</p>
            <p class="text-gray-300">Either party may terminate with 5 business days written notice. Client pays for verified savings achieved up to termination date per SOW terms. No fee on unfixed items. No kill fee. No penalties. Client keeps all deliverables.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- ═══ Communication Policy ═══ -->
    <div class="max-w-3xl mx-auto px-6 py-12">
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

    <!-- ═══ Overage Rates ═══ -->
    <section class="py-12">
      <div class="max-w-3xl mx-auto px-6">
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
                <li class="flex gap-2"><span class="text-brand-400">💰</span> Additional services not in the audit (e.g., "can you also migrate our CI/CD pipeline?")</li>
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
                <li class="flex gap-2"><span class="text-green-400">✓</span> Questions about audit findings (unlimited, forever)</li>
                <li class="flex gap-2"><span class="text-green-400">✓</span> Minor adjustments discovered during implementation that relate to SOW items</li>
                <li class="flex gap-2"><span class="text-green-400">✓</span> The 90-day verification call</li>
                <li class="flex gap-2"><span class="text-green-400">✓</span> 2 included follow-up calls (30 min each) during verification period</li>
                <li class="flex gap-2"><span class="text-green-400">✓</span> Email questions about implementation progress</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- ═══ Scope Changes ═══ -->
    <div class="max-w-3xl mx-auto px-6 py-12">
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

    <!-- ═══ Access & Termination ═══ -->
    <section class="py-12">
      <div class="max-w-3xl mx-auto px-6">
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
              <li><strong class="text-gray-200">Either party</strong> may terminate with 5 business days written notice.</li>
              <li><strong class="text-gray-200">Upfront payment</strong> is non-refundable after implementation begins.</li>
              <li><strong class="text-gray-200">If terminated early:</strong> Client pays for verified savings achieved to date (fixed items only) per SOW terms. No fee on unfixed items. No kill fee.</li>
              <li><strong class="text-gray-200">Immediate termination:</strong> Delete the IAM role. David ceases all work immediately.</li>
              <li><strong class="text-gray-200">Post-termination:</strong> Client keeps all deliverables forever. David retains no copies of Client data.</li>
            </ul>
          </div>
        </div>
      </div>
    </section>

    <!-- ═══ Example Engagement Timeline ═══ -->
    <div class="max-w-3xl mx-auto px-6 py-12">
      <h2 class="text-xl font-bold mb-2">📅 Example Engagement Timeline</h2>
      <p class="text-gray-500 text-sm mb-6">Typical engagement flow from first call to verified savings.</p>

      <div class="bg-gray-950 rounded-xl border border-gray-800 overflow-hidden">
        <div class="divide-y divide-gray-800">
          <div class="flex justify-between items-center p-4">
            <div>
              <p class="text-gray-200 font-medium text-sm">Week 0 — Free Intro Call</p>
              <p class="text-gray-500 text-xs">15 min · Free · Meet David, discuss your account</p>
            </div>
            <span class="text-green-400 text-sm font-bold">Free</span>
          </div>
          <div class="flex justify-between items-center p-4">
            <div>
              <p class="text-gray-200 font-medium text-sm">Weeks 1–2 — Free Audit</p>
              <p class="text-gray-500 text-xs">Read-only access · David audits the account</p>
            </div>
            <span class="text-green-400 text-sm font-bold">Free</span>
          </div>
          <div class="flex justify-between items-center p-4">
            <div>
              <p class="text-gray-200 font-medium text-sm">Week 2 — Findings Meeting</p>
              <p class="text-gray-500 text-xs">Delivers Audit PDF, Security PDF, Implementation Recommendations PDF</p>
            </div>
            <span class="text-green-400 text-sm font-bold">Free</span>
          </div>
          <div class="flex justify-between items-center p-4">
            <div>
              <p class="text-gray-200 font-medium text-sm">Weeks 3–8 — Implementation</p>
              <p class="text-gray-500 text-xs">Kickoff + weekly check-ins + final review</p>
            </div>
            <span class="text-gray-500 text-sm">Per SOW</span>
          </div>
          <div class="flex justify-between items-center p-4 bg-gray-900/50">
            <div>
              <p class="text-gray-200 font-medium text-sm">Post-Implementation — Verification & Payment</p>
              <p class="text-gray-500 text-xs">Side-by-side bill comparison · You pay a % of verified savings</p>
            </div>
            <span class="text-brand-400 text-sm font-bold">% of savings</span>
          </div>
          <div class="flex justify-between items-center p-4 bg-gray-900/50">
            <div>
              <p class="text-green-400 font-bold text-sm">Savings repeat — every year after</p>
              <p class="text-gray-500 text-xs">100% of savings, zero ongoing fees</p>
            </div>
            <span class="text-green-400 font-bold">Forever 🎉</span>
          </div>
        </div>
      </div>
    </div>

    <!-- Contact Form -->
    <section id="book-section">
      <ContactForm campaign="agreements" />
    </section>
  </PageSections>
</template>
