<template>
  <div class="min-h-screen bg-gray-950 text-gray-100 flex flex-col">
    <!-- Minimal header — logo only, no links -->
    <div class="bg-gray-950/95 backdrop-blur-sm">
      <nav class="border-b border-gray-800/50">
        <div class="max-w-5xl mx-auto px-4 sm:px-6 py-2.5 sm:py-3 flex items-center justify-center">
          <div class="flex items-center gap-2">
            <span class="text-xl sm:text-2xl">✂️</span>
            <span class="font-bold text-base sm:text-lg">Cut My AWS</span>
          </div>
        </div>
      </nav>
    </div>

    <!-- Page content -->
    <main class="flex-1">
      <slot />
    </main>
  </div>
</template>
