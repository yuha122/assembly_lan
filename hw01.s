fmt:    .asciz "sorted value = %d, %d\n"
        .align 4
        .global main
main:   save %sp, -96, %sp
        mov 30, %l1     ! first : %l1
        mov 10, %l2     ! second : %l2
        mov %g0, %l0    ! temp : %l0
        subcc %l2, %l1, %g0     ! if first < second
        bg next_r               ! next_r로 이동
        nop
        mov %l1, %l0    ! temp = first
        mov %l2, %l1    ! first = second
        mov %l0, %l2    ! second = temp
                        ! printf("sorted value = %d %d\n", first, second);
next_r:  set fmt, %o0    ! 첫번째 매개변수  "sorted value = %d %d\n"를 %o0로 전달
        mov %l1, %o1    ! 두번째 매개변수  first를 %o1으로 저장해서 전달
        mov %l2, %o2    ! 세번째 매개변수 second를 %o2로 저장해서 전달
        call printf     ! call printf
        nop
        ret
        restore

