<script setup>
const { pricing, calculateExample } = usePricing()

const props = defineProps({
  awsMonthly: {
    type: Number,
    required: true,
  },
  wastePct: {
    type: Number,
    required: true,
  },
})

const ex = calculateExample(props.awsMonthly, props.wastePct)
</script>

<template>
  <section>
    <div class="max-w-3xl mx-auto px-6 py-16 text-center">
      <h2 class="text-2xl font-bold mb-2">The math on a typical government agency 🧮</h2>
      <p class="text-gray-500 text-sm mb-8">${{ (awsMonthly / 1000).toFixed(0) }}K/mo AWS spend · {{ wastePct }}% waste found</p>
      <div class="grid sm:grid-cols-3 gap-6">
        <a href="#book" class="bg-gray-950 border border-gray-800 rounded-2xl p-6 block hover:border-brand-500/50 transition-colors">
          <p class="text-green-400 text-3xl font-bold">${{ (ex.annualSavings / 1000).toFixed(0) }}K</p>
          <p class="text-gray-500 text-sm mt-2">Annual savings found</p>
        </a>
        <a href="#book" class="bg-gray-950 border border-gray-800 rounded-2xl p-6 block hover:border-brand-500/50 transition-colors">
          <p class="text-brand-400 text-3xl font-bold">${{ (ex.totalFee / 1000).toFixed(0) }}K</p>
          <p class="text-gray-500 text-sm mt-2">Max total fee ({{ pricing.fixedPct }}%)</p>
        </a>
        <a href="#book" class="bg-gray-950 border border-gray-800 rounded-2xl p-6 block hover:border-brand-500/50 transition-colors">
          <p class="text-green-400 text-3xl font-bold">${{ (ex.annualSavings / 1000).toFixed(0) }}K</p>
          <p class="text-gray-500 text-sm mt-2">Returned to the mission — every year 🏛️</p>
        </a>
      </div>
      <p class="text-gray-600 text-xs mt-6">Year 1 net: ${{ (ex.yearOneNet / 1000).toFixed(0) }}K kept · Year 2+: full ${{ (ex.annualSavings / 1000).toFixed(0) }}K/yr goes straight to your budget</p>
    </div>
  </section>
</template>
