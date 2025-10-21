# CP/M Chapter 10 

## Preserving the User's Environment
- It is best to provide separation of the two environments, and establishes an interface between the two worlds
   - An interface which data will be passed, using subroutines that can be called from any place in the users programs

## Establishing the user's stack
- the stack: a memory area set aside as a handy place to stuff data
    - Necessary for calling and returning subroutines
- Data pushed into the stack grows downward in memory from the initial address contained in the stack pointer (SP)
    - Must set aside a block of memory exclusive for the stack use
        - Must set SP to point to the top of it
- Setting up the user stack:
    - Need to know here some RAM memory space if available
        - User programs execute within the TPA, the TPA is in RAM
    - Write programs that will be burned into PROM
    - Remember to set up the initial address in the SP to point to the top of some unused RAM
        - Save a block of RAM for the use of the stack 
            - Set the stack pointer initially to point to the top of that area
- The stack area should start at 64 bytes
    - Could execute 32 successive `PUSH`es of register contents or nest 32 levels of subroutine `CALL`s
- Include these two lines of code at the end of each program to set up a stack area:
```
        DS  64  ;STACK AREA
STAK:   DB  0   ;TOP OF STACK
```
- `DS`: mnemonic for `D`efine `S`torage
    - Sets aside a block of memory equal in size to the specified operand
- `DB`: stands for `D`efine `B`yte
    - Sets up a single-byte memory location with initial contents as specified by the operand
- **Note**: one operand specifies the size of block of memory (`DS`) and the other specifies the initial contents of a single location (`DB`)
- `DS` and `DB` are pseudo-ops
    - They tell the assembler how to set up memory areas but do not produce any object code that can be executed
- Initial contents of stack don't matter because we have to push something in to get anything meaningful out
- The address assigned to `STAK:` at assembly time will be loaded into SP at the very beginning of the program:
```
START: LXI  SP,STAK ;SET UP STACK POINTER
```
- Must remember to `LXI ` the SP at the start of all programs and set aside a space large enough for all the pushing and calling that will happen

## Saving the user's register contents
- All registers other than the accumulator will be saved and restored each time data is passed through the suer/system window
- We have to write a series of I/O subroutines that start off by saving the contents of  `B`, `C`, `D`,`E`, `H`, and `L` on the stack:
```
CO:     PUSH    B       ; SAVE REGISTERS
        PUSH    D
        PUSH    H
        .       .
        .       .
``` 
- Only requires 3 bytes of program space and 6 bytes of stack space
- Doesn't matter if the system disturbs the registers, because on return from `BDOS` we store the registers:
```
        .       .
        .       .
        POP     H       ; RESTORE REGISTERS
        POP     D
        POP     B
        RET 
```
- `POP`s are a mirror image of the `PUSH`es
- The last in (`H`) must be the first out

## Calling `BDOS`
- Assuming that the user program loaded an ASCII character into A
    - `BDOS` wants the character to be in E when `BDOS` is called
    - Function code (`WCONF`) wants the character to be in C
```
        .       .
        .       .
        MVI     C, WCONF        ; SELECT FUNCTION
        MOV     E, A            ; CHAR TO E
        CALL    BDOS
        .       .
        .       .
```
