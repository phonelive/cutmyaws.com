# =============================================================================
# ROUTER TEST — Lambda Health Check / Warmup
# =============================================================================
#
# Invoked by:
#   - Direct Lambda invocation with empty event {} (health check)
#   - Scheduled events with run_method: "router_test" (warmup)
#
# Verifies that:
#   1. Lambda boots and init.rb loads successfully
#   2. Database connection is alive
#   3. Returns a simple success indicator
#
# This is the simplest possible function — if this fails, something is
# fundamentally broken (gems not loading, SSM unavailable, etc.)
#
# =============================================================================

def router_test(event)
  puts "[ROUTER_TEST] Health check at #{Time.now.utc}"

  # Quick DB connectivity check
  db_ok = false
  begin
    result = ActiveRecord::Base.connection.execute("SELECT 1 AS ok")
    db_ok = true
    puts "[ROUTER_TEST] Database connection: OK"
  rescue StandardError => e
    puts "[ROUTER_TEST] Database connection: FAILED — #{e.class}: #{e.message}"
  end

  {
    statusCode: 200,
    headers: { 'Content-Type' => 'application/json' },
    body: {
      service: 'cutmyaws-prequal',
      env: ENV['env'],
      db: db_ok ? 'ok' : 'error',
      timestamp: Time.now.utc.iso8601,
    }.to_json
  }
end
