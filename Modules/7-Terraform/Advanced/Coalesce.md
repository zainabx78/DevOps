
# Coalesce


## Using Coalesce for Default Values

- Categorized as a collection function.
- Collections of values e.g. lists, maps, sets. 
- Takes any number of arguments and returns the first one that isn't a null or an empty string. 
- All arguments must be of the same type e.g. if it's a list, can't pass in a map.
  

- E.g. SIMPLE: 

`coalesce ("", "hello", "world")` In the terminal. 
  - This will return "hello" because coalesce ignores empty/null values and returns the next value. 




- One of the main uses of coalesce is to set defaults.


```
variable "user_defined_name" {
    type = string
    default = "" # aka null. 
}

resource "aws_instance" "my-instance" {
    ami = "ami-test"
    instance_type = "t2.micro"

    tags = {
        Name = coalesce (var.user_defined_name, "generic-name")
    }
}

```

- If the user doesn't provide a variable in user_defined_name, coalesce will provide a default value of `generic-name`. It's that simple.
- If input is given, terraform will use that instead of default value. 
  - E.g. `terraform plan -var="user_defined_name=zainab"`



### Missing values - use case

- Providing missing values. 
- Using lookup with coalesce.

![alt text](../Images/coalesce.png)

- lookup(...) looks in the Python program’s answers for an item called "id". If there isn’t one, it uses "fallback-name" instead.

- coalesce(...) is a second safety net. If the result is still empty, it uses "fallback-name".




### Another use case of coalesce/linkup 

- Prioritising different values
- try function = catches errors and returns null instead of crashing. 


![alt text](../Images/coalesce2.png)