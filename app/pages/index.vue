<script setup>
import { ref, onMounted, computed } from 'vue'

const calendly = (campaign) => `/book?c=${campaign}`

// ── Mobile sticky CTA visibility ──
const showMobileCta = ref(false)

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

  // ── Section scroll tracking ──
  const { trackEvent } = useTracking()
  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        trackEvent('section_view', { event_category: 'engagement', event_label: entry.target.id })
        observer.unobserve(entry.target)
      }
    })
  }, { threshold: 0.3 })
  document.querySelectorAll('section[id]').forEach((el) => observer.observe(el))

  // ── Show mobile sticky CTA after scrolling past hero ──
  const hero = document.getElementById('hero')
  if (hero) {
    const heroObserver = new IntersectionObserver(([entry]) => {
      showMobileCta.value = !entry.isIntersecting
    }, { threshold: 0 })
    heroObserver.observe(hero)
  }
})

// ── ROI Calculator ──
const calcAwsSpend = ref(25000)
const calcWastePct = ref(30)
const calcMonthlySavings = computed(() => Math.round(calcAwsSpend.value * (calcWastePct.value / 100)))
const calcAnnualSavings = computed(() => calcMonthlySavings.value * 12)
const calcDepositFee = computed(() => Math.round(calcAwsSpend.value * 12 * pricing.depositPct / 100))
const calcReportFee = computed(() => Math.round(calcAnnualSavings.value * pricing.reportPct / 100))
const calcReportRemainder = computed(() => calcReportFee.value - calcDepositFee.value)
const calcFixDepositFee = computed(() => Math.round(calcAwsSpend.value * 12 * pricing.fixDepositPct / 100))
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
  { value: '$100M', label: '💰 Saved & improved across client accounts.' },
  { value: '150', label: '🔍 AWS accounts audited. Zero unsurprised CFOs.' }
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
  depositPct: 1,       // Down payment: 1% of AWS annual spend to start (The Report)
  fixDepositPct: 4,    // Down payment: 4% of AWS annual spend to start (The Fix)
  reportPct: 15,       // The Report: 15% of annual savings (deposit deducted)
  implPct: 60,         // Implementation portion
  fixPct: 75,          // The Fix: 75% total (15% report + 60% implementation)
  securityPct: 10,     // Security Audit: 10% of AWS annual spend (free during promo)
  minAws: 5000,        // We work best with $5K+/mo AWS spend
  overageRate: 500,    // Hourly rate for out-of-scope work
}

// ── Example numbers ──
const exampleBefore = 25000
const exampleSavings = 9000
const exampleAnnual = exampleSavings * 12
const exampleAwsAnnual = exampleBefore * 12
const depositFee = Math.round(exampleAwsAnnual * pricing.depositPct / 100)
const reportFee = Math.round(exampleAnnual * pricing.reportPct / 100)
const reportRemainder = reportFee - depositFee
const fixDepositFee = Math.round(exampleAwsAnnual * pricing.fixDepositPct / 100)
const fixFee = Math.round(exampleAnnual * pricing.fixPct / 100)
const reportNet = exampleAnnual - reportFee
const fixNet = exampleAnnual - fixFee
const exampleMonthsToRoi = Math.ceil(fixFee / exampleSavings)
const exampleThreeYearNet = (exampleAnnual * 3) - fixFee
const minAwsK = `$${pricing.minAws / 1000}K`
</script>

<template>
  <div>
    <!-- Hero -->
    <section id="hero" class="relative overflow-hidden">
      <!-- Background gradient -->
      <div class="absolute inset-0 bg-gradient-to-br from-brand-500/5 via-transparent to-brand-500/3"></div>
      <div class="absolute top-0 right-0 w-[600px] h-[600px] bg-brand-500/5 rounded-full blur-3xl -translate-y-1/2 translate-x-1/3"></div>
      <div class="absolute bottom-0 left-0 w-[400px] h-[400px] bg-brand-500/3 rounded-full blur-3xl translate-y-1/2 -translate-x-1/3"></div>
    <div class="relative max-w-5xl mx-auto px-6 pt-16 pb-16">
      <div class="flex flex-col lg:flex-row gap-12 items-center">
        <!-- Left: Text -->
        <div class="flex-1">
          <p class="text-brand-400 font-semibold mb-4 text-lg">💰 I find 30–40% waste hiding in your AWS account</p>
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
              class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg text-center"
            >
              🗓️ Book Your Free<br class="sm:hidden"> Intro Call
            </a>
            <p class="text-gray-500 text-sm self-center">15 min &middot; free &middot; no pitch deck 😏</p>
          </div>
          <a href="#how-it-works" class="inline-block text-gray-500 hover:text-gray-400 text-sm mt-6 transition-colors">See how it works ↓</a>
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
    <section id="stats" class="bg-gray-900">
      <div class="max-w-4xl mx-auto px-6 py-24 grid grid-cols-1 sm:grid-cols-3 gap-12">
        <div v-for="stat in stats" :key="stat.label" class="text-center px-4">
          <div class="text-3xl font-bold text-brand-400 mb-2">{{ stat.value }}</div>
          <div class="text-sm text-gray-400 leading-relaxed">{{ stat.label }}</div>
        </div>
      </div>
    </section>

    <!-- Clients -->
    <section id="clients" class="py-24 px-6">
      <ClientLogos />
    </section>

    <!-- Is This For You? -->
    <section id="fit" class="bg-gray-900">
      <div class="max-w-4xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-12 text-center">Is this for you? 🤔</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-8 max-w-3xl mx-auto">
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-8">
            <h3 class="font-bold text-lg mb-4 text-green-400">Great fit ✅</h3>
            <ul class="space-y-3 text-gray-400 text-sm">
              <li class="flex items-start gap-2"><span class="text-green-400 mt-0.5">💰</span> Spending {{ minAwsK }}+/mo on AWS</li>
              <li class="flex items-start gap-2"><span class="text-green-400 mt-0.5">🕸️</span> Nobody's looked under the hood in a while</li>
              <li class="flex items-start gap-2"><span class="text-green-400 mt-0.5">📈</span> Bill keeps growing but you're not sure why</li>
              <li class="flex items-start gap-2"><span class="text-green-400 mt-0.5">🏗️</span> Architecture decisions from 2+ years ago</li>
              <li class="flex items-start gap-2"><span class="text-green-400 mt-0.5">🧑‍💻</span> Team too busy building to optimize</li>
            </ul>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-8">
            <h3 class="font-bold text-lg mb-4 text-gray-500">Not a fit ❌</h3>
            <ul class="space-y-3 text-gray-500 text-sm">
              <li class="flex items-start gap-2"><span class="mt-0.5">💸</span> Under {{ minAwsK }}/mo (not enough waste to justify)</li>
              <li class="flex items-start gap-2"><span class="mt-0.5">📊</span> Looking for a dashboard or SaaS tool</li>
              <li class="flex items-start gap-2"><span class="mt-0.5">🔄</span> Want ongoing managed services</li>
              <li class="flex items-start gap-2"><span class="mt-0.5">☁️</span> Azure or GCP only (AWS is my lane)</li>
            </ul>
          </div>
        </div>
      </div>
    </section>

    <!-- Why CutMyAWS -->
    <section id="why" class="max-w-5xl mx-auto px-6 py-24">
      <h2 class="text-3xl font-bold mb-4 text-center">Why Cut My AWS? 🤔</h2>
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
          <p class="text-gray-400">This is a one-time commitment, not an ongoing contract. The implementation fee isn't due until you've experienced the savings for 90 days. You only pay on realized savings. No savings? No fee. I carry the risk, not you. 🎯</p>
        </div>
        <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8">
          <p class="text-2xl mb-3">📉</p>
          <h3 class="text-lg font-bold mb-2">Growing ≠ efficient</h3>
          <p class="text-gray-400">Nobody sets out to waste money on AWS. You launch fast, scale fast, and three years later you're paying for infrastructure you forgot existed. That's not negligence &mdash; that's just building a business. Let me clean it up. 🧾</p>
        </div>
      </div>
      <!-- Mid-page CTA -->
      <div class="text-center pt-8 pb-0">
        <a
          :href="calendly('mid-page')"
          class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg"
        >
          🗓️ Book Your Free Intro Call
        </a>
        <p class="text-gray-600 text-sm mt-3">15 minutes. Free. Just math and honest answers. 🧮</p>
      </div>
    </section>

    <!-- Testimonials -->
    <section id="testimonials" class="bg-gray-900">
      <div class="max-w-5xl mx-auto px-6 py-24">
        <Testimonials />
      </div>
    </section>

    <!-- How It Works -->
    <section id="how-it-works">
      <div class="max-w-5xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-4 text-center">How It Works 🧰</h2>
        <p class="text-gray-400 text-center mb-12 max-w-xl mx-auto">Four steps. One call. One PDF. You decide how far to go after you see the numbers. 🤝</p>

        <div class="max-w-2xl mx-auto space-y-6">

          <!-- Step 1: Intro Call -->
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6 sm:p-8">
            <div class="flex items-center gap-3 mb-3">
              <span class="bg-brand-500 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">1</span>
              <div>
                <h3 class="text-lg font-bold">🗓️ Intro Call</h3>
                <p class="text-gray-500 text-sm">15 min &middot; free &middot; {{ pricing.depositPct }}% deposit to kick off the audit</p>
              </div>
            </div>
            <p class="text-gray-400">We meet, I ask questions about your business, and you <NuxtLink to="/onboarding/give-david-access" class="text-brand-400 hover:underline">grant read-only access</NuxtLink>. The {{ pricing.depositPct }}% deposit (based on <NuxtLink to="/onboarding/calculate-savings" class="text-brand-400 hover:underline">annualized AWS spend</NuxtLink>) gets deducted from The Report fee. 🔍</p>
          </div>

          <!-- Arrow -->
          <div class="text-center text-gray-600 text-lg">⏳ 5–10 business days</div>

          <!-- Step 2: The Report -->
          <div class="bg-gray-900 border-2 border-brand-500 rounded-2xl p-6 sm:p-8">
            <div class="flex items-center gap-3 mb-3">
              <span class="bg-brand-500 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">2</span>
              <div>
                <h3 class="text-lg font-bold">📋 The Report</h3>
                <p class="text-gray-500 text-sm">{{ pricing.reportPct }}% of annualized savings found (deposit deducted)</p>
              </div>
            </div>
            <p class="text-gray-400 mb-3">A <strong class="text-gray-200">45-minute call</strong> where I walk your team through every finding, plus a <strong class="text-gray-200">full PDF</strong> you keep forever &mdash; line-by-line savings, architecture recommendations, and where your tech doesn't match your business. 📄</p>
            <div class="flex flex-wrap gap-2 text-xs">
              <span class="bg-gray-950 text-gray-400 px-3 py-1 rounded-full border border-gray-800">✅ 45-min live call</span>
              <span class="bg-gray-950 text-gray-400 px-3 py-1 rounded-full border border-gray-800">✅ Full PDF report</span>
              <span class="bg-gray-950 text-gray-400 px-3 py-1 rounded-full border border-gray-800">✅ Architecture recs</span>
              <span class="bg-gray-950 text-gray-400 px-3 py-1 rounded-full border border-gray-800">✅ DIY implementation guide</span>
              <span v-if="promoActive" class="bg-green-500/20 text-green-400 px-3 py-1 rounded-full border border-green-500/30">🎁 FREE Security Audit ({{ promoDaysLeft }}d left)</span>
            </div>
          </div>

          <!-- Security Audit Add-on (compact) -->
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6 sm:p-8 relative">
            <div v-if="promoActive" class="absolute -top-3 right-6 bg-green-500 text-white text-xs font-bold px-3 py-1 rounded-full">🎁 FREE for {{ promoDaysLeft }} more day{{ promoDaysLeft === 1 ? '' : 's' }}!</div>
            <div v-else class="absolute -top-3 right-6 bg-gray-700 text-white text-xs font-bold px-3 py-1 rounded-full">ADD-ON</div>
            <div class="flex items-center gap-3 mb-3">
              <span class="bg-gray-700 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">🔒</span>
              <div>
                <h3 class="text-lg font-bold">🛡️ Security Audit</h3>
                <p class="text-gray-500 text-sm">{{ pricing.securityPct }}% of AWS annual spend<span v-if="promoActive"> &middot; <strong class="text-green-400">FREE during promo</strong></span></p>
              </div>
            </div>
            <p class="text-gray-400">A one-time PDF covering public S3 buckets, overprivileged IAM roles, security group misconfigs, unencrypted resources, and missing logging. Prioritized: critical → high → medium. 🔍</p>
            <p v-if="promoActive" class="text-green-400 text-sm font-semibold mt-3">🎁 Free with The Report during promo. After that, {{ pricing.securityPct }}% of AWS annual spend.</p>
          </div>

          <!-- Arrow -->
          <div class="text-center text-gray-600 text-lg">🤔 Want me to actually fix it?</div>

          <!-- Step 3: The Fix -->
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6 sm:p-8 relative">
            <div class="absolute -top-3 right-6 bg-brand-500 text-white text-xs font-bold px-3 py-1 rounded-full">OPTIONAL</div>
            <div class="flex items-center gap-3 mb-3">
              <span class="bg-gray-700 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">3</span>
              <div>
                <h3 class="text-lg font-bold">🔧 The Fix</h3>
                <p class="text-gray-500 text-sm">{{ pricing.fixDepositPct }}% deposit at kickoff &middot; {{ pricing.fixPct }}% total max</p>
              </div>
            </div>
            <p class="text-gray-400 mb-3">I implement the optimizations &mdash; serverless migrations, right-sizing, Savings Plans, architecture fixes. {{ pricing.fixDepositPct }}% deposit (of AWS annual spend) at kickoff, deducted from the implementation fee. Everything follows standard SDLC &mdash; changes go into a dev environment first, get tested, and I work with your team to promote to production. No cowboy deploys. 💪</p>
            <p class="text-gray-500 text-sm">⚠️ Not every Report item may be implementable &mdash; dependencies and constraints happen. You only pay the {{ pricing.implPct }}% on <strong class="text-gray-400">realized, verified savings</strong>.</p>
          </div>

          <!-- Arrow -->
          <div class="text-center text-gray-600 text-lg">⏳ 90 days later...</div>

          <!-- Step 4: The Proof -->
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6 sm:p-8">
            <div class="flex items-center gap-3 mb-3">
              <span class="bg-gray-700 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">4</span>
              <div>
                <h3 class="text-lg font-bold">📊 The Proof</h3>
                <p class="text-gray-500 text-sm">+{{ pricing.implPct }}% of verified annual savings</p>
              </div>
            </div>
            <p class="text-gray-400">We pull up your AWS bill. Before. After. Side by side. The {{ pricing.implPct }}% is based on <strong class="text-gray-200">actual, verified savings</strong> &mdash; not projections. If the savings didn't show up, I don't get paid. 💰</p>
          </div>

        </div>

        <!-- Pricing summary -->
        <p class="text-gray-500 text-sm text-center mt-8 max-w-lg mx-auto">{{ pricing.fixPct }}% total max ({{ pricing.reportPct }}% report + {{ pricing.implPct }}% implementation). Just want The Report? {{ pricing.reportPct }}%, a 45-min call, a PDF, and your team handles the rest. <NuxtLink to="/agreements" class="text-brand-400 hover:underline">Full terms →</NuxtLink></p>
      </div>
    </section>

    <!-- ROI Calculator -->
    <section id="calculator" class="bg-gray-900">
      <div class="max-w-5xl mx-auto px-6 py-24">
      <h2 class="text-3xl font-bold mb-2 text-center">🧮 Calculate Your Savings</h2>
      <p class="text-gray-400 text-center mb-2">Cloud cost optimization with no monthly fees. You pay once. Keep the savings forever. 💰</p>
      <p class="text-gray-500 text-center mb-10 text-sm">Drag the sliders or type your actual AWS spend below.</p>

      <div class="max-w-3xl mx-auto bg-gray-950 border border-gray-800 rounded-2xl p-8">
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
                class="w-full bg-gray-900 border border-gray-700 rounded-lg px-4 py-3 text-2xl font-bold text-brand-400 focus:border-brand-500 focus:outline-none"
              >
            </div>
            <input
              v-model.number="calcAwsSpend"
              type="range"
              :min="pricing.minAws"
              max="500000"
              step="5000"
              class="w-full h-2 bg-gray-700 rounded-lg appearance-none cursor-pointer accent-brand-500"
            >
            <div class="flex justify-between text-xs text-gray-600 mt-1">
              <span>{{ minAwsK }}</span>
              <span>$250K</span>
              <span>$500K</span>
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
                class="w-full bg-gray-900 border border-gray-700 rounded-lg px-4 py-3 text-2xl font-bold text-red-400 focus:border-red-500 focus:outline-none"
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
        <div class="bg-gray-900 rounded-xl p-5 border border-gray-800 mb-6 text-center">
          <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">🔥 You're wasting roughly</p>
          <p class="text-3xl font-bold text-red-400">${{ calcMonthlySavings.toLocaleString() }}<span class="text-gray-500 text-lg">/mo</span> &nbsp; = &nbsp; ${{ calcAnnualSavings.toLocaleString() }}<span class="text-gray-500 text-lg">/yr</span></p>
        </div>

        <!-- Two plan comparison -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
          <!-- The Report -->
          <div class="bg-gray-900 rounded-xl p-5 border border-gray-800">
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
          <div class="bg-gray-900 rounded-xl p-5 border-2 border-brand-500">
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
            class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg text-center"
          >
            🗓️ Book Your Free Intro Call →
          </a>
        </div>
      </div>
      </div>
    </section>

    <!-- Example -->
    <section id="example">
      <div class="max-w-5xl mx-auto px-6 py-24">
      <h2 class="text-3xl font-bold mb-2 text-center">🧮 Real Math, Fake Company</h2>
      <p class="text-gray-400 text-center mb-2">A ${{ (exampleBefore).toLocaleString() }}/mo SaaS company that swore their AWS was "pretty optimized" 👀</p>
      <p class="text-brand-400 font-semibold text-center mb-8">One-time fee. Paid from your recurring savings. ~{{ exampleMonthsToRoi }}-month ROI. 🎯</p>

      <!-- Shared finding -->
      <div class="max-w-2xl mx-auto bg-gray-900 border border-gray-800 rounded-2xl p-6 mb-8">
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
      <div class="max-w-2xl mx-auto bg-gray-900 border border-gray-800 rounded-2xl p-8">
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
              <span class="text-gray-300 font-medium">🔧 The Fix Deposit (Implementation Kickoff)</span>
              <span class="text-gray-500 ml-2">~3 weeks</span>
            </div>
            <span class="font-semibold">${{ fixDepositFee.toLocaleString() }}</span>
          </div>
          <div class="text-gray-500 text-xs pl-4">{{ pricing.fixDepositPct }}% of ${{ exampleAwsAnnual.toLocaleString() }} annual AWS spend = ${{ fixDepositFee.toLocaleString() }} (deducted from implementation fee)</div>
          <div class="flex justify-between items-center">
            <div>
              <span class="text-gray-300 font-medium">📊 90 Days After Implementation</span>
              <span class="text-gray-500 ml-2">~4-5 months</span>
            </div>
            <span class="font-semibold">${{ (fixFee - reportFee - fixDepositFee).toLocaleString() }}</span>
          </div>
          <div class="text-gray-500 text-xs pl-4">{{ pricing.implPct }}% of <strong>verified</strong> savings only, minus ${{ fixDepositFee.toLocaleString() }} deposit already paid. No savings? No charge. 🤙</div>
          <hr class="border-gray-700">
          <div class="flex justify-between text-base">
            <span class="font-bold text-gray-300">Total max ({{ pricing.fixPct }}%)</span>
            <span class="font-bold">${{ fixFee.toLocaleString() }}</span>
          </div>
          <div class="text-gray-500 text-xs pl-4">${{ depositFee.toLocaleString() }} + ${{ reportRemainder.toLocaleString() }} + ${{ fixDepositFee.toLocaleString() }} + ${{ (fixFee - reportFee - fixDepositFee).toLocaleString() }} = ${{ fixFee.toLocaleString() }} (deposits deducted from fees)</div>
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

      <p class="text-gray-500 text-sm text-center mt-6">Just want The Report? {{ pricing.reportPct }}%, a 45-min call, a PDF, and your team handles the rest. You keep ${{ reportNet.toLocaleString() }} year one. 💰</p>
      </div>
    </section>

    <!-- Common Waste -->
    <section id="waste" class="bg-gray-900">
      <div class="max-w-5xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-2 text-center">🕵️ The Usual Suspects</h2>
        <p class="text-gray-400 text-center mb-8">Decisions that made sense at the time. That time was 2021. It's not 2021 anymore.</p>
        <div class="max-w-3xl mx-auto space-y-4">
          <div
            v-for="item in wasteSources"
            :key="item.name"
            class="flex items-center gap-4 bg-gray-950 border border-gray-800 rounded-xl px-5 py-4"
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
    <section id="about">
      <div class="max-w-2xl mx-auto px-6 py-24 text-center">
        <img src="/david.png" alt="David Plappert" class="w-32 h-32 rounded-full mx-auto mb-6 object-cover object-top border-2 border-gray-700">
        <h2 class="text-3xl font-bold mb-6">👋 Who's poking around my AWS account?</h2>
        <p class="text-gray-400 text-lg leading-relaxed mb-4">
          I'm David Plappert &mdash; an actual human being with 19 years of AWS experience who will personally
          dig through your account, read your architecture, and understand your business. 🍱 Not an AI-generated summary.
          Not a dashboard with traffic lights. Not a junior analyst following a checklist. Me. On a call. With opinions. And a mildly aggressive sense of humor.
        </p>
        <p class="text-gray-400 text-lg leading-relaxed mb-4">
          I build and run production serverless SaaS at Fortune 100 scale &mdash; Lambda, API Gateway, S3, SES, the whole buffet.
          I even have a <a href="https://patents.google.com/patent/US11146689" target="_blank" class="text-brand-400 hover:underline">U.S. patent on cloud infrastructure</a> (because apparently I don't spend enough time with AWS already).
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
          The honest truth? I started Cut My AWS because I want to pay off our house and get my family completely debt-free.
          That's it. No VC funding. No exit strategy. Just a dad who's <strong class="text-gray-200">really good at AWS</strong> and
          <strong class="text-gray-200">really motivated</strong> to find your savings &mdash; because every dollar I earn pays off my house faster. 😅
        </p>
        <p class="text-gray-500 text-base">
          Yes, "Cut My AWS" is a real business name registered with the state of Florida. No, I will not apologize for it. ✂️
        </p>
      </div>
    </section>

    <!-- Security & Compliance -->
    <section id="security" class="bg-gray-900">
      <div class="max-w-5xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-4 text-center">🔒 Your Data. My Paranoia.</h2>
        <p class="text-gray-400 text-center mb-12 max-w-2xl mx-auto">I've worked with organizations that handle the most sensitive data in the country. Your AWS account is in good hands. Careful, experienced, slightly paranoid hands. 🫡</p>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 max-w-4xl mx-auto mb-12">
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6 text-center">
            <p class="text-3xl mb-3">🏥</p>
            <h3 class="font-bold mb-1">HIPAA</h3>
            <p class="text-gray-500 text-sm">Protected health information? Been there, secured that.</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6 text-center">
            <p class="text-3xl mb-3">🏛️</p>
            <h3 class="font-bold mb-1">DC Health Link</h3>
            <p class="text-gray-500 text-sm">Health exchange data for the nation's capital.</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6 text-center">
            <p class="text-3xl mb-3">💳</p>
            <h3 class="font-bold mb-1">PII &amp; eCommerce</h3>
            <p class="text-gray-500 text-sm">Customer data, payment data, the stuff that keeps you up at night.</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6 text-center">
            <p class="text-3xl mb-3">📋</p>
            <h3 class="font-bold mb-1">IRS Pub 1075</h3>
            <p class="text-gray-500 text-sm">Federal tax information. The government trusted me. You can too.</p>
          </div>
        </div>
        <div class="max-w-2xl mx-auto bg-gray-950 border border-gray-800 rounded-2xl p-8">
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
    <section id="faq">
      <div class="max-w-5xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-12 text-center">❓ Questions you're definitely asking right now</h2>
        <div class="max-w-2xl mx-auto space-y-10">
          <div>
            <h3 class="text-lg font-bold mb-3">🤔 What if you don't find any savings?</h3>
            <p class="text-gray-400">Then you have the most optimized AWS account I've ever seen, and honestly? I'll be impressed. In my career this has happened exactly zero times, but I hear there's a first time for everything. I'll send you a congratulatory email.</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🤨 When do I actually pay?</h3>
            <p class="text-gray-400">{{ pricing.depositPct }}% of your AWS annual spend is due at the intro call as a down payment &mdash; it gets deducted from The Report fee. {{ pricing.reportPct }}% of annualized savings (minus the deposit) is due when The Report is delivered. If you opt for implementation, there's a {{ pricing.fixDepositPct }}% deposit (of AWS annual spend) at kickoff &mdash; deducted from the implementation fee. The remaining {{ pricing.implPct }}% isn't due until <strong>90 days after deliverables</strong> &mdash; and only on verified savings. 😅</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🎯 Is this just a cost audit or something more?</h3>
            <p class="text-gray-400">Way more. Cloud cost optimization tools tell you <em>what</em> you're spending. I tell you <em>why</em> your tech doesn't match your business &mdash; and that's where the real cloud cost savings live. I'm a serverless architect who does cloud cost optimization the way it should be done &mdash; business-aligned, not dashboard-driven. The savings are a side effect of good architecture. 🏗️</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">📏 What size AWS accounts do you work with?</h3>
            <p class="text-gray-400">We work best with AWS accounts spending {{ minAwsK }}+/mo. Below that, there usually isn't enough waste to justify an engagement. Above that? Even better &mdash; more infrastructure means more savings to find. 🫡</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🧑‍💻 Can't my team just optimize this ourselves?</h3>
            <p class="text-gray-400">They can try! But cloud cost optimization isn't scanning dashboards for random savings. I'm reading your architecture, understanding your business, and finding the structural mismatches &mdash; the kind of waste that no cloud cost optimization tool surfaces. It's the difference between a thermometer and a doctor. 🌡️</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🤖 How is this different from tools like CloudHealth or ProsperOps?</h3>
            <p class="text-gray-400">Those are dashboards that scan your account and show you charts. I'm a person who reads your architecture, understands your business, gets on a call with you, and tells you exactly what to change and why. I find the structural misalignment between your tech and your business that no tool can see. 😏</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Final CTA -->
    <section id="cta" class="bg-gray-900">
      <div class="max-w-5xl mx-auto px-6 py-24 text-center">
      <h2 class="text-3xl font-bold mb-4">Your AWS bill isn't going to cut itself. ✂️</h2>
      <p class="text-xl text-gray-400 mb-2">15 minutes. Free. No pitch deck.</p>
      <p class="text-gray-500 mb-8">Find out what you're wasting &mdash; with zero risk and zero commitment. 💰</p>
      <a
        :href="calendly('bottom-cta')"
        class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg text-center"
      >
        🗓️ Book Your Free Intro Call
      </a>
      <p class="text-gray-600 text-sm mt-4">No hard sell. No PowerPoints. Just math. 🧮</p>
      <div class="mt-10">
        <p class="text-gray-600 text-xs uppercase tracking-wider mb-4">Also available through</p>
        <div class="flex items-center justify-center gap-4">
          <div class="flex items-center justify-center h-16 w-44 px-4 rounded-lg bg-white/90">
            <img src="/logos/aws-marketplace.svg" alt="AWS Marketplace" class="h-10 max-w-[150px] object-contain">
          </div>
          <div class="flex items-center justify-center h-16 w-44 px-4 rounded-lg bg-white/90">
            <img src="/logos/carahsoft.svg" alt="Carahsoft" class="h-10 max-w-[150px] object-contain">
          </div>
        </div>
      </div>
      </div>
    </section>

    <!-- Mobile sticky CTA (padding at bottom so content isn't hidden behind it) -->
    <div v-show="showMobileCta" class="h-16 sm:hidden"></div>

    <!-- Mobile sticky CTA bar -->
    <div v-show="showMobileCta" class="fixed bottom-0 left-0 right-0 z-40 sm:hidden bg-gray-950/95 backdrop-blur-sm border-t border-gray-800 p-3 transition-opacity" :class="showMobileCta ? 'opacity-100' : 'opacity-0'">
      <NuxtLink
        to="/book?c=mobile-sticky"
        class="block w-full bg-brand-500 hover:bg-brand-600 text-white font-bold py-3 rounded-xl text-center transition-colors"
      >
        🗓️ Book Free Intro Call — 15 min, free
      </NuxtLink>
    </div>

  </div>
</template>
