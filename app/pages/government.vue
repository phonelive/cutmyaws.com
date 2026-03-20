<script setup>
useHead({
  title: 'AWS Cost Optimization for Government Agencies — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})

const { pricing, minAwsK } = usePricing()

// ── Stats ──
const stats = [
  { value: '30%', label: 'Cost reduction across 3 state healthcare exchanges 🏥' },
  { value: '6', label: 'Government AWS accounts managed across DC, MA & more 🏛️' },
  { value: '19 yrs', label: 'AWS experience — in production since 2007 ☁️' },
]

// ── How it works steps ──
const steps = [
  { title: 'Your team grants read-only access', description: 'CloudFormation template, 15-minute setup. External ID for confused deputy protection. You control it, you revoke it when we\'re done. 🔒' },
  { title: 'David audits the account', description: 'Read-only, 5-10 business days. Full report: every waste item, dollar amounts, compliance-safe recommendations. All findings maintain your existing security posture. 🔍' },
  { title: 'Savings hit the budget', description: 'Your agency keeps the savings permanently. One-time fee. Available through AWS Marketplace or Carahsoft for simplified procurement. 🏛️' },
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
  { emoji: '📋', question: 'How does procurement work?', answer: `Available through <strong>AWS Marketplace</strong> (use your existing cloud budget), <strong>Carahsoft</strong> (GSA Schedule and government contract vehicles), or direct engagement. The audit is free &mdash; the upfront ${pricing.upfrontPct}% of the fee to start implementation may fall under your agency's micro-purchase threshold. 🏛️` },
  { emoji: '🔒', question: 'What access do you need?', answer: 'Read-only IAM role provisioned by your team using a CloudFormation template I provide. External ID for confused deputy protection. You control it the entire time, you revoke it when we\'re done. I can look but I literally cannot touch. 👀' },
  { emoji: '🏢', question: 'Can you audit multiple agency accounts?', answer: `Yes. Government agencies often have 3-10 AWS accounts across programs and environments. I audit them all. Volume pricing available &mdash; email <a href="mailto:david@cutmyaws.com" class="text-brand-400 hover:underline">david@cutmyaws.com</a> for details. 📊` },
  { emoji: '⚠️', question: 'Will your recommendations break our ATO?', answer: 'No. Every recommendation maintains your existing security and compliance posture. I spent 10 years inside government healthcare infrastructure &mdash; HIPAA, FedRAMP, IRS Pub 1075. I know what you can and can\'t change. If something is compliance-sensitive, I flag it and explain the tradeoff. 🎯' },
  { emoji: '🤔', question: 'What if you don\'t find savings?', answer: 'No savings = no fee. You literally cannot lose. But in 19 years and 150+ accounts, this has happened exactly zero times. Government accounts are some of the most waste-heavy I\'ve seen &mdash; because nobody\'s job is to look. 🤷' },
]
</script>

<template>
  <PageSections>
    <!-- Hero -->
    <GovHero />

    <!-- Video -->
    <YouTubeEmbed video-id="ZVUOW87e-Jc" label="intro" page="government" />

    <!-- Stats -->
    <SectionStats :stats="stats" />

    <!-- Client Logos -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-12">
        <ClientLogos />
      </div>
    </section>

    <!-- Dollar Example -->
    <GovSavingsExample :aws-monthly="50000" :waste-pct="35" />

    <!-- How It Works -->
    <HowItWorks
      headline="How it works for government agencies"
      subheadline="Three steps. Less paperwork than a change request. 📄"
      :steps="steps"
    />

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
    <GovProcurement />

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
      :bg="false"
    >
      <p class="text-gray-600 text-sm mt-3">
        Procurement questions?
        <a href="mailto:david@cutmyaws.com?subject=Government%20AWS%20Audit%20%E2%9C%82%EF%B8%8F&body=Hey%20David%2C%0A%0AOur%20agency%20spends%20%5B%24%5D%2Fmo%20on%20AWS.%20Let's%20talk%20about%20an%20audit." class="text-brand-400 hover:underline">Email David</a> — happy to work with your procurement office 📋
      </p>
    </CtaSection>

    <!-- Mobile sticky CTA -->
    <MobileStickyCtaBar link="#book" />

  </PageSections>
</template>
