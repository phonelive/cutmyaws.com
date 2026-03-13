<script setup>
defineProps({
  headline: {
    type: String,
    default: '❓ Questions you\'re definitely asking right now',
  },
  questions: {
    type: Array,
    required: true,
  },
})
</script>

<template>
  <div class="max-w-5xl mx-auto px-6 py-24">
    <h2 class="text-3xl font-bold mb-12 text-center">{{ headline }}</h2>
    <div class="max-w-2xl mx-auto space-y-10">
      <div v-for="q in questions" :key="q.question">
        <h3 class="text-lg font-bold mb-3">{{ q.emoji }} {{ q.question }}</h3>
        <p class="text-gray-400" v-html="q.answer"></p>
      </div>
    </div>
  </div>
</template>
