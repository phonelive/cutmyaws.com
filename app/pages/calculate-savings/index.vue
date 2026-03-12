<script setup>
import { ref, computed } from 'vue'

useHead({
  title: 'Calculate Your Annualized AWS Bill — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})

const months = ref([
  { label: '', amount: null },
  { label: '', amount: null },
  { label: '', amount: null },
  { label: '', amount: null },
  { label: '', amount: null },
  { label: '', amount: null },
  { label: '', amount: null },
  { label: '', amount: null },
  { label: '', amount: null },
  { label: '', amount: null },
  { label: '', amount: null },
  { label: '', amount: null },
])

// Generate last 12 month labels
const now = new Date()
const monthLabels = Array.from({ length: 12 }, (_, i) => {
  const d = new Date(now.getFullYear(), now.getMonth() - 11 + i, 1)
  return d.toLocaleDateString('en-US', { month: 'short', year: 'numeric' })
})

// Assign labels on setup
months.value.forEach((m, i) => { m.label = monthLabels[i] })

const filledMonths = computed(() => months.value.filter(m => m.amount !== null && m.amount !== '' && !isNaN(m.amount)))
const totalSpend = computed(() => filledMonths.value.reduce((sum, m) => sum + Number(m.amount), 0))
const monthlyAverage = computed(() => filledMonths.value.length > 0 ? Math.round(totalSpend.value / filledMonths.value.length) : 0)
const annualizedSpend = computed(() => monthlyAverage.value * 12)

// Savings estimates
const conservativePct = 20
const averagePct = 35
const aggressivePct = 50
const conservativeSavings = computed(() => Math.round(annualizedSpend.value * conservativePct / 100))
const averageSavings = computed(() => Math.round(annualizedSpend.value * averagePct / 100))
const aggressiveSavings = computed(() => Math.round(annualizedSpend.value * aggressivePct / 100))

// Pricing breakdown (mirrors index.vue pricing object)
const reportPct = 15
const fixPct = 75
const depositPct = 1

const depositFee = computed(() => Math.round(annualizedSpend.value * depositPct / 100))
const reportFee = computed(() => Math.round(averageSavings.value * reportPct / 100))
const fixFee = computed(() => Math.round(averageSavings.value * fixPct / 100))
const yearOneNet = computed(() => averageSavings.value - fixFee.value)
const yearTwoPlus = computed(() => averageSavings.value)
const fiveYearNet = computed(() => (averageSavings.value * 5) - fixFee.value)

function fmt(n) {
  return '$' + n.toLocaleString()
}

function clear() {
  months.value.forEach(m => { m.amount = null })
}

const hasData = computed(() => filledMonths.value.length >= 1)
</script>

<template>
  <div class="min-h-screen bg-gray-950 text-gray-100">
    <!-- Nav -->
    <nav class="border-b border-gray-800/50">
      <div class="max-w-5xl mx-auto px-6 py-4 flex items-center justify-between">
        <NuxtLink to="/" class="flex items-center gap-2 hover:opacity-80 transition-opacity">
          <span class="text-2xl">✂️</span>
          <span class="font-bold text-lg">Cut My AWS</span>
        </NuxtLink>
        <NuxtLink to="/give-david-access" class="text-gray-500 text-sm hover:text-gray-300 transition-colors hidden sm:block">
          🔧 Grant Access →
        </NuxtLink>
      </div>
    </nav>

    <!-- Header -->
    <div class="max-w-3xl mx-auto px-6 pt-12 sm:pt-16 pb-8 text-center">
      <h1 class="text-2xl sm:text-3xl font-bold mb-3">🧮 Calculate Your Annualized AWS Bill</h1>
      <p class="text-gray-400 mb-2">Enter your last 3-12 months of AWS spend to calculate your annualized bill.</p>
      <p class="text-gray-500 text-sm">This is used to determine the {{ depositPct }}% deposit and estimate your savings. You don't need all 12 months — enter what you have. 📊</p>
    </div>

    <!-- Where to find your bill -->
    <div class="max-w-3xl mx-auto px-6 pb-8">
      <div class="bg-gray-900 rounded-xl border border-gray-800 p-6">
        <h2 class="text-lg font-bold mb-3">📋 Where to Find Your Monthly Bills</h2>
        <ol class="space-y-3 text-gray-400 text-sm">
          <li class="flex gap-3">
            <span class="text-brand-400 font-bold flex-shrink-0">1.</span>
            <span>Sign in to the <strong class="text-gray-300">AWS Console</strong> as the account owner (root or IAM user with billing access)</span>
          </li>
          <li class="flex gap-3">
            <span class="text-brand-400 font-bold flex-shrink-0">2.</span>
            <span>Go to <strong class="text-gray-300">Billing and Cost Management</strong> → <strong class="text-gray-300">Bills</strong></span>
          </li>
          <li class="flex gap-3">
            <span class="text-brand-400 font-bold flex-shrink-0">3.</span>
            <span>Use the date dropdown to view each month. The <strong class="text-gray-300">"Total"</strong> at the top is what you enter below.</span>
          </li>
          <li class="flex gap-3">
            <span class="text-brand-400 font-bold flex-shrink-0">4.</span>
            <span>Alternatively, go to <strong class="text-gray-300">Cost Explorer</strong> → set granularity to <strong class="text-gray-300">Monthly</strong> → the bar chart shows each month's total</span>
          </li>
        </ol>
        <p class="text-gray-500 text-xs mt-4">💡 If you have multiple AWS accounts in an Organization, use the <strong>management account</strong> to see consolidated billing across all accounts.</p>
      </div>
    </div>

    <!-- Monthly input grid -->
    <div class="max-w-3xl mx-auto px-6 pb-8">
      <div class="flex items-center justify-between mb-4">
        <h2 class="text-lg font-bold">💰 Monthly AWS Spend</h2>
        <button @click="clear" class="text-gray-600 text-sm hover:text-gray-400 transition-colors">Clear all</button>
      </div>
      <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-3">
        <div
          v-for="(month, i) in months"
          :key="i"
          class="bg-gray-900 rounded-lg border border-gray-800 p-3"
        >
          <label class="text-gray-500 text-xs block mb-1">{{ month.label }}</label>
          <div class="flex items-center gap-1">
            <span class="text-gray-600 text-sm">$</span>
            <input
              v-model.number="month.amount"
              type="number"
              min="0"
              step="100"
              placeholder="0"
              class="bg-transparent text-gray-100 text-sm w-full outline-none placeholder-gray-700 [appearance:textfield] [&::-webkit-outer-spin-button]:appearance-none [&::-webkit-inner-spin-button]:appearance-none"
            />
          </div>
        </div>
      </div>
      <p class="text-gray-600 text-xs mt-3">Enter at least 3 months for the most accurate estimate. More months = better average.</p>
    </div>

    <!-- Results -->
    <div v-if="hasData" class="max-w-3xl mx-auto px-6 pb-12">
      <!-- Summary cards -->
      <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-8">
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-5 text-center">
          <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">Monthly Average</p>
          <p class="text-2xl font-bold text-gray-100">{{ fmt(monthlyAverage) }}</p>
          <p class="text-gray-600 text-xs mt-1">Based on {{ filledMonths.length }} month{{ filledMonths.length === 1 ? '' : 's' }}</p>
        </div>
        <div class="bg-gray-900 rounded-xl border-2 border-brand-500 p-5 text-center">
          <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">Annualized Spend</p>
          <p class="text-2xl font-bold text-brand-400">{{ fmt(annualizedSpend) }}</p>
          <p class="text-gray-600 text-xs mt-1">{{ fmt(monthlyAverage) }} × 12 months</p>
        </div>
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-5 text-center">
          <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">{{ depositPct }}% Deposit</p>
          <p class="text-2xl font-bold text-gray-100">{{ fmt(depositFee) }}</p>
          <p class="text-gray-600 text-xs mt-1">Deducted from The Report fee</p>
        </div>
      </div>

      <!-- Savings estimates -->
      <h2 class="text-lg font-bold mb-4">📉 Estimated Savings Range</h2>
      <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-8">
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-5">
          <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">Conservative ({{ conservativePct }}%)</p>
          <p class="text-xl font-bold text-green-400">{{ fmt(conservativeSavings) }}<span class="text-gray-500 text-sm">/yr</span></p>
          <p class="text-gray-600 text-xs mt-1">{{ fmt(Math.round(conservativeSavings / 12)) }}/mo</p>
        </div>
        <div class="bg-gray-900 rounded-xl border-2 border-green-500/50 p-5">
          <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">Average ({{ averagePct }}%)</p>
          <p class="text-xl font-bold text-green-400">{{ fmt(averageSavings) }}<span class="text-gray-500 text-sm">/yr</span></p>
          <p class="text-gray-600 text-xs mt-1">{{ fmt(Math.round(averageSavings / 12)) }}/mo</p>
        </div>
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-5">
          <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">Aggressive ({{ aggressivePct }}%)</p>
          <p class="text-xl font-bold text-green-400">{{ fmt(aggressiveSavings) }}<span class="text-gray-500 text-sm">/yr</span></p>
          <p class="text-gray-600 text-xs mt-1">{{ fmt(Math.round(aggressiveSavings / 12)) }}/mo</p>
        </div>
      </div>

      <!-- Pricing breakdown (using average) -->
      <h2 class="text-lg font-bold mb-4">💰 Pricing Breakdown <span class="text-gray-500 text-sm font-normal">(at {{ averagePct }}% savings)</span></h2>
      <div class="bg-gray-900 rounded-xl border border-gray-800 overflow-hidden mb-8">
        <div class="divide-y divide-gray-800">
          <div class="flex justify-between items-center p-4">
            <div>
              <p class="text-gray-300 font-medium">📋 The Report ({{ reportPct }}% of savings)</p>
              <p class="text-gray-600 text-xs">Full audit PDF + 45-min walkthrough call</p>
            </div>
            <p class="text-gray-100 font-bold">{{ fmt(reportFee) }}</p>
          </div>
          <div class="flex justify-between items-center p-4">
            <div>
              <p class="text-gray-300 font-medium">🔧 The Fix ({{ fixPct }}% total including report)</p>
              <p class="text-gray-600 text-xs">Implementation + 90-day verification</p>
            </div>
            <p class="text-gray-100 font-bold">{{ fmt(fixFee) }}</p>
          </div>
          <div class="flex justify-between items-center p-4 bg-gray-950/50">
            <div>
              <p class="text-green-400 font-medium">✅ You keep — year 1</p>
              <p class="text-gray-600 text-xs">{{ fmt(averageSavings) }} savings - {{ fmt(fixFee) }} fee</p>
            </div>
            <p class="text-green-400 font-bold">{{ fmt(yearOneNet) }}</p>
          </div>
          <div class="flex justify-between items-center p-4 bg-gray-950/50">
            <div>
              <p class="text-green-400 font-medium">✅ You keep — every year after</p>
              <p class="text-gray-600 text-xs">100% of savings, zero ongoing fees</p>
            </div>
            <p class="text-green-400 font-bold">{{ fmt(yearTwoPlus) }}<span class="text-gray-500 text-sm">/yr</span></p>
          </div>
          <div class="flex justify-between items-center p-4 bg-gray-950/50">
            <div>
              <p class="text-green-400 font-medium">🏆 5-year net savings</p>
              <p class="text-gray-600 text-xs">Total savings minus one-time fee</p>
            </div>
            <p class="text-green-400 font-bold text-xl">{{ fmt(fiveYearNet) }}</p>
          </div>
        </div>
      </div>

      <!-- CTA -->
      <div class="text-center">
        <NuxtLink
          to="/book?c=calculate-savings"
          class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg"
        >
          🗓️ Book Your Free Intro Call
        </NuxtLink>
        <p class="text-gray-500 text-sm mt-3">15 min · free · no pitch deck 😏</p>
      </div>
    </div>

    <!-- Empty state -->
    <div v-else class="max-w-3xl mx-auto px-6 pb-12 text-center">
      <div class="bg-gray-900 rounded-xl border border-gray-800 p-12">
        <p class="text-4xl mb-4">☝️</p>
        <p class="text-gray-400">Enter your monthly AWS spend above to see your annualized bill and estimated savings.</p>
      </div>
    </div>

    <!-- Footer -->
    <div class="max-w-2xl mx-auto px-6 py-12 text-center">
      <div class="flex flex-wrap items-center justify-center gap-4 text-sm text-gray-600 mb-4">
        <NuxtLink to="/give-david-access" class="text-brand-400 hover:underline">🔧 Grant Access</NuxtLink>
        <span>·</span>
        <NuxtLink to="/" class="hover:text-gray-400 transition-colors">← cutmyaws.com</NuxtLink>
      </div>
      <p class="text-gray-600 text-xs">
        Questions? <a href="mailto:david@cutmyaws.com" class="text-brand-400 hover:underline">david@cutmyaws.com</a>
      </p>
    </div>
  </div>
</template>
