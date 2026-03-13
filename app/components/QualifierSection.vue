<script setup>
defineProps({
  headline: {
    type: String,
    required: true,
  },
  subheadline: {
    type: String,
    default: '',
  },
  items: {
    type: Array,
    required: true,
  },
  notFitItems: {
    type: Array,
    default: () => [],
  },
  layout: {
    type: String,
    default: 'dual',
    validator: (v) => ['dual', 'grid'].includes(v),
  },
})
</script>

<template>
  <!-- Dual layout: Great fit / Not a fit side by side -->
  <div v-if="layout === 'dual'">
    <h2 class="text-3xl font-bold mb-12 text-center">{{ headline }}</h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 gap-8 max-w-3xl mx-auto">
      <div class="bg-gray-950 border border-gray-800 rounded-2xl p-8">
        <h3 class="font-bold text-lg mb-4 text-green-400">Great fit ✅</h3>
        <ul class="space-y-3 text-gray-400 text-sm">
          <li v-for="item in items" :key="item.text" class="flex items-start gap-2">
            <span class="text-green-400 mt-0.5">{{ item.emoji }}</span> {{ item.text }}
          </li>
        </ul>
      </div>
      <div class="bg-gray-950 border border-gray-800 rounded-2xl p-8">
        <h3 class="font-bold text-lg mb-4 text-gray-500">Not a fit ❌</h3>
        <ul class="space-y-3 text-gray-500 text-sm">
          <li v-for="item in notFitItems" :key="item.text" class="flex items-start gap-2">
            <span class="mt-0.5">{{ item.emoji }}</span> {{ item.text }}
          </li>
        </ul>
      </div>
    </div>
  </div>

  <!-- Grid layout: simple checklist grid -->
  <div v-else>
    <h2 class="text-2xl font-bold mb-2 text-center">{{ headline }}</h2>
    <p v-if="subheadline" class="text-gray-500 text-sm mb-8 text-center">{{ subheadline }}</p>
    <div class="grid sm:grid-cols-2 gap-4 text-left max-w-2xl mx-auto">
      <div
        v-for="item in items"
        :key="item.text"
        class="flex items-start gap-3 bg-gray-900 border border-gray-800 rounded-xl p-4"
      >
        <span class="text-brand-400 text-lg mt-0.5">✅</span>
        <p class="text-gray-400 text-sm" v-html="item.text"></p>
      </div>
    </div>
  </div>
</template>
