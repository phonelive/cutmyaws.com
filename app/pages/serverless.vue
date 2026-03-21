<script setup>
useHead({
  title: 'Serverless Migration — Save 40-70% on AWS — Cut My AWS',
  meta: [
    { name: 'description', content: 'Still running EC2 24/7? Serverless migration saves 40-70% on compute costs. Free audit. You only pay a % of actual savings. Guaranteed ROI.' },
    { name: 'robots', content: 'noindex' },
  ],
})

const { minAwsK } = usePricing()

// ── Stats ──
const stats = [
  { value: '40–70%', label: 'Compute savings when migrating to serverless 🚀' },
  { value: 'Free', label: 'The audit costs nothing — you see the numbers first', color: 'text-green-400' },
  { value: '19 yrs', label: 'AWS experience — serverless since Lambda launched (2014)' },
]

// ── Serverless benefits ──
const benefits = [
  { emoji: '💰', title: 'Pay per request, not per hour', description: 'EC2 charges you 24/7 whether anyone is using it or not. Serverless charges you per request. Your app gets 100 requests at 3am? You pay for 100 requests. Not 8 hours of idle compute. That\'s not optimization — that\'s just common sense. 🤷' },
  { emoji: '📈', title: 'Auto-scaling that actually works', description: 'No more guessing instance sizes. No more 3am pages because traffic spiked. Serverless scales to zero when nobody\'s using it and to 10,000 concurrent requests when they are. You stop paying for "just in case" and start paying for "right now." ⚡' },
  { emoji: '🛡️', title: 'Security you don\'t have to manage', description: 'With serverless, AWS manages the OS, runtime, and infrastructure. That\'s the shared responsibility model working in your favor. No more patching servers at midnight. No more "we\'ll update it next sprint" for the 47th sprint in a row. 🔒' },
  { emoji: '🚀', title: 'Ship faster, deploy easier', description: 'No SSH. No AMIs. No deployment scripts from 2019 that nobody understands. Push code, it runs. Rollback in seconds. Your team ships features instead of babysitting infrastructure. That\'s what "cloud-native" was supposed to mean. ☁️' },
]

// ── Migration savings examples ──
const migrationSavings = [
  { emoji: '🖥️', from: 'EC2 running 24/7', to: 'Lambda + API Gateway', savings: '40-70%', why: 'You\'re paying for 168 hours/week. Your app is busy for maybe 40. Lambda charges per-request.' },
  { emoji: '🏗️', from: 'Self-managed RDS', to: 'DynamoDB / Aurora Serverless', savings: '30-60%', why: 'That db.r5.2xlarge is great for your 50-user app. So is a $200/mo serverless database.' },
  { emoji: '🐳', from: 'EC2 (manual deploys)', to: 'ECS Fargate (Docker)', savings: '30-50%', why: 'Already have Docker images? Fargate runs your containers without managing servers. No EC2 instances, no patching, no capacity planning. Just push your image and go.' },
  { emoji: '🔄', from: 'ECS/EKS with ALB', to: 'Lambda + API Gateway', savings: '50-80%', why: 'ALB alone costs $20/mo before a single request. API Gateway + Lambda? Pennies until real traffic hits.' },
  { emoji: '⏰', from: 'Cron jobs on EC2', to: 'EventBridge + Lambda', savings: '80-95%', why: 'Running a whole server to execute a script for 30 seconds every hour. That\'s 29 minutes and 30 seconds of waste.' },
  { emoji: '📦', from: 'SQS consumers on EC2', to: 'SQS + Lambda triggers', savings: '60-80%', why: 'Lambda polls SQS for you. No idle consumers. No auto-scaling groups. Just code that runs when messages arrive.' },
  { emoji: '🌐', from: 'EC2/Nginx static hosting', to: 'S3 + CloudFront', savings: '80-95%', why: 'Running a whole server to serve static files is like hiring a chauffeur to deliver mail. S3 + CloudFront: global CDN, SSL, zero servers. Pennies per month.' },
]

// ── ROI section ──
const roiPoints = [
  { emoji: '🆓', title: 'The audit is free', detail: 'I analyze your architecture and show you exactly what can move to serverless and how much you\'ll save. You get the full report before spending a dollar.' },
  { emoji: '💸', title: 'You only pay a % of actual savings', detail: 'Not projections. Real reductions on your AWS bill. If the savings don\'t show up, I don\'t get paid.' },
  { emoji: '♾️', title: 'Savings are permanent', detail: 'One-time migration, permanent savings. You pay once. The lower bill repeats every month, forever.' },
  { emoji: '📊', title: 'Typical ROI: 3-5x in year one', detail: 'If I find $5K/mo in savings and you pay a one-time fee, that\'s $60K/year in savings — every year. The math does itself.' },
]

// ── FAQ questions ──
const faqQuestions = [
  { emoji: '🤔', question: 'Will serverless migration break my app?', answer: 'Not on my watch. I migrate in dev first, test everything, and your team reviews before anything touches production. I\'ve been doing this for 19 years — zero incidents, zero downtime migrations. I carry the risk, not you. If something breaks, I fix it for free. 🛡️' },
  { emoji: '⏱️', question: 'How long does a serverless migration take?', answer: 'Depends on complexity. Simple workloads (cron jobs, APIs): days. Complex architectures: 2-4 weeks. The audit takes 5-10 business days and tells you exactly what moves, what stays, and what the savings look like before any work begins. 📋' },
  { emoji: '🧑‍💻', question: 'Does my team need to learn serverless?', answer: 'I handle the migration. Your team learns the new architecture through the process — but they don\'t need to be serverless experts on day one. I document everything and walk them through it. Most teams find serverless easier to maintain, not harder. Less infrastructure = less to worry about. 🎓' },
  { emoji: '💰', question: 'What if the savings aren\'t worth the migration?', answer: 'Then I\'ll tell you that in the audit — for free. Not everything should be serverless. If your workload runs at 90% CPU utilization 24/7, EC2 might actually be the right call. I\'m not here to sell serverless. I\'m here to find the cheapest way to run your workload. 🎯' },
  { emoji: '🔒', question: 'Is serverless actually more secure?', answer: 'Yes. With serverless, AWS manages the OS, patches, and runtime. You\'re responsible for your code and IAM permissions — that\'s it. The attack surface shrinks dramatically. No unpatched servers. No SSH keys floating around. No "we forgot to update that instance." The shared responsibility model, working for you instead of against you. 🛡️' },
  { emoji: '📏', question: 'What size workloads benefit most?', answer: `Companies spending ${minAwsK}+/mo on AWS with workloads that aren't running at capacity 24/7. If your app has peaks and valleys — business hours traffic, batch processing, event-driven workloads — serverless is almost certainly cheaper. The bigger the idle time, the bigger the savings. 📈` },
]

// ── Qualifier items ──
const qualifierItems = [
  { text: 'Running <span class="text-gray-200 font-semibold">EC2 instances 24/7</span> for apps that aren\'t busy 24/7' },
  { text: 'Paying for <span class="text-gray-200 font-semibold">RDS instances</span> sized for peak traffic that happens once a day' },
  { text: 'Team is <span class="text-gray-200 font-semibold">patching servers</span> instead of shipping features' },
  { text: 'Architecture hasn\'t been <span class="text-gray-200 font-semibold">modernized in 2+ years</span>' },
  { text: `Spending <span class="text-gray-200 font-semibold">${minAwsK}+/mo</span> on AWS compute` },
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
            <p class="text-brand-400 text-sm font-bold uppercase tracking-wide mb-3">Free audit · You only pay a % of actual savings · Guaranteed ROI</p>
            <h1 class="text-3xl sm:text-4xl font-extrabold leading-tight mb-4">
              Your EC2 runs 24/7.<br>
              <span class="text-red-400">Your users don't.</span>
            </h1>
            <p class="text-gray-400 text-lg mb-4">
              Serverless migration saves 40–70% on compute. I find what moves, migrate it, and you only pay a % of actual savings.
              <strong class="text-gray-200">No savings? No fee.</strong>
            </p>
            <p class="text-gray-500 text-base mb-8">
              19 years of AWS. Serverless architect since Lambda launched. I don't sell dashboards — I read your architecture and tell you exactly what to change. 🏗️
            </p>
            <div class="flex flex-col sm:flex-row gap-4">
              <a
                href="#book"
                class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-bold px-10 py-5 sm:px-8 sm:py-4 rounded-xl text-xl sm:text-lg transition-colors text-center w-full sm:w-auto"
              >
                🗓️ Book a Free 15-Min Chat
              </a>
              <p class="text-brand-400/80 text-xs font-semibold self-center sm:self-start">⚡ Book in 30 seconds</p>
              <p class="text-gray-500 text-sm self-center sm:self-start">15 min · free · no pitch deck 😏</p>
            </div>
          </div>

          <!-- Right: David card -->
          <a href="#book" class="w-full lg:w-[380px] shrink-0 block group">
            <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8 text-center group-hover:border-brand-500/50 transition-colors">
              <img src="/david.png" alt="David Plappert" width="112" height="112" fetchpriority="high" class="w-28 h-28 rounded-full mx-auto mb-5 object-cover object-top border-2 border-gray-700">
              <p class="font-bold text-lg mb-1">David Plappert</p>
              <p class="text-gray-500 text-sm mb-6">Senior Serverless Architect · 19 years ☕</p>

              <div class="space-y-2 text-left text-sm">
                <div class="flex items-center gap-2 text-gray-400">
                  <span class="text-brand-400">✅</span> Serverless since Lambda launched (2014)
                </div>
                <div class="flex items-center gap-2 text-gray-400">
                  <span class="text-brand-400">✅</span> Pay only a % of verified savings
                </div>
                <div class="flex items-center gap-2 text-gray-400">
                  <span class="text-brand-400">✅</span> No savings? No fee. Period.
                </div>
                <div class="flex items-center gap-2 text-gray-400">
                  <span class="text-brand-400">✅</span> One migration, permanent savings
                </div>
              </div>
            </div>
          </a>
        </div>
      </div>
    </section>

    <!-- Contact Form (above the fold) -->
    <section id="book-section">
      <ContactForm campaign="serverless-top" />
    </section>

    <!-- Stats -->
    <SectionStats :stats="stats" />

    <!-- Client Logos -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-12">
        <ClientLogos />
      </div>
    </section>

    <!-- Why Serverless -->
    <section>
      <div class="max-w-5xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-4 text-center">Why Serverless? 🚀</h2>
        <p class="text-gray-400 text-center mb-12 max-w-2xl mx-auto">It's not about new technology. It's about paying for what you use instead of what you might use someday. The rest is just a bonus.</p>
        <div class="max-w-4xl mx-auto">
          <ValuePropCards :cards="benefits" :columns="2" />
        </div>
      </div>
    </section>

    <!-- Migration Savings Examples -->
    <section>
      <div class="max-w-4xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-2 text-center">🔄 What Serverless Migration Actually Looks Like</h2>
        <p class="text-gray-400 text-center mb-12">Real migrations. Real savings. Not theoretical — these are patterns I see in every audit.</p>

        <div class="space-y-4">
          <div v-for="item in migrationSavings" :key="item.from" class="bg-gray-900 border border-gray-800 rounded-2xl p-6">
            <div class="flex flex-col sm:flex-row sm:items-center gap-4">
              <div class="flex-1">
                <div class="flex items-center gap-2 mb-2">
                  <span class="text-2xl">{{ item.emoji }}</span>
                  <div class="flex items-center gap-2 flex-wrap">
                    <span class="text-red-400 font-mono text-sm bg-red-400/10 px-2 py-1 rounded">{{ item.from }}</span>
                    <span class="text-gray-600">→</span>
                    <span class="text-green-400 font-mono text-sm bg-green-400/10 px-2 py-1 rounded">{{ item.to }}</span>
                  </div>
                </div>
                <p class="text-gray-400 text-sm">{{ item.why }}</p>
              </div>
              <div class="sm:text-right shrink-0">
                <p class="text-green-400 text-2xl font-bold">{{ item.savings }}</p>
                <p class="text-gray-600 text-xs">typical savings</p>
              </div>
            </div>
          </div>
        </div>

        <div class="text-center mt-10">
          <a
            href="#book"
            class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg"
          >
            🗓️ Find Out What You Can Migrate
          </a>
          <p class="text-gray-600 text-sm mt-3">Free audit. I'll tell you exactly what moves and what stays. 📋</p>
        </div>
      </div>
    </section>

    <!-- ROI -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-2 text-center">📊 The ROI of a Free Migration Audit</h2>
        <p class="text-gray-400 text-center mb-12">The audit costs nothing. The migration pays for itself. The savings never stop.</p>

        <div class="space-y-4">
          <div v-for="point in roiPoints" :key="point.title" class="bg-gray-900 border border-gray-800 rounded-2xl p-6">
            <div class="flex items-start gap-4">
              <span class="text-2xl shrink-0">{{ point.emoji }}</span>
              <div>
                <h3 class="font-bold mb-1">{{ point.title }}</h3>
                <p class="text-gray-400 text-sm">{{ point.detail }}</p>
              </div>
            </div>
          </div>
        </div>

        <!-- ROI example -->
        <div class="mt-8 bg-brand-500/10 border border-brand-500/30 rounded-2xl p-6 text-center">
          <p class="text-gray-500 text-xs uppercase tracking-wider mb-3">Example ROI</p>
          <div class="grid sm:grid-cols-3 gap-6">
            <div>
              <p class="text-red-400 text-2xl font-bold">$15K/mo</p>
              <p class="text-gray-500 text-xs mt-1">Current EC2 + RDS spend</p>
            </div>
            <div>
              <p class="text-green-400 text-2xl font-bold">$5K/mo</p>
              <p class="text-gray-500 text-xs mt-1">After serverless migration</p>
            </div>
            <div>
              <p class="text-brand-400 text-2xl font-bold">$120K/yr</p>
              <p class="text-gray-500 text-xs mt-1">Annual savings — forever 🎉</p>
            </div>
          </div>
          <p class="text-gray-500 text-xs mt-4">You pay a one-time percentage of verified savings. The lower bill repeats every month.</p>
        </div>
      </div>
    </section>

    <!-- Qualifier -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-16 text-center">
        <QualifierSection
          headline="Serverless migration is for you if… 🎯"
          subheadline="Not every workload should be serverless. Here's who benefits most."
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

    <!-- Security Deep Dive -->
    <section>
      <div class="max-w-3xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-4 text-center">🛡️ Serverless Is More Secure (Yes, Really)</h2>
        <p class="text-gray-400 text-center mb-12 max-w-2xl mx-auto">The shared responsibility model isn't just a compliance checkbox — it's fewer things that can go wrong.</p>

        <div class="grid sm:grid-cols-2 gap-6">
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6">
            <h3 class="font-bold mb-3 text-red-400">🖥️ With EC2, you manage:</h3>
            <ul class="space-y-2 text-sm text-gray-400">
              <li class="flex items-start gap-2"><span class="text-red-400">✗</span> OS patches & updates</li>
              <li class="flex items-start gap-2"><span class="text-red-400">✗</span> Runtime & dependencies</li>
              <li class="flex items-start gap-2"><span class="text-red-400">✗</span> SSH keys & access</li>
              <li class="flex items-start gap-2"><span class="text-red-400">✗</span> Security groups & NACLs</li>
              <li class="flex items-start gap-2"><span class="text-red-400">✗</span> Server hardening</li>
              <li class="flex items-start gap-2"><span class="text-red-400">✗</span> Antivirus / intrusion detection</li>
            </ul>
          </div>
          <div class="bg-gray-900 border border-green-500/30 rounded-2xl p-6">
            <h3 class="font-bold mb-3 text-green-400">⚡ With Lambda, AWS manages:</h3>
            <ul class="space-y-2 text-sm text-gray-400">
              <li class="flex items-start gap-2"><span class="text-green-400">✓</span> OS patches — automatic</li>
              <li class="flex items-start gap-2"><span class="text-green-400">✓</span> Runtime updates — automatic</li>
              <li class="flex items-start gap-2"><span class="text-green-400">✓</span> No SSH — no keys to leak</li>
              <li class="flex items-start gap-2"><span class="text-green-400">✓</span> Network isolation — built in</li>
              <li class="flex items-start gap-2"><span class="text-green-400">✓</span> Server hardening — their problem</li>
              <li class="flex items-start gap-2"><span class="text-green-400">✓</span> Execution environment — ephemeral</li>
            </ul>
          </div>
        </div>
        <p class="text-gray-500 text-sm text-center mt-6">You manage your code and IAM permissions. AWS manages everything else. Less surface area = less risk. 🔒</p>
      </div>
    </section>

    <!-- About David -->
    <section>
      <AboutSection />
    </section>

    <!-- FAQ -->
    <section>
      <FaqSection
        headline="❓ Serverless migration questions"
        :questions="faqQuestions"
      />
    </section>

    <!-- Bottom Contact Form -->
    <section>
      <ContactForm campaign="serverless-bottom" anchor-id="book-bottom" />
    </section>

    <!-- Bottom CTA -->
    <CtaSection
      headline="Stop paying for servers nobody's using."
      subtext="One migration. Permanent savings. Free audit. You only pay a % of actual savings. Guaranteed ROI. 🚀"
      cta-link="#book"
      :bg="false"
    />

    <!-- Mobile sticky CTA -->
    <MobileStickyCtaBar
      link="#book"
    />

  </PageSections>
</template>
