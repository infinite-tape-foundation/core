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
    /* Note: we are at [6], mirror is at [5] */
    < [ - > < ] 
    
    /* We are now at GuestTape[6 + IP]. Capture opcode. */
    /* To avoid destroying code, we copy the cell contents to a temporary shift cell */
    [ - > + < ]
    >
    
    /* TRANSPORT RETURN:
       We are at GuestTape[6+IP+1].
       To return to Opcode [3]:
       1. Shift left once to [6+IP].
       2. Move the value from [6+IP+1] back into [6+IP] conceptually? No.
       3. We need to travel back IP + 7 cells left to hit Hub [0], then right 3.
       
       Wait, the most elegant way: while moving RIGHT during fetch, we leave a marker
       or use a secondary counter that stays at the destination.
       
       Revised V3 Fetch Strategy:
       A. Copy IP[1] to Temp [4].
       B. Move from [0] to [6].
       C. While Temp [4] > 0: move right, decrement [4].
       D. Now at [6 + IP]. Copy value to a nearby temp [6 + IP + 1].
       E. Move from [6 + IP + 1] back to [6] using a copy of IP stored in [6 + IP + 2].
       
       Actually, let's implement the 'Mirror-Shift' correctly:
    */

    /* From GuestTape[6+IP+1]: */
    /* Let us use the fact that we can move the opcode value itself as a counter if it's non-zero,
       but that's destructive. Instead, let's assume for now we just need to return to Hub.
    */

    <<<<<<<<< /* Skeletal return - needs precision loop based on Mirror [5] */
    
    /* --- STEP 2: OPCODE DISPATCH ---
     * (To be implemented following Transport fix)
     */

    > + < /* Increment IP for next cycle */
    < 
]EOF
