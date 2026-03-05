<script setup>
const calendlyUrl = 'https://calendly.com/phonelivestreaming/cutmyaws-com-intro'

// Promo: free security scan — update this date to extend/end the promo
const promoEnd = new Date('2026-04-04T23:59:59')
const now = new Date()
const promoActive = now < promoEnd
const promoDaysLeft = Math.max(0, Math.ceil((promoEnd.getTime() - now.getTime()) / (1000 * 60 * 60 * 24)))

const stats = [
  { value: '30-40%', label: '📊 Average waste hiding in AWS accounts' },
  { value: '$99', label: '🔍 Down payment on your 10% audit fee' },
  { value: '20+ years', label: '⚡ Of AWS experience. Not an AI. Not a dashboard. A person.' }
]

const wasteSources = [
  { emoji: '🖥️', name: 'Servers running 24/7 for workloads that should be serverless', savings: '40-70%' },
  { emoji: '🏗️', name: 'Enterprise-grade databases for apps with 50 users', savings: '30-60%' },
  { emoji: '🧘', name: 'EC2 instances running hot yoga while doing nothing', savings: '20-40%' },
  { emoji: '🤷', name: 'Savings Plans you didn\'t know existed', savings: '30-50%' },
  { emoji: '🦕', name: 'EBS volumes and snapshots from the Obama administration', savings: '$100-1,000/mo' },
  { emoji: '🍽️', name: 'NAT Gateway quietly eating your budget for lunch', savings: '$200-2,000/mo' },
  { emoji: '🐿️', name: 'Architecture designed for a business model that pivoted 2 years ago', savings: '20-50%' }
]

const exampleBefore = 20000
const exampleSavings = 7000
const exampleAnnual = exampleSavings * 12
const scanDeposit = 99
const reportFee = Math.round(exampleAnnual * 0.10)
const fixFee = Math.round(exampleAnnual * 0.25) // 10% report + 15% implementation = 25% total
const reportNet = exampleAnnual - reportFee
const fixNet = exampleAnnual - fixFee
</script>

<template>
  <div class="min-h-screen bg-gray-950 text-gray-100">
    <!-- Promo Banner -->
    <div v-if="promoActive" class="bg-brand-600 text-white text-center py-2.5 px-6 text-sm font-medium">
      <a :href="calendlyUrl" target="_blank" class="hover:underline">
        🔒 FREE security scan with every audit — misconfigs, public buckets, IAM risks — ends in {{ promoDaysLeft }} day{{ promoDaysLeft === 1 ? '' : 's' }}!
      </a>
    </div>

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
          Your tech stack wasn't built for<br>
          <span class="text-brand-400">how your business actually works. ✂️</span>
        </h1>
        <p class="text-xl text-gray-400 mb-4 max-w-2xl">
          Most AWS accounts aren't just overpriced &mdash; they're misaligned. Servers running 24/7 for workloads that spike 2 hours a day.
          Enterprise databases for apps with 50 users. Infrastructure built for a business plan that changed three pivots ago. 💸
        </p>
        <p class="text-xl text-gray-400 mb-8 max-w-2xl">
          I don't just find waste &mdash; I find the <strong class="text-gray-200">mismatch between your tech and your business.</strong>
          The cost savings are a side effect of getting that right.
          $99 starts the conversation. 🤷
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
        "Most companies don't have a cost problem. They have an alignment problem.
        The bill is just the symptom." 🎯
      </p>
      <p class="text-gray-500 mt-4">&mdash; David, who has fixed a lot of symptoms by treating the actual disease</p>
    </section>

    <!-- How It Works -->
    <section class="bg-gray-900/50 border-y border-gray-800">
      <div class="max-w-5xl mx-auto px-6 py-20">
        <h2 class="text-3xl font-bold mb-4 text-center">How It Works 🧰</h2>
        <p class="text-gray-400 text-center mb-12 max-w-xl mx-auto">Two calls. One report. Zero pressure. You decide how far to go after you see the numbers. 🤝</p>

        <!-- Timeline -->
        <div class="max-w-2xl mx-auto space-y-6">

          <!-- Step 1: Intro Call -->
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8">
            <div class="flex items-center gap-3 mb-4">
              <span class="bg-brand-500 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">1</span>
              <div>
                <h3 class="text-xl font-bold">🗓️ Intro Call</h3>
                <p class="text-gray-500 text-sm">15 min &middot; $99 down payment</p>
              </div>
            </div>
            <p class="text-gray-400">You book a call, pay $99, and grant read-only AWS access. We meet, I walk you through what I see, and we make sure I have everything I need to go deep. 🔍</p>
            <p class="text-gray-500 text-sm mt-3">The $99 is a down payment on your 10% audit fee &mdash; not an extra charge.</p>
          </div>

          <!-- Arrow -->
          <div class="text-center text-gray-600 text-2xl">⏳ 5-10 business days (I'm digging through your account)</div>

          <!-- Step 2: Exploration Call -->
          <div class="bg-gray-900 border-2 border-brand-500 rounded-2xl p-8">
            <div class="flex items-center gap-3 mb-4">
              <span class="bg-brand-500 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">2</span>
              <div>
                <h3 class="text-xl font-bold">📋 Exploration Call &mdash; The Report</h3>
                <p class="text-gray-500 text-sm">10% of annual savings found (minus your $99)</p>
              </div>
            </div>
            <p class="text-gray-400 mb-4">I present the full findings: every waste item, exact dollar amounts, architecture recommendations, and where your tech doesn't match your business needs. You get everything as a PDF. 📄</p>
            <ul class="space-y-3 text-gray-300">
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>Line-by-line savings breakdown your CFO will actually understand</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>Implementation guide for your team (if you want to DIY) 🛠️</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>You keep the report forever. Even if you ghost me. 👻</span>
              </li>
              <li v-if="promoActive" class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">🎁</span>
                <span><strong class="text-brand-400">BONUS:</strong> Free AWS security scan included &mdash; misconfigs, public S3 buckets, overprivileged IAM roles ({{ promoDaysLeft }} day{{ promoDaysLeft === 1 ? '' : 's' }} left!)</span>
              </li>
            </ul>
            <p class="text-gray-500 text-sm mt-4">Remainder of the 10% fee is due at this call. Your $99 down payment comes right off.</p>
          </div>

          <!-- Arrow -->
          <div class="text-center text-gray-600 text-2xl">🤔 Want me to fix it too?</div>

          <!-- Step 3: Implementation (Optional) -->
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8 relative">
            <div class="absolute -top-3 right-6 bg-brand-500 text-white text-xs font-bold px-3 py-1 rounded-full">🔥 OPTIONAL</div>
            <div class="flex items-center gap-3 mb-4">
              <span class="bg-gray-700 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">3</span>
              <div>
                <h3 class="text-xl font-bold">🔧 The Fix &mdash; Implementation</h3>
                <p class="text-gray-500 text-sm">Decided at the exploration call &middot; scoped together</p>
              </div>
            </div>
            <p class="text-gray-400 mb-4">At the exploration call, you decide if you want me to implement the fixes. We agree on a timeline, deliverables, and scope before any work starts. 🤝</p>
            <ul class="space-y-3 text-gray-300">
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>I implement every optimization (you watch or nap, your call 😴)</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>Custom timeline and deliverables we agree on together</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span>90 days after deliverables are complete, we verify the savings are real 📊</span>
              </li>
              <li class="flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">✅</span>
                <span><strong>+15% of verified savings due at the 90-day mark.</strong> If the savings didn't stick, you don't pay. 🤷</span>
              </li>
            </ul>
            <p class="text-gray-500 text-sm mt-4">25% total is the absolute max (10% report + 15% implementation). No surprises. No hidden fees.</p>
          </div>

          <!-- Arrow -->
          <div class="text-center text-gray-600 text-2xl">⏳ 90 days later...</div>

          <!-- Step 4: Verification -->
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8">
            <div class="flex items-center gap-3 mb-4">
              <span class="bg-gray-700 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">4</span>
              <div>
                <h3 class="text-xl font-bold">📊 The Proof</h3>
                <p class="text-gray-500 text-sm">+15% of verified annual savings</p>
              </div>
            </div>
            <p class="text-gray-400">We compare your AWS bill before vs. after. The 15% implementation fee is based on <strong class="text-gray-200">actual, verified savings</strong> &mdash; not projections, not estimates. Real numbers on a real bill. If the savings didn't materialize, you owe nothing for implementation. 💰</p>
          </div>

        </div>
      </div>
    </section>

    <!-- Example -->
    <section class="max-w-5xl mx-auto px-6 py-20">
      <h2 class="text-3xl font-bold mb-2 text-center">🧮 Real Math, Fake Company</h2>
      <p class="text-gray-400 text-center mb-8">A totally hypothetical ${{ (exampleBefore).toLocaleString() }}/mo AWS account (it's not hypothetical 👀)</p>

      <!-- Shared finding -->
      <div class="max-w-2xl mx-auto bg-gray-900 border border-gray-800 rounded-2xl p-6 mb-6">
        <div class="flex justify-between mb-2">
          <span class="text-gray-400">🔥 Monthly waste identified</span>
          <span class="font-semibold text-red-400">${{ exampleSavings.toLocaleString() }}/mo</span>
        </div>
        <div class="flex justify-between">
          <span class="text-gray-400">💰 Annual savings (just... sitting there)</span>
          <span class="font-semibold">${{ exampleAnnual.toLocaleString() }}/yr</span>
        </div>
      </div>

      <!-- Payment timeline -->
      <div class="max-w-2xl mx-auto bg-gray-900 border border-gray-800 rounded-2xl p-8">
        <h3 class="font-bold text-center mb-6">💳 When you pay (with The Fix)</h3>
        <div class="space-y-4 text-sm">
          <div class="flex justify-between items-center">
            <div>
              <span class="text-gray-300 font-medium">🗓️ Intro Call</span>
              <span class="text-gray-500 ml-2">Day 1</span>
            </div>
            <span class="font-semibold">${{ scanDeposit }}</span>
          </div>
          <div class="flex justify-between items-center">
            <div>
              <span class="text-gray-300 font-medium">📋 Exploration Call</span>
              <span class="text-gray-500 ml-2">~2 weeks</span>
            </div>
            <span class="font-semibold">${{ (reportFee - scanDeposit).toLocaleString() }}</span>
          </div>
          <div class="text-gray-500 text-xs pl-4">10% of ${{ exampleAnnual.toLocaleString() }} = ${{ reportFee.toLocaleString() }} minus ${{ scanDeposit }} down payment</div>
          <div class="flex justify-between items-center">
            <div>
              <span class="text-gray-300 font-medium">📊 90 Days After Implementation</span>
              <span class="text-gray-500 ml-2">~4-5 months</span>
            </div>
            <span class="font-semibold">${{ (fixFee - reportFee).toLocaleString() }}</span>
          </div>
          <div class="text-gray-500 text-xs pl-4">15% of <strong>verified</strong> savings only. No savings = $0 owed.</div>
          <hr class="border-gray-700">
          <div class="flex justify-between text-base">
            <span class="font-bold text-gray-300">Total max (25%)</span>
            <span class="font-bold">${{ fixFee.toLocaleString() }}</span>
          </div>
          <div class="flex justify-between text-base">
            <span class="font-bold text-brand-400">🎉 You keep (year 1)</span>
            <span class="font-bold text-brand-400">${{ fixNet.toLocaleString() }}</span>
          </div>
          <div class="flex justify-between text-base">
            <span class="font-bold text-green-400">🚀 Every year after</span>
            <span class="font-bold text-green-400">${{ exampleAnnual.toLocaleString() }}</span>
          </div>
        </div>
      </div>
      <p class="text-gray-500 text-sm text-center mt-4">Report only? Just 10%. Skip the implementation and your team handles it. You keep ${{ reportNet.toLocaleString() }} year one. 💰</p>
    </section>

    <!-- Common Waste -->
    <section class="bg-gray-900/50 border-y border-gray-800">
      <div class="max-w-5xl mx-auto px-6 py-20">
        <h2 class="text-3xl font-bold mb-2 text-center">🕵️ The Usual Suspects</h2>
        <p class="text-gray-400 text-center mb-8">Tech decisions that made sense once but don't match the business anymore. I find these in almost every account.</p>
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
        <img src="/david.png" alt="David Plappert" class="w-32 h-32 rounded-full mx-auto mb-6 object-cover object-top border-2 border-gray-700">
        <h2 class="text-3xl font-bold mb-6">👋 Who's poking around my AWS account?</h2>
        <p class="text-gray-400 text-lg leading-relaxed mb-4">
          I'm <a href="https://www.linkedin.com/in/davidplappert/" target="_blank" class="text-brand-400 hover:underline">David Plappert</a> &mdash; an actual human with 20+ years of AWS experience who will personally
          dig through your account, read your architecture, and understand your business. 🍱 Not an AI summary.
          Not a dashboard with red and green dots. Me, on a call, with opinions.
        </p>
        <p class="text-gray-400 text-lg leading-relaxed mb-4">
          I build and run production serverless SaaS at Fortune 100 scale. Lambda, API Gateway, S3, SES &mdash;
          the whole buffet. Most cost tools tell you what you're spending.
          I tell you <em>why</em> your tech doesn't match your business &mdash; and I make it <strong class="text-gray-200">not just cheaper, but better.</strong> 🎯
        </p>
        <p class="text-gray-400 text-lg leading-relaxed mb-4">
          Should that EC2 fleet be Lambda functions? Does that RDS instance need to be that big for 200 daily active users?
          Is your architecture built for a business model that pivoted two years ago? I ask the questions a dashboard can't. 🤔
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
            <h3 class="text-lg font-bold mb-2">🤨 When do I actually pay?</h3>
            <p class="text-gray-400">$99 at booking (down payment). Remainder of 10% at the exploration call when you get the report. If you opt for implementation, the extra 15% isn't due until <strong>90 days after deliverables</strong> &mdash; and only on verified savings. You never pay for results that didn't happen. 😅</p>
          </div>
          <div>
            <h3 class="text-lg font-bold mb-2">🎯 Is this just a cost audit or something more?</h3>
            <p class="text-gray-400">More. Way more. Cost tools tell you <em>what</em> you're spending. I tell you <em>why</em> your tech doesn't match your business &mdash; and that's where the real savings live. Running servers 24/7 for a workload that spikes twice a day? That's not a billing problem, that's an architecture problem. I fix both.</p>
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
            <h3 class="text-lg font-bold mb-2">🤖 How is this different from CloudHealth / ProsperOps / [insert SaaS tool]?</h3>
            <p class="text-gray-400">Those are dashboards. They scan your account and show you charts. I'm a person who reads your architecture, understands your business, gets on a call with you, and tells you exactly what to change and why. Dashboards find obvious waste. I find the structural misalignment between your tech and your business that no tool can see. Also, I have opinions and a sense of humor. Dashboards have neither. 😏</p>
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
        <div class="flex items-center gap-4">
          <a href="https://www.linkedin.com/in/davidplappert/" target="_blank" class="hover:text-gray-300 transition-colors">💼 LinkedIn</a>
          <a href="mailto:david@cutmyaws.com" class="hover:text-gray-300 transition-colors">📧 david@cutmyaws.com</a>
        </div>
      </div>
    </footer>
  </div>
</template>
