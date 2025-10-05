# CPM Chapter 3-4

## Chapter 3
### Logical Names and Physical Entities
- CP/M distinguishes between logical device names (software identifiers) and physical devices (actual hardware)
- Examples: 
    - CRT: implies a physical device
        - Terminal with keyboard attached
    - CON: logical device for the operator's console
        - Mapped to CRT:
- There are only 3 other physical devices attached to the computer:
    - LTP: Line printer
    - two disk drives numbered 0 and 1 in the Intel MDS tradition 
        - Mapped logically to A: and B:
- Logical and physical device mapping
    - Disk drive logical names map one-to-one with physical names in our minimum system
    - I/O devices: multiple physical devices may map to one logical name
- Four main logical I/O devices: CON:, LST:, RDR:, PUN:
- CON: is the only bi-directional logical device

### Selecting I/O Devices
- CP/M uses the one-byte memory location IOBYT to select physical devices for each logical device
- Logical Devices: 
    - CON: Console (bi-directional)
    - RDR: Reader (ex: paper tape reader, modem)
    - PUN: Punch (ex: paper tape punch, modem)
    - LST: List device (line printer, from LPT)
- IOBYT acts like software switches, not physical ones
- A device like a modem needs correct IOBYT settings for both RDR: and PUN:
- In a minimum system, IOBYT is fixed: CON: → CRT: and LAST: → LPT:

## Chapter 4
### What the Operating System Provides
- Hardware services are obvious, services provided by software are less obvious
- CP/M mediates access between hardware and software (like floppy disk and monitor program)
- Users interact with the CP/M through **built-in** and **transient commands** provided by CP/M
- Functions include:
    - Creating disk files
    - Deleting disk files
    - Renaming disk files
    - Copying disk files

### Named File Handling
- A file can contain just about any sort of information, right or wrong
    - Contents can be identified by a label
- The file name in a CP/M system has a few constraints
    - CP/M allows each file name to be up to **eight characters** in length
    - A file type of three characters is appended to the name, following a period
    - The general form is name/type represented by `FILENAME.TYP`
- **Standard File Types**: 
    - `.COM` → Binary Program Image (Command)
    - `.ASM` → Assembly Language Source Program
    - `.HEX` → Assembler Program Output (Hexadecimal)
    - `.PRN` → Assembler List Output (print)
    - `.BAK` → Editor Input--Saved (Backup)
    - `.$$$` → Temporary Scratch File 
    - `.SUB` → Submit Command File
    - `.BAS` → BASIC Language Program
    - `.INT` → BASIC Compiled Program (intermediate)
    - `.FOR` → Fortran Source
    - `.MAC` → Macro Assembler Source Program
    - `.REL` → Relocatable Compiler Output
    - `.DAT` → Data File
- Users can define custom file types
    - Example: `SAVE 0 B:-WORK.001` 
        - Creates an empty file with the name of `-WORK` and "type" of `001` on the disk in drive B

### Wildcards in File Names
-  Enter the command `DIR` to list the contents of the disk in drive A
- The `*` is a wildcard that tells CP/M to accept any FILENAME 
    - Matches any sequences of characters
- The `?` means accept any letter in this character position
    - Any number of `?`'s can be used in a filename in place of letters to help you search the disk directory for sets of files with similar letters
- Examples: 
    - `DIR LIFE????.ASM` → Lists all .ASM files that start with LIFE in the first 4 characters
    - `DIR *.COM` → List all files of type `.COM`
    - `DIR L*.ASM` Lists all .ASM files starting with L
    - `PIP B:=A:*.*` Copies all the files from drive A: onto the disk in drive B:
        - **PIP**: Peripheral Interchange Program

### Logical Unit Access
- CP/M provides both the console operator and user programs with simplified access to logical units, and thus to the selected physical devices
- Example:
    - `PIP PUN:=FILENAME.TYP` → sends the disk file to the physical device currently attaches as logical device PUN:
- Operators and programs reassign the logical devices

### Line Editing 
- CP/M has a built-in line editing feature
- Editing Commands: 
    - `DEL` / `DELETE` / `BS` / `RUBOUT` keys → deletes last character
    - `CTRL R` → re-displays the command line before terminating it
    - `CTRL U` or `CTRL X` → 'give up' command, cancels entire line and lets you restart
- Line editing controls are available to the programmer and the operator
