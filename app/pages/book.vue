<script setup>
import { onMounted } from 'vue'

definePageMeta({ layout: 'book' })

useHead({
  title: 'Book a Free 15-Min Chat — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})

const route = useRoute()
const campaign = route.query.c || 'book-main'

onMounted(() => {
  const { trackEvent } = useTracking()
  trackEvent('book_page_view', { event_category: 'engagement' })

  // Tell Reddit this visitor reached the booking page (mid-funnel signal)
  if (window.rdt) window.rdt('track', 'ViewContent')
})
</script>

<template>
  <div>
    <!-- Contact Form -->
    <ContactForm :campaign="campaign" />

    <!-- Best fit -->
    <div class="max-w-3xl mx-auto px-6 py-10 sm:py-12">
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-6 sm:gap-8 text-left">
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-6">
          <h3 class="text-sm font-bold text-gray-300 uppercase tracking-wider mb-3">You're a great fit if 💰</h3>
          <ul class="space-y-2 text-sm text-gray-400">
            <li>💰 Spending $5K+/mo on AWS</li>
            <li>🕸️ Nobody's looked under the hood in a while</li>
            <li>😅 Bill keeps going up but you're not sure why</li>
            <li>📈 Growing business with growing infrastructure</li>
            <li>🏗️ Architecture decisions from 2+ years ago</li>
          </ul>
        </div>
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-6">
          <h3 class="text-sm font-bold text-gray-300 uppercase tracking-wider mb-3">What to expect on the call 📞</h3>
          <ul class="space-y-2 text-sm text-gray-400">
            <li>🤝 Meet David (real person, not a sales team)</li>
            <li>💬 Quick chat about your business and AWS setup</li>
            <li>🔍 David shares initial observations if you've granted access</li>
            <li>📋 You'll know in 15 min if there's waste to find</li>
            <li>🚫 Zero pressure — genuinely zero</li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Social proof -->
    <div class="max-w-4xl mx-auto px-6 py-10 sm:py-12">
      <ClientLogos />
    </div>

    <!-- Testimonials -->
    <div class="max-w-4xl mx-auto px-6 py-12 sm:py-16">
      <Testimonials />
    </div>

  </div>
</template>
