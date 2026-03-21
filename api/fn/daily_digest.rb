# =============================================================================
# DAILY DIGEST — Scheduled Function
# =============================================================================
#
# Runs daily at 5:45am CT via EventBridge. Queries the leads table for all
# entries from the past 7 days and sends a summary email to David.
#
# INVOKED VIA: router.rb run_method = "daily_digest"
#
# =============================================================================

def daily_digest(event)
  puts "[DIGEST] Running daily leads digest..."

  begin
    conn = ActiveRecord::Base.connection

    results = conn.execute(
      "SELECT id, name, email, company, aws_monthly, availability, notes, status, utm_source, utm_medium, utm_campaign, page_url, created_at, updated_at FROM leads WHERE created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY) ORDER BY created_at DESC"
    )

    submitted = []
    partial = []
    notified = []

    results.each do |row|
      id, name, email, company, aws_monthly, availability, notes, status, utm_source, utm_medium, utm_campaign, page_url, created_at, updated_at = row
      entry = {
        id: id, name: name.to_s, email: email.to_s, company: company.to_s,
        aws_monthly: aws_monthly.to_s, availability: availability.to_s,
        notes: notes.to_s, status: status.to_s,
        utm_source: utm_source.to_s, utm_medium: utm_medium.to_s,
        utm_campaign: utm_campaign.to_s, page_url: page_url.to_s,
        created_at: created_at.to_s, updated_at: updated_at.to_s,
      }

      case status
      when 'submitted' then submitted << entry
      when 'partial' then partial << entry
      when 'notified' then notified << entry
      end
    end

    total = results.count

    # Build email
    subject = "CutMyAWS Daily Digest — #{total} lead#{'s' unless total == 1} (past 7 days)"

    body = <<~EMAIL
      Daily Leads Digest — #{Time.now.utc.strftime('%B %d, %Y')}
      ================================================================

      SUMMARY (past 7 days)
        Submitted:  #{submitted.count}
        Abandoned:  #{notified.count}
        Partial:    #{partial.count}
        Total:      #{total}

    EMAIL

    if submitted.any?
      body += "================================================================\n"
      body += "SUBMITTED LEADS (#{submitted.count})\n"
      body += "================================================================\n\n"
      submitted.each_with_index do |lead, i|
        body += format_lead(lead, i + 1)
      end
    end

    if notified.any?
      body += "================================================================\n"
      body += "ABANDONED LEADS (#{notified.count})\n"
      body += "================================================================\n\n"
      notified.each_with_index do |lead, i|
        body += format_lead(lead, i + 1)
      end
    end

    if partial.any?
      body += "================================================================\n"
      body += "PARTIAL / IN-PROGRESS (#{partial.count})\n"
      body += "================================================================\n\n"
      partial.each_with_index do |lead, i|
        body += format_lead(lead, i + 1)
      end
    end

    if total == 0
      body += "No leads in the past 7 days.\n"
    end

    body += "\n---\nCutMyAWS Daily Digest · Sent at #{Time.now.utc.strftime('%H:%M UTC')}\n"

    # Send via SES
    ses_client_opts = { region: 'us-east-1' }
    ses = Aws::SES::Client.new(ses_client_opts)

    ses.send_email({
      source: 'leads@cutmyaws.com',
      destination: {
        to_addresses: ['david@cutmyaws.com']
      },
      message: {
        subject: { data: subject },
        body: {
          text: { data: body }
        }
      }
    })

    puts "[DIGEST] Sent digest: #{total} leads (#{submitted.count} submitted, #{notified.count} abandoned, #{partial.count} partial)"
    return true

  rescue StandardError => e
    puts "[ERROR] Daily digest failed: #{e.class}: #{e.message}"
    puts e.backtrace&.first(5)&.join("\n")
    return false
  end
end

def format_lead(lead, num)
  name_display = lead[:name].empty? ? '(no name)' : lead[:name]
  email_display = lead[:email].empty? ? '(no email)' : lead[:email]

  text = "  #{num}. #{name_display} — #{email_display}\n"
  text += "     Company:    #{lead[:company].empty? ? '(none)' : lead[:company]}\n"
  text += "     AWS Spend:  #{lead[:aws_monthly].empty? ? '(none)' : lead[:aws_monthly]}\n"
  text += "     Status:     #{lead[:status]}\n"
  text += "     Campaign:   #{lead[:utm_campaign].empty? ? '(none)' : lead[:utm_campaign]}\n"
  text += "     Source:     #{lead[:utm_source].empty? ? '(none)' : lead[:utm_source]} / #{lead[:utm_medium].empty? ? '(none)' : lead[:utm_medium]}\n"
  text += "     Page:       #{lead[:page_url].empty? ? '(none)' : lead[:page_url]}\n"
  text += "     Created:    #{lead[:created_at]}\n"
  text += "\n"
  text
end
