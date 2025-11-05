# Chapter 14: Tricky Techniques
The 8080 is a stack-oriented minicomputer with a wide set of instructions.

## `TWOCR:`, a One-Line Subroutine
* Some console messages should have a blank line separating them from the rest of the text.
* `TWOCR:` simply calls `CCRLF` again, producing another newline.
* This program does not have a return, simply have `CCRLF` return for it.

## `SPMSG:` Displays in-line Messages
* In chapter 13 we had a way to display our sign on message that was highly inefficient, requiring us to load a register with the start address before calling its subroutine.
* `SPMSG:` is a better way to display these. To write, do this:

```
Call SPMSG
DB   'Message text for console', 0
```

* This will output the text and return to the later instructions after the zero byte terminator.
* The text is terminated by a zero so `SPMSG:` knows when to quit printing and go back to instructions.

## `GETYN:` Interrogates the Operator
* Creates a prompt of ```(Y/N)?``` and waits for a response of "y" or "n" (case does not matter) or CTRL C.
* Uses buffered console input for responses, but only looks for first character, meaning that anything starting with a "y" or "n" works as the corresponding response.
* If no correct response is given, the operator is resent the prompt.
* If the answer is yes, `GETYN:` sends the zero flag.
* If no, the zero flag will not be set.

## How `SPMSG:` Works
* The displayed test is located in a buffer, where each separate character is fetched, tests if it is zero, and outputs it through `CO:` it is not zero.
* The start address of `SPMSG:` text is located at the return address of `COMSG:`
* To move the text to the HL register, we use ```XTHL```, which simply switches the top of the stack with the HL register.
* To get the character from memory, we will use XOR, which in the 8080 is ```XRA```.
- `ADD M` loads a character and sets the zero flag if it is 0.
- The routine increments HL, swaps back with `XTHL`, then returns if the zero flag is set (which is the end of the message). 
    - If not zero it outputs the character and repeats the process

## How `GETYN:` Works
- `LDA` fetches the first character you typed from memory, so the program can check if it's a `Y` or `N`.
- The program skips the two-byte header of the input buffer to directly access the user's first typed character.
- The 8th bit is then masked off and the bit that flags the difference between ASCII upper and lower case is masked off too.
- If the `Y` compare was true, `C`om`P`are `I`mmediate (`CPI`) sets the zero flag.
- Returning a set zero flag is a signal for a yes answer, so we execute an instruction to clear it if the input is `N`.
