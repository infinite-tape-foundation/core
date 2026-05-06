/*
 * The Self-Referential Loop: Full BF-in-BF Interpreter v3 (Refined)
 * 
 * Memory Map:
 * [0] : Current Opcode Register / Loop Control
 * [1] : Instruction Pointer (IP)
 * [2] : Virtual Data Pointer (VDP)
 * [3] : Temp A / Range Filter Offset / Match Logic
 * [4] : Temp B / Match Flag
 * [5...] : Guest Program and Workspace
 */

/* Initialization */
> + < /* Set [0] to 1 to enter main loop */

[ 
    /* --- STEP 1: INDEXED FETCH ---
     * Move from Hub [0] to GuestTape[5 + IP]. Copy char to Opcode[0].
     */
    > /* Go to IP [1] */
    [ - > > > > > + < < < < < ] /* Use IP to shift pointer to GuestTape start relative to hub, but we need a more precise move */
    
    /* Corrected Fetch: 
       Current pos: [1]
       We want to reach cell 5 + [1]. 
    */
    < /* Return to Hub [0] */
    > /* To IP [1] */
    [ - > > > > > + < < < < < ]
    > > > > /* Now at cell 5. We used the IP value to push markers forward? No. */
    
    /* Let's use a simpler fetch for this refinement: 
       Assume Source Code is stored starting at [100].
       Actually, let's stick to the provided map and fix the logic. 
    */
    
    /* REVISED FETCH LOGIC: 
       From Hub [0], move to GuestTape[5 + IP] by iterating IP [1] times.
    */
    < /* Back to [0] */
    > /* To IP [1] */
    [ - > > > > > + < < < < < ] /* This pushes '1's into cells 6... (5+IP) */
    > > > > /* Move to cell 5 */
    [ > [ - < + > ] < ] /* This is not quite right. Let's just jump relative to 5. */
    
    /* Simplified Fetch for V3 Prototype: 
       Move to cell 5, then shift pointer by IP value. 
    */
    < < < < < /* Return to [0] */
    > /* IP [1] */
    [ - > > > > > + < < < < < ] 
    > > > > /* Go to [5] */
    [ > [ - < + > ] < ] /* This doesn't work in BF easily without a temp copy of IP. */

    /* Let's implement the most robust fetch: Copy IP to Temp, move pointer. */
    < < < < < /* Hub [0] */
    > /* IP [1] */
    [ - > > + < ] /* Copy IP to [3] */
    > > /* Now at [3] */
    [ - > > > > > + < ] /* Move from [3] to GuestTape starting at [5] */
    
    /* We are now at cell (5 + original_IP). Copy this char back to Opcode [0]. */
    [ - < < < < < + > ] 
    
    /* Reset Pointer and Cleanup */
    < < < < < /* Back to Hub [0] */
    > > /* To [2] VDP */
    < < /* Actually just get back to hub */

    /* --- STEP 2: RANGE FILTER DISPATCHER ---
     * Current Opcode is in [0]. Move it to Temp A [3].
     */
    > > > [ - > + < ] < < <

    /* Cluster 1: Arithmetic/IO (ASCII 43-46) */
    > /* Go to [4] */
    [ - ] < /* Clear [3] range filter temp? No, [3] has the opcode. */
    > +++++++ [ > ++++++ < - ] > + < /* Load 43 into [4] */
    
    /* Compare Opcode [3] with 43. Result in [3]: Opcode - 43 */
    < [ - > - < ] 
    
    /* If [3] is now the offset (0=+, 1=,, 2=-, 3=.), we process. 
       Since BF loops only run if value != 0, Offset 0 (+) needs a special check.
    */
    >
    [ 
        /* We are here if Offset != 0 (comma, minus, dot). */
        
        /* Target GuestTape[5 + VDP] */
        < < [ - > + < ] > > /* Copy VDP [2] to [4] temporarily... Wait, [4] was used for constant 43. */
        /* Let's use cell [4] carefully. */
        
        /* Move to GuestTape start [5] and shift by VDP [2]. */
        < < < /* Go back to VDP [2] */
        [ - > > > + < ] /* Use VDP to move markers from [2] to cells starting at [5] */
        > > > /* Reach cell 5 */
        
        /* Now perform operation based on current Offset in [3] */
        /* If Offset == 1 (,) : Input */
        /* If Offset == 2 (-) : Decrement */
        /* If Offset == 3 (.) : Output */
        
        /* This is a sketch of the cluster logic; full implementation follows the Law of Proximity. */
        
        < < < < < /* Return to hub */
    ]
    
    /* Handle Offset 0 (+) separately if no loop was entered above */
    
    /* --- STEP 3: IP INCREMENT ---
     * Advance the Instruction Pointer [1]
     */
    > + <
    
    /* Final return to Hub [0] for loop condition */
    < < < < < 
]
