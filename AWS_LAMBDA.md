**Step 1: Tag your Docker image**

```bash
docker tag lambda-playwright:latest <account_id>.dkr.ecr.<region>.amazonaws.com/lambda-playwright:latest
```

**Step 2: Login to Amazon ECR**

```bash
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com
```

**Step 3: Create an Amazon ECR repository**

```bash
aws ecr create-repository --repository-name lambda-playwright --region <region>
```

**Step 4: Push your Docker Image to Amazon ECR**

```bash
docker push <account_id>.dkr.ecr.<region>.amazonaws.com/lambda-playwright:latest
```

**Step 5: Create a Lambda function that runs your Docker image**

```bash
aws lambda create-function --function-name playwright-function --role <lambda-execution-role-ARN> --package-type Image --code ImageUri=<account_id>.dkr.ecr.<region>.amazonaws.com/lambda-playwright:latest --region <region> --timeout 900
```

Note: Replace `<lambda-execution-role-ARN>` with your lambda execution role ARN. This is an Amazon Resource Name which identifies your IAM role that has AWSLambdaBasicExecutionRole permissions.

**Step 6: Test the Lambda function**

```bash
aws lambda invoke --function-name playwright-function --payload '{}'
```

This will create a file called "outputfile.txt" in the local directory which contains the function result. Use the following command to print the output:

```bash
cat outputfile.txt
```

Please ensure that you have set the permissions correctly for the Lambda function to access other AWS services and make sure AWS CLI has been configured properly with your credentials. You need to have your AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and default AWS region configured either in your shell environment or in ~/.aws/credentials (on Linux) or in a similar file on Windows.

Remember, it's also important to have the proper security groups configured to allow outbound access for your Lambda function.
