<script setup>
import { onMounted } from 'vue'

useHead({
  title: 'Booking Confirmed — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})

const route = useRoute()

// Try to extract first name from query params (Calendly passes invitee info)
const rawName = route.query.invitee_full_name || route.query.name || route.query.invitee_name || ''
const prefixes = ['mr', 'mrs', 'ms', 'dr', 'prof', 'sir', 'rev']
const firstName = computed(() => {
  const parts = String(rawName).trim().split(/\s+/)
  if (!parts[0]) return ''
  // Skip honorific prefixes (Mr., Dr., etc.)
  const first = prefixes.includes(parts[0].replace(/\./g, '').toLowerCase()) ? parts[1] : parts[0]
  return first || ''
})

const shareUrl = encodeURIComponent('https://cutmyaws.com')

onMounted(() => {
  const { trackEvent } = useTracking()

  // Only fire conversion events if we have a real name from Calendly.
  // This prevents false conversions from direct URL visits or bots.
  if (firstName.value) {
    trackEvent('booking_confirmed', { event_category: 'conversion', linkedin_conversion_id: 26412858, reddit_event: 'Lead' })
  } else {
    // Still track the page view, but NOT as a conversion
    trackEvent('confirmed_page_view', { event_category: 'engagement' })
  }
})
</script>

<template>
  <div>
    <!-- Confirmation content -->
    <div class="max-w-2xl mx-auto px-8 py-32 text-center">
      <p class="text-6xl mb-6">🎉</p>
      <h1 v-if="firstName" class="text-3xl sm:text-4xl font-bold mb-4">Thanks, {{ firstName }} — you're on the calendar!</h1>
      <h1 v-else class="text-3xl sm:text-4xl font-bold mb-4">You're on the calendar!</h1>
      <p v-if="firstName" class="text-xl text-gray-400 mb-8">{{ firstName }}, check your inbox for the confirmation email. If you don't see it, check spam — Gmail sometimes gets overprotective. 😅</p>
      <p v-else class="text-xl text-gray-400 mb-8">Check your inbox for the confirmation email. If you don't see it, check spam — Gmail sometimes gets overprotective. 😅</p>

      <div class="bg-gray-900 rounded-xl border border-gray-800 p-8 mb-8 text-left max-w-lg mx-auto">
        <h2 class="text-lg font-bold mb-4">📋 What happens next</h2>
        <ul class="space-y-3 text-gray-400">
          <li class="flex gap-3"><span class="text-brand-400 font-bold">1.</span> You'll get a calendar invite with a Zoom link</li>
          <li class="flex gap-3"><span class="text-brand-400 font-bold">2.</span> On the call: we talk about your business and your AWS setup</li>
          <li class="flex gap-3"><span class="text-brand-400 font-bold">3.</span> David asks annoying questions. You share what you're comfortable with.</li>
          <li class="flex gap-3"><span class="text-brand-400 font-bold">4.</span> You'll walk away knowing if there's waste to find — zero obligation</li>
        </ul>
      </div>

      <!-- Social share -->
      <div class="bg-gray-900 rounded-xl border border-gray-800 p-6 mb-8 max-w-lg mx-auto">
        <p class="text-gray-400 text-sm mb-3">🤝 Know someone overpaying AWS? Share the love:</p>
        <div class="flex items-center justify-center gap-3">
          <a
            :href="`https://www.linkedin.com/sharing/share-offsite/?url=${shareUrl}`"
            target="_blank"
            rel="noopener"
            class="bg-gray-800 hover:bg-gray-700 text-white text-sm font-medium px-4 py-2 rounded-lg transition-colors border border-gray-700"
          >
            💼 Share on LinkedIn
          </a>
          <a
            href="mailto:?subject=Check%20out%20Cut%20My%20AWS&body=I%20just%20booked%20a%20free%20AWS%20cost%20audit%20with%20Cut%20My%20AWS.%20They%20only%20charge%20a%20%25%20of%20the%20savings%20they%20find.%20No%20savings%20%3D%20no%20fee.%0A%0Ahttps%3A%2F%2Fcutmyaws.com"
            class="bg-gray-800 hover:bg-gray-700 text-white text-sm font-medium px-4 py-2 rounded-lg transition-colors border border-gray-700"
          >
            📧 Email a friend
          </a>
        </div>
      </div>

      <p v-if="firstName" class="text-gray-500 text-sm mb-8">Looking forward to meeting you, {{ firstName }}. Just you, David, and your AWS bill. ✂️</p>
      <p v-else class="text-gray-500 text-sm mb-8">15 minutes. No pitch deck. Just David and your AWS bill. ✂️</p>

      <NuxtLink to="/" class="inline-block px-6 py-3 bg-brand-500 hover:bg-brand-600 text-white font-semibold rounded-lg transition-colors">
        ← Back to cutmyaws.com
      </NuxtLink>
    </div>

  </div>
</template>
