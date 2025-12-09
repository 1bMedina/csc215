# CP/M Chapter 15 Notes

## Introduction
- Logical devices are used as mechanism for accessing the physical devices connected to our computers w/o knowing their hardware specifics
    - The same is true for disk access

## Getting to know the FCB
- Instead of passing all the required information in registers, you use a block of RAM known as **File Control Block** (FCB)
    - provides the operating system with the information it has to have a desired file on the disk for read operations
    - also contains a workspace for write operations
- FCB can reside anywhere in RAM
- Several FCB can be used at one time
- **Transient File Control Block** (TFCB)
    - CP/M establishes for us at memory locations 005CH through 007CH
    - Consists of 33 bytes of memory
    - First memory location:
        - Contains the disk drive selection byte
            - If zero, currently selected drive is assumed for the disk access that uses this FCB
    - Second memory location:
        - File name and type
            - 8 bytes, short names padded out
            - 3 byte file type, also padded out
            - Can use wildcard
    - Rest of FCB 
        - Consists of bytes of binary data
            - FCB+12 = extent byte (ex) used in files larger than 16K
            - Record count byte (rc) at FCB+15
            - Next 16 bytes = contains addresses of 1K byte groups of records on the disk
                - binary numbers from zero up to the highest 1K byte block use don the disk
    - All set up and maintained by CP/M
    - OS will do all the work if we enter a command like this when prompted by CCP:
```
B:COPY C:FILENAME.TYP
```
- Will load program named `COPY.COM` from drive `B:` into the TPA, and set up the FCB drive to select byte for `C:`, filename bytes to the filename, and file type bytes to the file type
    - Rest of TFCB will be zeroed out

## How CP/M uses the FCB
- The operating system will allocate disk space in groups consisting of eight records each
- OS handles all computation involved in translating group numbers to the groups starting address at track x sector y

## Creating a disk file
- As each record is written CP/M updates the record counts in rc and cr in the FCB 
- Each group of 8 records written causes another unused 1K bytes of disk space to be allocated to the file until it is closed or all 16K bytes is used
    - If larger CP/M will automatically open an extension file
- Once a file is closed, the first 32 bytes of the FCB are written onto the disk as a directory entry
- If a writes to file overrun the 16K boundary, CP/M will write the filled FCB image into the directory
- Non-contiguous group numbers are evidence that this disk had files erased in the past

## SHOFN: displays the TFCB file name
- Source code should be kept in their own `.LIB` files because they are disk-oriented
- `SHOFN:` a subroutine to display the drive, file name, file type fields from the TFCB
    - Begins by saving the contents of the BC and HL register pairs
        - Only affects the accumulator
    - Will be using `COMSG:` to display information
    - Absolute memory address is referenced in 2 ways:
        - By the load and store instructions LDA and STA
        - By setting up an index pointing to the desired memory location
    - Using an index register is more efficient when referencing a string of memory addresses

## Breaking up with ED

| Source Listing           | File Name     | Contents                                           |
|--------------------------|---------------|-----------------------------------------------------|
| (Part of CPMIO.ASM)      | IOEQU.LIB     | Data and address value assignments for nondisk programs. |
| 15-2                     | DISKEQU.LIB   | Data and address value assignments for disk programs. |
| 18-1                     | COPY.LIB      | COPY main program.                                 |
| 16-1                     | GET.LIB       | GET: a file from disk subroutine.                  |
| 17-1                     | PUT.LIB       | PUT: a file onto disk subroutine.                  |
| 15-1                     | SHOFN.LIB     | Show file name subroutine.                         |
| 16-2                     | DISKSU.LIB    | Disk subroutines, miscellaneous.                   |
| (Part of CPMIO.ASM)      | CPMIO.LIB     | Input/output subroutines.                          |
| 16-3                     | RAM.LIB       | Memory area assignments.                           |

- Create `.LIB` files to break down bigger code such as `CPMIO.ASM`
- `IOEQU.LIB` = ASCII characters not including `ORG TPA`

## Merging files with PIP
- Merge `.LIB` files using:
```
PIP TESTC15.ASM=DISKEQU.LIB,TESTC15.LIB,SHOFN.LIB,CPMIO.LIB
```

- This is another way to merge files w/o ED

## Testing `SHOFN:`
- TPA entry contains a jump to START: and the space between the jump and START: is used for storage and stack space
- Adding a SP will only work if your program never disturbs CP/M as loaded into your computer memory
