<script setup>
defineProps({
  cards: {
    type: Array,
    required: true,
  },
  columns: {
    type: Number,
    default: 2,
  },
})
</script>

<template>
  <div
    class="grid grid-cols-1 gap-6"
    :class="columns === 3 ? 'sm:grid-cols-3' : 'md:grid-cols-2'"
    :style="columns === 2 ? '' : ''"
  >
    <a
      v-for="card in cards"
      :key="card.title"
      href="#book"
      class="border border-gray-800 rounded-2xl p-8 block hover:border-brand-500/50 transition-colors"
      :class="columns === 3 ? 'bg-gray-950' : 'bg-gray-900'"
    >
      <p class="text-2xl mb-3">{{ card.emoji }}</p>
      <h3 class="text-lg font-bold mb-2">{{ card.title }}</h3>
      <p class="text-gray-400">{{ card.description }}</p>
    </a>
  </div>
</template>
