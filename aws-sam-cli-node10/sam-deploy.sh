#!/bin/bash

# edit this value.
STACK_NAME=sam_sample_node10

sam deploy \
    --template-file packaged.yaml \
    --stack-name ${STACK_NAME} \
    --capabilities CAPABILITY_IAM \
    --region ap-northeast-1
