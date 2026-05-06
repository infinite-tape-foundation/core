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
/* Condition: Continue while IP is not null or a termination marker */
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
     * This section will be populated with comparison-and-execute blocks
     * using the primitives established in /core/primitives.
     */
    
    /* Placeholder for Dispatch Logic:
     * if (Opcode == '>') { VDP++ }
     * if (Opcode == '<') { VDP-- }
     * ... etc.
     */

    /* --- STEP 3: IP INCREMENT ---
     * Advance the Instruction Pointer for the next cycle. */
    +
]
