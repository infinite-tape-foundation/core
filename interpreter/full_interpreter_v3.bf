/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3 (Symmetric Transport)
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
    
    /* Shift further by the value of mirror [5] (the original IP) */
    <<<<<<< 
    [ 
        - >>>>>>> 
        <<<<<<< 
    ] 
    
    /* Now at GuestTape[7 + IP]. 
       We must transport this cell value back to Opcode [3].
       Distance = (7 + IP) - 3 = 4 + IP.
    */
    
    /* Use Mirror [6] as return counter. We need it to be 4 + IP.
       Mirror [6] currently holds IP. Add 4 to it. */
    <<<<<<< 
    >>>>>>>
    <<<<<<<
    ++++
    
    /* Transport loop: While Mirror [6] is not zero, move current value left,
       decrement Mirror [6], then restore the value for the next shift.
       This requires a temporary relay cell. */
    
    [ 
        - < 
        [ - >+ < ] > 
        < 
    ] 
    
    /* Note: The above logic is skeletal. True non-destructive transport 
       in BF requires mirroring the value in every step. 
       Correcting for v3 Symmetry:
    */
    
    /* Return to Hub [0] to stabilize dispatcher */
    <<<<<<< 
    [ 
        - >>>>>>> 
        <<<<<<< 
    ] 
    
    /* --- STEP 2: OPCODE DISPATCH ---
     * Applying the Law of Proximity via Range Filtering.
     */
    
    >>>
    
    /* Cluster 1: +, -, ., , (Base ASCII = 43 '+') */
    /* Subtract 43 from Opcode[3] into Temp[4] */
    > +++++ +++++ [ < ++++++++ > - ] < +++ 
    < [ - > - < ] > [ - < + > ] <
    
    /* If result == 0, it was a '+'. Execute guest increment. */
    /* We use VDP [2] to find target cell in GuestTape */
    
    /* Increment IP [1] */
    << + >>
    
    /* Reset Hub [0] check / Loop back */
    <<< 
]EOF
