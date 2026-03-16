#!/bin/zsh
# =============================================================================
# IRB Console Launcher
# =============================================================================
#
# Opens an IRB session connected to the CutMyAWS TiDB database.
# Loads all libs (AWS, SSM, DB, etc.) so you can run queries directly.
#
# USAGE:
#   ./scripts/irb.sh prod
#   # or via Rake:
#   bundle exec rake irb_prod
#
# INSIDE THE CONSOLE:
#   # Run raw SQL:
#   ActiveRecord::Base.connection.execute("SELECT * FROM prequal_submissions ORDER BY created_at DESC LIMIT 5")
#
#   # Reconnect after idle timeout:
#   reconnect!
#
#   # Check connection:
#   ActiveRecord::Base.connection.execute("SELECT 1")
#
# =============================================================================

# Get the directory where this script lives, then go to api/
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/.."

# Source zshrc for AWS profile setup if available
[[ -f ~/.zshrc ]] && source ~/.zshrc

# Bundle setup
bundle config set clean 'true'
bundle config set path 'vendor/bundle'
bundle config set silence_root_warning true
bundle config set jobs 3

RUN=0

if [ ! -d "vendor" ]; then
  RUN=1
elif [ "$(cat vendor/.for 2>/dev/null)" != "mac" ]; then
  RUN=1
fi

if [ ${RUN} = 1 ]; then
  rm -rf vendor
  bundle config list
  bundle install
  echo "mac" > vendor/.for
else
  echo "ALREADY BUNDLED FOR MAC!"
fi

# Fix for OpenSSL 3.6.0+ CRL checking issue
OPENSSL_CONFIG="$SCRIPT_DIR/../_dev/openssl-no-crl.cnf"
if [ -f "$OPENSSL_CONFIG" ]; then
  export OPENSSL_CONF="$OPENSSL_CONFIG"
fi

PREFIX="cutmyaws-${1}" IS_LOCAL=1 TZ=UTC bundle exec irb -r ./init
