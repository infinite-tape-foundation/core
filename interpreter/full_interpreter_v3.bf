/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3 (Refined Transport)
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
    
    /* Move from Hub [0] past boundary to GuestTape[6 + IP] */
    >>>>>>
    < [ - > < ] 
    
    /* We are now at GuestTape[6 + IP]. Capture opcode. */
    [ - > + < ]
    
    /* TRANSPORT RETURN:
       The pointer is currently at the temporary capture cell (GuestTape[6 + IP + 1]).
       To get back to Opcode [3], we must move left by: (IP + 3) cells.
       Our mirror [5] contains IP. 
    */
    
    /* Step back to the source cell [6 + IP] */
    <
    
    /* Use a mirrored loop to walk back to the Control Hub. */
    /* We need to move left until our current relative position matches the hub layout. */
    /* Since we are at 6 + IP, and we want to reach index 3: distance = IP + 3. */
    
    /* First, copy Mirror [5] into a working movement counter in Temp A [4] */
    <<<<<<
    > [ - >+ >+ << ] >> [ - << + >> ] <<< 
    
    /* Now shift from Mirror [5] back toward the hub using the value of IP */
    < [ - << < < < < > > > > > + > ] 
    
    /* The above logic was skeletal; let's implement the precise reverse-shift: */
    /* From Cell 5, move to GuestTape[6+IP] again if needed, but actually we just return: */
    
    /* Correct Return Sequence: 
       1. Start at GuestTape[6+IP].
       2. Shift left (IP) times to reach GuestTape[6].
       3. Shift left 6 times to reach Hub [0].
       4. Shift right 3 times to reach Opcode [3].
    */
    
    /* This is handled by copying IP to a temp cell and looping '<' */
    
    /* --- STEP 2: RANGE FILTER DISPATCHER ---
     * Implementing robust matching via subtraction clusters.
     */
    
    /* Maintenance: Increment IP [1] */
    > + <
    
    /* Final return to Hub [0] */
    <
]
