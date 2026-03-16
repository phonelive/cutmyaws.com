# =============================================================================
# SERVER-SIDE FORM VALIDATION
# =============================================================================
#
# Validates pre-qualification form submissions. Server-side validation is
# the last line of defense — client-side validation in PreQualForm.vue
# catches most issues, but bots/curl can bypass the frontend.
#
# VALIDATION RULES:
#   - name:        2-100 chars, no URLs
#   - email:       Valid format, not disposable
#   - aws_monthly: Must be one of the allowed dropdown values
#   - company:     5-500 chars, at least 2 real words
#
# =============================================================================

# Valid AWS monthly spend options (must match frontend dropdown)
VALID_AWS_SPEND_OPTIONS = [
  "$5K - $10K",
  "$10K - $25K",
  "$25K - $50K",
  "$50K - $100K",
  "$100K - $250K",
  "$250K+",
].freeze

# Common disposable email domains (spam prevention)
DISPOSABLE_EMAIL_DOMAINS = %w[
  mailinator.com guerrillamail.com tempmail.com throwaway.email
  yopmail.com 10minutemail.com trashmail.com fakeinbox.com
  sharklasers.com guerrillamailblock.com grr.la
].freeze

# -----------------------------------------------------------------------------
# Validate Pre-Qualification Form Data
# -----------------------------------------------------------------------------
# Validates all form fields and returns an array of error messages.
# Returns empty array if all fields are valid.
#
# @param data [Hash] Form data with keys: name, email, aws_monthly, company
# @return [Array<String>] Array of error messages (empty if valid)
#
# @example
#   errors = validate_prequal(name: "Jo", email: "bad", aws_monthly: "free", company: "x")
#   # => ["Name must be at least 2 characters", "Invalid email format", ...]
#
def validate_prequal(data)
  errors = []

  # ---------------------------------------------------------------------------
  # Name: 2-100 chars, no URLs
  # ---------------------------------------------------------------------------
  name = data[:name].to_s.strip
  if name.length < 2
    errors << "Name must be at least 2 characters"
  elsif name.length > 100
    errors << "Name must be 100 characters or fewer"
  elsif name.match?(/https?:\/\/|www\./i)
    errors << "Name cannot contain URLs"
  end

  # ---------------------------------------------------------------------------
  # Email: valid format, not disposable
  # ---------------------------------------------------------------------------
  email = data[:email].to_s.strip.downcase
  email_regex = /\A[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}\z/
  if email.empty?
    errors << "Email is required"
  elsif !email.match?(email_regex)
    errors << "Invalid email format"
  else
    domain = email.split('@').last
    if DISPOSABLE_EMAIL_DOMAINS.include?(domain)
      errors << "Please use your work email address"
    end
  end

  # ---------------------------------------------------------------------------
  # AWS Monthly Spend: must be valid dropdown option
  # ---------------------------------------------------------------------------
  aws_monthly = data[:aws_monthly].to_s.strip
  unless VALID_AWS_SPEND_OPTIONS.include?(aws_monthly)
    errors << "Please select your monthly AWS spend"
  end

  # ---------------------------------------------------------------------------
  # Company: 5-500 chars, at least 2 real words
  # ---------------------------------------------------------------------------
  company = data[:company].to_s.strip
  if company.length < 5
    errors << "Company info must be at least 5 characters"
  elsif company.length > 500
    errors << "Company info must be 500 characters or fewer"
  else
    # Check for at least 2 real words (not just "asdf asdf")
    words = company.split(/\s+/).select { |w| w.length >= 2 }
    if words.length < 2
      errors << "Please provide your company name and what you do"
    end
  end

  errors
end
