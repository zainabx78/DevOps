# MERGE CONFLICT 

## How it happens:

- A merge conflict happens when 2 people change the exact same line in the same file. 
- Conflicts only happen when the changes overlap. 


## What it looks like:


- When a conflict happens, Git marks the problem spot inside the file with some odd-looking symbols, something like this:

```
<<<<<<< yours
3 eggs
=======
2 eggs and a splash of milk
>>>>>>> theirs
```

- The top part is your version and the bottom part is the other person's. The lines of <<<, ===, and >>> are just signposts showing where each version starts and ends.


## How to fix it: 

- Cat the file that has the merge conflict. 
- Need to get rid of that conflict somehow:

  - Keep your version and delete the other.
  - Keep the other version and delete yours.
  - Keep both versions and delete the excess merge conflict lines. 

