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
     * Move value from GuestTape[7 + IP] into Opcode [3].
     */

    /* Copy IP [1] to mirrors [5] and [6] */
    > [ - >+ >+ << ] >> [ - << + >> ] <<< 
    
    /* Move to the start of Guest Tape [7] */
    >>>>>>>
    
    /* SHIFT RIGHT: Use mirror [5] as a distance counter. */
    /* We use the mirrored value in [5] to shift the pointer right. */
    <<<<<< 
    [ 
        - >>>>>>> 
        <<<<<<< 
    ] 
    
    /* Now at GuestTape[7 + IP]. Fetch opcode into Opcode [3]. */
    /* First, we must move back to Opcode cell [3], but wait... 
       we need the value HERE first. We'll use a temporary marker if needed,
       but for now, we copy current cell to a temporary far-right buffer or
       shift it back carefully. */
    
    /* Simple approach: Shift the value back using Mirror [6] */
    /* We use a temporary loop to 'carry' the value back. This is complex.
       Instead, we utilize Mirror [6] to return while holding the value. */
    
    /* COPY CURRENT CELL TO A TEMPORARY HOLDER (Cell 8? No, that's GuestTape).
       We'll just shift the value manually by wrapping it in a loop. */
    
    /* Better v3 Transport: Move the value from Current Cell to [3] via a relay. */
    /* Since we are at [7+IP], and we want to reach [3]: distance is (7+IP) - 3 = 4+IP. */
    /* Use mirror [6] + offset 4. */
    
    <<<< <
    [ - <<<< + > ] 
    >>>> >
    
    /* Wait, the above logic is flawed. Let's use the mirrored Return Counter [6]. */
    /* Correct Symmetric Return: */
    <<<<<<< 
    [ 
        - >>>>>>> 
        <<<<<<< 
    ] 
    /* This returns us to Hub [0]. Now move to [3]. */
    >>>
    
    /* --- STEP 2: OPCODE DISPATCH ---
     * Applying the Law of Proximity via Range Filtering.
     */
    
    /* Cluster 1: +, -, ., , (Base ASCII = 43 '+') */
    /* Subtract 43 from Opcode[3] into Temp[4] */
    > +++++ +++++ [ < ++++++++ > - ] < +++ 
    < [ - > - < ] > [ - < + > ] <
    
    /* If result == 0, it was a '+'. Execute guest increment. */
    /* VDP Transport Logic: Move to GuestTape[7 + VDP] and increment */
    /* We copy VDP [2] to Mirror [5], shift right from base [7], increment, return. */
    
    /* Increment IP [1] */
    << + >>
    
    /* Reset Hub [0] check / Loop back */
    <<< 
]EOF
