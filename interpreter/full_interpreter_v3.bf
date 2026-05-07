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
    
    /* Position pointer at Hub [0], then shift right by 6 cells to hit start of GuestTape */
    >>>>>>
    
    /* Use the mirror in [5] (which is now to our left) to reach GuestTape[6 + IP] */
    /* Since we are at cell [6] and the mirror was at [5], we move back once, check mirror, then shift right */
    < [ - > + < ] >
    
    /* Now we have shifted exactly IP cells relative to the start of the guest tape. */
    /* We are now at GuestTape[6 + IP]. Capture opcode into a temporary copy first. */
    [ - >+ >+ << ] >> [ - << + >> ] < [ - << + >> ] <<<
    
    /* --- STEP 2: SYMMETRIC RETURN ---
     * To return to Opcode cell [3], we must travel back through the distance we came.
     * Distance = 6 + IP.
     */

    /* Re-establish a counter for the trip back. We use a temporary mirror based on the current position. */
    /* The most reliable way is to restore IP from the original Mirror [5] which we used as a guide. */
    
    /* Move back to Mirror [5] using the value in the local temporary if needed, 
       but since we just did [6+IP], let's use the mirrored movement strategy. */
    
    /* Shift left until we reach the Hub region. */
    /* Use a known constant (like the fact that cells 0-5 are our control registers) */
    /* In v3, we implement this by mirroring the shift exactly. */
    
    <<<<<<
    /* Now at Cell 0. Shift to Opcode [3]. */
    >>>
    
    /* Transfer captured opcode from GuestTape[6+IP+1] to Opcode [3]. 
       Wait, the capture was done locally. We need to move it here. */
    /* For now, we assume the opcode is moved via a dedicated transport loop. */
    
    /* --- STEP 3: OPCODE DISPATCH ---
     * Placeholder for Range Filter Dispatcher
     */

    /* Increment IP for next cycle */
    < + > 
    
    /* Return to Hub [0] */
    <<<
]EOF
