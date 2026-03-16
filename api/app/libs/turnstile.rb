# =============================================================================
# CLOUDFLARE TURNSTILE CAPTCHA VALIDATION
# =============================================================================
#
# Validates Cloudflare Turnstile tokens to prevent bot/spam form submissions.
# Turnstile is a privacy-preserving CAPTCHA alternative that runs on
# the frontend (invisible mode) and provides a token verified server-side.
#
# FLOW:
#   1. Frontend loads Turnstile script (invisible mode — no widget shown)
#   2. On form submit, frontend calls turnstile.execute(siteKey) → gets token
#   3. Frontend includes token in POST body as `turnstileToken`
#   4. Backend validates token via Cloudflare's siteverify API
#   5. If valid → proceed. If invalid → 403 bot_detected.
#
# CONFIGURATION:
#   Site Key (frontend, public):  0x4AAAAAACrv6ddaepEh0qEx
#   Secret Key (backend, SSM):    /cutmyaws/{env}/turnstile/secret_key
#
# DOCUMENTATION: https://developers.cloudflare.com/turnstile/
#
# =============================================================================

# -----------------------------------------------------------------------------
# Validate Turnstile Token
# -----------------------------------------------------------------------------
# Verifies a Turnstile token with Cloudflare's verification API.
#
# @param token [String] Turnstile token from frontend widget
# @return [Boolean] true if valid, false if invalid or verification failed
#
# LOCAL DEVELOPMENT:
#   SSL verification is disabled in local dev due to Ruby 3.4+ CRL issues.
#   Use Cloudflare's test keys for local testing:
#   - Site key:   1x00000000000000000000AA (always passes)
#   - Secret key: 1x0000000000000000000000000000000AA (always passes)
#
def validate_turnstile(token)
  puts "[Turnstile] Validating token (length=#{token.to_s.length})"

  # Get secret key from SSM (checks ENV first, falls back to SSM)
  secret_key = awsssm_get_param("/#{ENV['PREFIX'].gsub("-","/")}/turnstile/secret_key")

  # Cloudflare Turnstile verification endpoint
  url = URI("https://challenges.cloudflare.com/turnstile/v0/siteverify")

  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true

  # Fix for Ruby 3.4+ OpenSSL CRL verification issues on macOS in local dev
  if ENV['IS_LOCAL'] && !ENV['IS_LOCAL'].empty?
    https.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  request = Net::HTTP::Post.new(url)
  request['Content-Type'] = 'application/x-www-form-urlencoded'

  body = {
    secret: secret_key,
    response: token,
  }

  request.body = body.to_query

  puts "[Turnstile] Sending verification request to Cloudflare..."
  response = https.request(request)
  result = JSON.parse(response.read_body)

  puts "[Turnstile] Response: success=#{result['success']}, error-codes=#{result['error-codes']&.join(', ')}"

  if !result["success"]
    puts "[Turnstile] VALIDATION FAILED — error-codes: #{result['error-codes']&.join(', ')}"
  end

  return result["success"]
end
