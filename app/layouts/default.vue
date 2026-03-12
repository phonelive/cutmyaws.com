<script setup>
const route = useRoute()

// Promo: free security scan — single source of truth
const promoEnd = new Date('2026-04-04T23:59:59')
const now = new Date()
const promoActive = now < promoEnd
const promoDaysLeft = Math.max(0, Math.ceil((promoEnd.getTime() - now.getTime()) / (1000 * 60 * 60 * 24)))
const securityPct = 10

// Hide book button on booking-related pages
const hideBookBtn = computed(() => ['/book', '/confirmed'].includes(route.path))
</script>

<template>
  <div class="min-h-screen bg-gray-950 text-gray-100 flex flex-col">
    <!-- Sticky header -->
    <div class="sticky top-0 z-50 bg-gray-950/95 backdrop-blur-sm">
      <!-- Promo Banner -->
      <div v-if="promoActive" class="bg-brand-600 text-white text-center py-1.5 px-4 text-xs sm:text-sm font-medium">
        <NuxtLink to="/book?c=promo-banner" class="hover:underline">
          🛡️ FREE Security Audit (normally {{ securityPct }}% of AWS annual spend) — ends in {{ promoDaysLeft }} day{{ promoDaysLeft === 1 ? '' : 's' }}!
        </NuxtLink>
      </div>

      <!-- Nav -->
      <nav class="border-b border-gray-800/50">
        <div class="max-w-5xl mx-auto px-4 sm:px-6 py-2.5 sm:py-3 flex items-center justify-between">
          <NuxtLink to="/" class="flex items-center gap-2 hover:opacity-80 transition-opacity">
            <span class="text-xl sm:text-2xl">✂️</span>
            <span class="font-bold text-base sm:text-lg">Cut My AWS</span>
          </NuxtLink>
          <NuxtLink
            v-if="!hideBookBtn"
            to="/book?c=nav"
            class="bg-brand-500 hover:bg-brand-600 text-white font-semibold px-4 sm:px-5 py-1.5 sm:py-2 rounded-lg transition-colors text-xs sm:text-sm"
          >
            🗓️ Book Free Intro Call
          </NuxtLink>
        </div>
      </nav>
    </div>

    <!-- Page content -->
    <main class="flex-1">
      <slot />
    </main>

    <!-- Footer -->
    <footer class="border-t border-gray-800 bg-gray-900">
      <div class="max-w-5xl mx-auto px-6 py-8 flex flex-col sm:flex-row items-center justify-between gap-4 text-sm text-gray-500">
        <span>✂️ &copy; {{ new Date().getFullYear() }} Smart Talk LLC d/b/a Cut My AWS &middot; Peoria, IL</span>
        <div class="flex items-center gap-4 flex-wrap justify-center sm:justify-end">
          <NuxtLink v-if="!hideBookBtn" to="/book?c=footer" class="text-brand-400 hover:text-brand-300 font-semibold transition-colors">🗓️ Book Free Intro</NuxtLink>
          <NuxtLink to="/onboarding/calculate-savings" class="hover:text-gray-300 transition-colors">🧮 Calculate Savings</NuxtLink>
          <NuxtLink to="/onboarding/give-david-access" class="hover:text-gray-300 transition-colors">🔧 Grant Access</NuxtLink>
          <NuxtLink to="/agreements" class="hover:text-gray-300 transition-colors">📋 Agreements</NuxtLink>
          <a href="https://www.linkedin.com/in/davidplappert/" target="_blank" class="hover:text-gray-300 transition-colors">💼 LinkedIn</a>
          <a href="mailto:david@cutmyaws.com" class="hover:text-gray-300 transition-colors">📧 david@cutmyaws.com</a>
        </div>
      </div>
    </footer>
  </div>
</template>
