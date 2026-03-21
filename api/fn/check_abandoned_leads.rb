# =============================================================================
# CHECK ABANDONED LEADS — Scheduled Function
# =============================================================================
#
# Runs periodically (every 30 min via EventBridge). Finds partial leads
# that have data but haven't been updated in 1+ hour, and emails David.
#
# LOGIC:
#   1. Find leads where status='partial' AND updated_at < 1 hour ago
#      AND email is not empty (has enough data to be useful)
#   2. Send notification email to David for each one
#   3. Mark as 'notified' so we don't email again
#
# INVOKED VIA: router.rb run_method = "check_abandoned_leads"
#
# =============================================================================

def check_abandoned_leads(event)
  puts "[ABANDONED] Checking for abandoned leads..."

  begin
    conn = ActiveRecord::Base.connection

    # Find partial leads with email, stale for 1+ hour
    results = conn.execute(
      "SELECT id, session_id, name, email, company, aws_monthly, availability, notes, utm_campaign, page_url, created_at, updated_at FROM leads WHERE status = 'partial' AND email != '' AND updated_at < DATE_SUB(NOW(), INTERVAL 1 HOUR) ORDER BY updated_at ASC LIMIT 20"
    )

    if results.count == 0
      puts "[ABANDONED] No abandoned leads found"
      return true
    end

    puts "[ABANDONED] Found #{results.count} abandoned lead(s)"

    results.each do |row|
      id, session_id, name, email, company, aws_monthly, availability, notes, utm_campaign, page_url, created_at, updated_at = row

      puts "[ABANDONED] Processing: #{name} (#{email}) — session #{session_id}"

      # Send email to David
      send_abandoned_lead_notification({
        name:         name.to_s,
        email:        email.to_s,
        company:      company.to_s,
        aws_monthly:  aws_monthly.to_s,
        availability: availability.to_s,
        notes:        notes.to_s,
        utm_campaign: utm_campaign.to_s,
        page_url:     page_url.to_s,
        created_at:   created_at.to_s,
        updated_at:   updated_at.to_s,
      })

      # Mark as notified
      conn.execute(
        ActiveRecord::Base.sanitize_sql_array([
          "UPDATE leads SET status = 'notified' WHERE id = ?", id
        ])
      )

      puts "[ABANDONED] Notified and marked: #{email}"
    end

    return true

  rescue StandardError => e
    puts "[ERROR] Abandoned lead check failed: #{e.class}: #{e.message}"
    puts e.backtrace&.first(5)&.join("\n")
    return false
  end
end
