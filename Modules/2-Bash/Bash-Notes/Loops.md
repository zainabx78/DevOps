# LOOPS

- Allow you to repeat a block of code until the condition becomes false.

## While loops


```bash
#!/bin/bash

while condition
do 
    #code to be executed

done

```

- Example: Count


```bash
#!/bin/bash

count=1

while [ $count -le 5]
do
    echo "count: $count"
    ((count ++)) # keeps adding 1 to the count until the count becomes 5 - condition becomes false.

done

```

- Example 2:


```bash
#!/bin/bash

fruits=("apple", "banana", "orange")
index=0

while [ $insdex -lt ${#fruits[0]}]
do 
    echo "Fruit: {$fruits[$index]}"
    ((index++))

done


```

#--------------------------------------------------------


## For loops

- Allow you to iterate over a sequence of values and perform repetitive tasks. 

```bash
#!/bin/bash

for variable in sequence # loops through each value in a sequence
do 
    # codeblock to be executed
done

```

- Example: 


```bash
#!/bin/bash

for (( i=1; i<=5; i++))
do 
    echo "Number: $i"
done

```

- Example 2:

  - Make sure no spaces when setting variables e.g. `fruit=("")`
  
```bash
#!/bin/bash

fruits=("apple" "banana" "orange")

for fruit in "${fruits[@]}"
do 
    echo "Fruit: $fruit"
done

```

- Sequence command:
  - Looping through numbers 


```bash
#!/bin/bash

for number in  $(seq 1 5)
do 
    echo "Number: $number"
done

```


#--------------------------------------------------------


## Break and continue

- Control statements - Break and continue.
- Break = immediately exits innermost loop it's placed in.

- Break: 

```bash
#!/bin/bash

for (( i=1; i<=5; i++ ))
do 

    if [ $i -eq 3 ] # as soon as loop gets to 3 = break
    then
        break
    fi

    echo "Number: $i"

done

```

  - This script should break after number 2 is printed. 


- Continue statement:
  - Same as break but use continue instead - instead of stopping at 3, it just skips 3.
  - Should print numbers 1, 2, 4, 5.

```bash
#!/bin/bash

for (( i=1; i<=5; i++ ))
do 

    if [ $i -eq 3 ] # as soon as loop gets to 3 = break
    then
        continue
    fi

    echo "Number: $i"

done

```

- Example : loop continuing indefinitely:

```bash
#!/bin/bash

count=1

while true # setting condition as true unless break
do 

    echo "Count: $count"
    ((count++))
    if [ $count -eq 4 ]
    then
        break
    fi

done
```

- Example 2: 
  - Skips the number 3 so it's not printed.
```bash
#!/bin/bash

count=1

while [ $count -le 5 ]
do 

    if [ $count -eq 3 ]
    then
        ((count++))
        continue
    fi
    
    echo "Count: $count"
    ((count++))

done
```
