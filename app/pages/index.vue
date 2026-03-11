<script setup>
import { ref, onMounted, computed } from 'vue'

const calendlyBase = 'https://calendly.com/phonelivestreaming/cutmyaws-com-intro'
const calendly = (campaign) => `${calendlyBase}?utm_source=cutmyaws&utm_medium=website&utm_campaign=${campaign}`

// ── Hero ticker animation ──
const tickerValue = ref(0)
const tickerTarget = 108000 // $108K on a $25K/mo account at 36% savings
const tickerDisplay = computed(() => tickerValue.value.toLocaleString())

onMounted(() => {
  const duration = 4000
  const steps = 120
  const increment = tickerTarget / steps
  let current = 0
  const interval = setInterval(() => {
    current += increment
    if (current >= tickerTarget) {
      tickerValue.value = tickerTarget
      clearInterval(interval)
    } else {
      tickerValue.value = Math.round(current)
    }
  }, duration / steps)
})

// ── ROI Calculator ──
const calcAwsSpend = ref(25000)
const calcWastePct = ref(30)
const calcMonthlySavings = computed(() => Math.round(calcAwsSpend.value * (calcWastePct.value / 100)))
const calcAnnualSavings = computed(() => calcMonthlySavings.value * 12)
const calcDepositFee = computed(() => Math.round(calcAwsSpend.value * 12 * pricing.depositPct / 100))
const calcReportFee = computed(() => Math.round(calcAnnualSavings.value * pricing.reportPct / 100))
const calcReportRemainder = computed(() => calcReportFee.value - calcDepositFee.value)
const calcFixFee = computed(() => Math.round(calcAnnualSavings.value * pricing.fixPct / 100))
const calcKeepReport = computed(() => calcAnnualSavings.value - calcReportFee.value)
const calcKeepFix = computed(() => calcAnnualSavings.value - calcFixFee.value)
const calcRoiReport = computed(() => {
  if (calcReportFee.value === 0) return 0
  return Math.round((calcKeepReport.value / calcReportFee.value) * 100) / 100
})
const calcRoiFix = computed(() => {
  if (calcFixFee.value === 0) return 0
  return Math.round((calcKeepFix.value / calcFixFee.value) * 100) / 100
})
// Months to break even on The Fix (when cumulative monthly savings > total fix fee)
const calcMonthsToRoi = computed(() => {
  if (calcMonthlySavings.value === 0) return 0
  return Math.ceil(calcFixFee.value / calcMonthlySavings.value)
})
// 5-year total savings
const calcFiveYearSavings = computed(() => calcAnnualSavings.value * 5)
const calcFiveYearNet = computed(() => calcFiveYearSavings.value - calcFixFee.value)

// Promo: free security scan — update this date to extend/end the promo
const promoEnd = new Date('2026-04-04T23:59:59')
const now = new Date()
const promoActive = now < promoEnd
const promoDaysLeft = Math.max(0, Math.ceil((promoEnd.getTime() - now.getTime()) / (1000 * 60 * 60 * 24)))

const stats = [
  { value: '19 Years', label: '☁️ Of AWS expertise. In production since 2007.' },
  { value: '$10M+', label: '💰 Saved & improved across client accounts.' },
  { value: '50+', label: '🔍 AWS accounts audited. Zero unsurprised CFOs.' }
]

const clients = [
  { name: 'Caterpillar', url: 'https://www.caterpillar.com', logo: '/logos/cat.svg' },
  { name: 'DC Government', url: 'https://dc.gov', logo: '/logos/dc-gov.png' },
  { name: 'Best Buy', url: 'https://www.bestbuy.com', logo: '/logos/best-buy.svg' },
  { name: 'PBS', url: 'https://www.pbs.org', logo: '/logos/pbs.svg' },
  { name: 'Commonwealth of Massachusetts', url: 'https://www.mass.gov', logo: '/logos/ma-state.png' },
  { name: 'Argonne National Laboratory', url: 'https://www.anl.gov', logo: '/logos/argonne.png' },
  { name: 'PhoneLive', url: 'https://phonelive.io', logo: '/logos/phonelive.png' },
  { name: 'EZRA Cloud', url: 'https://ezracloud.com', logo: '/logos/ezra.png' },
]

const testimonials = [
  { quote: 'David is a dev genius.', emoji: '🧠' },
  { quote: 'David responds quickly and makes sure to explain things as best as possible.', emoji: '💬' },
  { quote: 'David\'s a commando. He is fast and efficient at getting results.', emoji: '🎯' },
]

const wasteSources = [
  { emoji: '🖥️', service: 'EC2', name: 'Servers running 24/7 for a workload that shows up at 9am and leaves at 5pm', savings: '40-70%' },
  { emoji: '🏗️', service: 'RDS', name: 'A database the size of a school bus for an app with 50 users', savings: '30-60%' },
  { emoji: '🧘', service: 'EC2', name: 'Instances in a meditative state (they\'re not meditating, they\'re idle)', savings: '20-40%' },
  { emoji: '💳', service: 'Savings Plans', name: 'AWS literally wants you to buy these but nobody told you', savings: '30-50%' },
  { emoji: '🦕', service: 'EBS', name: 'Snapshots so old they remember when us-east-1 was the only region', savings: '$100-1K/mo' },
  { emoji: '🍽️', service: 'NAT GW', name: 'Quietly eating your budget for lunch every single day', savings: '$200-2K/mo' },
  { emoji: '🐿️', service: 'Architecture', name: 'Built for the pitch deck, not the business you\'re actually running', savings: '20-50%' }
]

// ── Pricing (change here, updates everywhere) ──
const pricing = {
  depositPct: 1,       // Down payment: 1% of AWS annual spend to start
  reportPct: 15,       // The Report: 15% of annual savings (deposit deducted)
  fixPct: 50,          // The Fix: 50% total (15% report + 35% implementation)
  implPct: 35,         // Implementation portion (fixPct - reportPct)
  securityPct: 10,     // Security Audit: 10% of AWS annual spend (free during promo)
  minAws: 5000,        // We work best with $5-150K/mo AWS spend
}

// ── Example numbers ──
const exampleBefore = 25000
const exampleSavings = 9000
const exampleAnnual = exampleSavings * 12
const exampleAwsAnnual = exampleBefore * 12
const depositFee = Math.round(exampleAwsAnnual * pricing.depositPct / 100)
const reportFee = Math.round(exampleAnnual * pricing.reportPct / 100)
const reportRemainder = reportFee - depositFee
const fixFee = Math.round(exampleAnnual * pricing.fixPct / 100)
const reportNet = exampleAnnual - reportFee
const fixNet = exampleAnnual - fixFee
const exampleMonthsToRoi = Math.ceil(fixFee / exampleSavings)
const exampleThreeYearNet = (exampleAnnual * 3) - fixFee
const minAwsK = `$${pricing.minAws / 1000}K`
</script>

<template>
  <div class="min-h-screen bg-gray-950 text-gray-100">
    <!-- Promo Banner -->
    <div v-if="promoActive" class="bg-brand-600 text-white text-center py-2.5 px-6 text-sm font-medium">
      <a :href="calendly('promo-banner')" target="_blank" class="hover:underline">
        🛡️ FREE Security Audit (normally {{ pricing.securityPct }}% of AWS annual spend) with every engagement — ends in {{ promoDaysLeft }} day{{ promoDaysLeft === 1 ? '' : 's' }}!
      </a>
    </div>

    <!-- Nav -->
    <nav class="border-b border-gray-800/50">
      <div class="max-w-5xl mx-auto px-6 py-4 flex items-center justify-between">
        <div class="flex items-center gap-2">
          <span class="text-2xl">✂️</span>
          <span class="font-bold text-lg">Cut My AWS</span>
        </div>
        <a
          :href="calendly('nav')"
          target="_blank"
          class="bg-brand-500 hover:bg-brand-600 text-white font-semibold px-5 py-2 rounded-lg transition-colors text-sm"
        >
          💸 Let's Go
        </a>
      </div>
    </nav>

    <!-- Hero -->
    <section class="relative overflow-hidden">
      <!-- Background gradient -->
      <div class="absolute inset-0 bg-gradient-to-br from-brand-500/5 via-transparent to-brand-500/3"></div>
      <div class="absolute top-0 right-0 w-[600px] h-[600px] bg-brand-500/5 rounded-full blur-3xl -translate-y-1/2 translate-x-1/3"></div>
      <div class="absolute bottom-0 left-0 w-[400px] h-[400px] bg-brand-500/3 rounded-full blur-3xl translate-y-1/2 -translate-x-1/3"></div>
    <div class="relative max-w-5xl mx-auto px-6 pt-16 pb-16">
      <div class="flex flex-col lg:flex-row gap-12 items-center">
        <!-- Left: Text -->
        <div class="flex-1">
          <p class="text-brand-400 font-semibold mb-4 text-lg">🛋️ Cloud cost optimization — without the dashboard</p>
          <h1 class="text-4xl sm:text-5xl font-bold leading-tight mb-6">
            Been using AWS for years? 🕸️<br>
            <span class="text-brand-400">When's the last time you cleaned house?</span>
          </h1>
          <p class="text-xl text-gray-400 mb-6">
            With 300+ AWS services and years of buildup, I find the waste, fix the aging architecture &mdash; and <strong class="text-gray-200">you only pay a one-time % of what I save you.</strong> 💸
          </p>
          <div class="flex flex-col sm:flex-row gap-4">
            <a
              :href="calendly('hero')"
              target="_blank"
              class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg text-center"
            >
              🗓️ Book Your<br class="sm:hidden"> Intro Call
            </a>
            <p class="text-gray-500 text-sm self-center">15 min &middot; {{ pricing.depositPct }}% down to start &middot; no pitch deck 😏</p>
          </div>
        </div>

        <!-- Right: Visual card -->
        <div class="w-full lg:w-[380px] shrink-0">
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8 text-center">
            <!-- Headshot -->
            <img src="/david.png" alt="David Plappert" class="w-28 h-28 rounded-full mx-auto mb-5 object-cover object-top border-2 border-gray-700">
            <p class="font-bold text-lg mb-1">David Plappert</p>
            <p class="text-gray-500 text-sm mb-6">19 years on AWS &middot; Since day one ☕</p>

            <!-- Animated savings ticker -->
            <div class="bg-gray-950 rounded-xl p-5 border border-gray-800 mb-5">
              <p class="text-gray-500 text-xs uppercase tracking-wider mb-2">Typical savings found</p>
              <p class="text-4xl font-bold text-green-400 tabular-nums">
                $<span ref="tickerRef">{{ tickerDisplay }}</span><span class="text-gray-500 text-lg">/yr</span>
              </p>
              <p class="text-gray-600 text-xs mt-1">on a $25K/mo account 👀</p>
            </div>

            <!-- Quick value props -->
            <div class="space-y-2 text-left text-sm">
              <div class="flex items-center gap-2 text-gray-400">
                <span class="text-brand-400">✅</span> You only pay a % of savings found
              </div>
              <div class="flex items-center gap-2 text-gray-400">
                <span class="text-brand-400">✅</span> No savings? No fee. Period.
              </div>
              <div class="flex items-center gap-2 text-gray-400">
                <span class="text-brand-400">✅</span> Not a dashboard. A real person.
              </div>
            </div>
          </div>
        </div>
      </div>
      </div>
    </section>

    <!-- Stats -->
    <section class="bg-gray-900">
      <div class="max-w-4xl mx-auto px-6 py-24 grid grid-cols-1 sm:grid-cols-3 gap-12">
        <div v-for="stat in stats" :key="stat.label" class="text-center px-4">
          <div class="text-3xl font-bold text-brand-400 mb-2">{{ stat.value }}</div>
          <div class="text-sm text-gray-400 leading-relaxed">{{ stat.label }}</div>
        </div>
      </div>
    </section>

    <!-- Clients -->
    <section class="py-24 px-6">
      <p class="text-center text-gray-500 text-sm uppercase tracking-wider mb-12">Trusted by teams at</p>
      <div class="grid grid-cols-2 sm:grid-cols-4 gap-8 items-center justify-items-center max-w-4xl mx-auto">
        <a
          v-for="client in clients"
          :key="client.name"
          :href="client.url"
          target="_blank"
          rel="noopener"
          class="group flex items-center justify-center h-24 w-full px-4 rounded-lg bg-white/90 hover:bg-white transition-all"
          :title="client.name"
        >
          <img
            :src="client.logo"
            :alt="client.name"
            class="h-14 max-w-[180px] object-contain opacity-90 group-hover:opacity-100 transition-opacity"
          >
        </a>
      </div>
    </section>

    <!-- Testimonials -->
    <section class="bg-gray-900">
      <div class="max-w-5xl mx-auto px-6 py-24">
        <p class="text-center text-gray-500 text-sm uppercase tracking-wider mb-10">What people say after working with David</p>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div
            v-for="t in testimonials"
            :key="t.quote"
            class="bg-gray-950 border border-gray-800 rounded-2xl p-8 text-center"
          >
            <p class="text-4xl mb-4">{{ t.emoji }}</p>
            <p class="text-gray-300 text-lg italic">"{{ t.quote }}"</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Why CutMyAWS -->
    <section class="max-w-5xl mx-auto px-6 py-24">
      <h2 class="text-3xl font-bold mb-4 text-center">Why CutMyAWS? 🤔</h2>
      <p class="text-gray-400 text-center mb-12 max-w-2xl mx-auto">Growing cloud spend doesn't mean efficient cloud spend. Cloud cost optimization tools show you charts &mdash; I show you why your tech doesn't match your business. Your revenue grew 40% &mdash; did your AWS bill grow 40% too? Or 80%? 📈</p>
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6 max-w-4xl mx-auto">
        <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8">
          <p class="text-2xl mb-3">🧑‍💻</p>
          <h3 class="text-lg font-bold mb-2">Keep your tech team building value</h3>
          <p class="text-gray-400">Your engineers should be shipping product, not hunting for savings. I dig into your architecture, find the misalignment, and do the one-time cleanup so they don't have to. No recurring retainer. No ongoing distraction. Just results. 🚀</p>
        </div>
        <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8">
          <p class="text-2xl mb-3">🙅</p>
          <h3 class="text-lg font-bold mb-2">Not a dashboard. Not an AI. A human.</h3>
          <p class="text-gray-400">Cloud cost optimization tools show charts. AI generates summaries. I read your architecture, understand your business, and tell you exactly what to change and why. Real cloud cost optimization is a person, not a platform. And I only make money when you do. 🤝</p>
        </div>
        <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8">
          <p class="text-2xl mb-3">💰</p>
          <h3 class="text-lg font-bold mb-2">You don't pay until you see results</h3>
          <p class="text-gray-400">This is a one-time commitment, not an ongoing contract. The implementation fee isn't due until you've experienced the savings for 90 days. No savings? No fee. I carry the risk, not you. 🎯</p>
        </div>
        <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8">
          <p class="text-2xl mb-3">📉</p>
          <h3 class="text-lg font-bold mb-2">Growing ≠ efficient</h3>
          <p class="text-gray-400">Nobody sets out to waste money on AWS. You launch fast, scale fast, and three years later you're paying for infrastructure you forgot existed. That's not negligence &mdash; that's just building a business. Let me clean it up. 🧾</p>
        </div>
      </div>
    </section>

    <!-- How It Works -->
    <section class="bg-gray-900">
      <div class="max-w-5xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-4 text-center">How It Works 🧰</h2>
        <p class="text-gray-400 text-center mb-12 max-w-xl mx-auto">One 45-minute call. One PDF. Zero PowerPoints. You decide how far to go after you see the numbers. 🤝</p>

        <!-- Timeline -->
        <div class="max-w-2xl mx-auto space-y-8">

          <!-- Step 1: Intro Call -->
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-8">
            <div class="flex items-center gap-3 mb-4">
              <span class="bg-brand-500 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">1</span>
              <div>
                <h3 class="text-xl font-bold">🗓️ Intro Call</h3>
                <p class="text-gray-500 text-sm">15 min &middot; {{ pricing.depositPct }}% of AWS annual spend to start ☕</p>
              </div>
            </div>
            <p class="text-gray-400 mb-4">We meet, I ask annoying questions about your business, and you grant read-only AWS access so I can go deep. Then the {{ pricing.depositPct }}% down payment kicks things off. 🔍</p>
            <p class="text-gray-500 text-sm">💡 The {{ pricing.depositPct }}% is a down payment &mdash; it gets <strong class="text-gray-300">deducted from The Report fee</strong>. Think of it as a deposit, not an extra charge. You're not paying more, you're paying sooner.</p>
          </div>

          <!-- Arrow -->
          <div class="text-center text-gray-600 text-2xl">⏳ 5-10 business days (I'm in your account, learning your business, judging your tag hygiene)</div>

          <!-- Step 2: Exploration Call -->
          <div class="bg-gray-950 border-2 border-brand-500 rounded-2xl p-8">
            <div class="flex items-center gap-3 mb-4">
              <span class="bg-brand-500 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">2</span>
              <div>
                <h3 class="text-xl font-bold">📋 The Report</h3>
                <p class="text-gray-500 text-sm">{{ pricing.reportPct }}% of annualized savings found (minus your {{ pricing.depositPct }}% deposit)</p>
              </div>
            </div>
            <p class="text-gray-400 mb-4">The Report is two things: a <strong class="text-gray-200">45-minute call</strong> where I walk you and your team through every finding, and a <strong class="text-gray-200">full PDF</strong> you keep forever. The call is where we dig in together &mdash; every waste item, exact dollar amounts, architecture recommendations, and where your tech doesn't match your business. The PDF is so nobody has to remember what I said. 📄</p>
            <ul class="space-y-3 text-gray-300">
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span><strong class="text-gray-200">45-minute live call</strong> with you and your team &mdash; ask questions, push back, bring your skeptic 🤨</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span><strong class="text-gray-200">Full PDF report</strong> &mdash; line-by-line savings breakdown your CFO will actually understand (and maybe frame)</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>Architecture recommendations &mdash; "this should be serverless" and "this database is 10x bigger than it needs to be" 🏗️</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>Implementation guide for your team if you want to DIY (I don't gatekeep) 🛠️</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>You keep the report forever. Even if you ghost me. I'll survive. Probably. 👻</span>
              </li>
              <li v-if="promoActive" class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">🎁</span>
                <span><strong class="text-brand-400">BONUS:</strong> Free Security Audit (normally {{ pricing.securityPct }}% of AWS annual spend) &mdash; full PDF report covering misconfigs, public S3 buckets, IAM risks, and more ({{ promoDaysLeft }} day{{ promoDaysLeft === 1 ? '' : 's' }} left!)</span>
              </li>
            </ul>
            <p class="text-gray-500 text-sm mt-4">The remaining {{ pricing.reportPct }}% fee (minus your {{ pricing.depositPct }}% deposit) is due at this call. You saw the numbers, you liked them, now we settle up. Math. 🧮</p>
          </div>

          <!-- Security Audit Add-on -->
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-8 relative">
            <div v-if="promoActive" class="absolute -top-3 right-6 bg-green-500 text-white text-xs font-bold px-3 py-1 rounded-full">🎁 FREE for {{ promoDaysLeft }} more day{{ promoDaysLeft === 1 ? '' : 's' }}!</div>
            <div v-else class="absolute -top-3 right-6 bg-gray-700 text-white text-xs font-bold px-3 py-1 rounded-full">ADD-ON</div>
            <div class="flex items-center gap-3 mb-4">
              <span class="bg-gray-700 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">🔒</span>
              <div>
                <h3 class="text-xl font-bold">🛡️ Security Audit</h3>
                <p class="text-gray-500 text-sm">{{ pricing.securityPct }}% of AWS annual spend<span v-if="promoActive"> &middot; <strong class="text-green-400">FREE during promo</strong></span></p>
              </div>
            </div>
            <p class="text-gray-400 mb-4">Not a dashboard. Not an AI summary. A one-time PDF report written by a senior AWS architect who's actually reading your account. I go through your security posture line by line and tell you exactly what's exposed, what's misconfigured, and what's one bad day away from a breach. 🔍</p>
            <ul class="space-y-3 text-gray-300">
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>Public S3 buckets &mdash; the #1 cause of "we made the news and not in the good way" 🪣</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>Overprivileged IAM roles &mdash; does your intern's role really need <code class="text-brand-300 text-sm">AdministratorAccess</code>? (It does not.) 🔑</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>Security group misconfigs &mdash; ports open to the internet that shouldn't be, rules that made sense three years ago 🚪</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>Unencrypted resources, missing logging, disabled CloudTrail &mdash; the stuff that makes compliance auditors cry 😰</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>Delivered as a prioritized PDF: critical → high → medium. Fix the scary stuff first. 📋</span>
              </li>
            </ul>
            <p v-if="promoActive" class="text-green-400 text-sm font-semibold mt-4">🎁 Book before the promo ends and this is included free with The Report. After that, it's {{ pricing.securityPct }}% of AWS annual spend.</p>
            <p v-else class="text-gray-500 text-sm mt-4">{{ pricing.securityPct }}% of your AWS annual spend. Worth every penny when the alternative is explaining a breach to your board. 🫠</p>
          </div>

          <!-- Arrow -->
          <div class="text-center text-gray-600 text-2xl">🤔 Want me to actually fix it? (Most people do. Turns out reading a 30-page report isn't fun.)</div>

          <!-- Step 3: Implementation (Optional) -->
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-8 relative">
            <div class="absolute -top-3 right-6 bg-brand-500 text-white text-xs font-bold px-3 py-1 rounded-full">🔥 OPTIONAL (but c'mon)</div>
            <div class="flex items-center gap-3 mb-4">
              <span class="bg-gray-700 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">3</span>
              <div>
                <h3 class="text-xl font-bold">🔧 The Fix &mdash; Implementation</h3>
                <p class="text-gray-500 text-sm">Decided at the exploration call &middot; scoped together like adults</p>
              </div>
            </div>
            <p class="text-gray-400 mb-4">We agree on a timeline, deliverables, and scope before I touch anything. Then I get to work making your AWS account match your actual business. Serverless migrations, right-sizing, Savings Plans &mdash; the whole shebang. 💪</p>
            <ul class="space-y-3 text-gray-300">
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>I implement every optimization (you watch, ask questions, or take a nap &mdash; dealer's choice 😴)</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>Custom timeline and deliverables. No mystery. No "we'll circle back." Actual dates.</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>90 days after deliverables, we compare bills. Did the savings actually happen? 📊</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span><strong>+{{ pricing.implPct }}% of verified savings due at the 90-day mark.</strong> The best part? It's a one-time payment from money you were already giving AWS. No new budget. No approvals. Just redirect what you're already spending. If the savings didn't stick? You owe me nothing. I'll go cry into my own AWS bill. 🤷</span>
              </li>
            </ul>
            <p class="text-gray-500 text-sm mt-4">{{ pricing.fixPct }}% total max ({{ pricing.reportPct }}% report + {{ pricing.implPct }}% implementation). That's the ceiling. There is no "and also this other fee." 🚫</p>
          </div>

          <!-- Arrow -->
          <div class="text-center text-gray-600 text-2xl">⏳ 90 days later... (the moment of truth 🥁)</div>

          <!-- Step 4: Verification -->
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-8">
            <div class="flex items-center gap-3 mb-4">
              <span class="bg-gray-700 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">4</span>
              <div>
                <h3 class="text-xl font-bold">📊 The Proof</h3>
                <p class="text-gray-500 text-sm">+{{ pricing.implPct }}% of verified annual savings &middot; a.k.a. "show me the receipts"</p>
              </div>
            </div>
            <p class="text-gray-400">We pull up your AWS bill. Before. After. Side by side. The {{ pricing.implPct }}% is based on <strong class="text-gray-200">actual, verified, no-BS savings</strong> &mdash; not my projections, not a spreadsheet estimate, not vibes. Real numbers on a real bill. If the savings didn't show up, I don't get paid. That's how confident I am. 💰</p>
          </div>

        </div>
      </div>
    </section>

    <!-- ROI Calculator -->
    <section class="max-w-5xl mx-auto px-6 py-24">
      <h2 class="text-3xl font-bold mb-2 text-center">🧮 Calculate Your Savings</h2>
      <p class="text-gray-400 text-center mb-2">Cloud cost optimization with no monthly fees. You pay once. Keep the savings forever. 💰</p>
      <p class="text-gray-500 text-center mb-10 text-sm">Drag the sliders or type your actual AWS spend below.</p>

      <div class="max-w-3xl mx-auto bg-gray-900 border border-gray-800 rounded-2xl p-8">
        <!-- Inputs -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-8">
          <!-- Monthly spend -->
          <div>
            <label class="text-gray-300 font-medium block mb-3">💸 Monthly AWS Spend</label>
            <div class="flex items-center gap-2 mb-3">
              <span class="text-gray-500 text-xl">$</span>
              <input
                v-model.number="calcAwsSpend"
                type="number"
                :min="pricing.minAws"
                max="500000"
                step="1000"
                class="w-full bg-gray-950 border border-gray-700 rounded-lg px-4 py-3 text-2xl font-bold text-brand-400 focus:border-brand-500 focus:outline-none"
              >
            </div>
            <input
              v-model.number="calcAwsSpend"
              type="range"
              :min="pricing.minAws"
              max="150000"
              step="5000"
              class="w-full h-2 bg-gray-700 rounded-lg appearance-none cursor-pointer accent-brand-500"
            >
            <div class="flex justify-between text-xs text-gray-600 mt-1">
              <span>{{ minAwsK }}</span>
              <span>$75K</span>
              <span>$150K</span>
            </div>
          </div>
          <!-- Waste % -->
          <div>
            <label class="text-gray-300 font-medium block mb-3">🔍 Estimated Waste</label>
            <div class="flex items-center gap-2 mb-3">
              <input
                v-model.number="calcWastePct"
                type="number"
                min="5"
                max="60"
                step="1"
                class="w-full bg-gray-950 border border-gray-700 rounded-lg px-4 py-3 text-2xl font-bold text-red-400 focus:border-red-500 focus:outline-none"
              >
              <span class="text-gray-500 text-xl">%</span>
            </div>
            <input
              v-model.number="calcWastePct"
              type="range"
              min="10"
              max="50"
              step="5"
              class="w-full h-2 bg-gray-700 rounded-lg appearance-none cursor-pointer accent-red-500"
            >
            <div class="flex justify-between text-xs text-gray-600 mt-1">
              <span>10% lean</span>
              <span>30% typical</span>
              <span>50% yikes</span>
            </div>
          </div>
        </div>

        <!-- Savings found -->
        <div class="bg-gray-950 rounded-xl p-5 border border-gray-800 mb-6 text-center">
          <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">🔥 You're wasting roughly</p>
          <p class="text-3xl font-bold text-red-400">${{ calcMonthlySavings.toLocaleString() }}<span class="text-gray-500 text-lg">/mo</span> &nbsp; = &nbsp; ${{ calcAnnualSavings.toLocaleString() }}<span class="text-gray-500 text-lg">/yr</span></p>
        </div>

        <!-- Two plan comparison -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
          <!-- The Report -->
          <div class="bg-gray-950 rounded-xl p-5 border border-gray-800">
            <p class="text-gray-400 text-xs uppercase tracking-wider mb-3">📋 The Report ({{ pricing.reportPct }}%)</p>
            <div class="space-y-2 text-sm">
              <div class="flex justify-between">
                <span class="text-gray-500">You pay</span>
                <span class="font-semibold">${{ calcReportFee.toLocaleString() }}</span>
              </div>
              <div class="flex justify-between text-lg">
                <span class="font-bold text-green-400">You keep yr 1</span>
                <span class="font-bold text-green-400">${{ calcKeepReport.toLocaleString() }}</span>
              </div>
              <div class="flex justify-between">
                <span class="text-gray-500">First-year ROI</span>
                <span class="font-bold text-brand-400">{{ calcRoiReport }}x</span>
              </div>
            </div>
          </div>
          <!-- The Fix -->
          <div class="bg-gray-950 rounded-xl p-5 border-2 border-brand-500">
            <p class="text-gray-400 text-xs uppercase tracking-wider mb-3">🔧 The Fix ({{ pricing.fixPct }}% total)</p>
            <div class="space-y-2 text-sm">
              <div class="flex justify-between">
                <span class="text-gray-500">You pay</span>
                <span class="font-semibold">${{ calcFixFee.toLocaleString() }}</span>
              </div>
              <div class="flex justify-between text-lg">
                <span class="font-bold text-green-400">You keep yr 1</span>
                <span class="font-bold text-green-400">${{ calcKeepFix.toLocaleString() }}</span>
              </div>
              <div class="flex justify-between">
                <span class="text-gray-500">First-year ROI</span>
                <span class="font-bold text-brand-400">{{ calcRoiFix }}x</span>
              </div>
            </div>
          </div>
        </div>

        <!-- ROI highlight bar -->
        <div class="bg-green-400/10 border border-green-400/30 rounded-xl p-5 mb-6">
          <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 text-center">
            <div>
              <p class="text-green-400 text-2xl font-bold">{{ calcMonthsToRoi }} mo</p>
              <p class="text-gray-400 text-xs">⏱️ Time to break even (The Fix)</p>
            </div>
            <div>
              <p class="text-green-400 text-2xl font-bold">${{ calcAnnualSavings.toLocaleString() }}</p>
              <p class="text-gray-400 text-xs">🚀 You keep every year after year 1</p>
            </div>
            <div>
              <p class="text-green-400 text-2xl font-bold">${{ calcFiveYearNet.toLocaleString() }}</p>
              <p class="text-gray-400 text-xs">💰 5-year net savings (after The Fix fee)</p>
            </div>
          </div>
        </div>

        <p class="text-gray-600 text-xs text-center mb-6">No monthly fees. No subscriptions. No recurring charges. You pay once and keep 100% of the savings every year after. ✂️</p>

        <!-- CTA -->
        <div class="text-center">
          <a
            :href="calendly('calculator')"
            target="_blank"
            class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg text-center"
          >
            🗓️ Let's find your actual number →
          </a>
        </div>
      </div>
    </section>

    <!-- Example -->
    <section class="bg-gray-900">
      <div class="max-w-5xl mx-auto px-6 py-24">
      <h2 class="text-3xl font-bold mb-2 text-center">🧮 Real Math, Fake Company</h2>
      <p class="text-gray-400 text-center mb-2">A ${{ (exampleBefore).toLocaleString() }}/mo SaaS company that swore their AWS was "pretty optimized" 👀</p>
      <p class="text-brand-400 font-semibold text-center mb-8">One-time fee. Paid from your recurring savings. ~{{ exampleMonthsToRoi }}-month ROI. 🎯</p>

      <!-- Shared finding -->
      <div class="max-w-2xl mx-auto bg-gray-950 border border-gray-800 rounded-2xl p-6 mb-8">
        <div class="flex justify-between mb-2">
          <span class="text-gray-400">🔥 Monthly waste found (whoops)</span>
          <span class="font-semibold text-red-400">${{ exampleSavings.toLocaleString() }}/mo</span>
        </div>
        <div class="flex justify-between">
          <span class="text-gray-400">💰 Annual savings (just vibing in their account)</span>
          <span class="font-semibold">${{ exampleAnnual.toLocaleString() }}/yr</span>
        </div>
      </div>

      <!-- Payment timeline -->
      <div class="max-w-2xl mx-auto bg-gray-950 border border-gray-800 rounded-2xl p-8">
        <h3 class="font-bold text-center mb-6">💳 When You Pay (with The Fix)</h3>
        <div class="space-y-4 text-sm">
          <div class="flex justify-between items-center">
            <div>
              <span class="text-gray-300 font-medium">🗓️ Intro Call</span>
              <span class="text-gray-500 ml-2">Day 1</span>
            </div>
            <span class="font-semibold">${{ depositFee.toLocaleString() }}</span>
          </div>
          <div class="text-gray-500 text-xs pl-4">{{ pricing.depositPct }}% of ${{ exampleAwsAnnual.toLocaleString() }} annual AWS spend = ${{ depositFee.toLocaleString() }} (deducted from The Report fee)</div>
          <div class="flex justify-between items-center">
            <div>
              <span class="text-gray-300 font-medium">📋 The Report (45-min call + PDF)</span>
              <span class="text-gray-500 ml-2">~2 weeks</span>
            </div>
            <span class="font-semibold">${{ reportRemainder.toLocaleString() }}</span>
          </div>
          <div class="text-gray-500 text-xs pl-4">{{ pricing.reportPct }}% of ${{ exampleAnnual.toLocaleString() }} = ${{ reportFee.toLocaleString() }} minus ${{ depositFee.toLocaleString() }} deposit = ${{ reportRemainder.toLocaleString() }}</div>
          <div class="flex justify-between items-center">
            <div>
              <span class="text-gray-300 font-medium">📊 90 Days After Implementation</span>
              <span class="text-gray-500 ml-2">~4-5 months</span>
            </div>
            <span class="font-semibold">${{ (fixFee - reportFee).toLocaleString() }}</span>
          </div>
          <div class="text-gray-500 text-xs pl-4">{{ pricing.implPct }}% of <strong>verified</strong> savings only. No savings? No charge. Pinky swear. 🤙</div>
          <hr class="border-gray-700">
          <div class="flex justify-between text-base">
            <span class="font-bold text-gray-300">Total max ({{ pricing.fixPct }}%)</span>
            <span class="font-bold">${{ fixFee.toLocaleString() }}</span>
          </div>
          <div class="flex justify-between text-base">
            <span class="font-bold text-brand-400">🎉 You keep (year 1)</span>
            <span class="font-bold text-brand-400">${{ fixNet.toLocaleString() }}</span>
          </div>
          <div class="flex justify-between text-base">
            <span class="font-bold text-green-400">🚀 You keep (every year after that, forever)</span>
            <span class="font-bold text-green-400">${{ exampleAnnual.toLocaleString() }}</span>
          </div>
        </div>
      </div>
      <!-- ROI -->
      <div class="max-w-2xl mx-auto bg-green-400/10 border border-green-400/30 rounded-2xl p-8 mt-8">
        <h3 class="font-bold text-center mb-6">📊 Return on Investment</h3>
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-6 text-center">
          <div>
            <p class="text-green-400 text-3xl font-bold">{{ exampleMonthsToRoi }} mo</p>
            <p class="text-gray-400 text-sm mt-1">⏱️ Time to ROI</p>
          </div>
          <div>
            <p class="text-green-400 text-3xl font-bold">${{ fixNet.toLocaleString() }}</p>
            <p class="text-gray-400 text-sm mt-1">🎉 Year 1 net savings</p>
          </div>
          <div>
            <p class="text-green-400 text-3xl font-bold">${{ exampleThreeYearNet.toLocaleString() }}</p>
            <p class="text-gray-400 text-sm mt-1">🚀 3-year net savings</p>
          </div>
        </div>
        <p class="text-gray-500 text-xs text-center mt-4">One-time fee. Every dollar saved after that is yours. Forever. ✂️</p>
      </div>

      <p class="text-gray-500 text-sm text-center mt-6">Just want The Report? {{ pricing.reportPct }}%, a 45-min call, a PDF, and your team handles the rest. You keep ${{ reportNet.toLocaleString() }} year one. No hard feelings. 💰</p>
      </div>
    </section>

    <!-- Common Waste -->
    <section>
      <div class="max-w-5xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-2 text-center">🕵️ The Usual Suspects</h2>
        <p class="text-gray-400 text-center mb-8">Decisions that made sense at the time. That time was 2021. It's not 2021 anymore.</p>
        <div class="max-w-3xl mx-auto space-y-4">
          <div
            v-for="item in wasteSources"
            :key="item.name"
            class="flex items-center gap-4 bg-gray-900 border border-gray-800 rounded-xl px-5 py-4"
          >
            <span class="text-2xl shrink-0">{{ item.emoji }}</span>
            <span class="bg-brand-500/15 text-brand-400 text-xs font-bold px-2.5 py-1 rounded-md shrink-0 w-24 text-center">{{ item.service }}</span>
            <span class="text-gray-300 flex-1">{{ item.name }}</span>
            <span class="text-red-400 font-bold text-sm whitespace-nowrap ml-2">{{ item.savings }}</span>
          </div>
        </div>
      </div>
    </section>

    <!-- About -->
    <section class="bg-gray-900">
      <div class="max-w-2xl mx-auto px-6 py-24 text-center">
        <img src="/david.png" alt="David Plappert" class="w-32 h-32 rounded-full mx-auto mb-6 object-cover object-top border-2 border-gray-700">
        <h2 class="text-3xl font-bold mb-6">👋 Who's poking around my AWS account?</h2>
        <p class="text-gray-400 text-lg leading-relaxed mb-4">
          I'm <a href="https://www.linkedin.com/in/davidplappert/" target="_blank" class="text-brand-400 hover:underline">David Plappert</a> &mdash; an actual human being with 19 years of AWS experience who will personally
          dig through your account, read your architecture, and understand your business. 🍱 Not an AI-generated summary.
          Not a dashboard with traffic lights. Not a junior analyst following a checklist. Me. On a call. With opinions. And a mildly aggressive sense of humor.
        </p>
        <p class="text-gray-400 text-lg leading-relaxed mb-4">
          I build and run production serverless SaaS at Fortune 100 scale &mdash; Lambda, API Gateway, S3, SES, the whole buffet.
          I know where AWS hides the markup because <strong class="text-gray-200">I've been paying it myself for years.</strong>
          Most cloud cost optimization tools tell you what you're spending. I tell you <em>why</em> your tech doesn't match your business &mdash; and I make it <strong class="text-gray-200">not just cheaper, but better.</strong> 🎯
        </p>
        <p class="text-gray-400 text-lg leading-relaxed mb-4">
          Should that EC2 fleet be Lambda functions? (Probably.) Does that RDS instance need to be that big? (It does not.)
          Is your architecture built for a business model that pivoted two years ago? (Almost certainly.) I ask the questions a dashboard can't. 🤔
        </p>
        <p class="text-gray-400 text-lg leading-relaxed mb-4">
          I only need <strong class="text-gray-200">read-only access</strong> for the scan. 🔒
          No write permissions. I can look but I can't touch. Think of it as window shopping your infrastructure. Very judgmentally.
        </p>
        <p class="text-gray-400 text-lg leading-relaxed mb-4">
          When I'm not auditing your infrastructure, I'm in the suburbs of Peoria, IL with my wife and two young kids. 🏡
          The honest truth? I started CutMyAWS because I want to pay off our house and get my family completely debt-free.
          That's it. No VC funding. No exit strategy. Just a dad who's <strong class="text-gray-200">really good at AWS</strong> and
          <strong class="text-gray-200">really motivated</strong> to find your savings &mdash; because every dollar I earn pays off my house faster. 😅
        </p>
        <p class="text-gray-500 text-base">
          Yes, "Cut My AWS" is a real business name registered with the state of Florida. No, I will not apologize for it. ✂️
        </p>
      </div>
    </section>

    <!-- Security & Compliance -->
    <section>
      <div class="max-w-5xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-4 text-center">🔒 Your Data. My Paranoia.</h2>
        <p class="text-gray-400 text-center mb-12 max-w-2xl mx-auto">I've worked with organizations that handle the most sensitive data in the country. Your AWS account is in good hands. Careful, experienced, slightly paranoid hands. 🫡</p>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 max-w-4xl mx-auto mb-12">
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6 text-center">
            <p class="text-3xl mb-3">🏥</p>
            <h3 class="font-bold mb-1">HIPAA</h3>
            <p class="text-gray-500 text-sm">Protected health information? Been there, secured that.</p>
          </div>
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6 text-center">
            <p class="text-3xl mb-3">🏛️</p>
            <h3 class="font-bold mb-1">DC Health Link</h3>
            <p class="text-gray-500 text-sm">Health exchange data for the nation's capital.</p>
          </div>
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6 text-center">
            <p class="text-3xl mb-3">💳</p>
            <h3 class="font-bold mb-1">PII &amp; eCommerce</h3>
            <p class="text-gray-500 text-sm">Customer data, payment data, the stuff that keeps you up at night.</p>
          </div>
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6 text-center">
            <p class="text-3xl mb-3">📋</p>
            <h3 class="font-bold mb-1">IRS Pub 1075</h3>
            <p class="text-gray-500 text-sm">Federal tax information. The government trusted me. You can too.</p>
          </div>
        </div>
        <div class="max-w-2xl mx-auto bg-gray-900 border border-gray-800 rounded-2xl p-8">
          <h3 class="font-bold mb-4 text-center">🛡️ How access works</h3>
          <ul class="space-y-3 text-gray-400">
            <li class="flex items-start gap-3">
              <span class="text-brand-400 mt-0.5">✅</span>
              <span><strong class="text-gray-200">Read-only IAM role</strong> &mdash; scoped policy, your team provisions it. I can look but I literally cannot touch. 👀</span>
            </li>
            <li class="flex items-start gap-3">
              <span class="text-brand-400 mt-0.5">✅</span>
              <span><strong class="text-gray-200">No data extraction</strong> &mdash; I audit infrastructure and architecture, not your application data.</span>
            </li>
            <li class="flex items-start gap-3">
              <span class="text-brand-400 mt-0.5">✅</span>
              <span><strong class="text-gray-200">SOC 2, HIPAA, FedRAMP environments</strong> &mdash; I've worked inside all of them. I know the rules. 🏗️</span>
            </li>
            <li class="flex items-start gap-3">
              <span class="text-brand-400 mt-0.5">✅</span>
              <span><strong class="text-gray-200">Access revoked when we're done</strong> &mdash; you control it the entire time. Delete the role and I'm gone.</span>
            </li>
          </ul>
        </div>
      </div>
    </section>

    <!-- FAQ -->
    <section class="bg-gray-900">
      <div class="max-w-5xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-12 text-center">❓ Questions you're definitely asking right now</h2>
        <div class="max-w-2xl mx-auto space-y-10">
          <div>
            <h3 class="text-lg font-bold mb-3">🤔 What if you don't find any savings?</h3>
            <p class="text-gray-400">Then you have the most optimized AWS account I've ever seen, and honestly? I'll be impressed. In my career this has happened exactly zero times, but I hear there's a first time for everything. I'll send you a congratulatory email.</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🤨 When do I actually pay?</h3>
            <p class="text-gray-400">{{ pricing.depositPct }}% of your AWS annual spend is due at the intro call as a down payment &mdash; it gets deducted from The Report fee. {{ pricing.reportPct }}% of annualized savings (minus the deposit) is due when The Report is delivered &mdash; that's a 45-minute call with you and your team plus a full PDF. If you opt for implementation, the extra {{ pricing.implPct }}% isn't due until <strong>90 days after deliverables</strong> &mdash; and only on verified savings. You literally never pay for results that didn't happen. This is the opposite of how consulting usually works, and I'm aware of that. 😅</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🎯 Is this just a cost audit or something more?</h3>
            <p class="text-gray-400">Way more. Cloud cost optimization tools tell you <em>what</em> you're spending. I tell you <em>why</em> your tech doesn't match your business &mdash; and that's where the real cloud cost savings live. Running servers 24/7 for a workload that spikes twice a day? That's not a billing problem, that's an architecture problem. I'm a serverless architect who does cloud cost optimization the way it should be done &mdash; business-aligned, not dashboard-driven. The savings are a side effect of good architecture. 🏗️</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">📏 Is $10-150K/mo really the sweet spot?</h3>
            <p class="text-gray-400">We work best with AWS accounts spending {{ minAwsK }}/mo or more. Below that, there usually isn't enough waste to justify an engagement. Above $150K you probably need a full-time FinOps team (I can help you hire one, actually). But that {{ minAwsK }}-150K range? That's where businesses are big enough to have real infrastructure but too busy building product to optimize it. That's my people. 🫡</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🧑‍💻 Can't my team just optimize this ourselves?</h3>
            <p class="text-gray-400">They can try! But cloud cost optimization isn't scanning dashboards for random savings. I'm reading your architecture, understanding your business, and finding the structural mismatches &mdash; the kind of waste that no cloud cost optimization tool surfaces. It's the difference between a thermometer and a doctor. One tells you the temperature. The other tells you why you feel terrible and gives you a prescription. 🌡️</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🛠️ What if my team can implement the fixes themselves?</h3>
            <p class="text-gray-400">Awesome &mdash; that's literally what The Report is for. You pay {{ pricing.reportPct }}%, get the 45-minute walkthrough call plus the full PDF playbook, and your team runs with it. I'll even answer questions if they get stuck. I don't get offended when people don't need me. I get paid and you get savings. Capitalism at its finest. 🎉</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🏢 Do you only work with tech companies?</h3>
            <p class="text-gray-400">Nope. I've worked with for-profit companies, non-profits (churches, civic organizations, foundations), and local, state, and federal government agencies. If you're running on AWS and spending {{ minAwsK }}+/mo, I don't care if you're selling software, saving souls, or serving citizens &mdash; your bill probably has waste and I can find it. 🏛️⛪💼</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🤖 How is this different from cloud cost optimization tools like CloudHealth or ProsperOps?</h3>
            <p class="text-gray-400">Those are cloud cost optimization tools &mdash; dashboards that scan your account and show you charts. I'm a person who reads your architecture, understands your business, gets on a call with you, and tells you exactly what to change and why. Cloud cost optimization platforms find obvious waste. I find the structural misalignment between your tech and your business that no tool can see. Also, I can explain things using sports metaphors if that helps. Dashboards cannot. 😏</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">😰 How do I know you won't break something?</h3>
            <p class="text-gray-400">The scan uses read-only access. I literally cannot change anything even if I wanted to. For implementation, every change is documented, reviewed with your team, and rolled out carefully. I've been doing this for 19 years. I break things on my own AWS account, not yours. (My personal bill is a whole separate therapy session.) 😅</p>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA -->
    <section>
      <div class="max-w-5xl mx-auto px-6 py-24 text-center">
      <h2 class="text-3xl font-bold mb-4">Your AWS bill isn't going to cut itself. ✂️</h2>
      <p class="text-xl text-gray-400 mb-2">{{ pricing.depositPct }}% down to start. The rest isn't due until you see the report.</p>
      <p class="text-gray-500 mb-8">Serious about cloud cost optimization? This is the fastest way to find out what you're wasting &mdash; with zero risk. 💰</p>
      <a
        :href="calendly('bottom-cta')"
        target="_blank"
        class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg text-center"
      >
        🗓️ Book Your Free AWS Intervention
      </a>
      <p class="text-gray-600 text-sm mt-4">No hard sell. No PowerPoints. Just math. 🧮</p>
      </div>
    </section>

    <!-- Referral -->
    <section class="bg-gray-900">
      <div class="max-w-3xl mx-auto px-6 py-24 text-center">
        <p class="text-4xl mb-4">🤝</p>
        <h2 class="text-2xl font-bold mb-3">Got clients bleeding AWS money? <span class="text-brand-400">Get paid to tell them.</span></h2>
        <p class="text-gray-400 text-lg mb-3">
          If you run an IT consulting firm, MSP, or business advisory &mdash; and your clients are on AWS &mdash;
          I'll pay you a referral fee for every engagement that closes. You look like a hero. They save money. I do the work. Everybody wins. 🎉
        </p>
        <p class="text-gray-500 mb-6">
          Seriously, you just send an intro email and collect a check. That's the whole program. It's not complicated because I didn't let a marketing team design it. 😅
        </p>
        <a
          href="mailto:david@cutmyaws.com?subject=Referral%20Partnership%20%E2%9C%82%EF%B8%8F&body=Hey%20David%2C%0A%0AI%20run%20%5Bcompany%5D%20and%20have%20clients%20on%20AWS.%20Let's%20talk%20referrals."
          class="inline-block bg-gray-800 hover:bg-gray-700 text-white font-semibold px-6 py-3 rounded-xl transition-colors border border-gray-700"
        >
          📧 Email David about referrals
        </a>
        <p class="text-gray-600 text-sm mt-4">david@cutmyaws.com — I respond fast ⚡</p>
      </div>
    </section>

    <!-- Investors -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-24 text-center">
        <p class="text-4xl mb-4">📈</p>
        <h2 class="text-2xl font-bold mb-3">Your portfolio companies are <span class="text-brand-400">overpaying AWS.</span></h2>
        <p class="text-gray-400 text-lg mb-3">
          You did the due diligence on the team, the TAM, and the cap table &mdash;
          but nobody looked at the AWS bill. Spoiler: it's not great. 😬
        </p>
        <p class="text-gray-400 text-lg mb-3">
          I audit your portfolio companies' AWS infrastructure, find the waste, and fix it &mdash;
          without slowing down product development. Your engineering team stays focused on shipping.
          I handle the infrastructure bloat they've been ignoring since Series A. 🚀
        </p>
        <div class="grid sm:grid-cols-3 gap-6 my-10 text-left">
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6">
            <p class="text-2xl mb-2">💸</p>
            <h3 class="font-bold mb-1">Pay on results</h3>
            <p class="text-gray-500 text-sm">No retainer. No hourly. You pay a percentage of verified savings &mdash; if I don't find waste, you owe nothing. Wild concept for consulting, I know. 🤷</p>
          </div>
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6">
            <p class="text-2xl mb-2">⏱️</p>
            <h3 class="font-bold mb-1">6-month ROI</h3>
            <p class="text-gray-500 text-sm">Most engagements pay for themselves within 6 months. After that, every dollar saved goes straight to runway. CFOs love this. Investors love it more. 😏</p>
          </div>
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6">
            <p class="text-2xl mb-2">🔁</p>
            <h3 class="font-bold mb-1">No recurring fees</h3>
            <p class="text-gray-500 text-sm">I'm not another SaaS on your portfolio's credit card. One engagement, permanent savings. The only thing that recurs is the money your companies keep. Every. Single. Month.</p>
          </div>
        </div>
        <p class="text-gray-500 mb-6">
          Think of it as an instant operational upgrade across your portfolio &mdash; funded entirely by the waste it eliminates.
          Your board deck just got a new slide. You're welcome. 📊
        </p>
        <a
          href="mailto:david@cutmyaws.com?subject=Portfolio%20AWS%20Optimization%20%E2%9C%82%EF%B8%8F&body=Hey%20David%2C%0A%0AI%20invest%20in%20%5B%23%5D%20companies%20running%20on%20AWS.%20Let's%20talk."
          class="inline-block bg-gray-800 hover:bg-gray-700 text-white font-semibold px-6 py-3 rounded-xl transition-colors border border-gray-700"
        >
          📧 Email David about your portfolio
        </a>
        <p class="text-gray-600 text-sm mt-4">Bulk portfolio pricing available &mdash; because math rewards volume 🧮</p>
      </div>
    </section>

    <!-- Footer -->
    <footer class="border-t border-gray-800 bg-gray-900">
      <div class="max-w-5xl mx-auto px-6 py-8 flex flex-col sm:flex-row items-center justify-between gap-4 text-sm text-gray-500">
        <span>✂️ &copy; {{ new Date().getFullYear() }} Smart Talk LLC d/b/a Cut My AWS &middot; Peoria, IL &middot; A real company with a real silly name</span>
        <div class="flex items-center gap-4">
          <a href="https://www.linkedin.com/in/davidplappert/" target="_blank" class="hover:text-gray-300 transition-colors">💼 LinkedIn</a>
          <a href="mailto:david@cutmyaws.com" class="hover:text-gray-300 transition-colors">📧 david@cutmyaws.com</a>
        </div>
      </div>
    </footer>
  </div>
</template>
