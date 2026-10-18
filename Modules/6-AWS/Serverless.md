# Serverless

- Developers don't have to manage servers anymore. 
- They just deploy code.
- They just deploy functions.
- Serverless = managed servers - AWS manages them for you. 


## Serverless in AWS

- AWS Lambda
- DynamoDB 
  - Fully managed serverless database 
  - Don't need to manage it. 
- AWS Cognito
- AWS API Gateway
- Amazon S3
- AWS SNS and SQS.
- AWS Kinesis Data firehose
- Aurora serverless
- Step functions
- Fargate


## AWS LAMBDA

- No servers to manage.
- Limited by time - short executions.
- Run on-demand.
- Scaling is automated. 
- Easy pricing - only pay for compute time. 
- Easy monitoring through cloudwatch.
- Easy scaling for functions.
- Increasing RAM will also improve CPU and network. 


Supports:
  - Node.js
  - Python
  - Java
  - C#
  - Ruby 
  - Custom Runtime API.
  - Lambda container image --> implements the lambda runtime api.


E.g. 
  - New image in S3.
  - Event triggers Lambda
  - Takes image and creates smaller thumbnail of image and stores in S3.
  - Pushes metadata in dynamodb. 

E.g. Serverless CRON Job
  - Cloudwatch events - event bridge
  - AWS Lambda function runs every 1 hour and performs a task. 
