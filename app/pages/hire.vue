<script setup>
useHead({
  title: 'Hire David — AWS Serverless Architect · 19 Years — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})
</script>

<template>
  <PageSections>
    <!-- Hero -->
    <section class="max-w-3xl mx-auto px-6 pt-16 pb-12 text-center">
      <div class="flex items-center justify-center gap-4 mb-6">
        <img src="/david.png" alt="David Plappert" class="w-16 h-16 rounded-full border-2 border-gray-800" />
        <div class="text-left">
          <p class="font-bold text-lg">David Plappert</p>
          <p class="text-gray-500 text-sm">Senior AWS Serverless Architect · 19 years</p>
        </div>
      </div>
      <h1 class="text-3xl sm:text-4xl font-extrabold mb-4">
        Hire someone who <span class="text-brand-400">ships</span>, not someone who bills hours. 🚀
      </h1>
      <p class="text-gray-400 text-lg mb-4">
        I build, migrate, and fix AWS infrastructure for a living. Serverless-first, production-grade, Fortune 100 battle-tested.
        No slide decks. No discovery phases that last longer than the actual project. Just results. 😏
      </p>
      <p class="text-gray-400 text-lg mb-8">
        I'm not cheap. But I'm ROI-focused and I deliver every time. If that sounds like what you need — let's talk.
      </p>
      <a
        href="mailto:david@cutmyaws.com?subject=Custom%20Engagement%20%F0%9F%9A%80&body=Hey%20David%2C%0A%0AI%20need%20help%20with%20%5Bdescribe%20your%20project%5D.%20Let's%20talk."
        class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-bold px-8 py-4 rounded-xl text-lg transition-colors"
      >
        📧 Email David to start a conversation
      </a>
      <p class="text-gray-600 text-sm mt-3">david@cutmyaws.com — I respond fast ⚡</p>
    </section>

    <!-- What I do -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-16">
        <h2 class="text-2xl font-bold text-center mb-2">What I do 🧰</h2>
        <p class="text-gray-500 text-sm text-center mb-8">Beyond cost optimization — the full AWS toolkit.</p>
        <div class="grid sm:grid-cols-2 gap-6">
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6">
            <p class="text-2xl mb-2">⚡</p>
            <h3 class="font-bold mb-1">Serverless Migrations</h3>
            <p class="text-gray-500 text-sm">EC2 → Lambda. Monolith → microservices. That thing running on three servers that nobody wants to touch? I'll turn it into a serverless architecture your team actually understands. No more 3 AM pager alerts. 😴</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6">
            <p class="text-2xl mb-2">🔍</p>
            <h3 class="font-bold mb-1">Architecture Reviews</h3>
            <p class="text-gray-500 text-sm">I read your architecture, find what's wrong, and tell you exactly how to fix it. Not a 90-page PDF that collects dust — a clear, prioritized action plan your team can execute Monday morning. 📋</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6">
            <p class="text-2xl mb-2">🏎️</p>
            <h3 class="font-bold mb-1">Performance Optimization</h3>
            <p class="text-gray-500 text-sm">Make it faster. Make it cheaper. Usually both at the same time, because the fastest code is the code that doesn't run unnecessary services. Wild how that works. 🤷</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6">
            <p class="text-2xl mb-2">🏗️</p>
            <h3 class="font-bold mb-1">Greenfield Builds</h3>
            <p class="text-gray-500 text-sm">Start right, skip the tech debt phase. I design and build production-ready AWS infrastructure from scratch — so you're not paying someone else to untangle it in 18 months. Future you says thanks. 🙏</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Why hire me -->
    <section class="max-w-3xl mx-auto px-6 py-16 text-center">
      <h2 class="text-2xl font-bold mb-2">Why hire me 🤔</h2>
      <p class="text-gray-500 text-sm mb-8">The short version. I'll spare you the origin story.</p>
      <div class="grid sm:grid-cols-2 gap-6 text-left">
        <div class="flex gap-3">
          <p class="text-brand-400 text-xl">📅</p>
          <div>
            <h3 class="font-bold mb-1">19 years of AWS</h3>
            <p class="text-gray-500 text-sm">Since 2007 — before Lambda existed, before "serverless" was a word, before your startup was a napkin sketch. I've seen every era of AWS and shipped production in all of them.</p>
          </div>
        </div>
        <div class="flex gap-3">
          <p class="text-brand-400 text-xl">🏢</p>
          <div>
            <h3 class="font-bold mb-1">Fortune 100 battle scars</h3>
            <p class="text-gray-500 text-sm">Caterpillar, Best Buy, PBS, DC Government, Commonwealth of Massachusetts. I build things that can't go down. Your scale doesn't scare me. 😎</p>
          </div>
        </div>
        <div class="flex gap-3">
          <p class="text-brand-400 text-xl">🎯</p>
          <div>
            <h3 class="font-bold mb-1">ROI-focused, scope-locked</h3>
            <p class="text-gray-500 text-sm">I scope tight, deliver on time, and don't surprise you with a change order halfway through. You'll know the cost before we start. No asterisks.</p>
          </div>
        </div>
        <div class="flex gap-3">
          <p class="text-brand-400 text-xl">🚢</p>
          <div>
            <h3 class="font-bold mb-1">I ship. That's the whole pitch.</h3>
            <p class="text-gray-500 text-sm">Not a PowerPoint consultant. Not a "let me loop in my team" consultant. I do the work. I push the code. I make the thing go live. Radical concept, I know. 😅</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Social proof -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-12">
        <ClientLogos />
      </div>
    </section>

    <!-- Calendly Embed -->
    <section id="book-section">
      <CalendlyEmbed campaign="hire" />
    </section>

  </PageSections>
</template>
