        .ORG    $500
START   LI      r7, $5300
        LI      r5, $5310
        MV      r4, r0
LOOP    LW      r2, r7, $0
        BRN     IF
        BRA     NEXT
IF      SUB     r2, r0, r2
NEXT    ADD     r4, r4, r2
        ADDI    r7, r7, $2
        SLT     r0, r7, r5
        BRNZ    LOOP
FINISH  SW      r7, r4, $0
        STOP

        .ORG    $5300
        .DW     $0000
        .DW     $FFFF
        .DW     $0002
        .DW     $FFFD
        .DW     $0004
        .DW     $FFFB
        .DW     $0006
        .DW     $FFF9
        .DW     $0008
        .DW     $FFF7