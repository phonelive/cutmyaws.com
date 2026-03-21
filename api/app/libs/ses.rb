# =============================================================================
# AWS SES EMAIL HELPER
# =============================================================================
#
# Sends email notifications via Amazon SES.
#   - send_lead_notification: new form submission (conversion)
#   - send_abandoned_lead_notification: partial form abandoned after 1hr
#
# SES IDENTITY: cutmyaws.com domain (verified in SES)
# FROM: leads@cutmyaws.com
# TO:   david@cutmyaws.com
#
# =============================================================================

#
def send_lead_notification(lead)
  begin
    ses_client_opts = { region: 'us-east-1' }
    if ENV['IS_LOCAL'] && !ENV['IS_LOCAL'].empty?
      ses_client_opts[:ssl_verify_peer] = false
    end
    ses = Aws::SES::Client.new(ses_client_opts)

    subject = "New Lead: #{lead[:name]} — #{lead[:aws_monthly]}/mo"

    body = <<~EMAIL
      New lead from cutmyaws.com

      Name: #{lead[:name]}
      Email: #{lead[:email]}
      AWS Monthly Spend: #{lead[:aws_monthly]}
      Company: #{lead[:company]}
      Best Times: #{lead[:availability] || '(not specified)'}
      Notes: #{lead[:notes].to_s.strip.empty? ? '(none)' : lead[:notes]}

      Campaign: #{lead[:utm_campaign] || '(none)'}
      Source: #{lead[:utm_source] || '(none)'} / #{lead[:utm_medium] || '(none)'}
      Page: #{lead[:page_url] || '(none)'}
      Submitted: #{lead[:created_at]}

      ---
      Reply to this person to schedule the intro call.
    EMAIL

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

    puts "[SES] Notification sent for #{lead[:name]} (#{lead[:email]})"

    # Also notify Slack
    slack_notify_lead(lead, type: 'submitted')

    return true

  rescue StandardError => e
    puts "[ERROR] SES send failed: #{e.class}: #{e.message}"
    puts e.backtrace&.first(3)&.join("\n")
    return false
  end
end

# -----------------------------------------------------------------------------
# Send Abandoned Lead Notification
# -----------------------------------------------------------------------------
# Fires when a partial form hasn't been updated in 1+ hour.
#
def send_abandoned_lead_notification(lead)
  begin
    ses_client_opts = { region: 'us-east-1' }
    if ENV['IS_LOCAL'] && !ENV['IS_LOCAL'].empty?
      ses_client_opts[:ssl_verify_peer] = false
    end
    ses = Aws::SES::Client.new(ses_client_opts)

    subject = "Abandoned Lead: #{lead[:name].to_s.empty? ? lead[:email] : lead[:name]} — #{lead[:aws_monthly]}"

    body = <<~EMAIL
      Someone started filling out the form but didn't submit.

      Name: #{lead[:name].to_s.empty? ? '(not entered)' : lead[:name]}
      Email: #{lead[:email]}
      AWS Monthly Spend: #{lead[:aws_monthly].to_s.empty? ? '(not entered)' : lead[:aws_monthly]}
      Company: #{lead[:company].to_s.empty? ? '(not entered)' : lead[:company]}
      Best Times: #{lead[:availability].to_s.empty? ? '(not entered)' : lead[:availability]}
      Notes: #{lead[:notes].to_s.strip.empty? ? '(none)' : lead[:notes]}

      Campaign: #{lead[:utm_campaign].to_s.empty? ? '(none)' : lead[:utm_campaign]}
      Page: #{lead[:page_url].to_s.empty? ? '(none)' : lead[:page_url]}
      Started: #{lead[:created_at]}
      Last Updated: #{lead[:updated_at]}

      ---
      This person started the form but didn't finish.
      Consider reaching out if they left an email address.
    EMAIL

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

    puts "[SES] Abandoned lead notification sent for #{lead[:email]}"

    # Also notify Slack
    slack_notify_lead(lead, type: 'abandoned')

    return true

  rescue StandardError => e
    puts "[ERROR] SES abandoned send failed: #{e.class}: #{e.message}"
    puts e.backtrace&.first(3)&.join("\n")
    return false
  end
end
