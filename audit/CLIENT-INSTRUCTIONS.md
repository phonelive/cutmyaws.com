# CutMyAWS Audit — Account Setup Instructions

Hi! To begin your AWS audit, we need **read-only** access to your account. This takes about 5 minutes.

We **cannot** modify, delete, or create any resources. The role is read-only with an external ID that only we know.

---

## Prerequisites

Before deploying the role, you need to enable two things:

### 1. Enable IAM Access to Billing (required)

By default, only the root user can see billing data. You need to enable IAM access:

1. Sign in as **root user** (not IAM)
2. Go to **Account** → **IAM User and Role Access to Billing Information**
3. Click **Edit**, check **Activate IAM Access**, click **Update**

### 2. Enable Cost Explorer (if not already enabled)

1. Go to **Billing** → **Cost Explorer**
2. If prompted, click **Enable Cost Explorer**
3. It takes up to 24 hours to populate historical data (usually faster)

---

## Deploy the Audit Role

### Option A: CloudFormation Console (easiest)

1. Click this link to launch the stack (replace `EXTERNAL_ID` with the ID we gave you):

   ```
   https://console.aws.amazon.com/cloudformation/home#/stacks/quickcreate?stackName=CutMyAWS-Audit&templateURL=YOUR_TEMPLATE_URL&param_ExternalId=EXTERNAL_ID
   ```

2. Or: Go to **CloudFormation** → **Create stack** → **Upload a template file**
3. Upload the `client-role.yaml` file we sent you
4. Enter the **External ID** we provided
5. Check the box acknowledging IAM resource creation
6. Click **Create stack**

### Option B: AWS CLI

```bash
aws cloudformation deploy \
  --template-file client-role.yaml \
  --stack-name CutMyAWS-Audit \
  --parameter-overrides ExternalId=EXTERNAL_ID_WE_GAVE_YOU \
  --capabilities CAPABILITY_NAMED_IAM
```

---

## What to Send Back

After the stack completes, send us:
- **Your AWS Account ID** (12-digit number from the top-right of the console)

That's it! We already know the role name and external ID.

---

## What This Role Can Do

✅ **Read** all resource configurations (EC2, RDS, Lambda, S3, etc.)
✅ **Read** 48 months of billing and cost data
✅ **Read** savings plans, reservations, and budgets

❌ **Cannot** create, modify, or delete any resources
❌ **Cannot** access data inside S3 buckets, databases, or secrets
❌ **Cannot** modify IAM users, policies, or roles

---

## Removing Access

When the audit is complete, delete the CloudFormation stack:

```bash
aws cloudformation delete-stack --stack-name CutMyAWS-Audit
```

Or: **CloudFormation** → **CutMyAWS-Audit** → **Delete**

This immediately revokes all access.
