#!/bin/bash
# Add a new client profile to AWS CLI for CutMyAWS auditing.
#
# Usage:
#   ./audit/add-client.sh <client-name> <client-account-id> <external-id>
#
# Example:
#   ./audit/add-client.sh acme 123456789012 cutmyaws-acme-2026
#
# This adds a profile [profile cutmyaws-acme] to ~/.aws/config that assumes
# the CutMyAWS-ReadOnly-Auditor role in the client's account.

set -euo pipefail

CLIENT_NAME="${1:?Usage: $0 <client-name> <account-id> <external-id>}"
ACCOUNT_ID="${2:?Usage: $0 <client-name> <account-id> <external-id>}"
EXTERNAL_ID="${3:?Usage: $0 <client-name> <account-id> <external-id>}"
PROFILE="cutmyaws-${CLIENT_NAME}"
ROLE_ARN="arn:aws:iam::${ACCOUNT_ID}:role/CutMyAWS-ReadOnly-Auditor"

# Check if profile already exists
if grep -q "\[profile ${PROFILE}\]" ~/.aws/config 2>/dev/null; then
  echo "ERROR: Profile [${PROFILE}] already exists in ~/.aws/config"
  exit 1
fi

# Add profile
cat >> ~/.aws/config << EOF

[profile ${PROFILE}]
role_arn = ${ROLE_ARN}
source_profile = cutmyaws
region = us-east-1
external_id = ${EXTERNAL_ID}
EOF

echo "✅ Added profile [${PROFILE}] to ~/.aws/config"
echo ""
echo "Test it:"
echo "  aws sts get-caller-identity --profile ${PROFILE}"
echo ""
echo "Run audit:"
echo "  # Last 48 months of monthly costs"
echo "  aws ce get-cost-and-usage \\"
echo "    --time-period Start=$(date -v-48m +%Y-%m-01),End=$(date +%Y-%m-01) \\"
echo "    --granularity MONTHLY \\"
echo "    --metrics UnblendedCost \\"
echo "    --profile ${PROFILE}"
