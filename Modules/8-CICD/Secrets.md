# Securing Workflows

## Secrets and encrypted variables

- Secrets are sensitive pieces of information.
    - E.g. API keys, passwords, credentials. 
    - Any value you don't want to expose in your code base. 


  - **How to manage secrets in GitHub Actions** :
      - Repo main page --> settings --> Add secrets
      - New repo secrets --> add name for secret --> enter value of secret. 


  - Examples of using secrets in the pipeline: 


```PY
- name: Use secret in a script
  run: echo "The secret is ${{ secrets.MY_SECRET }}"
```

OR 

```PY
- name: Use secret in a script
  run: echo "The secret is $MY_SECRET"
  env: 
    MY_SECRET: ${{ secrets.MY_SECRET }}
  ```


  - The secrets won't be shown in the pipeline when it runs. It's secure. 