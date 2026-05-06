/*
 * The Linear Executor: Phase I of the Self-Referential Loop.
 * 
 * Memory Map:
 * [0] : Instruction Pointer (IP)
 * [1] : Current Opcode Register
 * [2] : Virtual Data Pointer (VDP) - Relative offset to Guest Tape Start
 * [3] : Temp / Scratchpad A
 * [4] : Temp / Scratchpad B
 * [5...] : Guest Program and Workspace
 */

/* Initialization: Set VDP=0, IP=0 */
[ - ]

/* MAIN EXECUTION LOOP */
/* We execute as long as there is a program present starting at SourceBase [5]. */

[ 
    /* --- STEP 1: INDEXED FETCH ---
     * Goal: Move from IP[0] to (SourceBase[5] + IP[0]) and copy value to Opcode[1]
     */
    
    /* Copy IP [0] to Temp A [3] */
    > > > [ - > + < ] < < <
    
    /* Navigate to SourceBase [5] */
    > > > > >
    
    /* Shift right by Temp A [3] cells */
    < < < < [ - > + < ]
    
    /* Current cell is now the Opcode. Copy it to Opcode Register [1]. */
    [ - < < < < + > ]
    
    /* Return to IP [0] */
    < < < < <
    
    /* --- STEP 2: DISPATCHER ---
     * ASCII values: '>' : 62, '<' : 60, '+' : 43, '-' : 45, '.' : 46, ',' : 44
     */

    /* Logic for '+': (Opcode == 43) */
    > 
    [ - > > + < < ] /* Copy Opcode[1] to Temp A [3] */
    > > 
    +++++++ [ > ++++++ < - ] /* Subtract 43 from Temp A [3] */
    < 
    [ - > + < ] /* If not zero, Flag [4]=1 */
    >
    [ - ] < /* Clear flag if set (we need it zero for the action) */
    
    /* Action for '+': Increment value at GuestTape[VDP] */
    < < 
    [ - > + < ] /* Move VDP[2] into Temp B [4] */
    > > 
    > > > 
    < [ - > + < ] /* Shift by VDP offset starting from SourceBase [5] */
    + 
    
    /* Rigid Return Path: return pointer to IP [0] */
    < < < < < < < <
    > > > > >
    < [ - < + > ]
    < < < <

    /* Logic for '-': (Opcode == 45) */
    > 
    [ - > > + < < ] 
    > > 
    +++++++ [ > ++++++ < - ] 
    < 
    -- 
    [ - > + < ] 
    > 
    [ - ] < 
    
    < < 
    [ - > + < ]
    > > > > > 
    < [ - > + < ]
    - 
    
    < < < < < < < <
    > > > > >
    < [ - < + > ]
    < < < <

    /* Logic for '>': (Opcode == 62) */
    > 
    [ - > > + < < ] 
    > > 
    +++++++ [ > ++++++ < - ] 
    < 
    +++++++++++++++++++++++++++
    [ - > + < ] /* Offset from 43 to 62 is 19 */
    > 
    [ - ] < 
    
    /* Action for '>': Increment Virtual Data Pointer cell [2] */
    < < 
    + 
    
    < < < < < < < <
    > > > > >
    < [ - < + > ]
    < < < <

    /* Logic for '<': (Opcode == 60) */
    > 
    [ - > > + < < ] 
    > > 
    +++++++ [ > ++++++ < - ] 
    < 
    ++++++++++++++++++++++
    [ - > + < ] /* Offset from 43 to 60 is 17 */
    > 
    [ - ] < 
    
    /* Action for '<': Decrement Virtual Data Pointer cell [2] */
    < < 
    - 
    
    < < < < < < < <
    > > > > >
    < [ - < + > ]
    < < < <

    /* Logic for '.': (Opcode == 46) */
    > 
    [ - > > + < < ] 
    > > 
    +++++++ [ > ++++++ < - ] 
    < 
    +++ 
    [ - > + < ] /* Offset from 43 to 46 is 3 */
    > 
    [ - ] < 
    
    /* Action for '.': Output value at GuestTape[VDP] */
    < < 
    [ - > + < ] /* Move VDP[2] into Temp B [4] */
    > > 
    > > > 
    < [ - > + < ] /* Shift by VDP offset starting from SourceBase [5] */
    . 
    
    < < < < < < < <
    > > > > >
    < [ - < + > ]
    < < < <

    /* --- STEP 3: IP INCREMENT ---
     * Advance the Instruction Pointer for the next cycle. */
    + 
]
