```
Самойленко Володимир Миколайович - Варіант 9  

Скласти програму у мнемокодах для сортування масиву двійкових чисел
за заданою умовою відповідно до варіанту N.
NN = 9 :

1 array - xi / 2 even 
2 array - xi / 2 odd
input array : 8030 - 803A ( 11 nums )
output array 1 : 8040 - 804A
output array 2 : 8050 - 805A
---------------------------------------
mask : 0000 0001 = 01[h], cause only 2^0 give 1
```

```
--------
crutch
--------
db 00        ; in 00h    
32 3B 00     ; sta 803Bh

db 0B        ; in 0Bh
32 3C 00     ; sta 803Ch

21 30 80    ; lxi h,8030        input [m]
01 40 80    ; lxi b,8040        even
11 50 80    ; lxi d,8050        odd
--------
m1
--------
7E           ; mov a,m
E6 01        ; ani 01h                   
CA xx xx     ; jz even                         
C2 xx xx     ; jnz odd                      
--------
even 
--------
7E           ; mov a,m
02           ; stax bc (bc <-- a)
03           ; inx bc (bc + 1)
C3 xx xx     ; jmp end-m1
--------
odd 
--------
7E           ; mov a,m
12           ; stax de (de <-- a)
13           ; inx de (de + 1)
--------
end-m1
--------
807E  23     ; inx hl 
3A 3B 80     ; lda 803Bh
3C           ; inr a
32 3B 80     ; sta 803Bh

3A 3C 80     ; lda 803Ch
3D           ; dcr a
32 3C 80     ; sta 803Ch

FE 00        ; cpi 00h    
C2 xx xx     ; jnz m1

76           ; hlt
```

```
--------
input array
--------
8030  XX
8031  XX
8032  XX
8033  XX
8034  XX
8035  XX
8036  XX
8037  XX
8038  XX
8039  XX
803A  XX

--------
counter
--------
803B  XX
803C  XX

--------
output aray 1 - even
--------
8040  XX
8041  XX
8042  XX
8043  XX
8044  XX
8045  XX
8046  XX
8047  XX
8048  XX
8049  XX
804A  XX

--------
output aray 2 - odd
--------
8050  XX
8051  XX
8052  XX
8053  XX
8054  XX
8055  XX
8056  XX
8057  XX
8058  XX
8059  XX
805A  XX

--------
program
--------
805B  00          ; db 00
805C  32          ; sta 803Bh
805D  3B
805E  80

805F  0B          ; db 0B
8060  32          ; sta 803Ch
8061  3C
8062  80

8063  21          ; lxi hl,8030h
8064  30
8065  80

8066  01          ; lxi bc,8040h
8067  40
8068  80

8069  11          ; lxi de,8050h
806A  50
806B  80

--------
m1
--------
806C  7E          ; mov a,m
806D  E6          ; ani 01h
806E  01

806F  CA          ; jz even
8070  75
8071  80

8072  C2          ; jnz odd
8073  7B
8074  80

--------
even
--------
8075  7E          ; mov a,m
8076  02          ; stax b
8077  03          ; inx b
8078  C3          ; jmp end_m1
8079  7E
807A  80

--------
odd
--------
807B  7E          ; mov a,m
807C  12          ; stax d
807D  13          ; inx d

--------
end_m1
--------
807E  23          ; inx hl   

807F  3A          ; lda 803Bh
8080  3B
8081  80

8082  3C          ; inr a

8083  32          ; sta 803Bh
8084  3B
8085  80

8086  3A          ; lda 803Ch
8087  3C
8088  80

8089  3D          ; dcr a

808A  32          ; sta 803Ch
808B  3C
808C  80

808D  FE          ; cpi 00h
808E  00

808F  C2          ; jnz m1
8090  6C
8091  80

8092  76          ; hlt
```