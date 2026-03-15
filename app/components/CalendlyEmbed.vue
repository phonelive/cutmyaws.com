<script setup>
import { ref, onMounted, onBeforeUnmount, nextTick } from 'vue'

const props = defineProps({
  campaign: { type: String, default: 'inline' },
  anchorId: { type: String, default: 'book' },
})

const router = useRouter()

// Detect section background to match Calendly widget color
const bgColor = ref('030712') // default: base dark (odd sections)

const calendlyUrl = computed(() =>
  `https://calendly.com/phonelivestreaming/cutmyaws-com-intro?utm_source=cutmyaws&utm_medium=website&utm_campaign=${props.campaign}&hide_gdpr_banner=1&hide_event_type_details=1&hide_landing_page_details=1&background_color=${bgColor.value}&text_color=f3f4f6&primary_color=f97316`
)

// Dynamic height — Calendly sends page_height events as the user navigates
const widgetHeight = ref(null) // null = use CSS default

function onCalendlyMessage(e) {
  if (e.data?.event === 'calendly.event_scheduled') {
    const payload = e.data?.payload || {}
    const query = {}
    if (payload.invitee?.name) query.invitee_full_name = payload.invitee.name
    if (payload.invitee?.email) query.email = payload.invitee.email
    router.push({ path: '/confirmed', query })
  }
  // Auto-resize: Calendly posts page_height when content changes
  if (e.data?.event === 'calendly.page_height') {
    const height = parseFloat(e.data.payload?.height)
    if (height && height > 100) {
      widgetHeight.value = `${height}px`
    }
  }
}

onMounted(async () => {
  // Wait for DOM + CSS (nth-child backgrounds) to be applied
  await nextTick()

  // Detect the parent section's computed background color
  const el = document.getElementById(props.anchorId)
  if (el) {
    const section = el.closest('section')
    if (section) {
      const bg = getComputedStyle(section).backgroundColor
      // rgb(17, 24, 39) = bg-gray-900 (#111827)
      if (bg === 'rgb(17, 24, 39)') {
        bgColor.value = '111827'
      }
    }
  }

  // Load Calendly script after bgColor is set
  if (!document.querySelector('script[src*="calendly.com/assets/external/widget.js"]')) {
    requestAnimationFrame(() => {
      const script = document.createElement('script')
      script.src = 'https://assets.calendly.com/assets/external/widget.js'
      script.async = true
      document.head.appendChild(script)
    })
  }
  window.addEventListener('message', onCalendlyMessage)
})

onBeforeUnmount(() => {
  window.removeEventListener('message', onCalendlyMessage)
})
</script>

<template>
  <div :id="anchorId" class="max-w-4xl mx-auto px-6 py-12 text-center">
    <img src="/david.png" alt="David Plappert" class="w-20 h-20 rounded-full mx-auto mb-4 object-cover object-top border-2 border-gray-700">
    <h2 class="text-3xl font-bold mb-1">🗓️ Book Your Free Intro Call</h2>
    <p class="text-gray-400 mb-3">with David Plappert · 19 years on AWS</p>
    <div class="flex flex-wrap items-center justify-center gap-3 sm:gap-6 text-sm text-gray-500 mb-6">
      <span>⚡ 30 seconds to book</span>
      <span>☕ 15-minute call</span>
      <span>✅ Free</span>
      <span>💰 No savings = no fee</span>
    </div>
    <div
      class="calendly-inline-widget mx-auto transition-[height] duration-300"
      :class="widgetHeight ? '' : 'h-[1300px] sm:h-[950px]'"
      :style="{ minWidth: '320px', width: '100%', ...(widgetHeight ? { height: widgetHeight } : {}) }"
      :data-url="calendlyUrl"
    ></div>
  </div>
</template>

<style>
.calendly-inline-widget iframe {
  border: none !important;
  border-radius: 0 !important;
  box-shadow: none !important;
}
</style>
