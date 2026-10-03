# Decommission — AWS Account Closure (research 2026-10-03)

Goal: back up everything, then close the Cut My AWS AWS account(s) without touching any other project.

**Status:** research done, backup done and verified. **Account NOT closed yet.** Blocking decisions are listed below.

## 1. How many accounts? — Just one

Your memory was "one per env", but the live AWS Organization (`o-hub50yd8sx`, management account `734267377938` PhoneLive) has **one** Cut My AWS account. Dev and prod both run inside it:

| Account | ID | Email | Created | Status |
|---------|----|-------|---------|--------|
| Cut My AWS | `731039145080` | cutmyaws.aws@phonelive.io | 2026-03-12 (created in org) | ACTIVE |

No other org account has "cut"/"azure" in its name or email. The other 18 accounts (PhoneLive, pealcast-*, ezra-events-*, Main Street Club(s), Mama P's, Legal/Get Smart Talk, Dealflow, Dial In to Pray, David Andrew Plappert, and 4 already-closed accounts) are **out of scope and must not be touched**.

Cost: about $2–4/month (Mar $2.01, Apr $3.90, May $3.90, Jun $3.44, Jul $2.76, Aug $3.19, Sep $3.14).

## 2. What's in the account (all 17 enabled regions scanned; everything is in us-east-1 or global)

| Service | Resources |
|---------|-----------|
| S3 | `cutmyaws-com` (prod site), `dev-cutmyaws-com` (dev site), `cutmyaws-access-logs` (CloudTrail + access logs, ~42k objects), `cutmyaws-logs` (empty), `aws-sam-cli-managed-default-samclisourcebucket-zxd6chwgmszy` (78 SAM artifacts, 787 MB) |
| CloudFront | `E1QP2X8FI34J2A` (cutmyaws.com, www) and `E3AM3WI3FESOBD` (dev.cutmyaws.com). **Both run the `redirect-to-davidplappert` function: every request returns 301 → https://davidplappert.com** |
| Route 53 zones | `Z10236932X9JIETO6LHWY` **cutmyaws.com** (17 records) and `Z069219924T1FMI64PIIU` **cutmyazure.com** (7 records) |
| API Gateway v2 | `cutmyaws-dev-api` (omoylzwhgh), `cutmyaws-prod-api` (u1dn6uuy6i); custom domains api.cutmyaws.com, api.dev.cutmyaws.com |
| Lambda | `cutmyaws-dev-router`, `cutmyaws-prod-router` (ruby3.4) |
| CloudFormation | `cutmyaws-dev-api`, `cutmyaws-prod-api`, `aws-sam-cli-managed-default` |
| EventBridge | `cutmyaws-check-abandoned-leads` (every 30 min), daily digest rules for dev and prod (10:45 UTC) |
| SSM | 14 SecureString params under `/cutmyaws/{dev,prod}/` (TiDB creds, Slack webhook, Turnstile secret) |
| SES | Domain `cutmyaws.com`, email `david@phonelive.io`, config set `cutmyaws-tracking`; still in sandbox |
| SNS | `cutmyaws-dev-alarms`, `cutmyaws-prod-alarms`, `cutmyaws-ses-events`, `cutmyaws-site-alerts` |
| CloudWatch | 10 alarms, 6 log groups (60-day retention) |
| IAM | User `github-deploy`, role `cutmyaws-github-deploy`, GitHub OIDC provider, 2 customer policies, SAM function roles, `OrganizationAccountAccessRole` |
| ACM | 1 cert (cutmyaws.com, *.cutmyaws.com, *.dev.cutmyaws.com) |
| CloudTrail | `cutmyaws-management` (multi-region → `cutmyaws-access-logs`) |
| None | DynamoDB, RDS, ECR, Secrets Manager, Cognito, SQS, Step Functions, WAF, Backup, RAM shares, Marketplace listings |

No client audit roles are configured (no `cutmyaws-<client>` CLI profiles exist), so no customer account trusts this one.

## 3. Cross-project dependencies (⚠️ read before closing)

| # | Dependency | What breaks when the account closes |
|---|------------|-------------------------------|
| 1 | **cutmyazure.com DNS zone lives in this account.** The domain is registered in the PhoneLive (`pl`) account, but its nameservers point to the zone here. It is a *separate site* (repo `phonelive/cutmyazure.com`, served by GitHub Pages, live and returning 200) with Google Workspace MX. | cutmyazure.com website **and email** go dark. |
| 2 | **cutmyaws.com → davidplappert.com redirect** is served by CloudFront in this account. | cutmyaws.com stops redirecting to davidplappert.com, so links and ads pointing at cutmyaws.com break. |
| 3 | **cutmyaws.com Google Workspace email** (MX, SPF, DKIM, DMARC records are in the zone here). `david@cutmyaws.com` receives the SNS alerts and DMARC reports. | Mail to @cutmyaws.com bounces. |
| 4 | **Domain registrations** for cutmyaws.com and cutmyazure.com are in the `pl` account (auto-renew ON, expire 2027-03-05 / 2027-03-08). | Nothing; they stay. But the NS records would point at deleted zones. |
| 5 | **TiDB Cloud lead DB** (outside AWS). | Nothing gets deleted, but the credentials only live in SSM here and in the Lambda env vars. |
| 6 | **GitHub Actions** (`deploy.yml`, `api.yml`) use secrets `AWS_ACCESS_KEY_ID_CUTMYAWS` / `AWS_SECRET_ACCESS_KEY_CUTMYAWS`. | Every push to main or tag push fails. |
| 7 | Other repos only *mention* cutmyaws (ezra & pls-api cost audits, release-tag doc, LinkedIn drafts). | Nothing runs against this account. |

Org-level checks of the management account: no SCPs, no delegated administrators, no StackSet instances, and 0 IAM references to `731039145080`. Closing this account does not affect any other account.

## 4. Backup

Private repo **`phonelive/cutmyaws-aws-backup`** (1 GB, 419 files, SHA-256 manifest). It was verified by a fresh clone, with all 419 checksums OK. See its README. It holds S3 contents, Lambda code, all CloudWatch log events, CloudTrail, every service config, both Route 53 zone record sets, and the local untracked files, stash, and unpushed commit.

**Not backed up (needs your action):** SSM secret **values** (an automated export of decrypted secrets into git was blocked by design) and the TiDB lead DB (outside AWS).

This repo (`phonelive/cutmyaws.com`) is **public**, so no raw configs, logs, or secrets were committed here.

## 5. Closure plan (in order)

1. **Decide** on the dependencies in section 3. Recommended:
   - Move the **cutmyazure.com** zone to the `pl` account: create the zone, copy the 7 records from `config/route53/route53-records-cutmyazure.com.json`, then update the registrar NS in `pl`.
   - Move the **cutmyaws.com** zone to `pl` too, keeping MX/SPF/DKIM/DMARC. Re-point the apex/www redirect to davidplappert.com from somewhere outside this account, or deliberately let it die.
2. Export SSM values to a password manager; dump TiDB if the leads matter.
3. Disable the GitHub Actions workflows (or archive the repo) and delete the two `*_CUTMYAWS` repo secrets.
4. Close: `aws organizations close-account --account-id 731039145080 --profile pl`.
   - AWS keeps the account in **SUSPENDED** state for 90 days (reopenable via Support), then permanently deletes all content. Same as the 4 previously closed accounts (solvd-*, validco-dev, david-cat).
   - Closed accounts still count toward the org quota for 90 days.
5. Afterwards: remove the `[profile cutmyaws]` block from `~/.aws/config`. Decide whether to turn off auto-renew for cutmyaws.com and cutmyazure.com in `pl` (the ezra cost audit, 2026-07, lists both as "clearly dead").
