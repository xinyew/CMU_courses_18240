        .ORG    $0300
START   LW      r1, r0, $2000   ; r1 = len(array), for counting loops
        LI      r2, $FFF8       ; r2 = -8, for 
        LI      r3, $0000       ; r3 = 0, for indexing the array
        LI      r6, $FFFF       ; r6 = -1, for deducting from r1
        LI      r7, $4          ; r7 = -4, for getting the 3rd LSB

LOOP    SLT     r0, r0, r1      
        BRZ     DONE            ; if r1 == 0, done
        LW      r4, r3, $2002   ; r4 = M[r3 + 2002], tmp var storing values 
        LI      r7, $4          ; r7 = 4, for testing whether to round
        AND     r5, r4, r7      ; r5 = r4 & r7, tmp var storing camparison
        BRZ     MODIFY          ; if the 3rd LSB is 0, do the branching
        ADDI    r4, r4, $8      ; otherwise add 8 to the array element

MODIFY  AND     r4, r4, r2      ; check all bits other than the 3 LSBs
        BRN     NEG             ; if negative, branching to NEG round processing
        BRA     STORE           ; if positive, branching to STORE directly

NEG     SUB     r4, r0, r4      ; negate the value

STORE   SW      r3, r4, $4000   ; store the modified number to memory
        ADD     r1, r1, r6      ; loop counter -= 1
        ADDI    r3, r3, $2      ; index += 2
        BRA     loop            ; continue

DONE    STOP

        .ORG    $2000
        .DW     $5
        .DW     $0001
        .DW     $0101
        .DW     $0005
        .DW     $0105
        .DW     $8001