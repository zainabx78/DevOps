# Creating a CI/CD pipeline using AWS CodePipeline

### Prerequisites: 
- AWS Cloud9 IDE connected to EC2 instance with your code.
- S3 bucket hosting website.
- S3 bucket for CodePipeline.

### Creating the repository

- From AWS console, create a CodeCommit repository to host the code in. This repo is called MyRepo.
  
![Screenshot 2024-12-18 161025](https://github.com/user-attachments/assets/007ae4c0-159e-4448-86da-a52000b05ef1)

- Create a test file to ensure correct permissions and configuration of the repository.
- Create this file in the newly created repository and commit to the main branch. 

```
<!DOCTYPE html>
<html>
    <head>
    <title>Test page</title>
    </head>
    <body>
        <h1>
           This is a sample test page for my repo.
        </h1>
    </body>
</html>
```

The commit should look like this:
![Screenshot 2024-12-18 161743](https://github.com/user-attachments/assets/6ccf4f48-2496-41d4-9b0c-9e3e1c800d3f)

### Creating the Pipeline

- Create a json file with the pipeline configuration details in Cloud9 IDE environment:
```
{
    "pipeline": {
     "roleArn": "arn:aws:iam::808312730501:role/RoleForCodepipeline",
     "stages": [
       {
         "name": "Source",
         "actions": [
           {
             "inputArtifacts": [],
             "name": "Source",
             "actionTypeId": {
               "category": "Source",
               "owner": "AWS",
               "version": "1",
               "provider": "CodeCommit"
             },
             "outputArtifacts": [
               {
                 "name": "MyApp"
               }
             ],
             "configuration": {
               "RepositoryName": "front_end_website",
               "BranchName": "main"
             },
             "runOrder": 1
           }
         ]
       },
       {
         "name": "Deploy",
         "actions": [
           {
             "inputArtifacts": [
               {
                 "name": "MyApp"
               }
             ],
             "name": "CafeWebsite",
             "actionTypeId": {
               "category": "Deploy",
               "owner": "AWS",
               "version": "1",
               "provider": "S3"
             },
             "outputArtifacts": [],
             "configuration": {
               "BucketName": "c137619a3513353l8783613t1w808312730501-s3bucket-nz1xnqcpul1v",
               "Extract": "true",
               "CacheControl": "max-age=14"
             },
             "runOrder": 1
           }
         ]
       }
     ],
     "artifactStore": {
       "type": "S3",
       "location": "codepipeline-us-east-1-808312730501-website"
     },
     "name": "cafe_website_front_end_pipeline",
     "version": 1
    }
   }
```
- In CLoud9 IDE, ensure installation of AWS cli and python SDK (boto3)
```
aws --version
pip show boto3
```
- Run the pipeline script and create the pipeline using cli command in the cloud9 terminal:
```
cd ~/environment/resources
aws codepipeline create-pipeline --cli-input-json file://pipelinescriptfile.json
```
- In the CodePipeline console, your pipeline should have run.

![Screenshot 2024-12-18 170359](https://github.com/user-attachments/assets/bf5d995a-0fb4-4a0d-b128-2ed4b5e0711a)

- Since the target is configured as an S3 bucket, the test file should automatically have been added to the bucket once the pipeline was run. 
