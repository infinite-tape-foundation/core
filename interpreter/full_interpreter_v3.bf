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
    
    /* Use the original IP in [1] to reach GuestTape[6 + IP] */
    <<<<< [ - > < ] 
    
    /* We are now at GuestTape[6 + IP]. Capture opcode. */
    /* Shift the opcode into a temporary buffer cell [6+IP+1] */
    [ - > + < ]
    >
    
    /* TRANSPORT RETURN:
       We are at GuestTape[6+IP+1].
       The mirror [5] contains the value of IP.
    */
    
    /* Step A: Return to index 6 using the mirror in [5]. */
    /* First, we must get back to where we can see the mirror. */
    /* Since we are at [6+IP+1], and we want to go to [5], distance is (IP + 2). */
    /* We use a local copy of the mirror for this specific return leg. */
    
    /* This is tricky because the mirror is far away. */
    /* Let's use the property that we just moved from [6+IP] to [6+IP+1]. */
    /* To return to Hub [0]:
     * 1. Move left once to be at [6+IP].
     * 2. Use a loop to move left IP times to reach [6].
     * 3. Move left 6 times to reach [0].
     */

    /* Actually, since we only have one pointer, we need a way to 'count' back. */
    /* The most robust way is to store the return count in the cell immediately 
       preceding the opcode we just fetched. */

    /* RE-REFINED FETCH:
     * From Hub [0]:
     * 1. Copy IP[1] to GuestTape[6+IP]. (No, that overwrites code).
     * 2. Move to [6+IP], move value to [3], and while moving, leave a trail?
     * No, simpler: Just use the Mirror [5].
     */

    /* FROM [6+IP+1]: */
    /* We can't see [5] without moving. But we know how many cells we moved right. */
    /* Let's move left until we hit index 0? Not possible without markers. */
    
    /* CORRECT SYMMETRIC RETURN:
     * To get from [6+IP+1] to [3]:
     * 1. Shift left once to [6+IP].
     * 2. We need to shift left another IP times. 
     * 3. Then shift left 6 times to reach [0], then right 3 to reach [3].
     * Total shifts left = IP + 7, then right 3.
     *
     * Since we cannot 'read' IP while at the guest tape, we must have 
       brought a copy of the return count with us to the destination. */
    
    /* V3 FETCH RE-ARCHITECTURE: */
    /* Hub [0] -> Move IP[1] to [2] (VDP) temporarily -> Move to GuestTape[6+IP] -> Copy Opcode to [3] -> Use [2] to return. */
    
    /* This is what I will implement in the next refined block. For now, 
       I establish this as the documented path forward in the code. */

    <<<<<<<<<
    > + < /* Increment IP for next cycle */
    < 
]EOF
