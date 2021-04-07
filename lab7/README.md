## 부동소수점 합

### [과제 설명](/lab7/lab7.pdf)
### [소스코드](/lab7/lab7.s)
```assembly
        .section ".data"
a:      .single 0r999.0
b:      .single 0r1.0
zero:   .double 0r0.0
fmt0:   .asciz "input = "
fmt1:   .asciz "%g"
fmt2:   .asciz "output = %g\n"
        .align 4
        .global main,scanf,printf

main:   save %sp,-160,%sp

        set zero,%l0
        ldd [%l0],%f6   	! f6 = 0.0, f7 = 0.0
        std %f6,[%fp-16]

input:  set fmt0,%o0
        call printf
        nop

        set fmt1,%o0
        add %fp,-4,%o1
        call scanf
        nop

        ld [%fp-4],%f2  	! f2 = input value

        set a,%l0
        ld [%l0],%f0    	! f0 = 999.0
        set b,%l0
        ld [%l0],%f1    	! f1 = 1.0

        fcmps %f2,%f0   	! (input==999) -> output
        nop
        fbe output
        nop

        fcmps %f2,%f1   	! (input<1) -> input
        nop
        fbl input
        nop

        fstod %f2,%f4

        ldd [%fp-16],%f6	
        faddd %f4,%f6,%f6
        std %f6,[%fp-16]	!입력값 누적

        ba input
        nop

output: ldd [%fp-16],%o2
        mov %o2,%o1
        mov %o3,%o2

        set fmt2,%o0
        call printf
        nop

exit:   ret
        restore
```
