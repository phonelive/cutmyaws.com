<script setup>
import { onMounted, onBeforeUnmount } from 'vue'
import { useRoute, useRouter } from 'vue-router'

useHead({
  title: 'Book Your Free Intro Call — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})

const route = useRoute()
const router = useRouter()
const campaign = route.query.c || 'book'

const calendlyUrl = `https://calendly.com/phonelivestreaming/cutmyaws-com-intro?utm_source=cutmyaws&utm_medium=website&utm_campaign=${campaign}&hide_gdpr_banner=1&background_color=030712&text_color=f3f4f6&primary_color=f97316`

// Promo: free security scan — mirrors index.vue
const promoEnd = new Date('2026-04-04T23:59:59')
const now = new Date()
const promoActive = now < promoEnd
const promoDaysLeft = Math.max(0, Math.ceil((promoEnd.getTime() - now.getTime()) / (1000 * 60 * 60 * 24)))

const clients = [
  { name: 'Caterpillar', logo: '/logos/cat.svg' },
  { name: 'DC Government', logo: '/logos/dc-gov.png' },
  { name: 'Best Buy', logo: '/logos/best-buy.svg' },
  { name: 'PBS', logo: '/logos/pbs.svg' },
  { name: 'Commonwealth of Massachusetts', logo: '/logos/ma-state.png' },
  { name: 'Argonne National Laboratory', logo: '/logos/argonne.png' },
  { name: 'PhoneLive', logo: '/logos/phonelive.png' },
  { name: 'EZRA Cloud', logo: '/logos/ezra.png' },
]

const testimonials = [
  { quote: 'David is a dev genius.', emoji: '🧠' },
  { quote: 'David responds quickly and makes sure to explain things as best as possible.', emoji: '💬' },
  { quote: "David's a commando. He is fast and efficient at getting results.", emoji: '🎯' },
]

function onCalendlyMessage(e) {
  if (e.data?.event === 'calendly.event_scheduled') {
    router.push('/confirmed')
  }
}

onMounted(() => {
  const script = document.createElement('script')
  script.src = 'https://assets.calendly.com/assets/external/widget.js'
  script.async = true
  document.head.appendChild(script)

  const { trackEvent } = useTracking()
  trackEvent('book_page_view', { event_category: 'engagement' })

  window.addEventListener('message', onCalendlyMessage)
})

onBeforeUnmount(() => {
  window.removeEventListener('message', onCalendlyMessage)
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
      </div>
    </nav>

    <!-- Header -->
    <div class="max-w-4xl mx-auto px-6 pt-12 sm:pt-16 pb-6 text-center">
      <h1 class="text-2xl sm:text-3xl font-bold mb-4">🗓️ Book Your Free Intro Call</h1>

      <!-- Trust badges -->
      <div class="flex flex-wrap items-center justify-center gap-3 sm:gap-6 text-sm text-gray-400">
        <span>✅ No pitch deck</span>
        <span>✅ No commitment</span>
        <span>✅ No savings = no fee</span>
      </div>
    </div>

    <!-- Calendly embed -->
    <div
      class="calendly-inline-widget mx-auto"
      :data-url="calendlyUrl"
      style="min-width: 320px; width: 100%; height: 700px;"
    ></div>

    <!-- Best fit / Not a fit -->
    <div class="max-w-3xl mx-auto px-6 py-10 sm:py-12">
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-6 sm:gap-8 text-left">
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-6">
          <h3 class="text-sm font-bold text-gray-300 uppercase tracking-wider mb-3">Best fit 💰</h3>
          <ul class="space-y-2 text-sm text-gray-400">
            <li>💰 Spending $5K+/mo on AWS</li>
            <li>🕸️ Nobody's looked under the hood in a while</li>
            <li>😅 Bill keeps going up but you're not sure why</li>
            <li>💰 Want a one-time fix for recurring savings</li>
          </ul>
        </div>
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-6">
          <h3 class="text-sm font-bold text-gray-300 uppercase tracking-wider mb-3">Not a fit ❌</h3>
          <ul class="space-y-2 text-sm text-gray-400">
            <li>❌ Under $5K/mo (not enough waste)</li>
            <li>❌ Want a dashboard (I'm a person, not a SaaS)</li>
            <li>❌ Not ROI-focused (I optimize for your bottom line)</li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Social proof — all 8 logos, responsive -->
    <div class="max-w-4xl mx-auto px-6 py-10 sm:py-12 text-center">
      <p class="text-gray-500 text-xs uppercase tracking-wider mb-4">Trusted by teams at</p>
      <div class="grid grid-cols-2 sm:grid-cols-4 gap-3 sm:gap-4 max-w-xl mx-auto">
        <div
          v-for="client in clients"
          :key="client.name"
          class="flex items-center justify-center h-14 sm:h-16 px-4 sm:px-5 rounded-lg bg-white/90"
        >
          <img
            :src="client.logo"
            :alt="client.name"
            class="h-7 sm:h-8 max-w-[100px] sm:max-w-[120px] object-contain opacity-90"
          />
        </div>
      </div>
    </div>

    <!-- Testimonials -->
    <div class="max-w-4xl mx-auto px-6 py-12 sm:py-16">
      <p class="text-gray-500 text-xs uppercase tracking-wider mb-6 text-center">What people say</p>
      <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <div
          v-for="t in testimonials"
          :key="t.quote"
          class="bg-gray-900 rounded-xl border border-gray-800 p-6 text-center"
        >
          <p class="text-3xl mb-3">{{ t.emoji }}</p>
          <p class="text-gray-300 italic">"{{ t.quote }}"</p>
        </div>
      </div>
    </div>

    <!-- Footer -->
    <div class="max-w-2xl mx-auto px-6 py-12 text-center">
      <p class="text-gray-600 text-xs">
        Questions? <a href="mailto:david@cutmyaws.com" class="text-brand-400 hover:underline">david@cutmyaws.com</a>
      </p>
    </div>
  </div>
</template>
