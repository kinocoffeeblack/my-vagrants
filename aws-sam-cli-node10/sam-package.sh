#!/bin/bash

# edit this value.
STACK_NAME=sam_sample_node10
LAMBDA_UPLOAD_BUCKET_NAME=YOUR_BUCKET_NAME

sam package \
    --output-template-file packaged.yaml \
    --s3-bucket ${LAMBDA_UPLOAD_BUCKET_NAME} \
    --template-file ~/sam-build/${STACK_NAME}/template.yaml \
    --region ap-northeast-1
