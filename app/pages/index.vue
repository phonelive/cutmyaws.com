<script setup>
const calendlyUrl = 'https://calendly.com/davidplappert/aws-scan'

const stats = [
  { value: '30-40%', label: 'Average waste in AWS accounts' },
  { value: '$0', label: 'Cost if no savings found' },
  { value: '1-2 weeks', label: 'Typical audit turnaround' }
]

const wasteSources = [
  { name: 'Idle & oversized EC2 instances', savings: '20-40%' },
  { name: 'Missing Savings Plans / RIs', savings: '30-50%' },
  { name: 'Unattached EBS volumes & old snapshots', savings: '$100-1,000/mo' },
  { name: 'Oversized RDS instances', savings: '20-40%' },
  { name: 'NAT Gateway data transfer', savings: '$200-2,000/mo' },
  { name: 'S3 without lifecycle policies', savings: '10-30%' },
  { name: 'CloudWatch logs retained forever', savings: '$50-500/mo' }
]

const exampleBefore = 20000
const exampleSavings = 7000
const exampleAnnual = exampleSavings * 12
const auditFee = Math.round(exampleAnnual * 0.10)
const implFee = Math.round(exampleAnnual * 0.25)
const clientNet = exampleAnnual - auditFee - implFee
</script>

<template>
  <div class="min-h-screen bg-gray-950 text-gray-100">
    <!-- Nav -->
    <nav class="border-b border-gray-800">
      <div class="max-w-5xl mx-auto px-6 py-4 flex items-center justify-between">
        <div class="flex items-center gap-2">
          <div class="w-8 h-8 bg-brand-500 rounded-lg flex items-center justify-center font-bold text-white text-sm">$</div>
          <span class="font-bold text-lg">Cut My AWS</span>
        </div>
        <a
          :href="calendlyUrl"
          target="_blank"
          class="bg-brand-500 hover:bg-brand-600 text-white font-semibold px-5 py-2 rounded-lg transition-colors text-sm"
        >
          Free Scan
        </a>
      </div>
    </nav>

    <!-- Hero -->
    <section class="max-w-5xl mx-auto px-6 pt-20 pb-16">
      <div class="max-w-3xl">
        <h1 class="text-4xl sm:text-5xl font-bold leading-tight mb-6">
          Your AWS bill is too high.<br>
          <span class="text-brand-400">I'll prove it.</span>
        </h1>
        <p class="text-xl text-gray-400 mb-8 max-w-2xl">
          Free 15-minute scan of your AWS spend. If I find waste, you get a full audit
          with line-by-line savings. <strong class="text-gray-200">No savings, no fee. Ever.</strong>
        </p>
        <a
          :href="calendlyUrl"
          target="_blank"
          class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg"
        >
          Book Your Free AWS Scan
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

    <!-- How It Works -->
    <section class="max-w-5xl mx-auto px-6 py-20">
      <h2 class="text-3xl font-bold mb-12 text-center">How It Works</h2>
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <!-- Option A -->
        <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8">
          <div class="text-brand-400 font-semibold text-sm uppercase tracking-wider mb-2">Option A</div>
          <h3 class="text-2xl font-bold mb-1">Audit</h3>
          <p class="text-4xl font-bold text-brand-400 mb-4">10% <span class="text-lg text-gray-400 font-normal">of identified annual savings</span></p>
          <ul class="space-y-3 text-gray-300">
            <li class="flex items-start gap-3">
              <span class="text-brand-400 mt-0.5">&#10003;</span>
              <span>Full report of every waste item with exact dollar amounts</span>
            </li>
            <li class="flex items-start gap-3">
              <span class="text-brand-400 mt-0.5">&#10003;</span>
              <span>Line-by-line savings breakdown</span>
            </li>
            <li class="flex items-start gap-3">
              <span class="text-brand-400 mt-0.5">&#10003;</span>
              <span>Implementation instructions for your team</span>
            </li>
            <li class="flex items-start gap-3">
              <span class="text-brand-400 mt-0.5">&#10003;</span>
              <span>Delivered in 1-2 weeks</span>
            </li>
          </ul>
        </div>

        <!-- Option B -->
        <div class="bg-gray-900 border-2 border-brand-500 rounded-2xl p-8 relative">
          <div class="absolute -top-3 right-6 bg-brand-500 text-white text-xs font-bold px-3 py-1 rounded-full">MOST POPULAR</div>
          <div class="text-brand-400 font-semibold text-sm uppercase tracking-wider mb-2">Option B</div>
          <h3 class="text-2xl font-bold mb-1">Audit + Implement</h3>
          <p class="text-4xl font-bold text-brand-400 mb-4">10% + 25% <span class="text-lg text-gray-400 font-normal">of realized savings</span></p>
          <ul class="space-y-3 text-gray-300">
            <li class="flex items-start gap-3">
              <span class="text-brand-400 mt-0.5">&#10003;</span>
              <span>Everything in the Audit</span>
            </li>
            <li class="flex items-start gap-3">
              <span class="text-brand-400 mt-0.5">&#10003;</span>
              <span>I implement all optimizations (or pair with your team)</span>
            </li>
            <li class="flex items-start gap-3">
              <span class="text-brand-400 mt-0.5">&#10003;</span>
              <span>90-day monitoring &amp; verification</span>
            </li>
            <li class="flex items-start gap-3">
              <span class="text-brand-400 mt-0.5">&#10003;</span>
              <span>You only pay on <strong>proven</strong> results</span>
            </li>
          </ul>
        </div>
      </div>
    </section>

    <!-- Example -->
    <section class="bg-gray-900/50 border-y border-gray-800">
      <div class="max-w-5xl mx-auto px-6 py-20">
        <h2 class="text-3xl font-bold mb-8 text-center">Example: ${{ (exampleBefore).toLocaleString() }}/mo AWS Spend</h2>
        <div class="max-w-lg mx-auto bg-gray-900 border border-gray-800 rounded-2xl p-8">
          <div class="space-y-4">
            <div class="flex justify-between">
              <span class="text-gray-400">Monthly waste identified</span>
              <span class="font-semibold">${{ exampleSavings.toLocaleString() }}/mo</span>
            </div>
            <div class="flex justify-between">
              <span class="text-gray-400">Annual savings</span>
              <span class="font-semibold">${{ exampleAnnual.toLocaleString() }}/yr</span>
            </div>
            <hr class="border-gray-700">
            <div class="flex justify-between">
              <span class="text-gray-400">Audit fee (10%)</span>
              <span class="font-semibold">${{ auditFee.toLocaleString() }}</span>
            </div>
            <div class="flex justify-between">
              <span class="text-gray-400">Implementation fee (25%)</span>
              <span class="font-semibold">${{ implFee.toLocaleString() }}</span>
            </div>
            <hr class="border-gray-700">
            <div class="flex justify-between text-lg">
              <span class="font-bold text-brand-400">Your net savings (year 1)</span>
              <span class="font-bold text-brand-400">${{ clientNet.toLocaleString() }}/yr</span>
            </div>
            <div class="flex justify-between text-lg">
              <span class="font-bold text-green-400">Every year after</span>
              <span class="font-bold text-green-400">${{ exampleAnnual.toLocaleString() }}/yr</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Common Waste -->
    <section class="max-w-5xl mx-auto px-6 py-20">
      <h2 class="text-3xl font-bold mb-8 text-center">What I Look For</h2>
      <div class="max-w-2xl mx-auto space-y-3">
        <div
          v-for="item in wasteSources"
          :key="item.name"
          class="flex items-center justify-between bg-gray-900 border border-gray-800 rounded-xl px-6 py-4"
        >
          <span class="text-gray-300">{{ item.name }}</span>
          <span class="text-brand-400 font-semibold text-sm whitespace-nowrap ml-4">{{ item.savings }}</span>
        </div>
      </div>
    </section>

    <!-- About -->
    <section class="bg-gray-900/50 border-y border-gray-800">
      <div class="max-w-5xl mx-auto px-6 py-20">
        <div class="max-w-2xl mx-auto text-center">
          <h2 class="text-3xl font-bold mb-6">About</h2>
          <p class="text-gray-400 text-lg leading-relaxed mb-4">
            I'm David Plappert &mdash; a Senior AWS Serverless Architect with production experience at
            Fortune 100 companies. I build and operate SaaS platforms on AWS (Lambda, API Gateway,
            S3, SES, DynamoDB, TiDB) and know exactly where the waste hides.
          </p>
          <p class="text-gray-400 text-lg leading-relaxed">
            I only require <strong class="text-gray-200">read-only access</strong> for the audit.
            No write access until you sign on for implementation.
          </p>
        </div>
      </div>
    </section>

    <!-- CTA -->
    <section class="max-w-5xl mx-auto px-6 py-20 text-center">
      <h2 class="text-3xl font-bold mb-4">Ready to cut your AWS bill?</h2>
      <p class="text-xl text-gray-400 mb-8">Free 15-minute scan. No commitment. No credit card.</p>
      <a
        :href="calendlyUrl"
        target="_blank"
        class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg"
      >
        Book Your Free AWS Scan
      </a>
    </section>

    <!-- Footer -->
    <footer class="border-t border-gray-800 bg-gray-900/50">
      <div class="max-w-5xl mx-auto px-6 py-8 flex flex-col sm:flex-row items-center justify-between gap-4 text-sm text-gray-500">
        <span>&copy; {{ new Date().getFullYear() }} Smart Talk LLC. All rights reserved.</span>
        <a href="mailto:david@cutmyaws.com" class="hover:text-gray-300 transition-colors">david@cutmyaws.com</a>
      </div>
    </footer>
  </div>
</template>
