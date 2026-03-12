<script setup>
useHead({
  title: 'Client Onboarding — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})
</script>

<template>
  <div>
    <!-- Header -->
    <div class="max-w-3xl mx-auto px-6 pt-12 sm:pt-16 pb-8 text-center">
      <h1 class="text-2xl sm:text-3xl font-bold mb-3">📋 Client Onboarding</h1>
      <p class="text-gray-400 mb-2">Two quick steps to kick off your AWS audit.</p>
      <p class="text-gray-500 text-sm">Both take about 5 minutes each. Let's get started. 🚀</p>
    </div>

    <!-- Cards -->
    <div class="max-w-3xl mx-auto px-6 pb-16">
      <div class="grid gap-6 sm:grid-cols-2">

        <!-- Calculate Savings -->
        <NuxtLink
          to="/onboarding/calculate-savings"
          class="group bg-gray-900 border border-gray-800 rounded-2xl p-8 hover:border-brand-500 transition-colors"
        >
          <div class="text-4xl mb-4">🧮</div>
          <h2 class="text-xl font-bold mb-2 group-hover:text-brand-400 transition-colors">Calculate Your Savings</h2>
          <p class="text-gray-400 text-sm mb-4">Enter your last 3 AWS bills and I'll estimate your annualized spend and potential savings.</p>
          <span class="text-brand-400 text-sm font-medium">Get started →</span>
        </NuxtLink>

        <!-- Grant Access -->
        <NuxtLink
          to="/onboarding/give-david-access"
          class="group bg-gray-900 border border-gray-800 rounded-2xl p-8 hover:border-brand-500 transition-colors"
        >
          <div class="text-4xl mb-4">🔧</div>
          <h2 class="text-xl font-bold mb-2 group-hover:text-brand-400 transition-colors">Grant AWS Access</h2>
          <p class="text-gray-400 text-sm mb-4">Deploy a read-only IAM role so I can audit your account. Takes ~5 minutes. Fully revocable.</p>
          <span class="text-brand-400 text-sm font-medium">Set up access →</span>
        </NuxtLink>

      </div>
    </div>

  </div>
</template>
