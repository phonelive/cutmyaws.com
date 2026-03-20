<script setup>
import { ref, computed } from 'vue'

useHead({
  title: 'Calculate Your Annualized AWS Bill — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})

// === Date range calculation ===
// We only use finalized monthly AWS bills — no partial or estimated data.
// - The current month is always excluded (it's incomplete).
// - If we're less than 72 hours into the current month, we also exclude the
//   previous month — AWS can take up to 72 hours to finalize billing data.
const now = new Date()
const firstOfMonth = new Date(now.getFullYear(), now.getMonth(), 1)
const hoursIntoMonth = (now.getTime() - firstOfMonth.getTime()) / (1000 * 60 * 60)
const lastMonthFinalized = hoursIntoMonth >= 72

// API end date (exclusive) — 1st of current month, or 1 month earlier if last month isn't finalized yet
const apiEnd = lastMonthFinalized
  ? new Date(now.getFullYear(), now.getMonth(), 1)
  : new Date(now.getFullYear(), now.getMonth() - 1, 1)
// 3 months before the end
const apiStart = new Date(apiEnd.getFullYear(), apiEnd.getMonth() - 3, 1)

// Display labels
const fmtMonthYear = (d) => d.toLocaleDateString('en-US', { month: 'short', year: 'numeric' })
const lastIncludedMonth = new Date(apiEnd.getFullYear(), apiEnd.getMonth() - 1, 1)
const dateRangeLabel = `${fmtMonthYear(apiStart)} – ${fmtMonthYear(lastIncludedMonth)}`
const skippedMonthLabel = !lastMonthFinalized
  ? new Date(now.getFullYear(), now.getMonth() - 1, 1).toLocaleDateString('en-US', { month: 'long', year: 'numeric' })
  : null

// Generate 3 month input slots
const months = ref(
  Array.from({ length: 3 }, (_, i) => {
    const d = new Date(apiStart.getFullYear(), apiStart.getMonth() + i, 1)
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

const average = computed(() => {
  if (filledMonths.value.length === 0) return 0
  return Math.round(filledMonths.value.reduce((sum, m) => sum + m.amount, 0) / filledMonths.value.length)
})

const annualizedSpend = computed(() => average.value * 12)

// Savings tiers
const tiers = [
  { key: 'conservative', label: 'Conservative', pct: 20 },
  { key: 'average', label: 'Average', pct: 35 },
  { key: 'aggressive', label: 'Aggressive', pct: 50 },
]
const selectedTier = ref('average')
const tierSavings = (pct) => Math.round(annualizedSpend.value * pct / 100)
const selectedSavings = computed(() => {
  const tier = tiers.find(t => t.key === selectedTier.value)
  return tierSavings(tier.pct)
})
const selectedPct = computed(() => tiers.find(t => t.key === selectedTier.value).pct)

// Pricing breakdown (mirrors usePricing.ts)
const fixedPct = 75
const depositPct = 4

const depositFee = computed(() => Math.round(annualizedSpend.value * depositPct / 100))
const totalFee = computed(() => Math.round(selectedSavings.value * fixedPct / 100))
const yearOneNet = computed(() => selectedSavings.value - totalFee.value)
const yearTwoPlus = computed(() => selectedSavings.value)
const fiveYearNet = computed(() => (selectedSavings.value * 5) - totalFee.value)

function fmt(n) {
  return '$' + n.toLocaleString()
}

function clear() {
  months.value.forEach(m => { m.amount = null })
}

const hasData = computed(() => filledMonths.value.length >= 1)
const hasEnoughData = computed(() => filledMonths.value.length >= 3)
const minMonthly = 5000
const meetsMinimum = computed(() => average.value >= minMonthly)

// CLI script — single source of truth for display and copy.
// The script calculates its own dates dynamically, pulls monthly costs,
// and computes the annualized spend (3-month avg × 12).
const cliScript = `#!/bin/bash
# ✂️  CutMyAWS — How Much Is AWS Charging You?
# Usage: bash get-aws-bills.sh [--profile your-profile]
#
# Pulls your last 3 finalized monthly AWS bills, averages
# them, and tells you what AWS is collecting per year.
#
# Only uses finalized bills — no guesswork:
#   - Current (incomplete) month? Skipped.
#   - Month just ended < 72h ago? Also skipped.
#     AWS needs time to finalize. We wait. ⏳
#
# Formula: (3-month avg) × 12 = annualized spend

set -euo pipefail

PROFILE_FLAG=""
if [[ "\${1:-}" == "--profile" && -n "\${2:-}" ]]; then
  PROFILE_FLAG="--profile \${2}"
fi

# --- Calculate date range ---
YEAR=$(date +%Y); MONTH=$((10#$(date +%m)))
DAY=$((10#$(date +%d))); HOUR=$((10#$(date +%H)))
HOURS_INTO_MONTH=$(( (DAY - 1) * 24 + HOUR ))

END_Y=$YEAR; END_M=$MONTH
if [ "$HOURS_INTO_MONTH" -lt 72 ]; then
  END_M=$((END_M - 1))
  [ "$END_M" -lt 1 ] && { END_M=12; END_Y=$((END_Y - 1)); }
  echo "⏳ Month just flipped — skipping last month (AWS is still counting)"
fi
END_DATE=$(printf "%04d-%02d-01" "$END_Y" "$END_M")

START_M=$((END_M - 3)); START_Y=$END_Y
while [ "$START_M" -lt 1 ]; do
  START_M=$((START_M + 12)); START_Y=$((START_Y - 1))
done
START_DATE=$(printf "%04d-%02d-01" "$START_Y" "$START_M")

echo ""
echo "✂️  CutMyAWS — Annualized AWS Spend Calculator"
echo "📅 $START_DATE → $END_DATE (last 3 finalized months)"
echo ""

# --- Format number with commas ---
commas() { printf "%'d" "$1"; }

# --- Pull monthly costs ---
COSTS=$(aws ce get-cost-and-usage \\
  --time-period Start="$START_DATE",End="$END_DATE" \\
  --granularity MONTHLY \\
  --metrics UnblendedCost \\
  --query 'ResultsByTime[].[TimePeriod.Start,Total.UnblendedCost.Amount]' \\
  --output text \\
  $PROFILE_FLAG)

# --- The damage report ---
echo "=== 💸 Last 3 Monthly AWS Bills ==="
echo "Month       | Total"
echo "------------|------------"
echo "$COSTS" | while IFS=$'\\t' read -r month amount; do
  printf "%-11s | \\$%s\\n" "\${month:0:7}" "$(commas "\${amount%%.*}")"
done

# --- Annualized: 3-month avg × 12 ---
AVG=$(echo "$COSTS" | awk -F'\\t' '{s+=$2;n++} END{avg=int(s/n+0.5); printf "%d",avg}')
ANNUAL=$((AVG * 12))
DEPOSIT=$(( (ANNUAL * 4 + 50) / 100 ))

echo ""
echo "=== 📊 Annualized Spend ==="
echo "3-month avg: \\$$(commas $AVG)/mo"
echo "Annualized:  \\$$(commas $ANNUAL)/yr (avg × 12)"

echo ""
if [ "$AVG" -lt 5000 ]; then
  echo "=== 🤔 The Verdict ==="
  echo "At \\$$(commas $AVG)/mo, your bill is probably too lean for us"
  echo "to find meaningful savings. That's actually a good thing —"
  echo "it means you (or someone on your team) isn't asleep at the"
  echo "wheel. 👏"
  echo ""
  echo "CutMyAWS works best with \\$5K+/mo in AWS spend, where the"
  echo "cobwebs really start to pile up. If you have other AWS"
  echo "accounts or your spend is growing, reach out — we're happy"
  echo "to take a look."
  echo ""
  echo "👉 https://cutmyaws.com"
else
  echo "=== 🎯 Next Steps ==="
  echo "At \\$$(commas $AVG)/mo, there's almost certainly money hiding"
  echo "in this account. Most businesses at this level are overpaying"
  echo "AWS by 30-40% without realizing it. 😅"
  echo ""
  echo "To kick things off, 4% of your annualized spend is"
  echo "\\$$(commas $DEPOSIT) — that gets the engagement started."
  echo ""
  echo "👉 https://cutmyaws.com"
fi`

const copied = ref(false)
async function copyCliCommand() {
  await navigator.clipboard.writeText(cliScript)
  copied.value = true
  setTimeout(() => { copied.value = false }, 2000)
}
</script>

<template>
  <div>
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
              <p class="text-gray-300 font-medium">Pull the last 3 finalized monthly AWS bills</p>
              <p class="text-gray-500 text-sm">We only use finalized monthly bills. The current month is always excluded (it's incomplete), and if a month just ended, we wait up to 72 hours for AWS to finalize the data before including it. No estimates, only real numbers. 📅</p>
            </div>
          </div>
          <div class="flex items-start gap-4">
            <span class="bg-brand-500/20 text-brand-400 font-bold w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-sm">2</span>
            <div>
              <p class="text-gray-300 font-medium">Average them, then multiply by 12</p>
              <p class="text-gray-500 text-sm">That's your annualized spend. Same formula before and after — so savings are apples to apples. Simple math, honest number. No tricks. 🍎</p>
            </div>
          </div>
        </div>
        <div class="mt-5 bg-gray-950 rounded-lg p-4 text-center">
          <p class="text-gray-500 text-sm mb-1">Formula</p>
          <p class="text-lg font-mono text-gray-200">
            <span class="text-brand-400">(3-month avg)</span> × 12 = <span class="text-brand-400">annualized spend</span>
          </p>
        </div>
        <!-- Not-yet-finalized notice -->
        <div v-if="!lastMonthFinalized" class="mt-4 bg-yellow-500/10 border border-yellow-500/30 rounded-lg p-3 text-sm">
          <p class="text-yellow-400">⏳ {{ skippedMonthLabel }} is excluded — AWS billing data can take up to 72 hours to finalize. We only use finalized bills.</p>
        </div>
        <!-- Date range -->
        <p class="text-gray-600 text-xs mt-4 text-center">Currently using: <strong class="text-gray-400">{{ dateRangeLabel }}</strong> (3 months)</p>
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
        <p class="text-gray-500 text-sm mb-4">Save this as <code class="text-brand-300 text-xs">get-aws-bills.sh</code> and run it. It pulls the last 3 finalized months and calculates your annualized spend automatically. Enter the monthly totals below for the interactive breakdown.</p>
        <div class="bg-gray-950 rounded-lg p-4 font-mono text-sm text-gray-300 overflow-x-auto">
          <pre v-text="cliScript"></pre>
        </div>
        <div class="mt-3 space-y-1">
          <p class="text-gray-600 text-xs">💡 Requires the AWS CLI and billing access. Use <code class="text-gray-400">--profile your-profile</code> if you have named profiles. For Organizations, run from the <strong>management account</strong>.</p>
          <p class="text-gray-600 text-xs">📅 Dates are calculated dynamically — the script always pulls the correct 3-month window using only finalized monthly bills.</p>
        </div>
      </div>
    </div>

    <!-- Monthly input grid (3 months) -->
    <div class="max-w-3xl mx-auto px-6 pb-8">
      <div class="flex items-center justify-between mb-4">
        <div>
          <h2 class="text-lg font-bold">💰 Enter Monthly Totals</h2>
          <p class="text-gray-600 text-xs mt-1">{{ dateRangeLabel }} · last 3 finalized months</p>
        </div>
        <button @click="clear" class="text-gray-600 text-sm hover:text-gray-400 transition-colors">Clear all</button>
      </div>
      <div class="grid grid-cols-3 gap-3">
        <div
          v-for="(month, i) in months"
          :key="i"
          class="rounded-lg border p-3 transition-colors bg-gray-900 border-gray-800"
        >
          <label class="text-gray-500 text-xs mb-1 block">{{ month.label }}</label>
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
        <span v-if="!hasEnoughData && hasData">Enter all 3 months to calculate. {{ 3 - filledMonths.length }} more needed.</span>
        <span v-else-if="hasEnoughData">Average of all 3 months × 12 = your annualized spend.</span>
        <span v-else>Enter your monthly AWS totals from the CLI output above.</span>
      </p>
    </div>

    <!-- Results (need at least 3 months) -->
    <div v-if="hasEnoughData" class="max-w-3xl mx-auto px-6 pb-12">

      <!-- Calculation breakdown -->
      <div class="bg-gray-900 rounded-xl border border-gray-800 p-6 mb-8">
        <h2 class="text-lg font-bold mb-4">📊 Your Annualized Spend</h2>
        <div class="space-y-3">
          <div v-for="m in filledMonths" :key="m.label" class="flex justify-between items-center text-sm">
            <span class="text-gray-400"><strong class="text-gray-200">{{ m.label }}</strong></span>
            <span class="text-gray-200 font-mono">{{ fmt(m.amount) }}</span>
          </div>
          <div class="border-t border-gray-800 pt-3 flex justify-between items-center text-sm">
            <span class="text-gray-400">3-month average</span>
            <span class="text-gray-200 font-mono font-bold">{{ fmt(average) }}/mo</span>
          </div>
          <div class="flex justify-between items-center">
            <span class="text-gray-400 font-medium">Annualized spend (× 12)</span>
            <span class="text-brand-400 font-bold text-xl font-mono">{{ fmt(annualizedSpend) }}/yr</span>
          </div>
        </div>
      </div>

      <!-- Under $5K/mo — probably too lean -->
      <template v-if="!meetsMinimum">
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-8 mb-8 text-center">
          <p class="text-4xl mb-4">👏</p>
          <h2 class="text-xl font-bold mb-3">Your bill is looking pretty lean</h2>
          <p class="text-gray-400 mb-4">At <strong class="text-gray-200">{{ fmt(average) }}/mo</strong>, there probably isn't enough waste hiding in this account for an engagement to make sense. That's actually a good thing — it means somebody's been paying attention. 😏</p>
          <p class="text-gray-500 text-sm mb-6">CutMyAWS works best with $5K+/mo in AWS spend, where the cobwebs really start to pile up. If you have other accounts or your spend is growing, we're always happy to take a look.</p>
          <NuxtLink
            to="/"
            class="inline-block bg-gray-800 hover:bg-gray-700 text-gray-200 font-semibold px-6 py-3 rounded-xl transition-colors"
          >
            ✂️ Learn more at cutmyaws.com
          </NuxtLink>
        </div>
      </template>

      <!-- Over $5K/mo — full breakdown -->
      <template v-else>
        <!-- Summary cards -->
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-8">
          <div class="bg-gray-900 rounded-xl border border-gray-800 p-5 text-center">
            <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">3-Month Average</p>
            <p class="text-2xl font-bold text-gray-100">{{ fmt(average) }}</p>
            <p class="text-gray-600 text-xs mt-1">per month</p>
          </div>
          <div class="bg-gray-900 rounded-xl border-2 border-brand-500 p-5 text-center">
            <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">Annualized Spend</p>
            <p class="text-2xl font-bold text-brand-400">{{ fmt(annualizedSpend) }}</p>
            <p class="text-gray-600 text-xs mt-1">{{ fmt(average) }} × 12</p>
          </div>
          <div class="bg-gray-900 rounded-xl border border-gray-800 p-5 text-center">
            <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">{{ depositPct }}% Deposit to Start</p>
            <p class="text-2xl font-bold text-gray-100">{{ fmt(depositFee) }}</p>
            <p class="text-gray-600 text-xs mt-1">Deducted from your total fee</p>
          </div>
        </div>

        <!-- Savings estimates (clickable) -->
        <h2 class="text-lg font-bold mb-4">📉 Estimated Savings Range <span class="text-gray-500 text-sm font-normal">— click to update pricing below</span></h2>
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-8">
          <button
            v-for="tier in tiers"
            :key="tier.key"
            @click="selectedTier = tier.key"
            class="rounded-xl p-5 text-left transition-all cursor-pointer"
            :class="selectedTier === tier.key
              ? 'bg-gray-900 border-2 border-green-500/50 ring-1 ring-green-500/20'
              : 'bg-gray-900 border border-gray-800 hover:border-gray-700'"
          >
            <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">{{ tier.label }} ({{ tier.pct }}%)</p>
            <p class="text-xl font-bold text-green-400">{{ fmt(tierSavings(tier.pct)) }}<span class="text-gray-500 text-sm">/yr</span></p>
            <p class="text-gray-600 text-xs mt-1">{{ fmt(Math.round(tierSavings(tier.pct) / 12)) }}/mo</p>
          </button>
        </div>

        <!-- Pricing breakdown (using selected tier) -->
        <h2 class="text-lg font-bold mb-4">💰 Pricing Breakdown <span class="text-gray-500 text-sm font-normal">(at {{ selectedPct }}% savings)</span></h2>
        <div class="bg-gray-900 rounded-xl border border-gray-800 overflow-hidden mb-8">
          <div class="divide-y divide-gray-800">
            <div class="flex justify-between items-center p-4">
              <div>
                <p class="text-gray-300 font-medium">💳 Deposit ({{ depositPct }}% of AWS annual spend)</p>
                <p class="text-gray-600 text-xs">Deducted from total fee</p>
              </div>
              <p class="text-gray-100 font-bold">{{ fmt(depositFee) }}</p>
            </div>
            <div class="flex justify-between items-center p-4">
              <div>
                <p class="text-gray-300 font-medium">✂️ Total fee ({{ fixedPct }}% if all savings fixed)</p>
                <p class="text-gray-600 text-xs">Audit + implementation + 90-day verification</p>
              </div>
              <p class="text-gray-100 font-bold">{{ fmt(totalFee) }}</p>
            </div>
            <div class="flex justify-between items-center p-4 bg-gray-950/50">
              <div>
                <p class="text-green-400 font-medium">✅ You keep — year 1</p>
                <p class="text-gray-600 text-xs">{{ fmt(selectedSavings) }} savings - {{ fmt(totalFee) }} fee</p>
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
          <a
            href="#book"
            class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg"
          >
            🗓️ Book a Free 15-Min Chat
          </a>
          <p class="text-gray-500 text-sm mt-3">15 min · free · no pitch deck 😏</p>
        </div>
      </template>
    </div>

    <!-- Empty state / not enough data -->
    <div v-else class="max-w-3xl mx-auto px-6 pb-12 text-center">
      <div class="bg-gray-900 rounded-xl border border-gray-800 p-12">
        <p class="text-4xl mb-4">{{ hasData ? '✌️' : '☝️' }}</p>
        <p class="text-gray-400" v-if="hasData">Enter at least <strong class="text-gray-200">3 months</strong> to calculate. {{ 3 - filledMonths.length }} more needed.</p>
        <p class="text-gray-400" v-else>Enter your monthly AWS totals above. Run the CLI command to get them quickly.</p>
      </div>
    </div>

    <!-- Calendly Embed -->
    <section id="book-section">
      <CalendlyEmbed campaign="calculate-savings" />
    </section>

  </div>
</template>
