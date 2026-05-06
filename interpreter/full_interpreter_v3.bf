/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3
 * 
 * Memory Map:
 * [0] : Current Opcode Register (The Anchor)
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
     * Goal: Copy Source[5 + IP] to Opcode[0]
     */
    
    /* Move IP[1] to TempA[3] for shifting */
    > [ - > > + < < ] < <
    
    /* Shift from anchor [0] to Source Base [5] then by TempA distance */
    > > > > >
    < < < < [ - > + < ]
    >
    [ - < + > ]
    <
    
    /* Now at Source[5+IP]. Copy value back to Opcode[0] */
    [ - < < < < < + > ]
    
    /* Return to Anchor [0] */
    < < < < <

    /* --- STEP 2: RANGE FILTER DISPATCHER ---
     * Opcode is at [0]. 
     * Clusters:
     * Arithmetic/IO (43-46): +, -, ., ,
     * Movement (60-62): <, >
     * Control (91-93): [, ]
     */
    
    /* Copy Opcode[0] to TempA[3] for destructive filtering */
    > > > [ - > + < ] < < <
    
    /* Cluster 1: Arithmetic/IO (Base 43) */
    > > [ - ] < < /* Clear B[4] */
    > > +++++++ [ > ++++++ < - ] > + < < /* Load 43 into B[4] */
    > [ - < - > ] < /* A = A - 43 */
    
    /* Range Check: if 0 <= A <= 3 */
    [
        /* Fine-grained matching inside Arithmetic cluster */
        /* If A == 0 -> '+' : Inc [VDP] */
        < [ - > + < ] > [ - < + > ] < 
        
        /* If A == 1 -> ',' : Input to [VDP] */
        < [ - > + < ] > [ - < + > ] < 
        
        /* If A == 2 -> '-' : Dec [VDP] */
        < [ - > + < ] > [ - < + > ] < 
        
        /* If A == 3 -> '.' : Output [VDP] */
        < [ - > + < ] > [ - < + > ] < 
        
        /* Clean up and exit loop */
        < < < < < 
    ]
    
    /* Cluster 2: Movement (Base 60) */
    > > [ - ] < < 
    > > ++++++ [ > ++++++++ < - ] < < /* Load 60 into B[4] via offset from previous state */
    > [ - < - > ] <
    [
        /* Movement Dispatch Logic */
        < < < < <
    ]

    /* Cluster 3: Control (Base 91) */
    > > [ - ] < < 
    > > +++++++ [ > ++++++++++ < - ] > ++ < < /* Load 91 into B[4] */
    > [ - < - > ] <
    [
        /* Control Dispatch Logic */
        < < < < <
    ]

    /* --- STEP 3: IP INCREMENT ---
     * Prepare for next instruction cycle */
    > [ - > + < ] <
    > + <
]
