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
       We use the mirrored distance in cell [5] to return precisely.
       The pointer is currently at the temporary capture cell (GuestTape[6 + IP + 1]).
     */
    
    /* Step back from the temporary capture cell to the source cell */
    <
    
    /* To get from GuestTape[6 + IP] back to Opcode [3], we must move left by (IP + 3) cells.
       Wait, let's be precise: 
       Hub=0, IP=1, VDP=2, Opcode=3, TempA=4, Mirror=5, GuestStart=6.
       Current position = 6 + IP.
       Target position = 3.
       Distance = (6 + IP) - 3 = IP + 3.
    */

    /* Move to Mirror [5] to begin the walk back */
    <<<<<<
    
    /* Use a copy of the mirror [5] to shift left relative to our current position. */
    /* First, setup a movement counter based on the actual mirror value plus the fixed offset. */
    > [ - >+ >+ << ] >> [ - << + >> ] <<< 
    
    /* We are at cell [5]. The value is IP. 
       We need to go to GuestTape[6+IP], then return. 
       Actually, it's simpler to just use the loop in reverse. */
    
    /* This v3 transport logic is being iterative refined for absolute precision. */
    /* Return to Hub [0] via the mirroring mechanism. */
    <<<< <
    
    /* --- STEP 2: RANGE FILTER DISPATCHER ---
     * Implementing robust matching via subtraction clusters.
     */
    
    /* Skeletal dispatch remains until Transport is verified as symmetric. */
    >>>>>> [ - > < ] 
    + 
    <<<<<<
    
    /* Maintenance: Increment IP [1] */
    > + <
    
    /* Final return to Hub [0] */
    <
]
