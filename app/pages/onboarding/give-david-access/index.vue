<script setup>
useHead({
  title: 'Grant Access — Cut My AWS',
  meta: [
    { name: 'robots', content: 'noindex' },
  ],
})

const cutmyawsAccountId = '731039145080'
const roleName = 'CutMyAWS-ReadOnly-Auditor'
const policyName = 'CutMyAWS-Billing-ReadOnly'

// Tab state per step
const tab = ref({ 1: 'console', 2: 'console', 3: 'console', 4: 'console' })

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
      <h1 class="text-2xl sm:text-3xl font-bold mb-3">🔧 Grant David Access</h1>
      <p class="text-gray-400 mb-2">4 steps to grant Cut My AWS read-only access to your account.</p>
      <p class="text-gray-500 text-sm">Takes about 5 minutes. We <strong class="text-gray-300">cannot</strong> modify, delete, or create any resources.</p>
    </div>

    <!-- Steps -->
    <div class="max-w-3xl mx-auto px-6 pb-12 space-y-6">

      <!-- Step 1: Enable IAM Billing Access -->
      <div class="bg-gray-900 rounded-xl border border-gray-800 p-6 sm:p-8">
        <div class="flex items-start gap-4 mb-4">
          <div class="flex-shrink-0 w-10 h-10 rounded-full bg-brand-500/20 flex items-center justify-center">
            <span class="text-brand-400 font-bold">1</span>
          </div>
          <div>
            <h2 class="text-lg font-bold">💰 Enable IAM Access to Billing</h2>
            <p class="text-gray-400 text-sm mt-1">By default, only the root user can see billing. This lets the audit role view your costs.</p>
          </div>
        </div>

        <!-- Tabs -->
        <div class="ml-14">
          <div class="flex gap-2 mb-4">
            <button @click="tab[1] = 'console'" :class="tab[1] === 'console' ? 'bg-brand-500 text-white' : 'bg-gray-800 text-gray-400 hover:text-gray-300'" class="px-3 py-1.5 rounded-lg text-xs font-semibold transition-colors">🖥️ Console</button>
            <button @click="tab[1] = 'cli'" :class="tab[1] === 'cli' ? 'bg-brand-500 text-white' : 'bg-gray-800 text-gray-400 hover:text-gray-300'" class="px-3 py-1.5 rounded-lg text-xs font-semibold transition-colors">💻 CLI</button>
          </div>

          <div v-if="tab[1] === 'console'">
            <ol class="space-y-3">
              <li class="text-gray-300 text-sm flex gap-3">
                <span class="text-gray-600 flex-shrink-0">a.</span>
                <span>Sign in to AWS as the <strong class="text-gray-100">root user</strong> (not an IAM user)</span>
              </li>
              <li class="text-gray-300 text-sm flex gap-3">
                <span class="text-gray-600 flex-shrink-0">b.</span>
                <span>Go to <strong class="text-gray-100">Account</strong> → <strong class="text-gray-100">IAM User and Role Access to Billing Information</strong></span>
              </li>
              <li class="text-gray-300 text-sm flex gap-3">
                <span class="text-gray-600 flex-shrink-0">c.</span>
                <span>Click <strong class="text-gray-100">Edit</strong>, check <strong class="text-gray-100">Activate IAM Access</strong>, click <strong class="text-gray-100">Update</strong></span>
              </li>
            </ol>
          </div>

          <div v-else>
            <p class="text-gray-400 text-sm mb-3">Must be run as root user credentials (not IAM):</p>
            <div class="bg-gray-950 rounded-lg p-4 font-mono text-sm text-gray-300 overflow-x-auto">
              <pre>aws iam create-account-alias  # verify you're root
aws account put-alternate-contact  # root-only action

# IAM billing access is a console-only setting.
# Sign in as root and enable it in Account settings.</pre>
            </div>
            <p class="text-yellow-400/80 text-xs mt-3">⚠️ This specific setting can only be toggled in the console. It takes 30 seconds.</p>
          </div>
        </div>
      </div>

      <!-- Step 2: Enable Cost Explorer -->
      <div class="bg-gray-900 rounded-xl border border-gray-800 p-6 sm:p-8">
        <div class="flex items-start gap-4 mb-4">
          <div class="flex-shrink-0 w-10 h-10 rounded-full bg-brand-500/20 flex items-center justify-center">
            <span class="text-brand-400 font-bold">2</span>
          </div>
          <div>
            <h2 class="text-lg font-bold">📊 Enable Cost Explorer</h2>
            <p class="text-gray-400 text-sm mt-1">Cost Explorer provides the 48-month billing history we need for a thorough audit.</p>
          </div>
        </div>

        <div class="ml-14">
          <div class="flex gap-2 mb-4">
            <button @click="tab[2] = 'console'" :class="tab[2] === 'console' ? 'bg-brand-500 text-white' : 'bg-gray-800 text-gray-400 hover:text-gray-300'" class="px-3 py-1.5 rounded-lg text-xs font-semibold transition-colors">🖥️ Console</button>
            <button @click="tab[2] = 'cli'" :class="tab[2] === 'cli' ? 'bg-brand-500 text-white' : 'bg-gray-800 text-gray-400 hover:text-gray-300'" class="px-3 py-1.5 rounded-lg text-xs font-semibold transition-colors">💻 CLI</button>
          </div>

          <div v-if="tab[2] === 'console'">
            <ol class="space-y-3">
              <li class="text-gray-300 text-sm flex gap-3">
                <span class="text-gray-600 flex-shrink-0">a.</span>
                <span>Go to <strong class="text-gray-100">Billing</strong> → <strong class="text-gray-100">Cost Explorer</strong></span>
              </li>
              <li class="text-gray-300 text-sm flex gap-3">
                <span class="text-gray-600 flex-shrink-0">b.</span>
                <span>If prompted, click <strong class="text-gray-100">Enable Cost Explorer</strong></span>
              </li>
              <li class="text-gray-300 text-sm flex gap-3">
                <span class="text-gray-600 flex-shrink-0">c.</span>
                <span>It can take up to 24 hours to populate (usually much faster)</span>
              </li>
            </ol>
          </div>

          <div v-else>
            <div class="bg-gray-950 rounded-lg p-4 font-mono text-sm text-gray-300 overflow-x-auto">
              <pre>aws ce get-cost-and-usage \
  --time-period Start=2026-03-01,End=2026-03-12 \
  --granularity MONTHLY \
  --metrics UnblendedCost</pre>
            </div>
            <p class="text-gray-500 text-xs mt-3">If this returns data, Cost Explorer is already enabled. If you get an error, enable it in the console first — it's a one-time toggle.</p>
          </div>
        </div>
      </div>

      <!-- Step 3: Create the Audit Role -->
      <div class="bg-gray-900 rounded-xl border border-gray-800 p-6 sm:p-8">
        <div class="flex items-start gap-4 mb-4">
          <div class="flex-shrink-0 w-10 h-10 rounded-full bg-brand-500/20 flex items-center justify-center">
            <span class="text-brand-400 font-bold">3</span>
          </div>
          <div>
            <h2 class="text-lg font-bold">🔧 Create the Audit Role</h2>
            <p class="text-gray-400 text-sm mt-1">This creates a read-only IAM role that lets us view your resources and billing — nothing more. You'll need the <strong class="text-gray-200">External ID</strong> David sent you.</p>
          </div>
        </div>

        <div class="ml-14">
          <div class="flex gap-2 mb-4">
            <button @click="tab[3] = 'console'" :class="tab[3] === 'console' ? 'bg-brand-500 text-white' : 'bg-gray-800 text-gray-400 hover:text-gray-300'" class="px-3 py-1.5 rounded-lg text-xs font-semibold transition-colors">🖥️ Console</button>
            <button @click="tab[3] = 'cli'" :class="tab[3] === 'cli' ? 'bg-brand-500 text-white' : 'bg-gray-800 text-gray-400 hover:text-gray-300'" class="px-3 py-1.5 rounded-lg text-xs font-semibold transition-colors">💻 CLI</button>
          </div>

          <div v-if="tab[3] === 'console'">
            <ol class="space-y-3">
              <li class="text-gray-300 text-sm flex gap-3">
                <span class="text-gray-600 flex-shrink-0">a.</span>
                <span>Go to <strong class="text-gray-100">IAM</strong> → <strong class="text-gray-100">Roles</strong> → <strong class="text-gray-100">Create role</strong></span>
              </li>
              <li class="text-gray-300 text-sm flex gap-3">
                <span class="text-gray-600 flex-shrink-0">b.</span>
                <span>Select <strong class="text-gray-100">Another AWS account</strong></span>
              </li>
              <li class="text-gray-300 text-sm flex gap-3">
                <span class="text-gray-600 flex-shrink-0">c.</span>
                <span>Enter account ID: <code class="bg-gray-800 px-2 py-0.5 rounded text-brand-400">{{ cutmyawsAccountId }}</code></span>
              </li>
              <li class="text-gray-300 text-sm flex gap-3">
                <span class="text-gray-600 flex-shrink-0">d.</span>
                <span>Check <strong class="text-gray-100">Require external ID</strong> → enter the External ID David provided</span>
              </li>
              <li class="text-gray-300 text-sm flex gap-3">
                <span class="text-gray-600 flex-shrink-0">e.</span>
                <span>Search for and attach <strong class="text-gray-100">ReadOnlyAccess</strong> (AWS managed policy)</span>
              </li>
              <li class="text-gray-300 text-sm flex gap-3">
                <span class="text-gray-600 flex-shrink-0">f.</span>
                <span>Name the role: <code class="bg-gray-800 px-2 py-0.5 rounded text-brand-400">{{ roleName }}</code></span>
              </li>
              <li class="text-gray-300 text-sm flex gap-3">
                <span class="text-gray-600 flex-shrink-0">g.</span>
                <span>Click <strong class="text-gray-100">Create role</strong></span>
              </li>
              <li class="text-gray-300 text-sm flex gap-3">
                <span class="text-gray-600 flex-shrink-0">h.</span>
                <span>Open the role → <strong class="text-gray-100">Add permissions</strong> → <strong class="text-gray-100">Create inline policy</strong> → <strong class="text-gray-100">JSON</strong> tab → paste the billing policy below → name it <code class="bg-gray-800 px-2 py-0.5 rounded text-brand-400">{{ policyName }}</code></span>
              </li>
            </ol>

            <!-- Billing policy JSON for console users -->
            <div class="mt-4">
              <p class="text-gray-500 text-xs uppercase tracking-wider mb-2">Billing policy JSON (paste in step h)</p>
              <div class="bg-gray-950 rounded-lg p-4 font-mono text-xs text-gray-300 overflow-x-auto">
                <pre>{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "BillingAndCostRead",
      "Effect": "Allow",
      "Action": [
        "ce:Get*", "ce:Describe*", "ce:List*",
        "cur:Get*", "cur:Describe*", "cur:List*",
        "billing:Get*", "billing:List*",
        "budgets:View*", "budgets:Describe*",
        "savingsplans:Describe*", "savingsplans:List*",
        "cost-optimization-hub:Get*", "cost-optimization-hub:List*",
        "account:GetAccountInformation", "account:GetContactInformation",
        "account:ListRegions",
        "pricing:GetProducts", "pricing:DescribeServices", "pricing:GetAttributeValues",
        "organizations:Describe*", "organizations:List*"
      ],
      "Resource": "*"
    }
  ]
}</pre>
              </div>
            </div>
          </div>

          <div v-else>
            <p class="text-gray-400 text-sm mb-3">Replace <code class="text-brand-400">YOUR_EXTERNAL_ID</code> with the ID David sent you:</p>
            <div class="bg-gray-950 rounded-lg p-4 font-mono text-xs text-gray-300 overflow-x-auto">
              <pre># 1. Create the trust policy
cat &gt; /tmp/trust-policy.json &lt;&lt; 'EOF'
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Principal": { "AWS": "arn:aws:iam::{{ cutmyawsAccountId }}:root" },
    "Action": "sts:AssumeRole",
    "Condition": {
      "StringEquals": { "sts:ExternalId": "YOUR_EXTERNAL_ID" }
    }
  }]
}
EOF

# 2. Create the role
aws iam create-role \
  --role-name {{ roleName }} \
  --assume-role-policy-document file:///tmp/trust-policy.json \
  --max-session-duration 43200

# 3. Attach ReadOnlyAccess
aws iam attach-role-policy \
  --role-name {{ roleName }} \
  --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess

# 4. Create the billing policy
cat &gt; /tmp/billing-policy.json &lt;&lt; 'EOF'
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "BillingAndCostRead",
    "Effect": "Allow",
    "Action": [
      "ce:Get*", "ce:Describe*", "ce:List*",
      "cur:Get*", "cur:Describe*", "cur:List*",
      "billing:Get*", "billing:List*",
      "budgets:View*", "budgets:Describe*",
      "savingsplans:Describe*", "savingsplans:List*",
      "cost-optimization-hub:Get*", "cost-optimization-hub:List*",
      "account:GetAccountInformation", "account:GetContactInformation",
      "account:ListRegions",
      "pricing:GetProducts", "pricing:DescribeServices", "pricing:GetAttributeValues",
      "organizations:Describe*", "organizations:List*"
    ],
    "Resource": "*"
  }]
}
EOF

# 5. Attach the billing policy
aws iam put-role-policy \
  --role-name {{ roleName }} \
  --policy-name {{ policyName }} \
  --policy-document file:///tmp/billing-policy.json

# 6. Clean up temp files
rm /tmp/trust-policy.json /tmp/billing-policy.json</pre>
            </div>
          </div>
        </div>
      </div>

      <!-- Step 4: Send Account ID -->
      <div class="bg-gray-900 rounded-xl border border-gray-800 p-6 sm:p-8">
        <div class="flex items-start gap-4 mb-4">
          <div class="flex-shrink-0 w-10 h-10 rounded-full bg-brand-500/20 flex items-center justify-center">
            <span class="text-brand-400 font-bold">4</span>
          </div>
          <div>
            <h2 class="text-lg font-bold">📨 Send David Your Account ID</h2>
            <p class="text-gray-400 text-sm mt-1">That's it! Just send David your 12-digit AWS account ID and he'll confirm access.</p>
          </div>
        </div>

        <div class="ml-14">
          <div class="flex gap-2 mb-4">
            <button @click="tab[4] = 'console'" :class="tab[4] === 'console' ? 'bg-brand-500 text-white' : 'bg-gray-800 text-gray-400 hover:text-gray-300'" class="px-3 py-1.5 rounded-lg text-xs font-semibold transition-colors">🖥️ Console</button>
            <button @click="tab[4] = 'cli'" :class="tab[4] === 'cli' ? 'bg-brand-500 text-white' : 'bg-gray-800 text-gray-400 hover:text-gray-300'" class="px-3 py-1.5 rounded-lg text-xs font-semibold transition-colors">💻 CLI</button>
          </div>

          <div v-if="tab[4] === 'console'">
            <ol class="space-y-3">
              <li class="text-gray-300 text-sm flex gap-3">
                <span class="text-gray-600 flex-shrink-0">a.</span>
                <span>Click your account name in the top-right corner of the AWS console</span>
              </li>
              <li class="text-gray-300 text-sm flex gap-3">
                <span class="text-gray-600 flex-shrink-0">b.</span>
                <span>Copy the 12-digit <strong class="text-gray-100">Account ID</strong></span>
              </li>
              <li class="text-gray-300 text-sm flex gap-3">
                <span class="text-gray-600 flex-shrink-0">c.</span>
                <span>Email it to <a href="mailto:david@cutmyaws.com" class="text-brand-400 hover:underline font-semibold">david@cutmyaws.com</a></span>
              </li>
            </ol>
          </div>

          <div v-else>
            <div class="bg-gray-950 rounded-lg p-4 font-mono text-sm text-gray-300 overflow-x-auto">
              <pre>aws sts get-caller-identity --query Account --output text</pre>
            </div>
            <p class="text-gray-500 text-xs mt-3">Email the output to <a href="mailto:david@cutmyaws.com" class="text-brand-400 hover:underline">david@cutmyaws.com</a> — David will confirm access and the audit begins.</p>
          </div>
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

    <!-- Removing access -->
    <div class="max-w-3xl mx-auto px-6 pb-12">
      <div class="bg-gray-900 rounded-xl border border-gray-800 p-6 sm:p-8">
        <h2 class="text-lg font-bold mb-3">🗑️ Removing Access After the Audit</h2>
        <p class="text-gray-400 text-sm mb-4">When the audit is complete, just delete the role to instantly revoke all access:</p>

        <div class="flex gap-2 mb-4">
          <button @click="tab[5] = 'console'; tab[5] !== undefined" :class="!tab[5] || tab[5] === 'console' ? 'bg-brand-500 text-white' : 'bg-gray-800 text-gray-400 hover:text-gray-300'" class="px-3 py-1.5 rounded-lg text-xs font-semibold transition-colors" @click.prevent="tab = { ...tab, 5: 'console' }">🖥️ Console</button>
          <button :class="tab[5] === 'cli' ? 'bg-brand-500 text-white' : 'bg-gray-800 text-gray-400 hover:text-gray-300'" class="px-3 py-1.5 rounded-lg text-xs font-semibold transition-colors" @click="tab = { ...tab, 5: 'cli' }">💻 CLI</button>
        </div>

        <div v-if="!tab[5] || tab[5] === 'console'">
          <ol class="space-y-3">
            <li class="text-gray-300 text-sm flex gap-3">
              <span class="text-gray-600 flex-shrink-0">a.</span>
              <span>Go to <strong class="text-gray-100">IAM</strong> → <strong class="text-gray-100">Roles</strong></span>
            </li>
            <li class="text-gray-300 text-sm flex gap-3">
              <span class="text-gray-600 flex-shrink-0">b.</span>
              <span>Search for <code class="bg-gray-800 px-2 py-0.5 rounded text-brand-400">{{ roleName }}</code></span>
            </li>
            <li class="text-gray-300 text-sm flex gap-3">
              <span class="text-gray-600 flex-shrink-0">c.</span>
              <span>Select it → click <strong class="text-gray-100">Delete</strong> → confirm</span>
            </li>
          </ol>
        </div>

        <div v-else>
          <div class="bg-gray-950 rounded-lg p-4 font-mono text-xs text-gray-300 overflow-x-auto">
            <pre># Detach policies first, then delete
aws iam detach-role-policy \
  --role-name {{ roleName }} \
  --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess

aws iam delete-role-policy \
  --role-name {{ roleName }} \
  --policy-name {{ policyName }}

aws iam delete-role --role-name {{ roleName }}</pre>
          </div>
        </div>
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
