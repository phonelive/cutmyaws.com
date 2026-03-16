<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

const props = defineProps({
  videoId: { type: String, required: true },
  label: { type: String, default: 'intro' },  // video name (e.g. intro, demo)
  page: { type: String, default: 'home' },     // page context (e.g. home, book, investors)
})

const iframeId = `yt-${props.label}`
const activated = ref(false)
let player = null
let progressInterval = null
const firedMilestones = new Set()

function onStateChange(event) {
  const { trackEvent } = useTracking()
  const YT = window.YT

  // Event format: video_{name}_{page}_{action}
  const prefix = `video_${props.label}_${props.page}`

  if (event.data === YT.PlayerState.PLAYING) {
    if (!firedMilestones.has(0)) {
      firedMilestones.add(0)
      trackEvent(`${prefix}_play`, { event_category: 'video', event_label: `${props.label}_${props.page}` })
    }
    if (!progressInterval) {
      progressInterval = setInterval(() => {
        if (!player) return
        const pct = Math.round((player.getCurrentTime() / player.getDuration()) * 100)
        for (const milestone of [25, 50, 75]) {
          if (pct >= milestone && !firedMilestones.has(milestone)) {
            firedMilestones.add(milestone)
            trackEvent(`${prefix}_progress_${milestone}`, { event_category: 'video', event_label: `${props.label}_${props.page}` })
          }
        }
      }, 1000)
    }
  }

  if (event.data === YT.PlayerState.ENDED) {
    if (!firedMilestones.has(100)) {
      firedMilestones.add(100)
      trackEvent(`${prefix}_complete`, { event_category: 'video', event_label: `${props.label}_${props.page}` })
    }
    if (progressInterval) {
      clearInterval(progressInterval)
      progressInterval = null
    }
  }

  if (event.data === YT.PlayerState.PAUSED) {
    trackEvent(`${prefix}_pause`, { event_category: 'video', event_label: `${props.label}_${props.page}` })
    if (progressInterval) {
      clearInterval(progressInterval)
      progressInterval = null
    }
  }

  if (event.data === YT.PlayerState.BUFFERING) {
    trackEvent(`${prefix}_buffer`, { event_category: 'video', event_label: `${props.label}_${props.page}` })
  }
}

function onReady(event) {
  const { trackEvent } = useTracking()
  const prefix = `video_${props.label}_${props.page}`
  trackEvent(`${prefix}_ready`, { event_category: 'video', event_label: `${props.label}_${props.page}` })
  // Auto-play since user clicked the thumbnail
  event.target.playVideo()
}

function onError(event) {
  const { trackEvent } = useTracking()
  const prefix = `video_${props.label}_${props.page}`
  trackEvent(`${prefix}_error`, { event_category: 'video', event_label: `${props.label}_${props.page}`, value: event.data })
}

function onPlaybackRateChange(event) {
  const { trackEvent } = useTracking()
  const prefix = `video_${props.label}_${props.page}`
  trackEvent(`${prefix}_speed_change`, { event_category: 'video', event_label: `${props.label}_${props.page}`, value: event.data })
}

function initPlayer() {
  player = new window.YT.Player(iframeId, {
    events: {
      onStateChange,
      onReady,
      onError,
      onPlaybackRateChange,
    },
  })
}

function activate() {
  activated.value = true
  // Load YouTube API and init player after iframe renders
  nextTick(() => {
    if (window.YT && window.YT.Player) {
      initPlayer()
    } else {
      if (!document.querySelector('script[src*="youtube.com/iframe_api"]')) {
        const tag = document.createElement('script')
        tag.src = 'https://www.youtube.com/iframe_api'
        document.head.appendChild(tag)
      }
      const prev = window.onYouTubeIframeAPIReady
      window.onYouTubeIframeAPIReady = () => {
        if (prev) prev()
        initPlayer()
      }
    }
  })
}

onUnmounted(() => {
  if (progressInterval) clearInterval(progressInterval)
})
</script>

<template>
  <section>
    <div class="max-w-3xl mx-auto px-6 py-12">
      <div class="aspect-video rounded-2xl overflow-hidden border border-gray-800 relative">
        <!-- Lazy: thumbnail + play button until clicked -->
        <button
          v-if="!activated"
          class="w-full h-full relative cursor-pointer group"
          :aria-label="`Play video: ${label}`"
          @click="activate"
        >
          <img
            :src="`https://img.youtube.com/vi/${videoId}/hqdefault.jpg`"
            :alt="`Video thumbnail: ${label}`"
            class="w-full h-full object-cover"
            loading="lazy"
          >
          <!-- Play button overlay -->
          <div class="absolute inset-0 flex items-center justify-center bg-black/30 group-hover:bg-black/40 transition-colors">
            <div class="w-16 h-16 sm:w-20 sm:h-20 bg-brand-500 group-hover:bg-brand-600 rounded-full flex items-center justify-center transition-colors shadow-lg">
              <svg class="w-7 h-7 sm:w-9 sm:h-9 text-white ml-1" fill="currentColor" viewBox="0 0 24 24">
                <path d="M8 5v14l11-7z" />
              </svg>
            </div>
          </div>
        </button>

        <!-- Active: real YouTube iframe (only loaded after click) -->
        <iframe
          v-if="activated"
          :id="iframeId"
          :src="`https://www.youtube.com/embed/${videoId}?rel=0&modestbranding=1&showinfo=0&controls=1&enablejsapi=1&autoplay=1&origin=https://cutmyaws.com`"
          title="Your AWS Bill Is a Symptom — Cut My AWS"
          frameborder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
          allowfullscreen
          class="w-full h-full"
        ></iframe>
      </div>
    </div>
  </section>
</template>
