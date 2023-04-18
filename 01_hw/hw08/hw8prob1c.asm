; calculate R4 + (R4-1) + (R4-2) + ... + 1 + 0
; store the result in R1
        .ORG    $100
start   LI      R4, $FF ; load R6
        LI      R1, $0  ; set R1 to 0 for init
        LI      R3, $1  ; set R3 to 1 for subtraction

loop    SLTI    R0, R4, $0  ; test R4 ?= 0
        BRZ     done        ; stop if yes
        SUB     R4, R4, R3  ; subtract 1 from R4
        ADD     R1, R1, R4  ; add R1 = R1 + R4
        BRA     loop        ; continue

done    STOP
