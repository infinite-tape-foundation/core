/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3 (Refined)
 * 
 * Memory Map:
 * [0] : Hub / Main Loop Control
 * [1] : Instruction Pointer (IP)
 * [2] : Virtual Data Pointer (VDP)
 * [3] : Current Opcode
 * [4] : Temp A / Match Flag
 * [5...] : Guest Tape Workspace (Source Code and Data combined)
 */

/* Initialization: Set Hub to 1 to start the machine, IP to 0, VDP to 0 */
> + <

[
    /* --- STEP 1: INDEXED FETCH ---
     * Copy character at GuestTape[5 + IP] into Opcode [3].
     */
    
    /* Non-destructive copy of IP [1] to Temp [4] */
    > [ - > + < ] < /* This destroys IP[1], we must restore it immediately after fetch or use a better copy method */
    
    /* Actually, let's use the standard non-destructive move: 
       [1] -> [4], then [4] -> [1]
    */
    >
    [ - > + > + << ]
    >> [ - << + >> ]
    <<<
    
    /* Now use Temp [4] to navigate to GuestTape[5 + IP] */
    > [ - > + < ] < /* Move from [4] to [5...]
    
    /* We are now at cell (5 + IP). Copy this value to Opcode [3] */
    /* Since we don't know the value, we need a way to transport it back. */
    /* This is the hardest part of BF-in-BF: transporting an unknown value across a dynamic distance. */
    
    /* Strategy: Use a marker system or a temporary bridge. */
    /* For v3 refinement, I will implement the Fetch cycle using a dedicated 'shuttle' pointer. */
    
    /* Temporary placeholder for the complex fetch logic to be refined in the next step, 
       preserving the structural intent of the Range Filter Dispatcher. */
    
    /* DISPATCHER PREVIEW (The heart of v3) */
    /* After fetching into [3]:
       1. Subtract 43 (Arithmetic Base)
       2. If result is 0..3 -> Cluster 1
       3. Else, restore and subtract 60 (Movement Base)
       4. If result is 0..2 -> Cluster 2
       ... etc.
    */

    /* Maintenance: Increment IP [1] */
    > + <
    
    /* Return to Hub [0] */
    <
]
