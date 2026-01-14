#include <stdio.h>
#include "BIGINT.H"

void set_bigint(numstr, num)
char *numstr;
struct bigint *num;
{
    char last_pos, i;
    num->negative = (numstr[0] == '-');
    num->numdigits = strlen(numstr) - num->negative;
    num->digits = alloc(num->numdigits);
    last_pos = num->numdigits + (num->negative ? 0 : -1);

    for (i = 0; i < num->numdigits; i++) {
        num->digits[i] = numstr[last_pos-i];
        /* printf("numstr[%d] is %c\n", last_pos-i, numstr[last_pos-i]); */
    }
}

char* get_bigint(num)
struct bigint *num;
{
   char *numstr;
   char start_pos, i;
   numstr = alloc(num->numdigits + (num->negative ? 2 : 1));
   start_pos = num->negative;
   if (start_pos == 1) numstr[0] = '-';
   for (i = 0; i < num->numdigits; i++) {
       numstr[i+start_pos] = num->digits[num->numdigits-(i+1)];
       /* printf("numstr[%d] is %c\n", i, numstr[i+start_pos]); */
   }
   numstr[num->numdigits+start_pos] = '\0';
   return numstr;
}

void add_bigints(num1, num2, result)
struct bigint *num1;
struct bigint *num2;
struct bigint *result;
{
    char i, carry, a, b, total;
    char largest;
    char trim;
    
    largest = num1->numdigits;
    if (num2->numdigits > largest)
        largest = num2->numdigits;
        
    result->digits = alloc(largest + 1);
    result->negative = 0;
    carry = 0;
    
    for (i = 0; i < largest; i++) {
        if (i < num1->numdigits)
            a = num1->digits[i] - '0';
        else
            a = 0;
            
        if (i < num2->numdigits)
            b = num2->digits[i] - '0';
        else
            b = 0;
        
        total = a + b + carry;
        carry = total / 10;
        result->digits[i] = (total % 10) + '0';
    }
    
    if (carry) {
        result->digits[largest] = carry + '0';
        result->numdigits = largest + 1;
    } else {
        result->numdigits = largest;
    }
    
    trim = 0;
    for (i = result->numdigits - 1; i > 0; i--) {
        if (result->digits[i] == '0')
            trim++;
        else
            break;
    }
    
    result->numdigits -= trim;
}


int cmp_bigi(a, b)
struct bigint *a;
struct bigint *b;
{
    char i;

    if (a->numdigits > b->numdigits)
        return 1;
    if (a->numdigits < b->numdigits)
        return -1;

    for (i = a->numdigits - 1; i >= 0; i--) {
        if (a->digits[i] > b->digits[i])
            return 1;
        if (a->digits[i] < b->digits[i])
            return -1;
    }

    return 0; 
}


void sub_bigints(num1, num2, result)
struct bigint *num1;
struct bigint *num2;
struct bigint *result;
{
    struct bigint *a, *b;
    char i, borrow, total;
    char trim;


    if (cmp_bigi(num1, num2) >= 0) {
        a = num1;
        b = num2;
        result->negative = 0;
    } else {
        a = num2;
        b = num1;
        result->negative = 1;
    }

    result->digits = alloc(a->numdigits);
    borrow = 0;

    for (i = 0; i < a->numdigits; i++) {
        total = (a->digits[i] - '0') - borrow;
        if (i < b->numdigits)
            total -= (b->digits[i] - '0');

        if (total < 0) {
            total += 10;
            borrow = 1;
        } else {
            borrow = 0;
        }

        result->digits[i] = total + '0';
    }


    trim = 0;
    for (i = a->numdigits - 1; i > 0; i--) {
        if (result->digits[i] == '0')
            trim++;
        else
            break;
    }
    result->numdigits = a->numdigits - trim;
}
