<script setup>
useHead({
  title: 'Referral Partnership — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})
</script>

<template>
  <div>
    <!-- Hero -->
    <section class="max-w-3xl mx-auto px-6 pt-16 pb-12 text-center">
      <div class="flex items-center justify-center gap-4 mb-6">
        <img src="/david.png" alt="David Plappert" class="w-16 h-16 rounded-full border-2 border-gray-800" />
        <div class="text-left">
          <p class="font-bold text-lg">David Plappert</p>
          <p class="text-gray-500 text-sm">Senior AWS Architect · 19 years</p>
        </div>
      </div>
      <h1 class="text-3xl sm:text-4xl font-extrabold mb-4">
        Send me your clients' AWS bills. <span class="text-brand-400">Get paid.</span>
      </h1>
      <p class="text-gray-400 text-lg mb-4">
        You already know which of your clients are bleeding money on AWS.
        You've seen the invoices. You've heard the complaints. You just don't have time to fix it. 😅
      </p>
      <p class="text-gray-400 text-lg mb-8">
        I do. You make an intro, I handle the rest, and you earn a referral fee for every engagement that closes.
        Everybody wins — except AWS. 🎯
      </p>
      <NuxtLink
        to="/book?c=referral-hero"
        class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-bold px-8 py-4 rounded-xl text-lg transition-colors"
      >
        🗓️ Book a Quick Chat About Referrals
      </NuxtLink>
      <p class="text-gray-600 text-sm mt-3">15 min · no strings · just two people who like money 💰</p>
    </section>

    <!-- How it works -->
    <section class="bg-gray-900">
      <div class="max-w-3xl mx-auto px-6 py-16 text-center">
        <h2 class="text-2xl font-bold mb-2">How it works</h2>
        <p class="text-gray-500 text-sm mb-8">Three steps. Less effort than writing a Slack message. 💬</p>
        <div class="grid sm:grid-cols-3 gap-8 text-left">
          <div>
            <p class="text-brand-400 text-sm font-bold mb-2">STEP 1</p>
            <h3 class="font-bold mb-1">You make an intro</h3>
            <p class="text-gray-500 text-sm">Forward an email. Send a LinkedIn message. Yell across a coworking space. However you do it, just connect me with your client. That's it. That's your whole job. ✉️</p>
          </div>
          <div>
            <p class="text-brand-400 text-sm font-bold mb-2">STEP 2</p>
            <h3 class="font-bold mb-1">David audits the account</h3>
            <p class="text-gray-500 text-sm">Read-only access, 5–10 business days. I find the waste, build the report, and present the savings. Your client doesn't need to babysit me — I've done this a few hundred times. 🔍</p>
          </div>
          <div>
            <p class="text-brand-400 text-sm font-bold mb-2">STEP 3</p>
            <h3 class="font-bold mb-1">You get paid</h3>
            <p class="text-gray-500 text-sm">When the engagement closes, you earn a referral fee. Your client saves money, you get paid, and I get to yell at another AWS account. The circle of life. 🦁</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Value props -->
    <section class="max-w-3xl mx-auto px-6 py-16">
      <div class="grid sm:grid-cols-3 gap-6 text-left">
        <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6">
          <p class="text-2xl mb-2">✌️</p>
          <h3 class="font-bold mb-1">Stupid easy</h3>
          <p class="text-gray-500 text-sm">No sales pitch required. No technical knowledge needed. Just say "hey, you should talk to David about your AWS bill" and I handle the rest. You don't even need to know what a NAT Gateway is. 🤷</p>
        </div>
        <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6">
          <p class="text-2xl mb-2">🔁</p>
          <h3 class="font-bold mb-1">Repeatable</h3>
          <p class="text-gray-500 text-sm">Got 3 clients on AWS? That's 3 potential checks. Got 30? Now we're talking. Every client with a growing AWS bill is an opportunity sitting in your Rolodex. 📇</p>
        </div>
        <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6">
          <p class="text-2xl mb-2">🏆</p>
          <h3 class="font-bold mb-1">Your clients win</h3>
          <p class="text-gray-500 text-sm">They save real money. Their infrastructure gets better. And you're the one who made it happen. That's the kind of referral that gets you a thank-you lunch. 🍔</p>
        </div>
      </div>
    </section>

    <!-- Who's a good referral -->
    <section class="bg-gray-900">
      <div class="max-w-3xl mx-auto px-6 py-16 text-center">
        <h2 class="text-2xl font-bold mb-2">Who's a good referral? 🎯</h2>
        <p class="text-gray-500 text-sm mb-8">If you're nodding at any of these, we should talk.</p>
        <div class="grid sm:grid-cols-3 gap-6 text-left">
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6">
            <p class="text-2xl mb-2">💰</p>
            <h3 class="font-bold mb-1">$5K+/mo on AWS</h3>
            <p class="text-gray-500 text-sm">Below that, there's not enough waste to justify an engagement. Above that? It's almost guaranteed there's money hiding in the account. 📊</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6">
            <p class="text-2xl mb-2">🕸️</p>
            <h3 class="font-bold mb-1">Nobody's looked</h3>
            <p class="text-gray-500 text-sm">The bill goes up every month and everyone just... accepts it. No one's done an audit. No one's questioned the architecture. AWS loves these accounts. 😬</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6">
            <p class="text-2xl mb-2">📈</p>
            <h3 class="font-bold mb-1">Growing fast</h3>
            <p class="text-gray-500 text-sm">The company is scaling and so is the AWS bill. They're too busy building product to optimize infrastructure. That's where I come in. 🚀</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Social proof -->
    <section class="max-w-3xl mx-auto px-6 py-12">
      <ClientLogos />
    </section>

    <!-- Bottom CTA -->
    <section class="bg-gray-900">
      <div class="max-w-3xl mx-auto px-6 py-16 text-center">
        <h2 class="text-2xl font-bold mb-3">Let's set up your referral partnership. 🤝</h2>
        <p class="text-gray-400 mb-8">
          Quick call to get on the same page — who your clients are, how intros work, and what you earn.
          No paperwork on this call. Just a conversation.
        </p>
        <div class="flex flex-col sm:flex-row items-center justify-center gap-4">
          <NuxtLink
            to="/book?c=referral"
            class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-bold px-8 py-4 rounded-xl text-lg transition-colors"
          >
            🗓️ Book a Quick Chat About Referrals
          </NuxtLink>
          <a
            href="mailto:david@cutmyaws.com?subject=Referral%20Partnership%20%E2%9C%82%EF%B8%8F&body=Hey%20David%2C%0A%0AI%20run%20%5Bcompany%5D%20and%20have%20clients%20on%20AWS.%20Let's%20talk%20referrals."
            class="inline-block bg-gray-800 hover:bg-gray-700 text-white font-semibold px-6 py-3 rounded-xl transition-colors border border-gray-700"
          >
            📧 david@cutmyaws.com
          </a>
        </div>
      </div>
    </section>

  </div>
</template>
