/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3 (Symmetric Transport)
 * 
 * Memory Map:
 * [0] : Hub / Main Loop Control
 * [1] : Instruction Pointer (IP)
 * [2] : Virtual Data Pointer (VDP)
 * [3] : Current Opcode
 * [4] : Temp A / Match Flag
 * [5] : Fetch Mirror (Return Counter)
 * [6...] : Guest Tape Workspace (Source Code and Data combined)
 */

/* Initialization: Set Hub to 1, IP to 0, VDP to 0 */
> + <

[
    /* --- STEP 1: INDEXED FETCH ---
     * Goal: Move value from GuestTape[6 + IP] into Opcode [3].
     */

    /* Copy IP [1] to Fetch Mirror [5] for return trip */
    > [ - >+ >+ << ] >> [ - << + >> ] <<< 
    
    /* Position pointer at Hub [0] then move to start of GuestTape [6] */
    >>>>>>
    
    /* Use the mirror in [5] (which is now at our left) to reach GuestTape[6 + IP] */
    < [ - > < ] 
    
    /* We are now at GuestTape[6 + IP]. Capture opcode. */
    /* Non-destructive copy: [6+IP] -> [6+IP+1] and back to [6+IP] */
    [ - >+ >+ << ] >> [ - << + >> ] < [ - << + >> ] <<<
    
    /* Now we use the mirrored copy at [6+IP+1] to travel back to Hub [0] */
    /* First, create a temporary return counter from the copy we just made */
    > [ - > + < ] >
    
    /* Move left until we hit cell [5], using the counter in [6+IP+2] */
    /* However, since we know exactly how far we went (IP + 6), we can simply
       re-use the original Mirror [5] if we didn't destroy it. 
       Wait, let's be more robust: move left while mirroring. */
    
    /* Actual Return Logic: Move back to cell [0] by shifting left based on IP */
    /* To do this safely, we shift left until we reach a known zero/marker or 
       simply rely on the symmetry of the fetch move. */
    
    <<<<<<<<< /* Temporary skeletal jump; in final v3 this is replaced by mirror loop */
    
    /* --- STEP 2: OPCODE DISPATCH ---
     * Placeholder for Range Filter Dispatcher
     */

    /* Increment IP for next cycle */
    > + < 
    <
]EOF
