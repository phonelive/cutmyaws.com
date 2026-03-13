<script setup>
function trackOpen() {
  const { trackEvent } = useTracking()
  trackEvent('case_study_open', { event_category: 'engagement', event_label: 'dc-health-link' })
}
</script>

<template>
  <div class="max-w-5xl mx-auto px-6 py-24">
    <h2 class="text-3xl font-bold mb-2 text-center">📋 See It In Action</h2>
    <p class="text-gray-400 text-center mb-12 max-w-2xl mx-auto">10 years. 3 state healthcare exchanges. 6 AWS accounts. Here's the full story.</p>

    <a
      href="/case-study-dcgov.html"
      target="_blank"
      rel="noopener"
      class="block max-w-3xl mx-auto bg-gray-900 border-2 border-gray-800 rounded-2xl overflow-hidden hover:border-brand-500 transition-colors group"
      @click="trackOpen"
    >
      <!-- Top banner -->
      <div class="bg-brand-500/10 px-6 sm:px-8 py-3 flex items-center justify-between">
        <span class="text-xs font-bold text-brand-400 uppercase tracking-wider">Featured Case Study · Government Healthcare</span>
        <span class="text-gray-500 text-xs group-hover:text-brand-400 transition-colors">Read the full story ↗</span>
      </div>

      <div class="p-6 sm:p-8">
        <h3 class="text-2xl font-bold mb-2 group-hover:text-brand-400 transition-colors">EC2 → Microservices: 30% Cloud Savings Across 3 State Exchanges</h3>
        <p class="text-gray-400 text-sm mb-6">How David led DevOps for DC Health Link, the MA Health Connector, and more — migrating from monolithic EC2 to Lambda, ECS, and EKS while maintaining HIPAA compliance and 24/7 uptime.</p>

        <!-- Stats row -->
        <div class="grid grid-cols-3 gap-4 mb-6">
          <div class="bg-gray-950 border border-gray-800 rounded-xl p-4 text-center">
            <p class="text-green-400 text-2xl font-bold">30%</p>
            <p class="text-gray-600 text-xs mt-1">Cost reduction</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-xl p-4 text-center">
            <p class="text-green-400 text-2xl font-bold">6</p>
            <p class="text-gray-600 text-xs mt-1">AWS accounts</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-xl p-4 text-center">
            <p class="text-green-400 text-2xl font-bold">HIPAA</p>
            <p class="text-gray-600 text-xs mt-1">Full compliance</p>
          </div>
        </div>

        <!-- Tags -->
        <div class="flex flex-wrap gap-2">
          <span class="text-xs font-semibold text-brand-400 bg-brand-500/10 border border-brand-500/20 px-3 py-1 rounded-full">Lambda</span>
          <span class="text-xs font-semibold text-brand-400 bg-brand-500/10 border border-brand-500/20 px-3 py-1 rounded-full">ECS</span>
          <span class="text-xs font-semibold text-brand-400 bg-brand-500/10 border border-brand-500/20 px-3 py-1 rounded-full">EKS</span>
          <span class="text-xs font-semibold text-brand-400 bg-brand-500/10 border border-brand-500/20 px-3 py-1 rounded-full">HIPAA</span>
          <span class="text-xs font-semibold text-brand-400 bg-brand-500/10 border border-brand-500/20 px-3 py-1 rounded-full">Microservices</span>
          <span class="text-xs font-semibold text-brand-400 bg-brand-500/10 border border-brand-500/20 px-3 py-1 rounded-full">Cost Optimization</span>
        </div>
      </div>
    </a>
  </div>
</template>
