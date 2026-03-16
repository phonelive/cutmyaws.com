-- =============================================================================
-- MIGRATION 001: Create prequal_submissions table
-- =============================================================================
--
-- Stores pre-qualification form submissions from cutmyaws.com.
-- Each row represents a lead who filled out the form before seeing Calendly.
--
-- DATABASE: TiDB Cloud (MySQL-compatible)
-- TABLE: prequal_submissions
--
-- RUN MANUALLY:
--   mysql -h gateway01.us-east-1.prod.aws.tidbcloud.com -P 4000 \
--     -u '4EA5RRLJJAkgUTA.root' -p test < db/001_create_prequal_submissions.sql
--
-- OR VIA RAKE:
--   bundle exec rake db_create
--
-- =============================================================================

CREATE TABLE IF NOT EXISTS prequal_submissions (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,

  -- Form fields
  name VARCHAR(100) NOT NULL,             -- Full name
  email VARCHAR(255) NOT NULL,            -- Work email
  company TEXT NOT NULL,                  -- Company name + what they do
  aws_monthly VARCHAR(50) NOT NULL,       -- Monthly AWS spend bracket (dropdown value)

  -- Bot detection
  turnstile_success BOOLEAN DEFAULT TRUE, -- Cloudflare Turnstile validation result

  -- Request metadata (for analytics and fraud detection)
  ip_address VARCHAR(45),                 -- Client IP (supports IPv6)
  user_agent TEXT,                        -- Browser user agent string

  -- UTM tracking (from URL parameters)
  utm_source VARCHAR(100),                -- e.g., "google", "reddit"
  utm_medium VARCHAR(100),                -- e.g., "cpc", "paid", "organic"
  utm_campaign VARCHAR(100),              -- e.g., "cutmyaws-investors", "cutmyaws-25pct"

  -- Page context
  page_url VARCHAR(500),                  -- Which page the form was on

  -- Timestamp
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  -- Indexes
  INDEX idx_email (email),
  INDEX idx_created (created_at)
);
