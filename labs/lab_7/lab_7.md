```
Скласти програму для обчислення функції у мнемокодах відповідно варіанту N = 9 :
                            y = a * ( a + b )
                            y - 2 byte ( 65535 max ) | a & b - 1 byte

8000 y_2_byte_low
8001 y_1_byte_elder
8002 num_a
8003 num_b

8004 3A     ; LDA 8002
8005 02
8006 80
8007 4F     ; MOV C,A
8008 3A     ; LDA 8003
8009 03
800A 80
800B 81     ; ADD C
800C 57     ; MOV D,A | Dreg = sum(a+b)


800D 3A     ; LDA 8002
800E 02
800F 80
8010 47     ; MOV B, A | Breg = a 
8011 26     ; MVI H, 00 
8012 00
8013 2E     ; MVI L, 00
8014 00
             | reset HL
loop:
8015 7D     ; MOV A, L
8016 82     ; ADD D
8017 6F     ; MOV L, A

8018 D2     ; JNC skip_h++ | if carry = 0 
8019 1C
801A 80

801B 24     ; INR H | if carry = 1

skip_h++:
801C 05     ; DCR B ( B-- )
801D C2     ; JNZ loop | work till Breg > 0
801E 15
801F 80

8020 76     ; HLT

* так як в умові зазначено y - 2 byte, то слід використовувати a & b, що не будуть 
перевищувати максимально допустимий 2 байтовий результат ( 65535 ).
```