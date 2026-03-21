# =============================================================================
# LEADS CONTROLLER
# =============================================================================
#
# POST /leads          — full form submit (conversion)
# POST /leads/partial  — auto-save as user types (no Turnstile required)
# GET  /leads          — health check
#
# =============================================================================

# -----------------------------------------------------------------------------
# POST /leads — full form submit (conversion event)
# -----------------------------------------------------------------------------
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
      session_id:    body['sessionId'],
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

    # Save/update lead — upsert by session_id if present
    ip_address = event.dig('requestContext', 'http', 'sourceIp') ||
                 event.dig('headers', 'x-forwarded-for')&.split(',')&.first&.strip
    user_agent = event.dig('headers', 'user-agent') || event.dig('headers', 'User-Agent')

    begin
      conn = ActiveRecord::Base.connection

      if data[:session_id] && !data[:session_id].empty?
        # Update existing partial lead to submitted
        conn.execute(
          ActiveRecord::Base.sanitize_sql_array([
            "UPDATE leads SET name = ?, email = ?, company = ?, aws_monthly = ?, availability = ?, notes = ?, status = 'submitted', turnstile_success = ?, ip_address = ?, user_agent = ?, utm_source = ?, utm_medium = ?, utm_campaign = ?, page_url = ? WHERE session_id = ?",
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
            data[:session_id],
          ])
        )
        # If no rows updated (no partial existed), insert fresh
        rows_affected = conn.execute("SELECT ROW_COUNT() AS c").first[0]
        if rows_affected == 0
          insert_lead(conn, data, ip_address, user_agent, 'submitted')
        end
      else
        insert_lead(conn, data, ip_address, user_agent, 'submitted')
      end

      puts "[LEAD] Submitted: #{data[:name]} (#{data[:email]}) — #{data[:aws_monthly]}"
    rescue StandardError => e
      puts "[ERROR] Failed to save lead: #{e.class}: #{e.message}"
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

# -----------------------------------------------------------------------------
# POST /leads/partial — auto-save as user types (no Turnstile)
# -----------------------------------------------------------------------------
def leads_partial_post(event, context)
  api_handler(event, context) do
    body = JSON.parse(event['body'] || '{}')

    session_id = body['sessionId'].to_s.strip
    if session_id.empty? || session_id.length > 36
      next api_error_bad_request('Invalid session ID')
    end

    # Extract fields (all optional for partial saves)
    name       = body['name'].to_s.strip.slice(0, 100)
    email      = body['email'].to_s.strip.downcase.slice(0, 255)
    company    = body['company'].to_s.strip.slice(0, 500)
    aws_monthly = body['awsMonthly'].to_s.strip.slice(0, 255)
    availability = body['availability'].to_s.strip.slice(0, 500)
    notes      = body['notes'].to_s.strip.slice(0, 1000)
    utm_source = body['utmSource'].to_s.strip.slice(0, 100)
    utm_medium = body['utmMedium'].to_s.strip.slice(0, 100)
    utm_campaign = body['utmCampaign'].to_s.strip.slice(0, 100)
    page_url   = body['pageUrl'].to_s.strip.slice(0, 500)

    # Skip if no useful data
    if name.empty? && email.empty? && company.empty? && aws_monthly.empty?
      next api_success({ saved: false, reason: 'no_data' })
    end

    ip_address = event.dig('requestContext', 'http', 'sourceIp') ||
                 event.dig('headers', 'x-forwarded-for')&.split(',')&.first&.strip

    begin
      conn = ActiveRecord::Base.connection

      # Upsert: insert if new session, update if exists
      # Only update if status is still 'partial' (don't overwrite submitted leads)
      existing = conn.execute(
        ActiveRecord::Base.sanitize_sql_array([
          "SELECT id, status FROM leads WHERE session_id = ? LIMIT 1",
          session_id,
        ])
      )

      if existing.any?
        # Don't overwrite submitted leads
        if existing.first[1] == 'submitted'
          next api_success({ saved: false, reason: 'already_submitted' })
        end

        conn.execute(
          ActiveRecord::Base.sanitize_sql_array([
            "UPDATE leads SET name = ?, email = ?, company = ?, aws_monthly = ?, availability = ?, notes = ?, utm_source = ?, utm_medium = ?, utm_campaign = ?, page_url = ? WHERE session_id = ? AND status = 'partial'",
            name, email, company, aws_monthly, availability, notes,
            utm_source, utm_medium, utm_campaign, page_url,
            session_id,
          ])
        )
      else
        conn.execute(
          ActiveRecord::Base.sanitize_sql_array([
            "INSERT INTO leads (session_id, status, name, email, company, aws_monthly, availability, notes, ip_address, utm_source, utm_medium, utm_campaign, page_url, created_at) VALUES (?, 'partial', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())",
            session_id, name, email, company, aws_monthly, availability, notes,
            ip_address, utm_source, utm_medium, utm_campaign, page_url,
          ])
        )
      end

      puts "[LEAD:PARTIAL] Auto-saved: #{session_id} — #{name} / #{email}"
    rescue StandardError => e
      puts "[ERROR] Partial save failed: #{e.class}: #{e.message}"
      puts e.backtrace&.first(3)&.join("\n")
    end

    api_success({ saved: true })
  end
end

# -----------------------------------------------------------------------------
# GET /leads — health check
# -----------------------------------------------------------------------------
def leads_get(event, context)
  api_handler(event, context) do
    api_success({
      service: 'cutmyaws-leads',
      env: ENV['env'],
      status: 'ok',
    })
  end
end

# -----------------------------------------------------------------------------
# Helper: insert a new lead row
# -----------------------------------------------------------------------------
def insert_lead(conn, data, ip_address, user_agent, status)
  conn.execute(
    ActiveRecord::Base.sanitize_sql_array([
      "INSERT INTO leads (session_id, status, name, email, company, aws_monthly, availability, notes, turnstile_success, ip_address, user_agent, utm_source, utm_medium, utm_campaign, page_url, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())",
      data[:session_id],
      status,
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
end
