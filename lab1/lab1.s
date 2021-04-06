fmt1:   .asciz "==output==%d\n"
fmt2:   .asciz "input="
fmt4:   .asciz "%d"
        .align 4
        .global main,scanf,printf
main:   save %sp,-96,%sp

loop:   set fmt2,%o0
        call printf
        nop
        
        set fmt4,%o0
        add %fp,-4,%o1
        call scanf
        nop

        add %fp,-4,%o0	!메모리 x 위치에 기억되어 있는 정보를
        ld [%o0],%l1	!레지스터 l1에 복사
        
        subcc %l1,0,%g0	!음수이면 종료
        bl exit
        nop
        
        set fmt2,%o0
        call printf
        nop
        
        set fmt4,%o0
        add %fp,-4,%o1
        call scanf
        nop
        
        add %fp,-4,%o0	!메모리 x 위치에 기억되어 있는 정보를
        ld [%o0],%l2    !레지스터 l2에 복사
        
        mov %g0,%l3		!레지스터 l3에 0 저장

sum:    add %l1,%l3,%l3		!l3 += l1
        subcc %l1,%l2,%g0	!if(l1 - l2 > 0)
        inc %l1				!l1++, 레이블sum로 branch
        bl sum
        nop

        set fmt1, %o0		!출력
        mov %l3,%o1
        call printf
        nop
        
        ba loop
        nop					
		
exit:   ret					!메모리 반환 및 종료
        restore