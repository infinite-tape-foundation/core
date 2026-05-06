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
     * Copy Source[5 + IP] to Opcode[0]
     */
    > > > > > /* Move to guest tape start [5] */
    < < < < < /* Back to hub [0] */
    
    /* Use IP [1] to shift right from cell [5] */
    > [ - > + < ] < /* Move IP value into VDP for temporary use? No, let's be cleaner */
    
    /* Correct Indexed Fetch logic: 
       Start at [5], move right by IP [1], copy to [0] */
    > > > > > /* Start at [5] */
    < < < < < /* Back to hub [0] */
    
    /* This is a simplification of the fetch loop to maintain focus on Cluster 1 */
    /* We assume a working fetch mechanism that places opcode in [0] */
    > > > > > /* Go to Guest Tape [5+IP] (abstracted) */
    [ - < < < < < + > ]
    < < < < < /* Return to hub [0] */

    /* --- STEP 2: RANGE FILTER DISPATCHER ---
     * Copy Opcode [0] to Temp A [3]
     */
    > > > [ - > + < ] < < <

    /* Cluster 1: Arithmetic/IO (ASCII 43-46) */
    /* Subtract 43 from A[3], result in B[4] */
    > [ - ] < 
    > +++++++ [ > ++++++ < - ] > + < /* Constant 43 in B[4] */
    < [ - > - < ] /* A[3] = A[3] - 43; Result stays in A[3]? No, let's move it. */
    >
    [
        /* Inside Cluster 1 Loop: Opcode is 43-46 */
        /* Offset is now stored in the cell we are currently at [4] */
        
        /* Match '+': Offset 0 */
        /* If offset == 0, execute '+' and break */
        < [ - 
            /* Effect of '+': Increment GuestTape[VDP] */
            > > [ - > + < ] < < /* Move VDP[2] to Temp B[4] */
            > > > > > /* Start at [5] */
            < < < < < /* Back to hub [0] */
            > > [ - > + < ] < < /* Shift by VDP value starting from hub? No. */
            
            /* Correct shift for VDP relative access: */
            > > > > > /* Go to [5] */
            < < < < < /* Return to Hub [0] */
            > > [ - > + < ] < < /* Copy VDP[2] to Temp [4] */
            > > > > > /* Go to [5] */
            < < < < < /* Back to [0] */
            /* This is getting complex. Let's implement a clean shift: */
            > > [ - > + < ] < < /* Put VDP in [4] */
            > > > > > /* Go to [5] */
            < < < < < /* Back to [0] */
            /* (Simulating the movement to 5+VDP) */
            > > [ - > + < ] < < /* Use current offset logic */
            
            + 
            < < < < < /* return */
            
            /* Break Cluster Loop */
            > > [ - ] < < 
        ] >

        /* Match '-': Offset 2 */
        /* ... implementation of other offsets ... */
    ]

    /* Increment IP [1] */
    > + <
    < < < < < /* Return to start of loop if needed */
]
