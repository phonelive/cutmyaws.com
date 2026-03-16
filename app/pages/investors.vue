<script setup>
useHead({
  title: 'Cut Your Portfolio Companies\' AWS Costs — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})

const { pricing, promoActive, promoDaysLeft, minAwsK, calendly, calculateExample } = usePricing()

// Example: $25K/mo AWS spend, 36% waste found
const exampleAwsMonthly = 25000
const exampleWastePct = 36
const ex = calculateExample(exampleAwsMonthly, exampleWastePct)
const monthsToRoi = ex.monthsToRoi

// ── Stats ──
const stats = [
  { value: '30–40%', label: 'Average waste per account (yes, really 😳)' },
  { value: `${monthsToRoi} mo`, label: 'Time to ROI — faster than your next board meeting', color: 'text-green-400' },
  { value: '19 yrs', label: 'AWS experience — since before it was cool (2007)' },
]

// ── Value prop cards ──
const valueProps = [
  { emoji: '💸', title: 'Pay on results', description: 'No retainer. No hourly. You pay a percentage of verified savings — if I don\'t find waste, you owe nothing. Wild concept for consulting, I know. 🤷' },
  { emoji: '⏱️', title: `${monthsToRoi}-month ROI`, description: `Most engagements pay for themselves within ${monthsToRoi} months. After that, every dollar saved goes straight to runway. CFOs love this. Investors love it more. 😏` },
  { emoji: '🔁', title: 'No recurring fees', description: 'I\'m not another SaaS on your portfolio\'s credit card. One engagement, permanent savings. The only thing that recurs is the money your companies keep. Every. Single. Month.' },
]

// ── Qualifier items ──
const qualifierItems = [
  { text: `Spending <span class="text-gray-200 font-semibold">${minAwsK}+/mo</span> on AWS` },
  { text: 'Engineering team is <span class="text-gray-200 font-semibold">too busy shipping</span> to optimize infra' },
  { text: 'AWS bill has been <span class="text-gray-200 font-semibold">growing unsupervised</span> since launch' },
  { text: 'Nobody on the team has <span class="text-gray-200 font-semibold">done a cost audit</span> in the last 12 months' },
]

// ── Waste sources ──
const wasteSources = [
  { emoji: '🖥️', service: 'EC2', name: 'Servers running 24/7 for a workload that shows up at 9am and leaves at 5pm', savings: '40-70%' },
  { emoji: '🏗️', service: 'RDS', name: 'A database the size of a school bus for an app with 50 users', savings: '30-60%' },
  { emoji: '🧘', service: 'EC2', name: 'Instances in a meditative state (they\'re not meditating, they\'re idle)', savings: '20-40%' },
  { emoji: '💳', service: 'Savings Plans', name: 'AWS literally wants you to buy these but nobody told you', savings: '30-50%' },
  { emoji: '🦕', service: 'EBS', name: 'Snapshots so old they remember when us-east-1 was the only region', savings: '$100-1K/mo' },
  { emoji: '🍽️', service: 'NAT GW', name: 'Quietly eating your budget for lunch every single day', savings: '$200-2K/mo' },
  { emoji: '🐿️', service: 'Architecture', name: 'Built for the pitch deck, not the business you\'re actually running', savings: '20-50%' },
]

// ── Investor FAQ questions ──
const faqQuestions = [
  { emoji: '🤔', question: 'Can you audit multiple portfolio companies?', answer: 'Absolutely. That\'s the whole idea. I can run audits in parallel across your portfolio. Volume discounts available &mdash; email <a href="mailto:david@cutmyaws.com" class="text-brand-400 hover:underline">david@cutmyaws.com</a> for bulk pricing. Each company gets its own report, its own findings, its own savings. 📊' },
  { emoji: '📋', question: 'What does this look like in a board deck?', answer: 'One slide: "We reduced AWS spend by X% across N portfolio companies, saving $Y annually. One-time cost, permanent savings, zero headcount impact." Your LPs will love it. I can even help you draft the slide. 🎯' },
  { emoji: '🤝', question: 'How do I introduce you to my CTOs?', answer: 'Forward one email. I\'ll take it from there &mdash; 15-minute intro call, I explain the process, they grant read-only access, and 5-10 business days later they have a full report. Zero disruption to their engineering roadmap. The lowest-effort, highest-ROI introduction you\'ll make this quarter. ⌨️' },
  { emoji: '💰', question: 'What if you don\'t find any savings?', answer: 'Then your portfolio companies have the most optimized AWS accounts I\'ve ever seen. In my career this has happened exactly zero times, but I hear there\'s a first time for everything. No savings = no fee. You literally cannot lose. 🤷' },
  { emoji: '🔒', question: 'What access do you need?', answer: 'Read-only IAM role. I can look but I literally cannot touch. Your portfolio company\'s team provisions the role, controls it the entire time, and deletes it when we\'re done. I audit infrastructure and architecture, not application data. 👀' },
  { emoji: '📏', question: 'What size companies benefit most?', answer: `Companies spending ${minAwsK}+/mo on AWS. Below that, there usually isn't enough waste to justify an engagement. The sweet spot is $10K-$100K/mo &mdash; big enough to have real infrastructure, too busy building product to optimize it. 🫡` },
]
</script>

<template>
  <PageSections>
    <!-- Hero -->
    <section class="relative overflow-hidden">
      <div class="absolute inset-0 bg-gradient-to-br from-brand-500/5 via-transparent to-brand-500/3"></div>
      <div class="absolute top-0 right-0 w-[600px] h-[600px] bg-brand-500/5 rounded-full blur-3xl -translate-y-1/2 translate-x-1/3"></div>
      <div class="relative max-w-5xl mx-auto px-6 pt-16 pb-16">
        <div class="flex flex-col lg:flex-row gap-12 items-center">
          <!-- Left: Text -->
          <div class="flex-1">
            <p class="text-brand-400 text-sm font-bold uppercase tracking-wide mb-3">Every startup I audit wastes 30–40% on AWS</p>
            <h1 class="text-3xl sm:text-4xl font-extrabold leading-tight mb-4">
              Your portfolio is <span class="text-red-400">burning ${{ (ex.monthlySavings / 1000).toFixed(0) }}K+/mo</span> on AWS nobody audited.
            </h1>
            <p class="text-gray-400 text-lg mb-4">
              One engagement. Permanent savings. No savings? <strong class="text-gray-200">No fee.</strong>
            </p>
            <p class="text-gray-500 text-base mb-8">
              I read the architecture, find the mismatch between tech and business, and tell you exactly what to change — while their engineering team stays focused on shipping. 🚀
            </p>
            <div class="flex flex-col sm:flex-row gap-4">
              <a
                href="#book"
                class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-bold px-10 py-5 sm:px-8 sm:py-4 rounded-xl text-xl sm:text-lg transition-colors text-center w-full sm:w-auto"
              >
                🗓️ Book Your Free Intro Call
              </a>
              <p class="text-brand-400/80 text-xs font-semibold self-center sm:self-start">⚡ Book in 30 seconds</p>
              <p class="text-gray-500 text-sm self-center sm:self-start">15 min · free · no pitch deck 😏</p>
            </div>
          </div>

          <!-- Right: David card -->
          <div class="w-full lg:w-[380px] shrink-0">
            <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8 text-center">
              <img src="/david.png" alt="David Plappert" width="112" height="112" fetchpriority="high" class="w-28 h-28 rounded-full mx-auto mb-5 object-cover object-top border-2 border-gray-700">
              <p class="font-bold text-lg mb-1">David Plappert</p>
              <p class="text-gray-500 text-sm mb-6">Senior AWS Architect · 19 years ☕</p>

              <div class="space-y-2 text-left text-sm">
                <div class="flex items-center gap-2 text-gray-400">
                  <span class="text-brand-400">✅</span> Pay only a % of verified savings
                </div>
                <div class="flex items-center gap-2 text-gray-400">
                  <span class="text-brand-400">✅</span> No savings? No fee. Period.
                </div>
                <div class="flex items-center gap-2 text-gray-400">
                  <span class="text-brand-400">✅</span> One engagement, permanent savings
                </div>
                <div class="flex items-center gap-2 text-gray-400">
                  <span class="text-brand-400">✅</span> No recurring fees or SaaS subscriptions
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Calendly Embed (above the fold) -->
    <section id="book-section">
      <CalendlyEmbed campaign="investors" />
    </section>

    <!-- Video -->
    <YouTubeEmbed video-id="ZVUOW87e-Jc" label="intro" page="investors" />

    <!-- Stats -->
    <SectionStats :stats="stats" />

    <!-- Client Logos (moved up — social proof early) -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-12">
        <ClientLogos />
      </div>
    </section>

    <!-- Dollar Example -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-16 text-center">
        <h2 class="text-2xl font-bold mb-2">The math on a typical portfolio company 🧮</h2>
        <p class="text-gray-500 text-sm mb-8">${{ (exampleAwsMonthly / 1000).toFixed(0) }}K/mo AWS spend · {{ exampleWastePct }}% waste found</p>
        <div class="grid sm:grid-cols-3 gap-6">
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6">
            <p class="text-green-400 text-3xl font-bold">${{ (ex.annualSavings / 1000).toFixed(0) }}K</p>
            <p class="text-gray-500 text-sm mt-2">Annual savings found</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6">
            <p class="text-brand-400 text-3xl font-bold">${{ (ex.fixFee / 1000).toFixed(0) }}K</p>
            <p class="text-gray-500 text-sm mt-2">Max total fee ({{ pricing.reportPct }}% + {{ pricing.implPct }}%)</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6">
            <p class="text-green-400 text-3xl font-bold">${{ (ex.annualSavings / 1000).toFixed(0) }}K</p>
            <p class="text-gray-500 text-sm mt-2">Saved every year after — forever 🎉</p>
          </div>
        </div>
        <p class="text-gray-600 text-xs mt-6">Year 1 net: ${{ (ex.fixNet / 1000).toFixed(0) }}K kept · Year 2+: full ${{ (ex.annualSavings / 1000).toFixed(0) }}K/yr goes straight to runway</p>
      </div>
    </section>

    <!-- How it works -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-16 text-center">
        <h2 class="text-2xl font-bold mb-2">How it works for portfolio companies</h2>
        <p class="text-gray-500 text-sm mb-8">Three steps. Less effort than reading a pitch deck. 📄</p>
        <div class="grid sm:grid-cols-3 gap-8 text-left">
          <div>
            <p class="text-brand-400 text-sm font-bold mb-2">STEP 1</p>
            <h3 class="font-bold mb-1">You forward one email</h3>
            <p class="text-gray-500 text-sm">Introduce David to your portfolio company's CTO. That's it. Lowest effort, highest ROI move you'll make this quarter. ⌨️</p>
          </div>
          <div>
            <p class="text-brand-400 text-sm font-bold mb-2">STEP 2</p>
            <h3 class="font-bold mb-1">David audits the account</h3>
            <p class="text-gray-500 text-sm">Read-only access, 5–10 business days. Full report: every waste item, dollar amounts, architecture fixes. The kind of due diligence AWS hopes nobody does. 🔍</p>
          </div>
          <div>
            <p class="text-brand-400 text-sm font-bold mb-2">STEP 3</p>
            <h3 class="font-bold mb-1">Savings hit the P&L</h3>
            <p class="text-gray-500 text-sm">Your portfolio company keeps the savings forever. One-time fee based on verified savings. No recurring costs. No "enterprise plan." 🎉</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Value props -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-16">
        <ValuePropCards :cards="valueProps" :columns="3" />
      </div>
    </section>

    <!-- Qualifier -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-16 text-center">
        <QualifierSection
          headline="Your portfolio company is a good fit if… 🎯"
          subheadline="Not every company needs this. Here's who gets the most value."
          :items="qualifierItems"
          layout="grid"
        />
      </div>
    </section>

    <!-- Testimonials -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-12">
        <Testimonials />
      </div>
    </section>

    <!-- Case Studies -->
    <section>
      <CaseStudies />
    </section>

    <!-- Common Waste / Usual Suspects -->
    <section>
      <div class="max-w-5xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-2 text-center">🕵️ What I Find in Every Portfolio Company</h2>
        <p class="text-gray-400 text-center mb-8">Decisions that made sense at the time. That time was 2021. It's not 2021 anymore.</p>
        <WasteList :items="wasteSources" />
      </div>
    </section>

    <!-- Security & Compliance -->
    <section>
      <SecuritySection />
    </section>

    <!-- Security Promo (if active) -->
    <SecurityPromo />

    <!-- About David -->
    <section>
      <AboutSection />
    </section>

    <!-- FAQ -->
    <section>
      <FaqSection
        headline="❓ Questions investors ask"
        :questions="faqQuestions"
      />
    </section>

    <!-- Bottom Calendly Embed -->
    <section>
      <CalendlyEmbed campaign="investors-bottom" anchor-id="book-bottom" />
    </section>

    <!-- Bottom CTA -->
    <CtaSection
      headline="Extend runway without cutting headcount."
      subtext="One engagement. Permanent savings. Your board deck gets a new slide and your portfolio companies stop lighting money on fire. 📊"
      cta-link="#book"
      :bg="false"
    >
      <p class="text-gray-600 text-sm mt-3">
        Multiple portfolio companies?
        <a href="mailto:david@cutmyaws.com?subject=Portfolio%20AWS%20Optimization%20%E2%9C%82%EF%B8%8F&body=Hey%20David%2C%0A%0AI%20invest%20in%20%5B%23%5D%20companies%20running%20on%20AWS.%20Let's%20talk%20about%20portfolio%20pricing." class="text-brand-400 hover:underline">Email David for bulk pricing</a> — volume discounts available 🧮
      </p>
      <p class="text-gray-600 text-sm mt-6">
        Prefer email? <a href="mailto:david@cutmyaws.com?subject=Portfolio%20AWS%20Optimization%20%E2%9C%82%EF%B8%8F&body=Hey%20David%2C%0A%0AI%20invest%20in%20%5B%23%5D%20companies%20running%20on%20AWS.%20Let's%20talk." class="text-brand-400 hover:underline">david@cutmyaws.com</a>
      </p>
    </CtaSection>

    <!-- Mobile sticky CTA -->
    <MobileStickyCtaBar
      link="#book"
    />

  </PageSections>
</template>
