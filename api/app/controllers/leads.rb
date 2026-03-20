# =============================================================================
# LEADS CONTROLLER
# =============================================================================
#
# Handles POST /leads — contact form submissions from cutmyaws.com.
# Validates data, checks Turnstile, saves lead to TiDB, emails David.
#
# ENDPOINT:
#   POST /leads
#   GET  /leads (health check)
#
# REQUEST BODY (JSON):
#   {
#     "name": "Jane Smith",
#     "email": "jane@company.com",
#     "company": "Acme Corp — we build widgets",
#     "awsMonthly": "$25K - $50K",
#     "availability": "Mon morning, Wed afternoon",
#     "notes": "Multiple accounts",
#     "turnstileToken": "0.abc123...",
#     "utmSource": "google",
#     "utmMedium": "cpc",
#     "utmCampaign": "homepage-top",
#     "pageUrl": "https://cutmyaws.com"
#   }
#
# =============================================================================

def leads_post(event, context)
  api_handler(event, context) do
    body = JSON.parse(event['body'] || '{}')

    data = {
      name:          body['name'],
      email:         body['email'],
      company:       body['company'],
      aws_monthly:   body['awsMonthly'],
      availability:  body['availability'],
      notes:         body['notes'],
      turnstile:     body['turnstileToken'],
      utm_source:    body['utmSource'],
      utm_medium:    body['utmMedium'],
      utm_campaign:  body['utmCampaign'],
      page_url:      body['pageUrl'],
    }

    # Validation
    errors = validate_lead(data)
    if errors.any?
      puts "[LEAD] Validation failed: #{errors.join(', ')}"
      next api_error_validation(errors.join('. '), { fields: errors })
    end

    # Turnstile
    if data[:turnstile].nil? || data[:turnstile].empty?
      puts "[LEAD] Missing Turnstile token"
      next api_error_forbidden('Bot detection failed — please try again or email david@cutmyaws.com')
    end

    turnstile_valid = validate_turnstile(data[:turnstile])
    unless turnstile_valid
      puts "[LEAD] Turnstile validation failed for #{data[:email]}"
      next api_error_forbidden('Bot detection failed — please try again or email david@cutmyaws.com')
    end

    # Save to TiDB
    ip_address = event.dig('requestContext', 'http', 'sourceIp') ||
                 event.dig('headers', 'x-forwarded-for')&.split(',')&.first&.strip
    user_agent = event.dig('headers', 'user-agent') || event.dig('headers', 'User-Agent')

    begin
      conn = ActiveRecord::Base.connection
      conn.execute(
        ActiveRecord::Base.sanitize_sql_array([
          "INSERT INTO leads (name, email, company, aws_monthly, availability, notes, turnstile_success, ip_address, user_agent, utm_source, utm_medium, utm_campaign, page_url, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())",
          data[:name].strip,
          data[:email].strip.downcase,
          data[:company].strip,
          data[:aws_monthly],
          data[:availability],
          data[:notes].to_s.strip,
          true,
          ip_address,
          user_agent&.slice(0, 500),
          data[:utm_source],
          data[:utm_medium],
          data[:utm_campaign],
          data[:page_url],
        ])
      )
      puts "[LEAD] Saved: #{data[:name]} (#{data[:email]}) — #{data[:aws_monthly]}"
    rescue StandardError => e
      puts "[ERROR] Failed to save lead to TiDB: #{e.class}: #{e.message}"
      puts e.backtrace&.first(3)&.join("\n")
    end

    # Email David
    send_lead_notification({
      name:         data[:name].strip,
      email:        data[:email].strip.downcase,
      company:      data[:company].strip,
      aws_monthly:  data[:aws_monthly],
      availability: data[:availability],
      notes:        data[:notes],
      utm_source:   data[:utm_source],
      utm_medium:   data[:utm_medium],
      utm_campaign: data[:utm_campaign],
      page_url:     data[:page_url],
      created_at:   Time.now.utc.strftime('%Y-%m-%d %H:%M:%S UTC'),
    })

    api_success({ success: true }, 200)
  end
end

def leads_get(event, context)
  api_handler(event, context) do
    api_success({
      service: 'cutmyaws-leads',
      env: ENV['env'],
      status: 'ok',
    })
  end
end
