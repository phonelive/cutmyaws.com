<script setup>
defineProps({
  stats: {
    type: Array,
    required: true,
  },
  bg: {
    type: Boolean,
    default: false,
  },
})
</script>

<template>
  <section :class="bg ? 'bg-gray-900' : ''">
    <div class="max-w-4xl mx-auto px-6 py-24 grid grid-cols-1 sm:grid-cols-3 gap-12">
      <div v-for="stat in stats" :key="stat.label" class="text-center px-4">
        <div class="text-3xl font-bold mb-2" :class="stat.color || 'text-brand-400'">{{ stat.value }}</div>
        <div class="text-sm text-gray-400 leading-relaxed">{{ stat.label }}</div>
      </div>
    </div>
  </section>
</template>
