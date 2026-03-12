<script setup>
useHead({
  title: 'Cut Your Portfolio Companies\' AWS Costs — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})

// Promo: free security scan — mirrors index.vue
const promoEnd = new Date('2026-04-04T23:59:59')
const now = new Date()
const promoActive = now < promoEnd
const promoDaysLeft = Math.max(0, Math.ceil((promoEnd.getTime() - now.getTime()) / (1000 * 60 * 60 * 24)))

// Pricing — mirrors index.vue
const pricing = {
  fixPct: 75,
  minAws: 5000,
}

// Example: $25K/mo, 36% waste
const exampleSavings = 9000
const exampleAnnual = exampleSavings * 12
const fixFee = Math.round(exampleAnnual * pricing.fixPct / 100)
const monthsToRoi = Math.ceil(fixFee / exampleSavings)
const minAwsK = `$${pricing.minAws / 1000}K`

</script>

<template>
  <div class="min-h-screen bg-gray-950 text-gray-100">
    <!-- Promo urgency banner -->
    <div v-if="promoActive" class="bg-brand-600 text-white text-center py-2.5 px-6 text-sm font-medium">
      <NuxtLink to="/book?c=investor-promo" class="hover:underline">
        🛡️ FREE Security Audit with every engagement — ends in {{ promoDaysLeft }} day{{ promoDaysLeft === 1 ? '' : 's' }}!
      </NuxtLink>
    </div>

    <!-- Nav -->
    <nav class="border-b border-gray-800/50">
      <div class="max-w-5xl mx-auto px-6 py-4 flex items-center justify-between">
        <NuxtLink to="/" class="flex items-center gap-2 hover:opacity-80 transition-opacity">
          <span class="text-2xl">✂️</span>
          <span class="font-bold text-lg">Cut My AWS</span>
        </NuxtLink>
        <NuxtLink
          to="/book?c=investor-nav"
          class="bg-brand-500 hover:bg-brand-600 text-white font-semibold px-4 py-2 rounded-lg text-sm transition-colors"
        >
          Book Free Intro Call
        </NuxtLink>
      </div>
    </nav>

    <!-- Hero -->
    <section class="max-w-3xl mx-auto px-6 pt-16 pb-12 text-center">
      <div class="flex items-center justify-center gap-4 mb-6">
        <img src="/david.png" alt="David Plappert" class="w-16 h-16 rounded-full border-2 border-gray-800" />
        <div class="text-left">
          <p class="font-bold text-lg">David Plappert</p>
          <p class="text-gray-500 text-sm">Senior AWS Architect · 19 years</p>
        </div>
      </div>
      <h1 class="text-3xl sm:text-4xl font-extrabold mb-4">
        Your portfolio companies are <span class="text-brand-400">overpaying AWS.</span>
      </h1>
      <p class="text-gray-400 text-lg mb-4">
        You checked the team, the TAM, the cap table, the pitch deck, the Figma mockups, the founder's LinkedIn —
        but nobody opened the AWS bill. It's been growing unsupervised since day one. 😬
      </p>
      <p class="text-gray-400 text-lg mb-8">
        I audit your portfolio companies' AWS accounts, find the waste, and fix it —
        while their engineering team stays focused on shipping features, not deciphering Cost Explorer.
        That infrastructure bloat they've been ignoring since the seed round? That's my Tuesday. 🚀
      </p>
      <NuxtLink
        to="/book?c=investor-hero"
        class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-bold px-8 py-4 rounded-xl text-lg transition-colors"
      >
        🗓️ Book Your Free Intro Call
      </NuxtLink>
      <p class="text-gray-600 text-sm mt-3">15 min · free · no pitch deck 😏</p>
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

    <!-- Value props -->
    <section class="max-w-3xl mx-auto px-6 py-16">
      <div class="grid sm:grid-cols-3 gap-6 text-left">
        <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6">
          <p class="text-2xl mb-2">💸</p>
          <h3 class="font-bold mb-1">Pay on results</h3>
          <p class="text-gray-500 text-sm">No retainer. No hourly. You pay a percentage of verified savings — if I don't find waste, you owe nothing. Wild concept for consulting, I know. 🤷</p>
        </div>
        <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6">
          <p class="text-2xl mb-2">⏱️</p>
          <h3 class="font-bold mb-1">{{ monthsToRoi }}-month ROI</h3>
          <p class="text-gray-500 text-sm">Most engagements pay for themselves within {{ monthsToRoi }} months. After that, every dollar saved goes straight to runway. CFOs love this. Investors love it more. 😏</p>
        </div>
        <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6">
          <p class="text-2xl mb-2">🔁</p>
          <h3 class="font-bold mb-1">No recurring fees</h3>
          <p class="text-gray-500 text-sm">I'm not another SaaS on your portfolio's credit card. One engagement, permanent savings. The only thing that recurs is the money your companies keep. Every. Single. Month.</p>
        </div>
      </div>
    </section>

    <!-- Social proof -->
    <section class="bg-gray-900">
      <div class="max-w-3xl mx-auto px-6 py-12">
        <ClientLogos />
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
          <p class="text-gray-500 text-sm">That's your entire contribution. David takes it from there. Your team doesn't lift a finger until the call. Possibly the best ROI-per-keystroke in your portfolio. ⌨️</p>
        </div>
        <div>
          <p class="text-brand-400 text-sm font-bold mb-2">STEP 2</p>
          <h3 class="font-bold mb-1">David audits the account</h3>
          <p class="text-gray-500 text-sm">Read-only access, 5–10 business days. Full report: every waste item, dollar amounts, architecture fixes. The kind of due diligence AWS hopes nobody does. 🔍</p>
        </div>
        <div>
          <p class="text-brand-400 text-sm font-bold mb-2">STEP 3</p>
          <h3 class="font-bold mb-1">Savings hit the P&L</h3>
          <p class="text-gray-500 text-sm">Your portfolio company keeps the savings forever. My fee is a one-time percentage of what I find. No recurring costs. No SaaS subscription. No "enterprise plan." 🎉</p>
        </div>
      </div>
    </section>

    <!-- Bottom CTA -->
    <section class="bg-gray-900">
      <div class="max-w-3xl mx-auto px-6 py-16 text-center">
        <h2 class="text-2xl font-bold mb-3">Extend your portfolio's runway — without the uncomfortable headcount conversation.</h2>
        <p class="text-gray-400 mb-6">
          One engagement. Permanent savings. Your board deck gets a new slide and your portfolio companies stop lighting money on fire. You're welcome. 📊
        </p>
        <NuxtLink
          to="/book?c=investor-bottom"
          class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-bold px-8 py-4 rounded-xl text-lg transition-colors"
        >
          🗓️ Book Your Free Intro Call
        </NuxtLink>
        <p class="text-gray-600 text-sm mt-3">Bulk portfolio pricing available — because math rewards volume 🧮</p>
        <p class="text-gray-600 text-sm mt-6">
          Prefer email? <a href="mailto:david@cutmyaws.com?subject=Portfolio%20AWS%20Optimization%20%E2%9C%82%EF%B8%8F&body=Hey%20David%2C%0A%0AI%20invest%20in%20%5B%23%5D%20companies%20running%20on%20AWS.%20Let's%20talk." class="text-brand-400 hover:underline">david@cutmyaws.com</a>
        </p>
      </div>
    </section>

    <!-- Footer -->
    <footer class="border-t border-gray-800">
      <div class="max-w-5xl mx-auto px-6 py-6 flex flex-col sm:flex-row items-center justify-between gap-4 text-sm text-gray-600">
        <NuxtLink to="/" class="hover:text-gray-400 transition-colors">← Back to cutmyaws.com</NuxtLink>
        <p>&copy; {{ new Date().getFullYear() }} Smart Talk LLC</p>
      </div>
    </footer>
  </div>
</template>
