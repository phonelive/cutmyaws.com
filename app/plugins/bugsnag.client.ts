import Bugsnag from '@bugsnag/js'
import BugsnagPluginVue from '@bugsnag/plugin-vue'
import BugsnagPerformance from '@bugsnag/browser-performance'

export default defineNuxtPlugin((nuxtApp) => {
  Bugsnag.start({
    apiKey: '60c69015742479a1ff227007d0811389',
    plugins: [new BugsnagPluginVue()],
  })
  BugsnagPerformance.start({ apiKey: '60c69015742479a1ff227007d0811389' })

  const bugsnagVue = Bugsnag.getPlugin('vue')
  nuxtApp.vueApp.use(bugsnagVue!)
})
