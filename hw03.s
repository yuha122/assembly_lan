ptr_fmt1: .asciz "년도를 입력하세요(종료: 음수)"
ptr_fmt2: .asciz "%d 윤년입니다\n"
ptr_fmt3: .asciz "%d 평년입니다\n"
scf_fmt1: .asciz "%d"
          .align 4
          .section ".data"
          .global main
main:   save %sp, -96, %sp
loop:   set ptr_fmt1, %o0
        call printf
        nop
        set scf_fmt1, %o0
        call scanf        !
        add %fp, -4, %o1        ! 분기 지연을 회피하기 위해 코드 순서 수정
        ld [%fp-4], %l0         ! scanf로 입력 받아 메모리에 저장된 값을 %l1으로 불러옴
        cmp %l0, 0              ! %l1과 0을 비교하고 음수(즉, < 0)이면
        bl Exit                 ! Exit으로 분기
        nop
        mov %l0, %o0            ! %l1이 양수이면 
        call .rem               ! %l1 % 400
        mov 400, %o1            ! 분기 지연을 방지하기 위해 코드 순서 수정      
        cmp %o0, 0
        be yoon_year            ! 위의 계산 결과가 0이면 yoon_year로 분기
        nop
        call .rem
        mov 4, %o1
        cmp %o0, 0      
        be next_r               ! 위의 계산 결과가 0이면 next_r로 분기
        nop
        ba pyeong_year          ! 아니라면 pyeong_year로 분기
        nop
yoon_year: set ptr_fmt2, %o0    ! printf("%d 윤년입니다\n")
           call printf
           mov %l0, %o1         ! 분기 지연을 회피하기 위한 순서 수정
           ba loop              ! 다시 while 루프로 돌아감
           nop
next_r: mov %l1, %o0
        call .rem               ! %l1 % 4 == 0일 때 %l1 % 100의 값을 확인
        mov 100, %o1
        cmp %o0, 0              ! %l1 % 4 == 0 and %l1 % 100 == 0
        be pyeong_year          ! pyeong_year로 분기
        nop
        ba yoon_year            ! %l1 % 4 == 0 and %l1 % 100 != 0 이면 yoon_year로 분기
        nop
pyeong_year: set ptr_fmt3, %o0  ! printf("%d 평년입니다\n")
             call printf
             mov %l0, %o1       ! 분기 지연을 회피하기 위한 코드
             ba loop            ! 다시 while 루프로 돌아감
             nop
Exit: ret
      restore

