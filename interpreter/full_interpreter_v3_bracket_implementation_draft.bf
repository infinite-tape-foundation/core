/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3 (Bracket Integration Draft)
 * 
 * Memory Map:
 * [0] : Hub / Main Loop Control
 * [1] : Instruction Pointer (IP)
 * [2] : Virtual Data Pointer (VDP)
 * [3] : Current Opcode
 * [4] : Nesting Counter / Temp A
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
    
    /* Cluster 1 Match: +, -, ., , (Base ASCII = 43 '+') */
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

    /* SUBTRACTION ('-') MATCH */
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

    /* OUTPUT ('.') MATCH */
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

    /* INPUT (',') MATCH */
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

    /* MOVEMENT ('>', '<') MATCH: Base 60 ('<') */
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

    /* LEFT ('<') MATCH: Base 60 */
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

    /* --- BRACKET CLUSTER MATCH (ASCII 91-93) ---
     * Base ASCII = 91 ('[')
     */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++
    < [ - > - < ] > [ - < + > ] <
    >
    [
        /* Result is now Opcode - 91. */
        /* If Result == 0, it is '[' (Forward Jump). */
        [ - >+ < ] > [ - < + > ] <
        >
        [
            /* Forward Jump Logic: IF GuestTape[VDP] == 0 THEN skip to matching ']' */
            <<<<<<
            > [ - >+ >+ << ] >> [ - << + >> ] <<<
            >>>>>>>
            <<<<<<<
            [ - >>>>>>> <<<<<<< ]
            /* Copy value of VDP cell to match flag [4] */
            [ - >+ < ] >
            <<<<<<
            /* If guest tape value is NOT 0, we do NOT jump. We must clear the match flag. */
            [ - >+ < ] >
            [ - < + > ] <
            <<<<<<
            /* Set Nesting Counter [4] = 1 */
            > +
            /* Search Loop */
            [ 
                /* Increment IP [1] */
                < + >
                /* Fetch token at GuestTape[7 + IP] */
                < [ - >+ >+ << ] >> [ - << + >> ] <<<
                >>>>>>>
                <<<<<<<
                [ - >>>>>>> <<<<<<< ]
                /* Simplified nesting logic for draft: check if bracket and decr counter */
                - 
            ]
            <<<<<<
            >>>
            [ - < + > ] <
        ]
    ]

    /* --- STEP 3: IP INCREMENT & HUB RESET ---
     */
    <<<<<<
    > +
    <<<<<
]
