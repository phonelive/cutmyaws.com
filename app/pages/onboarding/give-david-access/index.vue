<script setup>
useHead({
  title: 'Client Onboarding — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})

const stackUrl = 'https://console.aws.amazon.com/cloudformation/home#/stacks/quickcreate?stackName=CutMyAWS-Audit&templateURL=https%3A%2F%2Fcutmyaws-audit.s3.amazonaws.com%2Fclient-role.yaml'

const steps = [
  {
    number: '1',
    title: 'Enable IAM Access to Billing',
    icon: '💰',
    description: 'By default, only the root user can view billing data. This step lets the audit role see your costs.',
    substeps: [
      'Sign in to AWS as the <strong>root user</strong> (not an IAM user)',
      'Go to <strong>Account</strong> → <strong>IAM User and Role Access to Billing Information</strong>',
      'Click <strong>Edit</strong>, check <strong>Activate IAM Access</strong>, click <strong>Update</strong>',
    ],
  },
  {
    number: '2',
    title: 'Enable Cost Explorer',
    icon: '📊',
    description: 'Cost Explorer provides the 48-month billing history we need for a thorough audit.',
    substeps: [
      'Go to <strong>Billing</strong> → <strong>Cost Explorer</strong>',
      'If prompted, click <strong>Enable Cost Explorer</strong>',
      'Note: it can take up to 24 hours to populate (usually much faster)',
    ],
  },
  {
    number: '3',
    title: 'Deploy the Audit Role',
    icon: '🔧',
    description: 'This creates a read-only IAM role that lets us view your resources and billing — nothing more.',
    substeps: [
      'Go to <strong>CloudFormation</strong> → <strong>Create stack</strong> → <strong>Upload a template file</strong>',
      'Upload the <code>client-role.yaml</code> file David sent you',
      'Enter the <strong>External ID</strong> David provided',
      'Check the box acknowledging IAM resource creation',
      'Click <strong>Create stack</strong> — takes about 30 seconds',
    ],
  },
  {
    number: '4',
    title: 'Send Us Your Account ID',
    icon: '📨',
    description: 'That\'s it! Just send David your 12-digit AWS account ID.',
    substeps: [
      'Find it in the top-right corner of the AWS console',
      'Email it to <strong>david@cutmyaws.com</strong>',
      'David will confirm access and the audit begins',
    ],
  },
]

const permissions = {
  allowed: [
    'Read all resource configurations (EC2, RDS, Lambda, S3, etc.)',
    'Read 48 months of billing and cost data',
    'Read savings plans, reservations, and budgets',
    'Read Cost Optimization Hub recommendations',
  ],
  blocked: [
    'Cannot create, modify, or delete any resources',
    'Cannot access data inside S3 buckets, databases, or secrets',
    'Cannot modify IAM users, policies, or roles',
    'Cannot make purchases or change billing settings',
  ],
}
</script>

<template>
  <div class="min-h-screen bg-gray-950 text-gray-100">
    <!-- Nav -->
    <nav class="border-b border-gray-800/50">
      <div class="max-w-5xl mx-auto px-6 py-4 flex items-center justify-between">
        <NuxtLink to="/" class="flex items-center gap-2 hover:opacity-80 transition-opacity">
          <span class="text-2xl">✂️</span>
          <span class="font-bold text-lg">Cut My AWS</span>
        </NuxtLink>
        <p class="text-gray-500 text-sm hidden sm:block">Client Onboarding</p>
      </div>
    </nav>

    <!-- Header -->
    <div class="max-w-3xl mx-auto px-6 pt-12 sm:pt-16 pb-8 text-center">
      <h1 class="text-2xl sm:text-3xl font-bold mb-3">🔧 Account Setup</h1>
      <p class="text-gray-400 mb-2">Grant Cut My AWS read-only access to begin your audit.</p>
      <p class="text-gray-500 text-sm">Takes about 5 minutes. We <strong class="text-gray-300">cannot</strong> modify, delete, or create any resources.</p>
    </div>

    <!-- Steps -->
    <div class="max-w-3xl mx-auto px-6 pb-12">
      <div class="space-y-6">
        <div
          v-for="step in steps"
          :key="step.number"
          class="bg-gray-900 rounded-xl border border-gray-800 p-6 sm:p-8"
        >
          <div class="flex items-start gap-4 mb-4">
            <div class="flex-shrink-0 w-10 h-10 rounded-full bg-brand-500/20 flex items-center justify-center">
              <span class="text-brand-400 font-bold">{{ step.number }}</span>
            </div>
            <div>
              <h2 class="text-lg font-bold flex items-center gap-2">
                <span>{{ step.icon }}</span>
                {{ step.title }}
              </h2>
              <p class="text-gray-400 text-sm mt-1">{{ step.description }}</p>
            </div>
          </div>
          <ol class="space-y-3 ml-14">
            <li
              v-for="(sub, i) in step.substeps"
              :key="i"
              class="text-gray-300 text-sm flex gap-3"
            >
              <span class="text-gray-600 flex-shrink-0">{{ String.fromCharCode(97 + i) }}.</span>
              <span v-html="sub"></span>
            </li>
          </ol>
        </div>
      </div>
    </div>

    <!-- Permissions breakdown -->
    <div class="max-w-3xl mx-auto px-6 pb-12">
      <h2 class="text-lg font-bold mb-6 text-center">🔒 What This Role Can (and Can't) Do</h2>
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-6">
          <h3 class="text-sm font-bold text-green-400 uppercase tracking-wider mb-4">✅ Read Access</h3>
          <ul class="space-y-3">
            <li v-for="item in permissions.allowed" :key="item" class="text-gray-300 text-sm flex gap-2">
              <span class="text-green-400 flex-shrink-0">✓</span>
              {{ item }}
            </li>
          </ul>
        </div>
        <div class="bg-gray-900 rounded-xl border border-gray-800 p-6">
          <h3 class="text-sm font-bold text-red-400 uppercase tracking-wider mb-4">❌ No Access</h3>
          <ul class="space-y-3">
            <li v-for="item in permissions.blocked" :key="item" class="text-gray-300 text-sm flex gap-2">
              <span class="text-red-400 flex-shrink-0">✗</span>
              {{ item }}
            </li>
          </ul>
        </div>
      </div>
    </div>

    <!-- CLI alternative -->
    <div class="max-w-3xl mx-auto px-6 pb-12">
      <div class="bg-gray-900 rounded-xl border border-gray-800 p-6 sm:p-8">
        <h2 class="text-lg font-bold mb-3">💻 Prefer the CLI?</h2>
        <p class="text-gray-400 text-sm mb-4">If you'd rather use the AWS CLI, run this command with the template David sent you:</p>
        <div class="bg-gray-950 rounded-lg p-4 font-mono text-sm text-gray-300 overflow-x-auto">
          <pre>aws cloudformation deploy \
  --template-file client-role.yaml \
  --stack-name CutMyAWS-Audit \
  --parameter-overrides ExternalId=YOUR_EXTERNAL_ID \
  --capabilities CAPABILITY_NAMED_IAM</pre>
        </div>
      </div>
    </div>

    <!-- Removing access -->
    <div class="max-w-3xl mx-auto px-6 pb-12">
      <div class="bg-gray-900 rounded-xl border border-gray-800 p-6 sm:p-8">
        <h2 class="text-lg font-bold mb-3">🗑️ Removing Access After the Audit</h2>
        <p class="text-gray-400 text-sm mb-4">When the audit is complete, delete the CloudFormation stack to instantly revoke all access:</p>
        <div class="bg-gray-950 rounded-lg p-4 font-mono text-sm text-gray-300 overflow-x-auto">
          <pre>aws cloudformation delete-stack --stack-name CutMyAWS-Audit</pre>
        </div>
        <p class="text-gray-500 text-sm mt-3">Or: <strong class="text-gray-400">CloudFormation</strong> → <strong class="text-gray-400">CutMyAWS-Audit</strong> → <strong class="text-gray-400">Delete</strong></p>
      </div>
    </div>

    <!-- Footer -->
    <div class="max-w-2xl mx-auto px-6 py-12 text-center">
      <p class="text-gray-400 text-sm mb-2">Questions about the setup?</p>
      <p class="text-gray-600 text-xs">
        <a href="mailto:david@cutmyaws.com" class="text-brand-400 hover:underline">david@cutmyaws.com</a>
      </p>
    </div>
  </div>
</template>
