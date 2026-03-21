# =============================================================================
# ROUTER.RB — AWS Lambda Entry Point
# =============================================================================
#
# Primary entry point for all AWS Lambda invocations. Implements a dynamic
# routing system that maps HTTP requests to controller methods based on
# the URL path and HTTP method.
#
# ROUTING PATTERN:
#   HTTP requests are converted to method names using the pattern:
#   {path}_{method}()
#
#   Examples:
#   - POST /prequal     → prequal_post(event, context)
#   - GET  /health      → health_get(event, context)
#
# INVOCATION TYPES:
#   1. HTTP API Gateway requests (httpMethod + path)
#   2. Scheduled events (run_method for cron jobs)
#   3. Direct invocations (empty event for testing)
#
# ERROR HANDLING:
#   All exceptions are caught, logged to CloudWatch, and the router
#   returns false on errors to indicate Lambda failure.
#
# AWS ACCOUNT: 731039145080 (Cut My AWS)
#
# =============================================================================

require './init.rb'

# -----------------------------------------------------------------------------
# Main Lambda Handler Function
# -----------------------------------------------------------------------------
#
# @param event [Hash] The Lambda event object containing:
#   - For HTTP: httpMethod, path, body, queryStringParameters, headers
#   - For scheduled: run_method (name of function to execute)
#   - For testing: empty hash {}
#
# @param context [Object] AWS Lambda context object with execution metadata
#
# @return [Hash, Boolean] Returns a response hash with statusCode and body,
#   or false on error
#
def router(event:, context:)
  # ---------------------------------------------------------------------------
  # Handle empty event (used for local testing/health checks)
  # ---------------------------------------------------------------------------
  if event == {}
    return send(:router_test, event)
  end

  # ---------------------------------------------------------------------------
  # Set thread-local request ID for log correlation
  # ---------------------------------------------------------------------------
  Thread.current[:request_id] = event.dig('requestContext', 'requestId') || event.dig('run_method')

  # ---------------------------------------------------------------------------
  # Normalize payload 2.0 → 1.0 field names for backward compatibility
  # ---------------------------------------------------------------------------
  # API Gateway HTTP API payload 2.0 uses different keys than 1.0.
  event['httpMethod'] ||= event.dig('requestContext', 'http', 'method')
  event['path'] ||= event['rawPath']

  # ---------------------------------------------------------------------------
  # Strip API Gateway stage prefix from path
  # ---------------------------------------------------------------------------
  # HTTP API includes the stage name in the path (e.g., /prod/prequal).
  # Strip it so routing works correctly (prequal_get, not prod_prequal_get).
  #
  stage = event.dig('requestContext', 'stage')
  if stage && event['path']&.start_with?("/#{stage}/")
    event['path'] = event['path'].sub("/#{stage}", "")
  elsif stage && event['path'] == "/#{stage}"
    event['path'] = "/"
  end

  begin
    # -------------------------------------------------------------------------
    # Route 1: Scheduled Events / Direct Invocations
    # -------------------------------------------------------------------------
    if event['run_method']
      allowed_run_methods = %w[
        router_test
        check_abandoned_leads
      ].freeze

      method_name = event['run_method'].to_s
      unless allowed_run_methods.include?(method_name)
        puts "[SECURITY] Blocked run_method invocation: #{method_name}"
        return false
      end

      return send(method_name, event)

    # -------------------------------------------------------------------------
    # Route 2: CORS Preflight Requests (OPTIONS)
    # -------------------------------------------------------------------------
    # Browsers send OPTIONS requests before cross-origin requests.
    # Return appropriate CORS headers to allow the actual request.
    #
    elsif event['httpMethod'].downcase == "options"
      origin = event.dig('headers', 'origin') || event.dig('headers', 'Origin')
      cors_origin = (origin && ALLOWED_ORIGINS.include?(origin)) ? origin : nil
      preflight_headers = { 'Content-Type' => 'text/plain' }
      if cors_origin
        preflight_headers['Access-Control-Allow-Origin'] = cors_origin
        preflight_headers['Access-Control-Allow-Methods'] = 'GET,POST,OPTIONS'
        preflight_headers['Access-Control-Allow-Headers'] = 'Content-Type'
        preflight_headers['Access-Control-Max-Age'] = '86400'
      end
      return { statusCode: 200, headers: preflight_headers }

    # -------------------------------------------------------------------------
    # Route 3: HTTP API Requests (GET, POST)
    # -------------------------------------------------------------------------
    # Convert URL path and method to a function name and invoke it.
    #
    else
      # Build function name from path and method:
      # - Remove leading slash [1..99]
      # - Replace '/', '.', and '-' with '_' for valid Ruby method name
      # - Convert to lowercase
      # Example: POST /prequal → "prequal_post"
      function_name = "#{event['path'][1..99].gsub("/","_").gsub(".","_").gsub("-","_").downcase}_#{event['httpMethod'].downcase}"

      unless respond_to?(function_name.to_sym, true)
        puts "[404] Route not found: #{event['httpMethod']} #{event['path']} → #{function_name}"
        return {
          statusCode: 404,
          headers: { 'Content-Type' => 'application/json' },
          body: { error: 'Not found', code: 'NOT_FOUND' }.to_json
        }
      else
        # Handle Base64-encoded bodies (API Gateway may encode binary data)
        if event['isBase64Encoded']
          event['body'] = Base64.decode64(event['body'])
        end

        output = send(function_name, event, context)
        return output
      end
    end

  rescue NoMethodError => e
    puts "[404] Unrecognized route: #{e.message} | Path: #{event.is_a?(Hash) ? event['path'] : 'unknown'}"
    return {
      statusCode: 404,
      headers: { 'Content-Type' => 'application/json' },
      body: { error: 'Not found', code: 'NOT_FOUND' }.to_json
    }

  rescue StandardError => e
    puts "[ERROR] Router: #{e.class}: #{e.message}"
    puts e.backtrace&.first(5)&.join("\n")
    return false
  end
end
