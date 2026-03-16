<script setup>
defineProps({
  clients: {
    type: Array,
    default: () => [
      { name: 'Caterpillar', logo: '/logos/cat.svg' },
      { name: 'DC Government', logo: '/logos/dc-gov.png' },
      { name: 'Best Buy', logo: '/logos/best-buy.svg' },
      { name: 'PBS', logo: '/logos/pbs.svg' },
      { name: 'Commonwealth of Massachusetts', logo: '/logos/ma-state.png' },
      { name: 'Argonne National Laboratory', logo: '/logos/argonne.png' },
      { name: 'PhoneLive', logo: '/logos/phonelive.png' },
      { name: 'EZRA Cloud', logo: '/logos/ezra.png' },
    ],
  },
  headline: {
    type: String,
    default: 'Trusted by teams at',
  },
})
</script>

<template>
  <div class="text-center">
    <p class="text-gray-500 text-sm uppercase tracking-wider mb-8">{{ headline }}</p>
    <div class="grid grid-cols-2 sm:grid-cols-4 gap-6 items-center justify-items-center max-w-4xl mx-auto">
      <a
        v-for="client in clients"
        :key="client.name"
        href="#book"
        class="group flex items-center justify-center h-20 w-full px-4 rounded-lg bg-white/90 hover:bg-white transition-all"
        :title="client.name"
      >
        <img
          :src="client.logo"
          :alt="client.name"
          class="h-12 max-w-[160px] object-contain opacity-90 group-hover:opacity-100 transition-opacity"
        >
      </a>
    </div>
  </div>
</template>
