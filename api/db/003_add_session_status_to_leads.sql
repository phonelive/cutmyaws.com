-- =============================================================================
-- MIGRATION 003: Add session tracking and status to leads
-- =============================================================================
--
-- Supports auto-save (partial leads) and abandoned form recovery.
--
-- session_id: UUID generated client-side, used to upsert partial saves
-- status: partial (auto-saved), submitted (form submitted), notified (abandoned email sent)
-- updated_at: tracks last auto-save for abandoned form detection
--
-- =============================================================================

ALTER TABLE leads ADD COLUMN session_id VARCHAR(36) AFTER id;
ALTER TABLE leads ADD COLUMN status VARCHAR(20) DEFAULT 'partial' AFTER session_id;
ALTER TABLE leads ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER created_at;
CREATE UNIQUE INDEX idx_session ON leads(session_id);
