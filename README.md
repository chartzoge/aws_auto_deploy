# AWS Auto Deploy

## Description
Grabs the latest CodeDeploy revision and kicks off a deployment to a specified CodeDeploy application. To be used along with a scheduled jenkins job.

## Prerequisites
- Node >= 0.10
- AWS CLI
    - Should have IAM role to list revisions & create deployments

## Synopsis
```bash
deploy.sh
    --application-name <value>
    --deployment-group-name <value>
    --s-3-bucket <value>
```

## Options
`--application-name` or `-a` (string)
> The name of an AWS CodeDeploy application associated with the applicable IAM user or AWS account.

`--deployment-group-name` or `-g` (string)
> The name of the deployment group. This will likely correspond to your different build environments (DEV, QA, STG, UAT, PROD)

`--S3_bucket` or `-b` (string)
> An Amazon S3 bucket name to limit the search for revisions.

## Example
```bash
./deploy.sh --application-name my-application \
    --deployment-group-name my-application-staging \
    --s-3-bucket my-application-assets
```

Successful execution will result in:
```
Deployment kicked off: {
    "deploymentId": "d-CRBXHEDKL"
}
```
