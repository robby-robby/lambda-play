#!/bin/bash

functionName=lambda-function
state=""

while [[ "$state" != "\"Active\"" ]]; do
	state=$(aws lambda get-function --function-name $functionName --query 'Configuration.State')
	echo "Current state: $state"
	sleep 5 # wait for 5 seconds before next check
done

echo "Lambda function $functionName is active."
