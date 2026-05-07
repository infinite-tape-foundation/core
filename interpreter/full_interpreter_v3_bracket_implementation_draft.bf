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
        
        /* If cell is 0, perform forward search */
        /* Nesting Counter Cell [4] = 1 */
        >>> +
        [
             /* Increment IP [1] */
             <<<<<< > + <<<<<<
             
             /* Fetch token at GuestTape[7 + IP] */
             >>>>>>>
             <<<<<<<
             [ - >>>>>>> <<<<<<< ]
             [ - >+ < ] >
             <<<<<<<
             >>>>>>>
             <<<<<<<
             
             /* Compare token to '[' (91) and ']' (93) */
             /* Subtract 91 from token to determine bracket type */
             +++++ +++++ [ < ++++++++ > - ] < +++
             < [ - > - < ] > [ - < + > ] <

             /* Match '[': Result 0 -> Increment Counter [4] */
             > [
                 <<<<<<< - >>>>>>> /* This path is for non-zero; logic inverted below */
             ]
             
             /* Logic Refinement: */
             /* If Token == 91, result was 0. We need a way to detect that. */
             /* For now, we use the match flag in Cell [4]. */
             
             /* Search continues... */
        ]
    ]
    
    /* Final Step: Increment IP normally if no jump occurred */
    > + <
]
