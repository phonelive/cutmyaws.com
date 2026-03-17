# =============================================================================
# API RESPONSE HELPERS
# =============================================================================
#
# Standardized API response helpers for consistent JSON responses,
# proper HTTP status codes, CORS headers, and error handling.
#
# USAGE:
#   api_success({ lead: lead_data })
#   api_success({ lead: lead_data }, 201)
#   api_error_bad_request('Email is required')
#   api_error_internal('Something broke', exception)
#
#   # Wrap entire endpoint for automatic error catching:
#   api_handler(event, context) do
#     # endpoint logic
#     api_success({ data: result })
#   end
#
# =============================================================================

# -----------------------------------------------------------------------------
# Standard Response Headers
# -----------------------------------------------------------------------------
# CORS headers are added dynamically based on the request's Origin header.
# Only origins in ALLOWED_ORIGINS get Access-Control-Allow-Origin.
#
unless defined?(API_HEADERS_BASE)
  API_HEADERS_BASE = {
    'Content-Type' => 'application/json',
  }.freeze
end

# Allowed CORS origins. Requests from unlisted origins get no CORS header,
# which means the browser will block the response.
unless defined?(ALLOWED_ORIGINS)
  ALLOWED_ORIGINS = [
    # Production
    'https://cutmyaws.com',
    'https://www.cutmyaws.com',
    # Dev environment
    'https://dev.cutmyaws.com',
    # Local development
    'http://localhost:3000',
    'http://localhost:3400',
  ].freeze
end

# Build API response headers with CORS origin matching.
# Reflects the request Origin back only if it's in the allowed list.
def cors_headers
  headers = API_HEADERS_BASE.dup
  origin = Thread.current[:cors_origin]
  if origin
    headers['Access-Control-Allow-Origin'] = origin
    headers['Access-Control-Allow-Credentials'] = 'true'
  end
  headers
end

# Backward-compatible constant for contexts without a request
unless defined?(API_HEADERS)
  API_HEADERS = API_HEADERS_BASE.dup.freeze
end

# -----------------------------------------------------------------------------
# Success Response
# -----------------------------------------------------------------------------
# @param data [Hash] Response data (converted to JSON)
# @param status_code [Integer] HTTP status code (default: 200)
# @return [Hash] Lambda-compatible response hash
#
def api_success(data, status_code = 200)
  {
    statusCode: status_code,
    headers: cors_headers,
    body: data.to_json
  }
end

# -----------------------------------------------------------------------------
# Error Response Builder
# -----------------------------------------------------------------------------
# @param status_code [Integer] HTTP status code
# @param message [String] Human-readable error message
# @param code [String, nil] Machine-readable error code
# @param details [Hash, nil] Additional error details
# @return [Hash] Lambda-compatible response hash
#
def api_error(status_code, message, code = nil, details = nil)
  body = { error: message }
  body[:code] = code if code
  body[:details] = details if details

  {
    statusCode: status_code,
    headers: cors_headers,
    body: body.to_json
  }
end

# 400 Bad Request — malformed or missing required parameters
def api_error_bad_request(message, details = nil)
  api_error(400, message, 'BAD_REQUEST', details)
end

# 403 Forbidden — Turnstile/bot detection failures
def api_error_forbidden(message = 'Forbidden')
  api_error(403, message, 'FORBIDDEN')
end

# 404 Not Found
def api_error_not_found(message = 'Not found')
  api_error(404, message, 'NOT_FOUND')
end

# 422 Unprocessable Entity — validation errors
def api_error_validation(message, details = nil)
  api_error(422, message, 'VALIDATION_ERROR', details)
end

# 500 Internal Server Error — unexpected failures
def api_error_internal(message = 'An unexpected error occurred', exception = nil)
  if exception
    puts "[ERROR] #{exception.class}: #{exception.message}"
    puts exception.backtrace&.first(10)&.join("\n")
  end
  api_error(500, message, 'INTERNAL_ERROR')
end

# -----------------------------------------------------------------------------
# API Handler Wrapper
# -----------------------------------------------------------------------------
# Wraps endpoint logic with standardized error handling and CORS setup.
# Catches all exceptions and returns appropriate error responses.
#
# @param event [Hash] Lambda event object
# @param context [Object] Lambda context object
# @yield Block containing the endpoint logic
# @return [Hash] Lambda-compatible response hash
#
# @example
#   def prequal_post(event, context)
#     api_handler(event, context) do
#       # endpoint logic
#       api_success({ success: true })
#     end
#   end
#
def api_handler(event, context)
  request_start = Process.clock_gettime(Process::CLOCK_MONOTONIC)

  # Set CORS origin for response headers
  origin = event&.dig('headers', 'origin') || event&.dig('headers', 'Origin')
  Thread.current[:cors_origin] = (origin && ALLOWED_ORIGINS.include?(origin)) ? origin : nil

  # Log incoming request
  method = event['httpMethod'] || event.dig('requestContext', 'http', 'method')
  path = event['path'] || event['rawPath']
  puts "[REQUEST] #{method} #{path}"

  begin
    result = yield

    elapsed_ms = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - request_start) * 1000).round
    puts "[RESPONSE] #{method} #{path} → #{result[:statusCode]} (#{elapsed_ms}ms)"

    result
  rescue JSON::ParserError => e
    api_error_bad_request('Invalid JSON in request body')
  rescue ArgumentError => e
    api_error_bad_request(e.message)
  rescue StandardError => e
    api_error_internal('An unexpected error occurred. Please try again.', e)
  end
end
