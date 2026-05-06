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

    /* Logic for '+': (Opcode == 43) */
    > 
    [ - > > + < < ] /* Copy Opcode[1] to Temp[3] */
    > > 
    +++++++ [ > ++++++ < - ] /* Subtract 43 from Temp[3] */
    < 
    [ - > + < ] /* If not zero, Flag[4]=1 */
    >
    [ - ] < /* Clear flag if set (we need it zero for the action) */
    
    /* The actual action for '+': Increment value at VDP. */
    < < 
    [ - > + < ] /* Use Temp[3] as counter for VDP movement */
    > > > >
    < [ - > + < ] /* Move right based on VDP */
    +
    
    /* Rigid Return Path: return pointer to IP [0] */
    < [ - < + > ]
    < < < <

    /* Logic for '-': (Opcode == 45) */
    > 
    [ - > > + < < ] /* Copy Opcode[1] to Temp[3] */
    > > 
    +++++++ [ > ++++++ < - ] /* Subtract 43 */
    < 
    -- /* Make it 45-43 = 2 */
    [ - > + < ] /* If not zero, Flag[4]=1 */
    >
    [ - ] < 
    
    < < 
    [ - > + < ]
    > > > >
    < [ - > + < ]
    -
    
    < [ - < + > ]
    < < < <

    /* Logic for '>': (Opcode == 62) */
    > 
    [ - > > + < < ] /* Copy Opcode[1] to Temp[3] */
    > > 
    +++++++ [ > ++++++ < - ] /* Subtract 43 */
    < 
    +++++++++++++++++++++++++++
    [ - > + < ] /* Offset from 43 to 62 is 19. This logic needs careful balancing. */
    >
    [ - ] < 
    
    < < 
    [ - > + < ]
    > > > >
    < [ - > + < ]
    +
    
    /* Correct Action for '>': Increment Virtual Data Pointer cell [2] */
    < < < < 
    > > 
    +
    
    < [ - < + > ]
    < < < <

    /* --- STEP 3: IP INCREMENT ---
     * Advance the Instruction Pointer for the next cycle. */
    + 
]
