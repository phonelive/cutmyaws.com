# =============================================================================
# AWS SSM PARAMETER STORE HELPER
# =============================================================================
#
# Provides secure access to AWS Systems Manager Parameter Store for retrieving
# secrets and configuration values. This is the primary method for accessing
# sensitive data like database credentials and API keys.
#
# PARAMETER NAMING CONVENTION:
#   /cutmyaws/{env}/{category}/{key}
#
#   Examples:
#     /cutmyaws/prod/db/host              → TiDB Cloud hostname
#     /cutmyaws/prod/db/pass              → TiDB Cloud password
#     /cutmyaws/prod/turnstile/secret_key → Cloudflare Turnstile secret
#
# CACHING STRATEGY:
#   Parameters are cached in environment variables after first retrieval.
#   This reduces AWS API calls and improves Lambda performance since
#   environment persists across warm invocations.
#
#   SSM Name: /cutmyaws/prod/db/host
#   ENV Key:  DB_HOST (normalized: uppercase, slashes→underscores, prefix stripped)
#
# FALLBACK ORDER:
#   1. Check ENV variable (cached value or set by serverless.yml)
#   2. Fetch from AWS SSM Parameter Store
#   3. Cache in ENV for future calls
#   4. Return false on error
#
# =============================================================================

# -----------------------------------------------------------------------------
# Create SSM Client
# -----------------------------------------------------------------------------
# Creates an AWS SSM client with appropriate SSL configuration.
# Local development may require SSL verification disabled due to
# Ruby 3.4+ CRL verification issues on macOS.
#
# @return [Aws::SSM::Client] Configured SSM client
#
def awsssm_client
  client_options = { region: 'us-east-1' }
  if ENV['IS_LOCAL'] && !ENV['IS_LOCAL'].empty?
    client_options[:ssl_verify_peer] = false
  end
  Aws::SSM::Client.new(client_options)
end

# -----------------------------------------------------------------------------
# Get Parameter from SSM
# -----------------------------------------------------------------------------
# Retrieves a parameter value from AWS SSM Parameter Store with caching.
# Values are decrypted automatically (SecureString parameters).
#
# @param name [String] Full SSM parameter path (e.g., "/cutmyaws/prod/db/host")
# @return [String, false] Parameter value or false on error
#
# CACHING:
#   Parameter values are cached in ENV variables using a normalized key:
#   - "/cutmyaws/prod/db/host" → ENV["DB_HOST"]
#   - Removes environment prefixes (CUTMYAWS, PROD) from key name
#
def awsssm_get_param(name)
  value = nil

  begin
    env_name = name.upcase.gsub("/","_").gsub("-","_")
    bad_words = ["CUTMYAWS","DEV","PROD"]
    bad_words.each do |bw|
      env_name = env_name.gsub("_#{bw}","")
    end
    if env_name[0] == "_"
      env_name = env_name[1..]
    end
    unless ENV[env_name].nil?
      value = ENV[env_name]
    end
  rescue StandardError => e
    puts "[ERROR] AWSSSM: ENV lookup failed for #{name}: #{e.class}: #{e.message}"
    puts e.backtrace&.first(3)&.join("\n")
    return false
  end

  if value.nil?
    begin
      ssm_client = awsssm_client
      value = ssm_client.get_parameter({ name: name, with_decryption: true }).parameter.value
      ENV[env_name] = value
    rescue StandardError => e
      puts "[ERROR] AWSSSM: SSM fetch failed for #{name}: #{e.class}: #{e.message}"
      puts e.backtrace&.first(3)&.join("\n")
      return false
    end
  end

  return value
end
