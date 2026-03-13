<template>
  <div class="max-w-5xl mx-auto px-6 py-24">
    <h2 class="text-3xl font-bold mb-4 text-center">🔒 Your Data. My Paranoia.</h2>
    <p class="text-gray-400 text-center mb-12 max-w-2xl mx-auto">I've worked with organizations that handle the most sensitive data in the country. Your AWS account is in good hands. Careful, experienced, slightly paranoid hands. 🫡</p>
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 max-w-4xl mx-auto mb-12">
      <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6 text-center">
        <p class="text-3xl mb-3">🏥</p>
        <h3 class="font-bold mb-1">HIPAA</h3>
        <p class="text-gray-500 text-sm">Protected health information? Been there, secured that.</p>
      </div>
      <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6 text-center">
        <p class="text-3xl mb-3">🏛️</p>
        <h3 class="font-bold mb-1">DC Health Link</h3>
        <p class="text-gray-500 text-sm">Health exchange data for the nation's capital.</p>
      </div>
      <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6 text-center">
        <p class="text-3xl mb-3">💳</p>
        <h3 class="font-bold mb-1">PII &amp; eCommerce</h3>
        <p class="text-gray-500 text-sm">Customer data, payment data, the stuff that keeps you up at night.</p>
      </div>
      <div class="bg-gray-950 border border-gray-800 rounded-2xl p-6 text-center">
        <p class="text-3xl mb-3">📋</p>
        <h3 class="font-bold mb-1">IRS Pub 1075</h3>
        <p class="text-gray-500 text-sm">Federal tax information. The government trusted me. You can too.</p>
      </div>
    </div>
    <div class="max-w-2xl mx-auto bg-gray-950 border border-gray-800 rounded-2xl p-8">
      <h3 class="font-bold mb-4 text-center">🛡️ How access works</h3>
      <ul class="space-y-3 text-gray-400">
        <li class="flex items-start gap-3">
          <span class="text-brand-400 mt-0.5">✅</span>
          <span><strong class="text-gray-200">Read-only IAM role</strong> &mdash; scoped policy, your team provisions it. I can look but I literally cannot touch. 👀</span>
        </li>
        <li class="flex items-start gap-3">
          <span class="text-brand-400 mt-0.5">✅</span>
          <span><strong class="text-gray-200">No data extraction</strong> &mdash; I audit infrastructure and architecture, not your application data.</span>
        </li>
        <li class="flex items-start gap-3">
          <span class="text-brand-400 mt-0.5">✅</span>
          <span><strong class="text-gray-200">SOC 2, HIPAA, FedRAMP environments</strong> &mdash; I've worked inside all of them. I know the rules. 🏗️</span>
        </li>
        <li class="flex items-start gap-3">
          <span class="text-brand-400 mt-0.5">✅</span>
          <span><strong class="text-gray-200">Access revoked when we're done</strong> &mdash; you control it the entire time. Delete the role and I'm gone.</span>
        </li>
      </ul>
    </div>
  </div>
</template>
