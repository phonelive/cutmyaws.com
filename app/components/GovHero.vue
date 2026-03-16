<template>
  <section class="relative overflow-hidden">
    <div class="absolute inset-0 bg-gradient-to-br from-brand-500/5 via-transparent to-brand-500/3"></div>
    <div class="absolute top-0 right-0 w-[600px] h-[600px] bg-brand-500/5 rounded-full blur-3xl -translate-y-1/2 translate-x-1/3"></div>
    <div class="relative max-w-5xl mx-auto px-6 pt-16 pb-16">
      <div class="flex flex-col lg:flex-row gap-12 items-center">
        <!-- Left: Text -->
        <div class="flex-1">
          <p class="text-brand-400 text-sm font-bold uppercase tracking-wide mb-3">Every government agency I audit wastes 30–40% on AWS</p>
          <h1 class="text-3xl sm:text-4xl font-extrabold leading-tight mb-4">
            Your agency is spending <span class="text-red-400">taxpayer dollars</span> on AWS nobody audited.
          </h1>
          <p class="text-gray-400 text-lg mb-4">
            One engagement. Permanent savings. No recurring contracts. No savings? <strong class="text-gray-200">No fee.</strong>
          </p>
          <p class="text-gray-500 text-base mb-8">
            I read the architecture, find the mismatch between your infrastructure and your mission, and tell you exactly what to change — while your team stays focused on delivery. 🏛️
          </p>
          <div class="flex flex-col sm:flex-row gap-4">
            <a
              href="#book"
              class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-bold px-8 py-4 rounded-xl text-lg transition-colors text-center"
            >
              🗓️ Book Your Free Intro Call
            </a>
            <p class="text-gray-500 text-sm self-center">15 min · free · no pitch deck 😏</p>
          </div>
        </div>

        <!-- Right: David card -->
        <a href="#book" class="w-full lg:w-[380px] shrink-0 block group">
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8 text-center group-hover:border-brand-500/50 transition-colors">
            <img src="/david.png" alt="David Plappert" class="w-28 h-28 rounded-full mx-auto mb-5 object-cover object-top border-2 border-gray-700">
            <p class="font-bold text-lg mb-1">David Plappert</p>
            <p class="text-gray-500 text-sm mb-6">10 yrs in gov healthcare · 19 yrs AWS ☕</p>

            <div class="space-y-2 text-left text-sm">
              <div class="flex items-center gap-2 text-gray-400">
                <span class="text-brand-400">✅</span> Read-only access — can't modify your environment
              </div>
              <div class="flex items-center gap-2 text-gray-400">
                <span class="text-brand-400">✅</span> HIPAA, FedRAMP, IRS Pub 1075 experience
              </div>
              <div class="flex items-center gap-2 text-gray-400">
                <span class="text-brand-400">✅</span> Available through Carahsoft & AWS Marketplace
              </div>
              <div class="flex items-center gap-2 text-gray-400">
                <span class="text-brand-400">✅</span> No savings? No fee. Period.
              </div>
            </div>
          </div>
        </a>
      </div>
    </div>
  </section>
</template>
