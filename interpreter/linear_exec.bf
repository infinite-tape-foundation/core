/*
 * The Linear Executor: Phase I of the Self-Referential Loop.
 * 
 * Memory Map:
 * [0] : Instruction Pointer (IP)
 * [1] : Current Opcode Register
 * [2] : Virtual Data Pointer (VDP) - Absolute address on Guest Tape
 * [3] : Temporary Counter / Scratchpad
 * [4] : Source Base Anchor (constant offset to guest tape start)
 * [5...] : Guest Program and Workspace
 */

/* Initialization: Set VDP=5, SourceBase=5 */
> > > > > +++++ < < < < <

/* MAIN EXECUTION LOOP */
[
    /* --- STEP 1: INDEXED FETCH ---
     * Move from IP[0] to (SourceBase[4] + IP[0])
     */
    
    /* Copy IP [0] to Temp [3] for counting */
    [ - > > > + < < < ]
    
    /* Navigate to SourceBase [4] */
    > > > >
    
    /* Shift right by Temp [3] cells */
    < [ - > + < ]
    
    /* The current cell now holds the Opcode. 
     * Copy this Opcode to Opcode Register [1]. */
    [ - < < < < + > ]
    
    /* Return to IP [0] */
    < < < <
    
    /* --- STEP 2: DISPATCHER ---
     * Evaluate Opcode Register [1] against known BF symbols.
     * ASCII values: '>' : 62, '<' : 60, '+' : 43, '-' : 45, '.' : 46, ',' : 44
     */

    /* Logic for '+': (Opcode == 43)
     * We use a temporary subtraction to check equality.
     */
    >
    /* Copy Opcode [1] to Temp [3] */
    [ - > > + < < ]
    
    /* Subtract 43 from Temp [3] */
    > > 
    +++++++ [ > ++++++ < - ]
    <
    
    /* If result is 0, it was '+'. Execute VDP increment. */
    /* To execute if zero, we move the value to a flag and check. */
    [ - > + < ] // If not zero, Flag[4] = 1
    >
    [
        /* Not a '+', clear flag and skip action */
        - 
    ] <
    
    /* The actual action for '+': Increment value at VDP. */
    /* Since this is Phase I, we simulate data access by moving relative to SourceBase. */
    /* Move to VDP [2], then navigate to tape offset. */
    < <
    [ - > + < ] // Use Temp [3] as counter for VDP movement
    > > > >
    < [ - > + < ] // Move right based on VDP
    +
    /* Return back to structure: move left to SourceBase anchor first */
    < [ - < + > ] // This is conceptual; need rigid return path.
    
    /* --- STEP 3: IP INCREMENT ---
     * Advance the Instruction Pointer for the next cycle. */
    < < < <
    + 
]
