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
        { name: 'description', content: 'Your AWS bill is too high. $100 scan finds the waste. 10% audit fee, 25% to implement. No savings, no fee.' },
        { property: 'og:title', content: 'Cut My AWS - AWS Cost Optimization' },
        { property: 'og:description', content: 'Your AWS bill is too high. $100 scan finds the waste. Pay only for savings found.' },
        { property: 'og:type', content: 'website' },
        { property: 'og:url', content: 'https://cutmyaws.com' }
      ],
      link: [
        { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' }
      ]
    }
  }
})
