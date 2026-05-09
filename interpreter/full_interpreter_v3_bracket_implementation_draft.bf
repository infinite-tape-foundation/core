/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3 (Bracket Integration Draft)
 * 
 * Memory Map:
 * [0] : Hub / Main Loop Control
 * [1] : Instruction Pointer (IP)
 * [2] : Virtual Data Pointer (VDP)
 * [3] : Current Opcode
 * [4] : Temp A / Match Flag
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
    
    /* Cluster 1: +, -, ., , (Base 43) */
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

    /* Subtraction ('-') match (Base 43 + 2) */
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

    /* Output ('.') match (Base 43 + 3) */
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
        [ - >+ < ] >
        .
        <<<<<<<
        ++++ 
        [ - >>>>>>> <<<<<<< ] 
        <<<
        >>>
        [ - < + > ] < 
    ]

    /* Input (',') match (Base 43 + 1) */
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

    /* Cluster 2: >, < (Base 60) */
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

    /* Left ('<') match (Base 60) */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < ++++ +++++ +++++ +++
    < [ - > - < ] > [ - < + > ] <
    >
    [
        <<<<<<
        > -
        <<<<<<
        >>>
        [ - < + > ] < 
    ]

    /* --- BRACKET CLUSTER (The Great Ascent) ---
     * Brackets are ASCII 91 '[' and 93 ']'. Base = 91.
     */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < ++++ +++++ +++++ ++++ ++
    < [ - > - < ] > [ - < + > ] <
    >
    [
        /* This is the entry point for Bracket Logic. 
         * We will implement the search loops here in the next phase.
         */
        <<<<<<
        /* Placeholder: Simple IP increment to prevent infinite lock */
        > +
        <<<<<<
        >>>
        [ - < + > ] < 
    ]

    /* --- STEP 3: IP INCREMENT & HUB RESET ---
     */
    <<<<<<
    > +
    <<<<<
]
