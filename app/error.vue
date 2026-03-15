<script setup>
const props = defineProps({
  error: Object,
})

const is404 = computed(() => props.error?.statusCode === 404)

const headline = computed(() => is404.value
  ? 'This page doesn\'t exist. Kind of like the savings you\'re leaving on the table.'
  : 'Something broke. Probably not as badly as your AWS bill, though.'
)

const subtext = computed(() => is404.value
  ? 'Maybe it was deprecated. Maybe it was never provisioned. Either way, it\'s costing you nothing — which is more than we can say about your NAT Gateway. 😏'
  : 'We hit an unexpected error. Unlike your AWS bill, this one we\'ll actually fix quickly. 🔧'
)

useHead({
  title: is404.value ? '404 — Cut My AWS' : 'Error — Cut My AWS',
})

const handleError = () => clearError({ redirect: '/' })
</script>

<template>
  <div class="min-h-screen bg-gray-950 text-gray-100 flex flex-col">
    <!-- Nav -->
    <nav class="border-b border-gray-800/50">
      <div class="max-w-5xl mx-auto px-6 py-4 flex items-center justify-between">
        <a href="/" class="flex items-center gap-2 hover:opacity-80 transition-opacity">
          <span class="text-2xl">✂️</span>
          <span class="font-bold text-lg">Cut My AWS</span>
        </a>
      </div>
    </nav>

    <!-- Error content -->
    <div class="flex-1 flex items-center justify-center px-6">
      <div class="max-w-lg text-center">
        <p class="text-8xl font-extrabold text-brand-500 mb-4">{{ error?.statusCode || '500' }}</p>
        <h1 class="text-2xl font-bold mb-4">{{ headline }}</h1>
        <p class="text-gray-400 mb-8">{{ subtext }}</p>
        <div class="flex flex-col sm:flex-row items-center justify-center gap-3">
          <button
            @click="handleError"
            class="bg-brand-500 hover:bg-brand-600 text-white font-semibold px-6 py-3 rounded-xl transition-colors"
          >
            ← Back to home
          </button>
          <a
            href="/#book"
            class="text-brand-400 hover:text-brand-300 font-semibold px-6 py-3 transition-colors"
          >
            🗓️ Book a call instead
          </a>
        </div>
        <p class="text-gray-600 text-sm mt-12">
          At least this page is free. Unlike that idle RDS instance. 💸
        </p>
      </div>
    </div>
  </div>
</template>
