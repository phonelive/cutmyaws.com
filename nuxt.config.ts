export default defineNuxtConfig({
  compatibilityDate: '2025-01-01',
  future: { compatibilityVersion: 4 },
  modules: ['@nuxtjs/tailwindcss'],
  nitro: {
    preset: 'github-pages'
  },
  site: {
    url: 'https://cutmyaws.com'
  },
  app: {
    head: {
      htmlAttrs: { lang: 'en' },
      title: 'Cut My AWS — Been Using AWS for Years? When\'s the Last Time You Cleaned House?',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },

        // SEO meta
        { name: 'description', content: 'Been using AWS for years? 300+ services. Years of buildup. Cobwebs everywhere. We only charge a % of the savings we find — no savings, no fee. A real human with 19 years makes your AWS not just cheaper, but better. $99 starts the conversation.' },
        { name: 'keywords', content: 'AWS cost optimization, AWS cost audit, AWS cost reduction, AWS consulting, serverless migration, cloud cost management, FinOps, AWS savings, cut AWS bill, AWS waste, business-aligned technology audit' },
        { name: 'author', content: 'David Plappert' },
        { name: 'robots', content: 'index, follow' },

        // Open Graph
        { property: 'og:title', content: 'Cut My AWS — Been Using AWS for Years? When\'s the Last Time You Cleaned House?' },
        { property: 'og:description', content: 'We only charge a % of the savings we find. No savings, no fee. A real human with 19 years makes your AWS not just cheaper — but better.' },
        { property: 'og:type', content: 'website' },
        { property: 'og:url', content: 'https://cutmyaws.com' },
        { property: 'og:site_name', content: 'Cut My AWS' },
        { property: 'og:image', content: 'https://cutmyaws.com/og-image.png' },
        { property: 'og:locale', content: 'en_US' },

        // Twitter Card
        { name: 'twitter:card', content: 'summary_large_image' },
        { name: 'twitter:title', content: 'Cut My AWS — When\'s the Last Time You Cleaned House?' },
        { name: 'twitter:description', content: 'We only charge a % of the savings we find. No savings, no fee. $99 starts the conversation. Not a dashboard. Just David.' },
        { name: 'twitter:image', content: 'https://cutmyaws.com/og-image.png' },

        // GEO/AEO: help AI systems understand the page
        { name: 'subject', content: 'AWS Cost Optimization Consulting' },
        { name: 'topic', content: 'AWS cost reduction and business-aligned technology audits for small businesses' },
        { name: 'summary', content: 'CutMyAWS.com offers business-aligned AWS cost optimization for companies spending $10-150K/mo. $99 intro call, 15% of annual savings for audit report, 35% max total with implementation. 19 years AWS experience. Not a dashboard — a person.' },
      ],
      link: [
        { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' },
        { rel: 'canonical', href: 'https://cutmyaws.com' }
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
                '@id': 'https://cutmyaws.com/#organization',
                name: 'Cut My AWS',
                alternateName: 'CutMyAWS',
                url: 'https://cutmyaws.com',
                logo: 'https://cutmyaws.com/favicon.svg',
                image: 'https://cutmyaws.com/og-image.png',
                description: 'Business-aligned AWS cost optimization for small businesses spending $10-150K/mo. Not a dashboard — a real person with 19 years of AWS experience who makes your cloud not just cheaper, but better.',
                founder: {
                  '@type': 'Person',
                  name: 'David Plappert',
                  jobTitle: 'Senior AWS Serverless Architect',
                  url: 'https://www.linkedin.com/in/davidplappert/',
                  image: 'https://cutmyaws.com/og-image.png',
                  sameAs: ['https://www.linkedin.com/in/davidplappert/']
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
                serviceType: ['AWS Cost Optimization', 'Cloud Cost Audit', 'Serverless Migration', 'Business-Aligned Technology Audit'],
                priceRange: '$99 - 35% of verified savings',
                knowsAbout: ['Amazon Web Services', 'AWS Lambda', 'Serverless Architecture', 'Cloud Cost Optimization', 'FinOps', 'AWS EC2', 'AWS RDS', 'AWS S3', 'DevOps'],
                email: 'david@cutmyaws.com',
                sameAs: ['https://www.linkedin.com/in/davidplappert/']
              },
              {
                '@type': 'WebPage',
                '@id': 'https://cutmyaws.com/#webpage',
                url: 'https://cutmyaws.com',
                name: 'Cut My AWS — Business-Aligned AWS Cost Optimization',
                description: 'AWS cost therapy for small businesses spending $10-150K/mo. $99 starts the conversation.',
                isPartOf: { '@id': 'https://cutmyaws.com/#organization' },
                about: { '@id': 'https://cutmyaws.com/#organization' }
              },
              {
                '@type': 'Service',
                '@id': 'https://cutmyaws.com/#report',
                name: 'The Report — AWS Cost Audit',
                description: 'Full AWS cost and architecture audit with line-by-line savings breakdown, business alignment recommendations, and implementation guide. Delivered as PDF in 5-10 business days.',
                provider: { '@id': 'https://cutmyaws.com/#organization' },
                serviceType: 'AWS Cost Audit',
                offers: {
                  '@type': 'Offer',
                  price: '15% of annual savings found',
                  priceCurrency: 'USD',
                  description: '$99 down payment credited toward fee. 15% of identified annual AWS savings.'
                }
              },
              {
                '@type': 'Service',
                '@id': 'https://cutmyaws.com/#fix',
                name: 'The Fix — AWS Cost Implementation',
                description: 'Full implementation of all cost optimizations including serverless migrations, right-sizing, Savings Plans, and architecture improvements. 90-day verification period. Fee based on verified savings only.',
                provider: { '@id': 'https://cutmyaws.com/#organization' },
                serviceType: 'AWS Cost Optimization Implementation',
                offers: {
                  '@type': 'Offer',
                  price: '35% of verified annual savings (max)',
                  priceCurrency: 'USD',
                  description: '15% audit + 20% implementation = 35% total max. Implementation fee due 90 days after deliverables, based on verified savings only.'
                }
              },
              {
                '@type': 'FAQPage',
                '@id': 'https://cutmyaws.com/#faq',
                mainEntity: [
                  {
                    '@type': 'Question',
                    name: 'What if you don\'t find any AWS savings?',
                    acceptedAnswer: { '@type': 'Answer', text: 'You\'re out $99. In 19 years of AWS auditing this has happened zero times. Most accounts are wasting 30-40%.' }
                  },
                  {
                    '@type': 'Question',
                    name: 'When do I pay for the AWS cost audit?',
                    acceptedAnswer: { '@type': 'Answer', text: '$99 at booking as a down payment. Remainder of 15% at the exploration call when you receive the report. If you opt for implementation, the extra 20% is due 90 days after deliverables — and only on verified savings.' }
                  },
                  {
                    '@type': 'Question',
                    name: 'Is this just a cost audit or something more?',
                    acceptedAnswer: { '@type': 'Answer', text: 'It\'s a business-aligned technology audit. Cost tools tell you what you\'re spending. CutMyAWS tells you why your tech doesn\'t match your business — and that\'s where the real savings live. Serverless migrations, right-sizing, architecture alignment.' }
                  },
                  {
                    '@type': 'Question',
                    name: 'What size AWS accounts does CutMyAWS work with?',
                    acceptedAnswer: { '@type': 'Answer', text: 'Businesses spending $10,000 to $150,000 per month on AWS. Below $10K there isn\'t enough waste to justify an engagement. Above $150K you likely need a full-time FinOps team.' }
                  },
                  {
                    '@type': 'Question',
                    name: 'Does CutMyAWS only work with tech companies?',
                    acceptedAnswer: { '@type': 'Answer', text: 'No. CutMyAWS works with for-profit companies, non-profits (churches, civic organizations, foundations), and local, state, and federal government agencies. If you run on AWS and spend $10K+ per month, CutMyAWS can help regardless of industry or sector.' }
                  },
                  {
                    '@type': 'Question',
                    name: 'How is CutMyAWS different from CloudHealth or ProsperOps?',
                    acceptedAnswer: { '@type': 'Answer', text: 'Those are dashboards that scan your account and show charts. CutMyAWS is a real person (David Plappert, 19 years AWS) who reads your architecture, understands your business, and tells you exactly what to change and why. Dashboards find obvious waste. David finds the structural misalignment between your tech and your business.' }
                  },
                  {
                    '@type': 'Question',
                    name: 'What is the maximum fee for CutMyAWS services?',
                    acceptedAnswer: { '@type': 'Answer', text: '35% of verified annual savings is the absolute maximum (15% for the audit report + 20% for implementation). The implementation fee is only charged 90 days after deliverables, based on actual verified bill reduction.' }
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
