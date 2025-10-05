# CPM Chapter 2

### Introduction
- To make sure that the operating system was loaded properly, a simple short loader would first read in a smart loader, that would the load the system. 
    - **Bootstrap**: minimum loader that allowed the system to pull itself up into memory by the bootstraps
- Semiconductor memory rapidly replaced the core memory 
    - The semiconductor RAM loses its memory when the power goes down
- When EPROMS became available the switches and lights began to disappear
- Software: ROMs contained programs, therefore software
- Firmware: software made harder by being burned into ROM

### Firmware Monitor
- In a CP/M system the low end of main memory address space must contain read-write memory
- There is a microcomputer hardware trick: a bootup circuit that is activated by the same reset signal that starts the CPU
    - The circuit makes the RAM at location zero 'disappear' and substitutes a 'shadow PROM'
    - One or more instructions are fetched from the shadow PROM and executed
    - At some point in the execution sequence, the computer hardware is told to disconnect the shadow PROM and reinstate RAM at location zero
- The first instruction that the CPU fetches from the shadow PROM is an unconditional jump to the beginning of a monitor program in ROM
    - The monitor ROM is usually located at the very top of the main memory address space
- The CPU decodes the jump command and knows to fetch the next instruction from the place it has jumped to 
    - It begins this next instruction by placing the new address on the computers address bus
        - The **address bus** is the set of sixteen signal lines that contain the bit pattern of the address of the next memory location
    - The circuit then disables the shadow PROM and reenables RAM at the bottom of memory
- When the reset switch is hit, the CPU begins to fetch instructions from the monitor PROM
- **DDT: the Dynamic Debugging Tool**
    - Will provide the same functions as the Monitor PROM
- **Peripheral Driver programs**: another feature provided by some monitor programs PROMs
    - Sub-routines that our program can call, providing us with access to all of the system peripherals without having to know any deatils of the systems IOCS
- Some form of loader program is not optional in a monitor PROM

### Operating System 
- CP/M can be adapted to differening hardware enviorments
- There is no standared Input/Output port assignments
    - For instance, to transmit a character from the compter to the console, a driver program must test the status of the output port to which the console is attached, to see if it is ready to accept a character
    - If not, the driver must wait for a not busys signal, once the port annonces it is ready to accept a character, the driver outputs the character to the console output port

### Customizing CP/M
- The user-to-system conventions built into the CP/M are one of the strong points of the operating system
- All disk and I/O accesses are passed through a single entry point into CP/M
- Function codes are passed in one register, the data or buffer address passed in other registers. 
    - This makes it possible to write programs that will run on any computer hardware without modification

### Application programs
- RAM
    - Firmware moniot will take some main memory address spaces
    - The resident portion of CP/M will take up about 6K
    - There are special areas at the bottom of RAM that are used by ther operating system
    - The rest of main memory address space is available for user programs
- CP/M loads programss in RAM in TPA
    - TPA: Transient Program area
    - The TPA begins at a fixed address and includes all available RAM not required by CP/M
    - The operating system has been arranged so that this can be accomplshed without interfering with the disk and I/O access portions of the operating system
- All user programs are refered to as application programs
- In the proccess of editing, assembling, and debugging, application programs we will be using CP/M's editor (ED), assembler (ASM), loader (LOAD), and debugger (DDT)
    - These programs are going to be loaded into the TPA as used
    - They will no reside in memory all at the same time, and only the DDT will share main memory with our programs
- DDT will have to be laoded along with our application programs only until the programs are full operational

### Special Memory Areas
- Down at the lowest adresses in our computer's RAM are loactions dedicated to vectors
    - Vectors are unconditional jump instructions
    - The 8080 family uses 8 memory locations as vectors for hardware interrupts 
- Above the space denoted to vectors, CP/M establishes buffer areas that we will be using when we interface our programs with the operating system
    - these areas all take up only 256 locations at the bottom of RAM and the TPA begins at the next available location
- Another special area within RAM may be dedicated to monitor functions
    - This area will vary from computer to computer
- You will often see a machine running a 46K version of CP/M when 48K of RAM actually exists
    - The other 2K was required for other functions
    