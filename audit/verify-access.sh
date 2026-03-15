#!/bin/bash
# Verify CutMyAWS audit access for a client account.
#
# Checks every permission from the onboarding page (/onboarding/give-david-access):
#   Step 1: IAM billing access enabled
#   Step 2: Cost Explorer enabled
#   Step 3: Audit role created with ReadOnlyAccess + billing inline policy
#   Step 4: (implicit) We can assume the role at all
#
# Usage:
#   ./audit/verify-access.sh <client-name>
#
# Example:
#   ./audit/verify-access.sh acme
#
# Requires: profile "cutmyaws-<client-name>" in ~/.aws/config
#           (created by ./audit/add-client.sh)

set -euo pipefail

CLIENT="${1:?Usage: $0 <client-name>}"
PROFILE="cutmyaws-${CLIENT}"

PASS=0
FAIL=0
WARN=0

pass() { echo "  ✅ $1"; ((PASS++)); }
fail() { echo "  ❌ $1"; ((FAIL++)); }
warn() { echo "  ⚠️  $1"; ((WARN++)); }

check() {
  local label="$1"
  shift
  if output=$("$@" 2>&1); then
    pass "$label"
  else
    fail "$label"
    echo "     → $output" | head -3
  fi
}

echo ""
echo "🔍 CutMyAWS Access Verification — ${CLIENT}"
echo "   Profile: ${PROFILE}"
echo ""

# ── Step 4: Can we assume the role at all? ──────────────────────────
echo "📌 Step 4: Role Assumption (sts:AssumeRole)"
if identity=$(aws sts get-caller-identity --profile "$PROFILE" --output json 2>&1); then
  account=$(echo "$identity" | grep -o '"Account": "[^"]*"' | cut -d'"' -f4)
  arn=$(echo "$identity" | grep -o '"Arn": "[^"]*"' | cut -d'"' -f4)
  pass "Assumed role successfully"
  echo "     Account: ${account}"
  echo "     Role:    ${arn}"
else
  fail "Cannot assume role — is the profile configured?"
  echo "     → $identity"
  echo ""
  echo "💡 Run ./audit/add-client.sh first, or check the external ID."
  echo ""
  exit 1
fi
echo ""

# ── Step 1: IAM Billing Access ──────────────────────────────────────
echo "💰 Step 1: IAM Billing Access"
# If billing access isn't enabled, billing API calls return AccessDenied
# even with the right IAM policies attached.
check "billing:GetBillingData" \
  aws billing get-billing-view \
  --arn "arn:aws:billing::${account}:billingview/primary" \
  --profile "$PROFILE" --output json

echo ""

# ── Step 2: Cost Explorer ───────────────────────────────────────────
echo "📊 Step 2: Cost Explorer"
# Cost Explorer must be enabled (one-time toggle). If not, ce:* calls fail
# with "Cost Explorer has not been enabled for this account."
END=$(date -u +%Y-%m-01)
START=$(date -u -v-1m +%Y-%m-01 2>/dev/null || date -u -d "1 month ago" +%Y-%m-01)
check "ce:GetCostAndUsage (last month)" \
  aws ce get-cost-and-usage \
  --time-period "Start=${START},End=${END}" \
  --granularity MONTHLY \
  --metrics UnblendedCost \
  --profile "$PROFILE" --output json

echo ""

# ── Step 3: Audit Role Permissions ──────────────────────────────────
echo "🔧 Step 3: Audit Role Permissions"

echo ""
echo "   ReadOnlyAccess (AWS managed policy):"

check "ec2:DescribeInstances" \
  aws ec2 describe-instances --max-items 1 \
  --profile "$PROFILE" --output json --region us-east-1

check "s3:ListBuckets" \
  aws s3api list-buckets --max-items 1 \
  --profile "$PROFILE" --output json

check "lambda:ListFunctions" \
  aws lambda list-functions --max-items 1 \
  --profile "$PROFILE" --output json --region us-east-1

check "rds:DescribeDBInstances" \
  aws rds describe-db-instances --max-items 1 \
  --profile "$PROFILE" --output json --region us-east-1

check "iam:ListRoles" \
  aws iam list-roles --max-items 1 \
  --profile "$PROFILE" --output json

echo ""
echo "   CutMyAWS-Billing-ReadOnly (inline policy):"

# Cost Explorer (ce:*)
START_48=$(date -u -v-48m +%Y-%m-01 2>/dev/null || date -u -d "48 months ago" +%Y-%m-01)
check "ce:GetCostAndUsage (48 months)" \
  aws ce get-cost-and-usage \
  --time-period "Start=${START_48},End=${END}" \
  --granularity MONTHLY \
  --metrics UnblendedCost \
  --profile "$PROFILE" --output json

check "ce:GetRightsizingRecommendation" \
  aws ce get-rightsizing-recommendation \
  --service AmazonEC2 \
  --profile "$PROFILE" --output json

# Cost and Usage Reports (cur:*)
check "cur:DescribeReportDefinitions" \
  aws cur describe-report-definitions \
  --profile "$PROFILE" --output json --region us-east-1

# Budgets (budgets:*)
check "budgets:DescribeBudgets" \
  aws budgets describe-budgets --account-id "$account" \
  --profile "$PROFILE" --output json

# Savings Plans (savingsplans:*)
check "savingsplans:DescribeSavingsPlans" \
  aws savingsplans describe-savings-plans \
  --profile "$PROFILE" --output json --region us-east-1

# Cost Optimization Hub (cost-optimization-hub:*)
check "cost-optimization-hub:ListRecommendations" \
  aws cost-optimization-hub list-recommendations \
  --profile "$PROFILE" --output json --region us-east-1

# Account info (account:*)
check "account:ListRegions" \
  aws account list-regions \
  --profile "$PROFILE" --output json

# Pricing API (pricing:*)
check "pricing:DescribeServices" \
  aws pricing describe-services --max-results 1 \
  --profile "$PROFILE" --output json --region us-east-1

# Organizations (organizations:*) — may fail if account isn't in an org
if org_output=$(aws organizations describe-organization --profile "$PROFILE" --output json 2>&1); then
  pass "organizations:DescribeOrganization"
else
  if echo "$org_output" | grep -q "AWSOrganizationsNotInUseException"; then
    warn "organizations: Account is not part of an AWS Organization (OK)"
  else
    fail "organizations:DescribeOrganization"
    echo "     → $org_output" | head -3
  fi
fi

echo ""

# ── Summary ─────────────────────────────────────────────────────────
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✅ Passed: ${PASS}"
[ "$WARN" -gt 0 ] && echo "  ⚠️  Warnings: ${WARN}"
[ "$FAIL" -gt 0 ] && echo "  ❌ Failed: ${FAIL}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ "$FAIL" -eq 0 ]; then
  echo "🎉 All checks passed — ready to audit ${CLIENT}!"
else
  echo "🚨 ${FAIL} check(s) failed. Have the client review:"
  echo "   https://cutmyaws.com/onboarding/give-david-access"
fi
echo ""

exit "$FAIL"
