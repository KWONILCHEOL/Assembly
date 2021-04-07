## 소수와 비소수

### [과제 설명](/lab3/lab3.pdf)
### [소스코드](/lab3/lab3.s)
```assembly
fmt1:   .asciz "input = "
fmt2:   .asciz "%d"
fmt3:   .asciz "output = non-prime number(%d)\n"
fmt4:   .asciz "output = prime number\n"
        .align 4
        .global main,printf,scanf
main:   save %sp,-72,%sp
loop:   set fmt1,%o0
        call printf
        nop

        set fmt2,%o0
        add %fp,-4,%o1
        call scanf
        nop

        ld [%fp-4],%l0
        
        cmp %l0,%g0			!if(l0 < 0) 종료
        bl exit
        nop
        
        cmp %l0,1			!if(l0 == 1) non
        be non
        add %g0,1,%l3		!l3 = 1

prime:  inc %l3				!l3++
        subcc %l3,%l0,%g0	!if(l3 - l0 == 0) pprint
        be pprint
        nop
        
        mov %l0,%o0
        mov %l3,%o1
        call .rem			!o0 = l0 % l3 
        nop

        cmp %o0,%g0			!나누어 떨어지면 비소수
        be  non
        nop

        bl prime		
        nop

pprint: set fmt4,%o0		!소수 출력
        call printf
        nop

        ba loop
        nop

non:    set fmt3,%o0		!비소수 출력
        mov %l3,%o1
        call printf
        nop

        ba loop
        nop 

exit:   ret
        restore 
```
