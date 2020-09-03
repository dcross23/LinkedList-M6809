# LinkedList-M6809
LinkedList in Motorola 6809 for Linux


## Usage 
To install the necessary commands to compile and execute run (it will install as6809, aslink and m6809-run commands):
```sh
./instalador.sh 
```

To compile and run the program, go to "LinkedListCode" folder and run:
```sh
./execute.sh [-d]
```
This command will compile and run automatically the program. 
With [-d] option, it will execute the program in debug mode.

To clean the folder and just leave the code files after compiling, just run:
```sh
./clean.sh
```


## Helps and tips
- To insert the number of nodes or/and the position of the node to be deleted, you just need to type the number with 3 number format. This is:
`001 instead of 1, 025 instead of 25, ...`. This is because the program can only read one number from the keyboard, so there is a function called 
**leer_decimal** that does the work of reading 3 numbers and interpret them.

- To finish the program, just say **no** to both delete and insert questions. This will be interpreted as you dont want to do anything and the program 
 will exit. Another form of finishing it, is just deleating all the nodes in the list (this was doned before inserting was implemented).