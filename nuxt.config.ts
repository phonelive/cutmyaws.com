export default defineNuxtConfig({
  compatibilityDate: '2025-01-01',
  future: { compatibilityVersion: 4 },
  modules: ['@nuxtjs/tailwindcss'],
  nitro: {
    preset: 'github-pages'
  },
  app: {
    head: {
      title: 'Cut My AWS ✂️ Business-Aligned AWS Cost Therapy for Small Businesses',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { name: 'description', content: 'Your tech was built for a business that doesn\'t exist anymore. $99 starts a business-aligned AWS audit from a real human with 20+ years experience. Not a dashboard. 15% audit fee, 35% max.' },
        { property: 'og:title', content: 'Cut My AWS ✂️ AWS Cost Therapy for Small Businesses ($10-50K/mo)' },
        { property: 'og:description', content: 'Your tech was built for a business that doesn\'t exist anymore. $99 starts the conversation. Not a dashboard. Not an AI. Just David.' },
        { property: 'og:type', content: 'website' },
        { property: 'og:url', content: 'https://cutmyaws.com' }
      ],
      link: [
        { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' }
      ],
      script: [
        { src: 'https://www.googletagmanager.com/gtag/js?id=G-ZGPX081LFE', async: true },
        { innerHTML: "window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments);}gtag('js',new Date());gtag('config','G-ZGPX081LFE');" },
        { innerHTML: "(function(c,l,a,r,i,t,y){c[a]=c[a]||function(){(c[a].q=c[a].q||[]).push(arguments)};t=l.createElement(r);t.async=1;t.src='https://www.clarity.ms/tag/'+i;y=l.getElementsByTagName(r)[0];y.parentNode.insertBefore(t,y);})(window,document,'clarity','script','vr2el2utus');" }
      ]
    }
  }
})
