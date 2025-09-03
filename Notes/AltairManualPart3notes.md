# Altair Manual Notes - Part Three

## Front Panel Switches and LEDs

- **ON-OFF** Switch
    - ON applies power to the computer
    - OFF cuts off power and erases the contents of the memory
- **STOP-RUN** Switch
    - STOP stops program execution
    - RUN implements program execution
- **SINGLE STEP** Switch
    - implements a single machine language instruction eacg time it is actuated
        -  a single machine language instruction may require as many as 5 machine cycles
- **EXAMINE-EXAMINE NEXT** Switch
    - EXAMINE displays the contents of any specified memory to address previously loaded into the DATA/ADDRESS Switches on the 9 data LEDs
    - EXAMINE NEXT is actuated, the contents of the next sequential memory address are displayed
- **DEPOSIT-DEPOSIT NEXT** Switch
    - DEPOSIT causes the data byte loaded into the 8 DATA Switches to be loaded into the memory address which has been previously designated
    - DEPOSIT NEXT loads the data byte loaded into the 8 DATA Switches into the next sequential memory address
        - Each time the switch is actuated, the data byte loaded into the 8 DATA Switches is loaded into the next sequential memory address
- **RESET-CLR** Switch
    - RESET sets the Program Counter to the first memory address ($0 000 000 000 000 000$)
        - Provides a rapid and efficient way to get back to the first step of a program which begins at the first memory address
    - CLR is a CLEAR command for external input/output equipment 
- **PROTECT-UNPROTECT** Switch
    - PROTECT prevents memory contents form being changed 
    - UNPROTECT permits the contents of the memory to be altered
- **AUX** Switches
    - used in conjunction with peripherals added to the basic machine
        - Altair 8800 includes two auxiliary switches which are not yet connected to the computer
- **DATA/ADDRESS** Switches 
    - DATA are those designated 7-0
    - ADDRESS are those designated 15-0
        - Switches designated 8-15 are not used and should be set to 0 when an address is being entered
    - A switch whose position is UP denotes a 1 bit
     - A switch whose position is DOWN denotes a 0 bit

<br>

#### Indicator LEDs

| LED | DEF |
|-----|-----|
| ADDRESS | A15-A0 - The bit pattern shown denotes the memory address being examined or loaded with data |
| DATA | D7-D0 - The bit pattern denotes the data ine the specified memory address |
| INTE | An INTERRUPT has been enabled when this LED is glowing |
| PROT | The mormory is PROTECTED when this is glowing |
| WAIT | The CPU is in a WAIT state when this is glowing |
| HLDA | A HOLD has been acknowledged when this is glowing |

#### Status LEDs

| LED | DEF |
|-----|-----|
| MEMR | The memory bus will be used for memory read data |
| INP | The address bus containing the address of an input device - the input data should be placed on the data bus when the data bus is in the input mode |
| M1 | The CPU is processing the first machine cycle of an instruction |
| OUT | The address contains the address of an output device and the data bus will contain the output data when the CPU is ready |
| HLTA | A HALT instruction has been executed and acknowledged |
| STACK |  The address bus holds the Stack Pointer's push-down stack address |
| WO | Operation in the current machine cycle will be a WRITE memory or OUTPUT function. Otherwise, a READ memory or INPUT operation will occur |
| INT | An INTERRUPT request has been acknowledged |

## Loading a Sample Program 
- ``LDA`` - Load the accumulator with the contents of a specified memory address
- ``MOV`` (A $\rightarrow$ B) - Move the contents of the accumulator into register B
- ``ADD`` (A $+$ B) - Add the contents of register B to the contents of the accumulator and store the results in the accumulator 
- ``STA`` - Store the contents of the accumulator in a specified memory address
- ``JMP`` - Jump to the first step in the program

<br>

- The computer is instructed **exactly** how to solve the problem and where to place the result
- Each of these machine language instructions require a single byte bit pattern to implement the basic instruction
    - ``LDA`` and ``STA`` require two additional bytes to provide the necessary memory addresses
- The individual bit patterns of a machine language program are sequentially numbered to reduce the chance for error when entering them into the computer

## Using The Memory
- Machine language operation requires the programmer to keep track of the memory
    - otherwise valuable data or program instructions may be deleted or replaced
- Memory mapping assigns various types of data to certain blocks of memory reserved for a specific purpose 
    - Effectively organizes the available memory into an efficient and readily accessible storage medium
    - Main purpose is to provide a cohesive organization of the available memory

## Memory Addressing
- Machine language instruction set for the Altai provides several methods for addressing memory
    - **Direct Addressing**: The instruction supplies the specified memory address in the form of two bytes immediately following the actual instruction byte
    - **Register Pair Addressin**g: Can contain a memory address. The ``H`` and ``L`` registers must be used for this purpose in most instructions
        - The ``H`` register contains the most significant 8 bits
        - The ``L`` register contains the least significant 8 bits
        - Two instructions (`STAX` and `LDAX`) permit the `B` and `C` or `D` and `E` register pairs to contain memory addresses
    - **Stack Pointer Addressing**: Two stack operations `PUSH` and `POP`
        - PUSHing data onto the stack causes two bytes of data to be stored in a special block of memory reserved by the programmer and called the stack
        - POPing data from rhe stack causes this data to be retrieved
        - The programmer must reserve the stack location in memory by loading a memory address into the Stack Pointer
            - This is accomplished by the means of the `LXI` instructions
    - **Immediate Addressing**: Immediate instructions contain data which is loaded into memory during program loading
        - The data is stored in the block of memory reserved for programming by the operator
    - **Stack Addressing of Subroutines**: When a subroutine is CALLed by a program, the address of the next sequential instruction in the main program is automatically saved and by being PUSHed onto the stack.
        - When the subroutine has been executed, a RETURN instruction POPs the address from the stack and the main program continues execution

## Operating Hints
- Always proofread a program after it has been entered into the computer
    - Done by returning to the first address in memory at which the program begins
- `NOP` = an instruction which specifies "No Operation" 
    - Scattering `NOP` instructions throughout a complicated program, considerable time can be saved if a program error requiring the addition of a new step of steps if found
- Debugging will be necessary occasionally
    - Debugging can be enhanced by use of the SINGLE STEP switch

