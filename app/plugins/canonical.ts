export default defineNuxtPlugin(() => {
  const route = useRoute()

  useHead({
    link: [
      {
        rel: 'canonical',
        href: computed(() => {
          // Strip trailing slash (except root), strip query params and hash
          const path = route.path.replace(/\/+$/, '') || '/'
          return `https://cutmyaws.com${path}`
        }),
      },
    ],
  })
})
