# =============================================================================
# DATABASE CONNECTION CONFIGURATION
# =============================================================================
#
# Establishes the primary MySQL database connection using ActiveRecord with
# the Trilogy adapter. Connects to TiDB Cloud (MySQL-compatible).
#
# DATABASE: TiDB Cloud (MySQL-compatible, Serverless tier)
#
# CONNECTION DETAILS (from SSM Parameter Store):
#   /cutmyaws/{env}/db/host     — gateway01.us-east-1.prod.aws.tidbcloud.com
#   /cutmyaws/{env}/db/name     — test
#   /cutmyaws/{env}/db/user     — 4EA5RRLJJAkgUTA.root
#   /cutmyaws/{env}/db/pass     — (SecureString in SSM)
#   /cutmyaws/{env}/db/port     — 4000
#
# KEY FEATURES:
#   - Trilogy adapter (faster MySQL adapter for Ruby)
#   - SSL with VERIFY_IDENTITY for TiDB Cloud
#   - utf8mb4 encoding for full Unicode support
#   - Auto-reconnect on SSL errors (connection drops after idle)
#
# CONNECTION POOL SETTINGS:
#   pool               — 5 for Lambda, 10 for local dev
#   checkout_timeout    — 5 seconds to get connection from pool
#   connect_timeout     — 5 seconds to establish initial connection
#   read_timeout        — 60 seconds for queries
#   idle_timeout        — 30 seconds before connection considered idle
#   reaping_frequency   — 60 seconds between idle connection checks
#
# =============================================================================

# Cache the database host in ENV for faster subsequent access
ENV['db_host'] = awsssm_get_param("/#{ENV['PREFIX'].gsub("-","/")}/db/host")

# -----------------------------------------------------------------------------
# Timezone Configuration
# -----------------------------------------------------------------------------
# Store all times in UTC in the database.
#
ActiveRecord.default_timezone = :utc
Time.zone = 'UTC'

# Determine pool size based on environment:
# - Lambda: 5 connections
# - Local dev (WEBrick): 10 connections for concurrent requests
is_lambda = ENV['AWS_LAMBDA_FUNCTION_NAME'].to_s.length > 0
db_pool_size = is_lambda ? 5 : 10

begin
  ActiveRecord::Base.establish_connection(
    adapter:            'trilogy',
    database:           awsssm_get_param("/#{ENV['PREFIX'].gsub("-","/")}/db/name"),
    host:               ENV['db_host'],
    username:           awsssm_get_param("/#{ENV['PREFIX'].gsub("-","/")}/db/user"),
    password:           awsssm_get_param("/#{ENV['PREFIX'].gsub("-","/")}/db/pass"),
    port:               awsssm_get_param("/#{ENV['PREFIX'].gsub("-","/")}/db/port"),
    ssl_mode:           'VERIFY_IDENTITY',
    encoding:           'utf8mb4',
    collation:          'utf8mb4_general_ci',
    pool:               db_pool_size,
    checkout_timeout:   5,
    connect_timeout:    5,
    read_timeout:       60,
    idle_timeout:       30,
    reaping_frequency:  60,
    reconnect:          true,
    retry_lost_connection: true,
  )
  ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)
rescue StandardError => e
  puts "[ERROR] DB connection failed: #{e.class}: #{e.message}"
  puts e.backtrace&.first(5)&.join("\n")
end

# -----------------------------------------------------------------------------
# Manual Reconnect Helper
# -----------------------------------------------------------------------------
# Helper method to manually reconnect to database. Useful in IRB/console
# sessions after idle periods when the SSL connection has timed out.
#
# @example
#   reconnect!  # Re-establishes database connection
#
def reconnect!
  ActiveRecord::Base.connection.reconnect!
  puts "Reconnected to database"
end

# -----------------------------------------------------------------------------
# Auto-Reconnect Module
# -----------------------------------------------------------------------------
# Monkey-patches the Trilogy adapter to automatically reconnect on connection
# errors. TiDB Cloud connections drop after idle periods, causing SSL errors
# or timeouts on the next query.
#
# HANDLED ERRORS:
#   - Trilogy::SSLError — SSL/TLS connection issues (unlimited retries)
#   - "SSL Error" in message — Generic SSL failures (unlimited retries)
#   - "unexpected eof" — Connection dropped by server (unlimited retries)
#   - ActiveRecord::AdapterTimeout — Read timeout on stale connection (1 retry)
#
# This is especially important for Lambda warm starts where the connection
# may have been idle since the last invocation.
#
module AutoReconnect
  def execute(sql, name = nil, **kwargs)
    @_timeout_retries_exec ||= 0
    super
  rescue ActiveRecord::AdapterTimeout => e
    if @_timeout_retries_exec < 1
      @_timeout_retries_exec += 1
      puts "[AutoReconnect] Query timeout during execute, reconnecting..."
      reconnect!
      retry
    else
      raise
    end
  rescue ActiveRecord::StatementInvalid => e
    if ssl_connection_error?(e)
      puts "[AutoReconnect] Connection lost during execute, reconnecting..."
      reconnect!
      retry
    else
      raise
    end
  ensure
    @_timeout_retries_exec = 0
  end

  def internal_exec_query(sql, name = nil, binds = [], **kwargs)
    @_timeout_retries_query ||= 0
    super
  rescue ActiveRecord::AdapterTimeout => e
    if @_timeout_retries_query < 1
      @_timeout_retries_query += 1
      puts "[AutoReconnect] Query timeout during query, reconnecting..."
      reconnect!
      retry
    else
      raise
    end
  rescue ActiveRecord::StatementInvalid => e
    if ssl_connection_error?(e)
      puts "[AutoReconnect] Connection lost during query, reconnecting..."
      reconnect!
      retry
    else
      raise
    end
  ensure
    @_timeout_retries_query = 0
  end

  private

  def ssl_connection_error?(error)
    error.cause.is_a?(Trilogy::SSLError) ||
      error.message.include?('SSL Error') ||
      error.message.include?('unexpected eof') ||
      error.message.include?('Lost connection')
  end
end

# Apply the AutoReconnect module to Trilogy adapter if loaded
if defined?(ActiveRecord::ConnectionAdapters::TrilogyAdapter)
  ActiveRecord::ConnectionAdapters::TrilogyAdapter.prepend(AutoReconnect)
end
