import Bugsnag from '@bugsnag/js'
import BugsnagPluginVue from '@bugsnag/plugin-vue'

export default defineNuxtPlugin((nuxtApp) => {
  Bugsnag.start({
    apiKey: '60c69015742479a1ff227007d0811389',
    plugins: [new BugsnagPluginVue()],
    releaseStage: 'prod',
    enabledReleaseStages: ['prod'],
  })

  const bugsnagVue = Bugsnag.getPlugin('vue')
  if (bugsnagVue) {
    nuxtApp.vueApp.use(bugsnagVue)
  }
})
