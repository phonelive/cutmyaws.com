# =============================================================================
# SESSION TOKEN — HMAC-signed tokens for authenticated form sessions
# =============================================================================
#
# After Turnstile verification on first auto-save, the server issues a
# session token. Subsequent saves and final submit use this token instead
# of re-verifying Turnstile.
#
# TOKEN FORMAT: base64(session_id:timestamp):hmac_hex
# EXPIRY: 1 hour
# SECRET: Turnstile secret key (reused — already in SSM)
#
# =============================================================================

require 'openssl'
require 'base64'

SESSION_TOKEN_TTL = 3600 # 1 hour in seconds

# Generate a session token for a verified form session
#
# @param session_id [String] UUID from the frontend
# @return [String] signed token
#
def generate_session_token(session_id)
  timestamp = Time.now.utc.to_i
  payload = Base64.urlsafe_encode64("#{session_id}:#{timestamp}")
  signature = hmac_sign(payload)
  "#{payload}:#{signature}"
end

# Validate a session token
#
# @param token [String] token from the frontend
# @param expected_session_id [String] session_id from the request (must match)
# @return [Boolean] true if valid and not expired
#
def validate_session_token(token, expected_session_id)
  return false if token.nil? || token.empty?

  parts = token.split(':')
  return false if parts.length < 3 # payload : signature (payload has base64 which may contain colons)

  # Last part is signature, everything before is payload
  signature = parts.last
  payload = parts[0..-2].join(':')

  # Verify HMAC
  expected_sig = hmac_sign(payload)
  return false unless secure_compare(signature, expected_sig)

  # Decode and check expiry + session_id
  begin
    decoded = Base64.urlsafe_decode64(payload)
    session_id, timestamp_str = decoded.split(':')
    timestamp = timestamp_str.to_i

    return false unless session_id == expected_session_id
    return false if Time.now.utc.to_i - timestamp > SESSION_TOKEN_TTL

    true
  rescue StandardError
    false
  end
end

private

def hmac_sign(payload)
  secret = ENV['TURNSTILE_SECRET_KEY'] || awsssm_get_param("/#{ENV['PREFIX'].gsub('-','/')}/turnstile/secret_key")
  OpenSSL::HMAC.hexdigest('SHA256', secret, payload)
end

# Constant-time comparison to prevent timing attacks
def secure_compare(a, b)
  return false if a.nil? || b.nil? || a.bytesize != b.bytesize
  a.bytes.zip(b.bytes).inject(0) { |acc, (x, y)| acc | (x ^ y) } == 0
end
