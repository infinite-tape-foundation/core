/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3 (Bracket Logic Draft)
 * 
 * Memory Map:
 * [0] : Hub / Main Loop Control
 * [1] : Instruction Pointer (IP)
 * [2] : Virtual Data Pointer (VDP)
 * [3] : Current Opcode
 * [4] : Temp A / Nesting Counter / Match Flag
 * [5] : Outward Mirror (Fetch Counter)
 * [6] : Inward Mirror (Return Counter)
 * [7...] : Guest Tape Workspace (Source Code and Data combined)
 */

/* Initialization: Set Hub to 1, IP to 0, VDP to 0 */
> + <

[
    /* --- STEP 1: SYMMETRIC INDEXED FETCH ---
     * Move value from GuestTape[7 + IP] into Opcode [3].
     */
    > [ - >+ >+ << ] >> [ - << + >> ] <<<
    >>>>>>>
    <<<<<<<
    [
        - >>>>>>> 
        <<<<<<<
    ] 
    [ - >+ < ] >
    <<<<<<<
    >>>>>>>
    <<<<<<<
    ++++ 
    <<<<<<<
    [
        - 
        >>>>>>> 
        [ - < + > ] 
        < 
        <<<<<<<
    ] 
    <<<
    
    /* --- STEP 2: OPCODE DISPATCH ---
     * Range Filter Dispatcher
     */
    
    /* Cluster 1 Match: +, -, ., , (Base ASCII = 43 '+') */
    >>>
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < +++ 
    < [ - > - < ] > [ - < + > ] <
    >
    [
        /* EXECUTE GUEST INCREMENT (+): Hub -> VDP [2] -> GuestTape[7+VDP] ++ */
        <<<<<<
        > [ - >+ >+ << ] >> [ - << + >> ] <<<
        >>>>>>>
        <<<<<<<
        [ - >>>>>>> <<<<<<< ]
        +
        <<<<<<<
        ++++ 
        [
            - 
            >>>>>>> 
            <<<<<<<
        ] 
        <<<
        >>>
        [ - < + > ] < 
    ]

    /* SUBTRACTION ('-') MATCH (45) */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < +++++ 
    < [ - > - < ] > [ - < + > ] <
    >
    [
        /* EXECUTE GUEST DECREMENT (-): Hub -> VDP [2] -> GuestTape[7+VDP] -- */
        <<<<<<
        > [ - >+ >+ << ] >> [ - << + >> ] <<<
        >>>>>>>
        <<<<<<<
        [ - >>>>>>> <<<<<<< ]
        -
        <<<<<<<
        ++++ 
        [
            - 
            >>>>>>> 
            <<<<<<<
        ] 
        <<<
        >>>
        [ - < + > ] < 
    ]

    /* OUTPUT ('.') MATCH (46) */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < +++++ +
    < [ - > - < ] > [ - < + > ] <
    >
    [
        /* EXECUTE GUEST OUTPUT (.): Hub -> VDP [2] -> GuestTape[7+VDP] -> . */
        <<<<<<
        > [ - >+ >+ << ] >> [ - << + >> ] <<<
        >>>>>>>
        <<<<<<<
        [ - >>>>>>> <<<<<<< ]
        [ - >+ < ] >
        .
        <<<<<<<
        ++++ 
        [
            - 
            >>>>>>> 
            <<<<<<<
        ] 
        <<<
        >>>
        [ - < + > ] < 
    ]

    /* INPUT (',') MATCH (44) */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < ++++ 
    < [ - > - < ] > [ - < + > ] <
    >
    [
        /* EXECUTE GUEST INPUT (,): Hub -> VDP [2] -> GuestTape[7+VDP] <- , */
        <<<<<<
        > [ - >+ >+ << ] >> [ - << + >> ] <<<
        >>>>>>>
        <<<<<<<
        [ - >>>>>>> <<<<<<< ]
        ,
        <<<<<<<
        ++++ 
        [
            - 
            >>>>>>> 
            <<<<<<<
        ] 
        <<<
        >>>
        [ - < + > ] < 
    ]

    /* MOVEMENT ('>', '<') MATCH (Base 60) */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < ++++ +++++ +++++ +++
    < [ - > - < ] > [ - < + > ] <
    >
    [
        /* RIGHT (>) match check: subtract 62 from 60 result? No, let's refine movement. */
        /* Simplification for draft: Assume if it hit this block, we test 60 vs 62 */
        <<<<<<
        > +
        <<<<<<
        >>>
        [ - < + > ] < 
    ]
    
    /* --- STEP 3: BRACKET LOGIC (The Recursive Ascent) ---
     * Cluster base = 91 ('[')
     */
    
    /* Match Bracket Cluster (91) */
    [ - >+ < ] > [ - < + > ] <
    > +++++ +++++ [ < ++++++++ > - ] < ++++ +++++ +++++ +++++ +++++ +++
    < [ - > - < ] > [ - < + > ] <
    >
    [
        /* Result 0 -> '[', Result 2 -> ']' */
        
        /* CASE: '[' (Forward Jump) */
        /* Only jump if GuestTape[VDP] == 0 */
        <<<<<<
        /* Copy VDP to find value */
        > [ - >+ >+ << ] >> [ - << + >> ] <<<
        >>>>>>>
        <<<<<<<
        [ - >>>>>>> <<<<<<< ]
        /* Now at GuestTape[VDP]. Check if 0. */
        [ 
            /* Not zero, no jump. Reset flag and exit block. */
            - 
            <<<<<<<
            ++++ 
            [ - >>>>>>> <<<<<<< ]
            <<< 
            >>> [ - < + > ] <
            /* Force break the outer bracket loop by clearing result cell? No, this is complex in BF. */
            /* For draft, we assume simple logic paths. */
        ]
        /* If it was zero, perform Forward Scan */
        <<<<<<<
        ++++ 
        [ - >>>>>>> <<<<<<< ] 
        <<<
        
        /* Nesting Counter = 1 */
        > +
        
        /* FORWARD SCAN LOOP */
        [ 
            /* IP++ */
            <<<< < + > >>>>
            
            /* Fetch token at new IP */
            > [ - >+ >+ << ] >> [ - << + >> ] <<<
            >>>>>>>
            <<<<<<<
            [ - >>>>>>> <<<<<<< ]
            /* Now at GuestTape[7+IP]. Compare with '['(91) or ']'(93) */
            
            /* ... (Search logic continues) ... */
            
            /* Return to hub for next scan iteration */
            <<<<<<<
            ++++ 
            [ - >>>>>>> <<<<<<< ]
            <<< 
        ]
    ]

    /* --- STEP 4: IP INCREMENT & HUB RESET ---
     */
    <<<<<<
    > +
    <<<<<
]
