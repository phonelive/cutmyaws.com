export default defineNuxtConfig({
  compatibilityDate: '2025-01-01',
  future: { compatibilityVersion: 4 },
  modules: ['@nuxtjs/tailwindcss'],
  nitro: {
    preset: 'github-pages'
  },
  app: {
    head: {
      title: 'Cut My AWS - AWS Cost Optimization',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { name: 'description', content: 'Your AWS bill is too high. I\'ll prove it. Free scan, pay only for savings found. 10% audit fee, 25% implementation fee.' },
        { property: 'og:title', content: 'Cut My AWS - AWS Cost Optimization' },
        { property: 'og:description', content: 'Your AWS bill is too high. I\'ll prove it. No savings, no fee.' },
        { property: 'og:type', content: 'website' },
        { property: 'og:url', content: 'https://cutmyaws.com' }
      ],
      link: [
        { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' }
      ]
    }
  }
})
