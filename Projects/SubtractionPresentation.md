## Two's Complement program
### By: Blu, Toby, and Dylan

| Step | Mnemonic           | Bit Pattern  | Hex  |
|------|--------------------|--------------|------|
| 0    | `LDA`              | `00 111 010` | `3A` |
| 1    | Low byte           | `10 000 001` | `81` |
| 2    | High byte          | `00 000 000` | `00` |
| 3    | `MOV B,A` (A to B) | `01 000 111` | `47` |
| 4    | `LDA`              | `00 111 010` | `3A` |
| 5    | Low byte           | `10 000 000` | `80` |
| 6    | High byte          | `00 000 000` | `00` |
| 7    | `SUB B`            | `10 010 000` | `90` |
| 8    | `STA`              | `00 110 010` | `32` |
| 9    | Low byte           | `10 000 010` | `82` |
| 10   | High byte          | `00 000 000` | `00` |
| 11   | `HLT`              | `01 110 110` | `76` |

### How It Works: 
- First, we Load the Accumulator and assign A with an address then **MOV**ed A to B, now the number that will be subtracted is moved into register B
- Next, the number that is being subtracted from is loaded into the **A**ccumulator from a second address
- Then, register B is **SUB**tracted from the register A
- Finally, the **A**ccumulator is stored (STA) back in memory by the provided address

## Read More About SUB

[SUB](https://ubuntourist.codeberg.page/Altair-8800/part-4.html#sub)

## About Two's Complement
Two’s complement is one of the most used methods to represent signed integers (zero, negative, positive) on computers. Two’s complement uses the most significant bit to show whether it is positive or negative. Positive numbers are given their non-negative representation 6 is 0110 and 0 is 0000. For negative numbers in two’s complement are represented by taking the bit complement of their magnitude and then adding one which -6 is 1010. Bit complement is each 0 is changed to 1 and each 1 is changed to 0. The magnitude is the absolute value of the number that you want to represent. Since we wanted to represent -6 the magnitude of that would be 6. The representation of a number can be extended to use more bits by adding extra 0s at the beginning for positive numbers, or extra 1s at the beginning for negative numbers. Conversely, you can reduce the number of bits if the leading digits are all 0s (for positive numbers) or 1s (for negative numbers).