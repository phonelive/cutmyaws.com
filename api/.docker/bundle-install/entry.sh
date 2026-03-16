#!/bin/bash
# =============================================================================
# ENTRY.SH — Lambda Bundle Install Script
# =============================================================================
#
# Runs inside the Docker container to install gems with native extensions
# compiled against Amazon Linux ARM64 (matching Lambda's runtime).
#
# This ensures gems like `trilogy` (which has C extensions for MySQL/TiDB
# SSL connections) are linked against the correct glibc and OpenSSL.
#
# =============================================================================

local_ruby_version=$(ruby -v | awk '{print $2}')
echo "Docker Ruby Version: ${local_ruby_version}"
echo "Docker Arch: $(uname -m)"

echo "gem: --no-rdoc --no-ri" > ~/.gemrc

# Install the same bundler version as Gemfile.lock specifies
gem install bundler -v $(tail -n1 Gemfile.lock)

echo "Bundler Version: $(bundle -v)"

bundle config set clean 'true'
bundle config set path 'vendor/bundle'
bundle config set silence_root_warning true
bundle config set jobs 3

git config --global --add safe.directory '*'

bundle config list

RUN=0

if [ ! -d "vendor" ]; then
  RUN=1
elif [ "$(cat vendor/.for 2>/dev/null)" != "lambda" ]; then
  RUN=1
fi

if [ ${RUN} = 1 ]; then
  rm -rf vendor
  bundle install || { echo "ERROR: bundle install failed!"; exit 1; }
  echo "lambda" > vendor/.for
else
  echo "ALREADY BUNDLED FOR LAMBDA!"
fi

# Clean up macOS artifacts
find . -name \*.DS_Store -type f -delete
