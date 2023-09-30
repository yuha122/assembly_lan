fmt2:   .asciz "정수 n값: %d, 정수 -n값: %d\n"
        .align 4
        .global main

main:   save %sp, -96&-8, %sp
        mov  34, %l0    		! %l0 = 34
        add %g0, -1, %l1        ! %l1를 모두 1로 세팅함
        xor %l0, %l1, %l1       ! %l0 (exclusive or) %l1하여 1의 보수를 만들고 그 결과를 %l1에 저장
        inc %l1                 ! %l1에 저장된 값에 + 1하여 2의 보수 만듦
        set fmt2, %o0           ! printf의 첫 번째 매개변수 "정수 n값: %d, 정수 -n값: %d\n"을 %o0로 전달 
        mov %l0, %o1            ! 두 번째 매개변수를 %o1에 전달
        mov %l1, %o2            ! 세 번째 매개변수를 %o2에 전달
        call printf             ! printf 호출
        nop                     ! 지연
        ret
        restore

