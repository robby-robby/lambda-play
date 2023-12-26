```bash
docker tag lambda-function:latest 443971207211.dkr.ecr.us-east-1.amazonaws.com/lambda-function:latest
```

```bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 443971207211.dkr.ecr.us-east-1.amazonaws.com
```

```bash
aws ecr create-repository --repository-name lambda-function --region us-east-1
```

```bash
docker push 443971207211.dkr.ecr.us-east-1.amazonaws.com/lambda-function:latest
```

```bash
aws iam create-role --role-name lambda-execution-role --assume-role-policy-document file://trust-policy.json
```

```bash
aws iam attach-role-policy --role-name lambda-execution-role --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
```

```bash
aws lambda create-function --function-name playwright-function --role arn:aws:iam::443971207211:role/lambda-execution-role --package-type Image --code ImageUri=443971207211.dkr.ecr.us-east-1.amazonaws.com/lambda-function:latest --region us-east-1 --timeout 900
```

```bash
aws lambda invoke --function-name playwright-function --region us-east-1 --payload '{}' outputfile.txt
```

Remember to replace `file://trust-policy.json` with the actual path of your `trust-policy.json` file, if it's not in the same directory you are running the commands from.
Please be mindful of the AWS command-line tool, Docker, as well as your IAM roles and policies on your AWS account - you'll need appropriate permissions to execute these commands.
