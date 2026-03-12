<script setup>
import { onMounted } from 'vue'

useHead({
  title: 'Booking Confirmed — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})

onMounted(() => {
  const { trackEvent } = useTracking()
  trackEvent('booking_confirmed', { event_category: 'conversion', linkedin_conversion_id: 26412858, reddit_event: 'Lead' })
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
      </div>
    </nav>

    <!-- Confirmation content -->
    <div class="max-w-2xl mx-auto px-8 py-32 text-center">
      <p class="text-6xl mb-6">🎉</p>
      <h1 class="text-3xl sm:text-4xl font-bold mb-4">You're on the calendar!</h1>
      <p class="text-xl text-gray-400 mb-8">Check your inbox for the confirmation email. If you don't see it, check spam — Gmail sometimes gets overprotective. 😅</p>

      <div class="bg-gray-900 rounded-xl border border-gray-800 p-8 mb-8 text-left max-w-lg mx-auto">
        <h2 class="text-lg font-bold mb-4">📋 What happens next</h2>
        <ul class="space-y-3 text-gray-400">
          <li class="flex gap-3"><span class="text-brand-400 font-bold">1.</span> You'll get a calendar invite with a Zoom link</li>
          <li class="flex gap-3"><span class="text-brand-400 font-bold">2.</span> David will review your AWS setup before the call</li>
          <li class="flex gap-3"><span class="text-brand-400 font-bold">3.</span> On the call: real talk about your bill, zero sales pitch</li>
          <li class="flex gap-3"><span class="text-brand-400 font-bold">4.</span> You'll walk away knowing exactly where to cut</li>
        </ul>
      </div>

      <p class="text-gray-500 text-sm mb-8">15 minutes. No pitch deck. Just David and your AWS bill. ✂️</p>

      <NuxtLink to="/" class="inline-block px-6 py-3 bg-brand-500 hover:bg-brand-600 text-white font-semibold rounded-lg transition-colors">
        ← Back to cutmyaws.com
      </NuxtLink>
    </div>

    <!-- Footer -->
    <div class="max-w-2xl mx-auto px-6 py-12 text-center">
      <p class="text-gray-600 text-xs">
        Questions? <a href="mailto:david@cutmyaws.com" class="text-brand-400 hover:underline">david@cutmyaws.com</a>
      </p>
    </div>
  </div>
</template>
