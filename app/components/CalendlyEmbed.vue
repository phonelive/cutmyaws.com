<script setup>
import { onMounted, onBeforeUnmount } from 'vue'

const props = defineProps({
  campaign: { type: String, default: 'inline' },
})

const router = useRouter()

const calendlyUrl = computed(() =>
  `https://calendly.com/phonelivestreaming/cutmyaws-com-intro?utm_source=cutmyaws&utm_medium=website&utm_campaign=${props.campaign}&hide_gdpr_banner=1&hide_event_type_details=1&background_color=030712&text_color=f3f4f6&primary_color=f97316`
)

function onCalendlyMessage(e) {
  if (e.data?.event === 'calendly.event_scheduled') {
    const payload = e.data?.payload || {}
    const query = {}
    if (payload.invitee?.name) query.invitee_full_name = payload.invitee.name
    if (payload.invitee?.email) query.email = payload.invitee.email
    router.push({ path: '/confirmed', query })
  }
}

onMounted(() => {
  // Delay script load so the inline-widget container is fully rendered
  // before Calendly's widget.js tries to postMessage into iframes
  // (fixes "null is not an object" on older iOS Safari)
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
  <div id="book" class="max-w-4xl mx-auto px-6 py-12 text-center">
    <h2 class="text-3xl font-bold mb-2">🗓️ Book Your Free Intro Call</h2>
    <p class="text-gray-400 mb-2">15 minutes with David. No pitch deck. No commitment.</p>
    <div class="flex flex-wrap items-center justify-center gap-3 sm:gap-6 text-sm text-gray-500 mb-6">
      <span>✅ Free</span>
      <span>✅ 15 minutes</span>
      <span>✅ No savings = no fee</span>
    </div>
    <div
      class="calendly-inline-widget mx-auto h-[1300px] sm:h-[950px]"
      :data-url="calendlyUrl"
      style="min-width: 320px; width: 100%;"
    ></div>
  </div>
</template>
