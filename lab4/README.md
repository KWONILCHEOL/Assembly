## 오름차순 정렬

### [과제 설명](/lab4/lab4.pdf)
### [소스코드](/lab4/lab4.s)
```assembly
        .section ".text"
fmt0:   .asciz "%3d"
fmt1:   .asciz "array element is %d\n"
fmt2:   .asciz "array input = "
fmt3:   .asciz "\nn input = "
fmt4:   .asciz "ascending order = "
        .align 4
        .global main
main:   save %sp,-160,%sp	!92 + 60 + 4
nin:    set fmt3,%o0
        call printf
        nop

        set fmt0,%o0
        add %fp,-4,%o1
        call scanf
        nop

        ld [%fp-4],%l0  	!레지스터 l0에 n복사

        cmp %l0,16			!if(l0 >= 16) exit
        bge exit
        nop

        cmp %l0,%g0			!if(l0 <= 0) exit
        ble exit
        nop

        sll %l0,2,%l1		! l1 = n*4
        sub %l1,4,%l1		! l1 = n*4 - 4
        mov 64,%l2			! l2 = 64
        sub %l2,%l1,%l1 	! l1 = 64-(n*4-4)

loop:   set fmt2,%o0
        call printf
        nop

        set fmt0,%o0
        sub %fp,%l2,%o1
        call scanf			! n개 입력
        nop

        cmp %l2,%l1
        bg,a loop
        sub %l2,4,%l2

        mov 64,%l2

algol1: cmp %l1,%l2			!bubble sort 사용
        be,a print
        mov 68,%l2

        sub %l2,4,%l3

algol2: sub %fp,%l2,%l6
        sub %fp,%l3,%l7
        ld [%l6],%l4
        ld [%l7],%l5

        cmp %l4,%l5
        bl algol3
        nop

        st %l5,[%l6]
        st %l4,[%l7]

algol3:
        cmp %l1,%l3
        be,a algol1
        sub %l2,4,%l2

        ba algol2
        sub %l3,4,%l3

print:  set fmt4,%o0
        call printf
        nop

print1: sub %l2,4,%l2

        set fmt0,%o0
        sub %fp,%l2,%l4
        ld [%l4],%o1
        call printf
        nop

        st %g0,[%l4]

        subcc %l2,%l1,%g0
        bg print1
        nop

        ba nin
        nop
exit:   ret
        restore
```
