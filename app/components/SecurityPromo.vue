<script setup>
const { promoActive, promoDaysLeft, pricing } = usePricing()
</script>

<template>
  <section v-if="promoActive" class="max-w-3xl mx-auto px-6 py-12 text-center">
    <div class="bg-brand-500/10 border border-brand-500/30 rounded-2xl p-8">
      <p class="text-2xl mb-3">🛡️</p>
      <h3 class="text-xl font-bold mb-2">FREE Security Audit</h3>
      <p class="text-gray-400 text-sm mb-2">Normally {{ pricing.securityPct }}% of AWS annual spend. Free for the next {{ promoDaysLeft }} day{{ promoDaysLeft === 1 ? '' : 's' }}.</p>
      <p class="text-gray-500 text-xs">Misconfigs, public S3 buckets, overprivileged IAM roles — the stuff that keeps CISOs up at night.</p>
    </div>
  </section>
</template>
