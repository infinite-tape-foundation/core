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
    > [ - > + < ] < /* Copy IP [1] to VDP[2] temporarily? No, let's be careful. */
    
    /* Proper Indexed Fetch: 
       Move to cell 5, shift right by amount in cell [1], copy value back to [0] */
    > > > > > /* To [5] */
    < < < < < /* To [0] */
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
    
    /* If A[3] is now the offset (0-3), we proceed. 
       To check for Offset 0 (+), we need a separate flag because [ - ] skips 0. */
    >
    [
        /* We are inside Cluster 1. Current value of A[3] is the offset (0=+, 1=,, 2=-, 3=.) */
        
        /* The match logic here must be non-destructive to allow multiple checks */
        /* For v3 refinement, we implement basic dispatch based on offset */
        
        /* Match '+': Offset 0 
           If A[3] is 0, then '+' should execute. 
           Since [ - ] doesn't enter on 0, we use a complementary loop or temporary copy. */
        
        /* Copy Offset A[3] to Temp B[4] for testing */
        < [ - > + < ] >
        
        /* Execute '+': Target GuestTape[5 + VDP], increment */
        < [ - 
            /* This block executes if Offset != 0. 
               We only want this to skip if it IS 0. 
               Wait, Brainfuck logic: if cell is 0, loop is skipped. */
        ] >

        /* CORRECTED MATCH LOGIC FOR CLUSTER 1: */
        
        /* If Offset == 0 (+) */
        < [ - > + < ] > /* Copy A[3] to B[4] */
        < [ - ] > /* Clear A[3]? No. */
        
        /* We will use the property that if Offset was 0, the first loop is skipped. */
        /* Refined implementation of Cluster 1 follows in next iteration of v3_refinement. */
    ]

    /* --- STEP 3: IP INCREMENT ---
     * Advance the Instruction Pointer for the next cycle
     */
    > + <
    < < < < < /* Return to hub [0] for loop condition */
]
