# Functions and Inputs

## Functions

- Mini programs within bash script.

```bash
#!/bin/bash

function_name() {

    # Code block to be executed

}

```

- Example: Hello World function

```bash
#!/bin/bash

hello_world() { # setting the function

    echo "Hello World"
}

hello_world # calling the function

```
  - To call the function: need to call the function
    - `hello_world`


- Example 2: Can also use parameters within the function

```bash
#!/bin/bash

greet_person () {

    local name="$1" # referencing variable 1 that's passed in
    echo "Hello, $name"
}

greet_person "Ahmed" # taking Ahmed as a parameter for the function

```


## Function Parameters

Different types of parameters:
 
1. Positonal parameter - 
  - Value is stored in a local variable.
  - Function uses the parameter
  - Example shown above.

2. Special parameters:
   - `"$#"` = prints any number of arguments passed in.
   - `"$0"` = special variable that contains name of the script.
   - `"$1"` = Contains the first argument/parameter
   - `"$2"` = Contains the second argument/parameter
   - `"$@"` = Contains all parameters

```bash
#!/bin/bash

print_args() {
    echo "Number of arguments: $#" 
    echo "Script name: $0" 
    echo "First argument: $1"
    echo "Second argument: $2"
    echo "All arguments: $@"
}

# Call the function with parameters

print_args "Alice" "Bob"

```

## User Inputs

- Can interact with users within scripts

### READ COMMAND:

- Read command is used to capture user's input.
- This script will ask your name and you have to type in your name and it will return hello. 

```bash
#!/bin/bash

greet_user(){
    echo "What is your name?"
    read name
    echo "Hello, $name!"
}

greet_user

```

- Example 2: combines parameters and user input

```bash
#!/bin/bash

greet_user(){
    local name

    if [ $# -eq 0 ]  # if all arguments = 0
    then
        echo "What is your name?"
        read name
    else             # if arguments are passed in script
        name="$1"
    fi

    echo "Hello, $name"
}

greet_user

```



## Handling Bad Data

- Bad data = invalid or unexpected user inputs that may cause errors or undesired behaviour in our scripts.

### Validating user inputs in functions

1. Using conditional statements
   - Check validity of inputs
   - E.g.:

```bash
#!/bin/bash

validate_age(){ # sets a function

    local age=$1 #age is the first parameter passed in
    # local = parameter only exists in this function.


    if [[ ! $age =~ ^[0-9]+$ ]]; then #using a regular expression
        echo "Invalid age. Please provide a numeric value."
        return 1
    fi
    # ^[0-9]+$ is a pattern (called a regular expression) meaning "only digits, from start to finish." So 25 matches, but abc or 2five don't.
    # =~ means "does it match this pattern?"
    # ! flips the question to "does it not match?"
    # E.g. the `!` means if age ISNT a number then do this..
    # Without the !, it would mean if age IS a number then do this..
    # return 1 means stop the function there and don't do further checks if it fails here


    if (( age < 18 )); then
        echo "Sorry, you must be at least 18 years old."
        return 1
    fi 
    # If age is a number and it's less than 18 then print this..
    # return 1 = failure in bash - means stop the function there and don't do further checks if it fails here

    echo "Congratulations! You are eligible."
    return 0
    # if age is a number and more than 18 then print this..
    # return 0 = success in bash
}

echo "Please enter your age"
read user_age
validate_age "$user_age"

# Write a section to write a message based on exit code (1 or 0)
exit_code=$?

if (( exit_code != 0 )); then # is not equal to
    echo "Input validation failed."
else
    echo "Input validation passed."
fi

# $? is Bash's built-in way of getting the exit code of whatever just ran.
# 0 = success
# 1 = faily7

```
- Use return 1 or return 0 to make sure the parameter isn't passed through any other condition/check if it fails or passed a final test.
- $? is Bash's built-in way of getting the exit code of whatever just ran.
- 0 = success
- 1 = fail



### Input sanitization 

```bash
#!/bin/bash

sanitize_string(){
    local input=$1
    local sanitized_input=${input//[^a-zA-Z0-9]/}

    echo "$sanitized_input"
}
# `//` = replace every single match 
# [^a-zA-Z0-9] is the thing to find. 
# a-z is lowercase letters, A-Z is capitals, 0-9 is digits, and the ^ at the start means "not these." 
# So it finds any character that isn't a letter or number, like spaces, !, @, or -.
# [^a-zA-Z0-9] finds everything except letters and numbers.
# The final / followed by nothing means "replace it with nothing," which deletes it.
# So, it means in the input - replace all of the values except numbers and letters and replace with nothing (to get rid of everything except numbers and letters)


# Calling the function
echo "Please enter a username:"
read input_username

$sanitized_username=${sanitize_string "$input_username"}

echo "Sanitized username: $sanitized_username
```

