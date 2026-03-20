<script setup>
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

const annualSpend = props.awsMonthly * 12
const annualSavings = Math.round(annualSpend * props.wastePct / 100)
</script>

<template>
  <section>
    <div class="max-w-3xl mx-auto px-6 py-16 text-center">
      <h2 class="text-2xl font-bold mb-2">The math on a typical government agency 🧮</h2>
      <p class="text-gray-500 text-sm mb-8">${{ (awsMonthly / 1000).toFixed(0) }}K/mo AWS spend · {{ wastePct }}% waste found</p>
      <div class="grid sm:grid-cols-3 gap-6">
        <a href="#book" class="bg-gray-950 border border-gray-800 rounded-2xl p-6 block hover:border-brand-500/50 transition-colors">
          <p class="text-green-400 text-3xl font-bold">${{ (annualSavings / 1000).toFixed(0) }}K</p>
          <p class="text-gray-500 text-sm mt-2">Annual savings found</p>
        </a>
        <a href="#book" class="bg-gray-950 border border-gray-800 rounded-2xl p-6 block hover:border-brand-500/50 transition-colors">
          <p class="text-brand-400 text-3xl font-bold">% of savings</p>
          <p class="text-gray-500 text-sm mt-2">You only pay a percentage of verified savings</p>
        </a>
        <a href="#book" class="bg-gray-950 border border-gray-800 rounded-2xl p-6 block hover:border-brand-500/50 transition-colors">
          <p class="text-green-400 text-3xl font-bold">${{ (annualSavings / 1000).toFixed(0) }}K</p>
          <p class="text-gray-500 text-sm mt-2">Returned to the mission — every year 🏛️</p>
        </a>
      </div>
      <p class="text-gray-600 text-xs mt-6">Free audit · No savings = no fee · Savings repeat every year</p>
    </div>
  </section>
</template>
