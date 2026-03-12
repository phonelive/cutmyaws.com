<script setup>
import { ref, computed } from 'vue'

useHead({
  title: 'Calculate Your Annualized AWS Bill — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})

// Generate last 18 month labels
const now = new Date()
const months = ref(
  Array.from({ length: 18 }, (_, i) => {
    const d = new Date(now.getFullYear(), now.getMonth() - 17 + i, 1)
    return {
      label: d.toLocaleDateString('en-US', { month: 'short', year: 'numeric' }),
      amount: null,
    }
  })
)

const filledMonths = computed(() =>
  months.value
    .filter(m => m.amount !== null && m.amount !== '' && !isNaN(m.amount))
    .map(m => ({ ...m, amount: Number(m.amount) }))
)

// Top 3 highest months
const top3 = computed(() =>
  [...filledMonths.value]
    .sort((a, b) => b.amount - a.amount)
    .slice(0, 3)
)

const top3Average = computed(() => {
  if (top3.value.length === 0) return 0
  return Math.round(top3.value.reduce((sum, m) => sum + m.amount, 0) / top3.value.length)
})

const annualizedSpend = computed(() => top3Average.value * 12)

// Is a month in the top 3?
function isTop3(month) {
  return top3.value.some(t => t.label === month.label)
}

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
const hasEnoughData = computed(() => filledMonths.value.length >= 3)

// CLI command with dynamic dates
const cliStartDate = computed(() => {
  const d = new Date(now.getFullYear(), now.getMonth() - 17, 1)
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-01`
})
const cliEndDate = computed(() => {
  const d = new Date(now.getFullYear(), now.getMonth() + 1, 1)
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-01`
})

const copied = ref(false)
async function copyCliCommand() {
  const cmd = `#!/bin/bash
# CutMyAWS — Pull last 18 months of AWS bills
# Run: bash get-aws-bills.sh [--profile your-profile]

PROFILE_FLAG=""
if [[ "\${1}" == "--profile" && -n "\${2}" ]]; then
  PROFILE_FLAG="--profile \${2}"
fi

aws ce get-cost-and-usage \\
  --time-period Start=${cliStartDate.value},End=${cliEndDate.value} \\
  --granularity MONTHLY \\
  --metrics UnblendedCost \\
  --query 'ResultsByTime[].{Month:TimePeriod.Start,Total:Total.UnblendedCost.Amount}' \\
  --output table \\
  \$PROFILE_FLAG`
  await navigator.clipboard.writeText(cmd)
  copied.value = true
  setTimeout(() => { copied.value = false }, 2000)
}
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
        <NuxtLink to="/onboarding/give-david-access" class="text-gray-500 text-sm hover:text-gray-300 transition-colors hidden sm:block">
          🔧 Grant Access →
        </NuxtLink>
      </div>
    </nav>

    <!-- Header -->
    <div class="max-w-3xl mx-auto px-6 pt-12 sm:pt-16 pb-8 text-center">
      <h1 class="text-2xl sm:text-3xl font-bold mb-3">🧮 Calculate Your Annualized AWS Bill</h1>
      <p class="text-gray-400 mb-2">This is how I calculate your annualized AWS spend for pricing.</p>
      <p class="text-gray-500 text-sm">Used to determine the {{ depositPct }}% deposit and estimate your savings. 📊</p>
    </div>

    <!-- How it's calculated -->
    <div class="max-w-3xl mx-auto px-6 pb-8">
      <div class="bg-gray-900 rounded-xl border border-gray-800 p-6">
        <h2 class="text-lg font-bold mb-4">📐 The Formula</h2>
        <div class="space-y-4">
          <div class="flex items-start gap-4">
            <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">1</span>
            <div>
              <p class="text-gray-300 font-medium">Pull the last 18 months of total AWS bills</p>
              <p class="text-gray-500 text-sm">This captures seasonal variation, growth trends, and any one-off spikes.</p>
            </div>
          </div>
          <div class="flex items-start gap-4">
            <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">2</span>
            <div>
              <p class="text-gray-300 font-medium">Take the 3 highest months</p>
              <p class="text-gray-500 text-sm">Your bill trends up over time. Using the highest 3 reflects where your spend actually is today — not where it was a year ago. 📈</p>
            </div>
          </div>
          <div class="flex items-start gap-4">
            <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">3</span>
            <div>
              <p class="text-gray-300 font-medium">Average those 3, then multiply by 12</p>
              <p class="text-gray-500 text-sm">That's your annualized spend. Simple math, honest number. No tricks.</p>
            </div>
          </div>
        </div>
        <div class="mt-5 bg-gray-950 rounded-lg p-4 text-center">
          <p class="text-gray-500 text-sm mb-1">Formula</p>
          <p class="text-lg font-mono text-gray-200">
            <span class="text-brand-400">(top 3 months avg)</span> × 12 = <span class="text-brand-400">annualized spend</span>
          </p>
        </div>
      </div>
    </div>

    <!-- CLI command -->
    <div class="max-w-3xl mx-auto px-6 pb-8">
      <div class="bg-gray-900 rounded-xl border border-gray-800 p-6">
        <div class="flex items-center justify-between mb-3">
          <h2 class="text-lg font-bold">💻 Get Your Bills via CLI</h2>
          <button
            @click="copyCliCommand"
            class="text-sm px-3 py-1 rounded-lg transition-colors"
            :class="copied ? 'bg-green-500/20 text-green-400' : 'bg-gray-800 text-gray-400 hover:text-gray-200'"
          >
            {{ copied ? '✓ Copied!' : '📋 Copy' }}
          </button>
        </div>
        <p class="text-gray-500 text-sm mb-4">Save this as <code class="text-brand-300 text-xs">get-aws-bills.sh</code> and run it to get the last 18 months of bills. Then enter the totals below.</p>
        <div class="bg-gray-950 rounded-lg p-4 font-mono text-sm text-gray-300 overflow-x-auto">
          <pre>#!/bin/bash
# CutMyAWS — Pull last 18 months of AWS bills
# Run: bash get-aws-bills.sh [--profile your-profile]

PROFILE_FLAG=""
if [[ "${1}" == "--profile" && -n "${2}" ]]; then
  PROFILE_FLAG="--profile ${2}"
fi

aws ce get-cost-and-usage \
  --time-period Start={{ cliStartDate }},End={{ cliEndDate }} \
  --granularity MONTHLY \
  --metrics UnblendedCost \
  --query 'ResultsByTime[].{Month:TimePeriod.Start,Total:Total.UnblendedCost.Amount}' \
  --output table \
  $PROFILE_FLAG</pre>
        </div>
        <p class="text-gray-600 text-xs mt-3">💡 Requires the AWS CLI and billing access. Use <code class="text-gray-400">--profile your-profile</code> if you have named profiles. For Organizations, run from the <strong>management account</strong>.</p>
      </div>
    </div>

    <!-- Monthly input grid (18 months) -->
    <div class="max-w-3xl mx-auto px-6 pb-8">
      <div class="flex items-center justify-between mb-4">
        <h2 class="text-lg font-bold">💰 Enter Monthly Totals</h2>
        <button @click="clear" class="text-gray-600 text-sm hover:text-gray-400 transition-colors">Clear all</button>
      </div>
      <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-6 gap-3">
        <div
          v-for="(month, i) in months"
          :key="i"
          class="rounded-lg border p-3 transition-colors"
          :class="hasEnoughData && isTop3(month) ? 'bg-brand-500/10 border-brand-500/50' : 'bg-gray-900 border-gray-800'"
        >
          <div class="flex items-center justify-between mb-1">
            <label class="text-gray-500 text-xs">{{ month.label }}</label>
            <span v-if="hasEnoughData && isTop3(month)" class="text-brand-400 text-xs font-bold">TOP 3</span>
          </div>
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
      <p class="text-gray-600 text-xs mt-3">
        <span v-if="!hasEnoughData && hasData">Enter at least 3 months to calculate. {{ 3 - filledMonths.length }} more needed.</span>
        <span v-else-if="hasEnoughData">The <span class="text-brand-400 font-medium">3 highest months</span> are highlighted. Their average × 12 = your annualized spend.</span>
        <span v-else>Enter your monthly AWS totals from the CLI output above.</span>
      </p>
    </div>

    <!-- Results (need at least 3 months) -->
    <div v-if="hasEnoughData" class="max-w-3xl mx-auto px-6 pb-12">

      <!-- Calculation breakdown -->
      <div class="bg-gray-900 rounded-xl border border-gray-800 p-6 mb-8">
        <h2 class="text-lg font-bold mb-4">📊 Your Annualized Spend</h2>
        <div class="space-y-3">
          <div class="flex justify-between items-center text-sm">
            <span class="text-gray-400">Highest month: <strong class="text-gray-200">{{ top3[0]?.label }}</strong></span>
            <span class="text-gray-200 font-mono">{{ fmt(top3[0]?.amount || 0) }}</span>
          </div>
          <div class="flex justify-between items-center text-sm">
            <span class="text-gray-400">2nd highest: <strong class="text-gray-200">{{ top3[1]?.label }}</strong></span>
            <span class="text-gray-200 font-mono">{{ fmt(top3[1]?.amount || 0) }}</span>
          </div>
          <div v-if="top3[2]" class="flex justify-between items-center text-sm">
            <span class="text-gray-400">3rd highest: <strong class="text-gray-200">{{ top3[2]?.label }}</strong></span>
            <span class="text-gray-200 font-mono">{{ fmt(top3[2]?.amount || 0) }}</span>
          </div>
          <div class="border-t border-gray-800 pt-3 flex justify-between items-center text-sm">
            <span class="text-gray-400">Average of top 3</span>
            <span class="text-gray-200 font-mono font-bold">{{ fmt(top3Average) }}/mo</span>
          </div>
          <div class="flex justify-between items-center">
            <span class="text-gray-400 font-medium">Annualized spend (× 12)</span>
            <span class="text-brand-400 font-bold text-xl font-mono">{{ fmt(annualizedSpend) }}/yr</span>
          </div>
        </div>
      </div>

      <!-- Summary cards -->
      <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-8">
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-5 text-center">
          <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">Top 3 Average</p>
          <p class="text-2xl font-bold text-gray-100">{{ fmt(top3Average) }}</p>
          <p class="text-gray-600 text-xs mt-1">per month</p>
        </div>
        <div class="bg-gray-900 rounded-xl border-2 border-brand-500 p-5 text-center">
          <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">Annualized Spend</p>
          <p class="text-2xl font-bold text-brand-400">{{ fmt(annualizedSpend) }}</p>
          <p class="text-gray-600 text-xs mt-1">{{ fmt(top3Average) }} × 12</p>
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

    <!-- Empty state / not enough data -->
    <div v-else class="max-w-3xl mx-auto px-6 pb-12 text-center">
      <div class="bg-gray-900 rounded-xl border border-gray-800 p-12">
        <p class="text-4xl mb-4">{{ hasData ? '✌️' : '☝️' }}</p>
        <p class="text-gray-400" v-if="hasData">Enter at least <strong class="text-gray-200">3 months</strong> to calculate. {{ 3 - filledMonths.length }} more needed.</p>
        <p class="text-gray-400" v-else>Enter your monthly AWS totals above. Run the CLI command to get them quickly.</p>
      </div>
    </div>

    <!-- Footer -->
    <div class="max-w-2xl mx-auto px-6 py-12 text-center">
      <div class="flex flex-wrap items-center justify-center gap-4 text-sm text-gray-600 mb-4">
        <NuxtLink to="/onboarding/give-david-access" class="text-brand-400 hover:underline">🔧 Grant Access</NuxtLink>
        <span>·</span>
        <NuxtLink to="/" class="hover:text-gray-400 transition-colors">← cutmyaws.com</NuxtLink>
      </div>
      <p class="text-gray-600 text-xs">
        Questions? <a href="mailto:david@cutmyaws.com" class="text-brand-400 hover:underline">david@cutmyaws.com</a>
      </p>
    </div>
  </div>
</template>
