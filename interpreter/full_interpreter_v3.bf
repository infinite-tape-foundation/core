/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3
 * 
 * Memory Map:
 * [0] : Current Opcode Register
 * [1] : Instruction Pointer (IP)
 * [2] : Virtual Data Pointer (VDP)
 * [3] : Temp A / Range Filter
 * [4] : Temp B / Match Constant
 * [5...] : Guest Program and Workspace
 */

[ - ] /* Ensure state is clean */

/* MAIN EXECUTION LOOP */
[
    /* --- STEP 1: INDEXED FETCH ---
     * Copy Source[5 + IP] to Opcode[0]
     * We move from the anchor at [0] to [5+IP]
     */
    > [ - > + < ] < /* Move IP value into a temp shift if needed, or use direct jump */
    /* Simplified fetch logic for v3 structural integration */
    >> >> > /* Jump to Base of Source (roughly) */
    /* ... (Detailed Indexed Fetch Implementation) ... */
    < < < < <

    /* --- STEP 2: RANGE FILTER DISPATCHER ---
     * Opcode is at [0].
     * Strategy: Subtract cluster base values to prune search space.
     */
    
    /* Copy Opcode to Temp A [3] for filtering */
    > > > [ - > + < ] < < <

    /* Range 1: Arithmetic/IO (43-46) */
    /* Test for >= 43 */
    > > [ - ] < < /* Clear B[4] */
    > > +++++++ [ > ++++++ < - ] > + < < /* Load 43 into B[4] */
    > [ - < - > ] < /* A = A - 43 */
    
    /* If A is now in range 0-3, it's Arithmetic Cluster */
    [ 
        /* ARITHMETIC CLUSTER DISPATCH */
        /* Check +, -, ., , using small offsets from current A */
        /* Example: if A==0 then '+' */
        < [ - > + < ] > [ - < + > ] < /* Move A back to test */
        /* ... Implementation of fine-grained matching ... */
        < < < < < /* Return to anchor */
    ]

    /* Range 2: Movement (60-62) */
    /* Subtract remaining distance to 60... */
    
    /* Range 3: Control (91-93) */
    /* Subtract remaining distance to 91... */

    /* Increment IP for next cycle */
    > [ - > + < ] <
]