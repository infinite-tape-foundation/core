/* 
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3 (Bracket Integration Draft)
 * 
 * Memory Map:
 * [0] : Hub / Main Loop Control
 * [1] : Instruction Pointer (IP)
 * [2] : Virtual Data Pointer (VDP)
 * [3] : Current Opcode
 * [4] : Temp A / Match Flag / Nesting Counter
 * [5] : Outward Mirror (Fetch Counter)
 * [6] : Inward Mirror (Return Counter)
 * [7...] : Guest Tape Workspace
 */

> + <
[
    /* --- STEP 1: SYMMETRIC INDEXED FETCH ---
     * Move value from GuestTape[7 + IP] into Opcode [3].
     */
    > [ - >+ >+ << ] >> [ - << + >> ] <<<
    >>>>>>>
    <<<<<<<
    [ - >>>>>>> <<<<<<< ] 
    [ - >+ < ] >
    <<<<<<<
    >>>>>>>
    <<<<<<<
    ++++ 
    <<<<<<<
    [ - >>>>>>> [ - < + > ] < <<<<<<< ] 
    <<<
    
    /* --- STEP 2: OPCODE DISPATCH ---
     */
    
    /* Cluster 1: +, -, ., , (Base ASCII = 43 '+') */
    >>>
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < +++ 
    < [ - > - < ] > [ - < + > ] <
    >
    [
        <<<<<<
        > [ - >+ >+ << ] >> [ - << + >> ] <<<
        >>>>>>>
        <<<<<<<
        [ - >>>>>>> <<<<<<< ]
        +
        <<<<<<<
        ++++ 
        [ - >>>>>>> <<<<<<< ] 
        <<<
        >>>
        [ - < + > ] < 
    ]

    /* Subtraction ('-') Match */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < +++++ 
    < [ - > - < ] > [ - < + > ] <
    >
    [
        <<<<<<
        > [ - >+ >+ << ] >> [ - << + >> ] <<<
        >>>>>>>
        <<<<<<<
        [ - >>>>>>> <<<<<<< ]
        -
        <<<<<<<
        ++++ 
        [ - >>>>>>> <<<<<<< ] 
        <<<
        >>>
        [ - < + > ] < 
    ]

    /* Output ('.') Match */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < +++++ +
    < [ - > - < ] > [ - < + > ] <
    >
    [
        <<<<<<
        > [ - >+ >+ << ] >> [ - << + >> ] <<<
        >>>>>>>
        <<<<<<<
        [ - >>>>>>> <<<<<<< ]
        [ - >+ < ] > .
        <<<<<<<
        ++++ 
        [ - >>>>>>> <<<<<<< ] 
        <<<
        >>>
        [ - < + > ] < 
    ]

    /* Input (',') Match */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < ++++ 
    < [ - > - < ] > [ - < + > ] <
    >
    [
        <<<<<<
        > [ - >+ >+ << ] >> [ - << + >> ] <<<
        >>>>>>>
        <<<<<<<
        [ - >>>>>>> <<<<<<< ]
        , 
        <<<<<<<
        ++++ 
        [ - >>>>>>> <<<<<<< ] 
        <<<
        >>>
        [ - < + > ] < 
    ]

    /* Cluster 2: Movement ('>', '<') (Base ASCII = 60 '<') */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < ++++ +++++ +++++ +++
    < [ - > - < ] > [ - < + > ] <
    >
    [
        <<<<<<
        > +
        <<<<<<
        >>>
        [ - < + > ] < 
    ]

    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < ++++ +++++ +++++ ++++
    < [ - > - < ] > [ - < + > ] <
    >
    [
        <<<<<<
        > -
        <<<<<<
        >>>
        [ - < + > ] < 
    ]

    /* Cluster 3: Brackets ('[', ']') (Base ASCII = 91 '[') */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < ++++ +++++ +++++ ++++ ++++ ++++ ++++ ++++ ++++ ++++ ++++
    < [ - > - < ] > [ - < + > ] <
    >
    [
        /* Opcode is '['. Forward Jump if GuestTape[VDP] == 0 */
        <<<<<<
        > [ - >+ >+ << ] >> [ - << + >> ] <<<
        >>>>>>>
        <<<<<<<
        [ - >>>>>>> <<<<<<< ]
        
        /* If cell is 0, perform search */
        [ 
            /* This block executes ONLY if GuestTape[VDP] != 0; we want the opposite. */
            /* Since BF doesn't have 'if not', we wrap the jump logic in a conditional that checks for zero. */
            - 
        ] 
        
        /* To implement [ : if(tape[vdp]==0) jump_forward() */
        /* We use a temporary flag: copy tape[vdp] to temp. If temp is 0, jump. */
        /* But we are already inside an interpreter loop. The easiest way to do 'if zero' is to leave it empty and handle the non-zero case by skipping the jump. */
        
        /* Implementation of forward scan: */
        /* Nesting Counter Cell [4] = 1 */
        >>> +
        /* Loop IP++ / Fetch / Update Counter until Counter == 0 */
        [ 
             <<<<<< > + <<<<<< 
             >>>>>>> <<<<<<< [ - >>>>>>> <<<<<<< ] 
             /* Compare token with '[' (91) and ']' (93) */
             /* ... (Scan Logic) ... */
             <<< - >>> 
        ]
        
        <<<<<<
        >>>
        [ - < + > ] < 
    ]

    /* Backward Jump (']') logic would follow similarly... */

    /* FINAL STEP: IP INCREMENT & HUB RESET */
    <<<<<<
    > +
    <<<<<
]
