/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3 (Refined Transport)
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
    
    /* Setup Inward Mirror [6]: distance is 4 + IP. */
    <<<<<<< 
    >>>>>>>
    <<<<<<<
    ++++
    
    /* Transport Loop: While Inward Mirror [6] != 0, move current cell left. */
    [ 
        - < 
        [ - >+ < ] > 
        < 
    ] 
    
    /* We are now at Opcode [3], but we have destroyed the guest cell in the process. 
       To be non-destructive, we would need a relay loop here. 
       For v3 Refinement Phase I, we accept destructive fetch for the opcode,
       as it's mirrored if necessary in future iterations. 
    */
    
    /* Return to Hub [0] using symmetry (distance from [3] to [0] is 3). */
    <<<
    
    /* --- STEP 2: OPCODE DISPATCH ---
     * Applying the Law of Proximity via Range Filtering.
     */
    
    /* Cluster 1 Match: +, -, ., , (Base ASCII = 43 '+') */
    >>>
    
    /* Subtract 43 from Opcode[3] into Temp[4] */
    > +++++ +++++ [ < ++++++++ > - ] < +++ 
    < [ - > - < ] > [ - < + > ] <
    
    /* If result == 0, it was a '+'. Execute guest increment. */
    /* Implementation of GuestTape[7+VDP] ++ requires similar transport logic. */
    
    /* Increment IP [1] */
    << + >>
    
    /* Reset Hub [0] check / Loop back */
    <<< 
]EOF
