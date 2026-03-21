<script setup>
import { ref, computed, watch, onMounted, onBeforeUnmount } from 'vue'

const props = defineProps({
  campaign: { type: String, default: 'inline' },
  anchorId: { type: String, default: 'book' },
})

const route = useRoute()

// Session ID — unique per form instance, persists across auto-saves
const sessionId = ref('')

// Form state
const form = ref({
  name: '',
  email: '',
  company: '',
  awsMonthly: '',
  availability: '',
  notes: '',
})

const submitted = ref(false)
const submitting = ref(false)
const error = ref('')
const turnstileToken = ref('')

const firstName = computed(() => {
  const parts = form.value.name.trim().split(/\s+/)
  return parts[0] || ''
})

const shareUrl = encodeURIComponent('https://cutmyaws.com')

// ── Event tracking flags (fire once per session) ──
const firedStarted = ref(false)
const firedEmailValid = ref(false)

// ── API base URL ──
const apiBase = computed(() =>
  typeof window !== 'undefined' && window.location.hostname.includes('dev.')
    ? 'https://api.dev.cutmyaws.com'
    : 'https://api.cutmyaws.com'
)

// ── Email validation ──
const emailRegex = /^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$/
const isEmailValid = computed(() => emailRegex.test(form.value.email.trim()))

// ── Auto-save (debounced) ──
let autoSaveTimer = null

function scheduleAutoSave() {
  if (autoSaveTimer) clearTimeout(autoSaveTimer)
  autoSaveTimer = setTimeout(autoSave, 2000) // 2 seconds after last keystroke
}

async function autoSave() {
  // Skip if nothing useful yet
  const f = form.value
  if (!f.name.trim() && !f.email.trim() && !f.company.trim() && !f.awsMonthly.trim()) return
  if (submitted.value) return

  try {
    await fetch(`${apiBase.value}/leads/partial`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        sessionId: sessionId.value,
        name: f.name.trim(),
        email: f.email.trim(),
        company: f.company.trim(),
        awsMonthly: f.awsMonthly.trim(),
        availability: f.availability.trim(),
        notes: f.notes.trim(),
        utmSource: route.query.utm_source || '',
        utmMedium: route.query.utm_medium || '',
        utmCampaign: route.query.utm_campaign || props.campaign,
        pageUrl: typeof window !== 'undefined' ? window.location.href : '',
      }),
    })
  } catch (e) {
    // Silent fail — auto-save is best-effort
  }
}

// ── Watch form for events + auto-save ──
watch(form, () => {
  const { trackEvent } = useTracking()

  // Fire lead_started once (first interaction with any data)
  if (!firedStarted.value) {
    const f = form.value
    if (f.name.trim() || f.email.trim() || f.company.trim() || f.awsMonthly.trim()) {
      firedStarted.value = true
      trackEvent('lead_started', { event_category: 'engagement', event_label: props.campaign })
    }
  }

  // Fire lead_email_valid once when email becomes valid
  if (!firedEmailValid.value && isEmailValid.value) {
    firedEmailValid.value = true
    trackEvent('lead_email_valid', { event_category: 'engagement', event_label: form.value.email.split('@')[1] })
  }

  // Schedule auto-save
  scheduleAutoSave()
}, { deep: true })

// ── Cleanup ──
onBeforeUnmount(() => {
  if (autoSaveTimer) clearTimeout(autoSaveTimer)
})

// Load Turnstile
onMounted(() => {
  // Generate session ID
  sessionId.value = crypto.randomUUID()

  if (!document.querySelector('script[src*="challenges.cloudflare.com"]')) {
    const script = document.createElement('script')
    script.src = 'https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit'
    script.async = true
    script.onload = () => renderTurnstile()
    document.head.appendChild(script)
  } else {
    renderTurnstile()
  }
})

function renderTurnstile() {
  if (window.turnstile) {
    window.turnstile.render(`#turnstile-${props.anchorId}`, {
      sitekey: '0x4AAAAAACrv6ddaepEh0qEx',
      callback: (token) => { turnstileToken.value = token },
      'error-callback': () => { turnstileToken.value = '' },
      theme: 'dark',
      size: 'flexible',
    })
  }
}

async function submit() {
  error.value = ''

  if (!form.value.name.trim()) { error.value = 'Name is required'; return }
  if (!form.value.email.trim()) { error.value = 'Email is required'; return }
  if (!form.value.awsMonthly) { error.value = 'Please select your monthly AWS spend'; return }
  if (!form.value.company.trim()) { error.value = 'Please tell us about your company'; return }
  if (!form.value.availability.trim()) { error.value = 'Please share when works best for you'; return }

  if (!turnstileToken.value) {
    error.value = 'Please complete the verification below, or email david@cutmyaws.com directly.'
    return
  }

  submitting.value = true

  try {
    // Cancel any pending auto-save
    if (autoSaveTimer) clearTimeout(autoSaveTimer)

    const res = await fetch(`${apiBase.value}/leads`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        sessionId: sessionId.value,
        name: form.value.name.trim(),
        email: form.value.email.trim(),
        company: form.value.company.trim(),
        awsMonthly: form.value.awsMonthly.trim(),
        availability: form.value.availability.trim(),
        notes: form.value.notes.trim(),
        turnstileToken: turnstileToken.value,
        utmSource: route.query.utm_source || '',
        utmMedium: route.query.utm_medium || '',
        utmCampaign: route.query.utm_campaign || props.campaign,
        pageUrl: window.location.href,
      }),
    })

    const data = await res.json()

    if (res.ok && data.success) {
      submitted.value = true

      // Fire all conversion events
      const { trackEvent } = useTracking()
      trackEvent('booking_confirmed', {
        event_category: 'conversion',
        event_label: props.campaign,
        linkedin_conversion_id: 26412858,
        reddit_event: 'Lead',
      })
    } else {
      error.value = data.error || 'Something went wrong. Please try again or email david@cutmyaws.com.'
      if (window.turnstile) window.turnstile.reset()
      turnstileToken.value = ''
    }
  } catch (e) {
    error.value = 'Network error. Please try again or email david@cutmyaws.com.'
    if (window.turnstile) window.turnstile.reset()
    turnstileToken.value = ''
  } finally {
    submitting.value = false
  }
}
</script>

<template>
  <div :id="anchorId" class="max-w-2xl mx-auto px-6 py-12">

    <!-- ═══ CONFIRMATION (replaces form after submit) ═══ -->
    <div v-if="submitted" class="text-center py-12">
      <p class="text-6xl mb-6">🎉</p>
      <h2 class="text-3xl font-bold mb-4">Thanks, {{ firstName }} — I'll be in touch!</h2>
      <p class="text-xl text-gray-400 mb-8">I'll email you within 1 business day to set up a time. Check your inbox (and spam, just in case). 😅</p>

      <div class="bg-gray-900 rounded-xl border border-gray-800 p-8 mb-8 text-left max-w-lg mx-auto">
        <h3 class="text-lg font-bold mb-4">📋 What happens next</h3>
        <ul class="space-y-3 text-gray-400">
          <li class="flex gap-3"><span class="text-brand-400 font-bold">1.</span> I'll email you to confirm a time that works</li>
          <li class="flex gap-3"><span class="text-brand-400 font-bold">2.</span> On the call: we talk about your business and your AWS setup</li>
          <li class="flex gap-3"><span class="text-brand-400 font-bold">3.</span> I ask some questions. You share what you're comfortable with.</li>
          <li class="flex gap-3"><span class="text-brand-400 font-bold">4.</span> You'll walk away knowing if there's waste to find — zero obligation</li>
        </ul>
      </div>

      <!-- Social share -->
      <div class="bg-gray-900 rounded-xl border border-gray-800 p-6 mb-8 max-w-lg mx-auto">
        <p class="text-gray-400 text-sm mb-3">🤝 Know someone overpaying AWS? Share the love:</p>
        <div class="flex items-center justify-center gap-3">
          <a
            :href="`https://www.linkedin.com/sharing/share-offsite/?url=${shareUrl}`"
            target="_blank"
            rel="noopener"
            class="bg-gray-800 hover:bg-gray-700 text-white text-sm font-medium px-4 py-2 rounded-lg transition-colors border border-gray-700"
          >
            💼 Share on LinkedIn
          </a>
          <a
            href="mailto:?subject=Check%20out%20Cut%20My%20AWS&body=I%20just%20requested%20a%20free%20AWS%20cost%20audit%20with%20Cut%20My%20AWS.%20They%20only%20charge%20a%20%25%20of%20the%20savings%20they%20find.%20No%20savings%20%3D%20no%20fee.%0A%0Ahttps%3A%2F%2Fcutmyaws.com"
            class="bg-gray-800 hover:bg-gray-700 text-white text-sm font-medium px-4 py-2 rounded-lg transition-colors border border-gray-700"
          >
            📧 Email a friend
          </a>
        </div>
      </div>

      <p class="text-gray-500 text-sm">Looking forward to it, {{ firstName }}. Just you, David, and your AWS bill. ✂️</p>
    </div>

    <!-- ═══ FORM ═══ -->
    <div v-else>
      <div class="text-center mb-8">
        <img src="/david.png" alt="David Plappert" width="80" height="80" loading="lazy" class="w-20 h-20 rounded-full mx-auto mb-4 object-cover object-top border-2 border-gray-700">
        <h2 class="text-3xl font-bold mb-1">🗓️ Let's Talk</h2>
        <p class="text-gray-400 mb-3">Fill this out and I'll reach out to schedule a time. Takes 30 seconds.</p>

        <!-- Urgency -->
        <div class="inline-flex items-center gap-2 bg-brand-500/10 border border-brand-500/30 rounded-full px-4 py-1.5 text-sm text-brand-400 font-medium">
          <span class="w-2 h-2 bg-brand-400 rounded-full animate-pulse"></span>
          🛡️ Free Security Audit with every engagement through 4/15
        </div>
      </div>

      <form @submit.prevent="submit" class="space-y-5">
        <!-- Name -->
        <div>
          <label for="name" class="text-gray-300 text-sm font-medium block mb-1">Name *</label>
          <input
            id="name"
            v-model="form.name"
            type="text"
            required
            placeholder="Jane Smith"
            class="w-full bg-gray-900 border border-gray-700 rounded-lg px-4 py-3 text-gray-100 placeholder-gray-600 focus:border-brand-500 focus:outline-none"
          >
        </div>

        <!-- Email -->
        <div>
          <label for="email" class="text-gray-300 text-sm font-medium block mb-1">Work Email *</label>
          <input
            id="email"
            v-model="form.email"
            type="email"
            required
            placeholder="jane@company.com"
            class="w-full bg-gray-900 border border-gray-700 rounded-lg px-4 py-3 text-gray-100 placeholder-gray-600 focus:border-brand-500 focus:outline-none"
          >
        </div>

        <!-- Company -->
        <div>
          <label for="company" class="text-gray-300 text-sm font-medium block mb-1">Company &amp; what you do *</label>
          <input
            id="company"
            v-model="form.company"
            type="text"
            required
            placeholder="Acme Corp — we build widgets"
            class="w-full bg-gray-900 border border-gray-700 rounded-lg px-4 py-3 text-gray-100 placeholder-gray-600 focus:border-brand-500 focus:outline-none"
          >
        </div>

        <!-- AWS Monthly Spend -->
        <div>
          <label for="awsMonthly" class="text-gray-300 text-sm font-medium block mb-1">Monthly AWS Spend *</label>
          <input
            id="awsMonthly"
            v-model="form.awsMonthly"
            type="text"
            required
            placeholder="~$15K/mo"
            class="w-full bg-gray-900 border border-gray-700 rounded-lg px-4 py-3 text-gray-100 placeholder-gray-600 focus:border-brand-500 focus:outline-none"
          >
        </div>

        <!-- Best Times to Meet -->
        <div>
          <label for="availability" class="text-gray-300 text-sm font-medium block mb-1">Best time of week for a 15-min call? *</label>
          <input
            id="availability"
            v-model="form.availability"
            type="text"
            required
            placeholder="e.g. Tue/Thu mornings, or anytime after 2pm"
            class="w-full bg-gray-900 border border-gray-700 rounded-lg px-4 py-3 text-gray-100 placeholder-gray-600 focus:border-brand-500 focus:outline-none"
          >
        </div>

        <!-- Notes (optional) -->
        <div>
          <label for="notes" class="text-gray-300 text-sm font-medium block mb-1">Anything else? <span class="text-gray-600">(optional)</span></label>
          <textarea
            id="notes"
            v-model="form.notes"
            rows="2"
            placeholder="Multiple accounts? Specific concerns? Just say hi?"
            class="w-full bg-gray-900 border border-gray-700 rounded-lg px-4 py-3 text-gray-100 placeholder-gray-600 focus:border-brand-500 focus:outline-none resize-none"
          ></textarea>
        </div>

        <!-- Turnstile -->
        <div :id="`turnstile-${anchorId}`" class="flex justify-center"></div>

        <!-- Error -->
        <p v-if="error" class="text-red-400 text-sm text-center">{{ error }}</p>

        <!-- Submit -->
        <button
          type="submit"
          :disabled="submitting"
          class="w-full bg-brand-500 hover:bg-brand-600 disabled:bg-brand-500/50 text-white font-semibold px-8 py-4 rounded-xl transition-colors text-lg"
        >
          {{ submitting ? 'Sending...' : '🗓️ Request a Free 15-Min Chat' }}
        </button>
      </form>

      <!-- Below form -->
      <div class="mt-6 space-y-4 text-center">
        <p class="text-gray-600 text-xs">After you submit: I'll email you within 1 business day to confirm a time. No phone tag. ✅</p>

        <!-- Testimonial -->
        <div class="max-w-md mx-auto bg-gray-950 border border-gray-800 rounded-xl px-5 py-3">
          <p class="text-gray-400 text-sm italic">"David's a commando. He is fast and efficient at getting results."</p>
          <p class="text-gray-600 text-xs mt-1">— CTO, Non-Profit w/ $10M Annual Budget</p>
        </div>

        <p class="text-gray-600 text-sm">Prefer email? <a href="mailto:david@cutmyaws.com?subject=AWS%20Cost%20Question%20%E2%9C%82%EF%B8%8F" class="text-brand-400 hover:underline">david@cutmyaws.com</a> · I reply within 1 business day 📧</p>
      </div>
    </div>

  </div>
</template>
