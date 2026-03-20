<script setup>
const route = useRoute()

// Hide book button on booking-related pages
const hideBookBtn = computed(() => ['/book', '/confirmed'].includes(route.path))
</script>

<template>
  <div class="min-h-screen bg-gray-950 text-gray-100 flex flex-col">
    <!-- Sticky header -->
    <div class="sticky top-0 z-50 bg-gray-950/95 backdrop-blur-sm">
      <!-- Nav -->
      <nav class="border-b border-gray-800/50">
        <div class="max-w-5xl mx-auto px-4 sm:px-6 py-2.5 sm:py-3 flex items-center justify-between">
          <NuxtLink to="/" class="flex items-center gap-2 hover:opacity-80 transition-opacity">
            <span class="text-xl sm:text-2xl">✂️</span>
            <span class="font-bold text-base sm:text-lg">Cut My AWS</span>
          </NuxtLink>
          <a
            v-if="!hideBookBtn"
            href="#book"
            class="bg-brand-500 hover:bg-brand-600 text-white font-semibold px-4 sm:px-5 py-1.5 sm:py-2 rounded-lg transition-colors text-xs sm:text-sm"
          >
            🗓️ Free 15-Min Chat
          </a>
        </div>
      </nav>
    </div>

    <!-- Page content -->
    <main class="flex-1 section-alternating">
      <slot />
    </main>

    <!-- Footer -->
    <footer class="border-t border-gray-800 bg-gray-900">
      <div class="max-w-5xl mx-auto px-6 py-10">
        <div class="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-8 text-sm">
          <!-- Brand + tagline -->
          <div class="sm:max-w-xs">
            <NuxtLink to="/" class="flex items-center gap-2 mb-3 hover:opacity-80 transition-opacity">
              <span class="text-xl">✂️</span>
              <span class="font-bold text-base text-gray-100">Cut My AWS</span>
            </NuxtLink>
            <p class="text-gray-500 text-xs leading-relaxed">AWS cost optimization for businesses spending $5K+/mo. Not a dashboard. Just David.</p>
          </div>

          <!-- Links + contact in one row -->
          <div class="flex flex-wrap gap-x-12 gap-y-6">
            <!-- Work with David -->
            <div>
              <p class="text-gray-400 font-semibold mb-3">Work with David</p>
              <ul class="space-y-2 text-gray-500">
                <li><NuxtLink to="/investors" class="hover:text-gray-300 transition-colors">For Investors</NuxtLink></li>
                <li><NuxtLink to="/government" class="hover:text-gray-300 transition-colors">For Government</NuxtLink></li>
                <li><NuxtLink to="/hire" class="hover:text-gray-300 transition-colors">Hire David</NuxtLink></li>
                <li><NuxtLink to="/referrals" class="hover:text-gray-300 transition-colors">Referral Partners</NuxtLink></li>
              </ul>
            </div>

            <!-- Contact -->
            <div>
              <p class="text-gray-400 font-semibold mb-3">Contact</p>
              <ul class="space-y-2 text-gray-500">
                <li v-if="!hideBookBtn"><a href="#book" class="text-brand-400 hover:text-brand-300 font-semibold transition-colors">🗓️ Book Free Intro</a></li>
                <li><a href="mailto:david@cutmyaws.com" class="hover:text-gray-300 transition-colors">📧 david@cutmyaws.com</a></li>
              </ul>
            </div>
          </div>
        </div>

        <!-- Bottom bar -->
        <div class="mt-8 pt-6 border-t border-gray-800 text-xs text-gray-600 text-center sm:text-left">
          &copy; {{ new Date().getFullYear() }} Smart Talk LLC d/b/a Cut My AWS &middot; Ocala, FL
        </div>
      </div>
    </footer>
  </div>
</template>

<style>
/* Auto-alternate section backgrounds: even sections get gray-900 */
.section-alternating > div > section:nth-child(even) {
  background-color: #111827; /* gray-900 */
}
</style>
