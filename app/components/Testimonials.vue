<script setup>
const testimonials = [
  { quote: 'David is a dev genius.', emoji: '🧠' },
  { quote: 'David responds quickly and makes sure to explain things as best as possible.', emoji: '💬' },
  { quote: "David's a commando. He is fast and efficient at getting results.", emoji: '🎯' },
]
</script>

<template>
  <div>
    <p class="text-center text-gray-500 text-sm uppercase tracking-wider mb-8">What people say after working with David</p>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <div
        v-for="t in testimonials"
        :key="t.quote"
        class="bg-gray-950 border border-gray-800 rounded-2xl p-8 text-center"
      >
        <p class="text-4xl mb-4">{{ t.emoji }}</p>
        <p class="text-gray-300 text-lg italic">"{{ t.quote }}"</p>
      </div>
    </div>
  </div>
</template>
