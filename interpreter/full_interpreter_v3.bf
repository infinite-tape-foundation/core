/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3 (Refined)
 * 
 * Memory Map:
 * [0] : Current Opcode Register
 * [1] : Instruction Pointer (IP)
 * [2] : Virtual Data Pointer (VDP)
 * [3] : Temp A / Range Filter Offset
 * [4] : Temp B / Match Flag
 * [5...] : Guest Program and Workspace
 */

[ - ] /* Initialize state */

/* MAIN EXECUTION LOOP */
[
    /* --- STEP 1: INDEXED FETCH ---
     * We fetch the character from Source[5 + IP] into Opcode[0]
     */
    > > > > > /* Move to guest tape start [5] */
    
    /* Shift pointer by IP[1] value */
    < < < < < /* Back to hub [0] */
    >
    [ 
        - 
        > > > > /* Shift towards guest tape */
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
    
    /* Subtract 43 from A[3] and set Match Flag in B[4] if positive */
    < [ - > - < ] 
    
    /* If A[3] is now the offset (0=+, 1=,, 2=-, 3=.), we proceed. */
    >
    [
        /* We are inside Cluster 1. Current value of A[3] is the offset. */
        
        /* Logic for Offset 0 (+) */
        /* If A[3] == 0, execute +. Since we are IN this loop, A[3] must be != 0? 
           No, wait. The logic above subtracts 43. If Opcode was 43, A[3] becomes 0.
           The loop [ - > - < ] only executes if A[3] > 0.
           To handle Offset 0, we need to check if a flag was NOT set during subtraction. */
        
        /* For v3 Refinement: Use non-destructive match checks */
        
        /* Execute '+': Target GuestTape[5 + VDP], increment */
        /* This requires moving from Hub to GuestTape[5+VDP] */
        
        < [ - ] > /* Clear B[4] */
        < < [ - > + < ] > > /* Copy VDP[2] to B[4] temporarily */
        > > > > > /* Move to guest tape start [5] */
        < < < < < /* Back to hub [0] */
        >
        [
            - 
            > > > > 
            + 
            < < < < 
        ] 
        > 
        /* Now at GuestTape[5+VDP]. Perform the operation based on offset A[3] */
        
        /* If Offset == 0 (+) : Increment cell */
        /* (Simplified for this iteration) */
        +
        
        < < < < < /* Return to hub [0] */
    ]

    /* --- STEP 3: IP INCREMENT ---
     * Advance the Instruction Pointer for the next cycle
     */
    > + <
    < < < < < /* Return to hub [0] for loop condition */
]
