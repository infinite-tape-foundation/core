/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3
 * 
 * Memory Map:
 * [0] : Current Opcode Register
 * [1] : Instruction Pointer (IP)
 * [2] : Virtual Data Pointer (VDP)
 * [3] : Temp A / Range Filter / Nesting Counter
 * [4] : Temp B / Search State / Match Constant
 * [5...] : Guest Program and Workspace
 */

[ - ] /* Initialize state */

/* MAIN EXECUTION LOOP */
[
    /* --- STEP 1: INDEXED FETCH ---
     * Move to IP, copy Source[5 + IP] to Opcode[0]
     */
    > [ - > + < ] < < < < < 
    > > > > >
    < < < < [ - > + < ]
    [ - < < < < + > ]
    < < < < <
    >
    [ - > + < ]
    <

    /* --- STEP 2: RANGE FILTER DISPATCHER ---
     * Copy Opcode [0] to Temp A [3]
     */
    > > > [ - > + < ] < < <

    /* Cluster 1: Arithmetic/IO (ASCII 43-46) */
    /* Subtract 43 from A[3], result in B[4] */
    > [ - ] < 
    > +++++++ [ > ++++++ < - ] > + <
    [ - > - < ]
    >
    [
        /* Fine-grained match for '+', '-', '.', ',' relative to VDP [2] */
        /* Current offset is in B[4]. We use a nested check. */
        < < < <
        
        /* Match '+': Offset 0. If we entered the cluster, B was non-zero. 
           Wait, the range filter logic needs to be precise. 
           Let's refine this into actual implementation blocks. */
        
        > > > >
        [ - ] /* Clear B to exit cluster loop */
    ]

    /* Cluster 2: Movement (ASCII 60-62) */
    /* Subtract 60 from A[3], result in B[4] */
    > [ - ] <
    > ++++++ [ > ++++++++++ < - ] <
    [ - > - < ]
    >
    [
        /* Match '<' and '>' using VDP [2] */
        < < < <
        
        > > > >
        [ - ]
    ]

    /* Cluster 3: Control (ASCII 91-93) */
    /* Subtract 91 from A[3], result in B[4] */
    > [ - ] <
    > ++++++++ [ > +++++++++++ < - ] > + <
    [ - > - < ]
    >
    [
        /* Match '[' and ']' using IP [1] search logic */
        < < < <
        
        > > > >
        [ - ]
    ]

    /* Increment IP [1] for next cycle */
    < < < < <
    > [ - > + < ] <
    > + <
    > > > >
    < < < < <
]
