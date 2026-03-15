<script setup>
useHead({
  title: 'AWS Cost Optimization for Government Agencies — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})

const { pricing, promoActive, promoDaysLeft, minAwsK, calendly, calculateExample } = usePricing()

// Example: $50K/mo AWS spend, 35% waste found (typical government account)
const exampleAwsMonthly = 50000
const exampleWastePct = 35
const ex = calculateExample(exampleAwsMonthly, exampleWastePct)

// ── Stats ──
const stats = [
  { value: '30%', label: 'Cost reduction across 3 state healthcare exchanges 🏥' },
  { value: '6', label: 'Government AWS accounts managed across DC, MA & more 🏛️' },
  { value: '19 yrs', label: 'AWS experience — in production since 2007 ☁️' },
]

// ── Value prop cards ──
const valueProps = [
  { emoji: '🏛️', title: 'Taxpayer dollars, accounted for', description: 'Every dollar of cloud waste is public money. I find the waste dashboards miss because dashboards don\'t read architecture — they read meters. I read your infrastructure like an auditor reads a ledger.' },
  { emoji: '📋', title: 'No recurring contract', description: 'Government procurement hates ongoing SaaS. This is a one-time engagement. No annual renewals. No subscription fatigue. One audit, permanent savings. Your budget office will love you.' },
  { emoji: '🛡️', title: 'Compliance-safe recommendations', description: '10 years inside HIPAA government healthcare. Every recommendation maintains your security and compliance posture. I\'ve worked inside FedRAMP, HIPAA, and IRS Pub 1075 environments. Your ATO is safe with me.' },
]

// ── Qualifier items ──
const qualifierItems = [
  { text: `Spending <span class="text-gray-200 font-semibold">${minAwsK}+/mo</span> on AWS` },
  { text: 'Infrastructure has been <span class="text-gray-200 font-semibold">growing without a formal cost review</span>' },
  { text: 'Team is focused on <span class="text-gray-200 font-semibold">mission delivery</span>, not cloud optimization' },
  { text: 'Nobody has done a <span class="text-gray-200 font-semibold">cost audit</span> in the last 12 months' },
  { text: 'Architecture decisions were made <span class="text-gray-200 font-semibold">2+ years ago</span>' },
]

// ── Waste sources ──
const wasteSources = [
  { emoji: '🖥️', service: 'EC2', name: 'Instances provisioned for peak enrollment season running 24/7/365', savings: '40-70%' },
  { emoji: '🏗️', service: 'RDS', name: 'Multi-AZ instances on dev/test environments that don\'t need high availability', savings: '30-50%' },
  { emoji: '🦕', service: 'EBS', name: 'Snapshots from three administrations ago. Nobody knows what they are, nobody will delete them.', savings: '$100-1K/mo' },
  { emoji: '🍽️', service: 'NAT GW', name: 'Quietly eating your budget. Every day. Nobody told procurement.', savings: '$200-2K/mo' },
  { emoji: '💳', service: 'Savings Plans', name: 'AWS literally wants you to buy these but procurement didn\'t know they existed', savings: '30-50%' },
  { emoji: '🐿️', service: 'Architecture', name: 'Built for the original grant proposal, not the mission you\'re actually running', savings: '20-50%' },
  { emoji: '🧊', service: 'S3', name: 'Glacier-eligible data sitting in Standard tier because nobody set a lifecycle policy', savings: '$50-500/mo' },
]

// ── Government-specific FAQ ──
const faqQuestions = [
  { emoji: '🏛️', question: 'Can you work with FedRAMP-authorized environments?', answer: 'Yes. 10 years in HIPAA government healthcare at IdeaCrew, working inside FedRAMP and IRS Pub 1075 environments. Every recommendation I make maintains your existing security and compliance posture. Your ATO is safe. 🛡️' },
  { emoji: '📋', question: 'How does procurement work?', answer: `Available through <strong>AWS Marketplace</strong> (use your existing cloud budget), <strong>Carahsoft</strong> (GSA Schedule and government contract vehicles), or direct engagement. The Report deposit (${pricing.depositPct}% of AWS annual spend) may fall under your agency's micro-purchase threshold. 🏛️` },
  { emoji: '🔒', question: 'What access do you need?', answer: 'Read-only IAM role provisioned by your team using a CloudFormation template I provide. External ID for confused deputy protection. You control it the entire time, you revoke it when we\'re done. I can look but I literally cannot touch. 👀' },
  { emoji: '🏢', question: 'Can you audit multiple agency accounts?', answer: `Yes. Government agencies often have 3-10 AWS accounts across programs and environments. I audit them all. Volume pricing available &mdash; email <a href="mailto:david@cutmyaws.com" class="text-brand-400 hover:underline">david@cutmyaws.com</a> for details. 📊` },
  { emoji: '⚠️', question: 'Will your recommendations break our ATO?', answer: 'No. Every recommendation maintains your existing security and compliance posture. I spent 10 years inside government healthcare infrastructure &mdash; HIPAA, FedRAMP, IRS Pub 1075. I know what you can and can\'t change. If something is compliance-sensitive, I flag it and explain the tradeoff. 🎯' },
  { emoji: '🤔', question: 'What if you don\'t find savings?', answer: 'No savings = no fee. You literally cannot lose. But in 19 years and 150+ accounts, this has happened exactly zero times. Government accounts are some of the most waste-heavy I\'ve seen &mdash; because nobody\'s job is to look. 🤷' },
]

// ── Government client logos ──
const govLogos = [
  { name: 'DC Government', src: '/logos/dc-gov.png', url: 'https://dc.gov' },
  { name: 'Commonwealth of MA', src: '/logos/ma-state.png', url: 'https://mass.gov' },
  { name: 'PBS', src: '/logos/pbs.svg', url: 'https://pbs.org' },
  { name: 'Argonne National Lab', src: '/logos/argonne.png', url: 'https://anl.gov' },
  { name: 'Caterpillar', src: '/logos/cat.svg', url: 'https://caterpillar.com' },
]
</script>

<template>
  <div>
    <!-- Hero -->
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
          <div class="w-full lg:w-[380px] shrink-0">
            <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8 text-center">
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
          </div>
        </div>
      </div>
    </section>

    <!-- Video -->
    <YouTubeEmbed video-id="ZVUOW87e-Jc" label="intro" page="government" />

    <!-- Stats -->
    <SectionStats :stats="stats" />

    <!-- Government Client Logos -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-12 text-center">
        <p class="text-gray-500 text-sm uppercase tracking-wider mb-8">Trusted by government agencies and public sector organizations</p>
        <div class="flex flex-wrap items-center justify-center gap-8 sm:gap-12">
          <a
            v-for="logo in govLogos"
            :key="logo.name"
            :href="logo.url"
            target="_blank"
            rel="noopener"
            class="grayscale opacity-50 hover:grayscale-0 hover:opacity-90 transition-all duration-300"
          >
            <img :src="logo.src" :alt="logo.name" class="h-10 max-w-[120px] object-contain">
          </a>
        </div>
      </div>
    </section>

    <!-- Dollar Example -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-16 text-center">
        <h2 class="text-2xl font-bold mb-2">The math on a typical government agency 🧮</h2>
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
            <p class="text-gray-500 text-sm mt-2">Returned to the mission — every year 🏛️</p>
          </div>
        </div>
        <p class="text-gray-600 text-xs mt-6">Year 1 net: ${{ (ex.fixNet / 1000).toFixed(0) }}K kept · Year 2+: full ${{ (ex.annualSavings / 1000).toFixed(0) }}K/yr goes straight to your budget</p>
      </div>
    </section>

    <!-- How It Works -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-16 text-center">
        <h2 class="text-2xl font-bold mb-2">How it works for government agencies</h2>
        <p class="text-gray-500 text-sm mb-8">Three steps. Less paperwork than a change request. 📄</p>
        <div class="grid sm:grid-cols-3 gap-8 text-left">
          <div>
            <p class="text-brand-400 text-sm font-bold mb-2">STEP 1</p>
            <h3 class="font-bold mb-1">Your team grants read-only access</h3>
            <p class="text-gray-500 text-sm">CloudFormation template, 15-minute setup. External ID for confused deputy protection. You control it, you revoke it when we're done. 🔒</p>
          </div>
          <div>
            <p class="text-brand-400 text-sm font-bold mb-2">STEP 2</p>
            <h3 class="font-bold mb-1">David audits the account</h3>
            <p class="text-gray-500 text-sm">Read-only, 5-10 business days. Full report: every waste item, dollar amounts, compliance-safe recommendations. All findings maintain your existing security posture. 🔍</p>
          </div>
          <div>
            <p class="text-brand-400 text-sm font-bold mb-2">STEP 3</p>
            <h3 class="font-bold mb-1">Savings hit the budget</h3>
            <p class="text-gray-500 text-sm">Your agency keeps the savings permanently. One-time fee. Available through AWS Marketplace or Carahsoft for simplified procurement. 🏛️</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Calendly Embed -->
    <section id="book-section">
      <CalendlyEmbed campaign="government" />
    </section>

    <!-- Value Props -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-16">
        <ValuePropCards :cards="valueProps" :columns="3" />
      </div>
    </section>

    <!-- Qualifier -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-16 text-center">
        <QualifierSection
          headline="Your agency is a good fit if… 🎯"
          subheadline="Not every agency needs this. Here's who gets the most value."
          :items="qualifierItems"
          layout="grid"
        />
      </div>
    </section>

    <!-- Case Studies -->
    <section>
      <CaseStudies />
    </section>

    <!-- Testimonials -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-12">
        <Testimonials />
      </div>
    </section>

    <!-- Common Waste -->
    <section>
      <div class="max-w-5xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-2 text-center">🕵️ What I Find in Every Government Account</h2>
        <p class="text-gray-400 text-center mb-8">Decisions that made sense when the grant was approved. The grant was 4 years ago.</p>
        <WasteList :items="wasteSources" />
      </div>
    </section>

    <!-- Procurement -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-16 text-center">
        <h2 class="text-2xl font-bold mb-2">Procurement-Friendly. We Made It Easy. 🏛️</h2>
        <p class="text-gray-500 text-sm mb-8">Three ways to purchase — use whichever fits your agency's process.</p>
        <div class="grid sm:grid-cols-3 gap-6">
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6 text-center">
            <div class="flex items-center justify-center h-16 w-32 mx-auto px-4 rounded-lg bg-white/90 mb-4">
              <img src="/logos/aws-marketplace.svg" alt="AWS Marketplace" class="h-10 max-w-[120px] object-contain">
            </div>
            <h3 class="font-bold mb-2">AWS Marketplace</h3>
            <p class="text-gray-500 text-sm">Use your existing cloud budget. No new vendor paperwork.</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6 text-center">
            <div class="flex items-center justify-center h-16 w-32 mx-auto px-4 rounded-lg bg-white/90 mb-4">
              <img src="/logos/carahsoft.svg" alt="Carahsoft" class="h-10 max-w-[120px] object-contain">
            </div>
            <h3 class="font-bold mb-2">Carahsoft</h3>
            <p class="text-gray-500 text-sm">GSA Schedule and government contract vehicles.</p>
          </div>
          <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6 text-center">
            <div class="flex items-center justify-center h-16 w-32 mx-auto mb-4">
              <span class="text-4xl">📧</span>
            </div>
            <h3 class="font-bold mb-2">Direct</h3>
            <p class="text-gray-500 text-sm">Micro-purchase threshold? <a href="mailto:david@cutmyaws.com" class="text-brand-400 hover:underline">Email David</a> directly.</p>
          </div>
        </div>
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
        headline="❓ Questions government buyers ask"
        :questions="faqQuestions"
      />
    </section>

    <!-- Bottom CTA -->
    <CtaSection
      headline="Every dollar saved goes back to the mission."
      subtext="One engagement. Permanent savings. Available through AWS Marketplace and Carahsoft. No recurring contracts. 🏛️"
      cta-link="#book"
    >
      <p class="text-gray-600 text-sm mt-3">
        Procurement questions?
        <a href="mailto:david@cutmyaws.com?subject=Government%20AWS%20Audit%20%E2%9C%82%EF%B8%8F&body=Hey%20David%2C%0A%0AOur%20agency%20spends%20%5B%24%5D%2Fmo%20on%20AWS.%20Let's%20talk%20about%20an%20audit." class="text-brand-400 hover:underline">Email David</a> — happy to work with your procurement office 📋
      </p>
    </CtaSection>

    <!-- Mobile sticky CTA -->
    <MobileStickyCtaBar
      link="#book"
    />

  </div>
</template>
