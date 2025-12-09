I   ; ASCII CHARACTERS
I   CR      EQU     0DH
I   LF      EQU     0AH
I   CTRLZ   EQU     1AH
I   
I   ; CP/M BDOS FUNCTIONS
I   RCONF   EQU     1
I   WCONF   EQU     2
I   RBUFF   EQU     10
I   
I   ; CP/M ADDRESSES
I   RBOOT   EQU     0
I   BDOS    EQU     5
I   TPA     EQU     100H
I   
I           ORG     TPA
I   
I   START:  LXI     SP,STAK
I   
I   ; MAIN PROGRAM - MULTIPLY TWO SINGLE-DIGIT NUMBERS
I   MAIN:   CALL    TWOCR           ; DOUBLE SPACE
I           CALL    SPMSG
I           DB      'MULTIPLY 2 Single-Digit Numbers',0
I           CALL    TWOCR
I   
I           ; GET FIRST DIGIT
I           CALL    SPMSG
I           DB      'ENTER FIRST DIGIT (0-9): ',0
I           CALL    GETNUM          ; GET NUMBER INTO HL (0–9)
I           SHLD    NUM1            ; SAVE FIRST NUMBER
I   
I           ; GET SECOND DIGIT
I           CALL    SPMSG
I           DB      'ENTER SECOND DIGIT (0-9): ',0
I           CALL    GETNUM          ; GET NUMBER INTO HL (0–9)
I           SHLD    NUM2            ; SAVE SECOND NUMBER
I   
I           ; MULTIPLY THE NUMBERS (HL = NUM1 * NUM2)
I           LHLD    NUM1            ; HL = first number
I           XCHG                    ; DE = first number
I           LHLD    NUM2            ; HL = second number
I           MOV     B,L             ; B = second number (0–9)
I           LXI     H,0             ; HL = 0 (accumulator)
I   
I   MULLP:  MOV     A,B
I           ORA     A
I           JZ      MULEND          ; if B == 0, done
I           DAD     D               ; HL = HL + DE
I           DCR     B               ; B--
I           JMP     MULLP
I   
I   MULEND: SHLD    RESULT          ; save product in RESULT
I   
I           ; DISPLAY RESULT
I           CALL    CCRLF
I           CALL    SPMSG
I           DB      'PRODUCT: ',0
I           LHLD    RESULT
I           CALL    PRTNUM          ; PRINT THE NUMBER
I   
I           ; ASK TO CONTINUE
I           CALL    CCRLF
I           CALL    SPMSG
I           DB      'AGAIN?',0
I           CALL    GETYN
I           JZ      MAIN            ; IF YES, DO ANOTHER
I   
I           ; EXIT TO CP/M
I           JMP     RBOOT
I   
I   ; GET A DECIMAL NUMBER FROM CONSOLE (0-999)
I   ; RETURNS VALUE IN HL
I   GETNUM: CALL    CIMSG           ; GET INPUT LINE
I           CALL    CCRLF
I           LXI     H,INBUF+2       ; POINT TO FIRST CHARACTER
I           LXI     D,0             ; CLEAR RESULT IN DE
I   
I   GNUM1:  MOV     A,M             ; GET CHARACTER
I           ORA     A               ; CHECK FOR END
I           JZ      GNUM2           ; DONE IF ZERO
I           CPI     '0'             ; CHECK IF DIGIT
I           JC      GNUM1X          ; SKIP IF NOT
I           CPI     '9'+1
I           JNC     GNUM1X          ; SKIP IF NOT
I   
I           ; MULTIPLY DE BY 10
I           PUSH    H               ; SAVE POINTER
I           PUSH    D               ; SAVE CURRENT RESULT
I           MOV     H,D             ; COPY DE TO HL
I           MOV     L,E
I           DAD     H               ; HL = DE * 2
I           DAD     H               ; HL = DE * 4
I           POP     D               ; RESTORE ORIGINAL DE
I           PUSH    D               ; SAVE IT AGAIN
I           DAD     D               ; HL = DE * 5
I           DAD     H               ; HL = DE * 10
I           POP     D               ; CLEAN UP STACK
I           XCHG                    ; RESULT TO DE
I   
I           ; ADD DIGIT TO RESULT
I           POP     H               ; RESTORE POINTER
I           MOV     A,M             ; GET DIGIT CHARACTER
I           SUI     '0'             ; CONVERT TO BINARY
I           ADD     E               ; ADD TO LOW BYTE
I           MOV     E,A
I           MVI     A,0
I           ADC     D               ; ADD CARRY TO HIGH BYTE
I           MOV     D,A
I   
I   GNUM1X: INX     H               ; NEXT CHARACTER
I           JMP     GNUM1
I   
I   GNUM2:  XCHG                    ; RESULT TO HL
I           RET
I   
I   ; PRINT NUMBER FROM HL (0–999)
I   PRTNUM: LXI     D,NUMBUF+5      ; POINT TO END OF BUFFER
I           MVI     B,0             ; DIGIT COUNTER
I   
I   PRTN1:  LXI     D,10            ; DIVISOR
I           CALL    DIVIDE          ; HL / 10, A = remainder
I           ADI     '0'             ; CONVERT REMAINDER TO ASCII
I           PUSH    PSW             ; SAVE DIGIT ON STACK
I           INR     B               ; COUNT DIGITS
I           MOV     A,H             ; CHECK IF QUOTIENT IS ZERO
I           ORA     L
I           JNZ     PRTN1           ; CONTINUE IF NOT ZERO
I   
I   PRTN2:  POP     PSW             ; GET DIGIT
I           CALL    CO              ; PRINT IT
I           DCR     B               ; COUNT DOWN
I           JNZ     PRTN2
I           RET
I   
I   ; DIVIDE HL BY 10, RESULT IN HL, REMAINDER IN A
I   DIVIDE: PUSH    B
I           PUSH    D
I           LXI     B,0             ; BC WILL HOLD RESULT
I           LXI     D,10            ; DIVISOR = 10
I   DIV1:   MOV     A,H             ; CHECK HIGH BYTE
I           ORA     A
I           JNZ     DIV2
I           MOV     A,L             ; IF H == 0, CHECK L
I           CMP     E               ; COMPARE L WITH 10
I           JC      DIV3            ; IF L < 10, DONE
I   DIV2:   MOV     A,L             ; SUBTRACT 10 FROM L
I           SUB     E
I           MOV     L,A
I           MOV     A,H
I           SBB     D
I           MOV     H,A
I           INX     B               ; INCREMENT QUOTIENT
I           JMP     DIV1
I   DIV3:   MOV     A,L             ; REMAINDER IN A
I           MOV     H,B             ; QUOTIENT HIGH BYTE
I           MOV     L,C             ; QUOTIENT LOW BYTE
I           POP     D
I           POP     B
I           RET
I   
I   ; STORAGE FOR NUMBERS
I   NUM1:   DW      0
I   NUM2:   DW      0
I   RESULT: DW      0
I   NUMBUF: DS      6
I   
I   ; CP/M I/O LIBRARY FUNCTIONS
I   
I   ; CONSOLE CHARACTER INTO REGISTER A MASKED TO 7 BITS
I   CI:     PUSH    B               ; SAVE REGISTERS
I           PUSH    D
I           PUSH    H
I           MVI     C,RCONF         ; READ FUNCTION
I           CALL    BDOS
I           ANI     7FH             ; MASK TO 7 BITS
I           POP     H               ; RESTORE REGISTERS
I           POP     D
I           POP     B
I           RET
I   
I   ; CHARACTER IN REGISTER A OUTPUT TO CONSOLE
I   CO:     PUSH    B               ; SAVE REGISTERS
I           PUSH    D
I           PUSH    H
I           MVI     C,WCONF         ; SELECT FUNCTION
I           MOV     E,A             ; CHARACTER TO E
I           CALL    BDOS            ; OUTPUT BY CP/M
I           POP     H               ; RESTORE REGISTERS
I           POP     D
I           POP     B
I           RET
I   
I   ; CARRIAGE RETURN, LINE FEED TO CONSOLE
I   TWOCR:  CALL    CCRLF           ; DOUBLE SPACE LINES
I   CCRLF:  MVI     A,CR
I           CALL    CO
I           MVI     A,LF
I           JMP     CO
I   
I   ; MESSAGE POINTED TO BY HL OUT TO CONSOLE
I   COMSG:  MOV     A,M             ; GET A CHARACTER
I           ORA     A               ; ZERO IS THE TERMINATOR
I           RZ                      ; RETURN ON ZERO
I           CALL    CO              ; ELSE OUTPUT THE CHARACTER
I           INX     H               ; POINT TO THE NEXT ONE
I           JMP     COMSG           ; AND CONTINUE
I   
I   ; MESSAGE POINTED TO BY STACK OUT TO CONSOLE
I   SPMSG:  XTHL                    ; GET "RETURN ADDRESS" TO HL
I           XRA     A               ; CLEAR FLAGS AND ACCUMULATOR
I           ADD     M               ; GET ONE MESSAGE CHARACTER
I           INX     H               ; POINT TO NEXT
I           XTHL                    ; RESTORE STACK FOR
I           RZ                      ; RETURN IF DONE
I           CALL    CO              ; ELSE DISPLAY CHARACTER
I           JMP     SPMSG           ; AND DO ANOTHER
I   
I   ; INPUT CONSOLE MESSAGE INTO BUFFER
I   CIMSG:  PUSH    B               ; SAVE REGISTERS
I           PUSH    D
I           PUSH    H
I           LXI     H,INBUF+1       ; ZERO CHARACTER COUNTER
I           MVI     M,0
I           DCX     H               ; SET MAXIMUM LINE LENGTH
I           MVI     M,80
I           XCHG                    ; INBUF POINTER TO DE REGISTERS
I           MVI     C,RBUFF         ; SET UP READ BUFFER FUNCTION
I           CALL    BDOS            ; INPUT A LINE
I           LXI     H,INBUF+1       ; GET CHARACTER COUNTER
I           MOV     E,M             ; INTO LSB OF DE REGISTER PAIR
I           MVI     D,0             ; ZERO MSB
I           DAD     D               ; ADD LENGTH TO START
I           INX     H               ; PLUS ONE POINTS TO END
I           MVI     M,0             ; INSERT TERMINATOR AT END
I           POP     H               ; RESTORE ALL REGISTERS
I           POP     D
I           POP     B
I           RET
I   
I   ; GET YES OR NO FROM CONSOLE
I   GETYN:  CALL    SPMSG
I           DB      ' (Y/N)?: ',0
I           CALL    CIMSG           ; GET INPUT LINE
I           CALL    CCRLF           ; ECHO CARRIAGE RETURN
I           LDA     INBUF+2         ; FIRST CHARACTER ONLY
I           ANI     01011111B       ; CONVERT LOWER CASE TO UPPER
I           CPI     'Y'             ; RETURN WITH ZERO = YES
I           RZ
I           CPI     'N'             ; NON-ZERO = NO
I           JNZ     GETYN           ; ELSE TRY AGAIN
I           CPI     0               ; RESET ZERO FLAG
I           RET                     ; AND ALL DONE
I   
I   INBUF:  DS      83              ; LINE INPUT BUFFER
I   
I   ; SET UP STACK SPACE
I           DS      64              ; 40H LOCATIONS
I   STAK:   DB      0               ; TOP OF STACK
I   
I           END     START
