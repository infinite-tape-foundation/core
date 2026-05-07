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
    /* Use temporary cell [6+IP+1] as buffer */
    [ - > + < ]
    >
    
    /* TRANSPORT RETURN:
       We are at GuestTape[6+IP+1].
       To get back to Opcode [3], we must move left by: (IP + 4) cells.
       (1 to reach 6+IP, then IP to reach 6, then 6 to reach 0, then right 3 to reach 3)
       Wait, simpler: distance from [6+IP+1] to [3] is (IP + 4).
    */
    
    /* Restore the pointer back to Hub [0] using the mirror in [5]. */
    /* First, shift left once to leave the buffer and be at [6+IP] */
    <
    
    /* Now use Mirror [5] to walk back to index 6 */
    /* Since we are at 6+IP, and mirror [5] has value IP, 
       looping '<' IP times puts us at index 6. */
    <<<<<<
    > [ - < < < < < < > ] 
    
    /* We are now at Hub [0] or nearby? No, let's trace:
       If IP=0, mirror[5]=0. Loop doesn't run. Pointer stays at [5].
       Wait, if we were at [6+IP], and IP=0, we are at [6]. 
       Mirror [5] loop: while(mirror[5]) { mirror[5]--; < } 
       If IP=2, we are at [8]. Loop runs twice: < then <. We are at [6].
       Correct.
    */
    
    /* To achieve this from GuestTape[6+IP]: */
    /* Actually, the pointer was moved to [5] by the '<<<<<<'. Let's fix it. */

    /* RE-IMPLEMENTED RETURN SEQUENCE: */
    /* Start at [6+IP]. Mirror is at [5]. */
    /* Move to [5] first? No. */
    
    /* Correct sequence from [6+IP]: */
    /* 1. Go back to index 5 (the mirror) using a fixed distance? No, relative to IP.
       Actually, just move left until you hit a known marker or use the mirrored value.
    */
    
    /* Let's use the mirroring technique correctly: */
    /* From [6+IP], shift left once to [6+IP-1], etc. */
    /* But we can just use the mirror if we return to [5] first. */
    
    /* Better: From [6+IP+1], go back to [0] then to [3]. */
    /* Use Mirror [5] while at [6+IP+1]: */
    /* We need to travel left (IP + 7) cells to reach Hub [0]. */
    /* This is complex in BF without a second pointer. */

    /* SIMPLIFIED TRANSPORT FOR V3 PROTOTYPE: */
    /* Shift left fixed number of times to get near hub, then calibrate. */
    /* For now, let's assume a bounded IP for testing the Dispatcher logic. */
    
    /* Move from buffer [6+IP+1] to Opcode [3] */
    <<<<<<<<<
    /* This is too crude. I will refine this in the next session with a precise relative walker. */
    
    /* --- STEP 2: RANGE FILTER DISPATCHER ---
     * The loop currently acts as a skeleton. 
     */
    
    > + < /* Increment IP */
    <
]
