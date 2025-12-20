# Study Questions

## Page 3
#### 1. Suppose you want to add unary operations (i.e., ones requiring only one operand) to the calculator. For example, we might add "M" to indicate unary minus (i.e., change the sign of the old value) and "A" to indicate absolute value. What changes would need to be made to the program?

Create a new operator that works on the stored value and doesn't require the program to read a second operand. 

##### 2. Suppose that words rather than single character symbols are to be used for the operators (e.g., the user types "times" instead of "*"). Where in the program would the necessary changes occur?

The changes would occur where the program reads and interprets the operator input, since it would need to accept strings (rather than single characters) and match them to the corresponding operations. 

##### 3.  Suppose that the calculator is to be converted to use C++ double values rather than integers. Where would changes need to be made?

You would need to change the input variable to be able to take in a double, essentially just declaring the input variable as a double. 

#### 4. Most modern systems support graphical displays and mouse (or other pointer) input. Rewrite the Calculator program to take advantage of these features to produce an on-screen push-button calculator (this is a large programming project).
**erm no**

#### 5. Show how a new command, "C", which acts like the "Clear" command on a calculator could be implemented. The clear command sets the current value to zero.
```
if (op == 'C') {
    value = 0;
}
```

#### 6. (AB only) How could the calculator be modified to allow the use of parentheses to control the order of operations?

The program would be modified to parse the input to recognize parentheses, evaluating the expression inside the parenthesis first and replace them with their result before continuing the remaining operations.

## Page 6
#### 1. What are the largest and smallest integer values in the programming environment you use?
The largest integer value is 32767 and the smallest integer value is -32767

#### 2. Each BigInt object will need to store the digits that represent the BigInt value. The decision to allow arbitrarily large BigInt values affects the choices for storing digits. Name one method for storing digits that will permit an arbitrary number of digits to be stored. What effect would a limit on the number of digits in a BigInt have in the design of the BigInt class?
You could store the digits in a dynamic array or list (like a vector or array list) so it can grow as needed. If there was a fixed digit size, you could use a fixed-size array, but there would need to be overflow checks, and it wouldn't really support very large numbers.

#### 3. Based on your knowledge of pencil-and-paper methods for doing arithmetic, what do you think will be the most difficult arithmetic operation (+, *, !) to implement for the BigInt class? Why?
Multiplication ($*$) would be the hardest. This is because of the amount of carrying and shifting when multiplying every digit in one number with every digit in the other number, this is unlike addition and subtraction which are more straight forward.

#### 4. Experiment with the calculator. If you enter abcd1234 when a number is expected, what happens? If you enter 1234abcd is the behavior different? What happens if you enter an operator that’s not one of the three that are implemented?
Letters before digits is an invalid input, and is turned into a `0`, digits before letters is valid on the other hand. Invalid inputs for the operators are rejected, and the user is re-prompted until a valid one is entered. 

#### 5. List as many operations as you can that are performed on integers, but that are not included in the list of BigInt functions and operators above.
- Modulus
- Bitwise operations
- Increment / Decrement

#### 6. (AB only) What implementation decisions would require providing a destructor, a copy constructor, and an assignment operator?
**I don't know....**

#### 7. Consider the headers for operator! and operator+ given below. Write the body of operator! assuming that operator+ has been written.
```
BigInt operator - (const BigInt & big, int small);
// postcondition: returns big - small
BigInt operator + (const BigInt & big, int small);
// postcondition: returns big + small
```
You can implement the body of `operator!` by repeatedly adding the current result to itself as a way to simulate multiplication. You also need to repeatedly subtract 1 from the operand to count down, relying on the current `operator+` and `operator-`.

## Page 10
#### 1. Consider the error handling provided by your C++ system. What does the system do if a file is not present in a call to open? What happens on integer overflow or divide by zero? Determine which method(s) are used and discuss the relative desirability of other options.
Within the system we use, if a file isn't present than an error will occur when you try to run the code. On the other hand, if it overflows, then it will loop back to zero. Additionally, zero division will also cause an error. 

#### 2. List several errors that might be generated by BigInt operations and develop a declaration for an enumerated type (enum) to hold the errors.
The first error could be a zero-division error, where something is divided by 0, making it undefined. Another error is an overflow error, as mentioned earlier, which happens when the calculator tries to calculate a number that is too large for the alloted storage space. The last error is an invalid digit error which happens when you try to input a data type that is incorrect (such as `a` in this case).

#### 3. Some systems allow error checking to be “turned off” entirely for greater speed. Under what circumstances is this approach preferred?
It may be preferred in situations when you know there will be no chance for error. For instance, if you know there's no chance for a zero-division error or an invalid digit error, or others, than speed would be prioritized. 

#### 4. Consider another method for handling errors: Describe the strengths and weaknesses of this approach.
> Use an interactive error-handling approach. An error message is displayed to the user who then has the option of (a) correcting the value that caused the error, (b) halting the program, or (c) ignoring the error.

Using an interactive error handling could increase the ability to correct simple mistakes, such as accidentally hitting the wrong character, without having a full on fatal error be thrown. Though, this type of error could be dangerous as it could ignore errors that the user can't fix and will break the code. 

#### 5. Consider another method for handling errors: Describe the strengths and weaknesses of this approach.
> Error results are stored in a single global variable. This is set initially to indicate a “no error” condition. Whenever an error is detected, the global variable is set to an appropriate value, and the client program is responsible for examining the value of the global variable.

This is good as it's centralized approach to error handling through the global variable, making it easier to debug. Though, it could cause errors to throw more often within the code, especially as it would be more prone to errors. 


## Page 17
#### 1. Why is a char vector used to store digits rather than an int vector? How will a change in the kind of element stored in the vector affect the implementation of all BigInt member functions.
Each digit is only `0-9`, so a `char` is the most memory efficient data type. It is easier to convert between characters and integers, and changing the digit type would affect all the arithmetic functions, carries, and more. 

#### 2. We have chosen an enum for storing the sign of a BigInt. Describe two alternatives or types other than an enum that can be used to represent the sign of a BigInt.
You could use a `bool` to represent the sign of a BigInt, true as positive and false as negative. You could also use `int` as a way to represent the sign, using `1` as positive and `-1` for negative. 

#### 3. Write the function GetDigit based on the description and declarations in this section. What kinds of error should you worry about?
It should be where the `GetDigit` function returns the digit at the given index. If that index happens to be out of bounds, then it returns 0 (or an error) to prevent invalid memory access. 

#### 4. Why will it be difficult to write the non-member functions operator == and operator < given the current method for accessing digits using GetDigit? Write the function operator == for positive BigInt values assuming that NumDigits and GetDigit are public member functions.

Since the digits can only be accessed one at a time through `GetDigit`, the comparison operators must first check that the numbers have the same length and then compare each digit individually, rather than directly comparing the internal storage. 
