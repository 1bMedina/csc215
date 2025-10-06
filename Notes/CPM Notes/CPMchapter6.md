# CP/M Chapter 6

## Interfacing with CP/M
- The system provides a large number of labor saving facilities, and all should be made use in your programs

## The 'giant hook" at location 5
- User transient programs access all of the facilities of CP/M through the BDOS CALL VECTOR that the operating system wrote into location 5
- This is the hook which we hang all our request for I/O and disk access services 
- Each different version and size of CP/M will have the CBIOS vectors starting at a different absolute address
    - Since CP/M knows where its BDOS ENTRY is located in RAM it can set up the location 5 jump instruction to point to itself
- You hang your service request on the giant hook so programs can be run under any version of CP/M on any computer
- Limit use of subset functions to the subset listed in table 6-1

| Label | Code | Function |
|-------|------|----------|
| **I/O Device Functions** | | |
| RCONF | 1 | Read character from console device |
| WCONF | 2 | Write character to console device |
| RRDRF | 3 | Read character from reader device |
| WPUNF | 4 | Write character to punch device |
| WLSTF | 5 | Write character to list device |
| RIOBF | 7 | Read IOBYT from memory location 3 |
| WIOBF | 8 | Write IOBYT to memory location 3 |
| RBUFF | 10 | Read console edited line input |
| CRDYF | 11 | Check console for character ready |
| **Disk Access Functions** | | |
| INITF | 13 | Initialize BDOS, select drive A: |
| DSELF | 14 | Log in and select drive d: |
| OPENF | 15 | Open a file for read or write |
| CLOSF | 16 | Close a file |
| FINDF | 17 | Find a file in the disk directory |
| NEXTF | 18 | Find next occurrence of a file |
| DELEF | 19 | Delete a file |
| READF | 20 | Read one disk record into memory |
| WRITF | 21 | Write one record from memory to disk |
| MAKEF | 22 | Create a disk directory entry |
| SDMAF | 26 | Set RAM buffer address for read or write |

