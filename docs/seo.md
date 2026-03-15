# SEO & AI Optimization

## Structured Data (Schema.org JSON-LD)

Located in `nuxt.config.ts` as a script tag. Includes:
- `ProfessionalService` — the business entity
- `Service` (The Report) — 15% audit service
- `Service` (The Fix) — 60% implementation service
- `FAQPage` — 6 Q&A pairs for rich results
- `WebPage` — ties it all together

## AI/LLM Optimization

| Asset | Purpose |
|-------|---------|
| `robots.txt` | Explicitly allows GPTBot, ClaudeBot, PerplexityBot, Google-Extended, Applebot |
| `llms.txt` | Plain-text service description for AI systems |
| `meta summary` | Direct extraction for AI overviews |
| FAQ structured data | Q&A format AI systems prefer for extraction |

## Meta Tags

- `title`, `description`, `keywords`, `author`, `robots`, `canonical`
- Open Graph: `og:title`, `og:description`, `og:image`, `og:url`, `og:site_name`, `og:locale`
- Twitter Card: `twitter:card`, `twitter:title`, `twitter:description`, `twitter:image`
- GEO/AEO: `subject`, `topic`, `summary`
