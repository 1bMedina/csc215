LDA 
41
00
MOV A->B
LDA
40
00
XRA B
STA 
42
00
HLT


| Step | Mnemonic           | Bit Pattern  | Hex  |
|------|--------------------|--------------|------|
| 0    | `LDA`              | `00 111 010` | `3A` |
| 1    | Low byte           | `00 100 001` | `41` |
| 2    | High byte          | `00 000 000` | `00` |
| 3    | `MOV B,A` (A to B) | `01 000 111` | `47` |
| 4    | `LDA`              | `00 111 010` | `3A` |
| 5    | Low byte           | `00 100 000` | `40` |
| 6    | High byte          | `00 000 000` | `00` |
| 7    | `XRA B`            | `10 010 000` | `A8` |
| 8    | `STA`              | `00 110 010` | `32` |
| 9    | Low byte           | `00 100 010` | `42` |
| 10   | High byte          | `00 000 000` | `00` |
| 11   | `HLT`              | `01 110 110` | `76` |


### How It Works: 
- First, we **L**oa**D** the **A**ccumulator and assign A with an address then **MOV**ed A to B, now the number that will be XOR-ed is moved into register B
- Next, the number that is being XOR-ed from is loaded into the **A**ccumulator from a second address
- Then, register B is **X**O**R**-ed from the register A
- Finally, the **A**ccumulator is stored (STA) back in memory by the provided address

### More About XRA:



## Read More About SUB

[XRA](https://ubuntourist.codeberg.page/Altair-8800/part-4.html#xra)
