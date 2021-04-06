fmt1:   .asciz "result=%08x %08x\n"
fmt2:   .asciz "input= "
fmt3:   .asciz "n = "
fmt4:   .asciz "%d"
        .align 4
        .global main,scanf,printf

main:   save %sp,-104,%sp

input:  set fmt2,%o0    
        call printf
        nop
        
        set fmt4,%o0   	!첫 번째 수 입력
        call scanf
        add %fp,-4,%o1
        
        add %fp,-4,%o0
        ld[%o0], %l0	!레지스터 l0에 복사

        set fmt2,%o0    
        call printf
        nop
        
        set fmt4,%o0    !두 번째 수 입력
        call scanf
        add %fp,-8,%o1
        
        add %fp,-8,%o0
        ld[%o0], %l1	!레지스터 l1에 복사
        
nin:    set fmt3,%o0    
        call printf
        nop
        
        set fmt4,%o0    !세 번째 수 입력
        call scanf
        add %fp,-12,%o1
        
        add %fp,-12,%o0
        ld[%o0], %l2	!레지스터 l2(n)에 복사

        cmp %l2, 0		!if(n < 0) exit
        bl exit

        mov 32,%l6		
        sub %l6,%l2,%l6

shift:  srl %l0,%l2,%l3 
        sll %l0,%l6,%l5 !l4로 넘겨질 비트
        srl %l1,%l2,%l4
        or %l4,%l5,%l4  
        
        set fmt1, %o0
        mov %l3,%o1
        call printf
        mov %l4,%o2
        
        ba nin
        nop
        
exit:   ret	
        restore