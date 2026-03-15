<script setup>
useHead({
  title: 'Referral Partnership — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})
</script>

<template>
  <PageSections>
    <!-- Hero -->
    <section>
      <div class="max-w-3xl mx-auto px-6 pt-16 pb-12 text-center">
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
        <a
          href="#book"
          class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-bold px-8 py-4 rounded-xl text-lg transition-colors"
        >
          🗓️ Book a Quick Chat About Referrals
        </a>
        <p class="text-gray-600 text-sm mt-3">15 min · no strings · just two people who like money 💰</p>
      </div>
    </section>

    <!-- How it works -->
    <section>
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
    <section>
      <div class="max-w-3xl mx-auto px-6 py-16">
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
      </div>
    </section>

    <!-- Who's a good referral -->
    <section>
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
    <section>
      <div class="max-w-3xl mx-auto px-6 py-12">
        <ClientLogos />
      </div>
    </section>

    <!-- Calendly Embed -->
    <section id="book-section">
      <CalendlyEmbed campaign="referral" />
    </section>

  </PageSections>
</template>
