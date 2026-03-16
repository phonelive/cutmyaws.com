# =============================================================================
# AWS SDK GLOBAL CONFIGURATION
# =============================================================================
#
# Initializes the AWS SDK Ruby gem with global configuration settings.
# All AWS services (SSM, SES) use these defaults unless overridden.
#
# AWS ACCOUNT: 731039145080 (Cut My AWS)
# REGION: us-east-1 (primary region for all services)
#
# =============================================================================

begin
  Aws.config.update(
    logger: ActiveSupport::Logger.new(STDOUT),
    log_level: 'debug',
    region: 'us-east-1',
  )
rescue StandardError => e
  puts "[ERROR] AWS config: #{e.class}: #{e.message}"
end
