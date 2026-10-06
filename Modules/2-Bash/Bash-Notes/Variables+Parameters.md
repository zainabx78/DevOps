# Variables

- Allow you to store and manipulate data. 

- Script using variables: 

```bash
#!/bin/bash

greeting = "Hello World"
count = 42

echo $count
echo $greeting

```

- Variables can also hold arrays:

```bash

#!/bin/bash

fruits = ("Apple", "Banana", "Orange")

echo $fruits

```


- Can also use variables within strings: Variable interpolation

```bash
#!/bin/bash

name = "Zainab"

echo "Hello, $name"

```



#------------------------------------------------------------------

# Parameters

- Passing parametes:
  - E.g. `./script.sh parameter1 parameter2` 
  - Parameters are passed after the script with spaces in between. 
  - `$1` = just the first parameter passed in. 

```bash
#!/bin/bash

echo "Parameter 1: $1"
echo "Parameter 2: $2"
echo "Parameter 3: $3"


```

  - When the script is ran, the parameter passed will be displayed.
  - Run the script with parameters = `./script.sh hello hi `
  - This only has 2 parameters - `hello` and `hi`
  - So, this will display:
  
   ![alt text](../Images/parameters.png)


## Accessing all parameters 

- Use special variable - `$@`
- Add this to the script: `echo "All parameters: $@` --> will display all parameters when passed with the script. 


#------------------------------------------------------------------


# Arithmetic Expansion 

1. Adding numbers together

```bash

#!/bin/bash

num1 = 5
num2 = 10

results  = $((num1 + num2))

echo "The sum of $num1 and $num2 is: $results"


```

2. Calculating the area of a rectangle

```bash

#!/bin/bash

length = 5
width = 8

area = (($length * $width))
perimeter = ((2 * (length + width)))

echo "The area of the rectangle is: $area"
echo "The perimeter of the rectangle is: $perimeter"


```



## Arithmetic Expansion with Parameters (dynamic scripts)

- This script will perform the calculations based on the parameters entered in the terminal. It doesn't have set numbers for length and width. 
- Enables us to make dynamic scripts and utilise user input. 

```bash
#!/bin/bash

length = "$1"
width = "$2"

area = (($length * $width))
perimeter = ((2 * (length + width)))

echo "The area of the rectangle is: $area"
echo "The perimeter of the rectangle is: $perimeter"


```
