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

function onCalendlyMessage(e) {
  if (e.data?.event === 'calendly.event_scheduled') {
    // Calendly payload includes invitee URI but not name directly.
    // Pass whatever we can extract to the confirmation page.
    const payload = e.data?.payload || {}
    const query = {}
    if (payload.invitee?.name) query.invitee_full_name = payload.invitee.name
    if (payload.invitee?.email) query.email = payload.invitee.email
    router.push({ path: '/confirmed', query })
  }
}

onMounted(() => {
  const script = document.createElement('script')
  script.src = 'https://assets.calendly.com/assets/external/widget.js'
  script.async = true
  document.head.appendChild(script)

  const { trackEvent } = useTracking()
  trackEvent('book_page_view', { event_category: 'engagement' })

  // Tell Reddit this visitor reached the booking page (mid-funnel signal)
  if (window.rdt) window.rdt('track', 'ViewContent')

  window.addEventListener('message', onCalendlyMessage)
})

onBeforeUnmount(() => {
  window.removeEventListener('message', onCalendlyMessage)
})
</script>

<template>
  <div>
    <!-- Header -->
    <div class="max-w-4xl mx-auto px-6 pt-12 sm:pt-16 pb-6 text-center">
      <h1 class="text-2xl sm:text-3xl font-bold mb-4">🗓️ Book Your Free Intro Call</h1>

      <!-- Trust badges -->
      <div class="flex flex-wrap items-center justify-center gap-3 sm:gap-6 text-sm text-gray-400">
        <span>✅ 15 minutes</span>
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
