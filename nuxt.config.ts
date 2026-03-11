export default defineNuxtConfig({
  compatibilityDate: '2025-01-01',
  future: { compatibilityVersion: 4 },
  modules: ['@nuxtjs/tailwindcss'],
  experimental: {
    inlineStyles: false
  },
  nitro: {
    preset: 'github-pages'
  },
  site: {
    url: 'https://cutmyaws.com'
  },
  app: {
    head: {
      htmlAttrs: { lang: 'en' },
      bodyAttrs: { style: 'background-color:#030712' },
      title: 'Cut My AWS — Been Using AWS for Years? When\'s the Last Time You Cleaned House?',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },

        // SEO meta
        { name: 'description', content: 'Cloud cost optimization for AWS — 300+ services, years of buildup, cobwebs everywhere. We only charge a % of the savings we find — no savings, no fee. A real human consultant with 19 years of AWS experience delivers cloud cost optimization strategies that make your infrastructure not just cheaper, but better. Free intro call.' },
        { name: 'keywords', content: 'cloud cost optimization, cloud cost optimization solutions, cloud cost optimization strategies, cloud cost optimization services, cloud cost savings, reduce cloud cost, AWS cost optimization, AWS cloud cost optimization, reduce AWS cost, AWS cost savings, cloud cost management, FinOps, FinOps consulting, FinOps consultant, AWS consulting, serverless migration, cut AWS bill, AWS waste, business-aligned technology audit' },
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
        { name: 'twitter:description', content: 'We only charge a % of the savings we find. No savings, no fee. Free intro call. Not a dashboard. Just David.' },
        { name: 'twitter:image', content: 'https://cutmyaws.com/og-image.png' },

        // GEO/AEO: help AI systems understand the page
        { name: 'subject', content: 'Cloud Cost Optimization & AWS FinOps Consulting' },
        { name: 'topic', content: 'Cloud cost optimization, AWS cost savings, and business-aligned technology audits for small businesses' },
        { name: 'summary', content: 'CutMyAWS.com offers cloud cost optimization and business-aligned AWS consulting for companies spending $10-150K/mo. Cloud cost optimization solutions include architecture audit, serverless migration, and implementation — priced at 15% of annual savings found, 50% max total. 19 years AWS experience. Not a dashboard — a real consultant.' },
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
                description: 'Cloud cost optimization solutions for small businesses spending $10-150K/mo on AWS. Business-aligned cloud cost optimization strategies from a real consultant with 19 years of AWS experience — not a dashboard, not an AI.',
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
                serviceType: ['Cloud Cost Optimization', 'AWS Cost Optimization', 'Cloud Cost Optimization Solutions', 'Cloud Cost Optimization Services', 'FinOps Consulting', 'Cloud Cost Audit', 'Serverless Migration', 'Business-Aligned Technology Audit'],
                priceRange: '15-50% of verified savings',
                knowsAbout: ['Cloud Cost Optimization', 'Cloud Cost Optimization Solutions', 'Cloud Cost Optimization Strategies', 'Cloud Cost Savings', 'Amazon Web Services', 'AWS Lambda', 'Serverless Architecture', 'FinOps', 'FinOps Consulting', 'AWS FinOps', 'AWS EC2', 'AWS RDS', 'AWS S3', 'DevOps'],
                email: 'david@cutmyaws.com',
                sameAs: ['https://www.linkedin.com/in/davidplappert/']
              },
              {
                '@type': 'WebPage',
                '@id': 'https://cutmyaws.com/#webpage',
                url: 'https://cutmyaws.com',
                name: 'Cut My AWS — Cloud Cost Optimization & AWS FinOps Consulting',
                description: 'Cloud cost optimization solutions and AWS cost savings for small businesses spending $10-150K/mo. Free intro call.',
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
                  description: 'Free intro call. 15% of identified annual AWS savings due at exploration call.'
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
                    acceptedAnswer: { '@type': 'Answer', text: 'Nothing. The intro call is free. In 19 years of AWS auditing this has happened zero times. Most accounts are wasting 30-40%.' }
                  },
                  {
                    '@type': 'Question',
                    name: 'When do I pay for the AWS cost audit?',
                    acceptedAnswer: { '@type': 'Answer', text: 'The intro call is free. 15% is due at the exploration call when you receive the report. If you opt for implementation, the extra 35% is due 90 days after deliverables — and only on verified savings.' }
                  },
                  {
                    '@type': 'Question',
                    name: 'Is this just a cost audit or something more?',
                    acceptedAnswer: { '@type': 'Answer', text: 'It\'s a business-aligned technology audit. Cloud cost optimization tools tell you what you\'re spending. CutMyAWS tells you why your tech doesn\'t match your business — and that\'s where the real cloud cost savings live. Serverless migrations, right-sizing, architecture alignment.' }
                  },
                  {
                    '@type': 'Question',
                    name: 'What size AWS accounts does CutMyAWS work with?',
                    acceptedAnswer: { '@type': 'Answer', text: 'Businesses spending $5,000 to $150,000 per month on AWS. Below $5K there isn\'t enough waste to justify an engagement. Above $150K you likely need a full-time FinOps team.' }
                  },
                  {
                    '@type': 'Question',
                    name: 'Does CutMyAWS only work with tech companies?',
                    acceptedAnswer: { '@type': 'Answer', text: 'No. CutMyAWS works with for-profit companies, non-profits (churches, civic organizations, foundations), and local, state, and federal government agencies. If you run on AWS and spend $5K+ per month, CutMyAWS can help regardless of industry or sector.' }
                  },
                  {
                    '@type': 'Question',
                    name: 'How is CutMyAWS different from cloud cost optimization tools like CloudHealth or ProsperOps?',
                    acceptedAnswer: { '@type': 'Answer', text: 'Cloud cost optimization tools scan your account and show charts. CutMyAWS is a real consultant (David Plappert, 19 years AWS) who reads your architecture, understands your business, and tells you exactly what to change and why. Cloud cost optimization platforms find obvious waste. David finds the structural misalignment between your tech and your business — the kind of cloud cost optimization insight no dashboard can deliver.' }
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
