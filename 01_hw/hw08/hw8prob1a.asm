; count the position of highest bit of 1 in R6
; store the result in R1
        .ORG    $100
start   LI      R6, $FF ; load R6
        LI      R1, $0  ; set R1 to 0 for init

loop    SLTI    R0, R6, $0  ; test R6 ?= 0
        BRZ     done        ; stop if yes
        SRLI    R6, R6, $1  ; logic right shift R6 by 1
        ADDI    R1, R1, $1  ; add 1 to R1
        BRA     loop        ; continue

done    STOP
