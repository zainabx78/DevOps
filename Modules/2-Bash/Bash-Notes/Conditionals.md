# CONDITIONALS - IF, ELSE AND ELIF

- Enable you to create decisions and enable dynamic behaviour in scripts. 

- E.g. simple if condition 

```bash
#!/bin/bash

if condition # start of the if statement
then

    # code block to be executed

fi # the end of the if statement

# eq = equals 
# ne = not equal to 
# lt = less than
# gt = greater than
# le = less than or equal to
# ge = greater than or equal to
```

- Using those comparison operators:

```bash
#!/bin/bash

age=25 # Setting the age variable

if [ $age -gt 18 ] # if value in the age variable is greater than 18 then:
then

    echo "You are an adult." # print this

fi  closing statement of if 
```


- Logical operators:
  - `&&`  = AND
  - `||` = OR

- This code block won't print anything as it's not true.

```bash
#!/bin/bash

grade = 85

if [ $grade -ge 90] && [$grade -le 100 ]
then
    echo "YAY"

fi

```

- Operators 
  - `==` = is equal to 
  - `!=` = is not equal to

```bash
#!/bin/bash

name = "Alice"

if [ $name == "Alice" ]
then
    echo "Hello, Alice"
fi

```




## ELSE AND ELIF

```bash
#!/bin/bash

if  condition
then
    # code block if condition is true
else
    # code block if condition is false
fi

```


- Example: ELSE

```bash
#!/bin/bash

age = 15

if [ $age -gt 10]
then
    echo "You are an adult"
else
    echo "You are not an adult"

fi


```

- Example: ELIF (multiple conditions)

```bash
#!/bin/bash

if [ $score -ge 90]
then
    echo "Excellent"

elif [$score -ge 80] # 2nd condition if first one is not met
    echo "Good"

else # Like a failsafe - if conditions are not met
    echo "Better luck next time" 

fi 

```

- Nested if statements
- Can use `then` on the same line too e.g. `; then`

```bash
#!/bin/bash

age = 18
grade = 85

if [ $age -gt 18 ]
then
    echo "You are eligible based on age"

    if [ $grade -ge 80 ]; then
        echo "You are eligible based on grade"
        echo "You are eligible based for the scholarship"
    else
        echo "sorry your grade is not high enough"
    fi

else
    echo "You are not eligible"

fi

```