# CP/M Chapter 10
- There needs to be a separation between the user environment and the operating system
- There is the use of subroutines which pass data or requests between the user program and the operating system
    - These are also used to protect the registers
- The separation improves **portability** and **reliability**

## Establishing the user's stack
- **What is the stack?**
    - A reserved area in RAM used for temporary data storage
    - Required for `CALL` and `RET` instructions (*subroutine handling*)
- **Why does it need to be set up manually?**
    - The stack grows **downward in memory**
    - We must **reserve** RAM space and point SP (stack pointer) to the **top** of that space

- **Setting up the stack**
    - All programs must do this at the end of each program:
```
        DS  64  ;STACK AREA
STAK:   DB  0   ;TOP OF STACK
```
and this line at the beginning of the program to load the address assigned to `STAK:` into SP:
```
START: LXI  SP,STAK ;SET UP STACK POINTER
```
- **Key notes**:
    - `DS` = `D`efine `S`torage → reserves memory (pseudo-op: not executed)
    - `DB` = `D`efine `B`yte → defines a single byte (pseudo-op: not executed)
        - These do not produce executable machine code, they are just a memory layout

## Saving the user's register contents
- Calling the operating system may overwrite CPU registers
- To protect the user program, we have to save all important registers before calling the OS using this I/O subroutine:
```
CO:     PUSH    B       ; SAVE REGISTERS
        PUSH    D
        PUSH    H
        .       .
        .       .
``` 
- Uses **3 bytes** of code, and **6 bytes** of stack **per call**
- After returning from `BDOS`, we restore the registers in reverse with this subroutine:
    - **the last in (H) must be the first out**
```
        .       .
        .       .
        POP     H       ; RESTORE REGISTERS
        POP     D
        POP     B
        RET 
```
- `POP`s are a mirror image of the `PUSH`es: *Last pushed = first restored*

## Calling `BDOS`
- `BDOS` expects data in **specific registers** which may not be the same as our user code
- **Example:** If a user loaded an ASCII char into register `A` → `BDOS` wants: 
    - Function code in `C`
    - Character in `E`
```
        .       .
        .       .
        MVI     C, WCONF        ; SELECT FUNCTION
        MOV     E, A            ; CHAR TO E
        CALL    BDOS
        .       .
        .       .
```
- `MVI  C,  WCONF`
    - Loads a function into register C
- `MOV  E,  A`
    - Moves the contents of **register A** into **register E**
- `CALL BDOS`
    - Jump into the operating systems code to execute requested function

## Return to CP/M
- Using interface subroutines keeps code portable to other operating systems
- Always end with `JMP 0` to safely reboot CP/M instead of manually resetting
