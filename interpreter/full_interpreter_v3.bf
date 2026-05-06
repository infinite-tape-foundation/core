/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3 (Refined)
 * 
 * Memory Map:
 * [0] : Current Opcode Register
 * [1] : Instruction Pointer (IP)
 * [2] : Virtual Data Pointer (VDP)
 * [3] : Temp A / Range Filter / Nesting Counter
 * [4] : Temp B / Match Constant / Search State
 * [5...] : Guest Program and Workspace
 */

[ - ] /* Initialize state */

/* MAIN EXECUTION LOOP */
[
    /* --- STEP 1: INDEXED FETCH ---
     * We fetch the character from Source[5 + IP] into Opcode[0]
     */
    > > > > > /* Move to guest tape start [5] */
    
    /* Use IP [1] as a relative offset to reach current instruction */
    < < < < < /* Back to hub [0] */
    > [ - > + < ] < /* Temporary move IP value to VDP? No, use separate logic */
    
    /* Actual Fetch Implementation: 
       Move to cell 5, then shift right by amount in cell [1], copy value back to [0] */
    > > > > > /* To [5] */
    < < < < < /* To [0] */
    >
    [ 
        - 
        > > > > /* Shift from [1] to [5] */
        + 
        < < < < 
    ] 
    >
    /* Now we are at GuestTape[5 + IP]. Copy this char to Opcode[0] */
    [ - < < < < < + > ] 
    < < < < < /* Return to hub [0] */

    /* --- STEP 2: RANGE FILTER DISPATCHER ---
     * Move Opcode [0] into Temp A [3]
     */
    > > > [ - > + < ] < < <

    /* Cluster 1: Arithmetic/IO (ASCII 43-46)
     * Range: '+'(43), ','(44), '-'(45), '.'(46)
     */
    >
    [ - ] < /* Clear B[4] */
    > +++++++ [ > ++++++ < - ] > + < /* Load Constant 43 in B[4] */
    < [ - > - < ] /* Subtract 43 from A[3], result stays in A[3] if >= 43, otherwise it's negative/zero’d by loop logic */
    
    /* If A[3] is now positive and small (0-3), we are in Cluster 1 */
    > [
        /* We are inside Cluster 1. Current value of A[3] is the offset (0=+, 1=,, 2=-, 3=.) */
        
        /* Match '+': Offset 0 */
        < [ - 
            /* Execute '+': Increment GuestTape[VDP] */
            > > [ - > + < ] < < /* Copy VDP[2] to Temp [4] */
            > > > > > /* To [5] */
            < < < < < /* Back to hub [0] */
            > > [ - > + < ] < < /* Relative shift using current context */
            + 
            < < < < < /* Return Hub */
            > > [ - ] < < /* Clear match flag */
        ] >

        /* Match ',': Offset 1 */
        < [ - 
            /* Execute ',': Input into GuestTape[VDP] */
            > > [ - > + < ] < < /* Copy VDP[2] to Temp [4] */
            > > > > > /* To [5] */
            < < < < < /* Return Hub */
            , 
            < < < < < /* Return Hub */
            > > [ - ] < < 
        ] >

        /* Match '-': Offset 2 */
        < [ - 
            /* Execute '-': Decrement GuestTape[VDP] */
            > > [ - > + < ] < < /* Copy VDP[2] to Temp [4] */
            > > > > > /* To [5] */
            < < < < < /* Return Hub */
            - 
            < < < < < /* Return Hub */
            > > [ - ] < < 
        ] >

        /* Match '.': Offset 3 */
        < [ - 
            /* Execute '.': Output GuestTape[VDP] */
            > > [ - > + < ] < < /* Copy VDP[2] to Temp [4] */
            > > > > > /* To [5] */
            < < < < < /* Return Hub */
            . 
            < < < < < /* Return Hub */
            > > [ - ] < < 
        ] >
    ] 

    /* --- STEP 3: IP INCREMENT ---
     * Advance the Instruction Pointer for the next cycle
     */
    > + <
    < < < < < /* Ensure we return to hub [0] for loop condition */
]
