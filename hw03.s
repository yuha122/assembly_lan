ptr_fmt1: .asciz "년도를 입력하세요(종료: 음수)"
ptr_fmt2: .asciz "%d 윤년입니다\n"
ptr_fmt3: .asciz "%d 평년입니다\n"
scf_fmt1: .asciz "%d"
          .align 4
          .section ".data"
          .global main
main:   save %sp, -96, %sp
loop1:  set ptr_fmt1, %o0
        call printf
        nop
        set scf_fmt1, %o0
        call scanf
        add %fp, -4, %o1        ! 분기 지연을 회피하기 위해 코드 순서 수정
        ld [%fp-4], %l0         ! scanf로 입력 받아 메모리에 저장된 값을 %l0로 불러옴
        ba test                 ! test로 무조건 분기
        cmp %l0, 0              ! 분기 지연을 방지하기 위한 코드 순서 수정              
loop2:  call .rem               ! %l1 % 400
        mov 400, %o1            ! 분기 지연을 방지하기 위해 코드 순서 수정
        ba test_400             ! test_400으로 무조건 분기
        cmp %o0, 0              ! 분기 지연을 방지하기 위한 코드 순서 수정
loop3:  call .rem               ! %l0 % 400 != 0이면
        mov 4, %o1              ! %l0 % 4               
        ba  test_4              ! test_4로 무조건 분기
        cmp %o0, 0              ! 분기 지연을 방지하기 위한 코드 순서 수정
test:   bg,a loop2              ! %l0 > 0이면, loop로 분기
        mov %l0, %o0            ! 분기 지연을 회피하기 위한 코드 순서 수정
        ret
        restore
test_400: be yoon_year          ! %l0 % 400 == 0이면, yoon_year로 분기
          mov %l0, %o0
          ba loop3              ! %l0 % 400 != 0이면, loop3으로 분기
          mov %l0, %o0          ! 분기 지연을 방지하기 위한 코드 순서 수정
test_4: be test_100             ! %l0 % 400 != 0 and %l0 % 4 == 0이면, test_100으로 분기
        mov %l0, %o0            ! 분기 지연을 방지하기 위한 코드 순서 수정
        ba pyeong_year          ! %l0 % 400 != 0 and %l0 % 4 != 0이면, pyeong_year로 분기
        nop
test_100: call .rem             ! %l0 % 400 != 0 and %l0 % 4 == 0
          mov 100, %o1
          cmp %o0, %o1          ! %l0 % 100 == 0이면, pyeong_year로 분기
          be pyeong_year
          nop
          ba yoon_year          !아니면 yoon_year로 분기
          nop
yoon_year:  set ptr_fmt2, %o0   ! printf("%d 윤년입니다\n")
            call printf
            mov %l0, %o1        ! 분기 지연을 회피하기 위한 순서 수정
            ba loop1            ! 다시 while 루프로 돌아감
            nop
pyeong_year: set ptr_fmt3, %o0  ! printf("%d 평년입니다\n")
             call printf
             mov %l0, %o1       ! 분기 지연을 회피하기 위한 코드
