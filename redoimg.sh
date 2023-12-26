#!/bin/bash

#aws iam create-role --role-name lambda-execution-role --assume-role-policy-document file://trust-policy.json
#aws iam attach-role-policy --role-name lambda-execution-role --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
#login aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 443971207211.dkr.ecr.us-east-1.amazonaws.com
#   aws ecr create-repository --repository-name lambda-function --region us-east-1
#   aws lambda create-function --function-name lambda-function --role arn:aws:iam::443971207211:role/lambda-execution-role --package-type Image --code ImageUri=443971207211.dkr.ecr.us-east-1.amazonaws.com/lambda-function:debug --region us-east-1 --timeout 900 --architecture arm64

docker build -t lambda-function:debug . &&
	docker tag lambda-function:debug 443971207211.dkr.ecr.us-east-1.amazonaws.com/lambda-function:debug &&
	docker push 443971207211.dkr.ecr.us-east-1.amazonaws.com/lambda-function:debug &&
	aws lambda update-function-code --function-name lambda-function --image-uri 443971207211.dkr.ecr.us-east-1.amazonaws.com/lambda-function:debug --region us-east-1
#aws lambda update-function-configuration --region us-east-1 --function-name lambda-function --environment 'Variables={LANG=en_US.UTF-8, TZ=:/etc/localtime, PATH=/var/lang/bin:/usr/local/bin:/usr/bin/:/bin:/opt/bin, LD_LIBRARY_PATH=/var/lang/lib:/lib64:/usr/lib64:/var/runtime:/var/runtime/lib:/var/task:/var/task/lib:/opt/lib, HOME=/home}'
#    aws lambda update-function-event-invoke-config --function-name lambda-function --maximum-retry-attempts 0
