<script setup>
defineProps({
  headline: {
    type: String,
    default: 'How it works',
  },
  subheadline: {
    type: String,
    default: '',
  },
  steps: {
    type: Array,
    required: true,
  },
})
</script>

<template>
  <section>
    <div class="max-w-3xl mx-auto px-6 py-16 text-center">
      <h2 class="text-2xl font-bold mb-2">{{ headline }}</h2>
      <p v-if="subheadline" class="text-gray-500 text-sm mb-8">{{ subheadline }}</p>
      <div class="grid sm:grid-cols-3 gap-8 text-left">
        <a v-for="(step, i) in steps" :key="i" href="#book" class="block hover:opacity-80 transition-opacity">
          <p class="text-brand-400 text-sm font-bold mb-2">STEP {{ i + 1 }}</p>
          <h3 class="font-bold mb-1">{{ step.title }}</h3>
          <p class="text-gray-500 text-sm">{{ step.description }}</p>
        </a>
      </div>
    </div>
  </section>
</template>
