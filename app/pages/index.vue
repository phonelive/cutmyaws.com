<script setup>
const calendlyUrl = 'https://calendly.com/phonelivestreaming/cutmyaws-com-intro'

const stats = [
  { value: '30-40%', label: '📊 Average waste hiding in AWS accounts' },
  { value: '$99', label: '🔍 Down payment on your 10% audit fee' },
  { value: '1-2 weeks', label: '⚡ From "ouch" to "oh nice"' }
]

const wasteSources = [
  { emoji: '🧘', name: 'EC2 instances running hot yoga while doing nothing', savings: '20-40%' },
  { emoji: '🤷', name: 'Savings Plans you didn\'t know existed', savings: '30-50%' },
  { emoji: '🦕', name: 'EBS volumes and snapshots from the Obama administration', savings: '$100-1,000/mo' },
  { emoji: '🏗️', name: 'RDS instances built for Black Friday traffic on a Tuesday', savings: '20-40%' },
  { emoji: '🍽️', name: 'NAT Gateway quietly eating your budget for lunch', savings: '$200-2,000/mo' },
  { emoji: '🐿️', name: 'S3 buckets hoarding data like a digital packrat', savings: '10-30%' },
  { emoji: '🧠', name: 'CloudWatch logs set to "remember everything forever"', savings: '$50-500/mo' }
]

const exampleBefore = 20000
const exampleSavings = 7000
const exampleAnnual = exampleSavings * 12
const scanDeposit = 99
const auditFee = Math.round(exampleAnnual * 0.10) - scanDeposit
const implFee = Math.round(exampleAnnual * 0.25)
const clientNet = exampleAnnual - scanDeposit - auditFee - implFee
</script>

<template>
  <div class="min-h-screen bg-gray-950 text-gray-100">
    <!-- Nav -->
    <nav class="border-b border-gray-800">
      <div class="max-w-5xl mx-auto px-6 py-4 flex items-center justify-between">
        <div class="flex items-center gap-2">
          <span class="text-2xl">✂️</span>
          <span class="font-bold text-lg">Cut My AWS</span>
        </div>
        <a
          :href="calendlyUrl"
          target="_blank"
          class="bg-brand-500 hover:bg-brand-600 text-white font-semibold px-5 py-2 rounded-lg transition-colors text-sm"
        >
          💸 $99 First Session
        </a>
      </div>
    </nav>

    <!-- Hero -->
    <section class="max-w-5xl mx-auto px-6 pt-20 pb-16">
      <div class="max-w-3xl">
        <p class="text-brand-400 font-semibold mb-4 text-lg">🛋️ AWS cost therapy</p>
        <h1 class="text-4xl sm:text-5xl font-bold leading-tight mb-6">
          Your AWS bill is lying to you.<br>
          <span class="text-brand-400">Let's get it to confess. 🔍</span>
        </h1>
        <p class="text-xl text-gray-400 mb-4 max-w-2xl">
          Somewhere between "we should optimize our cloud spend" and actually doing it,
          AWS collected another month of rent on resources you forgot existed. 💸
        </p>
        <p class="text-xl text-gray-400 mb-8 max-w-2xl">
          $99 gets you a live scan of your AWS spend. That $99 is your down payment
          on the 10% audit fee &mdash; not an extra charge.
          <strong class="text-gray-200">If I find nothing &mdash; and I always find something &mdash; you're out 99 bucks. 🤷</strong>
        </p>
        <a
          :href="calendlyUrl"
          target="_blank"
          class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg"
        >
          🗓️ Book Your $99 AWS Intervention
        </a>
      </div>
    </section>

    <!-- Stats -->
    <section class="border-y border-gray-800 bg-gray-900/50">
      <div class="max-w-5xl mx-auto px-6 py-12 grid grid-cols-1 sm:grid-cols-3 gap-8">
        <div v-for="stat in stats" :key="stat.label" class="text-center">
          <div class="text-3xl font-bold text-brand-400 mb-1">{{ stat.value }}</div>
          <div class="text-sm text-gray-400">{{ stat.label }}</div>
        </div>
      </div>
    </section>

    <!-- Social Proof / One-liner -->
    <section class="max-w-5xl mx-auto px-6 py-16 text-center">
      <p class="text-2xl text-gray-300 font-medium italic max-w-3xl mx-auto">
        "AWS didn't accidentally make their pricing confusing. They have 300+ services
        and a billing page that requires a PhD to read. I have the PhD." 🎓
      </p>
      <p class="text-gray-500 mt-4">&mdash; David, who does not actually have a PhD but has read a lot of invoices</p>
    </section>

    <!-- How It Works -->
    <section class="bg-gray-900/50 border-y border-gray-800">
      <div class="max-w-5xl mx-auto px-6 py-20">
        <h2 class="text-3xl font-bold mb-4 text-center">How It Works 🧰</h2>
        <p class="text-gray-400 text-center mb-12 max-w-xl mx-auto">Three steps. No lock-in. No write access. You can fire me at any point and keep everything I found. 🤝</p>

        <!-- Step 1: Scan -->
        <div class="max-w-2xl mx-auto mb-8 bg-gray-900 border border-gray-800 rounded-2xl p-8 text-center">
          <div class="text-brand-400 font-semibold text-sm uppercase tracking-wider mb-2">Step 1</div>
          <h3 class="text-2xl font-bold mb-1">🔍 The Scan</h3>
          <p class="text-4xl font-bold text-brand-400 mb-4">$99 <span class="text-lg text-gray-400 font-normal">down payment on your 10% audit fee</span></p>
          <p class="text-gray-400">You grant read-only access. I dig through your account like a detective with a spreadsheet. 🕵️ We hop on a 15-minute call where I show you exactly what I found and what it's costing you. The $99 comes off your audit invoice &mdash; it's not an extra charge.</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          <!-- Option A -->
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8">
            <div class="text-brand-400 font-semibold text-sm uppercase tracking-wider mb-2">Step 2</div>
            <h3 class="text-2xl font-bold mb-1">📋 The Report</h3>
            <p class="text-4xl font-bold text-brand-400 mb-4">10% <span class="text-lg text-gray-400 font-normal">of annual savings found</span></p>
            <ul class="space-y-3 text-gray-300">
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>Every waste item with exact dollar amounts (the uncomfortable truth 😬)</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>Line-by-line breakdown your CFO will actually understand</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>Step-by-step implementation guide for your team</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>Delivered in 1-2 weeks. You keep it forever. Even if you ghost me. 👻</span>
              </li>
            </ul>
          </div>

          <!-- Option B -->
          <div class="bg-gray-900 border-2 border-brand-500 rounded-2xl p-8 relative">
            <div class="absolute -top-3 right-6 bg-brand-500 text-white text-xs font-bold px-3 py-1 rounded-full">🔥 MOST PICK THIS</div>
            <div class="text-brand-400 font-semibold text-sm uppercase tracking-wider mb-2">Step 3</div>
            <h3 class="text-2xl font-bold mb-1">🔧 The Fix</h3>
            <p class="text-4xl font-bold text-brand-400 mb-4">+25% <span class="text-lg text-gray-400 font-normal">of savings after I prove them</span></p>
            <ul class="space-y-3 text-gray-300">
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>I implement every optimization (you watch or nap, your call 😴)</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>90-day monitoring to make sure the savings stick</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>You only pay on <strong>verified, proven</strong> results</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>If the savings don't show up on your bill, I don't get paid. Simple. 🤷</span>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </section>

    <!-- Example -->
    <section class="max-w-5xl mx-auto px-6 py-20">
      <h2 class="text-3xl font-bold mb-2 text-center">🧮 Real Math, Fake Company</h2>
      <p class="text-gray-400 text-center mb-8">A totally hypothetical ${{ (exampleBefore).toLocaleString() }}/mo AWS account (it's not hypothetical 👀)</p>
      <div class="max-w-lg mx-auto bg-gray-900 border border-gray-800 rounded-2xl p-8">
        <div class="space-y-4">
          <div class="flex justify-between">
            <span class="text-gray-400">🔥 Monthly waste identified</span>
            <span class="font-semibold text-red-400">${{ exampleSavings.toLocaleString() }}/mo</span>
          </div>
          <div class="flex justify-between">
            <span class="text-gray-400">💰 Annual savings (just... sitting there)</span>
            <span class="font-semibold">${{ exampleAnnual.toLocaleString() }}/yr</span>
          </div>
          <hr class="border-gray-700">
          <div class="flex justify-between">
            <span class="text-gray-400">🔍 Down payment (part of audit fee)</span>
            <span class="font-semibold">${{ scanDeposit }}</span>
          </div>
          <div class="flex justify-between">
            <span class="text-gray-400">📋 Remaining audit fee (10% minus $99)</span>
            <span class="font-semibold">${{ auditFee.toLocaleString() }}</span>
          </div>
          <div class="flex justify-between">
            <span class="text-gray-400">🔧 Implementation fee (25% of proven savings)</span>
            <span class="font-semibold">${{ implFee.toLocaleString() }}</span>
          </div>
          <hr class="border-gray-700">
          <div class="flex justify-between text-lg">
            <span class="font-bold text-brand-400">🎉 You keep (year 1)</span>
            <span class="font-bold text-brand-400">${{ clientNet.toLocaleString() }}</span>
          </div>
          <div class="flex justify-between text-lg">
            <span class="font-bold text-green-400">🚀 You keep (every year after)</span>
            <span class="font-bold text-green-400">${{ exampleAnnual.toLocaleString() }}</span>
          </div>
        </div>
      </div>
    </section>

    <!-- Common Waste -->
    <section class="bg-gray-900/50 border-y border-gray-800">
      <div class="max-w-5xl mx-auto px-6 py-20">
        <h2 class="text-3xl font-bold mb-2 text-center">🕵️ The Usual Suspects</h2>
        <p class="text-gray-400 text-center mb-8">I find these in almost every AWS account. Yours probably has at least 4.</p>
        <div class="max-w-2xl mx-auto space-y-3">
          <div
            v-for="item in wasteSources"
            :key="item.name"
            class="flex items-center justify-between bg-gray-900 border border-gray-800 rounded-xl px-6 py-4"
          >
            <span class="text-gray-300"><span class="mr-2">{{ item.emoji }}</span>{{ item.name }}</span>
            <span class="text-brand-400 font-semibold text-sm whitespace-nowrap ml-4">{{ item.savings }}</span>
          </div>
        </div>
      </div>
    </section>

    <!-- About -->
    <section class="max-w-5xl mx-auto px-6 py-20">
      <div class="max-w-2xl mx-auto text-center">
        <h2 class="text-3xl font-bold mb-6">👋 Who's poking around my AWS account?</h2>
        <p class="text-gray-400 text-lg leading-relaxed mb-4">
          I'm David Plappert. I build and run production SaaS on AWS &mdash; Lambda, API Gateway,
          S3, SES, the whole serverless buffet. 🍱 I've done this at Fortune 100 scale and for scrappy
          startups that count every penny. I know where AWS hides the markup because I've been paying it myself for years.
        </p>
        <p class="text-gray-400 text-lg leading-relaxed mb-4">
          I only need <strong class="text-gray-200">read-only access</strong> for the scan. 🔒
          No write permissions. I can look but I can't touch. Think of it as window shopping your infrastructure.
        </p>
        <p class="text-gray-500 text-base">
          Yes, "Cut My AWS" is a real business name. No, I will not apologize for it. ✂️
        </p>
      </div>
    </section>

    <!-- FAQ -->
    <section class="bg-gray-900/50 border-y border-gray-800">
      <div class="max-w-5xl mx-auto px-6 py-20">
        <h2 class="text-3xl font-bold mb-12 text-center">❓ Questions you're definitely asking</h2>
        <div class="max-w-2xl mx-auto space-y-8">
          <div>
            <h3 class="text-lg font-bold mb-2">🤔 What if you don't find any savings?</h3>
            <p class="text-gray-400">Then you have the most optimized AWS account I've ever seen and I owe you a genuine apology. You're out $99. In 50+ audits this has happened exactly zero times, but I suppose there's a first for everything.</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🤨 Is the $99 an extra fee on top of the 10%?</h3>
            <p class="text-gray-400">Nope! The $99 is a down payment on the 10% audit fee. It comes right off your invoice. If I find $84K/yr in savings, your 10% audit fee is $8,400 &mdash; minus the $99 you already paid = $8,301 remaining. The $99 just gets us started so I'm not doing free work for tire-kickers. 😅</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🧑‍💻 Can't I just use AWS Cost Explorer myself?</h3>
            <p class="text-gray-400">You can! And you should! But Cost Explorer shows you <em>what</em> you're spending. I show you <em>why</em> it's too much and exactly how to fix it. It's the difference between a thermometer and a doctor. 🌡️</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🛠️ What if my team can implement the fixes themselves?</h3>
            <p class="text-gray-400">Great &mdash; that's what the Audit Report is for. You pay 10%, get the full playbook, and your team runs with it. I don't get offended. I get paid and you get savings. Everyone wins. 🎉</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">😰 How do I know you won't break something?</h3>
            <p class="text-gray-400">The scan uses read-only access. I literally cannot change anything. For implementation, every change is documented, reviewed with your team, and rolled out carefully. I break things on my own AWS account, not yours. 😅</p>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA -->
    <section class="max-w-5xl mx-auto px-6 py-20 text-center">
      <h2 class="text-3xl font-bold mb-4">Your AWS bill isn't going to cut itself. ✂️</h2>
      <p class="text-xl text-gray-400 mb-8">$99. 15 minutes. One call that might save you thousands. 💰</p>
      <a
        :href="calendlyUrl"
        target="_blank"
        class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg"
      >
        🗓️ Book Your $99 AWS Intervention
      </a>
      <p class="text-gray-600 text-sm mt-4">$99 down payment on your 10% audit fee. No extra charges. No hard sell. Just math. 🧮</p>
    </section>

    <!-- Footer -->
    <footer class="border-t border-gray-800 bg-gray-900/50">
      <div class="max-w-5xl mx-auto px-6 py-8 flex flex-col sm:flex-row items-center justify-between gap-4 text-sm text-gray-500">
        <span>✂️ &copy; {{ new Date().getFullYear() }} Smart Talk LLC. All rights reserved.</span>
        <a href="mailto:david@cutmyaws.com" class="hover:text-gray-300 transition-colors">📧 david@cutmyaws.com</a>
      </div>
    </footer>
  </div>
</template>
