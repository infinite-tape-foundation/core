/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3 (Draft)
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
    > > > > > 
    < < < < <
    [ - > + < ]
    >
    [ - > + < ]
    <
    >
    [ - > + < ]
    <
    >
    [ - > + < ]
    <
    >
    [ - > + < ]
    <
    
    /* This is a conceptual simplification of the fetch loop for v3 draft */
    /* Real indexed fetch requires shifting based on IP value */

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
        < < < <
        /* Match '+' (offset 0): increment [VDP] */
        /* ... implementation ... */
        > > > >
        [ - ] /* Exit cluster loop */
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
        /* ... implementation ... */
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
        /* ... implementation ... */
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
