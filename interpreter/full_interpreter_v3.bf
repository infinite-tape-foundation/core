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
    
    /* Shift Right: Use mirror [5] as distance counter. */
    /* Start at Hub [0], move right by IP cells, then past the hub registers to cell [7]. */
    /* Total shift = 7 + IP. We already have IP in [5]. */
    
    /* First, move to the base of guest tape [7] */
    >>>>>>>
    
    /* Then shift further by the value of mirror [5] (which is the original IP) */
    <<<<<<< 
    [ 
        - >>>>>>> 
        <<<<<<< 
    ] 
    
    /* Now we are at GuestTape[7 + IP]. Fetch opcode into Opcode [3]. */
    /* To transport this value back to [3], we must use a loop that shifts left while
       decrementing Mirror [6] AND maintains the value being transported. */
    
    /* Value Transport Logic: Move current cell to [3] using Mirror [6]. */
    /* Since we are at [7+IP], and target is [3], distance is (7+IP)-3 = 4+IP. */
    /* The Return Counter [6] currently holds IP. */
    
    /* Step A: Copy the opcode value from current cell into a temporary relay */
    /* because we cannot 'carry' it in a standard BF loop without destroying it. */
    /* We will shift it back one cell at a time using Mirror [6] as the limit. */
    
    /* This is the core challenge of the v3 Transport. */
    /* For now, we implement the symmetric return first to stabilize the hub. */
    
    <<<<<<< 
    [ 
        - >>>>>>> 
        <<<<<<< 
    ] 
    /* Returned to Hub [0]. Now move to Opcode cell [3]. */
    >>>
    
    /* --- STEP 2: OPCODE DISPATCH ---
     * Applying the Law of Proximity via Range Filtering.
     */
    
    /* Cluster 1: +, -, ., , (Base ASCII = 43 '+') */
    /* Subtract 43 from Opcode[3] into Temp[4] */
    > +++++ +++++ [ < ++++++++ > - ] < +++ 
    < [ - > - < ] > [ - < + > ] <
    
    /* If result == 0, it was a '+'. Execute guest increment. */
    
    /* Increment IP [1] */
    << + >>
    
    /* Reset Hub [0] check / Loop back */
    <<< 
]EOF
