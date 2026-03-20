-- =============================================================================
-- MIGRATION 002: Create leads table
-- =============================================================================
--
-- Replaces prequal_submissions. Stores contact form submissions from cutmyaws.com.
--
-- RUN MANUALLY on both dev and prod TiDB instances.
--
-- =============================================================================

CREATE TABLE IF NOT EXISTS leads (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,

  -- Form fields
  name VARCHAR(100) NOT NULL,
  email VARCHAR(255) NOT NULL,
  company TEXT NOT NULL,
  aws_monthly VARCHAR(255) NOT NULL,
  availability TEXT,
  notes TEXT,

  -- Bot detection
  turnstile_success BOOLEAN DEFAULT TRUE,

  -- Request metadata
  ip_address VARCHAR(45),
  user_agent TEXT,

  -- UTM tracking
  utm_source VARCHAR(100),
  utm_medium VARCHAR(100),
  utm_campaign VARCHAR(100),

  -- Page context
  page_url VARCHAR(500),

  -- Timestamp
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  INDEX idx_email (email),
  INDEX idx_created (created_at)
);
