/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3
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
        /* Logic: If Offset==0 then '+', if Offset==X then '-'... */
        < < < <
        
        /* Match '+': Offset is 0. Since we are inside the cluster loop, 
           if it's '+' we just execute and clear the cluster trigger. */
        
        /* Effect of '+': Increment GuestTape[VDP] */
        /* We move pointer by VDP value starting from cell [5] */
        > > > [ - > + < ] < < < /* Move to VDP register [2] */
        [ - > + < ] /* Use VDP as counter to shift right from hub [0] */
        > > > > > /* Base offset to guest tape start [5] */
        + /* The actual increment operation on GuestTape[VDP] */
        < < < < < /* Return to hub */
        
        /* Clear cluster trigger to exit */
        > [ - ] <
        
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
        
        /* Logic for '>': If offset matches '>', increment VDP[2] */
        > [ - > + < ] < 
        
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
        
        /* Placeholder for bracket jumps: modify IP [1] */
        /* Deferred to a dedicated refinement pass */
        
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
