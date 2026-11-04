# Advanced Github Actions

## Using Conditions and Expressions

### Conditions

- Allows you to control when a job or step should run based on certain criteria. 

```yml
- name: Run Tests
  run: python -m unittest discover
  if: success()

```

### Expressions

- Provide a way to perform calculations, manipulate strings and more within the workflow file. 


- This is how you reference a branch inside the workflow:
```yml
- name: Print branch name
  run: echo The branch is${{ github.ref }}
```

 
## Matrix builds and parallel testing - carried out in cicd folder.

- Matrix builds allow you to run multiple job configs in parallel. 
- Useful for testing across multiple environments. 


### CREATING THE PIPELINE: 

  1. Need to create the application file and the test file:

  - File = `hello,py` = application file

  ```py
  def say_hello():
    return "Hello World!"

  if __name__ == "__main__":
    print (say_hello())

  ```


  - Test file: 

  ```py
  import unittest 

  from hello import say_hello

  class TestHello(unittest.TestCase):
    def test_say_hello(self):
        self.assertEqual(say_hello(), "Hello World!")

  ```

  2. Creating the actual pipeline
   - Needs to be in the .github/workflows folder!


```py

name: Zainab Combined # Workflow / pipeline name

on: [push] # On the condition of a git push


jobs:     # Creating a job and build running on ubuntu
  build:
    runs-on: ubuntu-latest

    strategy:     # This is how to run the same pipeline on multiple versions.
      matrix:     # Using matrix 
        python-version: ["3.8", "3.9", "3.10"]  # Loops over these versions for the pipeline.


    steps: 

    - name: checkout code  # Step 1 - download code on to the borrowed vm. 
      uses: actions/checkout@v4


    - name: setup python   # Step 2 - installs python. 
      uses: actions/setup-python@v5
      with: 
        python-version: ${{matrix.python-version}} # Uses the version from the loop above


    - name: install_dependencies  # step 3 - install extra dependencies
      run: |
        cd python
        python -m pip install --upgrade pip
        if [ -f requirements.txt ]; then pip install -r requirements.txt; fi

    - name: run tests # Step 4 - go into python folder and run tests.
      run: |
        cd python
        python -m unittest discover 


    - name: notify us of success # Step 5: if everything before this worked, print a message saying the tests passed on that Python version.
      run: echo "Tests passed on python ${{matrix.python-version}}"
      if: success()

```