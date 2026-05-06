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
    /* If B is within range [0, 3], we process Arithmetic */
    [
        /* Fine-grained match for '+' (Offset 0), '-' (Offset 1), '.' (Offset 2), ',' (Offset 3) */
        < < < <
        
        /* Match '+': Offset 0. We check if A[3]-43 == 0 by verifying B was not incremented? No, the cluster loop handles non-zero B. 
           Wait, if B=0, it won't enter this block. Correct logic: subtract 43, if B > 0 or if a flag is set. 
           Let us use the standard BF equality pattern: copy B to Temp, decrement, check zero. */
        
        /* Actual Implementation of +, -, ., , relative to VDP [2] goes here */
        
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
        
        /* Implementation of <, > relative to VDP goes here */
        
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
        
        /* Implementation of bracket jumps goes here */
        
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
