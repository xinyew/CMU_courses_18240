; read 10000 samples from ADC, calculated the most recent
; 8 samples and write the average value to DAC

        .ORG    $500
Init    MV r1, r0                       ; r1 counts the elements
        ADDI r7, r0, $4                 ; r7 = 4 for shifting
        LI r2, $1                       ; r2: enable bit
        SW r0, r2, $0010                ; set ADC enable bit

Wait    LW r2, r0, $0022                ; check data ready bit
        MV r5, r0                       ; r5 = 0 Init for sum
        ADDI r4, r0, $C                 ; r4 = 12 Indexing and loop counter
        BRN Shift                       ; if set, start Shifting
        BRA Wait                        ; otherwise, keep busy-waiting

Shift   SLT r0, r4, r0                  
        BRN RdADC                       ; RdADC if r4 < 0
        LW r3, r4, Recent               ; r3 = Recent[6/5/4...] 
        ADD r5, r5, r3                  ; accumulating valid values
        ADDI r4, r4, $2                 ; r4 += 2 Get positions 7/6/5...
        SW r4, r3, Recent               ; Recent[7/6/5...] = Recent[6/5/4...]
        SUB r4, r4, r7                  ; r4 -= 4 Set r4 to the next value

RdADC   LW r3, r0, $0020                ; r3 = ADC
        ADD r5, r5, r3                  ; accumulating valid values in r5
        SW r0, r3, Recent               ; Recent[0] = r3

WtDAC   SRAI r5, r5, $3                 ; r5 = r5 // 8
        LI  r6, $8000                   ; DAC enable bit
        SW  r0, r6, $0012               ; store the DAC enable bit
        SW  r0, r5, $0014               ; store the calculated value


Branch  ADDI r1, r1, $1                 ; increment counter
        SLTI r0, r1, $2710              ; check if r1 < 10000
        BRN Wait                        ; if so, wait for next value

Done    SW r0, r0, $0010                ; turn off ADC: clear enable bit

        .ORG    $1000
Recent  .DW     $0
        .DW     $0
        .DW     $0
        .DW     $0
        .DW     $0
        .DW     $0
        .DW     $0
        .DW     $0