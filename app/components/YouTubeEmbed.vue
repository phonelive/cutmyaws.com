<script setup>
import { onMounted, onUnmounted } from 'vue'

const props = defineProps({
  videoId: { type: String, required: true },
  label: { type: String, default: 'homepage_intro' },
})

const iframeId = `yt-${props.label}`
let player = null
let progressInterval = null
const firedMilestones = new Set()

function onStateChange(event) {
  const { trackEvent } = useTracking()
  const YT = window.YT

  if (event.data === YT.PlayerState.PLAYING) {
    if (!firedMilestones.has(0)) {
      firedMilestones.add(0)
      trackEvent('video_start', { event_category: 'video', event_label: props.label })
    }
    if (!progressInterval) {
      progressInterval = setInterval(() => {
        if (!player) return
        const pct = Math.round((player.getCurrentTime() / player.getDuration()) * 100)
        for (const milestone of [25, 50, 75]) {
          if (pct >= milestone && !firedMilestones.has(milestone)) {
            firedMilestones.add(milestone)
            trackEvent(`video_progress_${milestone}`, { event_category: 'video', event_label: props.label })
          }
        }
      }, 1000)
    }
  }

  if (event.data === YT.PlayerState.ENDED) {
    if (!firedMilestones.has(100)) {
      firedMilestones.add(100)
      trackEvent('video_complete', { event_category: 'video', event_label: props.label })
    }
    if (progressInterval) {
      clearInterval(progressInterval)
      progressInterval = null
    }
  }

  if (event.data === YT.PlayerState.PAUSED) {
    if (progressInterval) {
      clearInterval(progressInterval)
      progressInterval = null
    }
  }
}

function initPlayer() {
  player = new window.YT.Player(iframeId, {
    events: { onStateChange },
  })
}

onMounted(() => {
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

onUnmounted(() => {
  if (progressInterval) clearInterval(progressInterval)
})
</script>

<template>
  <section>
    <div class="max-w-3xl mx-auto px-6 py-12">
      <div class="aspect-video rounded-2xl overflow-hidden border border-gray-800">
        <iframe
          :id="iframeId"
          :src="`https://www.youtube.com/embed/${videoId}?rel=0&modestbranding=1&showinfo=0&controls=1&enablejsapi=1&origin=https://cutmyaws.com`"
          title="Your AWS Bill Is a Symptom — Cut My AWS"
          frameborder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
          allowfullscreen
          class="w-full h-full"
          loading="lazy"
        ></iframe>
      </div>
    </div>
  </section>
</template>
