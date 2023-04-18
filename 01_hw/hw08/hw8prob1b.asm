; calculate R6 * R2
; store the result in R1
        .ORG    $100
start   LI      R6, $FF ; load R6
        LI      R2, $3  ; set R2 to 3 for init
        LI      R1, $0  ; set R1 to 0 for init
        LI      R3, $1  ;

loop    SLTI    R0, R2, $0  ; test R2 ?= 0
        BRZ     done        ; stop if yes
        SUB     R2, R2, R3  ; subtract 1 from R2
        ADD     R1, R1, R6  ; add R1 = R1 + R6
        BRA     loop        ; continue

done    STOP
