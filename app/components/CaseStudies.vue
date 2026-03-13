<script setup>
const caseStudies = [
  {
    title: 'EC2 → Microservices: 30% Cloud Savings Across 3 State Exchanges',
    client: 'DC Health Link, MA Health Connector & more',
    industry: 'Government Healthcare (ACA)',
    stats: [
      { value: '30%', label: 'Cost reduction' },
      { value: '6', label: 'AWS accounts' },
      { value: '10 yrs', label: 'Engagement' },
    ],
    tags: ['Lambda', 'ECS', 'EKS', 'HIPAA', 'Microservices'],
    href: '/case-study-dcgov.html',
  },
]

function trackOpen(study) {
  const { trackEvent } = useTracking()
  trackEvent('case_study_open', { event_category: 'engagement', event_label: study.title })
}
</script>

<template>
  <div class="max-w-5xl mx-auto px-6 py-24">
    <h2 class="text-3xl font-bold mb-2 text-center">📋 Case Studies</h2>
    <p class="text-gray-400 text-center mb-12 max-w-2xl mx-auto">Real engagements. Real savings. Real architecture changes.</p>

    <div class="max-w-3xl mx-auto space-y-6">
      <a
        v-for="study in caseStudies"
        :key="study.title"
        :href="study.href"
        target="_blank"
        rel="noopener"
        class="block bg-gray-900 border border-gray-800 rounded-2xl p-6 sm:p-8 hover:border-brand-500 transition-colors group"
        @click="trackOpen(study)"
      >
        <div class="flex items-center justify-between mb-3">
          <span class="text-xs font-bold text-brand-400 uppercase tracking-wider">{{ study.industry }}</span>
          <span class="text-gray-600 text-xs group-hover:text-gray-400 transition-colors">Open ↗</span>
        </div>

        <h3 class="text-xl font-bold mb-2 group-hover:text-brand-400 transition-colors">{{ study.title }}</h3>
        <p class="text-gray-500 text-sm mb-4">{{ study.client }}</p>

        <!-- Stats -->
        <div class="flex gap-6 mb-4">
          <div v-for="stat in study.stats" :key="stat.label" class="text-center">
            <p class="text-green-400 text-xl font-bold">{{ stat.value }}</p>
            <p class="text-gray-600 text-xs">{{ stat.label }}</p>
          </div>
        </div>

        <!-- Tags -->
        <div class="flex flex-wrap gap-2">
          <span
            v-for="tag in study.tags"
            :key="tag"
            class="text-xs font-semibold text-brand-400 bg-brand-500/10 border border-brand-500/20 px-3 py-1 rounded-full"
          >{{ tag }}</span>
        </div>
      </a>
    </div>
  </div>
</template>
