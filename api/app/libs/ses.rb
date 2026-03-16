# =============================================================================
# AWS SES EMAIL HELPER
# =============================================================================
#
# Sends email notifications via Amazon SES. Used to notify David when a new
# pre-qualification form is submitted.
#
# SES IDENTITY: cutmyaws.com domain (must be verified in SES)
# FROM ADDRESS: prequal@cutmyaws.com
# TO ADDRESS:   david@cutmyaws.com
#
# SES SETUP REQUIREMENTS:
#   1. Verify cutmyaws.com domain in SES (or request production access)
#   2. If in SES sandbox, verify david@cutmyaws.com as a recipient
#   3. Lambda IAM role needs ses:SendEmail permission (in serverless.yml)
#
# =============================================================================

# -----------------------------------------------------------------------------
# Send Pre-Qualification Notification Email
# -----------------------------------------------------------------------------
# Sends an email to David with the pre-qualification form details.
# This fires immediately after a valid form submission so David can
# follow up quickly.
#
# @param lead [Hash] Lead data with keys:
#   :name         — Full name
#   :email        — Work email
#   :company      — Company name and description
#   :aws_monthly  — Monthly AWS spend bracket (e.g., "$25K - $50K")
#   :utm_source   — UTM source (e.g., "google")
#   :utm_medium   — UTM medium (e.g., "cpc")
#   :utm_campaign — UTM campaign (e.g., "cutmyaws-investors")
#   :page_url     — Page URL where form was submitted
#   :created_at   — Submission timestamp
#
# @return [Boolean] true if sent, false on error
#
def send_prequal_notification(lead)
  begin
    ses_client_opts = { region: 'us-east-1' }
    if ENV['IS_LOCAL'] && !ENV['IS_LOCAL'].empty?
      ses_client_opts[:ssl_verify_peer] = false
    end
    ses = Aws::SES::Client.new(ses_client_opts)

    subject = "New Pre-Qual: #{lead[:name]} — #{lead[:aws_monthly]}/mo"

    body = <<~EMAIL
      New pre-qualification submission from cutmyaws.com

      Name: #{lead[:name]}
      Email: #{lead[:email]}
      AWS Monthly Spend: #{lead[:aws_monthly]}
      Company: #{lead[:company]}

      Campaign: #{lead[:utm_campaign] || '(none)'}
      Source: #{lead[:utm_source] || '(none)'} / #{lead[:utm_medium] || '(none)'}
      Page: #{lead[:page_url] || '(none)'}
      Submitted: #{lead[:created_at]}

      ---
      This person is now seeing the Calendly booking widget.
    EMAIL

    ses.send_email({
      source: 'prequal@cutmyaws.com',
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
    return true

  rescue StandardError => e
    # Don't let SES failures break the form submission
    puts "[ERROR] SES send failed: #{e.class}: #{e.message}"
    puts e.backtrace&.first(3)&.join("\n")
    return false
  end
end
