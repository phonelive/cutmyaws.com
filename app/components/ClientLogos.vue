<script setup>
defineProps({
  clients: {
    type: Array,
    default: () => [
      { name: 'Caterpillar', url: 'https://www.caterpillar.com', logo: '/logos/cat.svg' },
      { name: 'DC Government', url: 'https://dc.gov', logo: '/logos/dc-gov.png' },
      { name: 'Best Buy', url: 'https://www.bestbuy.com', logo: '/logos/best-buy.svg' },
      { name: 'PBS', url: 'https://www.pbs.org', logo: '/logos/pbs.svg' },
      { name: 'Commonwealth of Massachusetts', url: 'https://www.mass.gov', logo: '/logos/ma-state.png' },
      { name: 'Argonne National Laboratory', url: 'https://www.anl.gov', logo: '/logos/argonne.png' },
      { name: 'PhoneLive', url: 'https://phonelive.io', logo: '/logos/phonelive.png' },
      { name: 'EZRA Cloud', url: 'https://ezracloud.com', logo: '/logos/ezra.png' },
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
        :href="client.url"
        target="_blank"
        rel="noopener"
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
