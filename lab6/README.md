## 서브루틴

### [과제 설명](/lab6/lab6.pdf)
### [소스코드](/lab6/lab6.s)
```assembly
st:     .asciz "start\n"
fmt1:   .asciz "input = "
fmt11:  .asciz "input(1,2) = "
fmt2:   .asciz "%d"
fmt3:   .asciz "output = %d\n"
        .align 4
        .global main,printf,scanf

sub1:   save %sp,-96,%sp
        clr %i2
		
sub1lo: mov %i0,%o0
        call .mul
        mov %i0,%o1

        add %i2,%o0,%i2

        cmp %i0,%i1
        bne,a sub1lo
        inc %i0

        mov %i2,%i1		!i1로 넘김

        ret
        restore

sub2:   clr %o2
sub2lo: add %o0,%o2,%o2
        cmp %o0,%o1
        bne,a sub2lo
        inc %o0

        retl
        mov %o2,%o1		!o1로 전달

main:   save %sp,-96,%sp

input:  set st,%o0
        call printf
        nop

        set fmt1,%o0
        call printf
        nop

        set fmt2,%o0
        sub %fp,4,%o1
        call scanf		!첫 번째
        nop

        ld [%fp-4],%l0

        cmp %l0,%g0
        bl exit
        nop

        set fmt1,%o0
        call printf
        nop

        set fmt2,%o0
        sub %fp,4,%o1
        call scanf		!두 번째
        nop

        ld [%fp-4],%l1

third:  set fmt11,%o0
        call printf
        nop

        set fmt2,%o0
        sub %fp,4,%o1
        call scanf		!세 번째
        nop

        ld [%fp-4],%l2

        mov %l0,%o0
        mov %l1,%o1

        cmp %l2,1		!임시 서브루틴1 이동
        be s1
        nop

        cmp %l2,2		!임시 서브루틴2 이동
        be s2
        nop

        ba third
        nop

s1:     call sub1		!서브루틴1 이동
        nop
        ba print
        nop

s2:     call sub2		!서브루틴2 이동
        nop

print:  set fmt3,%o0
        call printf
        nop

        mov %o0,%o1
        ba input
        nop

exit:   ret
        restore
```
