<script setup>
useHead({
  title: 'Cut Your Portfolio Companies\' AWS Costs — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})

// Pricing — synced with index.vue (single source of truth)
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

// Example: $25K/mo AWS spend, 36% waste found
const exampleAwsMonthly = 25000
const exampleWastePct = 36
const exampleMonthlySavings = Math.round(exampleAwsMonthly * exampleWastePct / 100)
const exampleAnnualSavings = exampleMonthlySavings * 12
const exampleFixFee = Math.round(exampleAnnualSavings * pricing.fixPct / 100)
const exampleKeepYear1 = exampleAnnualSavings - exampleFixFee
const monthsToRoi = Math.ceil(exampleFixFee / exampleMonthlySavings)

// Promo: free security scan — mirrors index.vue
const promoEnd = new Date('2026-04-04T23:59:59')
const now = new Date()
const promoActive = now < promoEnd
const promoDaysLeft = Math.max(0, Math.ceil((promoEnd.getTime() - now.getTime()) / (1000 * 60 * 60 * 24)))
</script>

<template>
  <div>
    <!-- Hero -->
    <section class="relative overflow-hidden">
      <div class="absolute inset-0 bg-gradient-to-br from-brand-500/5 via-transparent to-brand-500/3"></div>
      <div class="absolute top-0 right-0 w-[600px] h-[600px] bg-brand-500/5 rounded-full blur-3xl -translate-y-1/2 translate-x-1/3"></div>
      <div class="relative max-w-5xl mx-auto px-6 pt-16 pb-16">
        <div class="flex flex-col lg:flex-row gap-12 items-center">
          <!-- Left: Text -->
          <div class="flex-1">
            <h1 class="text-3xl sm:text-4xl font-extrabold leading-tight mb-4">
              Your portfolio companies are <span class="text-brand-400">overpaying AWS.</span>
            </h1>
            <p class="text-gray-400 text-lg mb-8">
              Nobody opened the AWS bill. It's been growing unsupervised since day one.
              I audit the account, find the waste, and fix it — while their engineering team stays focused on shipping. 🚀
            </p>
            <div class="flex flex-col sm:flex-row gap-4">
              <NuxtLink
                to="/book?c=investor-hero"
                class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-bold px-8 py-4 rounded-xl text-lg transition-colors text-center"
              >
                🗓️ Book Your Free Intro Call
              </NuxtLink>
              <p class="text-gray-500 text-sm self-center">15 min · free · no pitch deck 😏</p>
            </div>
          </div>

          <!-- Right: David card -->
          <div class="w-full lg:w-[380px] shrink-0">
            <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8 text-center">
              <img src="/david.png" alt="David Plappert" class="w-28 h-28 rounded-full mx-auto mb-5 object-cover object-top border-2 border-gray-700">
              <p class="font-bold text-lg mb-1">David Plappert</p>
              <p class="text-gray-500 text-sm mb-6">Senior AWS Architect · 19 years ☕</p>

              <div class="space-y-2 text-left text-sm">
                <div class="flex items-center gap-2 text-gray-400">
                  <span class="text-brand-400">✅</span> Pay only a % of verified savings
                </div>
                <div class="flex items-center gap-2 text-gray-400">
                  <span class="text-brand-400">✅</span> No savings? No fee. Period.
                </div>
                <div class="flex items-center gap-2 text-gray-400">
                  <span class="text-brand-400">✅</span> One engagement, permanent savings
                </div>
                <div class="flex items-center gap-2 text-gray-400">
                  <span class="text-brand-400">✅</span> No recurring fees or SaaS subscriptions
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Stats -->
    <section class="bg-gray-900">
      <div class="max-w-3xl mx-auto px-6 py-12">
        <div class="grid sm:grid-cols-3 gap-6 text-center">
          <div>
            <p class="text-brand-400 text-3xl font-bold">30–40%</p>
            <p class="text-gray-500 text-sm mt-1">Average waste per account (yes, really 😳)</p>
          </div>
          <div>
            <p class="text-green-400 text-3xl font-bold">{{ monthsToRoi }} mo</p>
            <p class="text-gray-500 text-sm mt-1">Time to ROI — faster than your next board meeting</p>
          </div>
          <div>
            <p class="text-brand-400 text-3xl font-bold">19 yrs</p>
            <p class="text-gray-500 text-sm mt-1">AWS experience — since before it was cool (2007)</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Client Logos (moved up — social proof early) -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-12">
        <ClientLogos />
      </div>
    </section>

    <!-- Dollar Example -->
    <section class="bg-gray-900">
      <div class="max-w-3xl mx-auto px-6 py-16 text-center">
        <h2 class="text-2xl font-bold mb-2">The math on a typical portfolio company 🧮</h2>
        <p class="text-gray-500 text-sm mb-8">${{ (exampleAwsMonthly / 1000).toFixed(0) }}K/mo AWS spend · {{ exampleWastePct }}% waste found</p>
        <div class="grid sm:grid-cols-3 gap-6">
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6">
            <p class="text-green-400 text-3xl font-bold">${{ (exampleAnnualSavings / 1000).toFixed(0) }}K</p>
            <p class="text-gray-500 text-sm mt-2">Annual savings found</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6">
            <p class="text-brand-400 text-3xl font-bold">${{ (exampleFixFee / 1000).toFixed(0) }}K</p>
            <p class="text-gray-500 text-sm mt-2">One-time fee ({{ pricing.fixPct }}% of savings)</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6">
            <p class="text-green-400 text-3xl font-bold">${{ (exampleAnnualSavings / 1000).toFixed(0) }}K</p>
            <p class="text-gray-500 text-sm mt-2">Saved every year after — forever 🎉</p>
          </div>
        </div>
        <p class="text-gray-600 text-xs mt-6">Year 1 net: ${{ (exampleKeepYear1 / 1000).toFixed(0) }}K kept · Year 2+: full ${{ (exampleAnnualSavings / 1000).toFixed(0) }}K/yr goes straight to runway</p>
      </div>
    </section>

    <!-- How it works -->
    <section class="max-w-3xl mx-auto px-6 py-16 text-center">
      <h2 class="text-2xl font-bold mb-2">How it works for portfolio companies</h2>
      <p class="text-gray-500 text-sm mb-8">Three steps. Less effort than reading a pitch deck. 📄</p>
      <div class="grid sm:grid-cols-3 gap-8 text-left">
        <div>
          <p class="text-brand-400 text-sm font-bold mb-2">STEP 1</p>
          <h3 class="font-bold mb-1">You forward one email</h3>
          <p class="text-gray-500 text-sm">Introduce David to your portfolio company's CTO. That's it. Lowest effort, highest ROI move you'll make this quarter. ⌨️</p>
        </div>
        <div>
          <p class="text-brand-400 text-sm font-bold mb-2">STEP 2</p>
          <h3 class="font-bold mb-1">David audits the account</h3>
          <p class="text-gray-500 text-sm">Read-only access, 5–10 business days. Full report: every waste item, dollar amounts, architecture fixes. The kind of due diligence AWS hopes nobody does. 🔍</p>
        </div>
        <div>
          <p class="text-brand-400 text-sm font-bold mb-2">STEP 3</p>
          <h3 class="font-bold mb-1">Savings hit the P&L</h3>
          <p class="text-gray-500 text-sm">Your portfolio company keeps the savings forever. One-time fee based on verified savings. No recurring costs. No "enterprise plan." 🎉</p>
        </div>
      </div>
    </section>

    <!-- Value props -->
    <section class="bg-gray-900">
      <div class="max-w-3xl mx-auto px-6 py-16">
        <div class="grid sm:grid-cols-3 gap-6 text-left">
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6">
            <p class="text-2xl mb-2">💸</p>
            <h3 class="font-bold mb-1">Pay on results</h3>
            <p class="text-gray-500 text-sm">No retainer. No hourly. You pay a percentage of verified savings — if I don't find waste, you owe nothing. Wild concept for consulting, I know. 🤷</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6">
            <p class="text-2xl mb-2">⏱️</p>
            <h3 class="font-bold mb-1">{{ monthsToRoi }}-month ROI</h3>
            <p class="text-gray-500 text-sm">Most engagements pay for themselves within {{ monthsToRoi }} months. After that, every dollar saved goes straight to runway. CFOs love this. Investors love it more. 😏</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6">
            <p class="text-2xl mb-2">🔁</p>
            <h3 class="font-bold mb-1">No recurring fees</h3>
            <p class="text-gray-500 text-sm">I'm not another SaaS on your portfolio's credit card. One engagement, permanent savings. The only thing that recurs is the money your companies keep. Every. Single. Month.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Qualifier -->
    <section class="max-w-3xl mx-auto px-6 py-16 text-center">
      <h2 class="text-2xl font-bold mb-2">Your portfolio company is a good fit if… 🎯</h2>
      <p class="text-gray-500 text-sm mb-8">Not every company needs this. Here's who gets the most value.</p>
      <div class="grid sm:grid-cols-2 gap-4 text-left max-w-2xl mx-auto">
        <div class="flex items-start gap-3 bg-gray-900 border border-gray-800 rounded-xl p-4">
          <span class="text-brand-400 text-lg mt-0.5">✅</span>
          <p class="text-gray-400 text-sm">Spending <span class="text-gray-200 font-semibold">${{ pricing.minAws / 1000 }}K+/mo</span> on AWS</p>
        </div>
        <div class="flex items-start gap-3 bg-gray-900 border border-gray-800 rounded-xl p-4">
          <span class="text-brand-400 text-lg mt-0.5">✅</span>
          <p class="text-gray-400 text-sm">Engineering team is <span class="text-gray-200 font-semibold">too busy shipping</span> to optimize infra</p>
        </div>
        <div class="flex items-start gap-3 bg-gray-900 border border-gray-800 rounded-xl p-4">
          <span class="text-brand-400 text-lg mt-0.5">✅</span>
          <p class="text-gray-400 text-sm">AWS bill has been <span class="text-gray-200 font-semibold">growing unsupervised</span> since launch</p>
        </div>
        <div class="flex items-start gap-3 bg-gray-900 border border-gray-800 rounded-xl p-4">
          <span class="text-brand-400 text-lg mt-0.5">✅</span>
          <p class="text-gray-400 text-sm">Nobody on the team has <span class="text-gray-200 font-semibold">done a cost audit</span> in the last 12 months</p>
        </div>
      </div>
    </section>

    <!-- Testimonials -->
    <section class="bg-gray-900">
      <div class="max-w-3xl mx-auto px-6 py-12">
        <Testimonials />
      </div>
    </section>

    <!-- Security Promo (if active) -->
    <section v-if="promoActive" class="max-w-3xl mx-auto px-6 py-12 text-center">
      <div class="bg-brand-500/10 border border-brand-500/30 rounded-2xl p-8">
        <p class="text-2xl mb-3">🛡️</p>
        <h3 class="text-xl font-bold mb-2">FREE Security Audit for Portfolio Companies</h3>
        <p class="text-gray-400 text-sm mb-2">Normally {{ pricing.securityPct }}% of AWS annual spend. Free for the next {{ promoDaysLeft }} day{{ promoDaysLeft === 1 ? '' : 's' }}.</p>
        <p class="text-gray-500 text-xs">Misconfigs, public S3 buckets, overprivileged IAM roles — the stuff that keeps CISOs up at night.</p>
      </div>
    </section>

    <!-- Bottom CTA -->
    <section class="bg-gray-900">
      <div class="max-w-3xl mx-auto px-6 py-16 text-center">
        <h2 class="text-2xl font-bold mb-3">Extend your portfolio's runway — without the uncomfortable headcount conversation.</h2>
        <p class="text-gray-400 mb-6">
          One engagement. Permanent savings. Your board deck gets a new slide and your portfolio companies stop lighting money on fire. 📊
        </p>
        <NuxtLink
          to="/book?c=investor-bottom"
          class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-bold px-8 py-4 rounded-xl text-lg transition-colors"
        >
          🗓️ Book Your Free Intro Call
        </NuxtLink>
        <p class="text-gray-600 text-sm mt-3">
          Multiple portfolio companies?
          <a href="mailto:david@cutmyaws.com?subject=Portfolio%20AWS%20Optimization%20%E2%9C%82%EF%B8%8F&body=Hey%20David%2C%0A%0AI%20invest%20in%20%5B%23%5D%20companies%20running%20on%20AWS.%20Let's%20talk%20about%20portfolio%20pricing." class="text-brand-400 hover:underline">Email David for bulk pricing</a> — volume discounts available 🧮
        </p>
        <p class="text-gray-600 text-sm mt-6">
          Prefer email? <a href="mailto:david@cutmyaws.com?subject=Portfolio%20AWS%20Optimization%20%E2%9C%82%EF%B8%8F&body=Hey%20David%2C%0A%0AI%20invest%20in%20%5B%23%5D%20companies%20running%20on%20AWS.%20Let's%20talk." class="text-brand-400 hover:underline">david@cutmyaws.com</a>
        </p>
      </div>
    </section>

    <!-- Mobile sticky CTA -->
    <div class="fixed bottom-0 inset-x-0 z-40 sm:hidden bg-gray-950/95 backdrop-blur-sm border-t border-gray-800 px-4 py-3">
      <NuxtLink
        to="/book?c=investor-mobile-sticky"
        class="block w-full bg-brand-500 hover:bg-brand-600 text-white font-bold py-3 rounded-xl text-center transition-colors"
      >
        🗓️ Book Free Intro Call
      </NuxtLink>
    </div>

  </div>
</template>
