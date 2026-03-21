<script setup>
import { ref, onMounted, computed } from 'vue'

const { pricing, minAwsK } = usePricing()


// ── Mobile sticky CTA visibility ──
const showMobileCta = ref(false)

onMounted(() => {
  // ── Section scroll tracking ──
  const { trackEvent } = useTracking()
  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        trackEvent('section_view', { event_category: 'engagement', event_label: entry.target.id })
        observer.unobserve(entry.target)
      }
    })
  }, { threshold: 0.3 })
  document.querySelectorAll('section[id]').forEach((el) => observer.observe(el))

  // ── Show mobile sticky CTA after scrolling past hero ──
  const hero = document.getElementById('hero')
  if (hero) {
    const heroObserver = new IntersectionObserver(([entry]) => {
      showMobileCta.value = !entry.isIntersecting
    }, { threshold: 0 })
    heroObserver.observe(hero)
  }
})

// ── Stats ──
const stats = [
  { value: '19 Years', label: '☁️ Of AWS expertise. In production since 2007.' },
  { value: '$100M', label: '💰 Saved & improved across client accounts.' },
  { value: '150', label: '🔍 AWS accounts audited. Zero unsurprised CFOs.' }
]

// ── Waste sources ──
const wasteSources = [
  { emoji: '🖥️', service: 'EC2', name: 'Servers running 24/7 for a workload that shows up at 9am and leaves at 5pm', savings: '40-70%' },
  { emoji: '🏗️', service: 'RDS', name: 'A database the size of a school bus for an app with 50 users', savings: '30-60%' },
  { emoji: '🧘', service: 'EC2', name: 'Instances in a meditative state (they\'re not meditating, they\'re idle)', savings: '20-40%' },
  { emoji: '💳', service: 'Savings Plans', name: 'AWS literally wants you to buy these but nobody told you', savings: '30-50%' },
  { emoji: '🦕', service: 'EBS', name: 'Snapshots so old they remember when us-east-1 was the only region', savings: '$100-1K/mo' },
  { emoji: '🍽️', service: 'NAT GW', name: 'Quietly eating your budget for lunch every single day', savings: '$200-2K/mo' },
  { emoji: '🐿️', service: 'Architecture', name: 'Built for the pitch deck, not the business you\'re actually running', savings: '20-50%' }
]

// ── Why CutMyAWS cards ──
const whyCards = [
  { emoji: '🧑‍💻', title: 'Keep your tech team building value', description: 'Your engineers should be shipping product, not hunting for savings. I dig into your architecture, find the misalignment, and do the one-time cleanup so they don\'t have to. No recurring retainer. No ongoing distraction. Just results. 🚀' },
  { emoji: '🙅', title: 'Not a dashboard. Not an AI. A human.', description: 'Cloud cost optimization tools show charts. AI generates summaries. I read your architecture, understand your business, and tell you exactly what to change and why. Real cloud cost optimization is a person, not a platform. And I only make money when you do. 🤝' },
  { emoji: '💰', title: 'Guaranteed ROI', description: 'The audit is free. You see the full report before spending a dollar. If you want me to fix it, you only pay a percentage of actual savings that show up on your bill. Not projections &mdash; real numbers. No savings? No fee. I carry the risk, not you. 🎯' },
  { emoji: '📉', title: 'Growing ≠ efficient', description: 'Nobody sets out to waste money on AWS. You launch fast, scale fast, and three years later you\'re paying for infrastructure you forgot existed. That\'s not negligence — that\'s just building a business. Let me clean it up. 🧾' },
]

// ── Qualifier items ──
const fitItems = [
  { emoji: '💰', text: `Spending ${minAwsK}+/mo on AWS` },
  { emoji: '🕸️', text: 'Nobody\'s looked under the hood in a while' },
  { emoji: '📈', text: 'Bill keeps growing but you\'re not sure why' },
  { emoji: '🏗️', text: 'Architecture decisions from 2+ years ago' },
  { emoji: '🧑‍💻', text: 'Team too busy building to optimize' },
]


// ── FAQ questions ──
const faqQuestions = [
  { emoji: '🤔', question: 'What if you don\'t find any savings?', answer: 'Then you have the most optimized AWS account I\'ve ever seen, and honestly? I\'ll be impressed. In my career this has happened exactly zero times, but I hear there\'s a first time for everything. And if the savings are small enough that implementation isn\'t worth the hassle, I\'ll tell you that too. I\'ll send you a congratulatory email either way.' },
  { emoji: '🤨', question: 'When do I actually pay?', answer: 'The intro call is free. The audit is free. You don\'t pay a dime until you\'ve seen the report and decided you want me to fix it. I only charge a percentage of actual savings &mdash; real reductions that show up on your AWS bill. Not projections. Guaranteed ROI. No savings? No fee. 😅' },
  { emoji: '🎯', question: 'Is this just a cost audit or something more?', answer: 'Way more. Cloud cost optimization tools tell you <em>what</em> you\'re spending. I tell you <em>why</em> your tech doesn\'t match your business &mdash; and that\'s where the real cloud cost savings live. I\'m a serverless architect who does cloud cost optimization the way it should be done &mdash; business-aligned, not dashboard-driven. The savings are a side effect of good architecture. 🏗️' },
  { emoji: '📏', question: 'What size AWS accounts do you work with?', answer: `We work best with AWS accounts spending ${minAwsK}+/mo. Below that, there usually isn't enough waste to justify an engagement. Above that? Even better &mdash; more infrastructure means more savings to find. 🫡` },
  { emoji: '🧑‍💻', question: 'Can\'t my team just optimize this ourselves?', answer: 'They can try! But cloud cost optimization isn\'t scanning dashboards for random savings. I\'m reading your architecture, understanding your business, and finding the structural mismatches &mdash; the kind of waste that no cloud cost optimization tool surfaces. It\'s the difference between a thermometer and a doctor. 🌡️' },
  { emoji: '🤖', question: 'How is this different from tools like CloudHealth or ProsperOps?', answer: 'Those are dashboards that scan your account and show you charts. I\'m a person who reads your architecture, understands your business, gets on a call with you, and tells you exactly what to change and why. I find the structural misalignment between your tech and your business that no tool can see. 😏' },
  { emoji: '⏱️', question: 'How much of my team\'s time does this take?', answer: 'Almost none. Grant read-only access (15 min setup), attend 1 findings meeting, and review changes before production. That\'s it. I do the work. Your team stays focused on shipping. 🚀' },
]

</script>

<template>
  <PageSections>
    <!-- Hero -->
    <section id="hero" class="relative overflow-hidden">
      <!-- Background gradient -->
      <div class="absolute inset-0 bg-gradient-to-br from-brand-500/5 via-transparent to-brand-500/3"></div>
      <div class="absolute top-0 right-0 w-[600px] h-[600px] bg-brand-500/5 rounded-full blur-3xl -translate-y-1/2 translate-x-1/3"></div>
      <div class="absolute bottom-0 left-0 w-[400px] h-[400px] bg-brand-500/3 rounded-full blur-3xl translate-y-1/2 -translate-x-1/3"></div>
    <div class="relative max-w-5xl mx-auto px-6 pt-24 pb-24">
      <div class="flex flex-col lg:flex-row gap-16 items-center">
        <!-- Left: Text -->
        <div class="flex-1">
          <p class="text-brand-400 font-semibold mb-6 text-lg">✂️ Free audit. You only pay a % of actual savings. Guaranteed ROI.</p>
          <h1 class="text-4xl sm:text-5xl font-bold leading-tight mb-6">
            Your AWS bill is a symptom.<br>
            <span class="text-brand-400">I find the cure.</span>
          </h1>
          <p class="text-lg text-gray-400 mb-8">You only pay a % of actual, verified savings on your bill. Guaranteed ROI. 💸</p>
          <div class="flex flex-col items-start gap-3 mb-8">
            <a
              href="#book"
              class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg text-center"
            >
              🗓️ Book a Free 15-Min Chat
            </a>
            <p class="text-gray-500 text-sm">15 min &middot; free &middot; no pitch deck 😏</p>
          </div>
        </div>

        <!-- Right: Visual card -->
        <a href="#book" class="w-full lg:w-[380px] shrink-0 block group">
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-8 text-center group-hover:border-brand-500/50 transition-colors">
            <!-- Headshot -->
            <img src="/david.png" alt="David Plappert" width="112" height="112" fetchpriority="high" class="w-28 h-28 rounded-full mx-auto mb-5 object-cover object-top border-2 border-gray-700">
            <p class="font-bold text-lg mb-1">David Plappert</p>
            <p class="text-gray-500 text-sm mb-6">19 years on AWS &middot; Since 2007 ☕</p>

            <!-- Value prop -->
            <div class="bg-gray-950 rounded-xl p-5 border border-gray-800 mb-5">
              <p class="text-gray-500 text-xs uppercase tracking-wider mb-2">What I typically find</p>
              <p class="text-4xl font-bold text-green-400">25–40%</p>
              <p class="text-gray-600 text-xs mt-1">of AWS spend is waste 👀</p>
            </div>

            <!-- Quick value props -->
            <div class="space-y-2 text-left text-sm">
              <div class="flex items-center gap-2 text-gray-400">
                <span class="text-brand-400">✅</span> You only pay a % of actual savings. Guaranteed ROI.
              </div>
              <div class="flex items-center gap-2 text-gray-400">
                <span class="text-brand-400">✅</span> No savings? No fee. Period.
              </div>
              <div class="flex items-center gap-2 text-gray-400">
                <span class="text-brand-400">✅</span> Not a dashboard. A real person.
              </div>
            </div>
          </div>
        </a>
      </div>
      </div>
    </section>

    <!-- Contact Form (top — right after hero) -->
    <section id="book-section">
      <ContactForm campaign="home-top" />
    </section>

    <!-- Video -->
    <YouTubeEmbed video-id="ZVUOW87e-Jc" label="intro" page="home" />

    <!-- Stats -->
    <SectionStats id="stats" :stats="stats" />

    <!-- Clients -->
    <section id="clients" class="py-24 px-6">
      <ClientLogos />
    </section>

    <!-- Is This For You? -->
    <section id="fit">
      <div class="max-w-4xl mx-auto px-6 py-24">
        <QualifierSection
          headline="Is this for you? 🤔"
          :items="fitItems"
          layout="grid"
        />
      </div>
    </section>

    <!-- Why CutMyAWS -->
    <section id="why">
      <div class="max-w-5xl mx-auto px-6 py-24">
      <h2 class="text-3xl font-bold mb-4 text-center">Why Cut My AWS? 🤔</h2>
      <p class="text-gray-400 text-center mb-12 max-w-2xl mx-auto">Growing cloud spend doesn't mean efficient cloud spend. Cloud cost optimization tools show you charts &mdash; I show you why your tech doesn't match your business. Your revenue grew 40% &mdash; did your AWS bill grow 40% too? Or 80%? 📈</p>
      <div class="max-w-4xl mx-auto">
        <ValuePropCards :cards="whyCards" :columns="2" />
      </div>
      <!-- Mid-page CTA -->
      <div class="text-center pt-8 pb-0">
        <a
          href="#book"
          class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg"
        >
          🗓️ Book a Free 15-Min Chat
        </a>
        <p class="text-gray-600 text-sm mt-3">15 minutes. Free. Just math and honest answers. 🧮</p>
      </div>
      </div>
    </section>

    <!-- Testimonials -->
    <section id="testimonials">
      <div class="max-w-5xl mx-auto px-6 py-24">
        <Testimonials />
      </div>
    </section>

    <!-- Case Studies -->
    <section id="case-studies">
      <CaseStudies />
    </section>

    <!-- How It Works -->
    <section id="how-it-works">
      <div class="max-w-5xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-4 text-center">How It Works 🧰</h2>
        <p class="text-gray-400 text-center mb-4 max-w-xl mx-auto">One engagement. I audit, I fix, you only pay a % of actual savings. No savings? No fee. 🤝</p>

        <!-- Key message -->
        <div class="max-w-2xl mx-auto bg-brand-500/10 border border-brand-500/30 rounded-xl p-5 mb-12 text-center">
          <p class="text-brand-400 font-semibold text-lg mb-1">The audit is free. You only pay a % of actual savings. Guaranteed ROI.</p>
          <p class="text-gray-400 text-sm">Not projections &mdash; real reductions on your AWS bill. No savings? No fee.</p>
        </div>

        <div class="max-w-2xl mx-auto space-y-4">

          <!-- Step 1: Intro Call -->
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6 sm:p-8">
            <div class="flex items-center gap-3 mb-3">
              <span class="bg-brand-500 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">1</span>
              <h3 class="text-lg font-bold">🗓️ Intro Call <span class="text-gray-500 text-sm font-normal">&middot; 15 min &middot; free</span></h3>
            </div>
            <p class="text-gray-400">We meet, I ask questions about your business, and we figure out if there's a fit. No payment. No AWS access. Just a conversation. 🔍</p>
          </div>

          <div class="text-center text-gray-600 text-sm">↓ If it's a fit, you grant read-only access. No payment yet.</div>

          <!-- Step 2: Audit -->
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6 sm:p-8">
            <div class="flex items-center gap-3 mb-3">
              <span class="bg-brand-500 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">2</span>
              <h3 class="text-lg font-bold">📋 Audit <span class="text-gray-500 text-sm font-normal">&middot; 5–10 business days &middot; free</span></h3>
            </div>
            <p class="text-gray-400">You <NuxtLink to="/onboarding/give-david-access" class="text-brand-400 hover:underline">grant read-only access</NuxtLink> (15 min setup). I dig into your architecture, billing history, and resource utilization. I see infrastructure and billing &mdash; not your application data, databases, or secrets. No charge. 📄</p>
          </div>

          <div class="text-center text-gray-600 text-sm">↓</div>

          <!-- Step 3: Findings Meeting -->
          <div class="bg-gray-900 border-2 border-brand-500 rounded-2xl p-6 sm:p-8">
            <div class="flex items-center gap-3 mb-3">
              <span class="bg-brand-500 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">3</span>
              <h3 class="text-lg font-bold">📊 Findings Meeting <span class="text-gray-500 text-sm font-normal">&middot; free</span></h3>
            </div>
            <p class="text-gray-400 mb-3">I walk your team through everything I found. You get three deliverables you keep forever &mdash; no charge. 🤝</p>
            <div class="space-y-2">
              <div class="bg-gray-950 rounded-lg p-3 border border-gray-800 flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">📋</span>
                <div>
                  <p class="text-gray-200 font-medium text-sm">Audit PDF</p>
                  <p class="text-gray-500 text-xs">Service-by-service savings breakdown with dollar amounts.</p>
                </div>
              </div>
              <div class="bg-gray-950 rounded-lg p-3 border border-green-500/30 flex items-start gap-3">
                <span class="text-green-400 mt-0.5">🛡️</span>
                <div>
                  <p class="text-gray-200 font-medium text-sm">Security PDF <span class="text-green-400 text-xs font-bold ml-2">FREE until 4/15</span></p>
                  <p class="text-gray-500 text-xs">Public S3 buckets, overprivileged IAM, security group misconfigs, unencrypted resources, missing logging.</p>
                </div>
              </div>
              <div class="bg-gray-950 rounded-lg p-3 border border-gray-800 flex items-start gap-3">
                <span class="text-brand-400 mt-0.5">🔧</span>
                <div>
                  <p class="text-gray-200 font-medium text-sm">Implementation Recommendations PDF</p>
                  <p class="text-gray-500 text-xs">What to change, why, and how &mdash; whether your team does it or I do.</p>
                </div>
              </div>
            </div>
          </div>

          <div class="text-center text-gray-600 text-sm">↓ Want me to fix it?</div>

          <!-- Step 4: Implementation -->
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6 sm:p-8">
            <div class="flex items-center gap-3 mb-3">
              <span class="bg-brand-500 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">4</span>
              <h3 class="text-lg font-bold">🔧 Implementation <span class="text-gray-500 text-sm font-normal">&middot; typically 2–4 weeks</span></h3>
            </div>
            <p class="text-gray-400">I implement the optimizations &mdash; serverless migrations, right-sizing, Savings Plans, architecture fixes. I work asynchronously &mdash; your team just reviews before production. Dev first, tested, then promoted. No cowboy deploys. Minimal disruption. 💪</p>
          </div>

          <div class="text-center text-gray-600 text-sm">↓</div>

          <!-- Step 5: Verification -->
          <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6 sm:p-8">
            <div class="flex items-center gap-3 mb-3">
              <span class="bg-brand-500 text-white text-sm font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">5</span>
              <h3 class="text-lg font-bold">📊 Verification & Payment</h3>
            </div>
            <p class="text-gray-400">We pull up your AWS bill. Before. After. Side by side. I only charge a percentage of <strong class="text-gray-200">actual savings on your bill</strong> &mdash; not projections, not estimates. If the savings didn't show up, I don't get paid. Guaranteed ROI. 💰</p>
          </div>

        </div>

        <!-- Summary -->
        <p class="text-gray-500 text-sm text-center mt-8 max-w-lg mx-auto">One-time fee. No monthly charges. No subscriptions. You pay once and keep the savings forever. <NuxtLink to="/agreements" class="text-brand-400 hover:underline">Full terms →</NuxtLink></p>
      </div>
    </section>

    <!-- Common Waste -->
    <section id="waste">
      <div class="max-w-5xl mx-auto px-6 py-24">
        <h2 class="text-3xl font-bold mb-2 text-center">🕵️ The Usual Suspects</h2>
        <p class="text-gray-400 text-center mb-8">Decisions that made sense at the time. That time was 2021. It's not 2021 anymore.</p>
        <WasteList :items="wasteSources" />
        <div class="text-center mt-10">
          <a
            href="#book-bottom-embed"
            class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg"
          >
            🗓️ Find Out What's Hiding in Yours
          </a>
          <p class="text-gray-600 text-sm mt-3">15 min. Free. No commitment. 😏</p>
        </div>
      </div>
    </section>

    <!-- About -->
    <section id="about">
      <AboutSection />
    </section>

    <!-- Security & Compliance -->
    <section id="security">
      <SecuritySection />
    </section>

    <!-- FAQ -->
    <section id="faq">
      <FaqSection :questions="faqQuestions" />
      <div class="text-center pb-12">
        <a
          href="#book-bottom-embed"
          class="inline-block bg-brand-500 hover:bg-brand-600 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg"
        >
          🗓️ Still Have Questions? Let's Talk
        </a>
        <p class="text-gray-600 text-sm mt-3">15 minutes. Free. I'll answer anything. 🤝</p>
      </div>
    </section>

    <!-- Contact Form (bottom — after all content) -->
    <section id="book-bottom">
      <ContactForm campaign="home-bottom" anchor-id="book-bottom-embed" />
    </section>

    <!-- Available Through -->
    <section id="available-through">
      <div class="max-w-5xl mx-auto px-6 py-12 text-center">
        <p class="text-gray-600 text-xs uppercase tracking-wider mb-4">Also available through</p>
        <div class="flex items-center justify-center gap-4">
          <div class="flex items-center justify-center h-16 w-44 px-4 rounded-lg bg-white/90">
            <img src="/logos/aws-marketplace.svg" alt="AWS Marketplace" class="h-10 max-w-[150px] object-contain">
          </div>
          <div class="flex items-center justify-center h-16 w-44 px-4 rounded-lg bg-white/90">
            <img src="/logos/carahsoft.svg" alt="Carahsoft" class="h-10 max-w-[150px] object-contain">
          </div>
        </div>
      </div>
    </section>

    <!-- Mobile sticky CTA -->
    <MobileStickyCtaBar
      link="#book"
      text="🗓️ Book a Free 15-Min Chat"
      :visible="showMobileCta"
    />

  </PageSections>
</template>
