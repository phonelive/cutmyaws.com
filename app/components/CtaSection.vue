<script setup>
defineProps({
  headline: {
    type: String,
    required: true,
  },
  subtext: {
    type: String,
    default: '',
  },
  ctaLink: {
    type: String,
    required: true,
  },
  ctaText: {
    type: String,
    default: '🗓️ Book a Free 15-Min Chat',
  },
  secondaryHtml: {
    type: String,
    default: '',
  },
  bg: {
    type: Boolean,
    default: true,
  },
})
</script>

<template>
  <section :class="bg ? 'bg-gray-900' : ''">
    <div class="max-w-3xl mx-auto px-6 py-16 text-center">
      <h2 class="text-2xl font-bold mb-3">{{ headline }}</h2>
      <p v-if="subtext" class="text-gray-400 mb-6">{{ subtext }}</p>
      <NuxtLink
        :to="ctaLink"
        class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-bold px-8 py-4 rounded-xl text-lg transition-colors"
      >
        {{ ctaText }}
      </NuxtLink>
      <div v-if="secondaryHtml" v-html="secondaryHtml" class="mt-3"></div>
      <slot />
    </div>
  </section>
</template>
