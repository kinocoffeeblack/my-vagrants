#!/bin/bash

# edit this value.
STACK_NAME=sam_sample_node10

sam build \
 --build-dir ~/sam-build/${STACK_NAME} \
 --region ap-northeast-1
