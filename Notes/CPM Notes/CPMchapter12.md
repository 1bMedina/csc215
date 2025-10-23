# CP/M Chapter 12 

## Program Building Blocks
- Each block should perform a single function. 
- Breaking a program down into blocks simplifies the programming effort.
- In assembly language programming, each block should be a subroutine of the main program
    - Ideally calling each subroutine until the job is completed
- The stack makes all of this possible
    - Each successive `CALL` results in another return address pushed onto the stack
    - Nesting of subroutines is handled by the stack
- "The main program calls subroutines that call other subroutines that handle data transfers to and from I/O devices using the BDOS call at location 5."
- The only limit to subroutines is the depth of the stack of space created by the user
- All communication with the outside world should be handled by the CP/M BDOS call at location 5
    - CPMIO subroutines fulfill this dual function
        - Each provides access to one I/O device at a time

## `CI:`, `CO:`, and a test program
- `AN`d `I`mmediate value with accumulator: an instruction that is one of the logical operations performed in the 8080 ALU
    - `ANI` masking should always be performed when receiving an ASCII character from any input device
        - The 8th bit in a valid ASCII character is used as a parity bit
            - Tests for errors in transmission of the character
    - The masking is produced by `AND`ing the character with `7F`
- `C`om`P`are `I`mmediate compares the current contents of the accumulator with the contents of the memory location immediately following the opcode

## Even more ED
- `3L` - skip ahead 3 `L`ines
    - add `-` to move back
- `K` - kill lines

| Keystroke(s)          | Resulting Action                                                              |
|-----------------------|-------------------------------------------------------------------------------|
| I                     | Append complete file onto editor buffer<br>Enter insert mode                  |
| CTRL Z                | Exit insert mode                                                              |
| B                     | Point to beginning of editor buffer                                           |
| -B                    | Point to end of editor buffer                                                 |
| V                     | Turn on automatic line numbering                                              |
| -V                    | Turn off automatic line numbering                                             |
| E                     | Write editor buffer to disk and exit                                          |
| Q                     | Exit ED without writing buffer to disk                                        |
| ±nL                   | Move back (–) or ahead (+) n lines                                            |
| nT                    | Type n lines on console                                                       |
| nK                    | Kill n lines following current pointer                                        |
| Fstring               | Find the first occurrence of "string" following current pointer position      |
| Sold ^Znew ^Z         | Substitute "new" string for "old"                                             |
| CTRL I                | Tab forward to next tab stop (each 8 characters)                              |
| RUBOUT                | Erase and echo last character                                                 |


