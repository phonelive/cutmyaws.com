<script setup>
defineProps({
  link: {
    type: String,
    required: true,
  },
  text: {
    type: String,
    default: '🗓️ Book Free Intro Call',
  },
  visible: {
    type: Boolean,
    default: true,
  },
})
</script>

<template>
  <!-- Spacer so content isn't hidden behind the fixed bar -->
  <div v-show="visible" class="h-16 sm:hidden"></div>

  <!-- Fixed bar -->
  <div
    v-show="visible"
    class="fixed bottom-0 inset-x-0 z-40 sm:hidden bg-gray-950/95 backdrop-blur-sm border-t border-gray-800 p-3 transition-opacity"
    :class="visible ? 'opacity-100' : 'opacity-0'"
  >
    <NuxtLink
      :to="link"
      class="block w-full bg-brand-500 hover:bg-brand-600 text-white font-bold py-3 rounded-xl text-center transition-colors"
    >
      {{ text }}
    </NuxtLink>
  </div>
</template>
