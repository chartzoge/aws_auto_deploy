#!/bin/bash
set -euo pipefail

while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -a|--application-name)
    APPLICATION_NAME="$2"
    shift
    ;;
    -g|--deployment-group-name)
    DEPLOYMENT_GROUP_NAME="$2"
    shift
    ;;
    -b|--s-3-bucket)
    S3_BUCKET="$2"
    shift
    ;;
    *)
    ;;
esac
shift
done

build_revision=$(aws deploy list-application-revisions \
    --application-name $APPLICATION_NAME \
    --sort-by "lastUsedTime" \
    --sort-order "descending" \
    --s-3-bucket $S3_BUCKET \
    --deployed "include" | ./parse_deployments.js)

echo "Deploying revision $build_revision"

current_deployment=$(aws deploy create-deployment \
    --application-name $APPLICATION_NAME \
    --s3-location bucket=$S3_BUCKET,key=$build_revision,bundleType=zip \
    --deployment-group-name $DEPLOYMENT_GROUP_NAME \
    --deployment-config-name CodeDeployDefault.OneAtATime \
    --description $build_revision)

echo "Deployment kicked off: $current_deployment"
