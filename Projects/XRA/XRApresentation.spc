# Exclusive-Or Presentation
# Blu and Anupama
# Instruction: XRA
#
# Outputs true or 1 when the inputs are different (one is false, other is true). 
#
3A # 00 LDA 41      Load B from 0041
41 # 01
00 # 02
47 # 03 MOV B, A    Move A to B
3A # 04 LDA 40      Load A from 0040
40 # 05 
00 # 06 
A8 # 07 XRA B       XOR A with B.
32 # 08 STA 42      Store at 0042
42 # 09 
00 # 0A
76 # 0B HLT         Halt
===
40:06
41:0C
42:00
