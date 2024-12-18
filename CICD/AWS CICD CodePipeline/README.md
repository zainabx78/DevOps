# Creating a CI/CD pipeline using AWS CodePipeline

### Prerequisites: 
- AWS Cloud9 IDE connected to EC2 instance with your code.
- S3 bucket hosting website.
- S3 bucket for CodePipeline.

### Creating the Pipeline

- From AWS console, create a CodeCommit repository to host the code in. This repo is called MyRepo.
  
![Screenshot 2024-12-18 161025](https://github.com/user-attachments/assets/007ae4c0-159e-4448-86da-a52000b05ef1)

- Create a test file to ensure correct permissions and configuration of the repository.
- Create a file in the newly created repository and commit to the main branch. 

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
- The commit should look like this:
![Screenshot 2024-12-18 161743](https://github.com/user-attachments/assets/6ccf4f48-2496-41d4-9b0c-9e3e1c800d3f)
