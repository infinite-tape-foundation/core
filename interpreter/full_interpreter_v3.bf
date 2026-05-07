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
    /* We use a temporary shift mechanism to move distance = [5] cells right */
    <<<<<<< 
    [ 
        - >>>>>>> 
        <<<<<<< 
    ] 
    
    /* Now at GuestTape[7 + IP]. 
       We must transport this cell value back to Opcode [3].
       Distance from [3] is (7 + IP) - 3 = 4 + IP.
    */
    
    /* Setup Inward Mirror [6]: current position is 7 + IP. Return target is 3. */
    /* We need to move left (7 + IP) - 3 times. */
    /* Mirror [6] already contains IP. We just add 4 to it. */
    <<<<<<< 
    >>>>>>>
    <<<<<<< 
    ++++ 
    
    /* Transport Loop: While Inward Mirror [6] != 0, move current cell left and decrement mirror. */
    /* This requires moving the pointer to mirror [6], checking it, then moving to the data, then shifting. */
    /* Since we are currently at GuestTape[7+IP], and Mirror [6] is far away, we use a relative shift. */
    
    /* Actual Transport Sequence: */
    /* Move to Mirror [6] */
    <<<<<<< 
    [ 
        - /* Decr mirror */
        >>>>>>> /* Move back to current guest cell */
        [ - < + > ] /* Copy value to cell on left */
        < /* Shift left permanently */
        <<<<<<< /* Move back to mirror [6] for next check */
    ] 
    
    /* After the loop, the original value of GuestTape[7+IP] has been shifted left by (4+IP) cells.
       Since we started at (7+IP), shifting left (4+IP) lands us exactly at cell [3].
    */
    
    /* Return to Hub [0] using symmetry (distance from [3] to [0] is 3). */
    <<< 
    
    /* --- STEP 2: OPCODE DISPATCH ---
     * Applying the Law of Proximity via Range Filtering.
     */
    
    /* Cluster 1 Match: +, -, ., , (Base ASCII = 43 '+') */
    >>>
    
    /* Non-destructive copy of Opcode [3] to Temp [4] for matching */
    [ - >+ < ] > [ - < + > ] <
    
    /* Subtract 43 from Temp[4] */
    > +++++ +++++ [ < ++++++++ > - ] < +++ 
    < [ - > - < ] > [ - < + > ] <
    
    /* If result == 0, it was a '+'. Execute guest increment. */
    /* Logic for GuestTape[7+VDP] ++ goes here in next refinement phase. */
    
    /* Increment IP [1] */
    << + >>
    
    /* Reset Hub [0] check / Loop back */
    <<< 
]EOF
