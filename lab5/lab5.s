        .section ".data"
n:      .skip 4
ary:    .skip 19*19*4
fmt0:   .asciz "n: "
fmt1:   .asciz "%4d"
fmt2:   .asciz "\n"
        .align 4
        .global main,scanf,printf
main:   save %sp,-96,%sp

input:  set fmt0,%o0
        call printf
        nop

        set fmt1,%o0
        set n,%o1
        call scanf
        nop

        ld [%o1],%l0    !l0 = n

        subcc %l0,2,%g0 !if(n - 2 <= 0) exit
        ble exit
        nop

        subcc %l0,20,%g0!if(n-20 >= 20) exit
        bge exit
        nop

        sub %l0,1,%l1   !l1 = (n-1)/2
        srl %l1,1,%l1

        clr %l2         !l2 = i
        mov %l1,%l3     !l3 = j

        mov %l0,%o0     !l4 = n*n
        call .mul
        mov %l0,%o1
        mov %o0,%l4

        mov 1,%l5       !l5 = value

magic:  mov %l2,%o0     !4(i*n+j)
        mov %l0,%o1
        call .mul
        nop
        add %o0,%l3,%o0
        sll %o0,2,%o0

        set ary,%o1     !ary + 4(i*n+j)
        add %o0,%o1,%o0
        st %l5,[%o0]    !magic input

        mov %l5,%o0
        call .rem
        mov %l0,%o1

        cmp %o0,%g0
        bne magic2
        nop

        cmp %l4,%l5
        be print
        nop

        inc %l2
        ba magic
        inc %l5

magic2: inc %l5

        sub %l2,1,%l2
        add %l3,1,%l3

        cmp %l2,%g0
        bl,a magic3
        sub %l0,1,%l2

magic3: cmp %l3,%l0
        be,a magic4
        clr %l3

magic4: ba magic
        nop

print:  clr %l2
        clr %l3
        mov 1,%l6

print1: mov %l2,%o0
        call .mul
        mov %l0,%o1
        add %o0,%l3,%o0
        sll %o0,2,%o0

        set ary,%o1
        add %o0,%o1,%o1

        set fmt1,%o0
        ld [%o1],%o1
        call printf
        nop

        mov %l6,%o0
        call .rem
        mov %l0,%o1

        cmp %o0,%g0
        bne print2
        nop

        set fmt2,%o0
        call printf
        nop

        cmp %l4,%l6
        be input
        nop

        inc %l6
        inc %l2
        ba print1
        clr %l3

print2: inc %l3
        inc %l6

        ba print1
        nop
exit:   ret
        restore
