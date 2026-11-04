# Manual Triggers and Github actions

- Allows workflow to be manually triggered via github actions UI. 
- Useful for deployments, maintenance and on-demand jobs. 

1. Create workflow file as normal (matrix builds workflow file)
2. Instead of push trigger (on:), use workflow_dispatch

```yml
on:
  push:
  workflow_dispatch:
    inputs:
      python-version:
        description: 'Choose python version'
        required: true
        default: '3.7'
        type: choice
        options:
        - '3.8'
        - '3.9'
        - '3.10'

```

- If you push this and trigger the pipeline, in github actions --> see option to pick a version you want to run instead of auto trigger. 