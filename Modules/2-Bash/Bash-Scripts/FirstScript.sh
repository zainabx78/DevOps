#!/bin/bash

# for loop
for (( i=1; i<=5; i++))
do 
    echo "Number: $i"
done

# for loop
fruits=("apple" "banana" "orange")

for fruit in "${fruits[@]}"
do 
    echo "Fruits: $fruit"
done

# sequence command
for number in  $(seq 1 5)
do 
    echo "Number: $number"
done

# break
for (( i=1; i<=5; i++ ))
do 

    if [ $i -eq 3 ] # as soon as loop gets to 3 = break
    then
        break
    fi

    echo "Number: $i"

done

# Continue
for (( i=1; i<=5; i++ ))
do 

    if [ $i -eq 3 ] # as soon as loop gets to 3 = break
    then
        continue
    fi

    echo "Number: $i"

done


# Indefinite loop
count=1
 
while true # setting the condition to true unless there's a break
do 

    echo "Count: $count"
    ((count++))
    if [ $count -eq 4 ]
    then
        break
    fi

done