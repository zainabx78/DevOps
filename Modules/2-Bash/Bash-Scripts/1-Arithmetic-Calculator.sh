#!/bin/bash


# Description:
#   This script asks the user to enter two numbers, then
#   performs the four basic maths operations on them:
#   addition, subtraction, multiplication and division.
#   It displays each calculation and its result on screen.
#
#   If the user enters 0 as the second number, the script
#   shows an error message for the division instead of
#   trying to divide, because dividing by zero isn't possible.
#
# Concepts used:
#   - User input (read)
#   - Variables
#   - Arithmetic expansion
#   - If/else conditionals
#   - Error handling



calculator(){

    # Asking for input 1
    echo "Please enter the first number:"
    read number1

    # If the number in input is 0 then error
    if [ "$number1" -eq 0 ]; then
        echo "Error: The number entered cannot be 0"
        exit 1
    fi

    # Asking for 2nd input
    echo "Please enter the second number:" 
    read number2
  

    # If the number in input is 0 then error
    if [ "$number2" -eq 0 ]; then
        echo "Error: The number entered cannot be 0"
        exit 1
    fi

    # Performing the operations on the numbers given in input
    c=$(( number1 + number2 ))
    d=$(( number1 - number2 ))
    e=$(( number1 / number2 ))
    f=$(( number1 * number2 ))

    echo "Results: $number1 + $number2 = $c, $number1 - $number2 = $d, $number1 / $number2 = $e, $number1 * $number2 = $f" 

}

calculator 
