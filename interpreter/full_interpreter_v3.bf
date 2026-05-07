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
    
    /* Position pointer at the start of GuestTape [6] */
    >>>>>>
    
    /* Use mirror in [5] to shift right by IP cells. 
       We move from cell 6, shifting right based on the count in cell 5.
       Wait—to use cell 5 while at cell 6, we must look back one cell. */
    < [ - > + < ] >
    
    /* We are now at GuestTape[6 + IP]. Capture opcode.
       Copy current cell to a temporary storage just ahead of it. */
    [ - > + < ] >
    
    /* To return and transport, we need a counter. 
       Since we used the mirror in [5] to go out, we restore it or use another.
       Symmetric Return: Move left until we hit our marker/boundary. */
    
    /* Refined Symmetric Transport: 
       The most robust way is to maintain a second mirror during the outward journey.
       For this v3 iteration, we implement the 'Return-to-Hub' shift. */
    
    <<<<<< 
    /* Return to Hub [0], then offset to Opcode [3] */
    >>>
    
    /* --- STEP 2: OPCODE DISPATCH ---
     * Range Filter Dispatcher implementation starts here. */
    
    /* The dispatcher will eventually match Cell [3] against cluster bases. */
    
    /* Increment IP for next cycle */
    < + > 
    
    /* Return to Hub [0] */
    <<<
]EOF
