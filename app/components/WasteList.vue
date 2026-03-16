<script setup>
defineProps({
  items: {
    type: Array,
    required: true,
  },
})
</script>

<template>
  <div class="max-w-3xl mx-auto space-y-4">
    <a
      v-for="item in items"
      :key="item.name"
      href="#book"
      class="flex items-center gap-4 bg-gray-950 border border-gray-800 rounded-xl px-5 py-4 hover:border-brand-500/50 transition-colors block"
    >
      <span class="text-2xl shrink-0">{{ item.emoji }}</span>
      <span class="bg-brand-500/15 text-brand-400 text-xs font-bold px-2.5 py-1 rounded-md shrink-0 w-24 text-center">{{ item.service }}</span>
      <span class="text-gray-300 flex-1">{{ item.name }}</span>
      <span class="text-red-400 font-bold text-sm whitespace-nowrap ml-2">{{ item.savings }}</span>
    </a>
  </div>
</template>
