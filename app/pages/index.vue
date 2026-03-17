<script setup>
import { ref, onMounted, computed } from 'vue'

const { pricing, promoActive, promoDaysLeft, minAwsK, calendly, calculateExample } = usePricing()


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

// ── Stats ──
const stats = [
  { value: '19 Years', label: '☁️ Of AWS expertise. In production since 2007.' },
  { value: '$100M', label: '💰 Saved & improved across client accounts.' },
  { value: '150', label: '🔍 AWS accounts audited. Zero unsurprised CFOs.' }
]

// ── Waste sources ──
const wasteSources = [
  { emoji: '🖥️', service: 'EC2', name: 'Servers running 24/7 for a workload that shows up at 9am and leaves at 5pm', savings: '40-70%' },
  { emoji: '🏗️', service: 'RDS', name: 'A database the size of a school bus for an app with 50 users', savings: '30-60%' },
  { emoji: '🧘', service: 'EC2', name: 'Instances in a meditative state (they\'re not meditating, they\'re idle)', savings: '20-40%' },
  { emoji: '💳', service: 'Savings Plans', name: 'AWS literally wants you to buy these but nobody told you', savings: '30-50%' },
  { emoji: '🦕', service: 'EBS', name: 'Snapshots so old they remember when us-east-1 was the only region', savings: '$100-1K/mo' },
  { emoji: '🍽️', service: 'NAT GW', name: 'Quietly eating your budget for lunch every single day', savings: '$200-2K/mo' },
  { emoji: '🐿️', service: 'Architecture', name: 'Built for the pitch deck, not the business you\'re actually running', savings: '20-50%' }
]

// ── Why CutMyAWS cards ──
const whyCards = [
  { emoji: '🧑‍💻', title: 'Keep your tech team building value', description: 'Your engineers should be shipping product, not hunting for savings. I dig into your architecture, find the misalignment, and do the one-time cleanup so they don\'t have to. No recurring retainer. No ongoing distraction. Just results. 🚀' },
  { emoji: '🙅', title: 'Not a dashboard. Not an AI. A human.', description: 'Cloud cost optimization tools show charts. AI generates summaries. I read your architecture, understand your business, and tell you exactly what to change and why. Real cloud cost optimization is a person, not a platform. And I only make money when you do. 🤝' },
  { emoji: '💰', title: 'You don\'t pay until you see results', description: 'This is a one-time commitment, not an ongoing contract. The implementation fee isn\'t due until you\'ve experienced the savings for 90 days. You only pay on realized savings. No savings? No fee. I carry the risk, not you. 🎯' },
  { emoji: '📉', title: 'Growing ≠ efficient', description: 'Nobody sets out to waste money on AWS. You launch fast, scale fast, and three years later you\'re paying for infrastructure you forgot existed. That\'s not negligence — that\'s just building a business. Let me clean it up. 🧾' },
]

// ── Qualifier items ──
const fitItems = [
  { emoji: '💰', text: `Spending ${minAwsK}+/mo on AWS` },
  { emoji: '🕸️', text: 'Nobody\'s looked under the hood in a while' },
  { emoji: '📈', text: 'Bill keeps growing but you\'re not sure why' },
  { emoji: '🏗️', text: 'Architecture decisions from 2+ years ago' },
  { emoji: '🧑‍💻', text: 'Team too busy building to optimize' },
]

const notFitItems = [
  { emoji: '💸', text: `Under ${minAwsK}/mo (but growing fast? let's talk)` },
  { emoji: '📊', text: 'Looking for a self-serve dashboard (I\'m hands-on)' },
  { emoji: '🔄', text: 'Want ongoing managed services (this is one-time)' },
  { emoji: '☁️', text: 'Azure or GCP only (AWS is my lane)' },
]

// ── FAQ questions ──
const faqQuestions = [
  { emoji: '🤔', question: 'What if you don\'t find any savings?', answer: 'Then you have the most optimized AWS account I\'ve ever seen, and honestly? I\'ll be impressed. In my career this has happened exactly zero times, but I hear there\'s a first time for everything. I\'ll send you a congratulatory email.' },
  { emoji: '🤨', question: 'When do I actually pay?', answer: `The initial chat is free &mdash; no payment, no commitment. If it's a fit, a ${pricing.depositPct}% deposit (of your AWS annual spend) kicks off the audit &mdash; deducted from The Report fee. ${pricing.reportPct}% of annualized savings (minus the deposit) is due when The Report is delivered. If you opt for implementation, there's a ${pricing.fixDepositPct}% deposit (of AWS annual spend) at kickoff &mdash; deducted from the implementation fee. The remaining ${pricing.implPct}% isn't due until <strong>90 days after deliverables</strong> &mdash; and only on verified savings. 😅` },
  { emoji: '🎯', question: 'Is this just a cost audit or something more?', answer: 'Way more. Cloud cost optimization tools tell you <em>what</em> you\'re spending. I tell you <em>why</em> your tech doesn\'t match your business &mdash; and that\'s where the real cloud cost savings live. I\'m a serverless architect who does cloud cost optimization the way it should be done &mdash; business-aligned, not dashboard-driven. The savings are a side effect of good architecture. 🏗️' },
  { emoji: '📏', question: 'What size AWS accounts do you work with?', answer: `We work best with AWS accounts spending ${minAwsK}+/mo. Below that, there usually isn't enough waste to justify an engagement. Above that? Even better &mdash; more infrastructure means more savings to find. 🫡` },
  { emoji: '🧑‍💻', question: 'Can\'t my team just optimize this ourselves?', answer: 'They can try! But cloud cost optimization isn\'t scanning dashboards for random savings. I\'m reading your architecture, understanding your business, and finding the structural mismatches &mdash; the kind of waste that no cloud cost optimization tool surfaces. It\'s the difference between a thermometer and a doctor. 🌡️' },
  { emoji: '🤖', question: 'How is this different from tools like CloudHealth or ProsperOps?', answer: 'Those are dashboards that scan your account and show you charts. I\'m a person who reads your architecture, understands your business, gets on a call with you, and tells you exactly what to change and why. I find the structural misalignment between your tech and your business that no tool can see. 😏' },
]

// ── Example numbers ──
const exampleBefore = 25000
const exampleSavings = 9000
const ex = calculateExample(exampleBefore, (exampleSavings / exampleBefore) * 100)
</script>

<template>
  <PageSections>
    <!-- Hero -->
    <section id="hero" class="relative overflow-hidden">
      <!-- Background gradient -->
      <div class="absolute inset-0 bg-gradient-to-br from-brand-500/5 via-transparent to-brand-500/3"></div>
      <div class="absolute top-0 right-0 w-[600px] h-[600px] bg-brand-500/5 rounded-full blur-3xl -translate-y-1/2 translate-x-1/3"></div>
      <div class="absolute bottom-0 left-0 w-[400px] h-[400px] bg-brand-500/3 rounded-full blur-3xl translate-y-1/2 -translate-x-1/3"></div>
    <div class="relative max-w-5xl mx-auto px-6 pt-24 pb-24">
      <div class="flex flex-col lg:flex-row gap-16 items-center">
        <!-- Left: Text -->
        <div class="flex-1">
          <p class="text-brand-400 font-semibold mb-6 text-lg">✂️ Save 25% on your AWS bill in 90 days</p>
          <h1 class="text-4xl sm:text-5xl font-bold leading-tight mb-6">
            Your AWS bill is a symptom.<br>
            <span class="text-brand-400">I find the cure.</span>
          </h1>
          <p class="text-lg text-gray-400 mb-8">You pay a % of what I save you. No savings? No fee. 💸</p>
          <div class="flex flex-col items-start gap-3 mb-8">
            <a
              href="#book"
              class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg text-center"
            >
              🗓️ Book a Free 15-Min Chat
            </a>
            <p class="text-gray-500 text-sm">15 min &middot; free &middot; no pitch deck 😏</p>
          </div>
        </div>

        <!-- Right: Visual card -->
        <a href="#book" class="w-full lg:w-[380px] shrink-0 block group">
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8 text-center group-hover:border-brand-500/50 transition-colors">
            <!-- Headshot -->
            <img src="/david.png" alt="David Plappert" width="112" height="112" fetchpriority="high" class="w-28 h-28 rounded-full mx-auto mb-5 object-cover object-top border-2 border-gray-700">
            <p class="font-bold text-lg mb-1">David Plappert</p>
            <p class="text-gray-500 text-sm mb-6">19 years on AWS &middot; Since 2007 ☕</p>

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
        </a>
      </div>
      </div>
    </section>

    <!-- Video -->
    <YouTubeEmbed video-id="ZVUOW87e-Jc" label="intro" page="home" />

    <!-- Stats -->
    <SectionStats id="stats" :stats="stats" />

    <!-- Clients -->
    <section id="clients" class="py-24 px-6">
      <ClientLogos />
    </section>

    <!-- Is This For You? -->
    <section id="fit">
      <div class="max-w-4xl mx-auto px-6 py-24">
        <QualifierSection
          headline="Is this for you? 🤔"
          :items="fitItems"
          :not-fit-items="notFitItems"
          layout="dual"
        />
      </div>
    </section>

    <!-- Why CutMyAWS -->
    <section id="why">
      <div class="max-w-5xl mx-auto px-6 py-24">
      <h2 class="text-3xl font-bold mb-4 text-center">Why Cut My AWS? 🤔</h2>
      <p class="text-gray-400 text-center mb-12 max-w-2xl mx-auto">Growing cloud spend doesn't mean efficient cloud spend. Cloud cost optimization tools show you charts &mdash; I show you why your tech doesn't match your business. Your revenue grew 40% &mdash; did your AWS bill grow 40% too? Or 80%? 📈</p>
      <div class="max-w-4xl mx-auto">
        <ValuePropCards :cards="whyCards" :columns="2" />
      </div>
      <!-- Mid-page CTA -->
      <div class="text-center pt-8 pb-0">
        <a
          href="#book"
          class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg"
        >
          🗓️ Book a Free 15-Min Chat
        </a>
        <p class="text-gray-600 text-sm mt-3">15 minutes. Free. Just math and honest answers. 🧮</p>
      </div>
      </div>
    </section>

    <!-- Calendly Embed -->
    <section id="book-section">
      <CalendlyEmbed campaign="homepage" />
    </section>

    <!-- Testimonials -->
    <section id="testimonials">
      <div class="max-w-5xl mx-auto px-6 py-24">
        <Testimonials />
      </div>
    </section>

    <!-- Case Studies -->
    <section id="case-studies">
      <CaseStudies />
    </section>

    <!-- How It Works -->
    <section id="how-it-works">
      <div class="max-w-5xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-4 text-center">How It Works 🧰</h2>
        <p class="text-gray-400 text-center mb-12 max-w-xl mx-auto">Four steps. One call. One PDF. You decide how far to go after you see the numbers. 🤝</p>

        <div class="max-w-2xl mx-auto space-y-6">

          <!-- Step 1: Free Chat -->
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6 sm:p-8">
            <div class="flex items-center gap-3 mb-3">
              <span class="bg-brand-500 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">1</span>
              <div>
                <h3 class="text-lg font-bold">🗓️ Free Chat</h3>
                <p class="text-gray-500 text-sm">15 min &middot; free</p>
              </div>
            </div>
            <p class="text-gray-400 mb-3">We meet, I ask questions about your business, and we figure out if there's a fit. No payment. No AWS access. Just a conversation. 🔍</p>
            <p class="text-gray-500 text-sm">If it's a fit, a {{ pricing.depositPct }}% deposit (based on <NuxtLink to="/onboarding/calculate-savings" class="text-brand-400 hover:underline">annualized AWS spend</NuxtLink>) kicks off the audit. You <NuxtLink to="/onboarding/give-david-access" class="text-brand-400 hover:underline">grant read-only access</NuxtLink>, and I get to work.</p>
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
                <p class="text-gray-500 text-sm">{{ pricing.fixDepositPct }}% deposit at kickoff &middot; you keep {{ 100 - pricing.fixPct }}%+ year 1, 100% every year after</p>
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
        <p class="text-gray-500 text-sm text-center mt-8 max-w-lg mx-auto">You keep {{ 100 - pricing.fixPct }}%+ of savings year 1, and 100% every year after. Just want The Report? {{ pricing.reportPct }}%, a 45-min call, a PDF, and your team handles the rest. <NuxtLink to="/agreements" class="text-brand-400 hover:underline">Full terms →</NuxtLink></p>
      </div>
    </section>

    <!-- ROI Calculator -->
    <section id="calculator">
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
            href="#book"
            class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg text-center"
          >
            🗓️ Book a Free 15-Min Chat →
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
      <p class="text-brand-400 font-semibold text-center mb-8">One-time fee. Paid from your recurring savings. ~{{ ex.monthsToRoi }}-month ROI. 🎯</p>

      <!-- Shared finding -->
      <div class="max-w-2xl mx-auto bg-gray-900 border border-gray-800 rounded-2xl p-6 mb-8">
        <div class="flex justify-between mb-2">
          <span class="text-gray-400">🔥 Monthly waste found (whoops)</span>
          <span class="font-semibold text-red-400">${{ exampleSavings.toLocaleString() }}/mo</span>
        </div>
        <div class="flex justify-between">
          <span class="text-gray-400">💰 Annual savings (just vibing in their account)</span>
          <span class="font-semibold">${{ ex.annualSavings.toLocaleString() }}/yr</span>
        </div>
      </div>

      <!-- Payment timeline -->
      <div class="max-w-2xl mx-auto bg-gray-900 border border-gray-800 rounded-2xl p-8">
        <h3 class="font-bold text-center mb-6">💳 When You Pay (with The Fix)</h3>
        <div class="space-y-4 text-sm">
          <div class="flex justify-between items-center">
            <div>
              <span class="text-gray-300 font-medium">🗓️ Free Chat</span>
              <span class="text-gray-500 ml-2">Day 1</span>
            </div>
            <span class="font-semibold text-green-400">Free</span>
          </div>
          <div class="text-gray-500 text-xs pl-4">15 min. No commitment. We figure out if it's a fit.</div>
          <div class="flex justify-between items-center">
            <div>
              <span class="text-gray-300 font-medium">💳 Audit Deposit</span>
              <span class="text-gray-500 ml-2">After chat</span>
            </div>
            <span class="font-semibold">${{ ex.depositFee.toLocaleString() }}</span>
          </div>
          <div class="text-gray-500 text-xs pl-4">{{ pricing.depositPct }}% of ${{ ex.awsAnnual.toLocaleString() }} annual AWS spend = ${{ ex.depositFee.toLocaleString() }} (deducted from The Report fee)</div>
          <div class="flex justify-between items-center">
            <div>
              <span class="text-gray-300 font-medium">📋 The Report (45-min call + PDF)</span>
              <span class="text-gray-500 ml-2">~2 weeks</span>
            </div>
            <span class="font-semibold">${{ ex.reportRemainder.toLocaleString() }}</span>
          </div>
          <div class="text-gray-500 text-xs pl-4">{{ pricing.reportPct }}% of ${{ ex.annualSavings.toLocaleString() }} = ${{ ex.reportFee.toLocaleString() }} minus ${{ ex.depositFee.toLocaleString() }} deposit = ${{ ex.reportRemainder.toLocaleString() }}</div>
          <div class="flex justify-between items-center">
            <div>
              <span class="text-gray-300 font-medium">🔧 The Fix Deposit (Implementation Kickoff)</span>
              <span class="text-gray-500 ml-2">~3 weeks</span>
            </div>
            <span class="font-semibold">${{ ex.fixDepositFee.toLocaleString() }}</span>
          </div>
          <div class="text-gray-500 text-xs pl-4">{{ pricing.fixDepositPct }}% of ${{ ex.awsAnnual.toLocaleString() }} annual AWS spend = ${{ ex.fixDepositFee.toLocaleString() }} (deducted from implementation fee)</div>
          <div class="flex justify-between items-center">
            <div>
              <span class="text-gray-300 font-medium">📊 90 Days After Implementation</span>
              <span class="text-gray-500 ml-2">~4-5 months</span>
            </div>
            <span class="font-semibold">${{ (ex.fixFee - ex.reportFee - ex.fixDepositFee).toLocaleString() }}</span>
          </div>
          <div class="text-gray-500 text-xs pl-4">{{ pricing.implPct }}% of <strong>verified</strong> savings only, minus ${{ ex.fixDepositFee.toLocaleString() }} deposit already paid. No savings? No charge. 🤙</div>
          <hr class="border-gray-700">
          <div class="flex justify-between text-base">
            <span class="font-bold text-gray-300">Total max ({{ pricing.fixPct }}%)</span>
            <span class="font-bold">${{ ex.fixFee.toLocaleString() }}</span>
          </div>
          <div class="text-gray-500 text-xs pl-4">${{ ex.depositFee.toLocaleString() }} + ${{ ex.reportRemainder.toLocaleString() }} + ${{ ex.fixDepositFee.toLocaleString() }} + ${{ (ex.fixFee - ex.reportFee - ex.fixDepositFee).toLocaleString() }} = ${{ ex.fixFee.toLocaleString() }} (deposits deducted from fees)</div>
          <div class="flex justify-between text-base">
            <span class="font-bold text-brand-400">🎉 You keep (year 1)</span>
            <span class="font-bold text-brand-400">${{ ex.fixNet.toLocaleString() }}</span>
          </div>
          <div class="flex justify-between text-base">
            <span class="font-bold text-green-400">🚀 You keep (every year after that, forever)</span>
            <span class="font-bold text-green-400">${{ ex.annualSavings.toLocaleString() }}</span>
          </div>
        </div>
      </div>
      <!-- ROI -->
      <div class="max-w-2xl mx-auto bg-green-400/10 border border-green-400/30 rounded-2xl p-8 mt-8">
        <h3 class="font-bold text-center mb-6">📊 Return on Investment</h3>
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-6 text-center">
          <div>
            <p class="text-green-400 text-3xl font-bold">{{ ex.monthsToRoi }} mo</p>
            <p class="text-gray-400 text-sm mt-1">⏱️ Time to ROI</p>
          </div>
          <div>
            <p class="text-green-400 text-3xl font-bold">${{ ex.fixNet.toLocaleString() }}</p>
            <p class="text-gray-400 text-sm mt-1">🎉 Year 1 net savings</p>
          </div>
          <div>
            <p class="text-green-400 text-3xl font-bold">${{ ex.threeYearNet.toLocaleString() }}</p>
            <p class="text-gray-400 text-sm mt-1">🚀 3-year net savings</p>
          </div>
        </div>
        <p class="text-gray-500 text-xs text-center mt-4">One-time fee. Every dollar saved after that is yours. Forever. ✂️</p>
      </div>

      <p class="text-gray-500 text-sm text-center mt-6">Just want The Report? {{ pricing.reportPct }}%, a 45-min call, a PDF, and your team handles the rest. You keep ${{ ex.reportNet.toLocaleString() }} year one. 💰</p>
      </div>
    </section>

    <!-- Common Waste -->
    <section id="waste">
      <div class="max-w-5xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-2 text-center">🕵️ The Usual Suspects</h2>
        <p class="text-gray-400 text-center mb-8">Decisions that made sense at the time. That time was 2021. It's not 2021 anymore.</p>
        <WasteList :items="wasteSources" />
        <div class="text-center mt-10">
          <a
            href="#book"
            class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg"
          >
            🗓️ Find Out What's Hiding in Yours
          </a>
          <p class="text-gray-600 text-sm mt-3">15 min. Free. No commitment. 😏</p>
        </div>
      </div>
    </section>

    <!-- About -->
    <section id="about">
      <AboutSection />
    </section>

    <!-- Security & Compliance -->
    <section id="security">
      <SecuritySection />
    </section>

    <!-- FAQ -->
    <section id="faq">
      <FaqSection :questions="faqQuestions" />
      <div class="text-center pb-12">
        <a
          href="#book"
          class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg"
        >
          🗓️ Still Have Questions? Let's Talk
        </a>
        <p class="text-gray-600 text-sm mt-3">15 minutes. Free. I'll answer anything. 🤝</p>
      </div>
    </section>

    <!-- Final CTA -->
    <section id="cta">
      <div class="max-w-5xl mx-auto px-6 py-24 text-center">
      <h2 class="text-3xl font-bold mb-4">Your AWS bill isn't going to cut itself. ✂️</h2>
      <p class="text-xl text-gray-400 mb-2">15 minutes. Free. No pitch deck.</p>
      <p class="text-gray-500 mb-8">Find out what you're wasting &mdash; with zero risk and zero commitment. 💰</p>
      <a
        href="#book"
        class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg text-center"
      >
        🗓️ Book a Free 15-Min Chat
      </a>
      <p class="text-gray-600 text-sm mt-4">No hard sell. No PowerPoints. Just math. 🧮</p>
      </div>
    </section>

    <!-- Available Through -->
    <section id="available-through">
      <div class="max-w-5xl mx-auto px-6 py-12 text-center">
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
    </section>

    <!-- Mobile sticky CTA -->
    <MobileStickyCtaBar
      link="#book"
      text="🗓️ Book a Free 15-Min Chat"
      :visible="showMobileCta"
    />

  </PageSections>
</template>
