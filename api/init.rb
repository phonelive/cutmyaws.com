# =============================================================================
# INIT.RB — Application Initialization and Bootstrap
# =============================================================================
#
# Loaded by router.rb on every Lambda cold start. Handles:
#
# 1. BUNDLER SETUP: Loads gem dependencies based on environment
# 2. TEMP DIRECTORY: Creates Lambda-compatible temp directory for Ruby 3.3+
# 3. ENVIRONMENT CONFIG: Sets URLs and configuration based on stage
# 4. AUTO-LOADING: Dynamically requires all libs and controllers
#
# LOAD ORDER (important for dependencies):
#   1. Bundler gems (external dependencies)
#   2. Libs (shared utilities: AWS, DB, Turnstile, SES, validation)
#   3. Controllers (API endpoints — depend on libs)
#   4. Functions (background jobs — depend on all above)
#
# ENVIRONMENTS:
#   - prod: cutmyaws-prod prefix → api.cutmyaws.com
#
# AWS ACCOUNT: 731039145080 (Cut My AWS)
#
# =============================================================================

# =============================================================================
# SECTION 1: Bundler Configuration
# =============================================================================
#
# Set the Gemfile path for Bundler. On Lambda, the code runs from /var/task
# so we need to explicitly set the path to find the Gemfile.
#
ENV['BUNDLE_GEMFILE'] ||= "#{Dir.pwd}/Gemfile"

require "bundler"

# Load gems based on environment:
# - Production (Lambda): Load only :default group
# - Local development:   Load :default and :dev groups (includes debug tools)
#
# The IS_LOCAL env var is set when running locally via `bundle exec rake http_dev`
#
if ENV['IS_LOCAL']
  Bundler.require(:default, :dev)
else
  Bundler.require(:default)
end

require 'securerandom'

# =============================================================================
# SECTION 2: Temporary Directory Setup
# =============================================================================
#
# Ruby 3.3+ requires a writable /tmp directory for certain operations.
# AWS Lambda's /tmp is the only writable location (512MB-10GB based on config).
#
FileUtils.mkdir_p("/tmp/tmp")
File.chmod(1777, "/tmp/tmp")
ENV['TMPDIR'] = "/tmp/tmp"

# =============================================================================
# SECTION 3: Environment-Specific Configuration
# =============================================================================
#
# Set environment variables based on the Lambda PREFIX (set in serverless.yml).
# The PREFIX format is: {service}-{stage} → e.g., "cutmyaws-prod"
#
if ENV['PREFIX'] == "cutmyaws-dev"
  ENV['env'] = "dev"
  ENV['API_BASE'] = "https://api.dev.cutmyaws.com"
  ENV['SITE_BASE'] = "https://cutmyaws.com"

elsif ENV['PREFIX'] == "cutmyaws-prod"
  ENV['env'] = "prod"
  ENV['API_BASE'] = "https://api.cutmyaws.com"
  ENV['SITE_BASE'] = "https://cutmyaws.com"
end

# =============================================================================
# SECTION 4: Dynamic Auto-Loading
# =============================================================================
#
# Rather than manually requiring each file, we use Dir.glob to automatically
# load all Ruby files from specific directories. New files are automatically
# loaded without updating init.rb.
#

# -----------------------------------------------------------------------------
# 4.1: Load Library Files (app/libs/*.rb)
# -----------------------------------------------------------------------------
#
# Libraries are shared utility modules and classes:
# - aws.rb, aws_ssm.rb: AWS SDK initialization and SSM helpers
# - db.rb: TiDB/MySQL database connection management
# - turnstile.rb: Cloudflare Turnstile CAPTCHA validation
# - ses.rb: SES email sending helper
# - validate.rb: Server-side form validation
# - api_response.rb: Standardized API response helpers
#
Dir.glob('./app/libs/*.rb').each do |file|
  begin
    require file
  rescue StandardError => e
    puts "[ERROR] INIT_LIBS: Failed to load #{file}: #{e.class}: #{e.message}"
    puts e.backtrace&.first(3)&.join("\n")
  end
end

# -----------------------------------------------------------------------------
# 4.2: Load Controller Files (app/controllers/*.rb)
# -----------------------------------------------------------------------------
#
# Controllers define API endpoints. Each file defines methods following
# the naming convention: {path}_{method}(event, context)
#
# Example: app/controllers/prequal.rb defines:
#   - prequal_post(event, context)    → POST /prequal
#
Dir.glob('./app/controllers/*.rb').each do |file|
  begin
    require file
  rescue => e
    puts "[ERROR] INIT_CONTROLLERS: Failed to load #{file}: #{e.class}: #{e.message}"
    puts e.backtrace&.first(3)&.join("\n")
  end
end

# -----------------------------------------------------------------------------
# 4.3: Load Function Files (fn/*.rb)
# -----------------------------------------------------------------------------
#
# Functions are background jobs and utilities invoked via run_method:
# - router_test.rb: Lambda health check endpoint
#
Dir.glob('./fn/*.rb').each do |file|
  begin
    require file
  rescue StandardError => e
    puts "[ERROR] INIT_FN: Failed to load #{file}: #{e.class}: #{e.message}"
    puts e.backtrace&.first(3)&.join("\n")
  end
end
