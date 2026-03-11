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

// Promo: free security scan — mirrors index.vue
const promoEnd = new Date('2026-04-04T23:59:59')
const now = new Date()
const promoActive = now < promoEnd
const promoDaysLeft = Math.max(0, Math.ceil((promoEnd.getTime() - now.getTime()) / (1000 * 60 * 60 * 24)))

const clients = [
  { name: 'Caterpillar', logo: '/logos/cat.svg' },
  { name: 'Best Buy', logo: '/logos/best-buy.svg' },
  { name: 'PBS', logo: '/logos/pbs.svg' },
  { name: 'DC Government', logo: '/logos/dc-gov.png' },
]

onMounted(() => {
  const script = document.createElement('script')
  script.src = 'https://assets.calendly.com/assets/external/widget.js'
  script.async = true
  document.head.appendChild(script)
})
</script>

<template>
  <div class="min-h-screen bg-gray-950 text-gray-100">
    <!-- Promo urgency banner -->
    <div v-if="promoActive" class="bg-brand-600 text-white text-center py-2.5 px-6 text-sm font-medium">
      🛡️ FREE Security Audit with every engagement — ends in {{ promoDaysLeft }} day{{ promoDaysLeft === 1 ? '' : 's' }}!
    </div>

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

    <!-- Header + trust signals -->
    <div class="max-w-4xl mx-auto px-4 pt-6 pb-2 text-center">
      <h1 class="text-2xl sm:text-3xl font-bold mb-2">🗓️ Book Your Free Intro Call</h1>
      <p class="text-gray-400 mb-4">Pick a time. 15 minutes. Just a real conversation about your AWS bill.</p>

      <!-- Trust badges — above the widget where they matter -->
      <div class="flex flex-wrap items-center justify-center gap-4 sm:gap-6 text-sm text-gray-400 mb-4">
        <span>✅ No pitch deck</span>
        <span>✅ No commitment</span>
        <span>✅ No savings = no fee</span>
      </div>

      <!-- Value prop for ad traffic -->
      <p class="text-gray-500 text-sm mb-2">19 years of AWS experience. We find 30–40% waste on average.</p>

      <!-- Social proof — logo cards matching homepage style -->
      <p class="text-gray-500 text-xs uppercase tracking-wider mb-3">Trusted by teams at</p>
      <div class="grid grid-cols-4 gap-3 max-w-lg mx-auto">
        <div
          v-for="client in clients"
          :key="client.name"
          class="flex items-center justify-center h-14 px-3 rounded-lg bg-white/90"
        >
          <img
            :src="client.logo"
            :alt="client.name"
            class="h-8 max-w-[120px] object-contain opacity-90"
          />
        </div>
      </div>
    </div>

    <!-- Calendly embed -->
    <div
      class="calendly-inline-widget mx-auto"
      :data-url="calendlyUrl"
      style="min-width: 320px; width: 100%; height: 700px;"
    ></div>

    <!-- Footer -->
    <div class="max-w-2xl mx-auto px-6 py-8 text-center">
      <p class="text-gray-600 text-xs">
        Questions? <a href="mailto:david@cutmyaws.com" class="text-brand-400 hover:underline">david@cutmyaws.com</a>
      </p>
    </div>
  </div>
</template>
