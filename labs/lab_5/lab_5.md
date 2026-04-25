```
Самойленко Володимир Миколайович - Варіант 9  
N = 9 - ( abs(xi) < abs(x5) )

Скласти програму у мнемокодах для визначення кількості однобайтних двійкових чисел xі, розміщених в адресах пам'яті 8020...802A, які відповідають умовам, заданим відповідно
до варіанта N.
```
```
setup block
------------
21 26 80 : lxi h, 8026          ; hl <-- x5(8026)
7E : mov a, m                   ; a_reg contain x5
E6 80 : ani 80h                 ; mask for 7 bit check ( - )
CA : jz setup cont.             ; x5 ≥ 0 go [setup cont.]

2F : cma                        ; inv
3C : inr a                      ; mod

----------
setup cont.
----------
57 : mov d, a                   ; d_reg = x5
06 00 : mvi b, 00               ; b_reg contain xi_num that fit the conditions
21 20 80 :lxi h, 8020           ; hl = 8020
0E 0B : mvi c, 0b               ; c_reg - counter (num of cycles 0b=11)
------------
xi check - m1:
------------
7E : mov a, m                   ; a_reg <-- [hl]
B7 : ora a                      ; flags setup, dont change cy
FA XX XX : jp if_positive       ; if s=0 => pos num => go if_positive
2F : cma
3C : inr a                      ; mod
------------
if_positive
------------
BA : cmp d                      ; a_reg - d_reg
DA XX XX: jc next+1             ; if cy=1 => abs(xi) < abs(x5) => next+1
jmp next
------------
next+1:
------------
04 : inr b                      ; b + 1
------------
next:
------------
23 : inx h                      ; hl + 1 (8020 … 802A)
0D : dcr c                      ; c - 1
C2 XX XX : jnz m1
76 : hlt
```
```
[arr]
****
8020
8021
8022
8023
8024
8025
8026
8027
8028
8029
802A
****
[prog]
802B 21     SET X5
802C 26   
802D 80
802E 7E
8030 E6
8031 80

8032 CA     GO CONTINUE SET IF X5+
8033 37
8034 80

8035 2F     MOD IF X5-
8036 3C

8037 57     SET CONT.
8038 06     
8039 00
803A 21
803B 20
803C 80
803D 0E
803E 0B

8040 7E     M1
8041 B7
8042 FA     GO IF_+
8043 47
8044 80

8045 2F     MOD IF Xi-     
8046 3C

8047 BA     IF_+

8048 DA     if cy=1 => abs(xi) < abs(x5) => | NEXT+1
8049 4E
804A 80

804B C3     if cy=0 | NEXT
804C 50
804D 80

804E 04     NEXT+1
8050 23     NEXT
8051 0D
8052 C2
8053 40
8054 80
8055 76
```

```
_______________    SM_NeW

ora a |= ana a ( + carry = 0 ) |= flags setup 

INR r (Increment Register)
Що робить: збільшує один 8-бітний регістр на 1
Приклади регістрів: A, B, C, D, E, H, L
Прапори: оновлює Z, S, P, AC, але не змінює CY
Коли використовується: щоб збільшити значення конкретного 
байта, наприклад лічильника або елементу масиву.

INX rp (Increment Register Pair)
Що робить: збільшує 16-бітну регістрову пару (BC, DE, HL) на 1
Прапори: не змінює жоден прапор
Коли використовується: щоб рухатися по адресам пам’яті, тобто
збільшувати HL, DE або BC для доступу до масиву або таблиці.
```