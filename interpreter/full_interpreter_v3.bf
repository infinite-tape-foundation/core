/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3 (Refined Transport & Data Access)
 * 
 * Memory Map:
 * [0] : Hub / Main Loop Control
 * [1] : Instruction Pointer (IP)
 * [2] : Virtual Data Pointer (VDP)
 * [3] : Current Opcode
 * [4] : Temp A / Match Flag
 * [5] : Outward Mirror (Fetch Counter)
 * [6] : Inward Mirror (Return Counter)
 * [7...] : Guest Tape Workspace (Source Code and Data combined)
 */

/* Initialization: Set Hub to 1, IP to 0, VDP to 0 */
> + <

[
    /* --- STEP 1: SYMMETRIC INDEXED FETCH ---
     * Goal: Move value from GuestTape[7 + IP] into Opcode [3].
     */

    /* Copy IP [1] to mirrors [5] and [6] */
    > [ - >+ >+ << ] >> [ - << + >> ] <<< 
    
    /* Shift Right to GuestTape base [7] */
    >>>>>>>
    
    /* Use mirror [5] to shift further by the original IP */
    <<<<<<< 
    [ 
        - >>>>>>> 
        <<<<<<< 
    ] 
    
    /* Now at GuestTape[7 + IP]. Setup return journey. */
    /* Distance back to cell [3] is (7 + IP) - 3 = 4 + IP. */
    <<<<<<< 
    >>>>>>>
    <<<<<<< 
    ++++ 
    
    /* Transport Loop: While Inward Mirror [6] != 0, move current cell left */
    <<<<<<< 
    [ 
        - 
        >>>>>>> 
        [ - < + > ] 
        < 
        <<<<<<< 
    ] 
    
    /* Value of GuestTape[7+IP] now resides in Opcode [3]. */
    <<< 
    
    /* --- STEP 2: OPCODE DISPATCH ---
     * Applying the Law of Proximity via Range Filtering.
     */
    
    /* Cluster 1 Match: +, -, ., , (Base ASCII = 43 '+') */
    >>>
    
    /* Non-destructive copy of Opcode [3] to Temp [4] for matching */
    [ - >+ < ] > [ - < + > ] <
    
    /* Subtract 43 from Temp[4] to test if it's a '+' opcode */
    > +++++ +++++ [ < ++++++++ > - ] < +++ 
    < [ - > - < ] > [ - < + > ] <
    
    /* If result == 0, it was a '+'. Execute guest increment. */
    /* Target cell is GuestTape[7 + VDP]. */
    >
    [ 
        /* EXECUTE GUEST INCREMENT: Hub -> VDP [2] -> GuestTape[7+VDP] ++ */
        <<<<<<
        /* Copy VDP [2] to Mirror [5] and [6] for transport */
        > [ - >+ >+ << ] >> [ - << + >> ] <<< 
        >>>>>>>
        <<<<<<< 
        [ - >>>>>>> <<<<<<< ]
        /* Now at GuestTape[7+VDP]. Increment it. */
        +
        /* Return using mirror [6] (distance back to hub) */
        <<<<<<< 
        ++++ 
        [ 
            - 
            >>>>>>> 
            <<<<<<< 
        ] 
        <<< 
        /* Clear the match flag Temp[4] to avoid infinite loop */
        >>>
        [ - < + > ] < 
    ]
    
    /* Increment IP [1] */
    << + >>
    
    /* Reset Hub [0] check / Loop back */
    <<< 
]EOF
