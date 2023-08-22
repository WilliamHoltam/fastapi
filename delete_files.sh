#!/bin/bash

# Replace these variables with your actual values
AWS_PROFILE="default"
BUCKET_NAME="fastapi-state"
export AWS_REGION=eu-west-2
# List all objects in the bucket
OBJECTS=$(aws s3api list-objects --profile $AWS_PROFILE --bucket $BUCKET_NAME --output json | jq -r '.Contents[].Key')

# Delete each object
for OBJECT in $OBJECTS; do
  aws s3api delete-object --profile $AWS_PROFILE --bucket $BUCKET_NAME --key "$OBJECT"
  echo "Deleted: s3://$BUCKET_NAME/$OBJECT"
done

echo "All objects deleted from bucket: $BUCKET_NAME"
