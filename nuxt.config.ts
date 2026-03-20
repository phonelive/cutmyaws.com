const siteUrl = process.env.NUXT_PUBLIC_SITE_URL || 'https://cutmyaws.com'
const isDevBuild = process.env.NUXT_PUBLIC_NOINDEX === 'true'

export default defineNuxtConfig({
  compatibilityDate: '2025-01-01',
  future: { compatibilityVersion: 4 },
  modules: ['@nuxtjs/tailwindcss'],
  nitro: {
    preset: 'github-pages'
  },
  site: {
    url: siteUrl
  },
  router: {
    options: {
      scrollBehaviorType: 'smooth',
    },
  },
  app: {
    head: {
      htmlAttrs: { lang: 'en', style: 'scroll-behavior: smooth' },
      bodyAttrs: { style: 'background-color:#030712' },
      title: 'Cut My AWS — Been Using AWS for Years? When\'s the Last Time You Cleaned House?',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },

        // SEO meta
        { name: 'description', content: 'Cloud cost optimization for AWS — 300+ services, years of buildup, cobwebs everywhere. We only charge a % of the savings we find — no savings, no fee. A real human consultant with 19 years of AWS experience delivers cloud cost optimization strategies that make your infrastructure not just cheaper, but better. Free 15-min chat.' },
        { name: 'keywords', content: 'cloud cost optimization, cloud cost optimization solutions, cloud cost optimization strategies, cloud cost optimization services, cloud cost savings, reduce cloud cost, AWS cost optimization, AWS cloud cost optimization, reduce AWS cost, AWS cost savings, cloud cost management, FinOps, FinOps consulting, FinOps consultant, AWS consulting, serverless migration, cut AWS bill, AWS waste, business-aligned technology audit' },
        { name: 'author', content: 'David Plappert' },
        { name: 'robots', content: isDevBuild ? 'noindex, nofollow' : 'index, follow' },

        // Open Graph
        { property: 'og:title', content: 'Cut My AWS — Been Using AWS for Years? When\'s the Last Time You Cleaned House?' },
        { property: 'og:description', content: 'We only charge a % of the savings we find. No savings, no fee. A real human with 19 years makes your AWS not just cheaper — but better.' },
        { property: 'og:type', content: 'website' },
        { property: 'og:url', content: siteUrl },
        { property: 'og:site_name', content: 'Cut My AWS' },
        { property: 'og:image', content: `${siteUrl}/og-image.png` },
        { property: 'og:locale', content: 'en_US' },

        // Twitter Card
        { name: 'twitter:card', content: 'summary_large_image' },
        { name: 'twitter:title', content: 'Cut My AWS — When\'s the Last Time You Cleaned House?' },
        { name: 'twitter:description', content: 'We only charge a % of the savings we find. No savings, no fee. Free 15-min chat. Not a dashboard. Just David.' },
        { name: 'twitter:image', content: `${siteUrl}/og-image.png` },

        // GEO/AEO: help AI systems understand the page
        { name: 'subject', content: 'Cloud Cost Optimization & AWS FinOps Consulting' },
        { name: 'topic', content: 'Cloud cost optimization, AWS cost savings, and business-aligned technology audits for small businesses' },
        { name: 'summary', content: 'Cut My AWS offers cloud cost optimization and business-aligned AWS consulting for companies spending $5K+/mo. Free audit — you only pay a percentage of verified savings. No savings, no fee. 19 years AWS experience. Not a dashboard — a real consultant.' },
      ],
      link: [
        { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' },
        { rel: 'me', href: 'https://www.linkedin.com/in/davidplappert/' },
        { rel: 'me', href: 'https://www.linkedin.com/company/cut-my-aws/' },
        { rel: 'me', href: 'https://www.youtube.com/@CutMyAWS' },
      ],
      script: [
        // GA + Clarity loaded via app/plugins/*.client.ts
        // Schema.org structured data
        {
          type: 'application/ld+json',
          innerHTML: JSON.stringify({
            '@context': 'https://schema.org',
            '@graph': [
              {
                '@type': 'ProfessionalService',
                '@id': `${siteUrl}/#organization`,
                name: 'Cut My AWS',
                alternateName: 'CutMyAWS',
                url: siteUrl,
                logo: `${siteUrl}/favicon.svg`,
                image: `${siteUrl}/og-image.png`,
                description: 'Cloud cost optimization solutions for small businesses spending $5K+/mo on AWS. Business-aligned cloud cost optimization strategies from a real consultant with 19 years of AWS experience — not a dashboard, not an AI.',
                founder: {
                  '@type': 'Person',
                  name: 'David Plappert',
                  jobTitle: 'Senior AWS Serverless Architect',
                  url: 'https://www.linkedin.com/in/davidplappert/',
                  image: `${siteUrl}/og-image.png`,
                  sameAs: [
                    'https://www.linkedin.com/in/davidplappert/',
                    'https://www.youtube.com/@CutMyAWS'
                  ]
                },
                parentOrganization: {
                  '@type': 'Organization',
                  name: 'Smart Talk LLC',
                  address: {
                    '@type': 'PostalAddress',
                    streetAddress: '445 NE 8th Ave',
                    addressLocality: 'Ocala',
                    addressRegion: 'FL',
                    postalCode: '34470',
                    addressCountry: 'US'
                  }
                },
                areaServed: 'US',
                serviceType: ['Cloud Cost Optimization', 'AWS Cost Optimization', 'Cloud Cost Optimization Solutions', 'Cloud Cost Optimization Services', 'FinOps Consulting', 'Cloud Cost Audit', 'Serverless Migration', 'Business-Aligned Technology Audit'],
                priceRange: 'Percentage of verified savings (free audit, no savings = no fee)',
                knowsAbout: ['Cloud Cost Optimization', 'Cloud Cost Optimization Solutions', 'Cloud Cost Optimization Strategies', 'Cloud Cost Savings', 'Amazon Web Services', 'AWS Lambda', 'Serverless Architecture', 'FinOps', 'FinOps Consulting', 'AWS FinOps', 'AWS EC2', 'AWS RDS', 'AWS S3', 'DevOps'],
                email: 'david@cutmyaws.com',
                sameAs: [
                  'https://www.linkedin.com/in/davidplappert/',
                  'https://www.linkedin.com/company/cut-my-aws/',
                  'https://www.youtube.com/@CutMyAWS'
                ]
              },
              {
                '@type': 'WebPage',
                '@id': `${siteUrl}/#webpage`,
                url: siteUrl,
                name: 'Cut My AWS — Cloud Cost Optimization & AWS FinOps Consulting',
                description: 'Cloud cost optimization solutions and AWS cost savings for small businesses spending $5K+/mo. Free 15-min chat.',
                isPartOf: { '@id': `${siteUrl}/#organization` },
                about: { '@id': `${siteUrl}/#organization` }
              },
              {
                '@type': 'Service',
                '@id': `${siteUrl}/#service`,
                name: 'AWS Cost Audit & Implementation',
                description: 'Free AWS cost audit showing where you can save. If you want David to fix it, you pay a percentage of verified savings. Free audit, no savings = no fee.',
                provider: { '@id': `${siteUrl}/#organization` },
                serviceType: 'AWS Cost Optimization',
                offers: {
                  '@type': 'Offer',
                  price: 'Percentage of verified savings',
                  priceCurrency: 'USD',
                  description: 'Free 15-min chat. Free audit. You only pay a percentage of verified savings David actually fixes. No savings = no fee.'
                }
              },
              {
                '@type': 'FAQPage',
                '@id': `${siteUrl}/#faq`,
                mainEntity: [
                  {
                    '@type': 'Question',
                    name: 'What if you don\'t find any AWS savings?',
                    acceptedAnswer: { '@type': 'Answer', text: 'Nothing. The initial chat is free. In 19 years of AWS auditing this has happened zero times. Most accounts are wasting 30-40%.' }
                  },
                  {
                    '@type': 'Question',
                    name: 'When do I pay for the AWS cost audit?',
                    acceptedAnswer: { '@type': 'Answer', text: 'The chat is free. The audit is free. You don\'t pay until you\'ve seen the findings and decided you want David to fix it. You only pay a percentage of verified savings. No savings = no fee.' }
                  },
                  {
                    '@type': 'Question',
                    name: 'Is this just a cost audit or something more?',
                    acceptedAnswer: { '@type': 'Answer', text: 'It\'s a business-aligned technology audit. Cloud cost optimization tools tell you what you\'re spending. Cut My AWS tells you why your tech doesn\'t match your business — and that\'s where the real cloud cost savings live. Serverless migrations, right-sizing, architecture alignment.' }
                  },
                  {
                    '@type': 'Question',
                    name: 'What size AWS accounts does Cut My AWS work with?',
                    acceptedAnswer: { '@type': 'Answer', text: 'Businesses spending $5,000 or more per month on AWS. Below $5K there isn\'t enough waste to justify an engagement. Above that? Even better — more infrastructure means more savings to find.' }
                  },
                  {
                    '@type': 'Question',
                    name: 'Does Cut My AWS only work with tech companies?',
                    acceptedAnswer: { '@type': 'Answer', text: 'No. Cut My AWS works with for-profit companies, non-profits (churches, civic organizations, foundations), and local, state, and federal government agencies. If you run on AWS and spend $5K+ per month, Cut My AWS can help regardless of industry or sector.' }
                  },
                  {
                    '@type': 'Question',
                    name: 'How is Cut My AWS different from cloud cost optimization tools like CloudHealth or ProsperOps?',
                    acceptedAnswer: { '@type': 'Answer', text: 'Cloud cost optimization tools scan your account and show charts. Cut My AWS is a real consultant (David Plappert, 19 years AWS) who reads your architecture, understands your business, and tells you exactly what to change and why. Cloud cost optimization platforms find obvious waste. David finds the structural misalignment between your tech and your business — the kind of cloud cost optimization insight no dashboard can deliver.' }
                  },
                  {
                    '@type': 'Question',
                    name: 'What is the maximum fee for Cut My AWS services?',
                    acceptedAnswer: { '@type': 'Answer', text: 'A percentage of verified savings that David actually fixes. The audit is free. Pricing is discussed after you see the findings. No savings = no fee.' }
                  }
                ]
              }
            ]
          })
        }
      ]
    }
  }
})
