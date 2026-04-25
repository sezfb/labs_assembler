65536 ( 2^16 ) 8-bit each = 64 kb [ Intel 8080 ]
------------------------------------------------|
SP (Stack Pointer) - 16-bit register only for stack operations (PUSH, POP, CALL, RET).
It holds the address of the top of the stack.
The stack grows downwards in memory, meaning that when you PUSH data onto the stack,
the SP is decremented, and when you POP data from the stack, the SP is incremented.

```
ORG 8000H ( assembly code starts at address 8000h ) - main

8000 : 31    → LXI SP,8010h
8001 : 10    → (частина LXI — low byte 8010h)
8002 : 80    → (частина LXI — high byte 8010h)
* [ 0 byte stack, 8010h stack pointer ]

8003 : CD    → CALL 8100h
8004 : 00    → (частина CALL — low byte 8100h)
8005 : 81    → (частина CALL — high byte 8100h)
- go to subroutine at 8100h + write return address in stack at 8006h after RET
* 800Fh|800Eh(8006h adr)(SP) =  [ 2 byte stack, 800Eh stack pointer ]

8006 : 76    → HLT

ORG 8100H ( assembly code starts at address 8100h ) - subroutine

8100 : F5    → PUSH PSW
* 800Fh|800Eh(8006h adr) + 800D|800C(A + Flags state)(SP) =  [ 4 byte stack, 800Ch stack pointer ]
8101 : C5    → PUSH B ( BC pair )
800D|800C(A + Flags state) + 800B|800A(SP) =  [ 6 byte stack, 800Ah stack pointer ]
8102 : D5    → PUSH D ( DE pair )
... 8009|8008(SP) =  [ 8 byte stack, 8008h stack pointer ]
8103 : E5    → PUSH H ( HL pair )
... 8007|8006(SP) =  [ 10 byte stack, 8006h stack pointer ]
- backup all registers to stack

8104 : 3E    → MVI A,05h
8105 : 05    → (дані для MVI)

8106 : 47    → MOV B,A
8107 : 87    → ADD A ( A + A = 5h + 5h = Ah )
8108 : 5F    → MOV E,A
8109 : 67    → MOV H,A

- stack pop order is reverse of push order
810A : E1    → POP H ( HL pair )
8006|8007(HL pair) =  [ 8 byte stack, 8006h stack pointer ]
810B : D1    → POP D (DE pair )
8008|8009(DE pair) =  [ 6 byte stack, 800Ah stack pointer ]
810C : C1    → POP B (BC pair)
800A|800B(BC pair) =  [ 4 byte stack, 800Ch stack pointer ]
810D : F1    → POP PSW ( A + Flags state )
800C|800D(A + Flags state) =  [ 2 byte stack, 800Eh stack pointer ]
810E : C9    → RET
- return to address(8006h) after RET [ 0 byte stack, 8010H stack pointer ] 
```