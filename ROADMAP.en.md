# ROADMAP

## Near-term improvements
- ACM module + HTTPS for public service.
- Move user_data to Cloud-Init templates and parameterize.
- Environments separation (workspaces): dev/stage/prod.

## Infrastructure
- CloudFront module + private access to S3.
- Logging: CloudWatch, EC2 metrics and alerts.
- Terraform state backend on S3/DynamoDB.

## CI/CD
- Automatic checks: `terraform fmt`, `validate`, `tflint`.
- Plan/apply in PR with manual approvals.

## Security
- Restrict SSH to corporate CIDRs.
- Encrypt params/secrets via SSM Parameter Store.