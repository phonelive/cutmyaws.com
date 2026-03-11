<script setup>
import { onMounted } from 'vue'
import { useRoute } from 'vue-router'

useHead({
  title: 'Book Your Free Intro Call — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})

const route = useRoute()
const campaign = route.query.c || 'book'

const calendlyUrl = `https://calendly.com/phonelivestreaming/cutmyaws-com-intro?utm_source=cutmyaws&utm_medium=website&utm_campaign=${campaign}&hide_gdpr_banner=1&background_color=030712&text_color=f3f4f6&primary_color=f97316`

onMounted(() => {
  const script = document.createElement('script')
  script.src = 'https://assets.calendly.com/assets/external/widget.js'
  script.async = true
  document.head.appendChild(script)
})
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
        <p class="text-gray-500 text-sm hidden sm:block">15 min &middot; free &middot; no pitch deck 😏</p>
      </div>
    </nav>

    <!-- Calendly embed -->
    <div class="max-w-4xl mx-auto px-4 pt-8 pb-4 text-center">
      <h1 class="text-2xl sm:text-3xl font-bold mb-2">🗓️ Book Your Free Intro Call</h1>
      <p class="text-gray-400 mb-6">Pick a time. 15 minutes. Just a real conversation about your AWS bill.</p>
    </div>

    <div
      class="calendly-inline-widget mx-auto"
      :data-url="calendlyUrl"
      style="min-width: 320px; width: 100%; height: 700px;"
    ></div>

    <!-- Trust bar -->
    <div class="max-w-2xl mx-auto px-6 py-12 text-center">
      <div class="flex flex-col sm:flex-row items-center justify-center gap-6 text-sm text-gray-500">
        <span>✅ No pitch deck</span>
        <span>✅ No commitment</span>
        <span>✅ No savings = no fee</span>
      </div>
      <p class="text-gray-600 text-xs mt-4">
        Questions? <a href="mailto:david@cutmyaws.com" class="text-brand-400 hover:underline">david@cutmyaws.com</a>
      </p>
    </div>
  </div>
</template>
