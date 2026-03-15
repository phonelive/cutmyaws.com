# Client Audit Infrastructure

## AWS Accounts

| Account | ID | Email | Purpose |
|---------|-----|-------|---------|
| PhoneLive (management) | 734267377938 | aws@phonelive.io | Parent org, consolidated billing |
| Cut My AWS | 731039145080 | cutmyaws.aws@phonelive.io | Audit operations, assumes roles into client accounts |

Organization ID: `o-hub50yd8sx`. All billing rolls up to PhoneLive management account.

## AWS CLI Profiles

| Profile | Account | Method |
|---------|---------|--------|
| `pl` | 734267377938 | IAM user credentials (david.plappert) |
| `cutmyaws` | 731039145080 | Assumes `OrganizationAccountAccessRole` via `pl` |
| `cutmyaws-<client>` | Client account | Assumes `CutMyAWS-ReadOnly-Auditor` via `cutmyaws` |

## Client Onboarding Flow

```
1. Client books intro call → /book
2. After signing: David generates unique external ID
3. Client deploys CloudFormation stack (audit/client-role.yaml)
   - Creates IAM role: CutMyAWS-ReadOnly-Auditor
   - Trusts CutMyAWS account (731039145080)
   - Attaches: ReadOnlyAccess + custom billing policy
   - Client must enable IAM billing access + Cost Explorer
4. David runs: ./audit/add-client.sh <name> <account-id> <external-id>
5. David runs: ./audit/verify-access.sh <name>  (confirms all 4 onboarding steps)
6. Audit begins via CLI: aws ce get-cost-and-usage --profile cutmyaws-<client>
6. After audit: client deletes CloudFormation stack to revoke access
```

## Client Role Permissions

The `CutMyAWS-ReadOnly-Auditor` role grants:
- **ReadOnlyAccess** (AWS managed) — Get/List/Describe for all services
- **Custom billing policy** — Cost Explorer (48 months), Cost & Usage Reports, Budgets, Savings Plans, Cost Optimization Hub, Account info, Pricing API, Organizations read

The role uses an **external ID** per client to prevent confused deputy attacks.

## Audit Key Files

| File | Purpose |
|------|---------|
| `audit/client-role.yaml` | CloudFormation template — client deploys to create audit role |
| `audit/add-client.sh` | Script to add client CLI profile (`./audit/add-client.sh <name> <id> <ext-id>`) |
| `audit/verify-access.sh` | Verify all onboarding steps completed (`./audit/verify-access.sh <name>`) |
| `audit/CLIENT-INSTRUCTIONS.md` | Client-facing setup instructions (send to client) |
| `app/pages/onboarding/give-david-access/index.vue` | Web version of client setup instructions at `/onboarding/give-david-access` |
| `app/pages/onboarding/calculate-savings/index.vue` | Annualized AWS bill calculator at `/onboarding/calculate-savings` |

## Common Audit CLI Commands

```bash
# Last 48 months of monthly costs by service
aws ce get-cost-and-usage \
  --time-period Start=2022-04-01,End=2026-04-01 \
  --granularity MONTHLY \
  --metrics UnblendedCost \
  --group-by Type=DIMENSION,Key=SERVICE \
  --profile cutmyaws-<client>

# Rightsizing recommendations
aws ce get-rightsizing-recommendation \
  --service AmazonEC2 \
  --profile cutmyaws-<client>

# Savings plan recommendations
aws ce get-savings-plans-purchase-recommendation \
  --savings-plans-type COMPUTE_SP \
  --term-in-years ONE_YEAR \
  --payment-option NO_UPFRONT \
  --lookback-period-in-days SIXTY_DAYS \
  --profile cutmyaws-<client>

# List all EC2 instances across regions
for region in $(aws ec2 describe-regions --query 'Regions[].RegionName' --output text --profile cutmyaws-<client>); do
  echo "=== $region ==="
  aws ec2 describe-instances --query 'Reservations[].Instances[].[InstanceId,InstanceType,State.Name]' --output table --region $region --profile cutmyaws-<client>
done
```
