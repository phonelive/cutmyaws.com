<script setup>
import { ref, onMounted, computed } from 'vue'

const calendlyUrl = 'https://calendly.com/phonelivestreaming/cutmyaws-com-intro'

// ── Hero ticker animation ──
const tickerValue = ref(0)
const tickerTarget = 108000 // $108K on a $25K/mo account at 36% savings
const tickerDisplay = computed(() => tickerValue.value.toLocaleString())

onMounted(() => {
  const duration = 2000
  const steps = 60
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
const calcAnnualSavings = computed(() => Math.round(calcAwsSpend.value * (calcWastePct.value / 100) * 12))
const calcReportFee = computed(() => Math.round(calcAnnualSavings.value * 0.15))
const calcFixFee = computed(() => Math.round(calcAnnualSavings.value * 0.40))
const calcKeepReport = computed(() => calcAnnualSavings.value - calcReportFee.value)
const calcKeepFix = computed(() => calcAnnualSavings.value - calcFixFee.value)

// Promo: free security scan — update this date to extend/end the promo
const promoEnd = new Date('2026-04-04T23:59:59')
const now = new Date()
const promoActive = now < promoEnd
const promoDaysLeft = Math.max(0, Math.ceil((promoEnd.getTime() - now.getTime()) / (1000 * 60 * 60 * 24)))

const stats = [
  { value: '$10-150K/mo', label: '🎯 The sweet spot. If this is your AWS bill, we should talk.' },
  { value: '$99', label: '💸 Down payment on your audit. Not an extra fee. We promise.' },
  { value: '19 years', label: '👨‍💻 Of AWS experience. Not an AI. Not a dashboard. Just David.' }
]

const clients = [
  { name: 'Caterpillar', url: 'https://www.caterpillar.com', logo: '/logos/cat.svg' },
  { name: 'DC Government', url: 'https://dc.gov', logo: '/logos/dc-gov.png' },
  { name: 'Best Buy', url: 'https://www.bestbuy.com', logo: '/logos/best-buy.svg' },
  { name: 'PBS', url: 'https://www.pbs.org', logo: '/logos/pbs.svg' },
  { name: 'Commonwealth of Massachusetts', url: 'https://www.mass.gov', logo: '/logos/ma-state.png' },
  { name: 'Argonne National Laboratory', url: 'https://www.anl.gov', logo: '/logos/argonne.png' },
  { name: 'PhoneLive', url: 'https://phonelive.com', logo: '/logos/phonelive.png' },
  { name: 'EZRA Cloud', url: 'https://ezracloud.com', logo: '/logos/ezra.png' },
]

const testimonials = [
  { quote: 'David is a dev genius.', emoji: '🧠' },
  { quote: 'David responds quickly and makes sure to explain things as best as possible.', emoji: '💬' },
  { quote: 'David\'s a commando. He is fast and efficient at getting results.', emoji: '🎯' },
]

const wasteSources = [
  { emoji: '🖥️', name: 'Servers running 24/7 for a workload that shows up at 9am and leaves at 5pm like the rest of us', savings: '40-70%' },
  { emoji: '🏗️', name: 'An RDS instance the size of a school bus for an app with 50 users', savings: '30-60%' },
  { emoji: '🧘', name: 'EC2 instances in a meditative state (they\'re not meditating, they\'re idle)', savings: '20-40%' },
  { emoji: '💳', name: 'Savings Plans that AWS literally wants you to buy but nobody told you about', savings: '30-50%' },
  { emoji: '🦕', name: 'EBS snapshots so old they remember when us-east-1 was the only region', savings: '$100-1,000/mo' },
  { emoji: '🍽️', name: 'A NAT Gateway that costs more than your team\'s lunch budget', savings: '$200-2,000/mo' },
  { emoji: '🐿️', name: 'Architecture built for the business plan you pitched to investors, not the one you\'re actually running', savings: '20-50%' }
]

// ── Pricing (change here, updates everywhere) ──
const pricing = {
  deposit: 99,
  reportPct: 15,       // The Report: 15% of annual savings
  fixPct: 40,          // The Fix: 40% total (15% report + 25% implementation)
  implPct: 25,         // Implementation portion (fixPct - reportPct)
  minAws: 10000,       // We work best with $10-150K/mo AWS spend
}

// ── Example numbers ──
const exampleBefore = 25000
const exampleSavings = 9000
const exampleAnnual = exampleSavings * 12
const scanDeposit = pricing.deposit
const reportFee = Math.round(exampleAnnual * pricing.reportPct / 100)
const fixFee = Math.round(exampleAnnual * pricing.fixPct / 100)
const reportNet = exampleAnnual - reportFee
const fixNet = exampleAnnual - fixFee
</script>

<template>
  <div class="min-h-screen bg-gray-950 text-gray-100">
    <!-- Promo Banner -->
    <div v-if="promoActive" class="bg-brand-600 text-white text-center py-2.5 px-6 text-sm font-medium">
      <a :href="calendlyUrl" target="_blank" class="hover:underline">
        🔒 FREE security scan with every audit — misconfigs, public buckets, IAM risks, oh my — ends in {{ promoDaysLeft }} day{{ promoDaysLeft === 1 ? '' : 's' }}!
      </a>
    </div>

    <!-- Nav -->
    <nav class="border-b border-gray-800">
      <div class="max-w-5xl mx-auto px-6 py-4 flex items-center justify-between">
        <div class="flex items-center gap-2">
          <span class="text-2xl">✂️</span>
          <span class="font-bold text-lg">Cut My AWS</span>
        </div>
        <a
          :href="calendlyUrl"
          target="_blank"
          class="bg-brand-500 hover:bg-brand-600 text-white font-semibold px-5 py-2 rounded-lg transition-colors text-sm"
        >
          💸 $99 &mdash; Let's Go
        </a>
      </div>
    </nav>

    <!-- Hero -->
    <section class="max-w-5xl mx-auto px-6 pt-16 pb-16">
      <div class="flex flex-col lg:flex-row gap-12 items-center">
        <!-- Left: Text -->
        <div class="flex-1">
          <p class="text-brand-400 font-semibold mb-4 text-lg">🛋️ AWS cost therapy for businesses spending $10-150K/mo</p>
          <h1 class="text-4xl sm:text-5xl font-bold leading-tight mb-6">
            Been using AWS for years? 🕸️<br>
            <span class="text-brand-400">When's the last time you cleaned house?</span>
          </h1>
          <p class="text-xl text-gray-400 mb-4">
            300+ services. Years of buildup. Forgotten snapshots, oversized databases, servers running 24/7 for workloads that left at 5pm. 🤷
            You've been busy building your business &mdash; nobody blames you for not catching it all. That's literally my job.
          </p>
          <p class="text-xl text-gray-400 mb-8">
            I dig through the cobwebs, find the garbage you're paying for, and <strong class="text-gray-200">make your AWS not just cheaper &mdash; but better.</strong>
            We only charge a % of the savings we find. No savings? No fee. 😏
          </p>
          <div class="flex flex-col sm:flex-row gap-4">
            <a
              :href="calendlyUrl"
              target="_blank"
              class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg text-center"
            >
              🗓️ Book Your $99 AWS Intervention
            </a>
            <p class="text-gray-500 text-sm self-center">15 min call. $99 down payment. <br class="sm:hidden">No pitch deck. Just math.</p>
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
    </section>

    <!-- Stats -->
    <section class="border-y border-gray-800 bg-gray-900/50">
      <div class="max-w-5xl mx-auto px-6 py-12 grid grid-cols-1 sm:grid-cols-3 gap-8">
        <div v-for="stat in stats" :key="stat.label" class="text-center">
          <div class="text-3xl font-bold text-brand-400 mb-1">{{ stat.value }}</div>
          <div class="text-sm text-gray-400">{{ stat.label }}</div>
        </div>
      </div>
    </section>

    <!-- Clients -->
    <section class="max-w-5xl mx-auto px-6 py-16">
      <p class="text-center text-gray-500 text-sm uppercase tracking-wider mb-10">Trusted by teams at</p>
      <div class="grid grid-cols-2 sm:grid-cols-4 gap-8 items-center justify-items-center max-w-4xl mx-auto">
        <a
          v-for="client in clients"
          :key="client.name"
          :href="client.url"
          target="_blank"
          rel="noopener"
          class="group flex items-center justify-center h-20 w-full px-6 rounded-xl bg-gray-900/40 border border-gray-800/50 hover:border-gray-700 hover:bg-gray-900/80 transition-all"
          :title="client.name"
        >
          <img
            :src="client.logo"
            :alt="client.name"
            class="h-10 max-w-[160px] object-contain opacity-60 group-hover:opacity-100 transition-opacity brightness-0 invert group-hover:brightness-100 group-hover:invert-0"
          >
        </a>
      </div>
    </section>

    <!-- Testimonials -->
    <section class="border-y border-gray-800 bg-gray-900/50">
      <div class="max-w-5xl mx-auto px-6 py-16">
        <p class="text-center text-gray-500 text-sm uppercase tracking-wider mb-10">What people say after working with David</p>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div
            v-for="t in testimonials"
            :key="t.quote"
            class="bg-gray-900 border border-gray-800 rounded-2xl p-6 text-center"
          >
            <p class="text-4xl mb-4">{{ t.emoji }}</p>
            <p class="text-gray-300 text-lg italic">"{{ t.quote }}"</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Philosophy -->
    <section class="max-w-5xl mx-auto px-6 py-16 text-center">
      <p class="text-2xl text-gray-300 font-medium italic max-w-3xl mx-auto">
        "Nobody sets out to waste money on AWS. It just happens. You launch fast, you scale fast, and three years later
        you're paying for infrastructure you forgot existed. That's not negligence &mdash; that's just building a business." 🧾
      </p>
      <p class="text-gray-500 mt-4">&mdash; David, who has found forgotten resources in literally every account he's ever audited</p>
    </section>

    <!-- How It Works -->
    <section class="bg-gray-900/50 border-y border-gray-800">
      <div class="max-w-5xl mx-auto px-6 py-20">
        <h2 class="text-3xl font-bold mb-4 text-center">How It Works 🧰</h2>
        <p class="text-gray-400 text-center mb-12 max-w-xl mx-auto">Two calls. One report. Zero PowerPoints. You decide how far to go after you see the numbers. 🤝</p>

        <!-- Timeline -->
        <div class="max-w-2xl mx-auto space-y-6">

          <!-- Step 1: Intro Call -->
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8">
            <div class="flex items-center gap-3 mb-4">
              <span class="bg-brand-500 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">1</span>
              <div>
                <h3 class="text-xl font-bold">🗓️ Intro Call</h3>
                <p class="text-gray-500 text-sm">15 min &middot; $99 down payment &middot; coffee optional but encouraged ☕</p>
              </div>
            </div>
            <p class="text-gray-400">You book a call, pay $99, and grant read-only AWS access. We meet, I poke around your account live, ask annoying questions about your business, and make sure I have everything I need to go deep. 🔍</p>
            <p class="text-gray-500 text-sm mt-3">The ${{ pricing.deposit }} is a down payment on your {{ pricing.reportPct }}% audit fee. It's not extra. It just proves you're serious and I'm not auditing someone's personal hobby project. (No offense to hobby projects.)</p>
          </div>

          <!-- Arrow -->
          <div class="text-center text-gray-600 text-2xl">⏳ 5-10 business days (I'm in your account, learning your business, judging your tag hygiene)</div>

          <!-- Step 2: Exploration Call -->
          <div class="bg-gray-900 border-2 border-brand-500 rounded-2xl p-8">
            <div class="flex items-center gap-3 mb-4">
              <span class="bg-brand-500 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">2</span>
              <div>
                <h3 class="text-xl font-bold">📋 Exploration Call &mdash; The Report</h3>
                <p class="text-gray-500 text-sm">{{ pricing.reportPct }}% of annual savings found (minus your ${{ pricing.deposit }}, because fair is fair)</p>
              </div>
            </div>
            <p class="text-gray-400 mb-4">I present everything: every waste item, exact dollar amounts, architecture recommendations, and where your tech doesn't match your business. It's like a doctor's visit for your infrastructure, except I have better bedside manner. 📄</p>
            <ul class="space-y-3 text-gray-300">
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>Line-by-line savings breakdown your CFO will actually understand (and maybe frame)</span>
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
                <span><strong class="text-brand-400">BONUS:</strong> Free AWS security scan &mdash; misconfigs, public S3 buckets, IAM roles that shouldn't exist ({{ promoDaysLeft }} day{{ promoDaysLeft === 1 ? '' : 's' }} left!)</span>
              </li>
            </ul>
            <p class="text-gray-500 text-sm mt-4">Remainder of the {{ pricing.reportPct }}% fee is due at this call. Your ${{ pricing.deposit }} comes right off. Math. 🧮</p>
          </div>

          <!-- Arrow -->
          <div class="text-center text-gray-600 text-2xl">🤔 Want me to actually fix it? (Most people do. Turns out reading a 30-page report isn't fun.)</div>

          <!-- Step 3: Implementation (Optional) -->
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8 relative">
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
                <span><strong>+{{ pricing.implPct }}% of verified savings due at the 90-day mark.</strong> If the savings didn't stick? You owe me nothing. I'll go cry into my own AWS bill. 🤷</span>
              </li>
            </ul>
            <p class="text-gray-500 text-sm mt-4">{{ pricing.fixPct }}% total max ({{ pricing.reportPct }}% report + {{ pricing.implPct }}% implementation). That's the ceiling. There is no "and also this other fee." 🚫</p>
          </div>

          <!-- Arrow -->
          <div class="text-center text-gray-600 text-2xl">⏳ 90 days later... (the moment of truth 🥁)</div>

          <!-- Step 4: Verification -->
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8">
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
    <section class="max-w-5xl mx-auto px-6 py-20">
      <h2 class="text-3xl font-bold mb-2 text-center">🧮 What Could You Save?</h2>
      <p class="text-gray-400 text-center mb-2">Slide the numbers. See the math. No monthly fees. No recurring charges. Ever. 💰</p>
      <p class="text-gray-500 text-center mb-10 text-sm">You pay once. You keep the savings forever.</p>

      <div class="max-w-2xl mx-auto bg-gray-900 border border-gray-800 rounded-2xl p-8">
        <!-- Sliders -->
        <div class="space-y-6 mb-8">
          <div>
            <div class="flex justify-between mb-2">
              <label class="text-gray-300 font-medium">💸 Monthly AWS Spend</label>
              <span class="text-brand-400 font-bold text-lg">${{ calcAwsSpend.toLocaleString() }}/mo</span>
            </div>
            <input
              v-model.number="calcAwsSpend"
              type="range"
              min="5000"
              max="150000"
              step="5000"
              class="w-full h-2 bg-gray-700 rounded-lg appearance-none cursor-pointer accent-brand-500"
            >
            <div class="flex justify-between text-xs text-gray-600 mt-1">
              <span>$5K</span>
              <span>$150K</span>
            </div>
          </div>
          <div>
            <div class="flex justify-between mb-2">
              <label class="text-gray-300 font-medium">🔍 Estimated Waste</label>
              <span class="text-red-400 font-bold text-lg">{{ calcWastePct }}%</span>
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
              <span>10% (lean)</span>
              <span>30% (typical)</span>
              <span>50% (yikes)</span>
            </div>
          </div>
        </div>

        <!-- Results -->
        <div class="bg-gray-950 rounded-xl p-6 border border-gray-800 space-y-4">
          <div class="flex justify-between">
            <span class="text-gray-400">🔥 Annual savings found</span>
            <span class="font-bold text-red-400 text-lg">${{ calcAnnualSavings.toLocaleString() }}</span>
          </div>
          <hr class="border-gray-800">

          <p class="text-gray-500 text-xs uppercase tracking-wider">📋 The Report ({{ pricing.reportPct }}%)</p>
          <div class="flex justify-between">
            <span class="text-gray-400">Your fee</span>
            <span class="font-semibold">${{ calcReportFee.toLocaleString() }}</span>
          </div>
          <div class="flex justify-between">
            <span class="font-bold text-green-400">🎉 You keep (year 1)</span>
            <span class="font-bold text-green-400">${{ calcKeepReport.toLocaleString() }}</span>
          </div>
          <hr class="border-gray-800">

          <p class="text-gray-500 text-xs uppercase tracking-wider">🔧 The Fix ({{ pricing.fixPct }}% total)</p>
          <div class="flex justify-between">
            <span class="text-gray-400">Your fee (report + implementation)</span>
            <span class="font-semibold">${{ calcFixFee.toLocaleString() }}</span>
          </div>
          <div class="flex justify-between">
            <span class="font-bold text-green-400">🎉 You keep (year 1)</span>
            <span class="font-bold text-green-400">${{ calcKeepFix.toLocaleString() }}</span>
          </div>
          <hr class="border-gray-800">

          <div class="flex justify-between text-lg">
            <span class="font-bold text-green-400">🚀 You keep every year after</span>
            <span class="font-bold text-green-400">${{ calcAnnualSavings.toLocaleString() }}</span>
          </div>
          <p class="text-gray-600 text-xs text-center">No monthly fees. No recurring charges. No subscriptions. You pay once and keep 100% forever. ✂️</p>
        </div>

        <!-- CTA -->
        <div class="text-center mt-6">
          <a
            :href="calendlyUrl"
            target="_blank"
            class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-6 py-3 rounded-xl transition-colors"
          >
            🗓️ Let's find your actual number →
          </a>
        </div>
      </div>
    </section>

    <!-- Example -->
    <section class="bg-gray-900/50 border-y border-gray-800">
      <div class="max-w-5xl mx-auto px-6 py-20">
      <h2 class="text-3xl font-bold mb-2 text-center">🧮 Real Math, Fake Company</h2>
      <p class="text-gray-400 text-center mb-8">A ${{ (exampleBefore).toLocaleString() }}/mo SaaS company that swore their AWS was "pretty optimized" 👀</p>

      <!-- Shared finding -->
      <div class="max-w-2xl mx-auto bg-gray-900 border border-gray-800 rounded-2xl p-6 mb-6">
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
            <span class="font-semibold">${{ scanDeposit }}</span>
          </div>
          <div class="flex justify-between items-center">
            <div>
              <span class="text-gray-300 font-medium">📋 Exploration Call</span>
              <span class="text-gray-500 ml-2">~2 weeks</span>
            </div>
            <span class="font-semibold">${{ (reportFee - scanDeposit).toLocaleString() }}</span>
          </div>
          <div class="text-gray-500 text-xs pl-4">{{ pricing.reportPct }}% of ${{ exampleAnnual.toLocaleString() }} = ${{ reportFee.toLocaleString() }} &mdash; minus the ${{ scanDeposit }} you already paid</div>
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
      <p class="text-gray-500 text-sm text-center mt-4">Just want the report? {{ pricing.reportPct }}% and your team handles it. You keep ${{ reportNet.toLocaleString() }} year one. No hard feelings. 💰</p>
      </div>
    </section>

    <!-- Common Waste -->
    <section class="bg-gray-900/50 border-y border-gray-800">
      <div class="max-w-5xl mx-auto px-6 py-20">
        <h2 class="text-3xl font-bold mb-2 text-center">🕵️ The Usual Suspects</h2>
        <p class="text-gray-400 text-center mb-8">Decisions that made sense at the time. That time was 2021. It's not 2021 anymore.</p>
        <div class="max-w-2xl mx-auto space-y-3">
          <div
            v-for="item in wasteSources"
            :key="item.name"
            class="flex items-center justify-between bg-gray-900 border border-gray-800 rounded-xl px-6 py-4"
          >
            <span class="text-gray-300"><span class="mr-2">{{ item.emoji }}</span>{{ item.name }}</span>
            <span class="text-brand-400 font-semibold text-sm whitespace-nowrap ml-4">{{ item.savings }}</span>
          </div>
        </div>
      </div>
    </section>

    <!-- About -->
    <section class="max-w-5xl mx-auto px-6 py-20">
      <div class="max-w-2xl mx-auto text-center">
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
          Most cost tools tell you what you're spending. I tell you <em>why</em> your tech doesn't match your business &mdash; and I make it <strong class="text-gray-200">not just cheaper, but better.</strong> 🎯
        </p>
        <p class="text-gray-400 text-lg leading-relaxed mb-4">
          Should that EC2 fleet be Lambda functions? (Probably.) Does that RDS instance need to be that big? (It does not.)
          Is your architecture built for a business model that pivoted two years ago? (Almost certainly.) I ask the questions a dashboard can't. 🤔
        </p>
        <p class="text-gray-400 text-lg leading-relaxed mb-4">
          I only need <strong class="text-gray-200">read-only access</strong> for the scan. 🔒
          No write permissions. I can look but I can't touch. Think of it as window shopping your infrastructure. Very judgmentally.
        </p>
        <p class="text-gray-500 text-base">
          Yes, "Cut My AWS" is a real business name registered with the state of Florida. No, I will not apologize for it. ✂️
        </p>
      </div>
    </section>

    <!-- FAQ -->
    <section class="bg-gray-900/50 border-y border-gray-800">
      <div class="max-w-5xl mx-auto px-6 py-20">
        <h2 class="text-3xl font-bold mb-12 text-center">❓ Questions you're definitely asking right now</h2>
        <div class="max-w-2xl mx-auto space-y-8">
          <div>
            <h3 class="text-lg font-bold mb-2">🤔 What if you don't find any savings?</h3>
            <p class="text-gray-400">Then you have the most optimized AWS account I've ever seen, and honestly? I'll be impressed. You're out $99. In my career this has happened exactly zero times, but I hear there's a first time for everything. I'll send you a congratulatory email.</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🤨 When do I actually pay?</h3>
            <p class="text-gray-400">$99 when you book (down payment). Remainder of {{ pricing.reportPct }}% at the exploration call when you get the report. If you opt for implementation, the extra {{ pricing.implPct }}% isn't due until <strong>90 days after deliverables</strong> &mdash; and only on verified savings. You literally never pay for results that didn't happen. This is the opposite of how consulting usually works, and I'm aware of that. 😅</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🎯 Is this just a cost audit or something more?</h3>
            <p class="text-gray-400">Way more. Cost tools tell you <em>what</em> you're spending. I tell you <em>why</em> your tech doesn't match your business &mdash; and that's where the real savings live. Running servers 24/7 for a workload that spikes twice a day? That's not a billing problem, that's an architecture problem. I'm a serverless architect who happens to also save you money. The savings are a side effect of good architecture. 🏗️</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">📏 Is $10-150K/mo really the sweet spot?</h3>
            <p class="text-gray-400">We work best with AWS accounts spending $10K/mo or more. Below that, there usually isn't enough waste to justify an engagement. Above $150K you probably need a full-time FinOps team (I can help you hire one, actually). But that $10-150K range? That's where businesses are big enough to have real infrastructure but too busy building product to optimize it. That's my people. 🫡</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🧑‍💻 Can't I just use AWS Cost Explorer myself?</h3>
            <p class="text-gray-400">You can! And you should! But Cost Explorer shows you <em>what</em> you're spending. I show you <em>why</em> it's too much and exactly how to fix it. It's the difference between a thermometer and a doctor. One tells you the temperature. The other tells you why you feel terrible and gives you a prescription. 🌡️</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🛠️ What if my team can implement the fixes themselves?</h3>
            <p class="text-gray-400">Awesome &mdash; that's literally what the report is for. You pay {{ pricing.reportPct }}%, get the full playbook, and your team runs with it. I'll even answer questions if they get stuck. I don't get offended when people don't need me. I get paid and you get savings. Capitalism at its finest. 🎉</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🤖 How is this different from CloudHealth / ProsperOps / [insert SaaS tool]?</h3>
            <p class="text-gray-400">Those are dashboards. They scan your account and show you charts. I'm a person who reads your architecture, understands your business, gets on a call with you, and tells you exactly what to change and why. Dashboards find obvious waste. I find the structural misalignment between your tech and your business that no tool can see. Also, I can explain things using sports metaphors if that helps. Dashboards cannot. 😏</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">😰 How do I know you won't break something?</h3>
            <p class="text-gray-400">The scan uses read-only access. I literally cannot change anything even if I wanted to. For implementation, every change is documented, reviewed with your team, and rolled out carefully. I've been doing this for 19 years. I break things on my own AWS account, not yours. (My personal bill is a whole separate therapy session.) 😅</p>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA -->
    <section class="max-w-5xl mx-auto px-6 py-20 text-center">
      <h2 class="text-3xl font-bold mb-4">Your AWS bill isn't going to cut itself. ✂️</h2>
      <p class="text-xl text-gray-400 mb-2">$99. 15 minutes. One call that pays for itself about a thousand times over.</p>
      <p class="text-gray-500 mb-8">Built for small businesses spending $10-150K/mo on AWS who'd rather spend that money on literally anything else. 💰</p>
      <a
        :href="calendlyUrl"
        target="_blank"
        class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg"
      >
        🗓️ Book Your $99 AWS Intervention
      </a>
      <p class="text-gray-600 text-sm mt-4">Down payment on your audit. No extra fees. No hard sell. No PowerPoints. Just math. 🧮</p>
    </section>

    <!-- Referral -->
    <section class="border-t border-gray-800 bg-gray-900/50">
      <div class="max-w-3xl mx-auto px-6 py-16 text-center">
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
        <p class="text-gray-600 text-sm mt-4">or just email <a href="mailto:david@cutmyaws.com" class="text-brand-400 hover:underline">david@cutmyaws.com</a> — I respond fast ⚡</p>
      </div>
    </section>

    <!-- Footer -->
    <footer class="border-t border-gray-800 bg-gray-900/50">
      <div class="max-w-5xl mx-auto px-6 py-8 flex flex-col sm:flex-row items-center justify-between gap-4 text-sm text-gray-500">
        <span>✂️ &copy; {{ new Date().getFullYear() }} Smart Talk LLC &middot; Ocala, FL &middot; A real company with a real silly name</span>
        <div class="flex items-center gap-4">
          <a href="https://www.linkedin.com/in/davidplappert/" target="_blank" class="hover:text-gray-300 transition-colors">💼 LinkedIn</a>
          <a href="mailto:david@cutmyaws.com" class="hover:text-gray-300 transition-colors">📧 david@cutmyaws.com</a>
        </div>
      </div>
    </footer>
  </div>
</template>
