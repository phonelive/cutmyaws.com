#!/usr/bin/env node
// Post-build: inline CSS into prerendered HTML files.
// Session replay tools (MS Clarity, Hotjar) capture the DOM snapshot
// but can't always fetch external CSS files — especially after a
// deploy changes the hashed filenames. Inlining fixes this.

import { readFileSync, writeFileSync, readdirSync, statSync } from 'node:fs'
import { join, resolve } from 'node:path'

const publicDir = resolve('.output/public')
const nuxtDir = join(publicDir, '_nuxt')

// Find the entry CSS file
const cssFile = readdirSync(nuxtDir).find(f => f.startsWith('entry.') && f.endsWith('.css'))
if (!cssFile) {
  console.log('⚠️  No entry CSS file found — skipping inline')
  process.exit(0)
}

const css = readFileSync(join(nuxtDir, cssFile), 'utf-8')
const linkPattern = `<link rel="stylesheet" href="/_nuxt/${cssFile}" crossorigin>`
const styleTag = `<style>${css}</style>`

// Walk all HTML files and replace the <link> with inline <style>
let count = 0
function walk(dir) {
  for (const entry of readdirSync(dir)) {
    const full = join(dir, entry)
    if (statSync(full).isDirectory()) {
      walk(full)
    } else if (entry.endsWith('.html')) {
      const html = readFileSync(full, 'utf-8')
      if (html.includes(linkPattern)) {
        writeFileSync(full, html.replace(linkPattern, styleTag))
        count++
      }
    }
  }
}

walk(publicDir)
console.log(`✅ Inlined ${cssFile} (${(css.length / 1024).toFixed(1)}KB) into ${count} HTML files`)
