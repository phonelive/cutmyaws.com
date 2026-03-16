# =============================================================================
# PRE-QUALIFICATION FORM CONTROLLER
# =============================================================================
#
# Handles POST /prequal — the main (and currently only) API endpoint.
# Receives pre-qualification form submissions from cutmyaws.com, validates
# the data, checks Turnstile, saves the lead to TiDB, and emails David.
#
# ENDPOINT:
#   POST /prequal
#
# REQUEST BODY (JSON):
#   {
#     "name": "Jane Smith",
#     "email": "jane@company.com",
#     "company": "Acme Corp — we build widgets",
#     "awsMonthly": "$25K - $50K",
#     "turnstileToken": "0.abc123...",
#     "utmSource": "google",
#     "utmMedium": "cpc",
#     "utmCampaign": "cutmyaws-investors",
#     "pageUrl": "https://cutmyaws.com/investors"
#   }
#
# RESPONSE (200):
#   { "success": true }
#
# ERRORS:
#   400 — Missing/invalid fields (returns validation errors)
#   403 — Turnstile failed (bot detected)
#   500 — Server error
#
# FLOW:
#   1. Parse JSON body
#   2. Server-side validation (name, email, spend, company)
#   3. Verify Turnstile token with Cloudflare
#   4. INSERT into prequal_submissions table in TiDB
#   5. Send notification email to David via SES
#   6. Return success (frontend reveals Calendly with pre-filled data)
#
# =============================================================================

def prequal_post(event, context)
  api_handler(event, context) do
    # -------------------------------------------------------------------------
    # 1. Parse request body
    # -------------------------------------------------------------------------
    body = JSON.parse(event['body'] || '{}')

    data = {
      name:          body['name'],
      email:         body['email'],
      company:       body['company'],
      aws_monthly:   body['awsMonthly'],
      turnstile:     body['turnstileToken'],
      utm_source:    body['utmSource'],
      utm_medium:    body['utmMedium'],
      utm_campaign:  body['utmCampaign'],
      page_url:      body['pageUrl'],
    }

    # -------------------------------------------------------------------------
    # 2. Server-side validation
    # -------------------------------------------------------------------------
    errors = validate_prequal(data)
    if errors.any?
      puts "[PREQUAL] Validation failed: #{errors.join(', ')}"
      next api_error_validation(errors.join('. '), { fields: errors })
    end

    # -------------------------------------------------------------------------
    # 3. Verify Turnstile token
    # -------------------------------------------------------------------------
    # Turnstile prevents bot/spam submissions. If the token is missing or
    # invalid, we reject the request. If Turnstile is blocked by an ad
    # blocker, the frontend shows a fallback message.
    #
    if data[:turnstile].nil? || data[:turnstile].empty?
      puts "[PREQUAL] Missing Turnstile token"
      next api_error_forbidden('Bot detection failed — please try again or email david@cutmyaws.com')
    end

    turnstile_valid = validate_turnstile(data[:turnstile])
    unless turnstile_valid
      puts "[PREQUAL] Turnstile validation failed for #{data[:email]}"
      next api_error_forbidden('Bot detection failed — please try again or email david@cutmyaws.com')
    end

    # -------------------------------------------------------------------------
    # 4. Save lead to TiDB
    # -------------------------------------------------------------------------
    # Extract IP and user agent from the request for analytics/fraud detection.
    #
    ip_address = event.dig('requestContext', 'http', 'sourceIp') ||
                 event.dig('headers', 'x-forwarded-for')&.split(',')&.first&.strip
    user_agent = event.dig('headers', 'user-agent') || event.dig('headers', 'User-Agent')

    begin
      conn = ActiveRecord::Base.connection
      conn.execute(
        ActiveRecord::Base.sanitize_sql_array([
          "INSERT INTO prequal_submissions (name, email, company, aws_monthly, turnstile_success, ip_address, user_agent, utm_source, utm_medium, utm_campaign, page_url, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())",
          data[:name].strip,
          data[:email].strip.downcase,
          data[:company].strip,
          data[:aws_monthly],
          true,
          ip_address,
          user_agent&.slice(0, 500),
          data[:utm_source],
          data[:utm_medium],
          data[:utm_campaign],
          data[:page_url],
        ])
      )
      puts "[PREQUAL] Lead saved: #{data[:name]} (#{data[:email]}) — #{data[:aws_monthly]}"
    rescue StandardError => e
      # Log but don't fail — the lead data is also in the SES email
      puts "[ERROR] Failed to save lead to TiDB: #{e.class}: #{e.message}"
      puts e.backtrace&.first(3)&.join("\n")
    end

    # -------------------------------------------------------------------------
    # 5. Send notification email to David
    # -------------------------------------------------------------------------
    send_prequal_notification({
      name:         data[:name].strip,
      email:        data[:email].strip.downcase,
      company:      data[:company].strip,
      aws_monthly:  data[:aws_monthly],
      utm_source:   data[:utm_source],
      utm_medium:   data[:utm_medium],
      utm_campaign: data[:utm_campaign],
      page_url:     data[:page_url],
      created_at:   Time.now.utc.strftime('%Y-%m-%d %H:%M:%S UTC'),
    })

    # -------------------------------------------------------------------------
    # 6. Return success
    # -------------------------------------------------------------------------
    # The frontend uses this to reveal the Calendly widget with pre-filled data.
    #
    api_success({ success: true }, 200)
  end
end

# =============================================================================
# HEALTH CHECK ENDPOINT
# =============================================================================
#
# GET /prequal — simple health check to verify the API is running.
# Returns the service name and environment.
#
def prequal_get(event, context)
  api_handler(event, context) do
    api_success({
      service: 'cutmyaws-prequal',
      env: ENV['env'],
      status: 'ok',
    })
  end
end
